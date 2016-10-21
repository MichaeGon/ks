import System.Directory
import System.FilePath

main :: IO ()
main = prepare >>= main'
    where
        main' p = readFile "ks.hs" >>= writeFile p
            >> getPermissions p >>= setPermissions p . setOwnerExecutable True

prepare :: IO FilePath
prepare = getHomeDirectory >>= prepare'
    where
        prepare' p = (dstdir </> "ks") <$ createDirectoryIfMissing True dstdir
            where
                dstdir = p </> ".local" </> "bin"
