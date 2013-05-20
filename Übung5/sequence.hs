accumulateIO :: [IO a] -> IO [a]
accumulateIO [] = []
accumulateIO (c:cs)  = do x <- c
						  xs <- accumulateIO cs
						  return(x:xs)



sequenceIO :: [IO a] -> IO ()
sequenceIO [] = return()
sequenceIO (a:as) = do a 
					sequenceIO as

seqList :: [a -> IO a] -> a -> IO a
