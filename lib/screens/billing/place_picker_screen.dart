import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Full-screen place list with search. Pops with the selected place name.
class PlacePickerScreen extends StatefulWidget {
  const PlacePickerScreen({
    super.key,
    required this.title,
    required this.places,
    this.selected,
    this.excluded,
  });

  final String title;
  final List<String> places;
  final String? selected;

  /// A place that must not be selectable (e.g. the From place when picking To).
  final String? excluded;

  @override
  State<PlacePickerScreen> createState() => _PlacePickerScreenState();
}

class _PlacePickerScreenState extends State<PlacePickerScreen> {
  static const Color _navy = Color(0xFF0B2A5B);
  static const Color _blue = Color(0xFF1E5AA8);
  static const Color _bg = Color(0xFFF4F7FC);

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  String _query = '';

  late final List<String> _all;

  @override
  void initState() {
    super.initState();
    final excluded = widget.excluded?.trim().toLowerCase();
    _all = widget.places
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && e.toLowerCase() != excluded)
        .toSet()
        .toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  List<String> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _all;
    // Names that start with the query come first, then names containing it.
    final starts = _all.where((p) => p.toLowerCase().startsWith(q));
    final contains = _all.where(
        (p) => !p.toLowerCase().startsWith(q) && p.toLowerCase().contains(q));
    return [...starts, ...contains];
  }

  Widget _buildSearchBar() {
    return Container(
      color: _navy,
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 16.h),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocus,
        textInputAction: TextInputAction.search,
        onChanged: (v) => setState(() => _query = v),
        style: TextStyle(fontSize: 15.sp, color: _navy),
        decoration: InputDecoration(
          hintText: 'Search place',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: const Icon(Icons.search_rounded, color: _blue),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.close_rounded, color: Colors.grey.shade600),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _query = '');
                  },
                ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_off_rounded,
              size: 48.w, color: Colors.grey.shade400),
          SizedBox(height: 10.h),
          Text(
            _all.isEmpty ? 'No places available' : 'No matching place found',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _navy,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: _navy,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: items.isEmpty
                ? _buildEmpty()
                : ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w, vertical: 14.h),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final place = items[index];
                      final isSelected = place.toLowerCase() ==
                          (widget.selected ?? '').trim().toLowerCase();
                      return InkWell(
                        borderRadius: BorderRadius.circular(14.r),
                        onTap: () => Navigator.pop(context, place),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 14.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? _blue.withValues(alpha: 0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: isSelected
                                  ? _blue
                                  : Colors.grey.shade200,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 36.w,
                                width: 36.w,
                                decoration: BoxDecoration(
                                  color: _blue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(Icons.location_on_rounded,
                                    color: _blue, size: 20.w),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  place,
                                  style: TextStyle(
                                    color: _navy,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check_circle_rounded,
                                    color: _blue),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}