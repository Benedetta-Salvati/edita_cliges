teiphy -t graphemic - morphologic -m ?? --no-fill-correctors --fragmentary-threshold 0.4 --drop-constant --clock local --ancestral-logger state --seed 42 --format beast --show-completion


teiphy data/cliges_unified_fixed_unique_listRels.xml data/cliges_unified_fixed_unique_beast.xml --no-fill-correctors --fragmentary-threshold 0.4 --no-drop-constant --clock strict --ancestral-logger state --seed 42 --format beast

teiphy data/cliges_unified_fixed_unique_listRels.xml data/cliges_unified_fixed_unique_beast.xml --no-fill-correctors --fragmentary-threshold 0.4 --no-drop-constant --clock uncorrelated --ancestral-logger state --seed 42 --format beast