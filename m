Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FCE36B04E;
	Wed,  1 Jul 2026 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882899; cv=none; b=hYa6JDMTyNXzTGcH8urHa5BbG8clEqHnR5t/8TSydkZ4x5epcR5cIZywRVc+EGhjQ7A0vgcLBiasx5Tt5mNvweU2sp4YJgSFrqHuMsR2jBQBT8V3OZ2svoj/t6NQViWhiWdsad7GNf8GG135hIa5u7DgF0WLqAUOOFKpfAxjkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882899; c=relaxed/simple;
	bh=j8qgiHrt40czQSm57BikmbHtt9BgKEZVtRsLKvS4Ehg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpOtIYpOnEkSrGYg8FbGwKcpqorh8ly47nhkhBb2TrdEB2JCOv0rUnNAknQ/PX+FrFnyBVVkHaMqCum771LTOoWU4cHOQ/fsp2svnbD3biiCnhYiA+n6yPv0cMDuo94VhElkShnESuMq+uYoljeBOhfhXWf8Z4JqpFIb1bFqk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mIjzacSy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mIjzacSy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613IHIO3805590;
	Wed, 1 Jul 2026 05:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vVH+GeK60J1TwY3fw
	V6UyeqzjFhE+CA3WRk5dvTpynU=; b=mIjzacSyuVByycjzHz5KJSoBwfsgHhFN9
	76tZvl5EENkOhU0GIKBlYPHpMDAnAYhOeCYTwXRZ1FdrDi0L8eV1l7BMHUm6TlK9
	Sn4Y9wOo9WTo0krG0lMK4zCZ6xQ8TIf28JO1+8w9YZIolF8PRa2KAPvvF3IBZv/Z
	ZXb18VnoqfW6inrSstdCpN5NZHT6LyKmH3C/V+oJm8fDVOOl4skSzIMaYtc+18fu
	Sy7KY25jyNaAPsVlX0GowpMJVLMizyDu5sVO6Qbw4C5yBMKxkDVQJKZTA8c3Fejt
	zluHv3tS1aSW7VdzrJVnZ9swkDizsujDz/iOawVsJ5uFDgB+tuNUA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa2b96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66154Z9I004987;
	Wed, 1 Jul 2026 05:14:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhydg65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6615EZCh57278864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 05:14:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42BD020049;
	Wed,  1 Jul 2026 05:14:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CE6620040;
	Wed,  1 Jul 2026 05:14:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 05:14:31 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v5 2/4] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
Date: Wed,  1 Jul 2026 10:44:07 +0530
Message-ID: <20260701051409.51820-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701051409.51820-1-amachhiw@linux.ibm.com>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX4ShGXfVPaB8i
 4smEb80CSvVKC2fXGFnxs9+QPS1Dxs37lUrLoOZ+tojZaBG8ZXIGcNFTNzRnNeZrYxD2DVmzQvE
 0gVZuPINF04Ohx6vVAkNI8Z+KLA4Z6w+1XxnIheTrxS8+zAfisL79uEvclHgDsgEO9tbXc/1end
 jR5ld+OWax1Ox1s93loHm65Dz8guQ/MK0FXuCK4a2o2kR0s3nrKuypwpWLyaKzaQPwAqgmwyFGs
 X/7j6pwxD3GvdIxKpn9kQ2QUn3gDwfJ937yTt73/9Btb7aaWMzGTEEZS9QSGDSy03WSmsJ+JD0t
 tg/B2i7WfBNHHilMukuY2kL7hJBcmrZo0XonQpZJH41rw/SAragmwqfizBlUBZugdaTmZJIU/l7
 d/ZO3SdWH0/+lL6eYQZn8kNyZIyUhv3CxQr57fO3zW7kV2wcpwvriqRZMqpImNzvE8Kyey97u9o
 me+TzNHsh8MX+C81EKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX+ku6qh8IXc8t
 +Hfpqicee1D5UE2pfjfff7OTczeg2Zwr1hEcUoN2c6j2AuLgljgBiZWwaMQ7X0TOkXMbiVuZCUm
 OJIwJZKbFQb2Xqjyzx+j39B8tSe+gR4=
X-Proofpoint-GUID: n-QblzgyyKlGe7YqpsOC4bQAVFcfwAIt
X-Proofpoint-ORIG-GUID: 8-d01y5PKK9fTBKKXdp37bwwt9ItJpAV
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a44a240 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=igDgF-0WGXUSGxExIdQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010046

On POWER systems, the host CPU may run in a compatibility mode (e.g., a
Power11 processor operating in Power10 compatibility mode). In such
cases, the effective CPU level exposed to guests differs from the
physical processor generation.

When running nested KVM guests, QEMU derives the host CPU type using
mfpvr(), which reflects the physical processor version. This can result
in a mismatch between the CPU model selected by QEMU and the
compatibility mode enforced by the host, leading to guest boot failures.

For example, booting a nested guest on a Power11 LPAR configured in
Power10 compatibility mode fails with:

  KVM-NESTEDv2: couldn't set guest wide elements
  [..KVM reg dump..]

This occurs because QEMU selects a CPU model corresponding to the
physical processor (via mfpvr()), while the host operates in a lower
compatibility mode. As a result, KVM rejects the requested compatibility
level during guest initialization.

On pseries nestedv2 systems, add support for retrieving host CPU
compatibility capabilities for nested guests on PowerVM. The capability
bitmap reflects the processor modes negotiated between the Power
hypervisor (L0) and the host partition (L1) via the
H_GUEST_GET_CAPABILITIES hcall, but is retrieved from the cached
nested_capabilities value populated during module initialization,
avoiding repeated hypervisor calls. A WARN_ON_ONCE() flags the
unexpected case where nested_capabilities is zero on a nestedv2 system.
The implementation defines KVM-specific capability constants
(KVM_PPC_COMPAT_CAP_POWER9/10/11), masks unsupported bits, and exposes
the result through the KVM_PPC_GET_COMPAT_CAPS ioctl.

Hook the implementation into the Book3S HV kvmppc_ops so that it can be
invoked by the generic KVM ioctl handling code.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - Updated PowerVM implementation to use cached nested_capabilities instead
    of making a live H_GUEST_GET_CAPABILITIES hcall on every ioctl call
  - Added WARN_ON_ONCE(!nested_capabilities); sanity check when
    nested_capabilities is unexpectedly zero on a nestedv2 system

 arch/powerpc/include/uapi/asm/kvm.h | 10 ++++++++++
 arch/powerpc/kvm/book3s_hv.c        | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 19e53d5ae540..913a64b901a3 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -445,6 +445,16 @@ struct kvm_ppc_compat_caps {
 };
 #define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
 
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
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f9380ef65750..152cd08a5b38 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6523,6 +6523,25 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+
+static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
+{
+	unsigned long capabilities = 0;
+	long rc = -EINVAL;
+
+	if (kvmhv_on_pseries()) {
+		if (kvmhv_is_nestedv2()) {
+			WARN_ON_ONCE(!nested_capabilities);
+			capabilities = nested_capabilities;
+			rc = 0;
+		}
+	}
+
+	host_caps->compat_capabilities = capabilities & KVM_PPC_COMPAT_BITMASK;
+
+	return rc;
+}
+
 static struct kvmppc_ops kvm_ops_hv = {
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -6565,6 +6584,7 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.hash_v3_possible = kvmppc_hash_v3_possible,
 	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
 	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
+	.get_compat_caps = kvmppc_get_compat_caps,
 };
 
 static int kvm_init_subcore_bitmap(void)
-- 
2.50.1 (Apple Git-155)

