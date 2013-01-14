\name{summary}
\alias{summary}
\title{
Summarizing the output from subtype 
}
\description{
summary summarizes the output from subtype.
}
\usage{
summary(object,...)
}

\arguments{
  \item{object}{
 the output from subtype
}
  \item{...}{
  criterion for filtering out uninteresting cases
}
}
\details{
summary provides a measure based on FDR and its p-value for assessing the subtypes. 
}
\value{
NFDR01 : see the reference
}
\references{
Alexeyenko, A. et al. (2011) Estimation of false discovery rate in a heterogeneous population.
}
\author{
Andrey Alexeyenko, Woojoo Lee (maintainer:lwj221@gmail.com) and Yudi Pawitan
}


%% ~Make other sections like Warning with \section{Warning }{....} ~


\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

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
