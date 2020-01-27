# RANDOM FOREST  -----------------------

# carregar o arquivo rda, como os dados
load(file = "./saida/dados/treino.rda")


rf_modelO <- randomForest::randomForest(
  factor(Species) ~ . ,
  data = treino
  )


importancia    <- randomForest::importance(rf_modelO)
varImportancia <- tibble::tibble(Variaveis = row.names(importancia),
                            Importancia = round(importancia[,'MeanDecreaseGini'],2))

library(magrittr)
# Create a rank variable based on importance
rankImportancia <- varImportancia %>%
  dplyr::mutate(Rank = paste0('#',
                              dplyr::dense_rank(
                                dplyr::desc(
                                  Importancia
                                  )
                                )
                              )
                )

library(ggplot2)
# Use ggplot2 to visualize the relative importance of variables
ggplot(rankImportancia, aes(x = reorder(Variaveis, Importancia),
                           y = Importancia, fill = Importancia)) +
  geom_bar(stat='identity') +
  geom_text(aes(x = Variaveis, y = 0.5, label = Rank),
            hjust=0, vjust=0.55, size = 4, colour = 'red') +
  labs(x = 'Variables') +
  coord_flip() +
  theme_bw()


# salvando o grafico da arvore de decisao
ggplot2::ggsave("./saida/plots/rank_importancia.jpg",
                plot = ggplot2::last_plot() ,
                # width = 8,
                # height = 8,
                # units = c("in", "cm", "mm"),
                dpi = 300
)



# carregar o arquivo rda, como os dados
load(file = "./saida/dados/teste.rda")


# resultado no dataset de teste
previsao <- predict(rf_modelO, teste, type = "class")

# resultado final: estatisticas
caret::confusionMatrix(previsao, teste$Species)


# Salvar a solução para um data frame
solucao_02 <- tibble::tibble(Specie = teste$Species, Previsto = previsao)

# Write the solution to file
write.csv(solucao_02, file = "./saida/dados/solucao_02.csv", row.names = F)


# remover variavel da memoria
rm(list = ls())

