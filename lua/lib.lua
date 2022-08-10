Lib = {}
Lib.Table = {}

function Lib.Table.extend(t1,t2)
   for k, v in pairs(t2) do
      t1[k] = v
   end
   return t1
end
