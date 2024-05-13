class Janken
  def initialize
    @hands = ["グー", "パー", "チョキ"]
    @directions = ["上", "下", "左", "右"]
  end

  def play
    puts "じゃんけんを始めます！"
    puts "自分の手を選んでください（0:グー, 1:パー, 2:チョキ）："
    player_hand_input = gets.chomp

    unless player_hand_input.match?(/^\d+$/)
      puts "0~2の数字を入力してください。"
      play
      return
    end

    player_hand_index = player_hand_input.to_i

    unless (0..2).include?(player_hand_index)
      puts "0~2の数字を入力してください。"
      play
      return
    end

    player_hand = @hands[player_hand_index]
    computer_hand = @hands.sample
    puts "自分の手：#{player_hand}"
    puts "コンピュータの手：#{computer_hand}"

    result = judge(player_hand, computer_hand)

    if result == :draw
      puts "あいこです！"
      play
    else
      announce_winner(result, player_hand, computer_hand)
    end
  end

  private

  def judge(player_hand, computer_hand)
    if player_hand == computer_hand
      :draw
    elsif (player_hand == "グー" && computer_hand == "チョキ") ||
          (player_hand == "チョキ" && computer_hand == "パー") ||
          (player_hand == "パー" && computer_hand == "グー")
      :win
    else
      :lose
    end
  end

  def announce_winner(result, player_hand, computer_hand)
    case result
    when :win
      puts "あなたの勝ちです！"
      acci_muki_hoi(player_hand, computer_hand, "あなた")
    when :lose
      puts "あなたの負けです…"
      acci_muki_hoi(computer_hand, player_hand, "コンピュータ")
    end
  end

  def acci_muki_hoi(winner_hand, loser_hand, winner_name)
    puts "#{winner_name}が勝者です！"
    puts "#{loser_hand}を出した方はあっち向いて〜"
    puts "どちらかの方向を選んでください（0:上, 1:下, 2:左, 3:右）："
    winner_direction_input = gets.chomp

    unless winner_direction_input.match?(/^\d+$/)
      puts "0~3の数字を入力してください。"
      acci_muki_hoi(winner_hand, loser_hand, winner_name)
      return
    end

    winner_direction_index = winner_direction_input.to_i

    unless (0..3).include?(winner_direction_index)
      puts "0~3の数字を入力してください。"
      acci_muki_hoi(winner_hand, loser_hand, winner_name)
      return
    end

    loser_direction_index = rand(4)
    puts "自分の方向：#{@directions[winner_direction_index]}"
    puts "コンピュータの方向：#{@directions[loser_direction_index]}"

    if winner_direction_index == loser_direction_index
      puts "あっち向いてホイ！#{winner_name}が勝者です！"
      exit
    else
      puts "もう一度じゃんけんをしてください。"
      play
    end
  end
end

janken = Janken.new
janken.play