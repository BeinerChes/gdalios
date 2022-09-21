--- a/CMakeLists.txt
+++ b/PATCH_LIBTIFF_2.cmake
@@ -135,9 +135,8 @@ include(Release)
 # Process subdirectories
 add_subdirectory(port)
 add_subdirectory(libtiff)
-add_subdirectory(tools)
-add_subdirectory(test)
-add_subdirectory(contrib)
+
+
 add_subdirectory(build)
 add_subdirectory(man)
 add_subdirectory(html)
 +