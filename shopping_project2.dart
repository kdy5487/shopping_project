import './shopping_project2.dart' as shopping_project;
import 'dart:io'; //사용자의 입력을 받는 라이브러리

//도전 과제
class Product {
  //상품을 정의하는 'product'클래스
  //속성 2개

  String name; //상품 이름
  int price; // 상품 1개당 가격

  Product(this.name, this.price); //매개변수 생성자, this 필수
}

class ShoppingMall {
  //쇼핑몰을 정의하는 'shoppingmall'클래스
  //속성 2개
  List<Product> products = [
    //'product'객체를 리스트: 판매하는 상품 목록 5개
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];
  List<Product> cart = []; //장바구니 리스트
  int total = 0; //장바구니에 담은 상품들의 총 가격

  //메서드 3개
  //네임드 생성자

  void showProducts() {
    // 1) 상품 목록을 출력하는 메서드
    for (var product in products) {
      //products list의 요소를 순회하니까 for-in 사용
      print('${product.name} / ${product.price}원'); //하나씩 상품 목록 출력
    }
  }

  void addToCart() {
    // 2) 상품을 장바구니에 담는 메서드
    // 상품이름과 상품갯수 입력 받기.
    print('상품 이름을 입력해 주세요 !');
    String? productName = stdin.readLineSync(); //상품 이름 입력받기(string)
    print('상품 갯수를 입력해 주세요 !');
    String? numberOfProduct =
        stdin.readLineSync(); //상품 갯수 입력받기(string) << int로 바꿔줄 필요 있음.

    //예외처리 및 int 변환
    int numberOfProductInt;
    try {
      numberOfProductInt = int.parse(numberOfProduct!); //string >> int
    } catch (e) {
      print('입력값이 올바르지 않아요 !');
      return;
    }
    //any를 통해 입력값과 상품이 일치하는 것이 있는지 확인.
    //일치하면 실행하도록 bool변수 선언.
    bool containproduct = products.any(
      (Product) => Product.name == productName,
    );

    if (containproduct && (numberOfProductInt > 0)) {
      //제품을 정확히 입력했고, 1개이상의 갯수를 입력한 경우 상품이 담김

      print('장바구니에 상품이 담겼어요 !');
    } else if (!containproduct) {
      //제품 불일치
      //입력시 띄어쓰기 주의...
      print('입력값이 올바르지 않아요 !');
      return;
    } else if (numberOfProductInt <= 0) {
      //갯수는 1개이상의 정수만 가능
      print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
      return;
    }

    //상품 객체 가져오기 (firstWhere 사용해서 입력값과 같은 상품 저장하기)
    Product selectedProduct = products.firstWhere(
      (product) => product.name == productName,
    );
    for (int i = 0; i < numberOfProductInt; i++) {
      cart.add(selectedProduct); //입력한 갯수만큼 장바구니에 추가
    }
    total += selectedProduct.price * numberOfProductInt; //총 가격
  }

  void showTotal() {
    // 3) 장바구니에 담은 상품의 목록과 총 가격을 출력하는 메서드
    if (cart.isEmpty) {
      //cart(장바구니)가 비었으면 출력
      print('장바구니에 담긴 상품이 없습니다.');
      return;
    }

    // 각 상품별 개수 저장
    List<String> summary = []; //상품별 갯수 정보 저장할 리스트
    List<String> countedProducts = []; //중복방지를 위한 카운트된 제품 갯수

    for (var product in cart) {
      // 중복 확인 후 없으면 추가
      if (!countedProducts.contains(product.name)) {
        //첫 상품인가?
        int count =
            cart.where((p) => p.name == product.name).length; //동일 상품 갯수 세기

        summary.add('${product.name} ${count}개'); //상품이름 + 갯수
        countedProducts.add(product.name); //중복방지
      }
    }

    // join을 사용해 문자열 합치기
    print('장바구니에 ${summary.join(', ')} 총 $total원이 담겨져 있네요.');
  }

  void clearCart() {
    if (cart.isEmpty) {
      //cart장바구니가 비어있으면 출력, total == 0도 될듯
      print('이미 장바구니가 비어있습니다.');
    } else {
      //
      cart.clear(); //카트 초기화
      total = 0; //가격도 초기화
      print('장바구니를 초기화합니다');
    }
  }
}

//메인 함수
void main() {
  ShoppingMall mall = ShoppingMall(); //클래스의 메서드를 호출
  bool isRunning = true;
  while (isRunning) {
    //프로그램 항상 실행하도록 함.
    print(
      "[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품 목록과 총 가격 보기 / [4] 프로그램 종료 / [5] 종료 재확인 / [6] 장바구니 초기화",
    );
    String? input = stdin.readLineSync(); //사용자 입력 받기
    // 특정 값에 대한 경우를 한번에 처리하므로 switch를 통해 사용자의 입력 처리
    switch (input) {
      case "1":
        mall.showProducts(); // 상품 목록 보기
        break;

      case "2":
        mall.addToCart(); //장바구니 담기
        break;

      case "3":
        mall.showTotal(); //장바구니에 담긴 상품의 총 가격보기
        break;

      case "4": //프로그램 종료
        print('정말 종료하시겠습니까? [5]를 누르면 종료됩니다.');

        String? inputAgain = stdin.readLineSync(); //종료할 것인지 한번 더 물어보기
        if (inputAgain == '5') {
          print('이용해 주셔서 감사합니다 ~ 안녕히가세요!');
          isRunning = false; // 거짓을 통해 반복문 탈출
        } else {
          print('종료하지 않습니다.');
          break;
        }
      case "6": //장바구니를 초기화할 수 있는 기능
        mall.clearCart();

      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}
