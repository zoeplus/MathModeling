所有说明性的笔记都命名为README

# RoadMap


# 为什么使用Visual Studio Code?


我自23年5月以来一直在使用Obsidian进行笔记记录，其有许多其他编辑器无法替代的功能. 所以对于更换Markdown编辑器一直没有什么想法. 而代码编写（主要是Python, LaTeX）则是在23年12月的时候开始使用Visual Studio Code（VSCode），对这个这种轻量级的IDE很是喜欢.

但是可惜的是Obsidian<u>不支持多人编辑功能</u>，可能的解决方案是同步功能或者Git，效果一般；Obsidian<u>没有版本控制系统</u>，虽然可以通过快照查看之前的文件，但是效果上还是一般（参考Git）

我为什么想要**多人编辑**和**版本控制**呢？因为在<u>建立团队知识库</u>、<u>团队分享和有效交流</u>、<u>团队合作进行项目</u>等场景下，以我之前的经历来看，多人编辑应该能起到一个积极的作用；至于版本控制，不管是合作进行项目还是个人编辑场景，都是有用处的.

面向我的这两个主要需求，可以找到一些实现方案. 目前我认为VSCode是最理想的一种，其支持：
- **多语言**（C++, Python, R, LaTeX, Markdown）**实时协同编辑**，**共享终端**（以便Debug）；
- 非常简单的**版本控制**，Ctrl + s就直接Save一个版本，并显示删、改、添加痕迹.
- **本地**，这点可能听起来没什么，但是VSCode使用的是本地的文件夹，Obsidian也使用本地的文件夹作为仓库，在<u>编辑Markdown时可以直接使用Obsidian / VSCode</u>（实时传递内容，演示），极大地保留了Obsidian的各种优势. 比如：
	- 在Obsidian中加速Markdown编辑，例如Editing Toolbar，Quick LaTeX for Obsidian；
	- Obsidian中的特色语法、双链等，例如下面举出的一些；
	- 附件管理，虽然Obsidian在这方面一般，但也比VSCode好多了；

# Obsidian使用介绍

如果使用Markdown编辑的话，我推荐. 此外，我使用Obsidian中的一些特定语法编辑，如果使用VSCode中的Markdown预览就会出错，例如Obsidian中的Callouts，一种加紧排版的方案：

![[Obsidian-Callouts.gif]]

我可以将Markdown输出为PDF，<u>但是效果仍然很差：LaTeX公式超行、断页、不能编辑</u>，这些都是问题，所以还是建议使用本仓库的人装Obsidian.

一个快速了解Obsidian的方法是，Ctrl + p 打开命令行窗口，然后输出Open sandbox vault，即可了解Obsidian可实现的功能.

# 个人书写习惯

- 在中文环境下使用英文句号，其他符号均使用中文符号；
- 使用bullet或者1.时将使用分号；作为结尾；
- 有时会使用Callouts来加紧笔记排版，不同图标（以及颜色）的Callouts对应不同的笔记形式：

>[!info] 前言

>[!summary] 概念

>[!note] 定理 / 算法

>[!example] 例 / 习题

>[!quote] 引用

- 使用标签标注问题，例如如果我对于某段话不理解，则用标签 #issue 标记，这样之后可以定位，不会流失.