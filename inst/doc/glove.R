## ---- eval=FALSE---------------------------------------------------------
#  library(text2vec)
#  library(readr)
#  temp <- tempfile()
#  download.file('http://mattmahoney.net/dc/text8.zip', temp)
#  wiki <- read_lines(unz(temp, "text8"))
#  unlink(temp)

## ---- eval=FALSE---------------------------------------------------------
#  # create iterator over tokens
#  it <- itoken(wiki,
#               # text is already pre-cleaned
#               preprocess_function = identity,
#               # all words are single whitespace separated
#               tokenizer = function(x) strsplit(x, split = " ", fixed = T))
#  # create vocabulary. Terms will be unigrams (simple words).
#  vocab <- vocabulary(it, ngram = c(1L, 1L) )

## ---- eval=FALSE---------------------------------------------------------
#  vocab <- prune_vocabulary(vocab, term_count_min = 5)

## ---- eval=FALSE---------------------------------------------------------
#  # as said above, we should provide iterator to create_vocab_corpus function
#  it <- itoken(wiki,
#               # text is already pre-cleaned
#               preprocess_function = identity,
#               # all words are single whitespace separated
#               tokenizer = function(x) strsplit(x, split = " ", fixed = T))
#  
#  corpus <- create_vocab_corpus(it,
#                                # use our filtered vocabulary
#                                vocabulary = vocab,
#                                # don't create document-term matrix
#                                grow_dtm = F,
#                                # use window of 5 for context words
#                                skip_grams_window = 15L)
#  
#  # get term cooccurence matrix from instance of C++ corpus class
#  tcm <- get_tcm(corpus)

## ---- eval = F-----------------------------------------------------------
#  fit <- glove(tcm = tcm,
#               word_vectors_size = 50,
#               x_max = 10, learning_rate = 0.2,
#               num_iters = 15)

## ---- eval = F-----------------------------------------------------------
#  word_vectors <- fit$word_vectors[[1]] + fit$word_vectors[[2]]
#  rownames(word_vectors) <- rownames(tcm)

## ---- eval = F-----------------------------------------------------------
#  word_vectors_norm <-  sqrt(rowSums(word_vectors ^ 2))
#  
#  rome <- word_vectors['paris', , drop = F] -
#    word_vectors['france', , drop = F] +
#    word_vectors['italy', , drop = F]
#  
#  cos_dist <- text2vec:::cosine(rome,
#                                word_vectors,
#                                word_vectors_norm)
#  head(sort(cos_dist[1,], decreasing = T), 5)
#  ##    paris    venice     genoa      rome  florence
#  ##0.7811252 0.7763088 0.7048109 0.6696540 0.6580989

