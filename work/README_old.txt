!! bash�̗��p��O��ɂ��Ă��܂�
!! '$' �̓R�}���h�v�����v�g���Ӗ����܂�

	I. �g������
@@@ �S�̂�ʂ��������̍쐬
 1. main�f�B���N�g���ɓ���
 2. 00main.sh �����s����
   $ ./00main.sh
 3. �𓚂܂Ƃ߂Ƃ��āA00main.dvi 00main.idx 00main.pdf �Ȃǂ̃t�@�C�������������
 4. �܂��𓚂̍쐬���������Ă��Ȃ����̃��X�g�� 00NotSolved.list �ɏo�͂����
 !. 00main.sh��00main.tex ��G��K�v��(�قƂ��)�����B

@@@ �����̖�肾���̏o��
 1. main�f�B���N�g���ɓ���
 2. 00debug.sh �����s����
    �����ɂ͖��ԍ���3���œ��͂��� (���Ƃ��Ζ��12�Ȃ� 012)
   $ ./00debug.sh 012
 3. 00debug.tex 00debug.dvi 00debug.pdf �Ȃǂ̃t�@�C�������������
 !. 00debug.sh ��G��K�v��(�قƂ��)�����B


	II. ���X�V�̂�����
 1. problems�f�B���N�g���ɓ���
 2. �X�V��������� or preamble �f�B���N�g���ɓ���
    �����ł͂��Ƃ��Ζ��12������
 3. ���߂̃t�@�C�����R�s�[����B
    ���Ƃ��΁A19�N4��1���̃t�@�C����19�N5��10���ɍX�V����Ȃ�A
   $ cp Q_012.190401.tex Q_012.190510.tex
 !. �o�[�W�����Ǘ��ɂ��ďڂ����͌�q
 4. �V�����t�@�C��(�����ł�Q_012.190510.tex)��ҏW����
 !. �ҏW�����t�@�C���̃`�F�b�N�ɂ�00debug.sh�𗘗p����
 5. ����ǉ�����ۂɂ́Aproblems�f�B���N�g���ɐV�������̃f�B���N�g�����쐬���A�t�@�C����ǉ�����B
    tex�t�@�C���̏����ɂ��ẮA���̖����Q�Ƃ��ꂽ��
 6. ����ǉ�������A�ȉ���2�ӏ���ύX����B
  1. preamble���́A\setcounter{qnum}{NNN} ���A����萔�ɂȂ�悤�ɍX�V����B
  2. main�f�B���N�g������00main.sh�ɂ�����ϐ�qnum �̒l�𑍖�萔�ɂȂ�悤�ɍX�V����B


	III. �f�B���N�g���\��
DochaBot_Ans  : �z�[���f�B���N�g��
 �� eclbkbox  : sty�t�@�C�����܂�
 �� emathC181101  : sty�t�@�C���Q
 �� main
     �� 00debug (.sh .tex .dvi .pdf)  : �����̖�肾���̏o��
     �� 00main (.sh .tex .ist .pdf)  : �S�̂�ʂ��������̏o��
     �� *.sty sty�t�@�C���Q (���g��eclbkbox��emathC181101�Ɠ���Bplatex�ɔF������邽�߂ɂ����ɃR�s�[)
 �� org
     �� �ǂ���y���wbot�𓚕�.tex  : �����������I���W�i����tex�t�@�C��
 �� problems
     �� preamble
         �� preamble.tex  : �ŐV�ł�preamble.yymmdd.tex�ւ̃����N (00debug.sh 00main.sh �ɂ���Đ���)
         �� preamble.yymmdd.tex  : �v���A���u�����܂Ƃ߂��t�@�C��
     �� Q_nnn
         �� Q_nnn.tex  : �ŐV�ł�Q_nnn.yymmdd.tex�ւ̃����N (00debug.sh 00main.sh �ɂ���Đ���)
         �� Q_nnn.yymmdd.tex  : nnn�Ԃ̖��Ɖ𓚂��܂Ƃ߂��t�@�C��
 �� ver.20190224  : �I���W�i����tex�t�@�C���ɂ����āA�P�ɖ���ʃt�@�C���ɂƂ肾���������̂��́B
 �� README.txt  : ���̃t�@�C��
 �� UpdateLog.txt  : main problems �Ɋ܂܂��t�@�C���ɂ��Ă̍X�V����


	IV. problems���̊e�t�@�C���ɂ���
 1. �v���A���u���Ɗe���̉𓚂́A�o�[�W�����Ǘ��������Ȃ��B
 2. �o�[�W�����͍X�V�������t�ŋ�ʂ���B
  * preamble.yymmdd.tex
  * Q_nnn.yymmdd.tex
 3. ���t�͐���̉���yy�A��mm�A��dd �Ƃ���B
 4. ���A����1���̏ꍇ��0�Ŗ��߂�B(��A2019�N4��1�� -> 190401)
 5. ���ԍ��͏��3���Ƃ���B100�����̔ԍ��̏ꍇ��0�Ŗ��߂�B(��A7�� -> 007 / 49�� -> 049)
 6. ���́A��`�֐� thm ��p���ċL�q����
  * \begin{thm}{���ԍ�}{���̐�}{�o�T}
  * ���̐��Əo�T�͋󗓂��B�󗓂̏ꍇ�ł��A{}�͕K�v
 7. ����̋�؂�ɂ́@\syoumon{} �𗘗p�B{}���ɂ͏���ԍ��Ȃǂ��L���B�ԍ��ȊO�ɂ��������L���B