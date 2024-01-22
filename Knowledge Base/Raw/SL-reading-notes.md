# 模型假设

## 监督学习假设及概念

假设$\mathcal{X}\subset \mathbb{R}^n,\mathcal{Y}\subset \mathbb{R}^m$，在$\mathcal{X}$和$\mathcal{Y}$上分别有随机变量$X,Y$，存在函数$f$和与$X$独立的**随机误差变量**（random error term）$\epsilon$，使得：$$Y=f(X)+\epsilon$$并假设$\text{Mean}(\epsilon)=0$.

称$x\in \mathcal{X}$为**预测因子**（predictor）/ **特征**（feature），$y\in Y$为**响应**（response）/ **标签**（target）. 称$\mathcal{X}$为特征空间，$\mathcal{Y}$为响应空间. 并且$x$ #issue .

- $f$为根据$x$预测$y$提供了**系统信息**（systemmatic information），但仍然存在其他未被观测到的变量会对$y$产生影响，因此假设存在误差项.

假设从$\mathcal{X}$中独立同$X$分布（i.i.d）地抽取了$(x_1,x_2,\cdots,x_N)$，根据上面地假设会观测到相应地$(y_1,y_2,\cdots,y_N)$，于是有**数据集**（data set）：$$T=\{(x_1,y_1),(x_2,y_2),\cdots(x_N,y_N)\}$$称$(x_i,y_i),i=1,2,\cdots,N$为一个**数据点**（data point）. 

在监督学习中，我们需要根据给定的数据集$T$估计$f$，记为$\hat{f}$，估计$f$的目的（使用场景）有两种：

1. **预测**（prediction）：只关注对于$X$，根据$\hat{f}$得到的响应$$\hat{Y}=\hat{f}(X)$$与实际的响应$$Y=f(X)+\epsilon$$之间的差距：$$\begin{aligned}
E[(Y-\hat{Y})^2]&=E[(f(X)+\epsilon-\hat{f}(X))^2]\\
&=[f(X)-\hat{f}(X)]^2+\text{Var}(\epsilon)\\
&\geq \text{Var}(\epsilon)
\end{aligned}$$只关心能否减少这一差距，无所谓$f$的具体形式，即使是黑箱也没有问题.
2. **推断**（inference）：关注变量之间的相互作用和关系.

# 模型选择

在[[#监督学习假设及概念]]中，并没有给出测量$E_X[(Y-\hat{Y})^2]$的方法，可供使用的只有$$T=\{(x_1,y_2),(x_2,y_2),\cdots,(x_N,y_N)\}$$而不可以从$\mathcal{X}$中无限制地抽样. 

下面假设我们给出了对于$f$的估计$\hat{f}$，考虑如何衡量$\hat{f}$，以减少$E[(Y-\hat{Y})^2]$.

## 衡量模型性能

根据不同的场景提出不同的模型性能评估方法.

为了检验$\hat{f}$的性能，需要将其应用于从未出现的数据上. 将$T$分割为**训练集**（train data set）和**测试集**（test data set），使用训练集获取$\hat{f}$，训练过程中需要评估$\bar{f}$的性能，也需要使用测试集评估$\hat{f}$的性能. 通常情况下训练和测试过程中的度量标准是相同的. 下面分别就回归和分类场景提出度量标准.

### 回归：MSE

假设有数据集$$T=\{(x_1,y_1),(x_2,y_2),\cdots,(x_N,y_N)\}$$待评估的函数为$\hat{f}$，则可以得到**均方误差**（mean squared error, MSE）：$$\text{MSE}(\hat{f},T)=\frac{1}{N}\sum\limits_{i=1}^{N}(y_i-\hat{f}(x_i))^2$$

假设对于一给定的数据点$(x_0,y_0)$，基于大量的<u>训练集</u>得到$\hat{f}$，视为一个随机变量，并假设与$\epsilon$独立，并假设其均值为$m$，则考虑在该点的均方误差期望：$$\begin{aligned}
E[(y_0-\hat{f}(x_0))^2]&=E[(f(x_0)+\epsilon-\hat{f}(x_0))^2]\\
&=E[(f(x_0)-\hat{f}(x_0))^2]+\text{Var}(\epsilon)\\
&=E[(f(x_0)-m+m-\hat{f}(x_0))^2]+\text{Var}(\epsilon)\\
&=E[(f(x_0)-m)^2]+E((m-\hat{f}(x_0)^2))+\text{Var}(\epsilon)\\
&=[\text{Bias}(\hat{f}(x_0))]^2+\text{Var}(\hat{f}(x_0))+\text{Var}(\epsilon)
\end{aligned}$$

#imcomplementation [[ML-cheatsheets.pdf]]

为在整体上取得较小的$E[(Y-\hat{Y})^2]$，需要在每个点处取得较小的$E[(y_0-\hat{f}(x_0))^2]$，其可以被拆解为$3$个部分：

- **偏差** $\text{Bias}(\hat{f}(x_0))$（bias）：当改变训练集时得到的$\hat{f}$与真实值之间的平均差距；
- **方差** $\text{Var}(\hat{f}(x_0))$（variance）：当改变训练集时得到的$\hat{f}$的波动程度；
- **不可减少误差** $\text{Var}(\epsilon)$（irreducible error）

最终需要得到的是低偏差和低方差的模型.

### 分类：错误率

假设做出的拟合函数为$\hat{f}$，应用在数据集$T=\{(x_1,y_1),(x_2,y_2),\cdots,(x_N,y_N)\}$上，对于$x_i$预测的结果为$\hat{y}_i(i=1,2,\cdots,N)$. 则定义**错误率**（error rate）：$$\text{Er}(\hat{f},D)=\frac{1}{N}I(\hat{y}\neq y)$$目标即为最小化应用于测试集上得到的错误率.

#issue %%按照ISL中的假设，在分类情境下还有真实函数和误差项吗？%%

>[!quote]- 下面是一段把我CPU干烧的话：
>It is possible to show (though the proof is outside of the scope of this book) that the test error rate $\text{Avg}(I(y_0\neq \hat{y}_0))$ is minimized, on average, by a very simple classifier that assigns each observation to the most likely class, given its predictor values.

所谓**贝叶斯分类器**（bayes classfier）即为将其预测的概率向量中最大的值所对应的类别作为预测类别. 并可以证明 #issue %%在什么条件下？%%此时测试错误率平均来看最小.

#imcomplementation %%P56 Exercise%%

# 线性回归

关注的问题：

- 各个特征与响应之间是否存在关系？关系的强弱如何？
- 特征之间是否存在**协同效应**（synergy effect）；
- 是否存在线性关系，如果不存在能否对变量进行变换以转换为线性关系？

## 单变量情形

先考虑最简单的情形：预测函数为
$$\hat{f}(X)=\alpha_0+\alpha_1X$$

其中$\alpha_0,\alpha_1$称为系数（coefficients）/ 参数（parameters）

选用MSE度量$\hat{f}$的拟合程度，或可使用**残差平方和**（residual sum of squres, RSS）：$$\text{RSS}(\hat{f},T)=\sum\limits_{i=1}^{N}(y_i-\hat{f}(x_i))^2$$

取$$\begin{aligned}
&\hat{\beta}_1=\frac{\sum_{i=1}^{N}(x_i-\bar{x})(y_i-\bar{y})}{\sum_{i=1}^{N}(x_i-\bar{x})^2}\\
&\hat{\beta}_0=\bar{y}-\hat{\beta}_1\bar{x}
\end{aligned}$$时最小化. （推导见[[#一般情形]]）

假设真实函数为：$$\begin{aligned}
&f(X)=\alpha_0+\alpha_1X+\epsilon\\
&\text{mean}(\epsilon)=0
\end{aligned}$$并且$X,\epsilon$独立.

#implementation %%R，使用College数据集%%

假设分别用大小相等的数据集$T$训练$\hat{f}$，$\hat{f}$中两个参数$\beta_0,\beta_1$因而可以视为随机变量，现在估量$\beta_0.\beta_1$与$f$中两个参数$\alpha_0,\alpha_1$之间的差距随着数据集大小$N$的变化会如何变化，考虑计算**标准误差**（standard errors）：$$\begin{aligned}
&\text{SE}(\beta_0)^2=\left[\frac{1}{N}+\frac{\bar{x}^2}{\sum_{i=1}^{N}(x_i-\bar{x})^2}\right]\cdot\text{Var}(\epsilon)\\
&\text{SE}(\beta_1)^2=\frac{\text{Var}(\epsilon)}{\sum_{i=1}^{N}(x_i-\bar{x})^2}
\end{aligned}$$

标准偏差定义为$$\text{SE}(Y)^2=\text{Var}(Y)=\frac{\sigma^2}{n}$$其中$\sigma$是随机变量$Y$的
**标准差**（standard deviation）

#imcomplementation  %%怎么来的？[https://en.wikipedia.org/wiki/Standard_error]，上式是如何推导得到的？%%

此外，在上式中$\text{Var}(\epsilon)$的估计（称为残余标准偏差，residual standard error，RSE）由RSS给出：$$\text{RSE}=\sqrt{\text{RSS}/(N-2)}$$

计算得到标准偏差之后可以计算**置信区间**（confidence intervals）；$95\%$的置信区间定义为有$95\%$的概率，参数的真实值将会落在该区间内. #issue %%A 95% confidence interval has the following prop- erty: if we take repeated samples and construct the confidence interval for each sample, 95% of the intervals will contain the true unknown value of the parameter%% 

对于线性回归，参数$\beta_1$的置$95\%$信区间大约为：$$\hat{\beta}_1\pm 2\cdot \text{SE}(\hat{\beta}_1)$$

#imcomplementation %%注释：上式成立误差项需要服从高斯分布，并且SE前的系数会随着N的变化发生轻微变化，最后是一句看不懂的话：To be precise, rather than the number 2, (3.10) should contain the 97.5% quantile of a t-distribution with n−2 degrees of freedom%%

标准差也可以执行**假设检验**（hypothesis tests），例如**零假设**（null hypothesis）$H_0$：变量$X$和$Y$之间没有关联；**备选假设**（alternative hypothesis）$H_a$：变量$X$和$Y$之间有关联.

在线性回归中，$H_0$对应于$\beta_1=0$，$H_a$对应于$\beta_1\neq0$.

实际进行假设检验时，需要确定精度（accuracy），即对于$\beta_1\neq0$，标准误差$\text{SE}(\beta_1)$在什么范围内时可以认为$\beta_1=0$，从而接受$H_0$.

实际中计算$t-$统计量（t-statistic）：$$t=\frac{\beta_1-0}{\text{SE}(\beta_1)}$$

其测量 #issue %%什么意思？？？ the number of standard deviations that $\beta_1$ is away from 0%% 如果$X$和$Y$之间无关联（$H_0$成立） #issue %%什么是有关联？在线性模型下是beta_1，在其他情况下用什么度量，线性关系的度量总是合适的吗？%% 则期望$t-$统计量具有$N-2$个自由度 #issue %%?%% 的$t-$分布.

反之，可以假设$H_0$成立（$\beta_1$=0），因为当$N$充分大（$>30$）时$t-$分布近似于标准正态分布$\mathcal{N}(0,1)$. 然后计算对于$t-$分布，计算$$P(x>\lvert t\rvert)$$ #issue %%t-分布没说清楚%% 该值定义为$p-$值（$p$-value） #imcomplementation %%更多内容见ISL Chap.13%%

通常来说，设置$p$值截止线为$5\%$或者$1\%$，当$p$值小于该截止线时拒绝零假设.

---

到这里回顾一下已经提到的统计量：
- $$\text{MSE}(\bar{f},T)$$
- $$\text{SE}(\beta_1)=\frac{\sigma}{\sqrt{n}}$$
- $\text{RSS}$：表示模型预测结果与实际值的绝对差平方和；
- #issue %%不理解为什么除自由度-2%%$$\text{RSE}=\sqrt{\frac{\text{RSS}}{N-2}}$$
- $t-$统计量：$$t=\sqrt{\frac{\beta_1-0}{\text{SE}(\beta_1)}}$$
- $p-$值；


为了检测模型的拟合程度（预测），可以选用$\text{MSE},\text{RSS},\text{RSE}$.

为了验证变量之间是否存在关系（推断），可以计算：$t-$统计量，$p-$值

---

下面再引入一些统计量：

$R^2$统计量：$$R^2=\frac{\text{TSS}-\text{RSS}}{\text{TSS}}$$

其中 **TSS**（total sum of squares）定义为$$\text{TSS}=\sum\limits_{i=1}^{N}(y_i-\bar{y})^2$$

直观上的解释：$\text{RSS}$为在进行回归之后计算得到的偏差平方和（不可解释），$\text{TSS}$为在进行回归之前得到的方差，$R^2$ #issue 因此表示$Y$的变动中可以被$X$解释的部分. %%太模糊%%

回顾（样本）协方差的定义：$$\text{Cov}(X, Y)=\frac{\sum_{i=1}^{N}(x_i-\bar{x})(y_i-\bar{y})}{\sqrt{\sum_{i=1}^{N}(x_i-\bar{x})^2}\sqrt{\sum_{i=1}^{N}(y_i-\bar{y})^2}}$$

一般记$r=\text{Cov}(X,Y)$，可以证明： #imcomplementation $$R^2=r^2$$

在下面讨论一般情形（多变量）时，无法延申$\text{Cov}(X,Y)$的概念，但$R^2$可以延申.

## 一般情形

现在考虑多个协变量的情形：$X_1,X_2,\cdots,X_d$，下面记：$$X=[X_1,X_2,\cdots,X_d]$$考虑其与标签$Y$之间的关系. 假设：$$Y=\alpha_0+\alpha_1X_1+\alpha_2X_2+\cdots+\alpha_dX_d+\epsilon$$

假设估计得到的函数：$$\hat{f}(X)=\beta_0+\beta_1X_1+\beta_2X_2+\cdots+\beta_dX_d$$

对于数据集$T$，可计算：$$\text{RSS}(\hat{f},T)=\sum\limits_{i=1}^{N}(y_i-\hat{f}(x_i))^2$$

为确定$X$与$Y$之间是否有关联，提出假设检验：

零假设：$$H_0:\alpha_1=\alpha_2=\cdots=\alpha_d=0$$和备选假设：$$H_a:\exists \alpha_i\neq0,i=1,2,\cdots,d$$

下面计算$F-$统计量（$F-statistic$）：$$F=\frac{(\text{TSS}-\text{RSS})/d}{\text{RSS}/(n-d-1)}$$其中：$$\begin{aligned}
&\text{TSS}=\sum\limits_{i=1}^{N}(y_i-\bar{y})^2\\
& \text{RSS}=\sum\limits_{i=1}^{N}(y_i-\hat{f}(x_i))^2
\end{aligned}$$

若线性假设成立，有：$$E[\text{RSS}/(N-d-1)]=\sigma^2$$并且在零假设成立的条件下：$$E[(\text{TSS}-\text{RSS})/d]=\sigma^2$$若不成立则：$$E[(\text{TSS}-\text{RSS})/d]>\sigma^2$$

因此当响应$Y$与预测因子$X$之间不存在关系时，$F-$统计量接近于$1$，否则“明显”大于$1$. #imcomplementation %%没有推导%% #implementation %%R实现%%

当$H_0$成立并且误差项$\epsilon_i$服从正态分布时，$F-$统计量服从$F-$分布. #imcomplementation %%即使误差项并不是正态分布的，$F-$统计量在$N$充分大时也近似服从$F-$分布%%

从而可以计算$p-$值，进而决定是否拒绝原假设$H_0$. %%这里不明白，$F$的$p-$值要如何取得？%%

更一般的情形，对一部分系数进行假设检验，为方便不妨定义零假设为：$$H_0:\alpha_{d-m+1}=\alpha_{d-m+2}=\cdots=\alpha_{d}=0$$

假设零假设成立，进而给出模型：$$\hat{f}'(X)=\beta_0+\beta_1X_1+\cdots+\beta_{d-m}X_{d-m}$$

同样可以计算$F-$统计量：$$F=\frac{(\text{RSS}_0-\text{RSS})/m}{\text{RSS}/(N-d-1)}$$其中$$\text{RSS}_0=\sum\limits_{i=1}^{N}(y_i-\hat{f}'(X))^2$$而$$\text{RSS}=\sum\limits_{i=1}^{N}(y_i-\hat{f}(X))^2$$

特殊情况：$d=1，m=0$时，$F-$统计量即等同于$t-$统计量. 并且可以证明，只对于单变量$X_i$和响应$Y$分析得到的$t-$统计量，等同于在多变量$X=[X_1,X_2,\cdots,X_d]$中忽略掉$X_i$之后计算得到的$F-$统计量：$$t^2=F$$ #issue %%原文：It turns out that each of these is exactly equivalent to the F - test that omits that single variable from the model, leaving all the others in—i.e. q=1 in (3.24).%% 进而在多变量分析中，为分析单个因素是否对响应起到效果，可以先进行单变量分析，进而排除没有影响的变量.

反之，能否仅根据对单变量分析的结果来判断多变量分析的影响？答案是不可以. #issue %%下面这个例子没有给出证明%% 考虑$d=100$，$H_0$假设成立，则约有$5\%$的$p-$值（单变量分析）将会小于$0.05$. 因此有可能认定存在关系，从而与相悖.

上述情况，若采用$F-$统计量其有$5\%$的概率落在$0.05$以下，与$d$或者$N$无关，因此更容易判断.

>[!warning]- $F-$统计量的限制
>$d>N$时不能使用$F-$统计量，也不能进行回归计算，上述方法失效.

在拒绝零假设之后，需要考虑哪些变量对于响应是有影响的，下面进入到**特征选择**（feature / variable selection）.

直接的方法是取特征的子集分别拟合模型，然后对比模型的性能. #imcomplementation %%报菜名：Mallow's $C_p$, Akaike information criterion ($\text{AIC}$), Bayesian information criterion ($\text{BIC}$), adjusted $R^2$. Chap. 6%% 但在$d$过大时显然不可取.

### 前向选择

**前向选择**（forward selection）首先拟合一个只含有截距的模型：$$\hat{f}_0(X)=\beta_0$$然后对$d$个特征分别进行单变量线性回归，得到：$$\hat{f}_i(X)=\beta_{0i}+\beta_iX_i,i=1,2,\cdots,d$$下面计算：$$\text{RSS}(\hat{f}_0+\hat{f}_{i},T),i=1,2,\cdots,d$$选取其中最小的$\text{RSS}$对应的$\hat{f}_0+\hat{f}_{i}$作为新的双变量线性回归，依次类推，直到达到停止条件. #imcomplementation %%什么停止条件？%%

#implementation %%这个筛选方法用R实现一下%%

### 后向选择

**后向选择**（backawrd selection）

### 混合选择