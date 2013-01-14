\name{subtype}
\alias{subtype}
\title{ Cluster analysis to find molecular subtypes and their assessment 
}
\description{
subtype performs a biclustering procedure on a input dataset and assess whether resulting clusters are promising subtypes. 
}
\usage{
subtype(GEset, outcomeLabels, treatment=NULL, Npermutes=10, Nchunks = 25, minClusterSizeB = 20, NclustersASet = 100, FDRpermutation = TRUE, nFDRperm = 50, seed = NULL, testMode="quick",survivaltimes=NULL,method="penalized", top_best_probes=100, Niter=20, showMovie=0, redefineSubtypeMembers=0,holdOut=10 )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{GEset}{p-by-n data matrix, where p is the number of variables (e.g. genes) and n is the number of subjects. Row and column names are necessary.}
\item{outcomeLabels}{n-by-1 vector. Binary prognosis labels assigned to the subjects. The order of subjects should be equalized to that of GEset.}
\item{treatment}{NULL.}
\item{Npermutes}{Number of permutations for the variables. For each permutation, the variables belong to different chunks.}
\item{Nchunks}{Number of chunks of the variables. When the number of variables is too large for clustering analysis, we split 
the variables into several(=Nchunks) chunks.}
\item{minClusterSizeB}{The minimum number of subjects per each selected subtype. The default is 20.}
\item{NclustersASet}{Cut a tree from hierarchical clustering into several groups. The default is 100.}
\item{FDRpermutation}{Determine whether FDR computation is based on permutation procedure. The default is TRUE.}
\item{nFDRperm}{Number of permutation to compute FDR. The default is 50.}
\item{seed}{seed number for reproducibility. }
\item{testMode}{the mode is fixed at "quick".}
\item{survivaltimes}{NULL. }
\item{method}{penalized is used. }
\item{top_best_probes}{top-ranked probes are used in t-test, and this is input for penalized. The default is 100.}
\item{Niter}{The number of iterations of { (TrainingSet, TestSet)->training->test->recordResults }. The defualt is 20.}
\item{showMovie}{display RUC/Surv curves and heatmaps. The default is 0. }
\item{redefineSubtypeMembers}{detect subtype members after every hold-out. The defualt is 0. }
\item{holdOut}{out of the subtype, i.e. Nsubtype - holdOut = Ntraining_set. The defualt is 10. }
}
\details{
This implements a biclustering algorithm to find hidden subtypes in a dataset.
summary provides a measure based on FDR and its p-value for assessing the subtypes. 
Note that the R-package rsmooth should be installed before implementing subtype. rsmooth can be downloaded
from http://www.meb.ki.se/~yudpaw.
For large dataset, the computation can be heavy, so it is desirable for users to consider parallel processing in R.
}
\value{
\tabular{ll}{
resultsAll: \tab a matrix including subtypeID and summary statistics for each subtypeID. 
For a specific subtypeID, it includes the number of genes, the number of subjects, area of low p-values (low_pValue_Area).\cr
GenesDefiningSubtypes: \tab Variables in each subtypeID. This can be identified with "subtypeID". \cr
SubtypePatients: \tab Subjects in each subtypeID. This can be identified with subtypeID.\cr
}
}
\references{
Alexeyenko, A. et al. (2011) Estimation of false discovery rate in a heterogeneous population.
}
\author{
Andrey Alexeyenko, Woojoo Lee (maintainer:lwj221@gmail.com) and Yudi Pawitan
}
%% ~Make other sections like Warning with \section{Warning }{....} ~
\examples{

set.seed(1234)
p<-100   #num.variables
n1<-5    #number of sample in population 1
n2<-5    #num.samples from population 2 

group<-c(rep(1,length.out=n1),rep(2,length.out=n2))
data<-matrix(rnorm((n1+n2)*p),(n1+n2),p)

############################

dimnames(data)[[1]]<-as.character(paste("P",runif(nrow(data),0,1),sep="")) ### making row names
dimnames(data)[[2]]<-as.character(paste("G",runif(ncol(data),0,1),sep="")) ### making column names

### The following procedure takes ~ 1 minute.
A=subtype(
   GEset = t(data),
   outcomeLabels = group,
   Npermutes = 2, 
   Nchunks = 5, 
   NclustersASet = 3,
   seed=1234
)

summary(A,f.out=0)  ### f.out can be used for filtering out uninteresting subtypes. e.g. if f.out=2, we ignore subtypes having N01_0<=2.

}
