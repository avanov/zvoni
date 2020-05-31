// https://manpages.debian.org/testing/ats2-lang/myatscc.1.en.html
// https://manpages.debian.org/testing/ats2-lang/patscc.1.en.html
(*
##myatsccdef=
patscc -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O3 -o $fname($1).exe $1
*)
val _ = print ("Hello, world!\n")

implement main0 () = ()