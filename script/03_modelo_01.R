
# ARVORE DE DECISAO BINARIA ----------

# carregar o arquivo rda, como os dados
load(file = "./saida/dados/treino.rda")

# criando o modelo: arvore de decisao
modelo_01 <- rpart::rpart(
  Species ~ . ,
  data = treino
)


# plotando a arvore de decisao
rpart.plot::prp(modelo_01, extra = 1)

# salvando o grafico da arvore de decisao
ggplot2::ggsave("./saida/plots/arvore_decisao.jpg",
       plot = rpart.plot::prp(modelo_01, extra = 1) ,
       # width = 8,
       # height = 8,
       # units = c("in", "cm", "mm"),
       dpi = 300
)


# carregar o arquivo rda, como os dados
load(file = "./saida/dados/teste.rda")


# resultado no dataset de teste
previsao <- stats::predict(modelo_01, teste, type = "class")

# resultado final: estatisticas
caret::confusionMatrix(previsao, teste$Species)


# Salvar a solução para um data frame
solucao_01 <- tibble::tibble(Specie = teste$Species, Previsto = previsao)

# Write the solution to file
write.csv(solucao_01, file = './saida/dados/solucao_01.csv', row.names = F)


#remover variavel da memoria
rm(list = ls())

# FIM

