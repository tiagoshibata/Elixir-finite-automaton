.PHONY: all live clean

all: report.pdf
	latexmk -pdf && touch report.pdf

report.pdf: report.tex
	chktex report.tex

live:
	latexmk -pvc

clean:
	latexmk -C
