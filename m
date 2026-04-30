Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A82E401;
	Thu, 30 Apr 2026 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528244; cv=none; b=b019MnmQQuYzpYGCRo4Txe6LLd05WwDhg+M9orjRgMiJGU36f35HcQ2hncDy1bODJuFbY36/nO4LUAZchNlgS823MW7B9Yt9zE1hqiV1U4QJvCDnkX3a/lW1V3TgcIEKaGyPzgfyXmOVCSbV+F6fjfTuzPEWR9TARmGxX85mkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528244; c=relaxed/simple;
	bh=Vhht9794HXQ938YCN4lGHDlmIYPgUsKnlKPWob5NhMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Obs4q9nyQNRx7S4CpygjMCakEwD7ERdPTRERtOmx26eK8Jt6zofvJ25GLUryzWy+6BYgexysV7h774pmKqCR4O3fhXZb7eJJd38NQ6VOhZVV6Rul7tPfOc1AbtmXzPXkYcn1W/7hIXknThWesBOqIKaCkc9ZU3jjzJzDaukyNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UkvMBih0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UkvMBih0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TGQKwW1381532;
	Thu, 30 Apr 2026 05:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kRHLaJYJOvSkXJuRt
	Sw56wFj4c4/U5VwrUJ/mjyaPbw=; b=UkvMBih0JfGBr7FeRqVutWPTEYvjpu0uN
	0VKc1UILaJxW5xeuLWPaQI7UZffT8dVwS86WzTSUagE9xYJzOVkBFdZFcsOr9jhU
	/ltWDL3PwUjRIIOuwi4xYaxZuRP76o4WaNpvBBjFjJzDiyIKOpHfvIvguFV4FP7A
	a+eoJYb4myO2Rm/b7pf4EZs+Jr+89RvI9VYe2//59wHT8m4scXnF0TX5iPGdK8Is
	51pDBUItTEk/zGiHn9zYIe1EOaID/AXfc/jo4OabTIgWhf9IoR90LbACtyK2zZHu
	9rXmDqu7mECgYsWDbCYgBAN3Kxz7dU0k1vGfu4Px+YPRCzxmoupqA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jvm6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U5crun010301;
	Thu, 30 Apr 2026 05:50:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyhbfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U5oMdX30016064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 05:50:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F37AB20043;
	Thu, 30 Apr 2026 05:50:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 866F420040;
	Thu, 30 Apr 2026 05:50:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 05:50:18 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and KVM_PPC_GET_COMPAT_CAPS
Date: Thu, 30 Apr 2026 11:19:01 +0530
Message-ID: <20260430054906.94431-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260430054906.94431-1-amachhiw@linux.ibm.com>
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX7ApGCVSfmgVV
 VGoO1X7c7/KM7S+/jEddz8GLi8ozSmSRlZ101rbtGkkkOjGP6e4TZ9C+TKXTasN4F51XmFPEZzG
 Fi53qAp9m557zalkUoBWuITS7h1cUcoXI7AKbJlEtJGixO9vtGUoxt9bZPdxHPUyL0Oy8oiAjG/
 iUfDEXTcuH+g5SfOP6LEslivVjdRebfWJoP42gKu9asF3cZC63Wh879yzC/tyIHdaljDYyUAIfv
 7w1p8WZArKoD3IWZneo4cB3h9NXZvWM5cPf4R6bXtbUghxPsCAeglQLR24twAkTXC0Eo/tMGUTf
 5AULVNbp5ZIza584rKOaieFaGZae5t4eBT45b2wXggTCJssOlxEnASArI6lK14uMCJbsQg/X7HW
 aBL2d6UdP5MBYXmU1rRc+18I6kvYyIUti+yVlkf3iZNE5+ov2kWfP6EJNlCNwKPvedZan1j7bKj
 PnjbgBnmJWINs/TK+eQ==
X-Proofpoint-GUID: 96lL4LaNIR1eM_sSVTGwF4xQporZ2bRu
X-Proofpoint-ORIG-GUID: Tp3jD4YFcuJfBz4z8oYH2TTtSLLlwBfk
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f2eda2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lArzyTj6eNMAAlWrubwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300055

Introduce a new capability and ioctl to expose CPU compatibility modes
supported by the host processor for nested guests.

Introduce a new KVM capability, KVM_CAP_PPC_COMPAT_CAPS, and a
corresponding vm ioctl, KVM_PPC_GET_COMPAT_CAPS, to expose processor
compatibility modes supported by the host.

On IBM POWER systems, newer processor generations (N) can operate in
compatibility modes corresponding to earlier generations, like (N-1) and
(N-2). This is particularly relevant for nested virtualization, where
nested KVM guests may need to run with a specific processor compatibility
level.

The new ioctl returns a bitmap describing the compatibility modes
supported by the host in respective bit numbers. This allows userspace
to select an appropriate compatibility level when configuring nested KVM
guests.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/include/uapi/asm/kvm.h | 6 ++++++
 include/uapi/linux/kvm.h            | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 077c5437f521..a38dff7a8aea 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -437,6 +437,12 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u32	flags;
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
+
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf..1788a0068662 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -996,6 +996,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_PPC_COMPAT_CAPS 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1349,6 +1350,9 @@ struct kvm_s390_keyop {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct kvm_ppc_compat_caps)
+
 /*
  * ioctls for vcpu fds
  */
-- 
2.50.1

