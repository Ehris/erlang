takeWhileIO :: (a -> Bool) -> IO a -> IO [a]
takeWhileIO pred oper = do    
    oper_ <- oper
    let val = pred oper_
    if val == True then
        do
            res <- takeWhileIO pred oper_
            return (oper_:res) 
    else
            return []
