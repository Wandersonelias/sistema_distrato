prawn_document(page_layout: :portrait) do |pdf|
    #Cabeçalho do documento - begin
    pdf.move_up(25)
    pdf.pad_top(5){
        pdf.image "#{Rails.root}/app/assets/images/Logo.png", :width => 120, :height => 40 
                
    }
    pdf.formatted_text [ { :text => "DEMONSTRATIVO DE DÉBITO DO IMÓVEL", :styles => [:bold] }] , :align => :center 
    #end
    #Dados do locatario do imóevel - begin
    pdf.pad(5){
        pdf.table([["NOME", @entrega.nome, "CPF:", @entrega.processo ]], :column_widths => [50, 280, 50, 140], :cell_style => {:size => 7})
        pdf.table([["ENDEREÇO", @entrega.endereco, "PROCESSO", @entrega.processo, "DATA:", @entrega.created_at.strftime("%d/%m/%Y")]], :column_widths => [50, 280, 50, 60, 30, 50], :cell_style => {:size => 7})
    }
    #end
    #--------------------------------------
    #Dados sobre a locação do imóvel - begin
    pdf.formatted_text [ { :text => "ALUGUEL", :styles => [:bold] }] , :align => :center 
    pdf.move_down(2)
    pdf.table([["Periodo","Vencimento", "Previsão de pagamento", "Valor Aluguel R$", "Multa 10%", "Juros"]],:row_colors => ["FCE016"],:column_widths => [50,75,150,100,75,70], :cell_style => {:size => 7, :font_style => :bold})
    @aluguels.each do |v|
        pdf.table([
            [v.periodo, v.data_vencimento, v.previsao_pagamento, number_with_precision(v.valor_aluguel, :precision => 2) , number_with_precision(v.multa == 0 ? 0.00 : v.multa, :precision =>  2), number_with_precision(v.juros, :precision => 2)]
            ], :column_widths => [50,75,150,100,75,70],:cell_style => {:size => 7}
        )
    end
    #Row para subtotal - begin
    pdf.table([["Subtotal","#{number_with_precision(aluguel = @aluguels.sum(:valor_aluguel), :precision => 2)}","#{number_with_precision(multa = @aluguels.sum(:multa), :precision => 2)}","#{ number_with_precision(total_juros = @aluguels.sum(:juros), :precision => 2)}"]], :column_widths => [275,100,75,70], :cell_style => {:size => 7})
    #end
    #Row para total - begin
    pdf.table([["Total","#{number_with_precision(total_juros == 0 ? aluguel : 0.00, :precision => 2)}"]], :column_widths => [375,145], :cell_style => {:size => 7})
    #end
    #Dados sobre contas publicas eachs com com ifs para filtrar por tipos - begin
    pdf.move_down(8)
    pdf.formatted_text [ { :text => "CONTAS PUBLICAS", :styles => [:bold] }] , :align => :center 
    pdf.move_down(2)
    pdf.table([["Tipo","Cadastro","Referencia", "Vencimento", "Valor R$"]],:row_colors => ["FCE016"],:column_widths => [60,60,120,150,130], :cell_style => {:size => 7})
    @conta.each do |cea|
        if cea.tipo_contum.id == 1
        pdf.table([
            [cea.tipo_contum.descricao, cea.cadastro, cea.referencia, cea.vencimento, number_with_precision(cea.valor, :precision => 2)]
            ], :column_widths => [60,60,120,150,130],:cell_style => {:size => 7}
        )
        end
    end
    pdf.table([["Total","#{number_with_precision(cea = @conta.where(:tipo_contum => 1).sum(:valor), :precision => 2)}"]], :column_widths => [390,130], :cell_style => {:size => 7})
    pdf.move_down(5)
    if @conta.where(:tipo_contum_id => 2).present?
        pdf.table([["Tipo","Cadastro","Referencia", "Vencimento", "Valor R$"]],:row_colors => ["FCE016"],:column_widths => [60,60,120,150,130],:cell_style => {:size => 7})
        @conta.each do |caesa|
            if caesa.tipo_contum.id == 2
            pdf.table([
                [caesa.tipo_contum.descricao,caesa.cadastro, caesa.referencia, (DateTime.parse(caesa.vencimento) + 5).strftime("%d/%m/%Y"), number_with_precision(caesa.valor, :precision => 2)]
                ], :column_widths => [60,60,120,150,130],:cell_style => {:size => 7}
            )
            end
        end
        pdf.table([["Total","#{number_with_precision(caesa = @conta.where(:tipo_contum => 2).sum(:valor), :precision => 2)}"]], :column_widths => [390,130], :cell_style => {:size => 7})    
    else
        pdf.table([["O IMÓVEL POSSUI POSSO ARTESIANO - NA HÁ DEBITOS DE CAESA "]], :column_widths => [520],:cell_style => {:size => 7, :font_style => :bold, :align => :center })
    end
#END 
    pdf.move_down(5)
    if @conta.where(:tipo_contum_id => 3).present?
            pdf.table([["Tipo","Cadastro","Referencia", "Vencimento", "Valor R$"]],:row_colors => ["FCE016"],:column_widths => [60,60,120,150,130], :cell_style => {:size => 7})
            @conta.each do |iptu|
                if iptu.tipo_contum.id == 3
                pdf.table([
                    [iptu.tipo_contum.descricao,iptu.cadastro, iptu.referencia, iptu.vencimento, number_with_precision(iptu.valor, :precision => 2)]
                    ], :column_widths => [60,60,120,150,130],:cell_style => {:size => 7}
                )
            end
        end
        pdf.table([["Total","#{number_with_precision(iptu = @conta.where(:tipo_contum => 3).sum(:valor), :precision => 2)}"]], :column_widths => [390,130], :cell_style => {:size => 7})
    else        
        pdf.table([["NÃO HA DEBITOS DE IPTU"]], :column_widths => [520],:cell_style => {:size => 7, :font_style => :bold, :align => :center })           
    end
    pdf.move_down(5)
    #Dados sobre reparos - begin
    if @reparo.present?
    pdf.formatted_text [ { :text => "REPAROS", :styles => [:bold] }] , :align => :center 
        pdf.move_down(2)
            pdf.table([["Descrição","Valor"]],:row_colors => ["FCE016"],:column_widths => [340,180],:cell_style => {:size => 7, :font_style => :bold, :align => :center })
            @reparos.each do |reparo|
                pdf.table([
                    [reparo.descricao, number_with_precision(reparo.valor, :precision => 2)]], :column_widths => [340,180],:cell_style => {:size => 7}
                )
            end
    else
        pdf.table([["NÃO HA DEBITOS REFERENTES A REPARAOS"]], :column_widths => [520],:cell_style => {:size => 7, :font_style => :bold, :align => :center })
    end
    pdf.move_down(5)
    #end
    pdf.formatted_text [ { :text => "RESUMO", :styles => [:bold] }] , :align => :center 
    #correção de bug para coagir nil em decimal
    caesa == nil ? caesa = 0 : number_with_precision(caesa, :precision => 2)
    iptu == nil ? iptu = 0 : number_with_precision(iptu, :precision => 2)
    cea == nil ? cea = 0 : number_with_precision(cea, :precision => 2)
    tt = (total_juros == 0 ? aluguel : 0.00) + cea.to_d + caesa.to_d + iptu.to_d
    # ends
    pdf.table([["TOTAL DE DEBITO", "R$ #{number_with_precision(tt, :precision => 2)}"]], :column_widths => [120, 120], :cell_style => {:size => 7 }, :position => :center, )
    pdf.table([["IMPLEMENTO CONTRATUAL", @entrega.implemento]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["MULTA CONTRATUAL", number_with_precision(@entrega.multa, :precision => 2)]], :column_widths => [120,120], :cell_style => {:size => 7},:position => :center )
    pdf.table([["TAXA CONDOMINIO", @entrega.condominio]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["ENCARGOS ADM", @entrega.encargos]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["DÉBITOS DIVERSOS", @entrega.debito_diversos]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["CRÉDITO", @entrega.credito]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
    pdf.table([["CAUÇÃO", @entrega.caucao]], :column_widths => [120,120], :cell_style => {:size => 7}, :position => :center )
        implemento = @entrega.implemento
        multa_entrega = @entrega.multa
        condominio = @entrega.condominio
        encargos = @entrega.encargos
        debito_diversos = @entrega.debito_diversos
        creditos = @entrega.credito
        caucao = @entrega.caucao


    tp = caucao - ((multa_entrega + implemento + condominio + encargos + debito_diversos + tt) - creditos)
    
    pdf.table([["TOTAL", "R$ #{tp}"]], :column_widths => [120,120], :cell_style => {:size => 7, :font_style => :bold}, :position => :center)
    #roddape assinatura --- 
    pdf.move_down(80)

    
    #pdf.table([["CAPITAL IMÓVEIS EIRELLI - EPP", " ", "#{@entrega.nome.upcase}"]], :column_widths => [240,40,240], :cell_style => {:size => 9, :align => :center}) do
    #    row(0).columns(0).borders = [:top]
    #    row(0).columns(1).borders = []
    #    row(0).columns(2).borders = [:top]
    #end
    #pdf.table([["CNPJ/MF Nº 01.549.402/0001 - 02"," ", "CNPJ/CPF Nº 01.549.402/0001 - 02"]], :column_widths => [240,40,240], :cell_style => {:size => 9, :align => :center, :borders => []})
    #
    pdf.bounding_box([0, 40], :width => 520, :height => 100, :align => :center) do
        
        pdf.move_down(5)
        pdf.table([["CAPITAL IMÓVEIS EIRELLI - EPP", " ", "#{@entrega.nome.upcase}"]], :column_widths => [240,40,240], :cell_style => {:size => 9, :align => :center}) do
            row(0).columns(0).borders = [:top]
            row(0).columns(1).borders = []
            row(0).columns(2).borders = [:top]
        end
        pdf.table([["CNPJ/MF Nº 01.549.402/0001 - 02"," ", "CNPJ/CPF Nº 01.549.402/0001 - 02"]], :column_widths => [240,40,240], :cell_style => {:size => 9, :align => :center, :borders => []})
        pdf.move_down(10)
        pdf.text "Impresso por: #{@entrega.user.nome} - #{DateTime.now.strftime("%d/%m/%Y - %H:%M:%Sh")}" , :align => :right
    end
    #pagina com detalhes

    pdf.start_new_page
    pdf.move_up(25)
    pdf.pad_top(5){
        pdf.image "#{Rails.root}/app/assets/images/Logo.png", :width => 120, :height => 40 
                
    }
    pdf.move_down(5)
    pdf.formatted_text [ { :text => "CONTAS A PAGAR", :styles => [:bold] }] , :align => :center
    pdf.move_down(5)
    pdf.text " Recebemos do(a) #{@entrega.nome.upcase}, a importancia de R$ #{number_with_precision(cea , :precision => 2)}  referente  a quitação das contas de CEA conforme quadro demostrativo a abaixo:"
    pdf.table([["Tipo","Cadastro","Referencia", "Vencimento", "Valor R$"]],:row_colors => ["FCE016"],:column_widths => [60,60,120,150,130], :cell_style => {:size => 7})
    @conta.each do |cea|
        if cea.tipo_contum.id == 1
        pdf.table([
            [cea.tipo_contum.descricao, cea.cadastro, cea.referencia, cea.vencimento, number_with_precision(cea.valor, :precision => 2)]
            ], :column_widths => [60,60,120,150,130],:cell_style => {:size => 7}
        )
        end
    end
    pdf.table([["Total","#{number_with_precision(cea = @conta.where(:tipo_contum => 1).sum(:valor), :precision => 2)}"]], :column_widths => [390,130], :cell_style => {:size => 7})
    pdf.move_down(5)
    if @conta.where(:tipo_contum_id => 2).present?
        pdf.text " Recebemos do(a) #{@entrega.nome.upcase}, a importancia de R$ #{number_with_precision(caesa , :precision => 2)}  referente a quitação das contas da CAESA conforme quadro demostrativo a abaixo:"
        pdf.table([["Tipo","Cadastro","Referencia", "Vencimento", "Valor R$"]],:row_colors => ["FCE016"],:column_widths => [60,60,120,150,130],:cell_style => {:size => 7})
        @conta.each do |caesa|
            if caesa.tipo_contum.id == 2
            pdf.table([
                [caesa.tipo_contum.descricao,caesa.cadastro, caesa.referencia, (DateTime.parse(caesa.vencimento) + 5).strftime("%d/%m/%Y"), number_with_precision(caesa.valor, :precision => 2)]
                ], :column_widths => [60,60,120,150,130],:cell_style => {:size => 7}
            )
            end
        end
        pdf.table([["Total","#{number_with_precision(caesa = @conta.where(:tipo_contum => 2).sum(:valor), :precision => 2)}"]], :column_widths => [390,130], :cell_style => {:size => 7})    
    else
        pdf.table([["O IMÓVEL POSSUI POSSO ARTESIANO - NA HÁ DEBITOS DE CAESA "]], :column_widths => [520],:cell_style => {:size => 7, :font_style => :bold, :align => :center })
    end
#END 
    pdf.move_down(5)
    if @conta.where(:tipo_contum_id => 3).present?
        pdf.text " Recebemos do(a) #{@entrega.nome.upcase}, a importancia de R$ #{number_with_precision(iptu , :precision => 2)}  referente a quitação das contas de IPTU conforme quadro demostrativo a abaixo:"
        
            pdf.table([["Tipo","Cadastro","Referencia", "Vencimento", "Valor R$"]],:row_colors => ["FCE016"],:column_widths => [60,60,120,150,130], :cell_style => {:size => 7})
            @conta.each do |iptu|
                if iptu.tipo_contum.id == 3
                pdf.table([
                    [iptu.tipo_contum.descricao,iptu.cadastro, iptu.referencia, iptu.vencimento, number_with_precision(iptu.valor, :precision => 2)]
                    ], :column_widths => [60,60,120,150,130],:cell_style => {:size => 7}
                )
            end
        end
        pdf.table([["Total","#{number_with_precision(iptu = @conta.where(:tipo_contum => 3).sum(:valor), :precision => 2)}"]], :column_widths => [390,130], :cell_style => {:size => 7})
    else        
        pdf.table([["NÃO HA DEBITOS DE IPTU"]], :column_widths => [520],:cell_style => {:size => 7, :font_style => :bold, :align => :center })           
    end
    pdf.move_down(10)
    pdf.formatted_text [ { :text => "OBSERVAÇÕES GERAIS", :styles => [:bold] }] , :align => :center
    #listagem de observações de CEA
    pdf.bounding_box([0, 380], :width => 520, :height => 50, :align => :center) do
        pdf.stroke_bounds
        pdf.move_down(3)
        
        pdf.formatted_text [ { :text => "CEA", :styles => [:bold] }] , :align => :center
        @conta.each do |cea|
            if cea.tipo_contum_id == 1
                pdf.text " * #{cea.observacao}"
            end
        end
    end
    #listagem de observações de CAESA
    pdf.bounding_box([0, 320], :width => 520, :height => 50, :align => :center) do
    pdf.stroke_bounds
        
        pdf.move_down(3)
        pdf.formatted_text [ { :text => "CAESA", :styles => [:bold] }] , :align => :center
        @conta.each do |caesa|
            if caesa.tipo_contum_id == 2
                
                    pdf.text "  * #{caesa.observacao} ", :align => :justify
                
            end
        end
    end
    #listagem de observações  IPTU
    pdf.bounding_box([0, 260], :width => 520, :height => 50, :align => :center) do
    pdf.stroke_bounds
        pdf.move_down(3)
        pdf.formatted_text [ { :text => "IPTU", :styles => [:bold] }] , :align => :center
        @conta.each do |iptu|
            if iptu.tipo_contum_id == 3
                pdf.text " *  #{iptu.observacao}"
            end
        end
    end    
    
    
    
    #Rodapé da pagina
    pdf.bounding_box([0, 40], :width => 520, :height => 100, :align => :center) do
        
        pdf.move_down(5)
        pdf.table([["SETOR FINANCEIRO", " ", "SETOR DE CONTRATOS"]], :column_widths => [240,40,240], :cell_style => {:size => 9, :align => :center}) do
            row(0).columns(0).borders = [:top]
            row(0).columns(1).borders = []
            row(0).columns(2).borders = [:top]
        end
        
        #pdf.table([["CNPJ/MF Nº 01.549.402/0001 - 02"," ", "CNPJ/CPF Nº 01.549.402/0001 - 02"]], :column_widths => [240,40,240], :cell_style => {:size => 9, :align => :center, :borders => []})
        pdf.move_down(25)

        pdf.text "Impresso por: #{@entrega.user.nome} - #{DateTime.now.strftime("%d/%m/%Y - %H:%M:%S")}" , :align => :right
    end
    
    
      
    
end




