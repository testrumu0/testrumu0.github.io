$(document).ready(function() {
    
    fullset();
    quickClick();

    const swiper = new Swiper('.swiper', {
          pagination: {
            el: '.swiper-pagination',
            type: 'fraction',
          },
        navigation:{//버튼 사용자 지정
           nextEl: '.swiper-button-next',
           prevEl: '.swiper-button-prev',
        },
          speed: 600,
          spaceBetween: 0,
        });
    
    animateSlideA();
    moveIcon();
    txtLine();
    
});


    function fullset(){//페이지전체 스크롤   
    var pageindex = $("#fullpage > .box").size();//fullpage 내의 섹션 개수 확인
    $("#fullpage .quick ul :first-child").addClass("on");//화면로드시 첫번째 항목에 클래스 적용
    //마우스 휠 이벤트
	$(window).bind("mousewheel", function(event){       
		var page = $(".quick ul li.on");
        var onpage = page.index()+1;
            if(onpage == 2){
                $(".bg_box2").slideDown(2000, 'swing');
            }
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
				alert("감사합니다!");
                
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
   
//퀵버튼 클릭 이동 
function quickClick(){ 
    $(".quick li").click(function(){ 
        var gnbindex = $(this).index()+1; 
        var length=0; 
        for(var i=1; i<(gnbindex); i++) { 
            length+=$(".sec"+i).height(); 
        } 
        if($("body").find("#fullpage:animated").length >= 1) return false; 
        $(this).addClass("on").siblings("li").removeClass("on"); 
        $("#fullpage").animate({"top": -length + "px"},800, "swing"); 
        return false; 
    }); 
}


//AnimateText--HOME    
    function animateSlideA() {//글자 나타남
        var slideA = $(".slide_txt");
        slideA.each(function(i){
             setTimeout(function () {
                slideA.eq(i).addClass("is_visible");
             }, 300*(i+1));              
        });       
   }

//textLine--ABOUT
    function txtLine(){ //마우스 오버 시 text에 밑줄
        $('.about_title').each(function(){
            var b = $(this);
            var b_txt = b.find('span');
            var w = b_txt.width();
            var line = b.find('.b_line');
            b.on('mouseover',function(){
                line.css({"display":"block","width":w});
            });
            b.on('mouseout',function(){
                line.css("display","none");
            }); 
        });
       
    }

//PagePopup--PORTFOLIO
function pagePop(url, i){//매개변수 이미지src,index
    var nm = $('#p_btn'+i).attr('class');
    var url = url;
    var num = i;
//    alert(num);
//    alert(nm);
    if(url==''&&num == 5){//방구석라이프_프로토타입
        var popup = window.open('', '_blank','width=390, height=667, scrollbars=no');
        popup.document.write("<title>"+nm+"</title>");
        popup.document.write("<iframe width='375' height='667' src='https://xd.adobe.com/embed/3d0e9b22-4258-4bc3-9f45-35ea5a3220d1-685d/' frameborder='0' allowfullscreen></iframe>");
    }else{
        var popup = window.open('', '_blank','width=900, height=640, scrollbars=yes');
        popup.document.write("<title>"+nm+"</title>");
        popup.document.write("<img src='"+url+"'>"); 
    }

}

//codePop
function codePop(i){
    var num = i;
    var url_1 = "https://github.com/testrumu0/testrumu0.github.io/tree/master/code/Fingerbook";
    var url_2 = "https://github.com/testrumu0/testrumu0.github.io/tree/master/code/HeyCalendar";
    var win = (i == 1) ? window.open(url_1,'_blank') : window.open(url_2,'_blank');
}

//IconAnimate--SKILLS
    function moveIcon(){//마우스 오버 시 아이콘 이미지 확장자 변경
            $('.icon > li').each(function(){
    			var a = $(this);
    			var img = a.find('img');
                var txt = a.find('p');
                var overtxt = a.find('span').text();
                var origintxt = txt.text();
    			var originsrc = img.attr('src');
    			var oversrc = originsrc.replace('.png','.gif'); 
    			a.on('mouseover', function(){
    				img.attr('src',oversrc);
                    txt.text(overtxt).css('color','#ff7235');
    			});
    			a.on('mouseout', function(){
    				img.attr('src',originsrc);
                    txt.text(origintxt).css('color','#000');
    			});
    		});
        }


/*출처: https://100ah.tistory.com/12 [Hello 100A] FullpageSlide
       https://jineecode.tistory.com/77 Swiper
       https://ddorang-d.tistory.com/55 [도라미도라미] Swiper
       https://wsss.tistory.com/119 AnimateText
        */


        
