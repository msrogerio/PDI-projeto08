%% Projeto 8
% *Autor:* Marlon da Silva Rogério

%% Referências
% *GONZALEZ, R. C.*, WOODS, R. E. Processamento de Imagens Digitais. 
% Editora Edgard Blucher, ISBN São Paulo, 2000.
% *Support MathWorks*, 2021. Disponível em: <https://www.mathworks.com/help/>.
% Acesso em: 18 de julho. de 2021.

% Para uma imagem de seu projeto pessoal ou alguma qualquer outra imagem sem compressão.
%  * Aplique uma compressão de essa imagem (varie algum parâmetro)
%    - JPG
%    - JPG2000
%    - SPIHT (algoritmo que utiliza transformada wavelet)
%  * plote o gráfico PSNR vs  jpg_bp
%    - comente


close all; clear
img_ref =  imread ('balao.png');

%% JPG
jpg_bp =[];
jpg_psnr =[];

for param1 = 0:5:100 
  imwrite(img_ref, 'balao.jpg','Quality', param1);
  img_compress = imread('balao.jpg');
  Cr =imratio('balao.png','balao.jpg');
  jpg_bp = [8/Cr jpg_bp];
  jpg_psnr = [psnr(img_ref,img_compress) jpg_psnr];
end

%% JPG2000
jp2_bp =[];
jp2_psnr =[];

for param1 = 2:5:150
  imwrite(img_ref, 'balao.jp2','CompressionRatio', param1);
  img_compress = imread('balao.jp2');
  Cr =imratio('balao.png','balao.jp2');
  jp2_bp = [8/Cr jp2_bp];
  jp2_psnr = [psnr(img_ref,uint8(img_compress)) jp2_psnr];
end

%% SPIHT
sp_bp =[];
sp_psnr =[];

for param1 = 0.01:0.1:1
  wcompress('c', 'balao.png' ,'balao.wtc', 'spiht' , 'bpp', param1);
  img_compress = wcompress('c','balao.wtc');
  Cr =imratio('balao.png','balao.wtc');
  sp_bp = [8/Cr sp_bp];
  sp_psnr = [psnr(uint8(img_compress), img_ref) sp_psnr];
end

%% 

figure;
plot(jpg_bp,jpg_psnr,'^-b');
hold on;
plot(jp2_bp,jp2_psnr,'^-r');
% plot(sp_bp,sp_psnr,'^-g');

ylabel('PSNR'); 
xlabel('b/p');
title('Compressao');


