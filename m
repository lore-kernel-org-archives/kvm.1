Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA7344044
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609997; cv=none; b=lfEr+XpnApSpz7fAVSzz+J8j1uM4fE8ruPWls7W+qrmBlTjua07an4xKolkPqZBOvoVOMdTz+yLklWFyDYCuM7pbKFtKvVcb9dp5OIxmoypOVAY2eCvsVcZN2LNryRIX4r8Z/a7c22UyQw5A9zmN8cI2seqYDhdpZd7Qx42aDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609997; c=relaxed/simple;
	bh=EUybIrD6iIx3opTzSPF4HGwFsErCgmud1FE87Ye7rc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3mbEFptQkuOkjBKtN1BP4sBEpieDz6tH7Jr40hgY/R+X0PaVI7tC47O8KKmjYcD55d7D0yjLdemx4fC9e3Hh842EjFVsoyH5ubvkZwNtu8x6Z5DJDN9PPuOeFd2bvVvkrqAmOiV74WGkYhwUlkImo0pwEzX4mUCF5mnDv8RB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qvUgKTle; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qvUgKTle"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIRED1227729;
	Tue, 16 Jun 2026 11:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f9DhG1RZ0xiQUtYCB
	6yQic/njWnuE+L8toJoYSSJ5JE=; b=qvUgKTleNZQ0v2O59SkonrZ9xZj5Ympk4
	hBrzcUlG21g/e9AIhYz+d8m53v1THR1Kk6qvDp5KGCL5NeDjYx3Bci+lYcW8HV93
	xYNnlD0x48/4ToQ+z/bqrslSQi0EyJzToY/dMnGPjlnNGFtiQwHJH2KNYHyEwSKE
	9bI2xCwheaOfoBNqKuJ81yeoa5uLKpdOk/uAwSIxaXi+HQekpAIPBCYN1Cy5Fzof
	4rIv5Ndtc+cpl4naP0IRAZogTxU20s7DZiwiLTVn7KWCbczdf+zXPeZzM6kMxeA7
	QNXuVuvPxoS8T35iDbRVEeRcrz9/aXc7QdWzO8Xs7iku7/X0ubCEQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm5bkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:39:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GBYZuO014602;
	Tue, 16 Jun 2026 11:39:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhq392a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:39:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GBdkkC45547868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 11:39:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3163020049;
	Tue, 16 Jun 2026 11:39:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B61E220040;
	Tue, 16 Jun 2026 11:39:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 11:39:42 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
Date: Tue, 16 Jun 2026 17:09:13 +0530
Message-ID: <20260616113915.25589-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616113915.25589-1-amachhiw@linux.ibm.com>
References: <20260616113915.25589-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX8nmTWoKM21PK
 Fn/0nJgGPrQlsAv7PVaDZK3TblmgyTM0Puss/GIxTTp0haTaLfTLpj3axHWMlJ2/pMZPPCkHePI
 tdTozc51Xhz+peUjY/k4R4OkJ07NIQs=
X-Proofpoint-GUID: yY93XW8x9DzwyHUS2jrVP8D-nFLQtysE
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a313607 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=lArzyTj6eNMAAlWrubwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX6g6cOHX/lZzD
 Lb666X14uapfR9zXg+2Dr7pDlDz8TCWfuJrajEJDicrGkX+LB6zK//+Shpn49K94hkGonvBdKNe
 86ntCMFaq6s64CBBjRfeAjswUIRsOSAVk9paZ/g6ZHnHarhzIdYlY+uEQj2AUUumoth9a0HRk9Q
 U51Cjjr/Aet5JGArW5hoKUEKON6Nh8/7ovXm0qHACnOSHVDERg40lJrRjeQmGoJY/+Zz/o9Ug3D
 inuHgfPO9/50DYOztmdUrOdZIGwR1KrVz0Ko74oQR1+YcFbxl2EZaX/Q2S+KtJscrZAm4MLNhvg
 kQjejP5kqwaGHB2d9PYas5jNTJIEqdt3zy5XYoijVjnMGL/3YB2SaCtxrC2zF7zUV9fFroSHcDQ
 Rxwsc/g6DrjO5VpOOATLz+cTJ6UK3h3i3hSWQ4BmQcg/yd+xMJOZ0/H6AvHjOQx/JGRthUABDrD
 ianW+ze+uK9XthGaDpw==
X-Proofpoint-ORIG-GUID: v9X0rEea5LZfqBY1LZF-OKh4cqrlIfKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160115

This is a temporary patch intended for review and testing purposes only.
It syncs the QEMU linux-headers with the kernel changes that introduce
the KVM_PPC_GET_COMPAT_CAPS ioctl for querying host CPU compatibility
capabilities. This includes the kvm_ppc_compat_caps structure with a
size field for ABI versioning, the KVM_CAP_PPC_COMPAT_CAPS capability
definition, the KVM_PPC_GET_COMPAT_CAPS ioctl definition, and capability
bit definitions for POWER9, POWER10, and POWER11 compatibility modes.

The actual header sync will be done via scripts/update-linux-headers.sh
once the kernel changes [1] are merged upstream.

[1] https://lore.kernel.org/all/20260430054906.94431-1-amachhiw@linux.ibm.com/

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 linux-headers/asm-powerpc/kvm.h | 18 ++++++++++++++++++
 linux-headers/linux/kvm.h       |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 077c5437f521..22ee61bdc812 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -437,6 +437,24 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u64	flags;			/* Reserved for future use */
+	__u64	size;			/* Size of this structure */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
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
+
+
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 50e87ed72c20..a3dbf7c317b9 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -985,6 +985,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_PPC_COMPAT_CAPS 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1329,6 +1330,8 @@ struct kvm_s390_keyop {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS          _IOR(KVMIO,  0xe4, struct kvm_ppc_compat_caps)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.50.1 (Apple Git-155)

