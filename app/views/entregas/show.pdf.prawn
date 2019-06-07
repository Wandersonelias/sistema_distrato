prawn_document(page_layout: :portrait) do |pdf|
    #Cabeçalho do documento - begin
    pdf.move_up(20)
    pdf.pad_top(5){
        pdf.image "#{Rails.root}/app/assets/images/superman.jpg", :width => 60, :height => 50 
        pdf.move_up(10)
        pdf.text "#{@entrega.created_at.strftime("%d/%m/%Y")}", :align => :right
        pdf.text "Processo nº #{@entrega.processo}", :align => :right
        pdf.move_down(5)
        
    }
    pdf.formatted_text [ { :text => "DEMONSTRATIVO DE DÉBITO DO IMÓVEL", :styles => [:bold] }] , :align => :center 
    #end
    pdf.pad(5){
        pdf.stroke_horizontal_rule
    }
    #Dados do locatario do imóevel - begin
    pdf.pad(5){
        pdf.table([["NOME", @entrega.nome]], :column_widths => [80, 440])
        pdf.table([["ENDEREÇO", @entrega.endereco]], :column_widths => [80,440])
    }
    #end
    #--------------------------------------
    #Dados sobre a locação do imóvel - begin
    pdf.formatted_text [ { :text => "ALUGUEL", :styles => [:bold] }] , :align => :center 
    pdf.pad(2){
        pdf.stroke_horizontal_rule
    }
    pdf.move_down(5)
    pdf.table([["Periodo","Vencimento", "Previsão de pagamento", "Valor Aluguel R$", "Multa 10%", "Juros"]],:row_colors => ["FCE016"],:column_widths => [50,75,150,100,75,70], :cell_style => {:size => 7, :font_style => :bold})
    @aluguels.each do |v|
        pdf.table([
            [v.periodo, v.data_vencimento, v.previsao_pagamento, number_with_precision(v.valor_aluguel, :precision => 2) , number_with_precision(v.multa , :precision =>  2), number_with_precision(v.juros, :precision => 2)]
            ], :column_widths => [50,75,150,100,75,70],:cell_style => {:size => 7}
        )
    end
    #Row para subtotal - begin
    pdf.table([["Subtotal","#{number_with_precision(aluguel = @aluguels.sum(:valor_aluguel), :precision => 2)}","#{number_with_precision(multa = @aluguels.sum(:multa), :precision => 2)}","#{ number_with_precision(juros = @aluguels.sum(:juros), :precision => 2)}"]], :column_widths => [275,100,75,70], :cell_style => {:size => 7})
    #end
    #Row para total - begin
    pdf.table([["Total","#{number_with_precision(juros, :precision => 2)}"]], :column_widths => [375,145], :cell_style => {:size => 7})
    #end
    #Dados sobre contas publicas eachs com com ifs para filtrar por tipos - begin
    pdf.move_down(8)
    pdf.formatted_text [ { :text => "CONTAS PUBLICAS", :styles => [:bold] }] , :align => :center 
    pdf.pad(5){
        pdf.stroke_horizontal_rule
    }
    pdf.move_down(2)
    pdf.table([["Tipo","Cadastro","Referencia", "Vencimento", "Valor R$"]],:row_colors => ["FCE016"],:column_widths => [60,60,120,150,130])
    @conta.each do |cea|
        if cea.tipo_contum.id == 1
        pdf.table([
            [cea.tipo_contum.descricao, cea.cadastro, cea.referencia, cea.vencimento, number_with_precision(cea.valor, :precision => 2)]
            ], :column_widths => [60,60,120,150,130],:cell_style => {:size => 7}
        )
        end
    end
    pdf.move_down(5)
    if @conta.where(:tipo_contum_id => 2).present?
        pdf.table([["Tipo","Cadastro","Referencia", "Vencimento", "Valor R$"]],:row_colors => ["FCE016"],:column_widths => [60,60,120,150,130])
        @conta.each do |caesa|
            if caesa.tipo_contum.id == 2
            pdf.table([
                [caesa.tipo_contum.descricao,caesa.cadastro, caesa.referencia, (DateTime.parse(caesa.vencimento) + 5).strftime("%d/%m/%Y"), number_with_precision(caesa.valor, :precision => 2)]
                ], :column_widths => [60,60,120,150,130],:cell_style => {:size => 7}
            )
            end
        end
    else
        pdf.table([["O IMÓVEL POSSUI POSSO ARTESIANO - NA HÁ DEBITOS DE CAESA "]], :column_widths => [520],:cell_style => {:size => 9, :font_style => :bold, :align => :center })
    end
#END 
    pdf.move_down(5)
    if @conta.where(:tipo_contum_id => 3).present?
            pdf.table([["Tipo","Cadastro","Referencia", "Vencimento", "Valor R$"]],:row_colors => ["FCE016"],:column_widths => [60,60,120,150,130])
            @conta.each do |iptu|
                if iptu.tipo_contum.id == 3
                pdf.table([
                    [iptu.tipo_contum.descricao,iptu.cadastro, iptu.referencia, iptu.vencimento, number_with_precision(iptu.valor, :precision => 2)]
                    ], :column_widths => [60,60,120,150,130],:cell_style => {:size => 7}
                )
            end
        end
    else        
        pdf.table([["NÃO HA DEBITOS DE IPTU"]], :column_widths => [520],:cell_style => {:size => 9, :font_style => :bold, :align => :center })           
    end
    pdf.move_down(5)
    #Dados sobre reparos - begin
    pdf.formatted_text [ { :text => "REPAROS", :styles => [:bold] }] , :align => :center 
    pdf.pad(5){
        pdf.stroke_horizontal_rule
    }
    pdf.move_down(2)
        pdf.table([["Descrição","Valor"]],:row_colors => ["FCE016"],:column_widths => [340,180],:cell_style => {:size => 7, :font_style => :bold, :align => :center })
        @reparos.each do |reparo|
            pdf.table([
                [reparo.descricao, number_with_precision(reparo.valor, :precision => 2)]], :column_widths => [340,180],:cell_style => {:size => 7}
            )
        end
    pdf.move_down(5)
    #end
    pdf.formatted_text [ { :text => "RESUMO", :styles => [:bold] }] , :align => :center 
    pdf.pad(5){
        pdf.stroke_horizontal_rule
    }
    
    
    pdf.table([["TOTAL DE DEBITO", "R$ 1223.34"]], :column_widths => [120, 120], :cell_style => {:size => 7 }, :position => :center, )
    pdf.table([["IMPLEMENTO CONTRATUAL", @entrega.implemento]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["MULTA CONTRATUAL", @entrega.multa]], :column_widths => [120,120], :cell_style => {:size => 7},:position => :center )
    pdf.table([["TAXA CONDOMINIO", @entrega.condominio]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["ENCARGOS ADM", @entrega.encargos]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["DÉBITOS DIVERSOS", @entrega.debito_diversos]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["CRÉDITO", @entrega.credito]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["CAUÇÃO", @entrega.caucao]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["TOTAL", "R$ 1000,00"]], :column_widths => [120,120], :cell_style => {:size => 7, :font_style => :bold}, :position => :center)

    pdf.move_down(20)
    pdf.table([["CAPITAL IMÓVEIS EIRELLI - EPP", " ", "#{@entrega.nome.upcase}"]], :column_widths => [240,40,240], :cell_style => {:size => 9, :align => :center}) do
        row(0).columns(0).borders = [:top]
        row(0).columns(1).borders = []
        row(0).columns(2).borders = [:top]
    end
    pdf.table([["CNPJ/MF Nº 01.549.402/0001 - 02"," ", "CNPJ/CPF Nº 01.549.402/0001 - 02"]], :column_widths => [240,40,240], :cell_style => {:size => 9, :align => :center, :borders => []})
    
    

end


