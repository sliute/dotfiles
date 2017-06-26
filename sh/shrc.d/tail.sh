tailf() {
  tail -f $@ | awk '/^==> / {a=substr($0, 5, length-8); next} {print a":"$0}'
}
