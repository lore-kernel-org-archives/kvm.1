Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632E47FB13;
	Tue,  4 Aug 2026 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866860; cv=none; b=SlNVN92lZIQ0M9c5+9jkIMk3nCEJQ7Mtn+D6CrtZ2GhbsdBoHx+J7emJ6X16R4nuMmf4Xza48xOJlYbVYv+6IUeeqXLFdX6ldvLSKm6E85UbVJyg9//DXpOttjTnrFGxcLm55eA2qck0DhOBJGavIzEaC0YwKFy9sRU/T98pKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866860; c=relaxed/simple;
	bh=B3rjWNof06DOjcDqnux8sCL6bHk6WPfnoXTVbPROf9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KimOZScynBbegr7JLPYWmdTOnQhj9lkpa4iz3LiqZStV1aMOeGupWxLC0YF0tiSPQzWd9KlgikmE5evOfPyfd3wJetLJ3zi/Z1B5uXeZMwK/9lIlY2mmbCJGQI3klfF057JNCdBDWqD1Zbd7G5OSesKzd4E7N5flaTnQyeoxqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n47OaoXW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n47OaoXW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FlX483598925;
	Tue, 4 Aug 2026 18:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9N6/CMvm+AZ9I1oKQ
	ncAJe5BSR5gGZbV9olUlWdLPpk=; b=n47OaoXW4vWFCmtijplhO6J7NP066/+Kf
	9vRU9+kLbP0c/O2f7Y2BDZUTECemtyi0GLfBdgZOpTOW8grJu/WRWZRIt7xl5Ex8
	u5sC8KrTvv7U11P94n1/5rA0Cem7p+Olz4bPXr9ToXCQU0wYatL98T6B1wh+48kw
	n/SgTNuiKshr4ds8K8KMAk+FIkyUq5FVy4yZLO9dGPburk543Jd4GI7UjL9G9rDU
	u6F+uAaW2L6ejKRMVSEUkbaCHEX09g2uk+tCU+Yl2CA1Lfa3gJlr1h7XDWpwlNsI
	2MBJHGdNrmbedEdTw/vhKBB2fQP8GqVlQKcfdiuvXELhhH8jEf0dA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqq7qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674HuHrp019927;
	Tue, 4 Aug 2026 18:07:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw385t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:07:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674I7KEO45547820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:07:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B50C2004D;
	Tue,  4 Aug 2026 18:07:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E488820040;
	Tue,  4 Aug 2026 18:07:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.28.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:07:16 +0000 (GMT)
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
Subject: [PATCH v6 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
Date: Tue,  4 Aug 2026 23:37:02 +0530
Message-ID: <20260804180705.59160-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804180705.59160-1-amachhiw@linux.ibm.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 53aN_lBO6qGtK__25-6HFX8k_ww-cBF0
X-Proofpoint-ORIG-GUID: L7I7KSYVkNTqgkcjeMrsd__4YB6MV0Og
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfX7XiEGTxyNCh3
 sFz/5Dk58rpAXRVkivxAh//xgx/ttQWhdQZsyYKqRB1RCBeen934FrRjqVISU5bA89EKnU0YpMk
 t//lPDa4eFqGBIEKEy7lRTvfwZlPEDk=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a722a5e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=rQyBRTFaFC3FL7QHXY8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfXymQXocWDRcJ6
 P1bkeC9UNSWfT49o72Y+qDQWQC8OXVcx63/dMSLdAndwA1ei5MpIyZQ639H4PX4EpTfF3qtEaCj
 vrmefVbd4defElpsqRqkI8dU2lZVxuoK3WZWWxlsmpdoR+tnRmNI22hquFQBDvPSxNr84bWA8W1
 JDlziCvLE9p+po6TzO//2UqJNqTFTkscOwXALaBfcpnsu7PU4R0vD5c+3Frb+lU495Sw+zdHms3
 OZqqcbgxxZjgP83N6Lf61Khr05hsI3tbUUCqsq7CnhMuy/SlmTwKIhtg8AOD0fAkuR+pNAcoWIp
 DQqFtKJ9HJjTXN4/O0+Bcwf7wcQz2hWe4wwdoYvIXL849XGoZEOywqiq5tsvPeGxwhlahYmjeNY
 1ACu/1hkbuYYWpLi7c9JAvhkMmOnKtZh84ksoLTJuYlshXi5FWBcN1ModzWzS+wWfx4GHjNrvFx
 2S04o0tnqCaU88YDspw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040144

Introduce a new capability and ioctl to expose CPU compatibility modes
supported by the host processor for nested guests.

On IBM POWER systems, newer processor generations (N) can operate in
compatibility modes corresponding to earlier generations, like (N-1) and
(N-2). This is particularly relevant for nested virtualization, where
nested KVM guests may need to run with a specific processor compatibility
level.

Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
the compatibility modes supported by the host in respective bit numbers,
allowing userspace (e.g., QEMU) to select an appropriate compatibility
level when configuring nested KVM guests.

The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
CPU compatibility capabilities via a PowerPC-specific backend
implementation when available.

The struct kvm_ppc_compat_caps places the 'size' field first so it can
be read alone via get_user() before copy_struct_from_user() is called,
avoiding pointer arithmetic to locate the size field.

The ioctl is defined using _IO so the ioctl number remains stable even if
the struct grows in future versions. It uses copy_struct_from_user() and
copy_struct_to_user() to provide forward- and backward-compatible
extensibility: older userspace passing a smaller struct to a newer kernel
gets zero-padded trailing fields, while newer userspace passing a larger
struct to an older kernel (usize > ksize) gets sizeof(struct
kvm_ppc_compat_caps)written back to host_caps.size so it can retry with the
older kernel-supported size, after which the kernel returns -E2BIG.

KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
(24) marking the size of the initial struct version, used as the
minimum floor for size field validation, similar to other versioned
struct interfaces in the kernel.

The 'flags' field is reserved for future use. The kernel rejects any
call where flags is non-zero with -EINVAL, preventing garbage values
from being baked into ABI permanently.

The ioctl returns appropriate error codes: EINVAL for an invalid size
or non-zero reserved fields, E2BIG if new userspace provides a larger
struct than the kernel knows about (with ksize written back into
host_caps.size for the retry), EFAULT for failed copy operations, and
ENOTTY if the backend doesn't implement get_compat_caps.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - Changed ioctl number from 0xe4 to 0xb8 to avoid the KVM_CREATE_DEVICE
    fd ioctl range (0xe0-0xe3); relocated definition alongside other PPC
    vm ioctls

 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
 arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  3 ++
 4 files changed, 83 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 0953f2daa466..169ea6a7fbad 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -319,6 +319,7 @@ struct kvmppc_ops {
 	bool (*hash_v3_possible)(void);
 	int (*create_vm_debugfs)(struct kvm *kvm);
 	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
+	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 077c5437f521..19e53d5ae540 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -437,6 +437,14 @@ struct kvm_ppc_cpu_char {
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
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b6b83fe3233f..732336092b03 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -703,6 +703,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			}
 		}
 		break;
+#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
+	case KVM_CAP_PPC_COMPAT_CAPS:
+		r = 0;
+		if (kvmhv_on_pseries())
+			r = 1;
+		break;
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 	default:
 		r = 0;
 		break;
@@ -2469,6 +2476,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = kvm->arch.kvm_ops->svm_off(kvm);
 		break;
 	}
+	case KVM_PPC_GET_COMPAT_CAPS: {
+		struct kvm_ppc_compat_caps host_caps = {};
+		u64 usize;
+
+		/*
+		 * Read the size field first to drive copy_struct_from_user.
+		 * size must be the first field of the struct.
+		 */
+		r = -EFAULT;
+		if (get_user(usize, (__u64 __user *)argp))
+			goto out;
+
+		/*
+		 * Enforce a minimum: reject buffers smaller than the initial
+		 * struct version (VER0). This allows old userspace compiled
+		 * against the original struct to still work on a newer kernel
+		 * that has grown the struct with appended fields.
+		 */
+		r = -EINVAL;
+		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
+			goto out;
+
+		/*
+		 * New userspace with a larger struct called an older kernel.
+		 * Write back ksize in host_caps.size so userspace knows which
+		 * older struct to retry with, then fail with -E2BIG.
+		 */
+		if (usize > sizeof(host_caps)) {
+			host_caps.size = sizeof(host_caps);
+			r = -EFAULT;
+			if (put_user(host_caps.size, (__u64 __user *)argp))
+				goto out;
+			r = -E2BIG;
+			goto out;
+		}
+
+		/*
+		 * copy_struct_from_user() handles forward/backward compat:
+		 *   usize == ksize: verbatim copy
+		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
+		 */
+		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
+					  argp, usize);
+		if (r)
+			goto out;
+
+		/* Reserved fields must be zero */
+		r = -EINVAL;
+		if (host_caps.flags)
+			goto out;
+
+		r = -ENOTTY;
+		if (!kvm->arch.kvm_ops->get_compat_caps)
+			goto out;
+
+		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
+		if (r)
+			goto out;
+
+		host_caps.size = sizeof(host_caps);
+		r = copy_struct_to_user(argp, usize, &host_caps,
+					sizeof(host_caps), NULL);
+		break;
+	}
 	default: {
 		struct kvm *kvm = filp->private_data;
 		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 419011097fa8..70e36e6a0ad4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -997,6 +997,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_PPC_COMPAT_CAPS 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1341,6 +1342,8 @@ struct kvm_s390_keyop {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.50.1 (Apple Git-155)

