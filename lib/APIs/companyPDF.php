<?php
    require'fpdf/fpdf.php';
    $db = new PDO('mysql:host=localhost;dbname=erp','root','');

    class PDF extends FPDF{
        function header(){
            $this->Image('c.png',10,6);
            $this->SetFont('Arial','B',16);
            $this->Cell(276,5,'Company Name',0,0,'C');
            $this->Ln();
            $this->SetFont('Times','',14);
            $this->Cell(276,10,'Company Accounting Report',0,0,'C');
            $this->Ln(20);
        }

        function footer(){
            $this->SetY(-15);
            $this->SetFont('Arial','',8);
            $this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
        }

        function headerTable(){
            $this->SetFont('Times','B',12);
            $this->Cell(20,10,'Month',1,0,'C');
            $this->Cell(20,10,'Year',1,0,'C');
            $this->Cell(35,10,'Balance',1,0,'C');
            $this->Cell(35,10,'Expenses',1,0,'C');
            $this->Cell(35,10,'Salary',1,0,'C');
            $this->Cell(35,10,'Income',1,0,'C');
            $this->Cell(30,10,'Tax',1,0,'C');
            $this->Cell(35,10,'New Balance',1,0,'C');
            $this->Cell(35,10,'Profit',1,0,'C');
            $this->Ln();
        }

        function viewTable($db){
            $this->SetFont('Times','',12);
            $stmt = $db->query('select * from company');
            while($data = $stmt->fetch(PDO::FETCH_OBJ)){
                $this->Cell(20,10,$data->month,1,0,'C');
                $this->Cell(20,10,$data->year,1,0,'C');
                $this->Cell(35,10,$data->Balance,1,0,'C');
                $this->Cell(35,10,$data->expenses,1,0,'C');
                $this->Cell(35,10,$data->salary,1,0,'C');
                $this->Cell(35,10,$data->income,1,0,'C');
                $this->Cell(30,10,$data->tax,1,0,'C');
                $this->Cell(35,10,$data->newBalance,1,0,'C');
                $this->Cell(35,10,$data->profit,1,0,'C');
                $this->Ln();
            }
        }
    }

    $pdf = new PDF();
    $pdf->AliasNbPages();
    $pdf->AddPage('L','A4',0);
    $pdf->headerTable();
    $pdf->viewTable($db);
    $pdf->Output();
    
    

?>