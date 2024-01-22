# Objects

## Series

```Python
## create Series
obj = pd.Series([1,9,1,9], index = ['a','b','c','u'])
# or using dictionaries
obj = {'a':1, 'b':9, 'c':1, 'd':9}

obj.values
obj.index

# change the index
obj.index = ['index0', 'index1', ...]

# name the series
obj.name = 'obj_name'
# name the index of the series
obj.index.name = 'index_name'

obj[['a', 'b']]
obj[obj > 8] # index by boolean

# treat series as a set-length ordered dictionary
'b' in obj # search in the keys (indices)

## operation on series
obj * 2
np.exp(obj)
# apply a function elementwise
def tss(ele):
	return ele ** 2 - 1 
obj.apply(tss)

```

## Data Frames

```python
df.columns
df.loc["col_name1", "col_name2", ...]
# for multi-level index
df.loc[[('col_name0', 'col_name10'), ('col_name2', 'col_name21')]]

## deal with index
df.index
df.set_index("index_name")
df.reset_index() # remove the index
df.reset_index(drop=True) # discard the index
# sort index by some properties
df.sort_index(level=["property1", "property2", ...], ascending=[True, False])

## filtering
filter_list = ['identity1', 'identity2', ...]
df[df['property'].isin(filter_list)]


## opearations
# drop column
df.drop("column", axis=1)
# drop row
df.drop([0,1], axis=0)
```


# Commons

## Missing Valuse

```python
# Null value
obj = pd.Series({'a':1, 'b':NaN})

pd.isnull(obj) # obj.isnull()
pd.notnull(obj) # obj.notnull()
# null's propogation
pd.isnull(obj) / obj.shape[0]
```