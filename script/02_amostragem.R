#  PRE-PROCESSAMENTO DOS DADOS

# treino 70%
# raw %>% nrow() * 0.70

# carregar o arquivo rda, como os dados
load(file = "./dados/raw.rda")

# plantando a semente
set.seed(123)

# criando amostragem
amostra <- sample(
  1:nrow(raw),
  nrow(raw) * (0.7)
)

# criando a serie de treino
treino <- raw[amostra, ]

# criando a serie de teste
teste <- raw[-amostra, ]


# salvar como arquivo rda
save(treino, file = "./saida/dados/treino.rda")
# salvar como arquivo rda
save(teste, file = "./saida/dados/teste.rda")

#remover variavel da memoria
rm(amostra, treino, teste, raw)
