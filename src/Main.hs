import Data.List
import Data.Maybe
import System.Directory
import System.FilePath
import System.Environment

main :: IO ()
main = getArgs >>= prepare . parse >>= main'
    where
        main' p = readFile "ks.hs" >>= writeFile p
            >> getPermissions p >>= setPermissions p . setOwnerExecutable True

prepare :: Maybe FilePath -> IO FilePath
prepare p = getHomeDirectory >>= prepare' . flip fromMaybe p . defpf
    where
        defpf x = x </> ".local" </> "bin"
        prepare' x = (x </> "ks") <$ createDirectoryIfMissing True x 

parse :: [String] -> Maybe FilePath
parse (x : xs)
    | "--prefix=" `isPrefixOf` x = return . drop 1 $ dropWhile (/= '=') x
    | otherwise = parse xs
parse _ = Nothing
