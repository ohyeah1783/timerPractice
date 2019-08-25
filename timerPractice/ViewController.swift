import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel! // outlet: ストーリーボード上のオブジェクトの参照のこと
    
    // タイマーを格納するプロパティ変数
    var timer: Timer!
    
    // タイマー用のための時間変数
    var timer_sec: Float = 0
    
    // override: 親(スーパー)クラスのメソッドの一部を変更して子(サブ)クラスで使いたい時に使う
    override func viewDidLoad() {
        super.viewDidLoad() // アプリの画面上に表示されたときに自動的に呼び出されるメソッド
    }
    
    // selector: #selector(updatetimer(_:)) で指定された関数
    // timeInterval: 0.1, repeats: true で指定された通り、0.1秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer){
        self.timer_sec += 0.1
        self.timerLabel.text = String(format: "%.1f", self.timer_sec)
    }
    // selector指定で呼び出す関数には @objc属性を付与する
    // updateTimer()：0.1 秒毎に呼び出される更新用関数
    // String(format: "%.1f", timer_sec) ：ラベル表示のときに、 x.xという形で小数点第1位までの数字を表示するためのフォーマット設定

    // 再生ボタン
    @IBAction func startTimer(_ sender: Any) {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            // Timer.scheduledTimerでタイマーを作成
            // timeInterval: 何秒毎に更新用関数が始動されるかを決める引数
            // target: 更新用関数が定義されているクラスを指定する
            // target: self ：　ViewController.swift に更新用関数を自作する
            // selector: 更新用関数の名前が指定される
            // #selector(updateTimer(_:)) ：@objc func updateTimer(_ timer: Timer) {...} として作成された更新用関数が timerInterval で指定された秒数毎（今回は 0.1 秒毎）に呼び出される
            // userInfo：タイマーとして渡したい値があれば設定する
            // repeats：は、リピートするかどうか
        }
    }
    
    // 一時停止ボタン
    @IBAction func pauseTimer(_ sender: Any) {
        if self.timer != nil {
            self.timer.invalidate() // タイマーを停止する
            self.timer = nil  // startTimer() の timer == nil で判断するために、 timer = nil としておく
        }
    }
    
    // リセットボタン
    @IBAction func resetTimer(_ sender: Any) {
        // リセットボタンを押すと、タイマーの時間を０に
        self.timer_sec = 0
        self.timerLabel.text = String(format: "%.1f", self.timer_sec)
        
        if self.timer != nil {
            self.timer.invalidate() // タイマーを停止する
            self.timer = nil
        }
    }
    
}

