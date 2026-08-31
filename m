Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF2287510
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160467; cv=none; b=Ux1cG4C71lCJ8IVn2piIhyw+szbOfNIQVVGp9Wpel7/up+MYIT8jPQwUqm+b4/PDk55VaYHB3cDAAgUjGnB9JexpxnpdxJUHFaJ4ArRjyHEP7iuvP5S/StlFeqi5GQS/AnHw8rm1DaGhO/ZNkBxAhkNR+vBU+IvBNRqPYEtMPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160467; c=relaxed/simple;
	bh=+Eg9Q49DYQE7U8wIwJ7HHpHboTUtd+LWM/yIL1QUDC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smUmQKpCzfS5geN5bBfNt7sdZ16pR8gEKirt5dSZCX4VqrjrnUsmv6fOYRPgo0ClKchdeN4R1rlM0DU5N72tI58upBFkUJbC8z4wmJteGJfqkJg9+I9Qq6nUdEqotWmuljNdU/LY4wBhMajPxNM8D1XgR10ApERFEp1TcYrQ8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpCgEw8P; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpCgEw8P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160466; x=1819696466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Eg9Q49DYQE7U8wIwJ7HHpHboTUtd+LWM/yIL1QUDC4=;
  b=EpCgEw8P3ogny6KX539X1nwqcgLqr5zFUxqZcJhhzFBrI5Xs0pCe1/fK
   I8139wmVVQvhxDydpjTSYNX6heFKb07RyI+FFGIKMymB0MEAxM+q4upf6
   WxNTGgyAMGK+/zWuvg6d25dUYrbIU5cAvapk0C9QQnLBNQJgZtNjqCfK9
   4NDUxEKWKUCLf6FYXXMXFhsO4Umdt8l15jBlZIfP3bMeIU5kFxSIZEcr/
   HNJc+mqhRm5D46R/DfHnWVd2VSn1FXpUnAkaRXVzYDWaVDwlORn3LD4vM
   3wWnizWH8zng4Y2MrCM2nsYhzLrq1ly89X+4fW30J8xGZcGaKdMncN+Y2
   A==;
X-CSE-ConnectionGUID: TbMd4goNQauKxgORJwbrSQ==
X-CSE-MsgGUID: Ru/D9wTNQc+0JlBMVyzsfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99911372"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99911372"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:14:25 -0700
X-CSE-ConnectionGUID: bGlu4i4fTuW9KKRqhPp4sA==
X-CSE-MsgGUID: NtZwQqU7QS2u516Bym1Fnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="266909767"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.19])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:14:17 -0700
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
Subject: [RFC PATCH v2 4/4] KVM: x86: Add optional KVM_EXPORT_VCPU and KVM_IMPORT_VCPU
Date: Mon, 31 Aug 2026 10:13:04 +0300
Message-ID: <20260831071304.762939-5-tony.lindgren@linux.intel.com>
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

Add support to export and import VCPU for cases where the VCPU state is
only accessible to the guest. Live migration of confidential computing
needs help of KVM for the firmware specific calls at least for TDX.

Introduce optional KVM_EXPORT_VCPU and KVM_IMPORT_VCPU.

Based on earlier code by Wei Wang <wei.w.wang@intel.com>.

Co-developed-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 ++
 arch/x86/include/asm/kvm_host.h    |  2 ++
 arch/x86/kvm/x86.c                 | 40 ++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h           |  8 ++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 173d0c4f1115e..7f110f80d6f82 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -152,6 +152,8 @@ KVM_X86_OP_OPTIONAL_RET0(cap_live_migration)
 KVM_X86_OP_OPTIONAL(migrate_cmd)
 KVM_X86_OP_OPTIONAL(export_memory)
 KVM_X86_OP_OPTIONAL(import_memory)
+KVM_X86_OP_OPTIONAL(export_vcpu)
+KVM_X86_OP_OPTIONAL(import_vcpu)
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9a517bfc2f3a6..b6362408dab80 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2014,6 +2014,8 @@ struct kvm_x86_ops {
 	int (*migrate_cmd)(struct kvm *kvm, struct kvm_migrate_cmd *cmd);
 	int (*export_memory)(struct kvm *kvm, struct kvm_memory_transfer *mem);
 	int (*import_memory)(struct kvm *kvm, struct kvm_memory_transfer *mem);
+	int (*export_vcpu)(struct kvm_vcpu *vcpu, struct kvm_vcpu_transfer *vcpu_state);
+	int (*import_vcpu)(struct kvm_vcpu *vcpu, struct kvm_vcpu_transfer *vcpu_state);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8a99c665008a3..e8385326894b1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6189,6 +6189,38 @@ static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int kvm_vcpu_ioctl_transfer_vcpu(struct kvm_vcpu *vcpu, bool import,
+					void __user *argp)
+{
+	struct kvm_vcpu_transfer vcpu_state;
+	struct kvm *kvm = vcpu->kvm;
+	int r;
+
+	if (!kvm_x86_call(cap_live_migration)(kvm) ||
+	    (import && !kvm_x86_ops.import_vcpu) ||
+	    (!import && !kvm_x86_ops.export_vcpu))
+		return -ENOTTY;
+
+	if (copy_from_user(&vcpu_state, argp, sizeof(vcpu_state)))
+		return -EFAULT;
+
+	if (vcpu_state.reserved || vcpu_state.buf.reserved)
+		return -EINVAL;
+
+	if (import)
+		r = kvm_x86_call(import_vcpu)(vcpu, &vcpu_state);
+	else
+		r = kvm_x86_call(export_vcpu)(vcpu, &vcpu_state);
+	if (r > 0)
+		r = -EIO;
+
+	/* Copy back also on an error to report a partially done transfer */
+	if (copy_to_user(argp, &vcpu_state, sizeof(vcpu_state)))
+		r = -EFAULT;
+
+	return r;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -6659,6 +6691,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			goto out;
 		r = kvm_x86_ops.vcpu_mem_enc_ioctl(vcpu, argp);
 		break;
+	case KVM_EXPORT_VCPU: {
+		r = kvm_vcpu_ioctl_transfer_vcpu(vcpu, false, argp);
+		break;
+	}
+	case KVM_IMPORT_VCPU: {
+		r = kvm_vcpu_ioctl_transfer_vcpu(vcpu, true, argp);
+		break;
+	}
 	default:
 		r = -EINVAL;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 666bbdf220d65..0a9aa126daadb 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1496,6 +1496,8 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_LIVE_MIGRATION */
 #define KVM_EXPORT_MEMORY	  _IOWR(KVMIO, 0xe5, struct kvm_memory_transfer)
 #define KVM_IMPORT_MEMORY	  _IOWR(KVMIO, 0xe6, struct kvm_memory_transfer)
+#define KVM_EXPORT_VCPU		  _IOWR(KVMIO, 0xe7, struct kvm_vcpu_transfer)
+#define KVM_IMPORT_VCPU		  _IOWR(KVMIO, 0xe8, struct kvm_vcpu_transfer)
 
 #define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
 #define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
@@ -1705,4 +1707,10 @@ struct kvm_memory_transfer {
 	struct kvm_transfer_buffer buf;
 };
 
+struct kvm_vcpu_transfer {
+	__u32 flags;
+	__u32 reserved;
+	struct kvm_transfer_buffer buf;
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.43.0

