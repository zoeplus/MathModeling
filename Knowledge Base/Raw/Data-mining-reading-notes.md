# 符号说明

本文采用统一的符号，或在上下文中直接省略符号说明.

- $\mathcal{O}=\{O_1,O_2,\cdots,O_N\}$表示一组数据对象，用于讨论数据类型的转换.
- $\mathcal{D}=\{x_1,x_2,\cdots,x_N\}$ 表示数据集
	- $x_i$ 表示第$i$个数据点，$x_i^j$表示其第$j$个特征. 
		- $x^j$表示第$j$个特征变量.
	- 第$j$个特征的统计特征：$\mu^j$ 均值. $\sigma^j$ 标准差. $\max^j=\max\{x^j_1,x^j_2,\cdots,x^j_N\}$ 最大值，$\min^j=\min\{x^j_1,x^j_2,\cdots,x^j_N\}$ 最小值.
	- $\mathcal{D}^j$表示第$j$个特征对应的数据集，即：$$D^j=\{x_1^j,x_2^j,\cdots,x_N^j\}$$
	- $D$表示数据矩阵，此处$d$或为特征数量或为数据集的所有属性的数量：$$D=\begin{bmatrix}x_1^1 & x_1^2 & \cdots & x_1^d\\ x_2^1 & x_2^2 & \cdots & x_2^d\\ \cdots & \cdots & \cdots &\cdots \\ x_N^1 & x_N^2 & \cdots  & x_N^d \end{bmatrix}$$
	- $C$为对应于$D$的协方差矩阵：$$C=\begin{bmatrix}c_{11} & c_{12} & \cdots  & c_{1d} \\ c_{21} & c_{22} & \cdots  & c_{2d} \\ \cdots & \cdots & \cdots & \cdots  \\ c_{d1} & c_{d2} & \cdots  & c_{dd}\end{bmatrix}$$其中$$c_{ij}=\frac{\sum_{i=1}^{N}x_k^ix_k^j}{N}-\mu^i \mu^j,\quad i,j=1,2,\cdots,d$$或可以写作：$$\begin{aligned}
&c_{ij}=\frac{D^i\cdot D^j}{N}-\mu^i\mu^j,\quad i,j=1,2,\cdots,d\\
&C=\frac{D^TD}{N}-\mu^T\mu\\
&\mu=[\mu^1,\cdots,\mu^d]^T
\end{aligned}$$

# 数据预处理

## 数据类型

### 数值（Numeric）

- 图像；

### 类别（Categorical）

### 时间序列（Time Series）

### 离散序列（Discrete Sequence）

### 空间数据（Spatial）

### 文本（Text）

### 图（Graph）

## 数据类型的可移植性

为什么需要进行数据类型的转换？

- 通常处理的都是混合类型的数据，为每一种数据类型组合建立模型比较困难，因此将不同的数据类型统一转换为相同的数据类型（例如数值型）；所以试图进行数据类型的转化.

#implementation

[[Data Type Change]]中列举出了数据类型之间的转换方法.

下面假设需要被转化的数据类型对应的数据集为$\mathcal{D}_0$，目标数据类型对应的数据为$\mathcal{D}_1$

### 数值 -> 类别

将$\mathcal{D}_0$划分为$\phi$个区间，然后标记区间为$1,2,\cdots,\phi$，从而完成转换.

1. 等宽均分区间（Equi-width）：
	- 求出$\min(\mathcal{D}_0),\max(\mathcal{D}_0)$，然后均分区间$[\min(\mathcal{D}_0),\max(\mathcal{D}_0)]$.
	- 均分区间存在问题：i.e. $[200,400]$中的数据量可能远远大于$[400,600]$，这就起不到一个良好区分的效果.

#implementation 

```R

```

2. 均分$\log(\mathcal{D}_0)$等：
	   - 假设$\mathcal{D}_0$的数据项的频率分布是呈指数形式的，用这一方法能够取得较好的区分效果.
	   - 推及一般，假设$\mathcal{D}_0$的累次频率分布可以用函数$f$近似表达，则只要选出$f$的分点对应的值即可.

3. 等深 / 等频率均分区间（Equi-depth）：首先$\text{sort}(\mathcal{D}_0)$，然后进行取中值点逐步均分.

### 时间序列 -> 离散序列

使用符号聚合近似方法（Symbolic aggregate approximation, SAX），假设时间序列$\mathcal{D}_0$可以转换为离散序列$\mathcal{D}_1$（以符号为元素），并假设$\mathcal{D}_1$中的每一个符号都对应于数量近似相等的时间序列数据.

SAX方法包含两个步骤：

1. 基于窗口平均（Window-based average） #issue %%滑动窗口平均？还是其他类型的？%%
2. 基于值的离散化（Value-based discretation）：假设经过窗口平均之后的时间序列数据服从Gaussian分布，并以窗口为单位计算均值和方差，进而确定分位点 #issue %%什么叫做以窗口为单位进行平均，以及如何确定分位点的数量（包括上面已经提到的数值转类别的方法）%%

这个方法描述的有些抽象，实际上所谓符号可以理解为“时期”，例如对于某件商品的日销售量数据构成的时间序列，可以使用SAX方法将该时间序列进行符号序列化，划分为旺季、淡季两个符号.

#implementation 

### 时间序列 -> 数值

可以使用离散小波变换（Discrete Wavelet Transformation）或者离散傅里叶变换（Discrete Flourier Transformation）将时间序列转换为一组系数. 这组系数能否反应该时间序列的不同位置之间的（平均 #issue ）差异.

The common property of these transforms is that the various coefficients are no longer as dependency oriented as the original time-series values. #issue

### 离散序列 -> 数值

分成两步进行，首先是采取独热变量的方法将离散序列转化为多条序列，i.e.（直接复制课本上的例子）

$$ACACACTGTGACTG$$

可以转换为：

$$\begin{aligned}
10101000001000\\ 
01010100000100\\
00000010100010\\
00000001010001
\end{aligned}$$

对应$4$条序列，之后对于每一条序列进行离散小波变换（Discrete Wavelet Transformation, DWT） #issue 最终再得到一个多维数值型数据.

#implementation 

### 空间数据 -> 数值

#issue

### 图 -> 数值

#issue 对于用加权边表示节点之间的相似度的图，可以使用多维缩放（Multi-dimensional scaling，MDS）；此外也可以使用光谱变换（Spectral transformation）进行类型转换.

### （基于相似度）任何数据类型 -> 图

对于一些基于相似度的算法，可以将相应的一组数据对象转化为图.

对于一组数据对象：$$\mathcal{O}=\{O_1,O_2,\cdots,O_n\}$$

创建一组相应的节点：$$N=\{N_1,N_2,\cdots, N_n\}$$

创建边可以使用下面的方法：

- 设置超参数$\epsilon$，当相似度$d(O_i, O_j)>\epsilon$时，在节点$N_i,N_j$之间创建加权无向边. 
- 使用KNN方法，在节点$N_i,N_j$之间创建有向边 #issue %%能否忽略？%%. 随后边权重$w_{ij}$为相似度的一个核函数 #issue ，越大的相似度对应于越大的边权.

## 数据清洗

### 处理缺失值（imputation）

1. 当缺失值不多时，直接丢弃缺失值所在的数据点.

```R
data <- na.omit(data)
```

2. 估计缺失值. 对于具有 #issue 依赖关系的数据（空间数据，时间序列等），缺失值的估计比较简单，例如可以采用插值法，均值法.

3. #issue The analytical phase is designed in such a way that it can work with missing values. Many data mining methods are inherently designed to work robustly with missing values. This approach is usually the most desirable because it avoids the additional biases inherent in the imputation process.

### 处理非一致值

所要处理的数据总体上可能呈现某种分布，同时可能出现与该分布不一致的值，可能是**错误记录的值**或者是**异常值**（outliers）

1. 一致性检测（Inconsistency detection）. #issue 
2. 专业知识；
3. 以数据为中心的方法. 计算出数据的统计特征以进行离群值的检测.

### 归一化和标准化

多数场景下，不同的特征具有不同的量度. 在这种情况下，某些算法（例如基于欧式距离）会失效，因此需要进行**归一化**（scaling）和**标准化**（normalization）. #issue %%normalization和standardization有什么区别？%%

常见的方法是**标准化**（standardization），对于第$j$个特征变量$x^j$，其标准化之后的值为：$$z^j=\frac{x^j-\mu^j}{\sigma^j}$$

或者可以使用如下归一化方法：$$z^j=\frac{x^j-\min^j}{\max^j-\min^j}$$

该方法需要确定最大值和最小值不是异常值.

#imcomplementation %%Python数学建模与实验%%

## 数据降维和变换

### 数据采样

对于数据量比较大的情况，例如在一个实时场景下进行数据采集时，需要采用数据采样的方法创建一个较小的数据库.

1. **对于静态数据进行采样**：静态数据是指我们实现已经有了一个确定大小的数据库$\mathcal{D}$（而不是实时收集的）. 首先确定采样率$\alpha$，假设有$N$条数据项，则从$\mathcal{D}$中无重复随机抽取$\alpha N$条数据项即可. 通常不采用重复（with replacement）抽样的方法. #issue %%为什么？比如异常值检测为什么不能使用重复检测的方法？%%

下面讨论对于静态数据的随机抽样方法.

**有偏采样**（biased sampling）：在分析过程中某些数据可能有更大的价值，例如：

- **时间衰减偏见**（temporal-decay bias）：越接近当前时间点的数据被记录的更多，因此有更大的概率被采样到（ #issue %%所以？如果没有时间标记的话如何解决这件事，就算知道分布又如何?%%）. 一种假设是指数衰减偏见（expoential-decay bias）$$p(X)\propto e^{-\lambda t}$$即数据点$X$被观测到的概率与时间间隔$t$成指数反比关系.

#implementation %%找一个数据集，分别利用有偏采样和分层采样试一试%%

**分层采样**（stratified sampling）：在某些数据集中不同类型的样本并没有得到均等的记录，一些有同样或者更高重要性的数据记录少. 分层采样因此首先将数据进行分层，按照比例从每一层中抽样. 

与分层采样类似的是基于密度采样

2. 对于数据流进行蓄水池采样

#imcomplementation %%先跳过了，P39%%

### 特征选择

选取一部分特征进行分析.

主要有两大类特征选择方法：

1. **无监督特征选择**（unsupervised feature selection） #imcomplementation %%Chap.6 数据聚类时会讲到%%
2. **监督特征选择**（supervised feature selection）：只选取与标签值有较强关系的特征. #imcomplementation %%Chap.10 数据分类%%

### 用坐标变换进行数据降维

将原先的所有特征用更少的特征表示出来，也就是降低数据点的维度.

在数据集中，不同特征之间可能存在关联性. 因此需要处理这些冗余 #issue %%如果不处理这些冗余有很大影响吗？%%

坐标变换是处理数据降维的一种方法，例如考虑： #imcomplementation  %%这里举个例子就好了，将一个三维向量[0,0,z]乘以一个满秩矩阵得到[x,y,z]，可视化一下，反过来就是一个3维用1维+2个低方差维度（这些低方差维度可以去掉，从而就是1个维度）表示即可，这里让我想起了Weiserstain GAN%%

基于坐标变换的方法有**主成分分析**（principal component analysis, PCA）和**奇异值分解**（singular value decomposition, SVD）两种.

1. PCA通常在对于数据集进行中心处理之后（对于整个数据集按照索引轴取均值向量，然后每个数据点减去该均值向量）使用. #issue %%然而，也可以不使用均值中心，只要数据集的均值是分别存储的. 这句话是什么意思？%% PCA的目的是将数据集旋转，从而获取到方差很大的新的维度（即，$\sigma^2D^j$或者$(\text{diag}D)_j$）. #issue %%这段不知道怎么准确用数学语言描述，什么是一个“维度的方差”%% 注意到协方差矩阵$C$是半正定矩阵：$$v^TCv=\frac{(Dv)^TDv}{N}-(\mu v)^2\geq 0,\forall v\in \mathbb{R}^d$$（即为数据集$D$在向量$v$上投影得到的向量的方差）从而存在可得：$$C=P$$ #issue %%高代...%%


- 潜在语义分析（latent sematic analysis, LSA），针对文本领域.

#imcomplementation %%参考Python数学建模，以及机器学习方法，完成之后在这里做一个索引%%

### 用类型转换进行数据降维

在[[#数据类型的可移植性]]中提到数据类型之间可以进行转换. 这个过程也可以实现数据降维. 例如：

- 采用DWT可以将时间序列转换为 #issue %%数据项数更小还是数据维度更小%%多维数据；
- 图使用嵌入方法 #issue %%什么意思，embedding techniques%%可以被转换为多维数据.


