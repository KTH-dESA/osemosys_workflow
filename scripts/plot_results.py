import pandas as pd
import seaborn as sns
import sys

sns.set_context("paper")

results = sys.argv[1]
plot_name = sys.argv[2]

data = pd.read_csv(results)
data = data[(data.T != 0).any()]
reshaped = data.melt(id_vars='Technology', var_name='Years', value_name='TotalAnnualCapacity')
plot = sns.relplot(x="Years", y="TotalAnnualCapacity", ci=None, kind="line", 
                   hue='Technology', data=reshaped)
plot.set_xticklabels(reshaped.loc[:,'Years'].unique(), rotation=90)
plot.savefig(plot_name)
