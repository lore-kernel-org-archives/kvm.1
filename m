Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A23CB2D7;
	Fri,  7 Aug 2026 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123524; cv=none; b=cKVXm4IKEb5xnEi1yA/B0ihw5CB7eoOEybn+0F1pUWOL6nzZWmhBt0aXJN/rKmkCPTdckLfKYd/ZhoAH7rxD+GftCIp5kxQxI186ZQjKC7DDo2XgS/kbuHxesd2WM302jVO3F0fScal4NvLqJ1AKkxt6h8rBAJIOJNSWf/Q2uVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123524; c=relaxed/simple;
	bh=8SJaesSmEMz50q645V+iXmIoBbDesixH+uHDXS6TbAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRMnCydCImxb2EZkH9YLWqfhPk8PIyykkZbpySlavPp0er/DIM2o3VsGKiFDLS3KH8ZiJqmaCK4nNCrcBTgO9XjMK2V387V5HkQcZHMecMWhd1kPHzMP/Ma9J1+K6K9l0DGc/3JSKiOwMCB0fK9njmV7Cb7OHW+LlA5DiCXF/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Oo5/c2sx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oo5/c2sx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Gm16d2078702;
	Fri, 7 Aug 2026 17:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6ZsR7bxa41ZnjXxzT
	z2yS40d1f72fEwF8oWdyBI1bAo=; b=Oo5/c2sx5qIM0lm+AYjRdD7bWu2HFfWvC
	c0u9HGqc1t4so3ZPdaeIBTBwH2cHV88hmGt9ZUAll3a6XWhq5v6u5brMfYekf/Zr
	6PxdYVF6Xo0TCJ1TKCFrGejXTeSZUy7UXZAhEdpP51BvSOCnbhSGOxNUfE2EbZ1x
	dlz6Aphw5FQsut9R92GmYhbur/KjGVnjcgVUrUYZoxqyOZiY5kgancPWxFpcigcs
	lqzN5nIpwFAjrvH5qD1VY1jbapd7hV+LDkitZ7Xxn/LdGnY04sWiql0c79xrErRP
	CBjeS4Ry35kntLrBPVBCtdKpvRYA1RHNmwCnk13x2IlEabJrYQaaA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00cwjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:24:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GuNx3010399;
	Fri, 7 Aug 2026 17:24:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhrk1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:24:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677HOrmT48628166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 17:24:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AE0D20043;
	Fri,  7 Aug 2026 17:24:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 864B320040;
	Fri,  7 Aug 2026 17:24:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.72])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 17:24:49 +0000 (GMT)
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
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v8 2/4] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
Date: Fri,  7 Aug 2026 22:54:31 +0530
Message-ID: <20260807172433.82045-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807172433.82045-1-amachhiw@linux.ibm.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX24IehhchE8HV
 D3NX4bSlbA039NPj7ZTtjBCyw8Nutya8L2ZogMwvCnnEPmboJrIPXp5ZkCpjlh1HDwE3C5S/AyJ
 XQceclZBfQH3G7RfJzi+dCDa+op9WcI=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a7614ea cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=igDgF-0WGXUSGxExIdQA:9
X-Proofpoint-ORIG-GUID: 7odzluqe5z2V-guF_F8BWQZJN--6fgRI
X-Proofpoint-GUID: R6dKHr4Il_rg6qblzO-AaOZDgoQ4H3Nq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX3wjYt9VeR/Gl
 xx72fgEQekb32RMvQOzKyemJ+YYyT0Jw6hqy81tPQT6AtJgwzXyQMKNmtXiGUJImr8SNTOAfneq
 +Y5b1Racap9YsX05hfThVNN+/goAa2FL4JuWISbHrS8qejdnAGqRetkKXYM4kz7+y0nzkK3EHWT
 Shu1WaQQ0sXXAD8C0FHA2IHahhyr8xDsps+xXbUcvul2wwtN6nt/QlvgC0n2goeW2rGXvXFBg11
 o8uHm03dp9AgGdMiwHb+bf/IXlTX6e6a/1jeVVFUaLti60a+E1YQWii4gLza2vmQlRSPnBW01na
 2sU1fY3qeSaO7oHzVeyZvhAykvHKHB6HbdopTN9WzYz+F5ATQwiv8dbm1XC3v75s56+1qSOnein
 jgReLgtLutsnSjdwaJthCkFRKhY8LFYdduqJnIXwnPsPHN8UNstQY0lNv0SlsBP6uVhefbtD2yp
 NLPhsVSd0iwzbE+3Iug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070135

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
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
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

