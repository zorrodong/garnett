context("test-overall.R")

library(org.Hs.eg.db)
data(test_cds)

set.seed(260)
test_classifier <- train_cell_classifier(cds = test_cds,
                                         marker_file = "../pbmc_test.txt",
                                         db=org.Hs.eg.db,
                                         min_observations = 10,
                                         cds_gene_id_type = "SYMBOL",
                                         num_unknown = 50,
                                         marker_file_gene_id_type = "SYMBOL")

test_cds <- garnett::classify_cells(test_cds, test_classifier,
                                    db = org.Hs.eg.db,
                                    rank_prob_ratio = 1.5,
                                    cluster_extend = TRUE,
                                    cds_gene_id_type = "SYMBOL")

test_that("whole process is the same", {
  expect_equal(sum(pData(test_cds)$cell_type == "B cells"), 202)
  expect_equal(sum(pData(test_cds)$cell_type == "CD4 T cells"), 131)
  expect_equal(sum(pData(test_cds)$cell_type == "CD8 T cells"), 65)
  expect_equal(sum(pData(test_cds)$cell_type == "T cells"), 155)
  expect_equal(sum(pData(test_cds)$cluster_ext_type == "B cells"), 401)
  expect_equal(sum(pData(test_cds)$cluster_ext_type == "CD4 T cells"), 200)
  expect_equal(sum(pData(test_cds)$cluster_ext_type == "T cells"), 199)
})


pd <- new("AnnotatedDataFrame", data = pData(test_cds))
fd <- new("AnnotatedDataFrame", data = fData(test_cds))
test_cds <- newCellDataSet(as.matrix(exprs(test_cds)),
                           phenoData = pd,
                           featureData = fd)
test_cds <- estimateSizeFactors(test_cds)


set.seed(260)
test_classifier <- train_cell_classifier(cds = test_cds,
                                         marker_file = "../pbmc_test.txt",
                                         db=org.Hs.eg.db,
                                         min_observations = 10,
                                         cds_gene_id_type = "SYMBOL",
                                         num_unknown = 50,
                                         marker_file_gene_id_type = "SYMBOL")

test_cds <- garnett::classify_cells(test_cds, test_classifier,
                                    db = org.Hs.eg.db,
                                    rank_prob_ratio = 1.5,
                                    cluster_extend = TRUE,
                                    cds_gene_id_type = "SYMBOL")

test_that("whole process is the same matrix", {
  expect_equal(sum(pData(test_cds)$cell_type == "B cells"), 202)
  expect_equal(sum(pData(test_cds)$cell_type == "CD4 T cells"), 131)
  expect_equal(sum(pData(test_cds)$cell_type == "CD8 T cells"), 65)
  expect_equal(sum(pData(test_cds)$cell_type == "T cells"), 155)
  expect_equal(sum(pData(test_cds)$cluster_ext_type == "B cells"), 401)
  expect_equal(sum(pData(test_cds)$cluster_ext_type == "CD4 T cells"), 200)
  expect_equal(sum(pData(test_cds)$cluster_ext_type == "T cells"), 199)
  expect_is(exprs(test_cds), "matrix")
})

data(test_cds)
set.seed(260)
test_classifier <- train_cell_classifier(cds = test_cds,
                                         marker_file = "../pbmc_test.txt",
                                         db=org.Hs.eg.db,
                                         min_observations = 10,
                                         cds_gene_id_type = "SYMBOL",
                                         num_unknown = 50,
                                         cores = 2,
                                         marker_file_gene_id_type = "SYMBOL")

test_cds <- garnett::classify_cells(test_cds, test_classifier,
                                    db = org.Hs.eg.db,
                                    rank_prob_ratio = 1.5,
                                    cluster_extend = TRUE,
                                    cds_gene_id_type = "SYMBOL")

test_that("whole process is the same multi-core", {
  expect_equal(sum(pData(test_cds)$cell_type == "B cells"), 202)
  expect_equal(sum(pData(test_cds)$cell_type == "CD4 T cells"), 131)
  expect_equal(sum(pData(test_cds)$cell_type == "CD8 T cells"), 65)
  expect_equal(sum(pData(test_cds)$cell_type == "T cells"), 155)
  expect_equal(sum(pData(test_cds)$cluster_ext_type == "B cells"), 401)
  expect_equal(sum(pData(test_cds)$cluster_ext_type == "CD4 T cells"), 200)
  expect_equal(sum(pData(test_cds)$cluster_ext_type == "T cells"), 199)
})

