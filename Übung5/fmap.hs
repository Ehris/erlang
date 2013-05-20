
fmapIO :: (a -> b) -> IO a -> IO b

fmapIO f a = do  
         result <- a
         return (f result)      
         
fmapIO' :: (a -> b) -> IO a -> IO b
fmapIO' f a =  a >>= (\x -> return(f x))
