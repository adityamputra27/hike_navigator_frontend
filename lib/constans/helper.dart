bool isVersionGreaterThan(String newVersion, String currentVersion) {
  List<int> v1 = newVersion.split('.').map(int.parse).toList();
  List<int> v2 = currentVersion.split('.').map(int.parse).toList();

  while (v1.length < v2.length) v1.add(0);
  while (v2.length < v1.length) v2.add(0);

  for (int i = 0; i < v1.length; i++) {
    if (v1[i] > v2[i]) {
      return true;
    } else if (v1[i] < v2[i]) {
      return false;
    }
  }
  return false;
}
