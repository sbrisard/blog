static_uncombined: fftw_mpi_c_demo.c
	gcc fftw_mpi_c_demo.c -I/C/opt/Microsoft_HPC_Pack_2012/Inc -I/C/src/fftw-3.3.3/build/include -L/C/opt/Microsoft_HPC_Pack_2012/Lib/i386 -L/C/src/fftw-3.3.3/build/lib -lfftw3_mpi -lfftw3 -lm -lmsmpi

static_uncombined_global_install: fftw_mpi_c_demo.c
	gcc fftw_mpi_c_demo.c -I/C/opt/Microsoft_HPC_Pack_2012/Inc -L/C/opt/Microsoft_HPC_Pack_2012/Lib/i386 -lfftw3_mpi -lfftw3 -lm -lmsmpi -L/mingw/lib

static_combined: fftw_mpi_c_demo.c
	gcc fftw_mpi_c_demo.c -I/C/opt/Microsoft_HPC_Pack_2012/Inc -I/C/src/fftw-3.3.3/build/include -L/C/opt/Microsoft_HPC_Pack_2012/Lib/i386 -L/C/src/fftw-3.3.3/build/lib/combined -lfftw3 -lm -lmsmpi

dynamic: fftw_mpi_c_demo.c
	gcc fftw_mpi_c_demo.c -I/C/opt/Microsoft_HPC_Pack_2012/Inc -L/C/opt/Microsoft_HPC_Pack_2012/Lib/i386 -lfftw3 -lm -lmsmpi
