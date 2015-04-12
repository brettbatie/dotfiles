#!/bin/bash
# requires to parameters, original directory and destination directory
if [[ $# -ne 2 ]]; then
	echo 'Two parameters required: originalDirectory destinationDirectory'
	exit;
fi

# -o copy the files to the destination
# '-Directory<FileModifyDate' - Take the FileModify date and use that for the Directory format
# '-Direcotry<CreateDate' - Take the DateTimeOriginal tag and use that for the Directory format
# '-Directory<DateTimeOriginal' - Take the FileModifyDate and use that for the Directory format
# The '-Directory<*' on the farthest right is used if the tag exists.
# -d the directory structure %Y is taken from the DateTimeOriginal (if it exists) otherwise it is taken from CreateDate (if it exists) otherwise it is taken from the file modify date.
# -P preserve file info
# -progress - show progress
# -r recursive
# -w file name format. %f = filename, %c = add a count if there is a duplicate name, %e = extension
exiftool -o . -ext 3FR -ext EIP -ext LA -ext ORF -ext RTF -ext 3G2 -ext EPS -ext LFP -ext OTF -ext RW2 -ext 3GP -ext EPUB -ext LNK -ext PAC -ext RWL -ext ACR -ext ERF -ext M2TS -ext PAGES -ext RWZ -ext AFM -ext EXE -ext M4A/V -ext PBM -ext RM -ext AI -ext EXIF -ext MEF -ext PCD -ext SEQ -ext AIFF -ext EXR -ext MIE -ext PDB -ext SO -ext APE -ext EXV -ext MIFF -ext PDF -ext SR2 -ext ARW -ext F4A/V -ext MKA -ext PEF -ext SRF -ext ASF -ext FFF -ext MKS -ext PFA -ext SRW -ext AVI -ext FLA -ext MKV -ext PFB -ext SVG -ext AZW -ext FLAC -ext MNG -ext PFM -ext SWF -ext BMP -ext FLV -ext MOBI -ext PGF -ext THM -ext BTF -ext FPF -ext MODD -ext PGM -ext TIFF -ext CHM -ext FPX -ext MOS -ext PLIST -ext TORRENT -ext COS -ext GIF -ext MOV -ext PICT -ext TTC -ext CR2 -ext GZ -ext MP3 -ext PMP -ext TTF -ext CRW -ext HDP -ext MP4 -ext PNG -ext VRD -ext CS1 -ext HDR -ext MPC -ext PPM -ext VSD -ext DCM -ext HTML -ext MPG -ext PPT -ext WAV -ext DCP -ext ICC -ext MPO -ext PPTX -ext WDP -ext DCR -ext IDML -ext MQV -ext PS -ext WEBP -ext DFONT -ext IIQ -ext MRW -ext PSB -ext WEBM -ext DIVX -ext IND -ext MXF -ext PSD -ext WMA -ext DJVU -ext INX -ext NEF -ext PSP -ext WMV -ext DLL -ext ITC -ext NRW -ext QTIF -ext WV -ext DNG -ext J2C -ext NUMBE -ext RA -ext X3F -ext DOC -ext JNG -ext ODP -ext RAF -ext XCF -ext DOCX -ext JP2 -ext ODS -ext RAM -ext XLS -ext DPX -ext JPEG -ext ODT -ext RAR -ext XLSX -ext DV -ext K25 -ext OFR -ext RAW -ext XMP -ext DVB -ext MTS -ext KDC -ext OGG -ext RIFF -ext ZIP -ext DYLIB -ext KEY -ext OGV -ext RSRC -ext JPG -ext '-Directory<FileModifyDate' '-Directory<CreateDate' '-Directory<DateTimeOriginal' -d $2/%Y/%m -P -r -w %f%+c.%e $1

