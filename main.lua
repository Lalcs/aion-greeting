hello =
{
  [1] = {"おはようございます。", "おっはー"},
  [2] = {"こんにちは。", "こん～"},
  [3] = {"こんばんは。", "こばわー"}
};

-- ニックネーム
name =
{
  -- フレンド
  ["家主"] = "",
  ["フレンドA"] = "フレA",
  ["フレンドB"] = "フーレB",
  -- レギオン
  ["レギメンA"] = "レギレギ",
  ["レギメンB"] = "レギB",
};

-- 敬称内容
title =
{
  -- デフォルト
  ["D"] = {"さん", "様", "殿"},

  -- フレンド
  ["家主"] = "",
  ["フレンドB"] = "ちゃん",

  -- レギオン
}

-- メッセージ内容
msgu =
{
  ["家主"] = {"おかえりなさい！", "帰ってくるの早かったにゃ～"},
}
msgr =
{
  [1] = {" いらっしゃーい！", " ｲﾗｯｼｬｲﾏｾ(｡u_u｡)ﾍﾟｺ", " (ﾉ´▽｀)ﾉｲﾗｯｼｬ───ｨ"},
  [2] = {"ゆっくりしていってね！", "まったりしていってね！"},
  [3] = {"執事を右クリックすると有益な情報が得られるかも？！"},
  [4] = {""},
  [5] = {""},
  [6] = {""},
  [7] = {""},
  [8] = {""},
  [9] = {""},
  [10] = {""},
};
emo =
{
  ["D"] = H.Emotion.wave,
  ["家主"] = H.Emotion.kneel,
}

-- コンストラクタ
function OnInit()
  -- 執事の認知範囲指定
  H.SetSensor(6, 30);
end

-- 執事が認知したら読み込み
function OnUserEntered(username)
  -- 変数の局所化
  local ti;
  local i = 0;
  local ii = 2;
  local id = 3;


  -- 引数(チャンネル, "r[*]メッセｰジ用")
  H.PlaySound(0, "r[1]rrrr[2]rrrr[3]rrrr[4]rrrr[5]rrrr[6]rrrr[7]rrrr[8]rrrr[9]rrrr[10]rrrr[11]");

  -- メッセージ出力
  H.StartAnimation(0, 1, get_emo(username));
  H.Say(1, get_hello());
  H.Say(2, get_name(username) .. get_title(username) .. get_msg(username, 1));

  if(msgu[username] == nil) then
    ti = table.maxn(msgr);
  else
    ti = table.maxn(msgu[username]);
  end

  while(i <= ti) do
    H.Say(id, get_msg(username, ii));
    i = i + 1;
    ii = ii + 1;
    id = id + 1;
  end
end

-- 乱数の取得
function get_rand(max)
  -- 変数の局所化
  local rand;

  if(max == nil) then
    return 1;
  elseif(max == 1) then
    return 1;
  else
    math.randomseed(os.time());

    -- 乱数の取得
    rand = math.random(max);
    rand = math.random(max);

    return rand;
  end
end

-- 挨拶の取得
function get_hello()
  -- 変数の局所化
  local time_h;
  local id;

  -- 変数の型変更
  time_h = math.floor(os.date("%H"));

  if (time_h <= 4) then
    id = 3;
  elseif (time_h <= 11) then
    id = 1;
  elseif (time_h <= 17) then
    id = 2;
  elseif (time_h <= 23) then
    id =3;
  end

  return hello[id][get_rand(table.maxn(hello[id]))];
end

-- ニックネームの取得
function get_name(str)
  if (name[str] == nil) then
    return str;
  else
    return name[str];
  end
end

-- 敬称の取得
function get_title(str)
  if(title[str] == nil) then
    return title["D"][get_rand(table.maxn(title["D"]))];
  else
    return title[str];
  end
end

-- メッセージの取得
function get_msg(str, id)
  if(msgu[str] == nil) then
    return msgr[id][get_rand(table.maxn(msgr[id]))];
  else
    return msgu[str][id];
  end
end
-- エモ取得
function get_emo(str)
  if(emo[str] == nil) then
    return emo["D"];
  else
    return emo[str];
  end
end
