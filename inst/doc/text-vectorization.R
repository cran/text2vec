## ---- loading-data, eval=TRUE--------------------------------------------
library(text2vec)
data("movie_review")
set.seed(42L)

## ---- vocab-iterator, eval=TRUE------------------------------------------
it <- itoken(movie_review[['review']], preprocess_function = tolower, 
             tokenizer = word_tokenizer, chunks_number = 10, progessbar = F)
# using unigrams here
t1 <- Sys.time()
vocab <- vocabulary(src = it, ngram = c(1L, 1L))
print( difftime( Sys.time(), t1, units = 'sec'))

## ---- vocab_dtm_1, eval=TRUE---------------------------------------------
it <- itoken(movie_review[['review']], preprocess_function = tolower, 
             tokenizer = word_tokenizer, chunks_number = 10, progessbar = F)
corpus <- create_vocab_corpus(it, vocabulary = vocab)
dtm <- get_dtm(corpus)

## ---- vocab_dtm_1_dim, eval=TRUE-----------------------------------------
dim(dtm)

## ---- fit_1, message=FALSE, warning=FALSE, eval=TRUE---------------------
library(glmnet)
t1 <- Sys.time()
fit <- cv.glmnet(x = dtm, y = movie_review[['sentiment']], 
                 family = 'binomial', 
                 # lasso penalty
                 alpha = 1,
                 # interested area unded ROC curve
                 type.measure = "auc",
                 # 5-fold cross-validation
                 nfolds = 5,
                 # high value, less accurate, but faster training
                 thresh = 1e-3,
                 # again lower number iterations for faster training
                 # in this vignette
                 maxit = 1e3)
print( difftime( Sys.time(), t1, units = 'sec'))
plot(fit)
print (paste("max AUC = ", round(max(fit$cvm), 4)))

## ---- prune_vocab_dtm_1--------------------------------------------------
# remove very common and uncommon words
pruned_vocab <- prune_vocabulary(vocab, term_count_min = 10,
 doc_proportion_max = 0.5, doc_proportion_min = 0.001)

it <- itoken(movie_review[['review']], preprocess_function = tolower, 
             tokenizer = word_tokenizer, chunks_number = 10, progessbar = F)
corpus <- create_vocab_corpus(it, vocabulary = pruned_vocab)
dtm <- get_dtm(corpus)

## ---- tfidf_dtm_1--------------------------------------------------------
dtm <- dtm %>% tfidf_transformer
dim(dtm)

## ---- fit_2, message=FALSE, warning=FALSE, eval=TRUE---------------------
t1 <- Sys.time()
fit <- cv.glmnet(x = dtm, y = movie_review[['sentiment']], 
                 family = 'binomial', 
                 # lasso penalty
                 alpha = 1,
                 # interested area unded ROC curve
                 type.measure = "auc",
                 # 5-fold cross-validation
                 nfolds = 5,
                 # high value, less accurate, but faster training
                 thresh = 1e-3,
                 # again lower number iterations for faster training
                 # in this vignette
                 maxit = 1e3)
print( difftime( Sys.time(), t1, units = 'sec'))
plot(fit)
print (paste("max AUC = ", round(max(fit$cvm), 4)))

## ---- ngram_dtm_1--------------------------------------------------------
it <- itoken(movie_review[['review']], preprocess_function = tolower, 
             tokenizer = word_tokenizer, chunks_number = 10, progessbar = F)

t1 <- Sys.time()
vocab <- vocabulary(src = it, ngram = c(1L, 3L))

print( difftime( Sys.time(), t1, units = 'sec'))

vocab <- vocab %>% 
  prune_vocabulary(term_count_min = 10, doc_proportion_max = 0.5, doc_proportion_min = 0.001)

it <- itoken(movie_review[['review']], preprocess_function = tolower, 
             tokenizer = word_tokenizer, chunks_number = 10, progessbar = F)

corpus <- create_vocab_corpus(it, vocabulary = vocab)

print( difftime( Sys.time(), t1, units = 'sec'))

dtm <- corpus %>% 
  get_dtm %>% 
  tfidf_transformer


dim(dtm)

t1 <- Sys.time()
fit <- cv.glmnet(x = dtm, y = movie_review[['sentiment']], 
                 family = 'binomial', 
                 # lasso penalty
                 alpha = 1,
                 # interested area unded ROC curve
                 type.measure = "auc",
                 # 5-fold cross-validation
                 nfolds = 5,
                 # high value, less accurate, but faster training
                 thresh = 1e-3,
                 # again lower number iterations for faster training
                 # in this vignette
                 maxit = 1e3)
print( difftime( Sys.time(), t1, units = 'sec'))
plot(fit)
print (paste("max AUC = ", round(max(fit$cvm), 4)))

## ---- hash_dtm-----------------------------------------------------------
t1 <- Sys.time()

it <- itoken(movie_review[['review']], preprocess_function = tolower, 
             tokenizer = word_tokenizer, chunks_number = 10, progessbar = F)

fh <- feature_hasher(hash_size = 2**16, ngram = c(1L, 3L))

corpus <- create_hash_corpus(it, feature_hasher = fh)
print( difftime( Sys.time(), t1, units = 'sec'))

dtm <- corpus %>% 
  get_dtm %>% 
  tfidf_transformer

dim(dtm)

t1 <- Sys.time()
fit <- cv.glmnet(x = dtm, y = movie_review[['sentiment']], 
                 family = 'binomial', 
                 # lasso penalty
                 alpha = 1,
                 # interested area unded ROC curve
                 type.measure = "auc",
                 # 5-fold cross-validation
                 nfolds = 5,
                 # high value, less accurate, but faster training
                 thresh = 1e-3,
                 # again lower number iterations for faster training
                 # in this vignette
                 maxit = 1e3)
print( difftime( Sys.time(), t1, units = 'sec'))
plot(fit)
print (paste("max AUC = ", round(max(fit$cvm), 4)))

