<?php 
    require_once 'mail.php';

    $email = $_POST['email'];
    $restore = $_POST['restore'];
    $mail->setFrom('nerdteam2018@gmail.com', 'no-Reply');
    $mail->addAddress($email);
    $mail->Subject = 'Password Recovary';
    $mail->Body    = 'you password is <b>'.$restore.'</b>';
    $mail->send();

?>