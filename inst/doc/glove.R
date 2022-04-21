## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(echo=TRUE, eval=FALSE, warning=FALSE, message=FALSE)

## -----------------------------------------------------------------------------
#  library(text2vec)
#  text8_file = "~/text8"
#  if (!file.exists(text8_file)) {
#    download.file("http://mattmahoney.net/dc/text8.zip", "~/text8.zip")
#    unzip ("~/text8.zip", files = "text8", exdir = "~/")
#  }
#  wiki = readLines(text8_file, n = 1, warn = FALSE)

## -----------------------------------------------------------------------------
#  # Create iterator over tokens
#  tokens <- space_tokenizer(wiki)
#  # Create vocabulary. Terms will be unigrams (simple words).
#  it = itoken(tokens, progressbar = FALSE)
#  vocab <- create_vocabulary(it)

## -----------------------------------------------------------------------------
#  vocab <- prune_vocabulary(vocab, term_count_min = 5L)

## -----------------------------------------------------------------------------
#  # Use our filtered vocabulary
#  vectorizer <- vocab_vectorizer(vocab)
#  # use window of 5 for context words
#  tcm <- create_tcm(it, vectorizer, skip_grams_window = 5L)

## ---- message=TRUE------------------------------------------------------------
#  glove = GlobalVectors$new(rank = 50, x_max = 10)
#  wv_main = glove$fit_transform(tcm, n_iter = 10, convergence_tol = 0.01, n_threads = 8)
#  # INFO  [09:35:20.779] epoch 1, loss 0.1758
#  # INFO  [09:35:28.212] epoch 2, loss 0.1223
#  # INFO  [09:35:35.500] epoch 3, loss 0.1081
#  # INFO  [09:35:43.100] epoch 4, loss 0.1003
#  # INFO  [09:35:50.848] epoch 5, loss 0.0953
#  # INFO  [09:35:58.593] epoch 6, loss 0.0917
#  # INFO  [09:36:06.346] epoch 7, loss 0.0890
#  # INFO  [09:36:14.123] epoch 8, loss 0.0868
#  # INFO  [09:36:21.862] epoch 9, loss 0.0851
#  # INFO  [09:36:29.610] epoch 10, loss 0.0836

## -----------------------------------------------------------------------------
#  wv_context = glove$components
#  word_vectors = wv_main + t(wv_context)

## -----------------------------------------------------------------------------
#  berlin <- word_vectors["paris", , drop = FALSE] -
#    word_vectors["france", , drop = FALSE] +
#    word_vectors["germany", , drop = FALSE]
#  cos_sim = sim2(x = word_vectors, y = berlin, method = "cosine", norm = "l2")
#  head(sort(cos_sim[,1], decreasing = TRUE), 5)
#  #     paris    berlin    munich    madrid   germany
#  # 0.7859821 0.7410693 0.6490518 0.6216343 0.6160014

