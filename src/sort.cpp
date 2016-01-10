#include "text2vec.h"
 using namespace std;
// template <typename T>
// std::vector<size_t> sort_indexes(const std::vector<T> &v);
//
// template <typename T>
// std::vector<size_t> get_subset_order(const std::vector<T> &v, size_t begin, size_t end);
//
// template <typename T>
// void permute (const std::vector<size_t> &ordering, std::vector<T> &x, size_t offset );


// http://stackoverflow.com/a/12399290/1069256
template <typename T>
  vector<size_t> sort_indexes(const vector<T> &v) {

    // initialize original index locations
    vector<size_t> idx(v.size());
    for (size_t i = 0; i != idx.size(); ++i) idx[i] = i;

    // sort indexes based on comparing values in v
    sort(idx.begin(), idx.end(),
         [&v](size_t i1, size_t i2) {return v[i1] < v[i2];});

    return idx;
  }

template <typename T>
  vector<size_t> get_subset_order(const vector<T> &v, size_t begin, size_t end) {
    // initialize original index locations
    vector<size_t> idx(end - begin + 1);
    for (size_t i = 0; i != idx.size(); ++i) idx[i] = i;
    // sort indexes based on comparing values in v
    sort(idx.begin(), idx.end(),
         [&v, begin](size_t i1, size_t i2) {return v[i1 + begin] < v[i2 + begin];});

    return idx;
  }

template <typename T>
  void permute (const vector<size_t> &ordering,
                vector<T> &x,
                size_t offset ) {
    vector<T> x_original(ordering.size());
    for(size_t i = 0; i < ordering.size(); i++) {
      x_original[i] = x[i + offset];
    }

    for(size_t i = 0; i< ordering.size(); i++) {
      x[i + offset] = x_original[ordering[i]];
    }
  }


// convert from triple format to column compressed
//   SEXP get_dtm_dgC(int ncol) {
//     // vectors for new dgCMatrix
//     //IntegerVector dtm_i(i.size());
//     vector<int>    dtm_i(i.size());
//     vector<double> dtm_x(x.size());
//     vector<int>    dtm_p;
//     size_t inner_col_iter = 0;
//     size_t nnz_iter = 0;
//     vector<size_t> order;
//     vector<size_t> idx = sort_indexes<int>(j);
//     int j_prev_iter = idx[0];
//     for (auto k: idx) {
//
//       dtm_i[nnz_iter] = i[k];
//       dtm_x[nnz_iter] = x[k];
//
//
//       if((j_prev_iter != j[k])) {
//         // sort<int>(dtm_i.begin() + nnz_iter - inner_col_iter, dtm_i.begin() + nnz_iter - 1);
//         order = get_subset_order(dtm_i, nnz_iter - inner_col_iter, nnz_iter - 1);
//         permute<double>(order, dtm_x, nnz_iter - inner_col_iter);
//         permute<int>(order, dtm_i, nnz_iter - inner_col_iter);
//
//         dtm_p.push_back(nnz_iter);
//         inner_col_iter = 0;
//       }
//       nnz_iter ++;
//       inner_col_iter ++;
//
//       j_prev_iter = j[k];
//     }
//
//
//     dtm_p.push_back(nnz_iter);
//
//     S4 dtm("dgCMatrix");
//     dtm.slot("i") = dtm_i;
//     dtm.slot("p") = wrap(dtm_p);
//     dtm.slot("x") = dtm_x;
//     dtm.slot("Dim") = IntegerVector::create(doc_count, ncol) ;
//     if(this->terms.empty())
//       dtm.slot("Dimnames") = List::create(R_NilValue, R_NilValue);
//     else
//       dtm.slot("Dimnames") = List::create(R_NilValue, this->terms);
//
//     return dtm;
// }
