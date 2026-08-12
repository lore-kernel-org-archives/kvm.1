Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AD3B2FDD;
	Wed, 12 Aug 2026 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522066; cv=none; b=Dd8VSRnm6yUfz4YG8qccD2I+oVE2MY3mQsKrCYlQDURU402XS8RIhYbSIowMdWsyVhY2dzKhiSqKcFEoYoX/TKH8bbJQfurx/W5YezK3Cjff7UQRGX9jiZE6knuQylSoBv329xTxpp8IKRkAzeofgRhlFCZMx7D3ka2eKrbFFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522066; c=relaxed/simple;
	bh=/xxK/sVc2169K0s9RH/stCB+M2FpxkTpzvDF8K6czKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oChXZ7/s7mROiVTGzI3eHKbP+X+4Nsq3Nb2roa/1DPK3j3R6y4Qx/Xs6+T4WF6RWcXtXmnRkY0Wi2wWpSrUPsUZEo5+SGRGRskjntL1xlQDabX+9ze7p4KlIY5qI0wepfANmQy4CEQn55oRd2kSbWGu28+6H+tgihUxwUU5JVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1Fkz56r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1Fkz56r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786522065; x=1818058065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/xxK/sVc2169K0s9RH/stCB+M2FpxkTpzvDF8K6czKM=;
  b=T1Fkz56rY8AZkd3M4O1JH6rZF4ZS+VnOTCW67FCfREBRcOaYs253ldYs
   P1m4CijcDf704eXDe/9Idgspj8OW9cKLjMlTWLuLk296pyshY+lNd+q26
   jvEPzyu7J87u9d/BU+pykOv/eNCWL3NzaQQ41L9Ppzh0kBhuFCZ4KoQGH
   03giTlFagLUJ1XOXq1u7sMdBPZUlxCfN60dhHeVz6BrQnH2JxzuUEmgt9
   216JVO+KRNnlR2zk2x8vuK2dyLw/sbt8UkBnCMI4tIg3FMBEOkdGCdBPf
   PWBRBTmkqVHX/LMUnoEQnLa6lfhLo4Pg33B4VIJhTM7AEnq4aqeZ5X7ZA
   A==;
X-CSE-ConnectionGUID: JAChmvljQhKIPvCSUe5VKQ==
X-CSE-MsgGUID: MMjUhT9lT2+WQBtHLhvy1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97413304"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97413304"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:07:45 -0700
X-CSE-ConnectionGUID: WAk0Fgo2RJCYCqepHY2b9Q==
X-CSE-MsgGUID: s75ZzNPPRNmF5cA63RJUkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="287000423"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2026 01:07:42 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	nik.borisov@suse.com,
	xiaoyao.li@intel.com
Subject: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
Date: Wed, 12 Aug 2026 16:02:29 +0800
Message-ID: <20260812080229.2481439-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812080229.2481439-1-xiaoyao.li@intel.com>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Bus Lock VM exit functionality for TDX guests.

Bus Lock VM exit is an existing feature supported by KVM.  Userspace can
enable Bus Lock VM exit through KVM_BUS_LOCK_DETECTION_EXIT when it's
reported as supported.  However, KVM reports the support of this CAP
just based on the hardware capability but doesn't differentiate between
VMX and TDX.  This leads to the issue that userspace can enable this cap
for TDX guests without getting an error, but the feature is not actually
enabled because KVM doesn't call the TDX module API to program the
relevant TD VMCS fields.

Enable Bus Lock VM exit for TDX guests by programming the
BUS_LOCK_DETECTION control in the TD VMCS and by adding the exit handler.
Clear the bus_lock_detected bit to avoid being counted multiple times if
it needs to return early for wait_for_sept_zap case in tdx_vcpu_run().
Since the wait_for_sept_zap case is expected to be rare, just do the
clearing of bus_lock_detected unconditionally.

Note, there is no enumeration bit for this feature by TDX module because
all TDX modules support it, and allow to set the TD VMCS as long as the
hardware supports the feature.

Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
Cc: stable@vger.kernel.org
Originally-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v3:
- Refine the changelog. (Rick)

Changes in v2:
- Don't overwrite the negative return value to 0. (Sashiko)
- Clear the bus_lock_detected bit when it returns early for
  wait_for_sept_zap case.
- Add a note to clarify the feature is always supported by the TDX
  module, to make Sashiko happy.
---
 arch/x86/kvm/vmx/tdx.c | 28 ++++++++++++++++++++++++++--
 arch/x86/kvm/vmx/vmx.c |  2 +-
 arch/x86/kvm/vmx/vmx.h |  1 +
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 598b85d772e3..e7047657ef78 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1082,8 +1082,10 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	 * allowing vCPU entry to avoid contention with tdh_vp_enter() and
 	 * TDCALLs.
 	 */
-	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap)))
+	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap))) {
+		vt->exit_reason.bus_lock_detected = 0;
 		return EXIT_FASTPATH_EXIT_HANDLED;
+	}
 
 	trace_kvm_entry(vcpu, run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT);
 
@@ -2039,7 +2041,7 @@ int tdx_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 }
 
 
-int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
+static int __tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u64 vp_enter_ret = tdx->vp_enter_ret;
@@ -2140,6 +2142,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	case EXIT_REASON_NOTIFY:
 		/* NMI blocking state is handled by TDX module */
 		return __vmx_handle_notify(vcpu, vmx_get_exit_qual(vcpu));
+	case EXIT_REASON_BUS_LOCK:
+		return handle_bus_lock_vmexit(vcpu);
 	default:
 		break;
 	}
@@ -2149,6 +2153,22 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	return 0;
 }
 
+int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
+{
+	int ret = __tdx_handle_exit(vcpu, fastpath);
+
+	/* Exit to user space when bus lock was detected */
+	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
+		if (ret > 0) {
+			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+			ret = 0;
+		}
+
+		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
+	}
+	return ret;
+}
+
 void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
@@ -3175,6 +3195,10 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
 				vcpu->kvm->arch.notify_window);
 	}
 
+	if (vcpu->kvm->arch.bus_lock_detection_enabled)
+		td_vmcs_setbit32(tdx, SECONDARY_VM_EXEC_CONTROL,
+				 SECONDARY_EXEC_BUS_LOCK_DETECTION);
+
 	tdx->state = VCPU_TD_STATE_INITIALIZED;
 
 	return 0;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e53cc96002c7..c429db9b9205 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6265,7 +6265,7 @@ static int handle_encls(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_X86_SGX_KVM */
 
-static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
+int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..8faf04c09721 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -379,6 +379,7 @@ bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned int flags);
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu);
 
 void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type, bool set);
+int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu);
 
 static inline void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu,
 						 u32 msr, int type)
-- 
2.43.0

