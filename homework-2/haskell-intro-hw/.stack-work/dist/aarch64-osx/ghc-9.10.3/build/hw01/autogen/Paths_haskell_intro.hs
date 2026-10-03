{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_haskell_intro (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/chris/cmsc433-1/homework-2/haskell-intro-hw/.stack-work/install/aarch64-osx/813fe8885de2e37876a656b488b2a411e4b56c9b97bebf690cbd99cb2b030c13/9.10.3/bin"
libdir     = "/Users/chris/cmsc433-1/homework-2/haskell-intro-hw/.stack-work/install/aarch64-osx/813fe8885de2e37876a656b488b2a411e4b56c9b97bebf690cbd99cb2b030c13/9.10.3/lib/aarch64-osx-ghc-9.10.3-fe9c/haskell-intro-0.1.0.0-KmDpenk6DFAExQdWH5lu0o-hw01"
dynlibdir  = "/Users/chris/cmsc433-1/homework-2/haskell-intro-hw/.stack-work/install/aarch64-osx/813fe8885de2e37876a656b488b2a411e4b56c9b97bebf690cbd99cb2b030c13/9.10.3/lib/aarch64-osx-ghc-9.10.3-fe9c"
datadir    = "/Users/chris/cmsc433-1/homework-2/haskell-intro-hw/.stack-work/install/aarch64-osx/813fe8885de2e37876a656b488b2a411e4b56c9b97bebf690cbd99cb2b030c13/9.10.3/share/aarch64-osx-ghc-9.10.3-fe9c/haskell-intro-0.1.0.0"
libexecdir = "/Users/chris/cmsc433-1/homework-2/haskell-intro-hw/.stack-work/install/aarch64-osx/813fe8885de2e37876a656b488b2a411e4b56c9b97bebf690cbd99cb2b030c13/9.10.3/libexec/aarch64-osx-ghc-9.10.3-fe9c/haskell-intro-0.1.0.0"
sysconfdir = "/Users/chris/cmsc433-1/homework-2/haskell-intro-hw/.stack-work/install/aarch64-osx/813fe8885de2e37876a656b488b2a411e4b56c9b97bebf690cbd99cb2b030c13/9.10.3/etc"

getBinDir     = catchIO (getEnv "haskell_intro_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "haskell_intro_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "haskell_intro_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "haskell_intro_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskell_intro_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskell_intro_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
