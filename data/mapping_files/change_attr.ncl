
    ;;..............................................................................
    ;; change attribute
    ;;..............................................................................
    load "/qfs/people/zhan524/.conda/envs/mylib/lib/ncarg/nclscripts/csm/contributed.ncl"

    begin

       filename = getenv("filename")

       fna = filename

       print("input files : "+fna)

       fla = addfile(fna,"w")

    ;;..............................................................................
    ;; create global attributes of the file
    ;;..............................................................................
       fAtt               = True            ; assign file attributes
       fAtt@author        = "Kai Zhang (kai.zhang@pnnl.gov)"
       fAtt@note          = "Source grid: T170"
       fAtt@history       = systemfunc ("date")
       fileattdef( fla, fAtt )            ; copy file attributes

    end

