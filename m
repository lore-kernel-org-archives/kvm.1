Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244305;
	b=XQp+Gp0eKhBodiJyZ2ioowcDvEEXRmauNIn3RneWEGWDEx796cUZVY+2wc9lmXuRu/WT
	 VRfnCIn7SpM95F4uYdXcpxUXabDZR6bJxrHKMSSiP7L7QfXW/ENRsAHFYVhQIszRt+K6X
	 p3xzOQEgcaC87E5eauQpWvY6t0E4MHpHzOYKuacScoieD2l5hVwEzuE/cV8lAJS5NBUDx
	 CTrC4fwzanOe9oZbEPp9LoIythg1ArqNCPihcnY80xTxFM7EaagQvXmBzT56XYhkSe7ai
	 1wm0rc3eNi91N7dKDA8xUvnJ7Bd3VtXsWS53IwCN+Nq5bKSumZpYg1Azt1ai5jPOptw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244305;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QEQmTipsyKkpYQOUcjIFdUA6AUwyhNa0XiT/YiP0mIY=;
	b=rh4O5T90uIlNUaeQ4Ih6uE9/Lgv/inX1JJxIx7D54VFc0nIWLS8yraAqaOCHeZuR2KBn
	 YqRKtr9KS3uHy+Roy10E6T74j9ceFHwIm0p7tDolI+4vvFM1SU9UI+rJNgelc91ZDJxRJ
	 62v+MIuOokstqxt82JQkdYt0ta+qTv5hkbZDOOqA0wiS4xrjkqEHbNwTumh+UDMaUpcco
	 nt0jxhZ81ubGVPrpORbxtqP8TQUw0qOL1ro0O8tBl1YCULsGoiMrJL10H0/cvbRHFlY2y
	 zDWNtB5WNbWYDn9mDn6PstXMnTCLkBKIqWL0+MLzVS1f4p8bnXE8YYX011W+Nod4FnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jt6o6Crr;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B8606A32A
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 17:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71B8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jt6o6Crr
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9FcatA3702176;
	Mon, 9 Nov 2026 17:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QEQmTipsyKkpYQOUc
	jIFdUA6AUwyhNa0XiT/YiP0mIY=; b=Jt6o6CrrPleha1CM0AY2I+v+4hMx0u3V4
	ea800TQnopeUVhW1rOlIL3GbtJ1EleruyDJ5eB40HGqnhC5F/d5Owb/qEPBhQwWu
	cVIAaSCpbxoWxSRrmlZ7Rfv5HRSsLBXv06FifeGHkfNIQk+XMY1z+WG6EEEYOD96
	+He7b8s7aqrrSF5Y8DNaN6QzSARUEmA3YJcW/R1Fa3zAnKRdcp9Lr0Gvp+wOWZxo
	eVD8iCtSDNVm1fKp/ny0F16y3c2BlVBV3ZthZ7Np08BD93tJB8Hoc5IAH9T6F++u
	DAVtifHW0Pp00DvoPmyMite+K4/g1k2XuD+AtuT+b28PZxn9wI5RQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5ykq7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 17:11:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9GrodN126034;
	Mon, 9 Nov 2026 17:11:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvt0p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 17:11:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9HBNuR44564812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 17:11:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADBB120043;
	Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C40120040;
	Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Bjoern Walk <bwalk@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [RFC Patch 6/8] linux-headers: Update to post-processed KVM headers
Date: Mon,  9 Nov 2026 18:10:32 +0100
Message-ID: <20261109171036.3806884-7-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: wvHuPxoljydAA0_pgv_G0cDBs4EJ0qRP
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af1fec0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8
 a=xhpvHnLSkC4Hu9qOc1kA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: wvHuPxoljydAA0_pgv_G0cDBs4EJ0qRP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfXwU0uRE/wXOTX
 5mTiGXCTLrD28SVr3MkSCU6mYCQsj7xT99WzNeU+DNB9HPQQj/X4tQum4XNt1VDG6b/4m31YAwe
 7mT7Z72L67pDnQs7pJkp49MP6iBr2IPeexWE40UHVZw3yfI6qyPipEnKMEJ1LWy2sBCA/t6qdBt
 vqgsyRge+PnqVyb0zgbdEmwEicsVsCdISnFBapfLJGwf8JPsOEuDqSFijkmElNhzCT9zDsEytsp
 vg5tNKtBRyq0eFGZBsdo+p6n5udq31shPhA3hXYcAOu5S0ol7ZW9v4sC6ED43PMBvN/TiW1JOtL
 3qg7osT295p2xvnUqWW1OTlsdkIK/HGQfeWBQQT7ZmMOcrGEpqfHHpQks1/A1sytiKGBP9OKTNH
 gSo1tKD/mE2PiPECray29e3ur14RKIG1fvjNSDwWWTx9wzOFBLLdETwX5DBkjLZCg65zegT3FQF
 euHjehYior2dIbz2+9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX82Vk6DsXsqCr
 ajW8d8W2+MH86fzinU9byJiHy8nw5USWK9mtB5gmoQUSHVkqSHUbYtUK3wA2+pwErE7xuy6b9qq
 wSHJb2I61ThHIf7cpXVPblYz9OxYrBA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066

Note: This is just to show the result of running
scripts/update-linux-headers and should be merged with the previous
patch.

Note: This commit fails to compile because it is missing the adjustments
to "system/kvm.h" from the next patch.

Signed-off-by: Bjoern Walk <bwalk@linux.ibm.com>
---
 linux-headers/asm-arm64/hwcap.h      | 159 +++++++++++++
 linux-headers/asm-arm64/kvm.h        |   4 +-
 linux-headers/asm-arm64/ptrace.h     | 337 +++++++++++++++++++++++++++
 linux-headers/asm-arm64/unistd.h     |   2 +-
 linux-headers/asm-loongarch/unistd.h |   6 +-
 linux-headers/asm-mips/unistd.h      |   8 +-
 linux-headers/asm-powerpc/unistd.h   |   4 +-
 linux-headers/asm-riscv/kvm.h        |   4 +-
 linux-headers/asm-riscv/unistd.h     |   6 +-
 linux-headers/asm-s390/unistd.h      |   2 +-
 linux-headers/linux/kvm.h            |   5 +-
 11 files changed, 518 insertions(+), 19 deletions(-)
 create mode 100644 linux-headers/asm-arm64/hwcap.h
 create mode 100644 linux-headers/asm-arm64/ptrace.h

diff --git a/linux-headers/asm-arm64/hwcap.h b/linux-headers/asm-arm64/hwcap.h
new file mode 100644
index 00000000..10272ddb
--- /dev/null
+++ b/linux-headers/asm-arm64/hwcap.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _UAPI__ASM_HWCAP_H
+#define _UAPI__ASM_HWCAP_H
+
+/*
+ * HWCAP flags - for AT_HWCAP
+ *
+ * Bits 62 and 63 are reserved for use by libc.
+ * Bits 33-61 are unallocated for potential use by libc.
+ */
+#define HWCAP_FP		(1 << 0)
+#define HWCAP_ASIMD		(1 << 1)
+#define HWCAP_EVTSTRM		(1 << 2)
+#define HWCAP_AES		(1 << 3)
+#define HWCAP_PMULL		(1 << 4)
+#define HWCAP_SHA1		(1 << 5)
+#define HWCAP_SHA2		(1 << 6)
+#define HWCAP_CRC32		(1 << 7)
+#define HWCAP_ATOMICS		(1 << 8)
+#define HWCAP_FPHP		(1 << 9)
+#define HWCAP_ASIMDHP		(1 << 10)
+#define HWCAP_CPUID		(1 << 11)
+#define HWCAP_ASIMDRDM		(1 << 12)
+#define HWCAP_JSCVT		(1 << 13)
+#define HWCAP_FCMA		(1 << 14)
+#define HWCAP_LRCPC		(1 << 15)
+#define HWCAP_DCPOP		(1 << 16)
+#define HWCAP_SHA3		(1 << 17)
+#define HWCAP_SM3		(1 << 18)
+#define HWCAP_SM4		(1 << 19)
+#define HWCAP_ASIMDDP		(1 << 20)
+#define HWCAP_SHA512		(1 << 21)
+#define HWCAP_SVE		(1 << 22)
+#define HWCAP_ASIMDFHM		(1 << 23)
+#define HWCAP_DIT		(1 << 24)
+#define HWCAP_USCAT		(1 << 25)
+#define HWCAP_ILRCPC		(1 << 26)
+#define HWCAP_FLAGM		(1 << 27)
+#define HWCAP_SSBS		(1 << 28)
+#define HWCAP_SB		(1 << 29)
+#define HWCAP_PACA		(1 << 30)
+#define HWCAP_PACG		(1UL << 31)
+#define HWCAP_GCS		(1UL << 32)
+#define HWCAP_CMPBR		(1UL << 33)
+#define HWCAP_FPRCVT		(1UL << 34)
+#define HWCAP_F8MM8		(1UL << 35)
+#define HWCAP_F8MM4		(1UL << 36)
+#define HWCAP_SVE_F16MM		(1UL << 37)
+#define HWCAP_SVE_ELTPERM	(1UL << 38)
+#define HWCAP_SVE_AES2		(1UL << 39)
+#define HWCAP_SVE_BFSCALE	(1UL << 40)
+#define HWCAP_SVE2P2		(1UL << 41)
+#define HWCAP_SME2P2		(1UL << 42)
+#define HWCAP_SME_SBITPERM	(1UL << 43)
+#define HWCAP_SME_AES		(1UL << 44)
+#define HWCAP_SME_SFEXPA	(1UL << 45)
+#define HWCAP_SME_STMOP		(1UL << 46)
+#define HWCAP_SME_SMOP4		(1UL << 47)
+
+/*
+ * HWCAP2 flags - for AT_HWCAP2
+ */
+#define HWCAP2_DCPODP		(1 << 0)
+#define HWCAP2_SVE2		(1 << 1)
+#define HWCAP2_SVEAES		(1 << 2)
+#define HWCAP2_SVEPMULL		(1 << 3)
+#define HWCAP2_SVEBITPERM	(1 << 4)
+#define HWCAP2_SVESHA3		(1 << 5)
+#define HWCAP2_SVESM4		(1 << 6)
+#define HWCAP2_FLAGM2		(1 << 7)
+#define HWCAP2_FRINT		(1 << 8)
+#define HWCAP2_SVEI8MM		(1 << 9)
+#define HWCAP2_SVEF32MM		(1 << 10)
+#define HWCAP2_SVEF64MM		(1 << 11)
+#define HWCAP2_SVEBF16		(1 << 12)
+#define HWCAP2_I8MM		(1 << 13)
+#define HWCAP2_BF16		(1 << 14)
+#define HWCAP2_DGH		(1 << 15)
+#define HWCAP2_RNG		(1 << 16)
+#define HWCAP2_BTI		(1 << 17)
+#define HWCAP2_MTE		(1 << 18)
+#define HWCAP2_ECV		(1 << 19)
+#define HWCAP2_AFP		(1 << 20)
+#define HWCAP2_RPRES		(1 << 21)
+#define HWCAP2_MTE3		(1 << 22)
+#define HWCAP2_SME		(1 << 23)
+#define HWCAP2_SME_I16I64	(1 << 24)
+#define HWCAP2_SME_F64F64	(1 << 25)
+#define HWCAP2_SME_I8I32	(1 << 26)
+#define HWCAP2_SME_F16F32	(1 << 27)
+#define HWCAP2_SME_B16F32	(1 << 28)
+#define HWCAP2_SME_F32F32	(1 << 29)
+#define HWCAP2_SME_FA64		(1 << 30)
+#define HWCAP2_WFXT		(1UL << 31)
+#define HWCAP2_EBF16		(1UL << 32)
+#define HWCAP2_SVE_EBF16	(1UL << 33)
+#define HWCAP2_CSSC		(1UL << 34)
+#define HWCAP2_RPRFM		(1UL << 35)
+#define HWCAP2_SVE2P1		(1UL << 36)
+#define HWCAP2_SME2		(1UL << 37)
+#define HWCAP2_SME2P1		(1UL << 38)
+#define HWCAP2_SME_I16I32	(1UL << 39)
+#define HWCAP2_SME_BI32I32	(1UL << 40)
+#define HWCAP2_SME_B16B16	(1UL << 41)
+#define HWCAP2_SME_F16F16	(1UL << 42)
+#define HWCAP2_MOPS		(1UL << 43)
+#define HWCAP2_HBC		(1UL << 44)
+#define HWCAP2_SVE_B16B16	(1UL << 45)
+#define HWCAP2_LRCPC3		(1UL << 46)
+#define HWCAP2_LSE128		(1UL << 47)
+#define HWCAP2_FPMR		(1UL << 48)
+#define HWCAP2_LUT		(1UL << 49)
+#define HWCAP2_FAMINMAX		(1UL << 50)
+#define HWCAP2_F8CVT		(1UL << 51)
+#define HWCAP2_F8FMA		(1UL << 52)
+#define HWCAP2_F8DP4		(1UL << 53)
+#define HWCAP2_F8DP2		(1UL << 54)
+#define HWCAP2_F8E4M3		(1UL << 55)
+#define HWCAP2_F8E5M2		(1UL << 56)
+#define HWCAP2_SME_LUTV2	(1UL << 57)
+#define HWCAP2_SME_F8F16	(1UL << 58)
+#define HWCAP2_SME_F8F32	(1UL << 59)
+#define HWCAP2_SME_SF8FMA	(1UL << 60)
+#define HWCAP2_SME_SF8DP4	(1UL << 61)
+#define HWCAP2_SME_SF8DP2	(1UL << 62)
+#define HWCAP2_POE		(1UL << 63)
+
+/*
+ * HWCAP3 flags - for AT_HWCAP3
+ */
+#define HWCAP3_MTE_FAR		(1UL << 0)
+#define HWCAP3_MTE_STORE_ONLY		(1UL << 1)
+#define HWCAP3_LSFE		(1UL << 2)
+#define HWCAP3_LS64		(1UL << 3)
+#define HWCAP3_SVE_B16MM	(1UL << 4)
+#define HWCAP3_SVE2P3		(1UL << 5)
+#define HWCAP3_SME_LUT6		(1UL << 6)
+#define HWCAP3_SME2P3		(1UL << 7)
+#define HWCAP3_F16MM		(1UL << 8)
+#define HWCAP3_F16F32DOT	(1UL << 9)
+#define HWCAP3_F16F32MM		(1UL << 10)
+#define HWCAP3_SVE_LUT6		(1UL << 11)
+
+#endif /* _UAPI__ASM_HWCAP_H */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 6aefe797..56a2cd35 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -34,8 +34,8 @@
 #ifndef __ASSEMBLER__
 #include <linux/psci.h>
 #include <linux/types.h>
-#include <asm/ptrace.h>
-#include <asm/sve_context.h>
+#include "asm-arm64/ptrace.h"
+#include "asm-arm64/sve_context.h"
 
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_VCPU_EVENTS
diff --git a/linux-headers/asm-arm64/ptrace.h b/linux-headers/asm-arm64/ptrace.h
new file mode 100644
index 00000000..99cf2885
--- /dev/null
+++ b/linux-headers/asm-arm64/ptrace.h
@@ -0,0 +1,337 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Based on arch/arm/include/asm/ptrace.h
+ *
+ * Copyright (C) 1996-2003 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _UAPI__ASM_PTRACE_H
+#define _UAPI__ASM_PTRACE_H
+
+#include <linux/types.h>
+
+#include "asm-arm64/hwcap.h"
+#include "asm-arm64/sve_context.h"
+
+
+/*
+ * PSR bits
+ */
+#define PSR_MODE_EL0t	0x00000000
+#define PSR_MODE_EL1t	0x00000004
+#define PSR_MODE_EL1h	0x00000005
+#define PSR_MODE_EL2t	0x00000008
+#define PSR_MODE_EL2h	0x00000009
+#define PSR_MODE_EL3t	0x0000000c
+#define PSR_MODE_EL3h	0x0000000d
+#define PSR_MODE_MASK	0x0000000f
+
+/* AArch32 CPSR bits */
+#define PSR_MODE32_BIT		0x00000010
+
+/* AArch64 SPSR bits */
+#define PSR_F_BIT	0x00000040
+#define PSR_I_BIT	0x00000080
+#define PSR_A_BIT	0x00000100
+#define PSR_D_BIT	0x00000200
+#define PSR_BTYPE_MASK	0x00000c00
+#define PSR_SSBS_BIT	0x00001000
+#define PSR_PAN_BIT	0x00400000
+#define PSR_UAO_BIT	0x00800000
+#define PSR_DIT_BIT	0x01000000
+#define PSR_TCO_BIT	0x02000000
+#define PSR_V_BIT	0x10000000
+#define PSR_C_BIT	0x20000000
+#define PSR_Z_BIT	0x40000000
+#define PSR_N_BIT	0x80000000
+
+#define PSR_BTYPE_SHIFT		10
+
+/*
+ * Groups of PSR bits
+ */
+#define PSR_f		0xff000000	/* Flags		*/
+#define PSR_s		0x00ff0000	/* Status		*/
+#define PSR_x		0x0000ff00	/* Extension		*/
+#define PSR_c		0x000000ff	/* Control		*/
+
+/* Convenience names for the values of PSTATE.BTYPE */
+#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)
+
+/* syscall emulation path in ptrace */
+#define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
+/* MTE allocation tag access */
+#define PTRACE_PEEKMTETAGS	  33
+#define PTRACE_POKEMTETAGS	  34
+
+#ifndef __ASSEMBLER__
+
+/*
+ * User structures for general purpose, floating point and debug registers.
+ */
+struct user_pt_regs {
+	__u64		regs[31];
+	__u64		sp;
+	__u64		pc;
+	__u64		pstate;
+};
+
+struct user_fpsimd_state {
+	__u128		vregs[32];
+	__u32		fpsr;
+	__u32		fpcr;
+	__u32		__reserved[2];
+};
+
+struct user_hwdebug_state {
+	__u32		dbg_info;
+	__u32		pad;
+	struct {
+		__u64	addr;
+		__u32	ctrl;
+		__u32	pad;
+	}		dbg_regs[16];
+};
+
+/* SVE/FP/SIMD state (NT_ARM_SVE & NT_ARM_SSVE) */
+
+struct user_sve_header {
+	__u32 size; /* total meaningful regset content in bytes */
+	__u32 max_size; /* maxmium possible size for this thread */
+	__u16 vl; /* current vector length */
+	__u16 max_vl; /* maximum possible vector length */
+	__u16 flags;
+	__u16 __reserved;
+};
+
+/* Definitions for user_sve_header.flags: */
+#define SVE_PT_REGS_MASK		(1 << 0)
+
+#define SVE_PT_REGS_FPSIMD		0
+#define SVE_PT_REGS_SVE			SVE_PT_REGS_MASK
+
+/*
+ * Common SVE_PT_* flags:
+ * These must be kept in sync with prctl interface in <linux/prctl.h>
+ */
+#define SVE_PT_VL_INHERIT		((1 << 17) /* PR_SVE_VL_INHERIT */ >> 16)
+#define SVE_PT_VL_ONEXEC		((1 << 18) /* PR_SVE_SET_VL_ONEXEC */ >> 16)
+
+
+/*
+ * The remainder of the SVE state follows struct user_sve_header.  The
+ * total size of the SVE state (including header) depends on the
+ * metadata in the header:  SVE_PT_SIZE(vq, flags) gives the total size
+ * of the state in bytes, including the header.
+ *
+ * Refer to <asm/sigcontext.h> for details of how to pass the correct
+ * "vq" argument to these macros.
+ */
+
+/* Offset from the start of struct user_sve_header to the register data */
+#define SVE_PT_REGS_OFFSET						\
+	((sizeof(struct user_sve_header) + (__SVE_VQ_BYTES - 1))	\
+		/ __SVE_VQ_BYTES * __SVE_VQ_BYTES)
+
+/*
+ * The register data content and layout depends on the value of the
+ * flags field.
+ */
+
+/*
+ * (flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD case:
+ *
+ * The payload starts at offset SVE_PT_FPSIMD_OFFSET, and is of type
+ * struct user_fpsimd_state.  Additional data might be appended in the
+ * future: use SVE_PT_FPSIMD_SIZE(vq, flags) to compute the total size.
+ * SVE_PT_FPSIMD_SIZE(vq, flags) will never be less than
+ * sizeof(struct user_fpsimd_state).
+ */
+
+#define SVE_PT_FPSIMD_OFFSET		SVE_PT_REGS_OFFSET
+
+#define SVE_PT_FPSIMD_SIZE(vq, flags)	(sizeof(struct user_fpsimd_state))
+
+/*
+ * (flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_SVE case:
+ *
+ * The payload starts at offset SVE_PT_SVE_OFFSET, and is of size
+ * SVE_PT_SVE_SIZE(vq, flags).
+ *
+ * Additional macros describe the contents and layout of the payload.
+ * For each, SVE_PT_SVE_x_OFFSET(args) is the start offset relative to
+ * the start of struct user_sve_header, and SVE_PT_SVE_x_SIZE(args) is
+ * the size in bytes:
+ *
+ *	x	type				description
+ *	-	----				-----------
+ *	ZREGS		\
+ *	ZREG		|
+ *	PREGS		| refer to <asm/sigcontext.h>
+ *	PREG		|
+ *	FFR		/
+ *
+ *	FPSR	uint32_t			FPSR
+ *	FPCR	uint32_t			FPCR
+ *
+ * Additional data might be appended in the future.
+ *
+ * The Z-, P- and FFR registers are represented in memory in an endianness-
+ * invariant layout which differs from the layout used for the FPSIMD
+ * V-registers on big-endian systems: see sigcontext.h for more explanation.
+ */
+
+#define SVE_PT_SVE_ZREG_SIZE(vq)	__SVE_ZREG_SIZE(vq)
+#define SVE_PT_SVE_PREG_SIZE(vq)	__SVE_PREG_SIZE(vq)
+#define SVE_PT_SVE_FFR_SIZE(vq)		__SVE_FFR_SIZE(vq)
+#define SVE_PT_SVE_FPSR_SIZE		sizeof(__u32)
+#define SVE_PT_SVE_FPCR_SIZE		sizeof(__u32)
+
+#define SVE_PT_SVE_OFFSET		SVE_PT_REGS_OFFSET
+
+#define SVE_PT_SVE_ZREGS_OFFSET \
+	(SVE_PT_REGS_OFFSET + __SVE_ZREGS_OFFSET)
+#define SVE_PT_SVE_ZREG_OFFSET(vq, n) \
+	(SVE_PT_REGS_OFFSET + __SVE_ZREG_OFFSET(vq, n))
+#define SVE_PT_SVE_ZREGS_SIZE(vq) \
+	(SVE_PT_SVE_ZREG_OFFSET(vq, __SVE_NUM_ZREGS) - SVE_PT_SVE_ZREGS_OFFSET)
+
+#define SVE_PT_SVE_PREGS_OFFSET(vq) \
+	(SVE_PT_REGS_OFFSET + __SVE_PREGS_OFFSET(vq))
+#define SVE_PT_SVE_PREG_OFFSET(vq, n) \
+	(SVE_PT_REGS_OFFSET + __SVE_PREG_OFFSET(vq, n))
+#define SVE_PT_SVE_PREGS_SIZE(vq) \
+	(SVE_PT_SVE_PREG_OFFSET(vq, __SVE_NUM_PREGS) - \
+		SVE_PT_SVE_PREGS_OFFSET(vq))
+
+/* For streaming mode SVE (SSVE) FFR must be read and written as zero */
+#define SVE_PT_SVE_FFR_OFFSET(vq) \
+	(SVE_PT_REGS_OFFSET + __SVE_FFR_OFFSET(vq))
+
+#define SVE_PT_SVE_FPSR_OFFSET(vq)				\
+	((SVE_PT_SVE_FFR_OFFSET(vq) + SVE_PT_SVE_FFR_SIZE(vq) +	\
+			(__SVE_VQ_BYTES - 1))			\
+		/ __SVE_VQ_BYTES * __SVE_VQ_BYTES)
+#define SVE_PT_SVE_FPCR_OFFSET(vq) \
+	(SVE_PT_SVE_FPSR_OFFSET(vq) + SVE_PT_SVE_FPSR_SIZE)
+
+/*
+ * Any future extension appended after FPCR must be aligned to the next
+ * 128-bit boundary.
+ */
+
+#define SVE_PT_SVE_SIZE(vq, flags)					\
+	((SVE_PT_SVE_FPCR_OFFSET(vq) + SVE_PT_SVE_FPCR_SIZE		\
+			- SVE_PT_SVE_OFFSET + (__SVE_VQ_BYTES - 1))	\
+		/ __SVE_VQ_BYTES * __SVE_VQ_BYTES)
+
+#define SVE_PT_SIZE(vq, flags)						  \
+	 (((flags) & SVE_PT_REGS_MASK) == SVE_PT_REGS_SVE ?		  \
+		  SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, flags)	  \
+		: ((((flags) & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD ?  \
+		    SVE_PT_FPSIMD_OFFSET + SVE_PT_FPSIMD_SIZE(vq, flags) \
+		  : SVE_PT_REGS_OFFSET)))
+
+/* pointer authentication masks (NT_ARM_PAC_MASK) */
+
+struct user_pac_mask {
+	__u64		data_mask;
+	__u64		insn_mask;
+};
+
+/* pointer authentication keys (NT_ARM_PACA_KEYS, NT_ARM_PACG_KEYS) */
+
+struct user_pac_address_keys {
+	__u128	apiakey;
+	__u128	apibkey;
+	__u128	apdakey;
+	__u128	apdbkey;
+};
+
+struct user_pac_generic_keys {
+	__u128	apgakey;
+};
+
+/* ZA state (NT_ARM_ZA) */
+
+struct user_za_header {
+	__u32 size; /* total meaningful regset content in bytes */
+	__u32 max_size; /* maxmium possible size for this thread */
+	__u16 vl; /* current vector length */
+	__u16 max_vl; /* maximum possible vector length */
+	__u16 flags;
+	__u16 __reserved;
+};
+
+/*
+ * Common ZA_PT_* flags:
+ * These must be kept in sync with prctl interface in <linux/prctl.h>
+ */
+#define ZA_PT_VL_INHERIT		((1 << 17) /* PR_SME_VL_INHERIT */ >> 16)
+#define ZA_PT_VL_ONEXEC			((1 << 18) /* PR_SME_SET_VL_ONEXEC */ >> 16)
+
+
+/*
+ * The remainder of the ZA state follows struct user_za_header.  The
+ * total size of the ZA state (including header) depends on the
+ * metadata in the header:  ZA_PT_SIZE(vq, flags) gives the total size
+ * of the state in bytes, including the header.
+ *
+ * Refer to <asm/sigcontext.h> for details of how to pass the correct
+ * "vq" argument to these macros.
+ */
+
+/* Offset from the start of struct user_za_header to the register data */
+#define ZA_PT_ZA_OFFSET						\
+	((sizeof(struct user_za_header) + (__SVE_VQ_BYTES - 1))	\
+		/ __SVE_VQ_BYTES * __SVE_VQ_BYTES)
+
+/*
+ * The payload starts at offset ZA_PT_ZA_OFFSET, and is of size
+ * ZA_PT_ZA_SIZE(vq, flags).
+ *
+ * The ZA array is stored as a sequence of horizontal vectors ZAV of SVL/8
+ * bytes each, starting from vector 0.
+ *
+ * Additional data might be appended in the future.
+ *
+ * The ZA matrix is represented in memory in an endianness-invariant layout
+ * which differs from the layout used for the FPSIMD V-registers on big-endian
+ * systems: see sigcontext.h for more explanation.
+ */
+
+#define ZA_PT_ZAV_OFFSET(vq, n) \
+	(ZA_PT_ZA_OFFSET + ((vq * __SVE_VQ_BYTES) * n))
+
+#define ZA_PT_ZA_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
+
+#define ZA_PT_SIZE(vq)						\
+	(ZA_PT_ZA_OFFSET + ZA_PT_ZA_SIZE(vq))
+
+/* GCS state (NT_ARM_GCS) */
+
+struct user_gcs {
+	__u64 features_enabled;
+	__u64 features_locked;
+	__u64 gcspr_el0;
+};
+
+#endif /* __ASSEMBLER__ */
+
+#endif /* _UAPI__ASM_PTRACE_H */
diff --git a/linux-headers/asm-arm64/unistd.h b/linux-headers/asm-arm64/unistd.h
index df36f238..f9c4b780 100644
--- a/linux-headers/asm-arm64/unistd.h
+++ b/linux-headers/asm-arm64/unistd.h
@@ -1,2 +1,2 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm/unistd_64.h>
+#include "asm-arm64/unistd_64.h"
diff --git a/linux-headers/asm-loongarch/unistd.h b/linux-headers/asm-loongarch/unistd.h
index e19c7f2f..9a53f745 100644
--- a/linux-headers/asm-loongarch/unistd.h
+++ b/linux-headers/asm-loongarch/unistd.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
-#include <asm/bitsperlong.h>
+#include "asm-loongarch/bitsperlong.h"
 
 #if __BITS_PER_LONG == 32
-#include <asm/unistd_32.h>
+#include "asm-loongarch/unistd_32.h"
 #else
-#include <asm/unistd_64.h>
+#include "asm-loongarch/unistd_64.h"
 #endif
diff --git a/linux-headers/asm-mips/unistd.h b/linux-headers/asm-mips/unistd.h
index 62b86b86..a323a147 100644
--- a/linux-headers/asm-mips/unistd.h
+++ b/linux-headers/asm-mips/unistd.h
@@ -13,26 +13,26 @@
 #ifndef _ASM_UNISTD_H
 #define _ASM_UNISTD_H
 
-#include <asm/sgidefs.h>
+#include "asm-mips/sgidefs.h"
 
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
 #define __NR_Linux	4000
-#include <asm/unistd_o32.h>
+#include "asm-mips/unistd_o32.h"
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
 #define __NR_Linux	5000
-#include <asm/unistd_n64.h>
+#include "asm-mips/unistd_n64.h"
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
 #define __NR_Linux	6000
-#include <asm/unistd_n32.h>
+#include "asm-mips/unistd_n32.h"
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
diff --git a/linux-headers/asm-powerpc/unistd.h b/linux-headers/asm-powerpc/unistd.h
index 2b29bd80..e54f841f 100644
--- a/linux-headers/asm-powerpc/unistd.h
+++ b/linux-headers/asm-powerpc/unistd.h
@@ -11,9 +11,9 @@
 #define _ASM_POWERPC_UNISTD_H_
 
 #ifndef __powerpc64__
-#include <asm/unistd_32.h>
+#include "asm-powerpc/unistd_32.h"
 #else
-#include <asm/unistd_64.h>
+#include "asm-powerpc/unistd_64.h"
 #endif
 
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index 504e7330..26cd9515 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -12,8 +12,8 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/types.h>
-#include <asm/bitsperlong.h>
-#include <asm/ptrace.h>
+#include "asm-riscv/bitsperlong.h"
+#include "asm-riscv/ptrace.h"
 
 #define __KVM_HAVE_IRQ_LINE
 
diff --git a/linux-headers/asm-riscv/unistd.h b/linux-headers/asm-riscv/unistd.h
index 81896bbb..06d51210 100644
--- a/linux-headers/asm-riscv/unistd.h
+++ b/linux-headers/asm-riscv/unistd.h
@@ -14,10 +14,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <https://www.gnu.org/licenses/>.
  */
-#include <asm/bitsperlong.h>
+#include "asm-riscv/bitsperlong.h"
 
 #if __BITS_PER_LONG == 64
-#include <asm/unistd_64.h>
+#include "asm-riscv/unistd_64.h"
 #else
-#include <asm/unistd_32.h>
+#include "asm-riscv/unistd_32.h"
 #endif
diff --git a/linux-headers/asm-s390/unistd.h b/linux-headers/asm-s390/unistd.h
index 14846188..2e77f04d 100644
--- a/linux-headers/asm-s390/unistd.h
+++ b/linux-headers/asm-s390/unistd.h
@@ -8,6 +8,6 @@
 #ifndef _ASM_S390_UNISTD_H_
 #define _ASM_S390_UNISTD_H_
 
-#include <asm/unistd_64.h>
+#include "asm-s390/unistd_64.h"
 
 #endif /* _ASM_S390_UNISTD_H_ */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index aea4ab5c..7a6ebe01 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -2,6 +2,10 @@
 #ifndef __LINUX_KVM_H
 #define __LINUX_KVM_H
 
+#ifndef QEMU_KVM_H
+#error Including <linux/kvm.h> directly is prohibited, use "system/kvm.h" instead
+#endif
+
 /*
  * Userspace interface for /dev/kvm - kernel based virtual machine
  *
@@ -13,7 +17,6 @@
 
 #include <linux/stddef.h>
 #include <linux/ioctl.h>
-#include <asm/kvm.h>
 
 
 #define KVM_API_VERSION 12
-- 
2.56.0

