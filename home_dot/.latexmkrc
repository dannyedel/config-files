$pdflatex = 'pdflatex -interaction=nonstopmode -shell-escape %O %S' ;
$pdf_previewer = 'dspdfviewer -u0 -f' ;
$pdf_mode = 1;

$recorder = 1;

add_cus_dep('dot', 'pdf', 0, 'dot2pdf');

sub dot2pdf {
	system("dot -Tpdf \"$_[0].dot\" > \"$_[0].pdf\"");
}
