Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F63BFAE7
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160451; cv=none; b=XzjUDMeCTnep5aAzopLj8KC0NmKvRsZhv5V/tighKG56HregUrTrzI1adAw4J7Tn8/DzR/1NzolR0LANIM8KXlwpZXxzSDHei94F9lDaoUbiCfhQstLFUyNgTBKEDZMhU/UBbrT6lPXyQqBQMtAOnfxCgH5jgn3HULI2Wuygtms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160451; c=relaxed/simple;
	bh=UNILhy75v1+SH1piil4wmLH7svGpwzcx2Ev8M5T+kvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzaXYa/ExjpneOFDb5w+OINI+7wyncHmLE9WzIfDhXs2j3nKe3guUfdPYt4I76EPJxjXHxveJwiGEbum8YWkHHGretNSmSD8rJtRV/zwdHZy7oFDK1avZPTyr3+da5swHUa8uoQ/vE8uDoYbVV+NAfX7Emfi+D1Di5QTuIDtr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEtnNllL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEtnNllL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160450; x=1819696450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNILhy75v1+SH1piil4wmLH7svGpwzcx2Ev8M5T+kvE=;
  b=NEtnNllLu2NjQBWO6GWenXUYpgUW1E3g8Kww8mzOfKK8GYNK+3ZQpPYB
   J4xx6UzUAV1TJ+UPSMlwmpKW78No5yQubsnHYGPb6d25IITPUONwhK/Gs
   FUr74V+XjTULmkHayER6yCy27WhVyITeYtfKjCbCXg9FTeoBxhKTCV9IZ
   xnYcx+KfMmUB1oP57+XmvxbXUtVNYvWpJgt4XPJUg85y+24SdFyYHetgH
   z06etl8qJ/lTwGhPbOfxqJxKJoU4bUQ20FKW5NaFaJ5CPu+R33te82efQ
   +coyZTgVFISH3gNFWI4eqoBXqdCkBQaydxquKsIBaZ7MURk7a11f5TNVu
   g==;
X-CSE-ConnectionGUID: euerxWYURcq8HD0dYBe57Q==
X-CSE-MsgGUID: S4817mpDTaiEyP2sCFnYqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99911311"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99911311"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:14:09 -0700
X-CSE-ConnectionGUID: X4LqqWWrQnKwyU7YvyI/9A==
X-CSE-MsgGUID: Dk2WV+IgQESdUdyXvwLdIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="266909731"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.19])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:14:01 -0700
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
Subject: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION and KVM_MIGRATE_CMD
Date: Mon, 31 Aug 2026 10:13:02 +0300
Message-ID: <20260831071304.762939-3-tony.lindgren@linux.intel.com>
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

Live migration of confidential guests needs the help of KVM at least for
TDX.

Add KVM_CAP_LIVE_MIGRATION for when hardware specific live migration
functions must be used.

Add KVM_MIGRATE_CMD to configure the hardware for live migration.

Assisted-by: Claude-Code:claude-opus-5 checkpatch
[ used AI to review and simplify the code ]
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 ++
 arch/x86/include/asm/kvm_host.h    |  2 ++
 arch/x86/kvm/x86.c                 | 25 +++++++++++++++++++++++++
 include/uapi/linux/kvm.h           | 22 ++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 83dc5086138b3..ac080b556b0c8 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -148,6 +148,8 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 KVM_X86_OP_OPTIONAL(gmem_invalidate)
+KVM_X86_OP_OPTIONAL_RET0(cap_live_migration)
+KVM_X86_OP_OPTIONAL(migrate_cmd)
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5f6c1ce9673b7..d9291a8a97bb1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2010,6 +2010,8 @@ struct kvm_x86_ops {
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
 	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
 	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
+	bool (*cap_live_migration)(struct kvm *kvm);
+	int (*migrate_cmd)(struct kvm *kvm, struct kvm_migrate_cmd *cmd);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947a..7064fd709e56d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4973,6 +4973,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_READONLY_MEM:
 		r = kvm ? kvm_arch_has_readonly_mem(kvm) : 1;
 		break;
+	case KVM_CAP_LIVE_MIGRATION:
+		r = kvm ? kvm_x86_call(cap_live_migration)(kvm) : 0;
+		break;
 	default:
 		break;
 	}
@@ -7614,6 +7617,28 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = kvm_vm_ioctl_set_msr_filter(kvm, &filter);
 		break;
 	}
+	case KVM_MIGRATE_CMD: {
+		struct kvm_migrate_cmd cmd;
+
+		if (!kvm_x86_ops.migrate_cmd ||
+		    !kvm_x86_call(cap_live_migration)(kvm))
+			return -ENOTTY;
+
+		if (copy_from_user(&cmd, argp, sizeof(cmd)))
+			return -EFAULT;
+
+		if (cmd.reserved || cmd.buf.reserved)
+			return -EINVAL;
+
+		r = kvm_x86_call(migrate_cmd)(kvm, &cmd);
+		if (r > 0)
+			r = -EIO;
+
+		/* Copy back also on an error to report a partially done command */
+		if (copy_to_user(argp, &cmd, sizeof(cmd)))
+			return -EFAULT;
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 419011097fa8e..e5b227d3a8e40 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -997,6 +997,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_LIVE_MIGRATION 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1350,6 +1351,8 @@ struct kvm_s390_keyop {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+#define KVM_MIGRATE_CMD		  _IOWR(KVMIO, 0xe4, struct kvm_migrate_cmd)
+
 /*
  * ioctls for vcpu fds
  */
@@ -1670,4 +1673,23 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+#define KVM_MIGRATE_SETUP		0
+#define KVM_MIGRATE_ITERATION		1
+#define KVM_MIGRATE_STOP_AND_COPY	2
+#define KVM_MIGRATE_ABORT		3
+#define KVM_MIGRATE_END			4
+
+struct kvm_transfer_buffer {
+	__u64 address;
+	__u32 size;
+	__u32 reserved;
+};
+
+struct kvm_migrate_cmd {
+	__u16 command;
+	__u16 flags;
+	__u32 reserved;
+	struct kvm_transfer_buffer buf;
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.43.0

