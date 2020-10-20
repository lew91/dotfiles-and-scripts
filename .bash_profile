
export PATH
export CLICOLOR=1
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"

# cuda
export CUDA_HOME=/usr/local/cuda 
export DYLD_LIBRARY_PATH="$CUDA_HOME/lib:$CUDA_HOME/extras/CUPTI/lib"
export LD_LIBRARY_PATH=$DYLD_LIBRARY_PATH 
export PATH=$DYLD_LIBRARY_PATH:$PATH 
export PATH="$CUDA_HOME/bin:$PATH"
# export flags="--config=cuda --config=opt"

#Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH

export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"


# Proxy
export ALL_PROXY=socks5://127.0.0.1:7891
