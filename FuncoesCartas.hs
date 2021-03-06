module FunCartas where
import System.Random

data Cartas = A | Dois | Tres | Quatro | Cinco | Seis | Sete | Oito | Nove | Dez | J | Q | K deriving (Show, Enum, Bounded, Read)

-- Entrega cartas do dealer. Até o valor ser 17 ou superior.
entregarCartasDealer :: StdGen -> Int -> [Cartas]
entregarCartasDealer gen total
  |total < 11 && randomNum == 1 = toEnum(randomNum - 1) : entregarCartasDealer novoGen (total + randomNum + 10)
  |total < 17 = toEnum (randomNum - 1) : entregarCartasDealer novoGen (total + randomNum)
  |otherwise = []
  where (randomNum, novoGen) = randomR(1,13) gen :: (Int, StdGen)

-- Entrega cartas até jogador parar
iniciarCartasJogador :: StdGen -> Int -> [Cartas]
iniciarCartasJogador gen parar
  |parar /= 0 = toEnum(randomNum - 1) : iniciarCartasJogador novoGen (parar - 1)
  |otherwise = []
  where (randomNum, novoGen) = randomR(1,13) gen :: (Int, StdGen)

-- Entrega uma carta para quem chamar
entregarCartaJogador :: StdGen -> [Cartas]
entregarCartaJogador gen = [toEnum (randomNum - 1)]
  where (randomNum, novoGen) = randomR(1,13) gen :: (Int, StdGen)

-- recebe um vetor de cartas e retorna um vetor de inteiros contendo os valores
-- dessas cartas
valorDaMao :: [Cartas] -> [Int]
valorDaMao [] = []
valorDaMao (c:cx)
  | fromEnum c >= 10 = fromEnum 10 : valorDaMao cx
  | otherwise = (fromEnum (c) + 1) : valorDaMao cx

-- mostra as cartas do dealer para o usuário
mostrarCarta :: [Cartas] -> String
mostrarCarta [] = ""
mostrarCarta (c:cs)
  | fromEnum c < 10 && fromEnum c > 0 = show (fromEnum (c) + 1) ++ ", " ++ mostrarCarta cs
  | otherwise = show c ++ ", " ++ mostrarCarta cs

-- mapeia os valores das cartas (J = 11, K = 13)
mostrarMao :: [Cartas] -> [Int]
mostrarMao [] = []
mostrarMao (c:cx) = (fromEnum (c) + 1) : mostrarMao cx

-- converte os valores dos inteiros para Cartas (11 =  J, 13 = K)
converterIteiros :: [Int] -> [Cartas]
converterIteiros [] = []
converterIteiros (x:xs) = toEnum (x - 1) : converterIteiros xs

-- soma os valores das cartas que estao em um vetor de inteiros, se o 'A' estiver nesse vetor e
-- a soma total for menor que 12, entao o 'A' valera 11
somaCartas :: [Int] -> Int
somaCartas cartas
  | sum cartas < 12 && 1 `elem` cartas = sum (cartas) + 10
  | otherwise = sum cartas
