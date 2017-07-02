
## enviroment
- Windows7
- 64bit OS
- Anaconda4.2
- python3.5
- Git
- 7Zip

## install VS 2015 Community for c/c++ build
- https://www.visualstudio.com/ja/downloads/
- must choose Programming language Cpp


## install mecab for compiled IPA dictionary
http://taku910.github.io/mecab/#download

- install mecab by installer for dictionary
- dictionary char code utf-8
- add bin dir to path

### edit mecab.h
- add set_result member
- when edit the sorce code, turn off administrator authentication

```sdk/mecab.h.patch
--- C:/Program Files (x86)/MeCab/sdk/mecab.h.bak	Mon Jan 21 17:02:08 2013
+++ C:/Program Files (x86)/MeCab/sdk/mecab.h	Tue Jan 24 15:41:25 2017
@@ -777,6 +777,7 @@
  */
 class MECAB_DLL_CLASS_EXTERN Lattice {
 public:
+  virtual void set_result(const char *str) = 0;
   /**
    * Clear all internal lattice data.
    */
```

## source code
### donwload
- donwload mecab-0.996.tar.gz and ungzip

### edit Makefile and source code 
mecab-0.996/src

- copy Makefile.msvc.in to Makefile.msvc
  - X86 to X64
  - @DIC_VERSION to 102
  - @VERSION@ to 0.996
- feature_index.cpp
- writer.cpp
  - size_t to unsigned int

```Makefile.msvc.patch
--- C:/Users/xxx/Downloads/mecab-0.996/src/Makefile.msvc.in	Sun Sep 30 01:44:26 2012
+++ C:/Users/xxx/Downloads/mecab-0.996/src/Makefile.msvc	Tue Jan 24 12:55:46 2017
@@ -3,10 +3,10 @@
 LINK=link.exe
 
 CFLAGS = /EHsc /O2 /GL /GA /Ob2 /nologo /W3 /MT /Zi /wd4800 /wd4305 /wd4244
-LDFLAGS = /nologo /OPT:REF /OPT:ICF /LTCG /NXCOMPAT /DYNAMICBASE /MACHINE:X86 ADVAPI32.LIB
+LDFLAGS = /nologo /OPT:REF /OPT:ICF /LTCG /NXCOMPAT /DYNAMICBASE /MACHINE:X64 ADVAPI32.LIB
 DEFS =  -D_CRT_SECURE_NO_DEPRECATE -DMECAB_USE_THREAD \
-        -DDLL_EXPORT -DHAVE_GETENV -DHAVE_WINDOWS_H -DDIC_VERSION=@DIC_VERSION@ \
-        -DVERSION="\"@VERSION@\"" -DPACKAGE="\"mecab\"" \
+        -DDLL_EXPORT -DHAVE_GETENV -DHAVE_WINDOWS_H -DDIC_VERSION=102 \
+        -DVERSION="\"0.996\"" -DPACKAGE="\"mecab\"" \
         -DUNICODE -D_UNICODE \
         -DMECAB_DEFAULT_RC="\"c:\\Program Files\\mecab\\etc\\mecabrc\""
 INC = -I. -I..
```

```feature_index.cpp.patch
--- C:/Users/xxx/Downloads/mecab-0.996/src/feature_index.cpp	Mon Jan 16 16:30:05 2017
+++ C:/Users/xxx/Downloads/mecab-0.996/src/feature_index.cpp.bak	Sun Nov 25 14:35:32 2012
@@ -353,7 +353,7 @@
               if (!r) goto NEXT;
               os_ << r;
             } break;
-            case 't':  os_ << (unsigned int)path->rnode->char_type;     break;
+            case 't':  os_ << (size_t)path->rnode->char_type;     break;
             case 'u':  os_ << ufeature; break;
             case 'w':
               if (path->rnode->stat == MECAB_NOR_NODE) {
```

```writer.cpp.patch
--- C:/Users/xxx/Downloads/mecab-0.996/src/writer.cpp	Mon Jan 16 16:31:10 2017
+++ C:/Users/xxx/Downloads/mecab-0.996/src/writer.cpp.bak	Mon Jan 16 16:30:56 2017
@@ -257,7 +257,7 @@
             // input sentence
           case 'S': os->write(lattice->sentence(), lattice->size()); break;
             // sentence length
-        	case 'L': *os << (unsigned int)lattice->size(); break;
+          case 'L': *os << lattice->size(); break;
             // morph
           case 'm': os->write(node->surface, node->length); break;
           case 'M': os->write(reinterpret_cast<const char *>
```


## build exe, dll, lib
### run Open Visual Studio 2015 x64 Native Tools Command Prompt
- same as `call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64`
- add to path, add variable, etc.

```diff-path.txt
C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow
C:\Program Files (x86)\MSBuild\14.0\bin\amd64
C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\BIN\amd64
C:\Windows\Microsoft.NET\Framework64\v4.0.30319
C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\VCPackages
C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE
C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools
C:\Program Files (x86)\HTML Help Workshop
C:\Program Files (x86)\Microsoft Visual Studio 14.0\Team Tools\Performance Tools\x64
C:\Program Files (x86)\Microsoft Visual Studio 14.0\Team Tools\Performance Tools
C:\Program Files (x86)\Windows Kits\8.1\bin\x64
C:\Program Files (x86)\Windows Kits\8.1\bin\x86
C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\x64\
```

```diff-set-command-result.log
CommandPromptType=Native
Framework40Version=v4.0
FrameworkDir=C:\Windows\Microsoft.NET\Framework64
FrameworkDIR64=C:\Windows\Microsoft.NET\Framework64
FrameworkVersion=v4.0.30319
FrameworkVersion64=v4.0.30319
INCLUDE=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\INCLUDE;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\ATLMFC\INCLUDE;C:\Program Files (x86)\Windows Kits\10\include\10.0.10240.0\ucrt;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\include\um;C:\Program Files (x86)\Windows Kits\8.1\include\\shared;C:\Program Files (x86)\Windows Kits\8.1\include\\um;C:\Program Files (x86)\Windows Kits\8.1\include\\winrt;
LIB=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\LIB\amd64;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\ATLMFC\LIB\amd64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.10240.0\ucrt\x64;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\lib\um\x64;C:\Program Files (x86)\Windows Kits\8.1\lib\winv6.3\um\x64;
LIBPATH=C:\Windows\Microsoft.NET\Framework64\v4.0.30319;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\LIB\amd64;C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\ATLMFC\LIB\amd64;C:\Program Files (x86)\Windows Kits\8.1\References\CommonConfiguration\Neutral;\Microsoft.VCLibs\14.0\References\CommonConfiguration\neutral;
NETFXSDKDir=C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\
Platform=X64
UCRTVersion=10.0.10240.0
UniversalCRTSdkDir=C:\Program Files (x86)\Windows Kits\10\
VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\
VisualStudioVersion=14.0
WindowsLibPath=C:\Program Files (x86)\Windows Kits\8.1\References\CommonConfiguration\Neutral
WindowsSdkDir=C:\Program Files (x86)\Windows Kits\8.1\
WindowsSDKLibVersion=winv6.3\
WindowsSDKVersion=\
WindowsSDK_ExecutablePath_x64=C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\x64\
WindowsSDK_ExecutablePath_x86=C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\
```

### make
- cd mecab-0.996/src
- run make.bat (`make`)
  - `nmake -f Makefile.msvc`
- if failed, run `nmake -f Makefile.msvc clean`

### copy oututs
- to mecab/bin
  - libmecab.dll
  - mecab.exe
  - mecab-cost-train.exe
  - mecab-dict-gen.exe
  - mecab-dict-index.exe
  - mecab-system-eval.exe
  - mecab-test-gen.exe
- to mecab/sdk
  - libmecab.lib
  - mecab.h

## python-mecab
- `git clone https://github.com/SamuraiT/mecab-python3`
  - Commit hash:	9411d509f34d3a0494b9a5c241566c99014ec063
- edit setup.py
- `pip install --no-cache-dir -e .`

```setup.py.patch
--- C:/Users/xxx/AppData/Local/Temp/h80KN9_setup.py	Tue Jan 24 14:08:23 2017
+++ C:/Users/xxx/tools/mecab-python3/setup.py	Tue Jan 24 14:08:53 2017
@@ -38,9 +38,9 @@
     ext_modules = [
         Extension("_MeCab",
         ["MeCab_wrap.cxx",],
-        include_dirs=cmd2("mecab-config --inc-dir"),
-        library_dirs=cmd2("mecab-config --libs-only-L"),
-        libraries=cmd2("mecab-config --libs-only-l"))
+        include_dirs=[r"C:\Program Files (x86)\MeCab\sdk"],
+        library_dirs=[r"C:\Program Files (x86)\MeCab\sdk"],
+        libraries=["libmecab"])
     ],
     classifiers = [
         "Programming Language :: Python",
```

## references
- http://pop365.cocolog-nifty.com/blog/2015/03/windows-64bit-m.html
- https://gist.github.com/ksomemo/6c834b5ed96aaf410c9b4a1b4fb50f41
