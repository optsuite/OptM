 # OptM beta 1.0
 A feasible method for optimization with orthogonality constraints

 # Problems and solvers
 The package contains codes for the following three problems:

 - $\min F(X), s.t., ||X_i||_2 = 1$

   Solver: OptManiMulitBallGBB.m
   Solver demo: Test_maxcut_demo.m, solving the max-cut problem

   

   The constraints can even be a single sphere: $||X||_F = 1$

   Solver demo: GPE_SP1d_Func.m, solving the BEC problem (the data is not provided).

 - $\min F(X), S.t., X^{\top} X = I_k$, where  $X \in R^{n,k}$

      Solver: OptStiefelGBB.m   
      Solver demo: test_eig_rand_demo.m, computing leading eigenvalues

Applications have been solved by these solvers:

- Homogeneous polynomial optimization problems with multiple spherical constraints：
  $$\max \;  \sum_{1\le i\le n_1, 1\le j \le n_2, 1 \le k \le n_3, 1\le l \le n_4} a_{ijkl} x_i y_j z_k w_l \;  s.t., \|x\|_2 = \|y\|_2 = \|z\|_2 = \|w\|_2= 1,$$
  where $A = (a_{ijkl})$ is a fourth-order tensor of size $n\times n \times n\times n$.
- Maxcut SDP: $\min  \mathrm{Tr}(CX), s.t., X_{ii}=1, X \succeq 0$
- SDP: $\min \mathrm{Tr}(CX), s.t., \mathrm{Tr}(X)=1, X \succeq 0 $
- Low-Rank Nearest Correlation  Estimation: $ \min_{ X \succeq 0} \; \frac{1}{2} \| H \odot (X - C) \|_F^2, \; X_{ii} = 1, \; i = 1, \ldots, n, \; \mathrm{rank}(X) \le p.$
- The Bose–Einstein condensates (BEC) problem
- Linear eigenvalue problems: $\min \mathrm{Tr}(X^{\top}AX), s.t., X^{\top}X =I $
- The electronic structure calculation: the Kohn-Sham total energy minimization and the Hartree-Fock total energy minimization
- Quadratic assignment problem
- Harmonic energy minimization


  For more general problems and solvers, see:
  	Adaptive Regularized Newton Method for Riemannian Optimization
  	https://github.com/wenstone/ARNT


 # References
 - [Zaiwen Wen and Wotao Yin. A feasible method for optimization with orthogonality constraints. Mathematical Programming (2013): 397-434.](https://link.springer.com/article/10.1007/s10107-012-0584-1)

 - [Jiang Hu, Andre Milzarek, Zaiwen Wen, Yaxiang Yuan. Adaptive Regularized Newton Method for Riemannian Optimization. SIAM Journal on Scientific Computing](https://arxiv.org/abs/1708.02016)

 - [Zaiwen Wen, Andre Milzarek, Michael Ulbrich and Hongchao Zhang, Adaptive regularized self-consistent field iteration with exact Hessian for electronic structure calculation. SIAM Journal on Scientific Computing (2013), A1299-A1324.](https://doi.org/10.1137/120894385)

 - [Xinming Wu, Zaiwen Wen, and Weizhu Bao. A regularized Newton method for computing ground states of Bose–Einstein condensates. Journal of Scientific Computing (2017): 303-329.](https://link.springer.com/article/10.1007/s10915-017-0412-0)

- X. Zhang, J. Zhu, Z. Wen, A. Zhou, Gradient-type Optimization Methods for Electronic Structure Calculation, SIAM Journal on Scientific Computing, Vol. 36, No. 3 (2014), pp. C265-C289

- R. Lai, Z. Wen, W. Yin, X. Gu, L. Lui, Folding-Free Global Conformal Mapping for Genus-0 Surfaces by Harmonic Energy Minimization, Journal of Scientfic Computing, 58(2014), 705-725


 # The Authors
 We hope that the package is useful for your application.  If you have any bug reports or comments, please feel free to email one of the toolbox authors:

 * Zaiwen Wen, wendouble@gmail.com
 * Wotao Yin, wotao.yin@gmail.com

 

 # Copyright
-------------------------------------------------------------------------
   Copyright (C) 2018, Zaiwen Wen and Wotao Yin
   Copyright (C) 2010, Zaiwen Wen and Wotao Yin

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without  even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>

