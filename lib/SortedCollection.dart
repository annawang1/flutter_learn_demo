typedef Compare = int Function(Object a, Object b);

class SortedCollection {
  Compare compare;

  SortedCollection(this.compare);

}

//class SortedCollection {
//  Function compare;
//
//  SortedCollection(int f(Object a, Object b)) {
//    compare = f;
//  }
//}

int sort(Object a, Object b) => 0;

void main() {
  SortedCollection coll = SortedCollection(sort);

  if (coll.compare is Function) {
    print('coll.compare is Function');
  }
}
