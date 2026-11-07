package com.example.bus_ticket_register

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Typeface
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import com.cloudpos.POSTerminal
import com.cloudpos.printer.PrinterDevice

class MainActivity : FlutterActivity() {

    private val CHANNEL = "cloudpos/printer"
    private val PRINT_WIDTH = 384

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                when (call.method) {

                    "printReceipt" -> {
                        try {
                            val shop = call.argument<String>("shop") ?: ""
                            val shopaddress = call.argument<String>("shopaddress") ?: ""
                            val shopaddress2 = call.argument<String>("shopaddress2") ?: ""
                            val phone = call.argument<String>("phone") ?: ""
                            val website = call.argument<String>("website") ?: ""
                            val bill = safeInt(call.argument<Any>("bill"))
                            val billdate = call.argument<String>("billdate") ?: ""
                            val mode = call.argument<String>("mode") ?: ""
                            val total = call.argument<String>("total") ?: ""
                            @Suppress("UNCHECKED_CAST")
                            val items = call.argument<List<Map<String, Any>>>("items") ?: listOf()
                            val logo = call.argument<ByteArray>("logo")

                            printReceipt(
                                shop, shopaddress, shopaddress2, phone, website,
                                bill, billdate, mode, total, items, logo
                            )

                            result.success("Printed")
                        } catch (e: Exception) {
                            result.error("PRINT_ERROR", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }

    private fun safeInt(value: Any?): Int {
        return when (value) {
            is Int -> value
            is Long -> value.toInt()
            is Double -> value.toInt()
            is String -> value.toIntOrNull() ?: 0
            else -> 0
        }
    }

    data class ReceiptLine(val text: String, val align: String = "left", val bold: Boolean = false)

    private fun printReceipt(
        shop: String,
        address: String,
        address2: String,
        phone: String,
        website: String,
        bill: Int,
        billdate: String,
        mode: String,
        total: String,
        items: List<Map<String, Any>>,
        logo: ByteArray?,
    ) {
        try {
            val printer = POSTerminal.getInstance(this)
                .getDevice("cloudpos.device.printer") as PrinterDevice
            printer.open()

            val lines = mutableListOf<ReceiptLine>()

            // Bus name
            if (shop.isNotEmpty()) {
                lines.add(ReceiptLine(shop, "center", bold = true))
            }

            // Date and bus number
            lines.add(ReceiptLine("$billdate     $website", "left"))

            lines.add(ReceiptLine("--------------------------------", "center"))

            // Boarding and destination
            lines.add(ReceiptLine("Boarding       : $address", "left"))
            lines.add(ReceiptLine("Destination    : $address2", "left"))

            // Time
            lines.add(ReceiptLine("Time           : $phone", "left"))

            lines.add(ReceiptLine("--------------------------------", "center"))

            // Full ticket
            lines.add(ReceiptLine("Full Ticket", "left", bold = true))
            lines.add(ReceiptLine("$mode x ₹$total", "left"))

            // Total
            lines.add(ReceiptLine("Total: ₹$total", "right", bold = true))

            lines.add(ReceiptLine(""))
            lines.add(ReceiptLine("Thank you", "center", bold = true))
            lines.add(ReceiptLine(""))


            val logoBitmap = logo?.let { BitmapFactory.decodeByteArray(it, 0, it.size) }

            val bitmap = renderReceiptToBitmap(lines, logoBitmap)
            printer.printBitmap(bitmap)
            printer.close()

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun renderReceiptToBitmap(
        lines: List<ReceiptLine>,
        logo: Bitmap?,
    ): Bitmap {
        val textSize = 28f
        val lineSpacing = 10f
        val padding = 16

        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = Color.BLACK
            this.textSize = textSize
            typeface = Typeface.DEFAULT
        }

        val fm = paint.fontMetrics
        val lineHeight = (fm.descent - fm.ascent + lineSpacing).toInt()
        val maxWidth = PRINT_WIDTH - (padding * 2)

        // Scale the logo to a sensible width, preserving aspect ratio
        var scaledLogo: Bitmap? = null
        var logoHeight = 0
        if (logo != null) {
            val logoWidth = (PRINT_WIDTH * 0.6f).toInt()
            val scale = logoWidth.toFloat() / logo.width
            logoHeight = (logo.height * scale).toInt()
            scaledLogo = Bitmap.createScaledBitmap(logo, logoWidth, logoHeight, true)
        }
        val logoGap = if (scaledLogo != null) 12 else 0

        val preparedLines = mutableListOf<ReceiptLine>()

        for (line in lines) {
            paint.typeface = if (line.bold) Typeface.DEFAULT_BOLD else Typeface.DEFAULT
            if (line.text.isBlank()) {
                preparedLines.add(ReceiptLine("", line.align, line.bold))
                continue
            }
            var currentLine = ""
            line.text.split(" ").forEach { word ->
                val testLine = if (currentLine.isEmpty()) word else "$currentLine $word"
                if (paint.measureText(testLine) <= maxWidth) {
                    currentLine = testLine
                } else {
                    if (currentLine.isNotEmpty()) preparedLines.add(ReceiptLine(currentLine, line.align, line.bold))
                    currentLine = word
                }
            }
            if (currentLine.isNotEmpty()) preparedLines.add(ReceiptLine(currentLine, line.align, line.bold))
        }

        val totalHeight = logoHeight + logoGap + (preparedLines.size * lineHeight) + (padding * 2)
        val bitmap = Bitmap.createBitmap(PRINT_WIDTH, totalHeight, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        canvas.drawColor(Color.WHITE)

        var y = padding.toFloat()

        if (scaledLogo != null) {
            val x = (PRINT_WIDTH - scaledLogo.width) / 2f
            canvas.drawBitmap(scaledLogo, x, y, null)
            y += logoHeight + logoGap
        }

        y -= fm.ascent

        for (line in preparedLines) {
            paint.typeface = if (line.bold) Typeface.DEFAULT_BOLD else Typeface.DEFAULT
            paint.textAlign = when (line.align) {
                "center" -> Paint.Align.CENTER
                "right"  -> Paint.Align.RIGHT
                else     -> Paint.Align.LEFT
            }
            val x = when (line.align) {
                "center" -> PRINT_WIDTH / 2f
                "right"  -> (PRINT_WIDTH - padding).toFloat()
                else     -> padding.toFloat()
            }
            canvas.drawText(line.text, x, y, paint)
            y += lineHeight
        }

        return bitmap
    }
}
