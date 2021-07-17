$(document).ready(function() {
    
    fullset();

    const slide = new Swiper('#newSwiper', swiperSetting);
    
});


    function fullset(){    
    var pageindex = $("#fullpage > .box").size();//fullpage 내의 섹션 개수 확인
    $("#fullpage .quick ul :first-child").addClass("on");//화면로드시 첫번째 항목에 클래스 적용
    var is_action = true;
    //마우스 휠 이벤트
	$(window).bind("mousewheel", function(event){       
		var page = $(".quick ul li.on");
        var onpage = page.index()+1;              
                if(onpage == 2 && is_action){
                   var bar = setTimeout(function(){ 
                    tag(1,0.7);
                    tag(2,0.5); 
                    tag(3,0.6); 
                    tag(4,0.7); 
                    tag(5,0.5); 
                    tag(6,0.5); 
                }, 0);  
                is_action = false;
            }//sklls페이지에서만 tag함수 한번만 동작       
		//alert(page.index()+1);  // 현재 on 되어있는 페이지 번호
		if($("body").find("#fullpage:animated").length >= 1) return false;
		//마우스 휠을 위로
		if(event.originalEvent.wheelDelta >= 0) {
			var before = page.index();
			if(page.index() >= 0) page.prev().addClass("on").siblings(".on").removeClass("on");//퀵버튼옮기기
            if(onpage <= 5){//sec5에서만 글자색 변경
                document.getElementById('quick').style.color="#000";
            }else{
                document.getElementById('quick').style.color="#fff";
            }
			var pagelength = 0;
			for(var i=1; i<(before); i++)
			{
				pagelength += $(".sec"+i).height();

			}
			if(page.index() > 0){ //첫번째 페이지가 아닐때 (index는 0부터 시작임)
				page=page.index()-1;
				$("#fullpage").animate({"top": -pagelength + "px"},1000, "swing");
			}else{
				alert("첫번째페이지 입니다.");
			}	
		}else{ // 마우스 휠을 아래로
            
			var nextPage=parseInt(page.index()+1); //다음페이지번호
			var lastPageNum=parseInt($(".quick ul li").size()); //마지막 페이지번호
			//현재페이지번호 <= (마지막 페이지 번호 - 1)
			//이럴때 퀵버튼옮기기


			if(page.index() <= $(".quick ul li").size()-1){ 
				page.next().addClass("on").siblings(".on").removeClass("on");
			}
			if(onpage == 4 || onpage == 5){//sec5에서만 글자색 변경
                document.getElementById('quick').style.color="#fff";
            }else{
                document.getElementById('quick').style.color="#000";
            }
			if(nextPage < lastPageNum){ //마지막 페이지가 아닐때만 animate !
				var pagelength=0;
				for(var i = 1; i<(nextPage+1); i++){ 
					//총 페이지 길이 구하기
					//ex) 현재 1번페이지에서 2번페이지로 내려갈때는 1번페이지 길이 + 2번페이지 길이가 더해짐
					pagelength += $(".sec"+i).height();
				}
				$("#fullpage").animate({"top": -pagelength + "px"},1000, "swing");
			}
			else{ // 현재 마지막 페이지 일때는
				alert("마지막 페이지 입니다!");
                
			};		
			
		}
	});
	$(window).resize(function(){ 
		//페이지가 100%이기때문에 브라우저가 resize 될때마다 스크롤 위치가 그대로 남아있는것을 방지하기 위해
		var resizeindex = $(".quick ul li.on").index()+1;
		
		var pagelength=0;
		for(var i = 1; i<resizeindex; i++){ 
			//총 페이지 길이 구하기
			//ex) 현재 1번페이지에서 2번페이지로 내려갈때는 1번페이지 길이 + 2번페이지 길이가 더해짐
			pagelength += $(".sec"+i).height();
		}

		$("#fullpage").animate({"top": -pagelength + "px"},0);
	});
    
  }//ENDfullset
 

//progressBar
    function tag(num,endValue){//num,endValue매개변수추가
        var progressbar = $('#progress'+num),//제어
        max = progressbar.attr('max'),
        time = (1000/max)*4,
        end = max*endValue,//제어
        value = progressbar.val();

      var loading = function() {
          value += 1;
          addValue = progressbar.val(value);

          $('.progress-value').html(value + '%');

          if (value == end) {
              clearInterval(animate);
          }
        
      }

      var animate = setInterval(function() {
          loading();       
      }, time);
        

    }//END progressBar    

    //SwiperSetting
   var swiperSetting = {
      slidesPerView: 'auto',
      pagination : {
          el : '.swiper-pagination',
          type:"fraction",
      },
       navigation: {   // 버튼 사용자 지정
	   nextEl: '.swiper-button-next',
	   prevEl: '.swiper-button-prev',
      },
//      centeredSlides: true,
//      loop: true,
//      loopedSlides: 2,
      spaceBetween : 37,
      slidesOffsetBefore : 20, // 슬라이드 시작 부분 여백
      slidesOffsetAfter : 20, // 슬라이드 시작 부분 여백
   } 



/*출처: https://100ah.tistory.com/12 [Hello 100A]
       https://jineecode.tistory.com/77
       https://ddorang-d.tistory.com/55 [도라미도라미] */


        
