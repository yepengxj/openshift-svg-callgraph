
run_godepgraph<-function(pkg_prefix,pkg_name,pic_name)
{
  pic_name1<-sub("/","-",pic_name,fixed=T)
  cmd<-sprintf("godepgraph  -s  \"%s/%s\" | dot -Tsvg -o \"%s.svg\" ",
           pkg_prefix,
          pkg_name,
          pic_name1)
  print(cmd)
  print(paste0(pkg_prefix,"/",pkg_name))
  print(pic_name1)
  #cmd <- "ls"
  system(cmd)
}

list_dir<-function(dir_prefix,pkg_prefix,pkg_name,layer=0)
{
  if(layer < 3)
  {
    #file_list<-dir("~/Documents/go_home/src/github.com/openshift/origin",recursive=F,full.name=F)
    file_list<-dir(paste0(dir_prefix,"/",pkg_name),recursive=F,full.name=F)
    
    run_godepgraph(pkg_prefix,pkg_name,sub("/","-",pkg_name,fixed=T))
    
    for(file in file_list)
    {
       #if(file.info("~/Documents/go_home/src/github.com/openshift/origin")[,"isdir"])
      new_pkg_name<-paste0(pkg_name,"/",file)
      file_name<-paste0(dir_prefix,"/",new_pkg_name)
      if(file.info(file_name)[,"isdir"])
      {
        list_dir(dir_prefix, pkg_prefix, new_pkg_name, layer+1)
      }
    }
  }
}

dir("~/Documents/go_home/src/github.com/openshift/origin",recursive=F,full.name=F,)
file.info("~/Documents/go_home/src/github.com/openshift/origin")[,"isdir"]
pkg_prefix<-"github.com/openshift"
depgraph_prefix<-"/Users/yepeng/Documents/godepgraph/origin"
dir_prefix<-"~/Documents/go_home/src/github.com/openshift"

list_dir(dir_prefix, pkg_prefix, "origin", 0)
