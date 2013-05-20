
repeatIO :: IO Bool -> IO () -> IO ()
repeatIO test oper = do
				 x <- test
						if x==False then do return ()
								else do oper
										repeatIO test oper
