
# OBTENDO OS DADOS    -------------------------

# aqui tem todos os codigos para se obter dados

# base de dados do R: iris (flowers)
raw <- datasets::iris


# salvar como arquivo rda
save(raw, file = "./dados/raw.rda")

#remover variavel da memoria
rm(raw)
