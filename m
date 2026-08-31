Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513EE3AB26C
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160459; cv=none; b=HbFq0LxFhwwa7OZHWMR3fZCfR6wiUoleANFPGL136dm0Tcnqdv+FkXeKnuO8qXBnFSOonqgHDVvUh7Kgypv83dBcsBVngwm1ktdEaC4OIfDhLT63cO8FThQbnW524bTPB0WWSZMuJJx/exUPE46ce26ohp2MnMKalH923b7aQVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160459; c=relaxed/simple;
	bh=U/p8MSqi//0efZduan5htTavsmdGmIs+VYH3gGk73P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejaOJOcA7CGGPcZP0xFTILb7wdTfZdOdJjiLFBjcRoD0xi6dmKg+wL7d1A1ENxDJVplTDs3jJ918wCan8C6Apdmkp63qP89uLMtiowFk8tQDteDJM4k9v7boKOmagVu7+iWFz7jgVN3YcYk9PcYyuNE3Wv6/eNujOhb9HpaJ2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNQPTrb8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNQPTrb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160458; x=1819696458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/p8MSqi//0efZduan5htTavsmdGmIs+VYH3gGk73P8=;
  b=KNQPTrb8tBSgYCa2kmHOWGea8TJF70vChuiUstG+m3eJ1SIuUP5GTouR
   47RTnpTNb65pRMmWReRuU0PmCQssjM0iuO5dDfoEBo4z9nIK9yfcEkkEp
   gBv5pkJr3Sa6F9m/vL6+E9tb/2IIXBTyNFUjzPj3WgPqdg3Bym/HP1xKV
   z15VQMdO+OGWZylOMxLEy2YU37Y7b/12qf64Qk/NN/aQoFrsCxoLbGtkx
   EKzJ1VNFrZLFcZdo15n+A1F8sR/8lcyho97RjM6zDPmJQ6NFJvJRoqzeQ
   Xied0Y63aGVy5JYRk1Q0cC6sOzSh4vDwI5PxJRl4DvzfAXRpmkjIr3rOH
   w==;
X-CSE-ConnectionGUID: QuLJGEprRVqKADlAE5BCrQ==
X-CSE-MsgGUID: lOHIkoXuSjap0iXYURQZog==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99911347"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99911347"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:14:17 -0700
X-CSE-ConnectionGUID: 05jMv5zCTZWwZkZSwVwfTQ==
X-CSE-MsgGUID: ayNGJjvdRh+biVtRLkS/sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="266909749"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.19])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:14:09 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Fabiano Rosas <farosas@suse.de>,
	Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>,
	Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?q?Jakub=20R=C5=AF=C5=BEi=C4=8Dka?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?q?J=C3=B6rg=20R=C3=B6del=20?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	kvm@vger.kernel.org
Subject: [RFC PATCH v2 3/4] KVM: x86: Add optional KVM_EXPORT_MEMORY and KVM_IMPORT_MEMORY
Date: Mon, 31 Aug 2026 10:13:03 +0300
Message-ID: <20260831071304.762939-4-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to export and import KVM memory for cases where the memory
is only accessible to the guest. Live migration of confidential computing
needs help of KVM for the vendor specific calls at least for TDX.
Introduce optional KVM_EXPORT_MEMORY and KVM_IMPORT_MEMORY.

Based on earlier code by Wei Wang <wei.w.wang@intel.com>.

Co-developed-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Assisted-by: Claude-Code:claude-opus-5 checkpatch
[ used AI to review and simplify the code ]
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 ++
 arch/x86/include/asm/kvm_host.h    |  2 ++
 arch/x86/kvm/x86.c                 | 37 ++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h           | 13 +++++++++++
 4 files changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index ac080b556b0c8..173d0c4f1115e 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -150,6 +150,8 @@ KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 KVM_X86_OP_OPTIONAL(gmem_invalidate)
 KVM_X86_OP_OPTIONAL_RET0(cap_live_migration)
 KVM_X86_OP_OPTIONAL(migrate_cmd)
+KVM_X86_OP_OPTIONAL(export_memory)
+KVM_X86_OP_OPTIONAL(import_memory)
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d9291a8a97bb1..9a517bfc2f3a6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2012,6 +2012,8 @@ struct kvm_x86_ops {
 	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 	bool (*cap_live_migration)(struct kvm *kvm);
 	int (*migrate_cmd)(struct kvm *kvm, struct kvm_migrate_cmd *cmd);
+	int (*export_memory)(struct kvm *kvm, struct kvm_memory_transfer *mem);
+	int (*import_memory)(struct kvm *kvm, struct kvm_memory_transfer *mem);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7064fd709e56d..8a99c665008a3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7258,6 +7258,37 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 	return -ENOIOCTLCMD;
 }
 
+static int kvm_vm_ioctl_transfer_memory(struct kvm *kvm, bool import,
+					void __user *argp)
+{
+	struct kvm_memory_transfer mem;
+	int r;
+
+	if (!kvm_x86_call(cap_live_migration)(kvm) ||
+	    (import && !kvm_x86_ops.import_memory) ||
+	    (!import && !kvm_x86_ops.export_memory))
+		return -ENOTTY;
+
+	if (copy_from_user(&mem, argp, sizeof(mem)))
+		return -EFAULT;
+
+	if (mem.reserved || mem.buf.reserved || !mem.nr_gfns)
+		return -EINVAL;
+
+	if (import)
+		r = kvm_x86_call(import_memory)(kvm, &mem);
+	else
+		r = kvm_x86_call(export_memory)(kvm, &mem);
+	if (r > 0)
+		r = -EIO;
+
+	/* Copy back also on an error to report a partially done transfer */
+	if (copy_to_user(argp, &mem, sizeof(mem)))
+		return -EFAULT;
+
+	return r;
+}
+
 int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
 	struct kvm *kvm = filp->private_data;
@@ -7639,6 +7670,12 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 			return -EFAULT;
 		break;
 	}
+	case KVM_EXPORT_MEMORY:
+		r = kvm_vm_ioctl_transfer_memory(kvm, false, argp);
+		break;
+	case KVM_IMPORT_MEMORY:
+		r = kvm_vm_ioctl_transfer_memory(kvm, true, argp);
+		break;
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e5b227d3a8e40..666bbdf220d65 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1493,6 +1493,10 @@ struct kvm_enc_region {
 #define KVM_GET_SREGS2             _IOR(KVMIO,  0xcc, struct kvm_sregs2)
 #define KVM_SET_SREGS2             _IOW(KVMIO,  0xcd, struct kvm_sregs2)
 
+/* Available with KVM_CAP_LIVE_MIGRATION */
+#define KVM_EXPORT_MEMORY	  _IOWR(KVMIO, 0xe5, struct kvm_memory_transfer)
+#define KVM_IMPORT_MEMORY	  _IOWR(KVMIO, 0xe6, struct kvm_memory_transfer)
+
 #define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
 #define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
 
@@ -1692,4 +1696,13 @@ struct kvm_migrate_cmd {
 	struct kvm_transfer_buffer buf;
 };
 
+struct kvm_memory_transfer {
+	__u64 gfns;
+	__u32 nr_gfns;
+	__u16 id;
+	__u16 flags;
+	__u64 reserved;
+	struct kvm_transfer_buffer buf;
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.43.0

