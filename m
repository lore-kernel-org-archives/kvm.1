Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81629B766;
	Wed,  5 Aug 2026 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899893; cv=none; b=vGmtTwMBEAPntWeBlMJnDq6Kf6Ug4ZS9PYcwyCt9Kke/d2cUhuhuL76cSyjrezjupOPdhgHivVla4CIVmlcmfeV5+wxCRsstGZhPg0+X3VqxH/eo5ah0urtxsLKGWvgMjY+0WoACpTeMs/F+dp06bZIVIOogSQDxRddANQJeFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899893; c=relaxed/simple;
	bh=cxZf7sLrQvDzI7acg2W0hB1SujLc7zcpUhT7L4sItY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM5ZqYrtAcwTUP0OviwbZp0qCuW+sOa1Em+zJbnQOHg6iinxCCaOalSDflk/XH/bPObgFYFwi2pqlCzfE2f9VzwO/ljfDVlhPqhyXncyiAIFyD5k06inbBVxcbbZy/u0rG1h83kW5HH9IDh67PP1zf22Kw3mK8/kW/DuSod/alA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsSAaIfw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsSAaIfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785899888; x=1817435888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cxZf7sLrQvDzI7acg2W0hB1SujLc7zcpUhT7L4sItY4=;
  b=ZsSAaIfw2GRXHuTCOIBba75AOdwDGUz0nvVxYTdZUrh64p64ulWR3zLJ
   AffqkzOvBw5SRgEXKy70iomMw9+/A6FuR2ykCk4CuACciskXjjpyeOf0R
   OfDNCzrLYJdTzuV85ujIH3vlhT3wZ1oddBe/pjf2pmjgQPVEzBN50c3XY
   m44DhtmQzVVhdpmGiXWb4MpHJN3FCG4ODXXwVFr8KDii/e0H27d2x/Voz
   baa6gYAc7fJmO7UdegoiqTAY2s02u7CGqRlD5NWRWxATWeSEaB13uNlcT
   uF79KOPY4EpARfqUvwYeHPOxhC4S7LlQWyrtTLFTXSxEhfaF52MZzonDJ
   w==;
X-CSE-ConnectionGUID: WtErn++WQha09VXb+OygJw==
X-CSE-MsgGUID: B88HHXmiSPiicRn2craR5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86493978"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86493978"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 20:18:07 -0700
X-CSE-ConnectionGUID: eNRunBjOTrOr4fUG7DeyfQ==
X-CSE-MsgGUID: o9bUmOZPTwOZk8N47Np6rQ==
X-ExtLoop1: 1
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa003.fm.intel.com with ESMTP; 04 Aug 2026 20:18:03 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 2/2] KVM: TDX: Enable Bus Lock VM exit
Date: Wed,  5 Aug 2026 11:12:57 +0800
Message-ID: <20260805031257.1844914-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805031257.1844914-1-xiaoyao.li@intel.com>
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Bus Lock VM exit functionality for TDX guests.

Userspace can enable KVM_BUS_LOCK_DETECTION_EXIT for TDX guests
without getting an error, but the feature is not actually enabled
because KVM does not yet program the TDX execution control or handle
the resulting exit.

Enable Bus Lock VM exit for TDX guests by programming the
BUS_LOCK_DETECTION control in the TD VMCS and by adding the exit
handler.

Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
Cc: stable@vger.kernel.org
Originally-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
The enabling of Bus Lock exit was missed in the initial upstreaming of
TDX base support. We suppose the patch needs to be backported to
stable kernels. So, the cc stable is added.

This patch makes the exit handlers for VMX and TDX look similar, we can
actually consolidate them. However, considering this series needs to be
backported to stable kernel while the consolidation patch doesn't need
to, we plan to send the consolidation patch separately after this series
settles.
---
 arch/x86/kvm/vmx/tdx.c | 23 ++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.c |  2 +-
 arch/x86/kvm/vmx/vmx.h |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index cdc0d24657ac..c037e9cb5bdf 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2031,7 +2031,7 @@ int tdx_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 }
 
 
-int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
+static int __tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u64 vp_enter_ret = tdx->vp_enter_ret;
@@ -2132,6 +2132,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	case EXIT_REASON_NOTIFY:
 		/* NMI blocking state is handled by TDX module */
 		return __handle_notify(vcpu, false);
+	case EXIT_REASON_BUS_LOCK:
+		return handle_bus_lock_vmexit(vcpu);
 	default:
 		break;
 	}
@@ -2141,6 +2143,21 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	return 0;
 }
 
+int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
+{
+	int ret = __tdx_handle_exit(vcpu, fastpath);
+
+	/* Exit to user space when bus lock was detected */
+	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
+		if (ret > 0)
+			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+
+		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
+		return 0;
+	}
+	return ret;
+}
+
 void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
@@ -3167,6 +3184,10 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
 				vcpu->kvm->arch.notify_window);
 	}
 
+	if (vcpu->kvm->arch.bus_lock_detection_enabled)
+		td_vmcs_setbit32(tdx, SECONDARY_VM_EXEC_CONTROL,
+				 SECONDARY_EXEC_BUS_LOCK_DETECTION);
+
 	tdx->state = VCPU_TD_STATE_INITIALIZED;
 
 	return 0;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9c5a7e5c907e..c590eb1e06ee 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6255,7 +6255,7 @@ static int handle_encls(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_X86_SGX_KVM */
 
-static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
+int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 79431b5e9bcb..f2c80e4dc5ac 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -379,6 +379,7 @@ bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned int flags);
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu);
 
 void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type, bool set);
+int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu);
 int __handle_notify(struct kvm_vcpu *vcpu, bool handle_nmi_unblock);
 
 static inline void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu,
-- 
2.43.0

