class GtfsResourceInfo {
  final String url;
  final String resourceId;
  final String? etag;
  final String? lastModified;

  const GtfsResourceInfo({
    required this.url,
    required this.resourceId,
    this.etag,
    this.lastModified,
  });
}
