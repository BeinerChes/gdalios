--- a/CMakeLists.txt
+++ b/PATCH_LIBTIFF_1.cmake
@@ -217,12 +217,4 @@ if(CXX_SUPPORT)
 
 endif()
 
-add_executable(mkg3states ../placeholder.h)
-target_sources(mkg3states PRIVATE mkg3states.c tif_fax3.h)
-target_link_libraries(mkg3states tiff port)
-
-add_custom_target(faxtable
-        DEPENDS mkg3states
-        COMMAND ${CMAKE_COMMAND} -E rm "tif_fax3sm.c"
-        COMMAND mkg3states -b -c const "tif_fax3sm.c"
-        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
+
