Foundation URI					:Unique identifier for the entity that will not change 
Linearization (release) URI		:Unique identifier for this version of the classification. It includes the linearization name such as MMS and minor version idetifier such as 2018 in it
Code							:ICD-11 code for the entity. Note that the groupings do not have a code.
BlockId							:Identifier for high level groupings that do not bear a code
Title							:Title of the entity
ClassKind						:One of the three (chapter, block, category)
									Chapter is top level classification entities
									Blocks are high level groupings that do not bear a code
									Categories are entities that has a code
DepthInKind						:Depth of within the Class Kind. For example, a category with depthinkind=2 means it is category whose parent is also a category bu grand parent is not
IsResidual						:true if the entity is a residual category (i.e. other specified or unspecified categories)
ChapterNo						:The chapter that the entity is in
BrowserLink						:Direct link to this entity in ICD-11 browser.
IsLeaf							:true if this entity does not have any children
Primary Tabulation:
GroupingX					    :Groupings that the entity is included in
