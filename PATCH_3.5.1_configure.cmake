--- orig/configure.cmake    2022-05-11 00:03:37.000000000 +1000
+++ patched/configure.cmake 2022-07-06 18:54:48.000000000 +1000
@@ -41,6 +41,7 @@
 check_type_size("int" SIZEOF_INT)
 check_type_size("unsigned long" SIZEOF_UNSIGNED_LONG)
 check_type_size("void*" SIZEOF_VOIDP)
+check_type_size("size_t" SIZEOF_SIZE_T)
 
 if (MSVC)
   set(HAVE_VSNPRINTF 1)
@@ -116,6 +117,13 @@
         "
     HAVE_5ARGS_MREMAP)
 
+  check_c_source_compiles(
+    "
+        #include <pthread.h>
+        int main() { pthread_atfork(0,0,0); 0; }
+        "
+    HAVE_PTHREAD_ATFORK)
+
   check_include_file("sys/stat.h" HAVE_SYS_STAT_H)
   if (${CMAKE_SYSTEM} MATCHES "Linux")
       check_include_file("linux/fs.h" HAVE_LINUX_FS_H)
@@ -233,6 +241,27 @@
     set(VSI_FTRUNCATE64 "ftruncate")
   endif ()
 
+  # For some reason, above tests detect xxxx64 symbols for iOS, which are not
+  # available at build time.
+  if (${CMAKE_SYSTEM_NAME} MATCHES "iOS")
+    set(VSI_FOPEN64 "fopen")
+    set(VSI_FTRUNCATE64 "ftruncate")
+    set(VSI_FTELL64 "ftell")
+    set(VSI_FSEEK64 "fseek")
+    set(VSI_STAT64 "stat")
+    set(VSI_STAT64_T "stat")
+    unset(HAVE_FOPEN64)
+    unset(HAVE_FOPEN64 CACHE)
+    unset(HAVE_FTRUNCATE64)
+    unset(HAVE_FTRUNCATE64 CACHE)
+    unset(HAVE_FTELL64)
+    unset(HAVE_FTELL64 CACHE)
+    unset(HAVE_FSEEK64)
+    unset(HAVE_FSEEK64 CACHE)
+    unset(HAVE_STATVFS64)
+    unset(HAVE_STATVFS64 CACHE)
+  endif()
+
   set(UNIX_STDIO_64 TRUE)
 
   set(INCLUDE_XLOCALE_H)
@@ -313,4 +342,4 @@
   set(MACOSX_FRAMEWORK OFF)
 endif ()
 
-# vim: ts=4 sw=4 sts=4 et
+# vim: ts=4 sw=4 sts=4 et
\ No newline at end of file