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
            $this->Cell(276,10,'Salary Accounting Report',0,0,'C');
            $this->Ln(20);
        }

        function footer(){
            $this->SetY(-15);
            $this->SetFont('Arial','',8);
            $this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
        }

        function headerTable(){
            $this->SetFont('Times','B',12);
            $this->Cell(15,10,'ID',1,0,'C');
            $this->Cell(45,10,'Name',1,0,'C');
            $this->Cell(30,10,'Department',1,0,'C');
            $this->Cell(25,10,'Salary',1,0,'C');
            $this->Cell(25,10,'Insurance',1,0,'C');
            $this->Cell(25,10,'Tax',1,0,'C');
            $this->Cell(30,10,'Deduction',1,0,'C');
            $this->Cell(50,10,'Note',1,0,'C');
            $this->Cell(30,10,'Net Salary',1,0,'C');
            $this->Ln();
        }

        function viewTable($db){
            $this->SetFont('Times','',12);
            $stmt = $db->query("select * from users where name <> ''");
            while($data = $stmt->fetch(PDO::FETCH_OBJ)){
                $this->Cell(15,10,$data->id,1,0,'C');
                $this->Cell(45,10,$data->name,1,0,'C');
                $this->Cell(30,10,$data->department,1,0,'C');
                $this->Cell(25,10,$data->salary,1,0,'C');
                $this->Cell(25,10,$data->insurance,1,0,'C');
                $this->Cell(25,10,$data->tax,1,0,'C');
                $this->Cell(30,10,$data->deduction,1,0,'C');
                $this->Cell(50,10,$data->note,1,0,'C');
                $this->Cell(30,10,$data->netSalary,1,0,'C');
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