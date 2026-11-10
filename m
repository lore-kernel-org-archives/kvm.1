Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325474;
	b=jvl4MHHkQB9Ld0Xdt1NWfW4lckbBCq/301UKWPYSaKtXrlXb56rkrFHf9Fc5p0yoNO+z
	 q7tmR0ldlYNOmLDqEN1Z9Z5XOl1tCPR8s7lKdcjanfbGZQSu0mY2ya7uW1cYCHdnWsILX
	 dO+x4A4rM6To+eiUjpruKDon2M5kjGBMaHeakGuMD6QUrp04OmAnU2GnjWBz9LKPJR6Mv
	 bTCF1gHMi32yXls7iOUXOkfAdKP096zkPpkuEOZAOsNVluMwDQUKiuRitTBwEAFswtMPU
	 sXxjc05WZmpDtlU5H4Tjx7lFZIOEYp+hEokUvESnvIsJV0mssvXJyDozvj/k6CqHmXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325474;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PNlP9f6Wrf+sUQn6QPmno7fsahkNAHws9ylX2pvBoqc=;
	b=Z0wan56DkdMdOA9P45lHPjWvPKC6I7EgWKXNEFMo/nwGBsWOkhCRFTr1WbHKry4nctMv
	 fCuU4nuKlxQhZs0G36Z7eSJmC1GMaAadpk+1wljjBrD+0Qp+ZELj0ifD9LwNo2Flwtfjo
	 s7bjulGQrGClc/K73B4xlVG0T4S3ziTVC7UiPzKuQ/mmTGV8w9UL36YdtFtKExZd8kG16
	 H9RRYw/k6R4MIu+3zzD8UkmbdH+yEWq7ejhlOy4QnDOzz1nkSssJ5kyN7qvoTMfYO7xXE
	 hRANnymSrgVQlMeVpjWmIuXOBGHXemPw0J+2r7tIUrboWqT9Sakwq+emfYgN3+iwHjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sxZoPAPr;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EEF606A332
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 15:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EEF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sxZoPAPr
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFECoj2667195;
	Tue, 10 Nov 2026 15:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PNlP9f6Wrf+sUQn6QPmno7fsahkNAHws9ylX2pvBo
	qc=; b=sxZoPAPrd2MlOVa/FhHY+4jxfS/cmpI9Hf0J2Diw8znSyrIxqXL5Gqt7r
	jUyufx+JnXx7MejWRCjWy0k0KXxuhUThwAgdRUEqSX9PSDUshLxgCagVue41TD5r
	N2aNss5xvw15yv1KSgNOcNM/NMb7FrdVvraRQigDybXUITQ3S9gVT1S2WBeW3gcy
	cRZ95J72Q62uxnUQRCQXSfpj9BFdpfDQ7JA5Z+fEjjfuLzjtiYOFm8C2pO5ScEHG
	yl/9+2IyTImY3EIrbQP7D5Olcvric1+UdIT8mv31KQ6JsfInZLkzSFMdGb+bzkU6
	MTxn2rzvg462KshgfaKXoXII7V09Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6wngv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 15:44:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAF4wpw1880673;
	Tue, 10 Nov 2026 15:44:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3320nj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 15:44:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAFiLMk48693680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 15:44:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4E7D20043;
	Tue, 10 Nov 2026 15:44:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 066C820040;
	Tue, 10 Nov 2026 15:44:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.184])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 15:44:19 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org
Subject: [PATCH] powerpc: Link with -z notext
Date: Tue, 10 Nov 2026 21:14:15 +0530
Message-ID: <20261110154415.46220-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MiBTYWx0ZWRfX65r6+Laa4BA1
 6MAxt1xuDBzeOuoJiWB/f35TPMeIJW6a0Ie2aCXXEruenoXVKIIJfwTEXy4a0SvFmBxspAcFk5K
 /SEXOqVUPiWE10bXxgorkhkZohpaHzY=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af33bda cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=_iiAB3vgKD867NDUgDgA:9
X-Proofpoint-ORIG-GUID: L2jU7n3C7WxHLaCnRZ2cLLSuHaux1D9G
X-Proofpoint-GUID: L2jU7n3C7WxHLaCnRZ2cLLSuHaux1D9G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MiBTYWx0ZWRfX1KoVsvXBCIHN
 Umfnk7C29chGhse5Hv9y1h2uk7nZFR5Gxs3HX6S9DSm+Z82/9xyFmRgEiCw9OR32oM68Y5mxdfS
 kWtds/0u1ehOK1ZTeLcQWMBnB0ul2Ac9dTL07M9xSNoPPDMC1MS1fxnlWXRbjwDrESyPKy3R/Vz
 GKo7hyYcz59XNrDpOb/tAqOwFhZI4ovsNA1UZBUDLEPfmt7Jdh/uLnnUzRZub9MhSCVryAW4B0Q
 1VVIJk4772l/ShQajuAiiJgGwdrp0j9qxxlHufZfuhsF37Bk53BiI94sML91lluLgxR93sHg5V3
 BdnUYkXEathc4S00EuBeIo+w0QRSdIhXX54RjGiBLiz2yBejo/c8ZqMcV2AxZ7faH/ICfA+1oJ8
 p7cPIyq03OA8rYAOaglQIuGga7E0XDBw4pZiYvR2Jr4Ts4rVIbBy4kBfM86oDF5z0s6sQ93lpzg
 LfNr8c+NFvm28bv5/RQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100062

Building the powerpc tests with GNU ld 2.46.1 fails when linking the
test binaries:

  /usr/bin/ld.bfd: error: read-only segment has dynamic relocations

The tests are linked with -pie and relocate themselves at boot (see
relocate() in powerpc/reloc64.c, called from powerpc/cstart64.S).
Newer GNU ld rejects relocations in read-only segments by default.  The
Makefile already checks after linking that only R_PPC64_RELATIVE
relocations are present.

Fix this by adding `-z notext` to the powerpc linker flags, as was done
for arm64 in commit 5d67db4e1860 ("arm64: Link with -z notext").

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/powerpc/Makefile b/powerpc/Makefile
index 41e752b070bc..35fe58835726 100644
--- a/powerpc/Makefile
+++ b/powerpc/Makefile
@@ -78,7 +78,7 @@ include $(SRCDIR)/scripts/asm-offsets.mak
 
 FLATLIBS = $(libcflat) $(LIBFDT_archive)
 %.elf: CFLAGS += $(arch_CFLAGS)
-%.elf: LDFLAGS += $(arch_LDFLAGS) -pie -n
+%.elf: LDFLAGS += $(arch_LDFLAGS) -pie -n -z notext
 %.elf: %.o $(FLATLIBS) $(SRCDIR)/powerpc/flat.lds $(cstart.o) $(reloc.o) %.aux.o
 	$(LD) $(LDFLAGS) -o $@ \
 		-T $(SRCDIR)/powerpc/flat.lds --build-id=none \

base-commit: 5a221342a025948fa7d84f0c404748f6ba57f3ad
-- 
2.54.0 (Apple Git-157)

