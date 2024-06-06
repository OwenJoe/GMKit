//
//  GMMessageController.swift
//  Gimme
//
//  Created by hule on 2024/5/24.
//

import UIKit

class GMMessageController: GMBaseViewController{
    
    var datas: [GMChatModel] = []
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, navigationBarHeight, ScreenWidth, ScreenHeight - navigationBarHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "GMMessageListCell", bundle: nil), forCellReuseIdentifier: "GMMessageListCellID")
        tableView.backgroundColor = HexString("#101123")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        headerRefresh()
        footerRefresh()
        getListData()
        NotificationCenter.default.addObserver(self, selector: #selector(acceptAndReload), name: Notification.Name(rawValue: "MessageLoadNotic"), object: nil)
    }
    
    //收到通知要刷新列表
   @objc func acceptAndReload()  {
        getListData()
    }

    
    //UI添加
    func setupUI()  {
        self.title = "Message"
        view.addSubview(tableView)
    }
    
    
    //顶部下拉刷新
    func headerRefresh()  {
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.getListData()
            print("下拉刷新更多")
            self?.tableView.reloadData()
            self?.tableView.mj_header?.endRefreshing()
        })
    }
    
   //上拉刷新
    func footerRefresh()  {
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
           print("上拉刷新")
            GMProgressHUD.showError(GMLocalizedString("No more data"))
            self?.tableView.mj_footer?.endRefreshing()
        })
    }

    //外界点击调用
    
    //获取列表数据
    func getListData()   {
        self.datas.removeAll()
        for i in 0..<GMMessageController.getData().count {
            
            for t in 0..<GMMessageController.getData()[i].count {
                
                if t == 0 {
                    datas.append(GMMessageController.getData()[i][0])
                }
            }
        }
        tableView.reloadData()
    }
}


extension  GMMessageController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GMMessageListCellID", for: indexPath) as? GMMessageListCell ?? GMMessageListCell()
        cell.model = datas[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         let cell = tableView.cellForRow(at: indexPath) as? GMMessageListCell
         let chatVc = GMChatController ()
         chatVc.chatTitleStr = cell?.model?.name ?? "Entering..."
         chatVc.datas = GMMessageController.getData()
         chatVc.row = indexPath.row
         self.navigationController?.pushViewController(chatVc, animated: true)

    }
    
    
    //传送整个数据模型到里边
   class func getData() -> [[GMChatModel]] {
        
        //如果没有数据,就初始化一次
        guard let arr: [[GMChatModel]] =  GMStorageManager.shared.getCustomModelArray(forKey: ChatModelArrKey) else {
            
            var oneArr = [GMChatModel]()
            let onePic = "https://img2.baidu.com/it/u=1628103142,1853610686&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=400"
            let oneName = "Lactic_Glow🌠"
            let oneRecent = getQuestionChat()
            let oneTime = "06-01"
            let oneCount = 0
            oneArr.append(contentsOf:
                            [GMChatModel.initModel(recent: oneRecent, messageCount: oneCount, time: oneTime, pic: onePic, name: oneName, content:  getQuestionChat(), type: .other),
                          GMChatModel.initModel(recent: oneRecent, messageCount:oneCount, time: oneTime, pic: onePic, name: oneName, content:  getQuestionChat(), type: .other),
                          GMChatModel.initModel(recent: oneRecent, messageCount: oneCount, time: oneTime, pic: onePic, name:oneName, content:  getQuestionChat(), type: .other),
                          GMChatModel.initModel(recent: "", messageCount: 0, time: "", pic: "", name: "", content: getAnswerData(), type: .mySelf),
                          GMChatModel.initModel(recent: oneRecent, messageCount: oneCount, time: oneTime, pic: onePic, name: oneName, content:  getQuestionChat(), type: .other),
                          GMChatModel.initModel(recent: "", messageCount: 0, time: "", pic: "", name: "", content: getAnswerData(), type: .mySelf),
                          GMChatModel.initModel(recent: oneRecent, messageCount: oneCount, time: oneTime, pic: onePic, name: oneName, content:  getQuestionChat(), type: .other)]
                          )
              
              var twoArr = [GMChatModel]()
              let twoPic = "https://img0.baidu.com/it/u=3984855896,2866376972&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"
              let twoName = "별빛🌟🌟🌟🌟🌟🌟"
              let twoRecent = getQuestionChat()
              let twoTime = "05-17"
              twoArr.append(contentsOf:
                                [GMChatModel.initModel(recent: twoRecent, messageCount: 0, time: twoTime, pic: twoPic, name: twoName, content:  getQuestionChat(), type: .other),
                              GMChatModel.initModel(recent: twoRecent, messageCount: 0, time: twoTime, pic: twoPic, name: twoName, content:  getQuestionChat(), type: .other),
                              GMChatModel.initModel(recent: twoRecent, messageCount: 0, time: twoTime, pic: twoPic, name: twoName, content:  getQuestionChat(), type: .other),
                              GMChatModel.initModel(recent: "", messageCount: 0, time: "", pic: "", name: "", content: getAnswerData(), type: .mySelf),
                              GMChatModel.initModel(recent: twoRecent, messageCount: 0, time: twoTime, pic: twoPic, name: twoName, content:  getQuestionChat(), type: .other),
                              GMChatModel.initModel(recent: "", messageCount: 0, time: "", pic: "", name: "", content: getAnswerData(), type: .mySelf),
                              GMChatModel.initModel(recent: twoRecent, messageCount: 0, time: twoTime, pic: twoPic, name: twoName, content:  getQuestionChat(), type: .other)])
                
              let totalDatas = [oneArr, twoArr]
              GMStorageManager.shared.saveCustomModelArray(array: totalDatas, forKey: ChatModelArrKey)
              return totalDatas
        }

        return arr
    }
    
    //问题
   class func getQuestionChat() -> String {
        let dailyChats: [String] = [
            "Good morning, the weather is nice today!",
            "Have you had breakfast?",
            "Do you have any plans for today?",
            "I just went for a run, it felt great!",
            "Have you seen the latest movie?",
            "I have to work overtime today, I might be home late.",
            "Do you have any restaurant recommendations?",
            "I’ve been learning to bake cakes recently, I’ll let you try next time.",
            "The weather forecast says it will rain today, remember to bring an umbrella.",
            "What’s your favorite season?",
            "I bought a new book yesterday, it’s very interesting.",
            "Have you played the latest game?",
            "I made pasta today, it tastes pretty good.",
            "Do you have any plans for the weekend?",
            "I’ve been trying meditation recently, it feels very relaxing.",
            "Have you been to that new coffee shop?",
            "I have to go to the bank today to handle some things.",
            "What’s your favorite movie genre?",
            "I’ve been learning guitar recently, it feels pretty difficult.",
            "Do you have any TV show recommendations?",
            "I have to go to the supermarket today to buy some things.",
            "What’s your favorite sport?",
            "I’ve been trying a new fitness plan recently.",
            "Have you been to that new restaurant?",
            "I have to go to the library today to return some books.",
            "What’s your favorite music genre?",
            "I’ve been learning to paint recently, it feels very interesting.",
            "Do you have any travel destination recommendations?",
            "I have to go to the post office today to send some things.",
            "What’s your favorite holiday?",
            "I’ve been trying new cooking recipes recently.",
            "Have you been to that new gym?",
            "I have to get my car repaired today.",
            "What’s your favorite color?",
            "I’ve been learning photography recently, it feels very challenging.",
            "Do you have any book recommendations?",
            "I have to go to the pharmacy today to buy some medicine.",
            "What’s your favorite animal?",
            "I’ve been trying new yoga poses recently.",
            "Have you been to that new park?",
            "I have to get a haircut today.",
            "What’s your favorite food?",
            "I’ve been learning programming recently, it feels very useful.",
            "Do you have any website recommendations?",
            "I have to wash my car today.",
            "What’s your favorite drink?",
            "I’ve been trying new dance styles recently.",
            "Have you been to that new bar?",
            "I have to go to the bank today to deposit some money.",
            "Who’s your favorite TV show character?",
            "I’ve been learning to make sushi recently, it feels very interesting.",
            "Do you have any travel route recommendations?",
            "I have to go to the pet store today to have a look.",
            "The sun is shining, it's a perfect day for outdoor activities!",
            "Yes, I had a nutritious breakfast this morning.",
            "I'm planning to meet some friends for lunch.",
            "I just finished a challenging workout, feeling accomplished!",
            "No, I haven't had the chance to watch it yet.",
            "I have a meeting later, so I'll be busy.",
            "There's a new Thai restaurant that opened recently, it's fantastic!",
            "Sure, I'll be happy to taste your delicious cakes.",
            "Thanks for the reminder, I'll grab my umbrella before leaving.",
            "I love the colorful leaves in autumn.",
            "I'm reading a fantasy novel, it's captivating!",
            "Not yet, but it's on my list.",
            "I made a salad for lunch, it's light and refreshing.",
            "I'm planning to relax and catch up on some shows.",
            "I find yoga to be a great way to unwind and destress.",
            "Yes, it's a cozy coffee shop with a great atmosphere.",
            "I need to visit the bank to withdraw some cash.",
            "I enjoy a variety of movie genres, but I'm a fan of thrillers.",
            "Learning guitar can be challenging, but it's rewarding.",
            "I recently watched 'Breaking Bad' and highly recommend it!",
            "I need to restock my pantry, so I'll be heading to the supermarket.",
            "I love watching and playing basketball.",
            "The new fitness plan I'm following has been really effective.",
            "Yes, it's a new Italian restaurant that has amazing pizza.",
            "I need to return some books to the library before they're due.",
            "I listen to a mix of genres, but I enjoy rock music the most.",
            "Painting allows me to unleash my creativity and express myself.",
            "I'm planning a trip to Europe. Any recommendations?",
            "I have some documents to mail, so I'll stop by the post office.",
            "Christmas is my favorite holiday because of the festive spirit.",
            "I've been experimenting with new recipes and discovering new flavors.",
            "Yes, it's a modern gym with state-of-the-art equipment.",
            "I need to take my car to the mechanic for a check-up.",
            "Blue is my favorite color because it's calming and peaceful.",
            "Photography is a passion of mine. I love capturing moments.",
            "Have you read 'The Great Gatsby'? It's a classic.",
            "I need to pick up some medications from the pharmacy.",
            "I'm a dog person. I love their loyalty and companionship.",
            "I've been practicing advanced yoga poses to challenge myself.",
            "Yes, it's a beautiful park with walking trails and a lake.",
            "I'm planning to get a new hairstyle. Any suggestions?",
            "I enjoy trying different cuisines, but Italian food is my favorite.",
            "Programming opens up endless possibilities and empowers creativity.",
            "Sure, what kind of websites are you interested in? News, entertainment, or educational?",
            "I need to give my car a thorough wash and clean.",
            "I can't start my day without a cup of coffee.",
            "Dancing is a great way to express yourself and let loose.",
            "No, I haven't been to that bar yet. Is it good?",
            "I need to deposit some money at the bank before it closes.",
            "I have so many favorite TV show characters, but one of them is Michael Scott from 'The Office'.",
            "Making sushi requires precision, but the end result is worth it.",
            "I'm planning a road trip soon. Any suggestions for the route?",
            "I want to visit the pet store to adopt a new furry friend.",
            
            // 以下是填充的对话（47条）
            "I love going for walks in the park in the morning.",
            "Yes, I had a nutritious and delicious breakfast this morning.",
            "I'm thinking of going to the beach this weekend.",
            "That's a great way to stay active and enjoy nature!",
            "No, I haven't had the chance to watch it yet.",
            "Take care and have a great day!",
            "Definitely! There's a new sushi restaurant that just opened.",
            "I would be happy to try your homemade cakes!",
            "Thanks for the reminder. I'll bring an umbrella with me.",
            "I love the vibrant colors of spring.",
            "I'm currently reading a thrilling mystery novel.",
            "Not yet, but I'll check it out soon.",
            "That's fantastic! I love pasta.",
            "I'm planning to relax and spend time with family and friends.",
            "Meditation has been a great way to reduce stress and increase mindfulness.",
            "Yes, it's a cozy coffee shop with a great atmosphere.",
            "Good luck with your errands at the bank!",
            "I enjoy a wide range of movie genres, but I'm a fan of romantic comedies.",
            "Keep practicing, and you'll improve!",
            "Yes, 'Stranger Things' is one of the best shows I've watched recently.",
            "Don't forget to make a shopping list before going to the supermarket.",
            "I'm a fan of basketball. It's an exciting sport to watch.",
            "Staying fit and active is important. Keep up the good work!",
            "I haven't had the chance to play it yet, but I've heard great things about it.",
            "Enjoy your time at the library. It's a peaceful place to read and explore new books.",
            "I enjoy listening to a variety of music genres, from pop to classical.",
            "Painting allows me to express my creativity and emotions.",
            "Have you ever been to Japan? It's an amazing travel destination.",
            "Don't forget to bring your packages and important documents to the post office.",
            "Christmas is my favorite holiday. I love the festive decorations and spending time with loved ones.",
            "Trying out new recipes is always fun and exciting.",
            "No, I haven't been there yet. Is it worth visiting?",
            "Car maintenance is important to keep your vehicle in good condition.",
            "My favorite color is blue. It's calming and represents tranquility.",
            "Photography is a wonderful way to capture moments and create memories.",
            "Sure, what genre of music do you prefer? Pop, rock, classical, or something else?",
            "Wishing you a speedy recovery. Take care and get well soon!",
            "I'm a cat person. They're independent and adorable.",
            "Yoga is a great way to improve flexibility and find inner peace.",
            "Yes, it's a beautiful park with walking trails and a lake.",
            "I hope you get a stylish and trendy haircut that suits you!",
            "I love trying different cuisines from around the world. What's your favorite?",
            "Programming is a valuable skill in today's digital age. Keep up the good work!",
            "Sure, what kind of websites are you interested in? News, entertainment, or educational?",
            "A clean car is always a pleasure to drive.",
            "I enjoy a cup of coffee in the morning. How about you?",
            "Dancing is a great way to express yourself and have fun.",
            "I haven't been there yet, but I've heard great things about it.",
            "Wishing you a smooth visit to the bank.",
            "I have so many favorite TV show characters, but one of them is Jon Snow from 'Game of Thrones'.",
            "Sushi-making requires precision and creativity. It's a fascinating skill to learn.",
            "Where are you planning to travel? I can recommend some amazing destinations.",
            "Enjoy your time at the pet store. There are so many adorable pets to see!",
        ]

        let randomIndex = Int(arc4random_uniform(UInt32(dailyChats.count)))
        return dailyChats[randomIndex]
    }

    
    //回答
  class  func getAnswerData() -> String {
    
        let answers: [String] = [
            "Yes, it is a beautiful day!",
            "Yes, I had a delicious breakfast.",
            "No, I don't have any plans yet.",
            "That sounds refreshing!",
            "No, I haven't seen it yet.",
            "That's too bad. Take care!",
            "Sure, there's a great Italian restaurant nearby.",
            "I would love to try your cakes!",
            "Thanks for the reminder!",
            "I love all seasons, but autumn is my favorite.",
            "What book is it? I'm curious!",
            "Not yet, but I'll check it out.",
            "I'm glad you enjoyed it!",
            "I'm planning to relax and spend time with family.",
            "Meditation is a great way to unwind.",
            "Yes, it's a cozy place with delicious coffee.",
            "Good luck at the bank!",
            "I enjoy various genres, but I love action movies.",
            "Keep practicing, you'll get better!",
            "Have you watched 'Stranger Things'? It's amazing!",
            "Remember to buy your essentials!",
            "I enjoy watching and playing tennis.",
            "Fitness is important. Keep up the good work!",
            "Not yet, but I'll check it out soon.",
            "Have fun at the library!",
            "I have a diverse taste in music, but I love rock.",
            "Painting can be a wonderful form of expression.",
            "What's your favorite travel destination?",
            "Don't forget your important errands!",
            "I love the holiday season, especially Christmas.",
            "Exploring new recipes is always fun!",
            "No, not yet. Is it worth visiting?",
            "Car maintenance is important. Stay safe!",
            "My favorite color is blue. What about you?",
            "Photography is an amazing hobby. Enjoy it!",
            "Sure, what genre do you prefer?",
            "Take care of your health. Get well soon!",
            "Dogs are my favorite animals. What about you?",
            "Yoga is a great way to stay fit and calm the mind.",
            "I haven't been there yet. Is it nice?",
            "I hope you get a stylish haircut!",
            "I love trying different cuisines. What's your favorite?",
            "Programming is a valuable skill. Keep it up!",
            "Sure, what kind of websites are you interested in?",
            "A clean car is always nice!",
            "My favorite drink is coffee. How about you?",
            "Dancing is a great way to express yourself!",
            "I haven't been there yet. Is it a good place?",
            "Have a smooth transaction at the bank!",
            "I have so many favorite TV show characters!",
            "Sushi-making sounds like a fun skill to learn.",
            "I'm planning a trip soon. Any recommendations?",
            "Have a great time at the pet store!",
            "I enjoy going for walks in the park.",
            "Yes, I just finished a delicious meal.",
            "I'm thinking of going for a hike this weekend.",
            "That's a great way to stay active!",
            "No, I haven't had a chance to watch it yet.",
            "Take care and stay safe!",
            "Absolutely! There's a new Mexican restaurant that opened recently.",
            "I'll be happy to taste your cakes!",
            "Thanks for the reminder. I'll make sure to bring an umbrella.",
            "I love the vibrant colors of spring.",
            "I'm currently reading a sci-fi novel, it's really captivating.",
            "I haven't had the chance to play it, but I've heard good things.",
            "That's wonderful! Cooking is a great skill to have.",
            "I'm planning to relax and catch up on some reading.",
            "Meditation has been a game-changer for me.",
            "Yes, it's a cozy little place with a great ambiance.",
            "I hope everything goes smoothly at the bank for you.",
            "I enjoy a wide range of genres, but I'm a fan of romantic comedies.",
            "Keep practicing and you'll improve in no time!",
            "Yes, 'Stranger Things' is one of my all-time favorites!",
            "Don't forget to make a shopping list before going to the supermarket.",
            "I'm a big fan of basketball. What's your favorite sport?",
            "Staying fit and active is important. Keep up the good work!",
            "I haven't had the chance to watch it, but I'll add it to my list.",
            "Enjoy your time at the library!",
            "I enjoy listening to classical music and jazz.",
            "Painting is a great way to express your creativity.",
            "Have you ever been to Japan? It's an incredible travel destination.",
            "Don't forget to bring your ID when going to the post office.",
            "I love the festive atmosphere during the holiday season.",
            "Trying out new recipes is always exciting!",
            "No, I haven't been there yet. Is it worth visiting?",
            "Car maintenance is essential for a smooth driving experience.",
            "My favorite color is green because it represents nature and tranquility.",
            "Photography allows you to capture beautiful moments and memories.",
            "Sure, what kind of music do you enjoy? Pop, rock, or classical?",
            "Wishing you a speedy recovery!",
            "I have a soft spot for cats. They're so adorable.",
            "Yoga is a great way to improve flexibility and find inner peace.",
            "Yes, it's a lovely park with beautiful scenery.",
            "I hope you get a stylish and trendy haircut!",
            "I'm a fan of Italian cuisine, especially pizza and pasta.",
            "Programming opens up endless possibilities. Keep up the good work!",
            "Sure, what are you interested in? News, entertainment, or something else?",
            "A clean and shiny car always feels great.",
            "I enjoy a cup of tea in the morning. How about you?",
            "Dancing allows you to express yourself and let loose.",
            "I haven't been there yet, but I've heard great things about it.",
            "Wishing you a hassle-free visit to the bank!",
            "I have so many favorite characters, but one of them is Sherlock Holmes.",
            "Sushi-making is a skill that requires precision and creativity.",
            "Where are you planning to travel? I can provide some recommendations.",
            "Have a wonderful time exploring the pet store!",
            "I love going for picnics in the park.",
            "Yes, I had a healthy and delicious breakfast.",
            "I'm thinking of going to the beach this weekend.",
            "That's a great way to stay active and fit!",
            "No, I haven't had a chance to watch it yet.",
            "Take care and have a great day!",
            "Definitely! There's a new Chinese restaurant that opened recently.",
            "I can't wait to taste your delicious cakes!",
            "Thanks for reminding me. I'll bring an umbrella with me.",
            "I love the warmth and beauty of summer.",
            "I'm currently reading a thrilling mystery novel.",
            "Not yet, but I've heard it's a must-watch.",
            "That's fantastic! I love pasta.",
            "I'm planning to spend time with friends and family.",
            "Meditation has helped me reduce stress and improve focus.",
            "Yes, it's a charming cafe with a cozy atmosphere.",
            "Wishing you a successful visit to the bank.",
            "Action movies are my favorite, especially the ones with intense fight scenes.",
            "Keep practicing, and you'll see improvement.",
            "Yes, 'Stranger Things' is one of the best TV shows I've seen.",
            "Don't forget to buy some fresh fruits and vegetables.",
            "I enjoy playing soccer. It's a fast-paced and exciting sport.",
            "Staying active is important for a healthy lifestyle. Keep it up!",
            "I haven't had the chance to play it, but I've heard great things about it.",
            "Enjoy your time at the library. It's a peaceful place to read and study.",
            "I enjoy listening to a wide range of music genres, from pop to classical.",
            "Painting is a great way to relax and express creativity.",
            "Have you ever been to Paris? It's a dream travel destination for many.",
            "Don't forget to bring your package and necessary documents to the post office.",
            "Christmas is my favorite holiday. I love the festive decorations and the joy in the air.",
            "Trying out new recipes is a fun and delicious adventure.",
            "No, I haven't been there yet. Is it a popular spot?",
            "Car maintenance is important to keep your vehicle in good condition.",
            "My favorite color is purple because it symbolizes creativity and spirituality.",
            "Photography is a wonderful way to capture memories and express yourself.",
            "Sure, what kind of music do you enjoy? Pop, rock, classical, or something else?",
            "Wishing you a speedy recovery. Take care and get well soon!",
            "I'm a dog person. They are loyal and bring so much joy.",
            "Yoga is a great way to improve flexibility and find inner peace.",
            "Yes, it's a beautiful park with plenty of green spaces.",
            "I hope you get a fantastic haircut that suits you perfectly!",
            "I'm a foodie, and I enjoy trying different cuisines from around the world.",
            "Programming is a valuable skill in today's digital age. Keep up the good work!",
            "Sure, what type of websites are you interested in? News, entertainment, or educational?",
            "A clean car is always a pleasure to drive.",
            "I enjoy a cup of coffee in the morning. How about you?",
            "Dancing is a great way to express yourself and have fun.",
            "I haven't been there yet, but I've heard great things about it.",
            "Wishing you a smooth visit to the bank.",
            "I have so many favorite TV show characters, but one of them is Tyrion Lannister from 'Game of Thrones'.",
            "Sushi-making is an art form. It requires skill and attention to detail.",
            "Where are you planning to travel? I can recommend some amazing places.",
            "Enjoy your time at the pet store. There are so many adorable pets to see!",
            "I enjoy going for a jog in the morning.",
            "Yes, I had a healthy and nutritious breakfast.",
            "I'm planning to visit a museum this weekend.",
            "That's a great way to stay fit and active!",
            "No, I haven't had a chance to watch it yet.",
            "Take care and have a wonderful day!",
            "Definitely! There's a new sushi restaurant that just opened.",
            "I can't wait to try your homemade cakes!",
            "Thanks for reminding me. I'll bring an umbrella just in case.",
            "I love the cozy and festive atmosphere during winter.",
            "I'm currently reading a thought-provoking non-fiction book.",
            "Not yet, but I've heard great things about it.",
            "That's amazing! I enjoy cooking too.",
            "I'm planning to catch up on my favorite TV series.",
            "Meditation helps me relax and focus on the present moment.",
            "Yes, it's a charming coffee shop with excellent coffee and pastries.",
            "Wishing you a successful visit to the bank.",
            "I enjoy a wide range of movie genres, but I'm a fan of romantic comedies.",
            "Keep practicing, and you'll improve your skills.",
            "Yes, 'Stranger Things' is one of the best shows I've seen recently.",
            "Don't forget to buy some groceries for the week.",
            "I'm a fan of basketball. It's an exciting sport to watch.",
            "Staying active is important for a healthy lifestyle. Keep it up!",
            "I haven't had the chance to play it yet, but I've heard it's fantastic.",
            "Enjoy your time at the library. It's a peaceful place to study and explore new books.",
            "I enjoy listening to a variety of music genres, from classical to hip-hop.",
            "Painting allows me to express my emotions and creativity.",
            "Have you ever been to the Maldives? It's a stunning travel destination.",
            "Don't forget to bring your ID when going to the post office.",
            "Christmas is my favorite holiday. I love the festive decorations and spending time with family.",
            "Trying out new recipes is always exciting. What's your favorite dish to cook?",
            "No, I haven't been there yet. Is it worth visiting?",
            "Car maintenance is essential for a smooth and safe driving experience.",
            "My favorite color is yellow because it represents happiness and positivity.",
            "Photography is a great way to capture and preserve memories.",
            "Sure, what genre of music do you prefer? Pop, rock, classical, or something else?",
            "Wishing you a fast recovery and good health!",
            "I'm a dog person. They're loyal and bring so much joy to our lives.",
            "Yoga is a wonderful way to relax the mind and strengthen the body.",
            "Yes, it's a beautiful park with a serene atmosphere.",
            "I hope you get a haircut that makes you feel confident and stylish!",
            "I love trying different cuisines from around the world. What's your favorite?",
            "Programming is a valuable skill in today's digital world. Keep up the good work!",
            "Sure, what kind of websites are you interested in? News, entertainment, or educational?",
            "A clean car is always a pleasure to drive.",
            "I enjoy a cup of tea in the morning. How about you?",
            "Dancing is a great way to express yourself and have fun.",
            "I haven't been there yet, but I've heard great things about it.",
            "Wishing you a smooth visit to the bank.",
            "I have so many favorite TV show characters, but one of them is Jon Snow from 'Game of Thrones'.",
            "Sushi-making requires precision and creativity. It's a fascinating skill to learn.",
            "Where are you planning to travel? I can recommend some amazing destinations.",
            "Enjoy your time at the pet store. There are so many cute and adorable animals to see!",
        ]

        let str = answers.randomElement()
        return str ?? ""
    }
}
