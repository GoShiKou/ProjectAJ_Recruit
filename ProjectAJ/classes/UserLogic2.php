<?php

require_once 'dbconnect.php';

class UserLogic2
{
    /**
     * ユーザを登録する
     * @param array $userData
     * @return bool $result
     */
    public static function createUser($userData)
    {
        $result = false;
        
        $sql = 'INSERT INTO users(user_id,username,email,password) VALUES (?,?,?,?)';

        //ユーザデッタを配列に入れる
        $arr = [];
        $arr[] = $userData['user_id']; //user_id
        $arr[] = $userData['username']; //name
        $arr[] = $userData['email'];//email
        $arr[] = password_hash($userData['password'],PASSWORD_DEFAULT);//password 

        try{
            $stmt = connect()-> prepare($sql);
            $result = $stmt->execute($arr);
    
            return $result;

        }catch(\Exception $e){

            return $result;

        }
        
    }
    /**
     * ログイン処理
     * @param string $user_id
     * @param string $password
     * @return bool $result
     */
    public static function login($user_id,$password)
    {
        //結果
        $result = false;
        //ユーザをuser_idから検索して取得
        $user = self::getUserByUserId($user_id);

        if (!$user){
            $_SESSION['msg'] = 'User ID が一致しません。';
            return $result;
        }

        //パスワードの照会
        if(password_verify($password,$user['password'])){
            //ログイン成功
            session_regenerate_id(true);
            $_SESSION['login_user'] = $user;
            $result = true;
            return $result;
        }else{
        $_SESSION['msg'] = 'パスワードが一致しません。';
            return $result;
        }

    }
     /**
     * user_idからユーザを取得
     * @param string $user_id
     * @return array|bool $user|false
     */
    public static function getUserByUserId($user_id)
    {
        //SQLの準備
        //SQLの実行
        //SQLの結果を返す
        $sql = 'SELECT * FROM users WHERE user_id = ?';

        //user_idを配列に入れる
        $arr = [];
        $arr [] = $user_id;

        try{
            $stmt = connect()-> prepare($sql);
            $stmt->execute($arr);
            //SQLの結果を返す
            $user = $stmt->fetch();
    
            return $user;

        }catch(\Exception $e){

            return false;

        }

    }

     /**
   * ログインチェック
   * @param void
   * @return bool $result
   */
  public static function checkLogin()
  {
    $result = false;
    
    // セッションにログインユーザが入っていなかったらfalse
    if (isset($_SESSION['login_user']) && $_SESSION['login_user']['id'] > 0) {
      return $result = true;
    }

    return $result;

  }

  /**
   * ログアウト処理
   */
  public static function logout()
  {
    $_SESSION = array();
    session_destroy();
  }

}

?>