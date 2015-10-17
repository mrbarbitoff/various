cors = c()
for (exp in dir('./barbitoff/salmon/')){
    sq = read.table(paste0('./barbitoff/salmon/', exp))
    kq = read.table(paste0('./barbitoff/kallisto/', exp), header=T)
    cors = c(cors, cor(sq[, 3], kq[, 5]))
}
names(cors) = dir('./barbitoff/salmon')
print(cors)
