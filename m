Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089C347BD7
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787115588; cv=none; b=NX961hCPSkEYj9m0tTQ39/yIZSKsub75TZP/tlR7y4Zzzk5scrGfoB7XXwHj0rVT1nsGL8Tm1Ow2hzjzmMjNtSKCC7lBf3eCDUQEK8YZLKAFSW700x0XgAQrSgmqiMAqNf0Up0N2jtDvyG20XwXDDDhOrTBnrY4C8z/2fG+ybdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787115588; c=relaxed/simple;
	bh=8k/Qmmlos1eSgba14budLNWaJJRtVzMlO3ziiY6Ze6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1L0CBjQ6HR95EBbLO2PHj9vDQJr/YhRtqVOQpSQ67abKnreZMv2HRwJmqEsKFb7ioQkH9yNE7Namyqa6uJOEofcAKtc9zoS/qjrJaQfmkQXlczEa1PHDXoPdcuw19EOpFxcyOgBV2MajaMvRvqB1YxSdJruNuL5eR5R5oovDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RNcMApCu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RNcMApCu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J31T0n2174981;
	Wed, 19 Aug 2026 04:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iUmV/PM7Ld9PwfsfRcvm3fEvssMVhV6s8ClnLD1Gz
	0U=; b=RNcMApCuaUPxKbL5/bFa8bSgTD94smjsV9iAVToOKnmHTofH/LHGJdNMd
	eDk7/4vWYEnycuIQoSS91CP44bX5kyEtfSmvCGrmAvq0CCTXJavKbSE+Y0xWOcMc
	/xaFzInLxo2N3CTOzOsxC8EBAQxl6sjuHHfCzqh1s46NxWASx01letySUWCBStAN
	yGQ4Ks1yutAtRDRnyuVIonlOG7/kozQjYWit6zXjtmIK22sL2MfS85Hy0aMzOsAa
	hykIAC5OM7cKfhsEbpeig/79wFw8crENt1QNPk1KpOVwZJQhmatMcH9x/H9ZLKT3
	jM7D3LoQrRiWaROm45o2vC+4mZFtg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu19kx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 04:59:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J4uZ1W007445;
	Wed, 19 Aug 2026 04:59:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw7996-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 04:59:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J4xUjv45613374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 04:59:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25B032004B;
	Wed, 19 Aug 2026 04:59:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3988620040;
	Wed, 19 Aug 2026 04:59:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.17.134])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 04:59:27 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH] linux-headers: Update to include KVM_CAP_PPC_COMPAT_CAPS
Date: Wed, 19 Aug 2026 10:29:24 +0530
Message-ID: <20260819045924.11732-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a853839 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FAdeBzD3L_d8WbVtQBUA:9
X-Proofpoint-GUID: mjM-StOYGVeV43p_KmjF2LAfImHgw8DD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzMSBTYWx0ZWRfXwkKWxlnFSZ5y
 nRbxYVEmX4g0i1WsfitF1IpwMYPnTAbQOTbcbkqvyfkavIttu3NPN47pAxBbRp1wO80CB1fk90Y
 jtHE8ms7hmXpgNri6c3PppaLCuxUQrA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzMSBTYWx0ZWRfX7jTOgaseD+Yl
 vqtoNdGnewpwlwh76xNkQjuwzUQqO55egmzw+wOSel0TuSP+QrAiQELS1JtXg+jyVSM+kHXwA/L
 SkBe2R85KakrLeKetaMBnbUN8vyd0NqDV4GogFws02x1TIIPmhbc5Z/zDPRyUINzQ+XxNxu8Cza
 q4pcQJ2rRpIm/Ux320+nI9xoQ4yPhZwDhHOIe2WrrSXhpikebrlZKIoqPhndMe6nJ+YOe3cNZQG
 x4l5n08dfqdjKdVu1mHhCbynwLjhq27NFVpAQ7XtjhtiMCz52GljvihscJijO5VvVVWHX3oZdpd
 RReImO5Bj7gJaREUzBqbQPmwPospCzYAn3S2duyV0Ay0kMc97K+ppHGVGVsiVWkDs5Tp8MKM62i
 QJWpFpGVdTSrICDSmEqiJUgJNnC0DNCgg96xyBgbtBDoDh27ELc6j9BQTkG2k91dOF75mlHiSnE
 b35w9qZ+qqlQqDSWaRQ==
X-Proofpoint-ORIG-GUID: mjM-StOYGVeV43p_KmjF2LAfImHgw8DD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190031

Sync linux headers from Linux kernel commit 1200d84f4c0a
("Merge tag 'powerpc-7.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux").

This picks up the new KVM_CAP_PPC_COMPAT_CAPS capability for powerpc,
which introduces:
- struct kvm_ppc_compat_caps: reports processor compatibility modes
  supported by the host (POWER9, POWER10, POWER11)
- KVM_PPC_GET_COMPAT_CAPS ioctl (KVMIO 0xb8)
- KVM_CAP_PPC_COMPAT_CAPS (cap #250) in linux/kvm.h

The sync is needed to get the corresponding Qemu series[1] merged.

[1]: https://lore.kernel.org/all/20260812170854.58709-1-amachhiw@linux.ibm.com/

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 include/standard-headers/linux/const.h  |  4 ++--
 linux-headers/asm-arm64/unistd_64.h     |  1 +
 linux-headers/asm-generic/unistd.h      |  6 +++++-
 linux-headers/asm-loongarch/unistd_64.h |  1 +
 linux-headers/asm-mips/unistd_n32.h     |  1 +
 linux-headers/asm-mips/unistd_n64.h     |  1 +
 linux-headers/asm-mips/unistd_o32.h     |  1 +
 linux-headers/asm-powerpc/kvm.h         | 18 ++++++++++++++++++
 linux-headers/asm-powerpc/unistd_32.h   |  1 +
 linux-headers/asm-powerpc/unistd_64.h   |  1 +
 linux-headers/asm-riscv/unistd_32.h     |  1 +
 linux-headers/asm-riscv/unistd_64.h     |  1 +
 linux-headers/asm-s390/unistd_64.h      |  1 +
 linux-headers/asm-x86/unistd_32.h       |  1 +
 linux-headers/asm-x86/unistd_64.h       |  1 +
 linux-headers/asm-x86/unistd_x32.h      |  1 +
 linux-headers/linux/const.h             |  4 ++--
 linux-headers/linux/kvm.h               |  3 +++
 18 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/include/standard-headers/linux/const.h b/include/standard-headers/linux/const.h
index c6a9d0c9835c..92635cec4aed 100644
--- a/include/standard-headers/linux/const.h
+++ b/include/standard-headers/linux/const.h
@@ -13,7 +13,7 @@
  * leave it unchanged in asm.
  */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
 #else
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * Missing __asm__ support
  *
diff --git a/linux-headers/asm-arm64/unistd_64.h b/linux-headers/asm-arm64/unistd_64.h
index 70b3754a4247..4329a2ad54c2 100644
--- a/linux-headers/asm-arm64/unistd_64.h
+++ b/linux-headers/asm-arm64/unistd_64.h
@@ -328,6 +328,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index a627acc8fb5f..5b7e77a7c736 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -863,8 +863,12 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+/* fs/open.c */
+#define __NR_fchroot 472
+__SYSCALL(__NR_fchroot, sys_fchroot)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 473
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-loongarch/unistd_64.h b/linux-headers/asm-loongarch/unistd_64.h
index 3a29d86e1dee..b525f2d7b881 100644
--- a/linux-headers/asm-loongarch/unistd_64.h
+++ b/linux-headers/asm-loongarch/unistd_64.h
@@ -325,6 +325,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index 5fa1ee0cb465..f883da76c999 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -400,5 +400,6 @@
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
 #define __NR_rseq_slice_yield (__NR_Linux + 471)
+#define __NR_fchroot (__NR_Linux + 472)
 
 #endif /* _ASM_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index e1f873d83a5d..59837eb86628 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -376,5 +376,6 @@
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
 #define __NR_rseq_slice_yield (__NR_Linux + 471)
+#define __NR_fchroot (__NR_Linux + 472)
 
 #endif /* _ASM_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index 8207e9ca4f67..485872076e92 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -446,5 +446,6 @@
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
 #define __NR_rseq_slice_yield (__NR_Linux + 471)
+#define __NR_fchroot (__NR_Linux + 472)
 
 #endif /* _ASM_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 077c5437f521..913a64b901a3 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -437,6 +437,24 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u64	size;			/* Size of this structure */
+	__u64	flags;			/* Reserved for future use */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
+#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
+
+/*
+ * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
+ * These bits indicate which processor compatibility modes are supported.
+ */
+#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
+#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
+#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
+#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
+					 KVM_PPC_COMPAT_CAP_POWER10 | \
+					 KVM_PPC_COMPAT_CAP_POWER11)
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index 1f633601201b..2677c54903a4 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -453,6 +453,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index 87439c53c121..6fc19ccccdb9 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -425,6 +425,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-riscv/unistd_32.h b/linux-headers/asm-riscv/unistd_32.h
index 828f3c2b9de1..1039bdc6cf5b 100644
--- a/linux-headers/asm-riscv/unistd_32.h
+++ b/linux-headers/asm-riscv/unistd_32.h
@@ -319,6 +319,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-riscv/unistd_64.h b/linux-headers/asm-riscv/unistd_64.h
index 8fa59835a333..72040a54987a 100644
--- a/linux-headers/asm-riscv/unistd_64.h
+++ b/linux-headers/asm-riscv/unistd_64.h
@@ -329,6 +329,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 01f674c1bcb7..3d3747e3ca1f 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -391,6 +391,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index e94546882962..7f298247f805 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -462,6 +462,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 3c49b00ed13c..fbddeb4bc381 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -386,6 +386,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index bd2af9ad088d..629770ed4baa 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -339,6 +339,7 @@
 #define __NR_file_setattr (__X32_SYSCALL_BIT + 469)
 #define __NR_listns (__X32_SYSCALL_BIT + 470)
 #define __NR_rseq_slice_yield (__X32_SYSCALL_BIT + 471)
+#define __NR_fchroot (__X32_SYSCALL_BIT + 472)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/const.h b/linux-headers/linux/const.h
index c6a9d0c9835c..92635cec4aed 100644
--- a/linux-headers/linux/const.h
+++ b/linux-headers/linux/const.h
@@ -13,7 +13,7 @@
  * leave it unchanged in asm.
  */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
 #else
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * Missing __asm__ support
  *
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index dd52e2a65bfd..aea4ab5c6953 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -986,6 +986,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_PPC_COMPAT_CAPS 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1330,6 +1331,8 @@ struct kvm_s390_keyop {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)

base-commit: fa19879df1658f96ac07365fca8835b7decd6995
-- 
2.50.1 (Apple Git-155)

