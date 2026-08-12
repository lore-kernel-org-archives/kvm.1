Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749683B1014;
	Wed, 12 Aug 2026 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522063; cv=none; b=L8cW2KWgPpL86PeImQ+SfV6+UITJHIBV0PSclkwjl7Pq2g9M1Ust1c1wn/xBY16I2/Qha0NZtqHC97Hm5r+rh+I5PKLgNhpqwXysJUc4FwiKy5aacjgoXLvwxViI95AFPuGHtCA9+06VYTqcLnlj1mnMvnVbzBFJYLE1DcQINkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522063; c=relaxed/simple;
	bh=v6R5k+IM3r3avGKDLv0Tr+821cL8yV9/ll5ot0u7LAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY7A/tyBauBL4cqsSdc2cUxdq+QMKap6FnbQw5JhjmcU+tRdVQoN78Id2tTFpuebXXHgbe3Z9z7F3Vd3PdacsGfNSQN5QFd4JPhqeipLMLPNujrI7NsnKhwnZWbvfukBroVMpnjR07K+4KFObwPAA/vDuNNxImYYsA/0bfxmSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4BBemRX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4BBemRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786522063; x=1818058063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6R5k+IM3r3avGKDLv0Tr+821cL8yV9/ll5ot0u7LAQ=;
  b=l4BBemRXNx/wHgjl5eFnb3HLmm8bynYbuDg0U5MOCHjkRDVFPRt93rFc
   +Fk4nK19MjxDhmCKfB15q7aSkS/U8liDxrlQP7tU9b9bz/oV9eoEu80xQ
   RrUoxMN/KXpITk2e3FSRhPqRB2XcvLOD/OSWwlS6182WOgHoymt6nVAXd
   CshzwNjef8DKUs8ZaYTe/HEfds26B49IDoLearkTB3RC4nz0i/dQKfrSR
   jEZr+Y1S+bB2UhXxcAHHTvrt45d99umMBsQYAVepxe7rMoOAwkqEVoexJ
   3NEJBZpNlKoY7RHF0Ld2V3UGUrLxMhNdq3fdCYMksb0jXmmoTba+yIAGM
   g==;
X-CSE-ConnectionGUID: ggkK8QFtRsCPQbiVmoU6yg==
X-CSE-MsgGUID: JXVFxZhMSgWyncyf+Yyb4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97413294"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97413294"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:07:43 -0700
X-CSE-ConnectionGUID: +iW4Mx27Teub2MySXiV4aA==
X-CSE-MsgGUID: 1mrC+tZTR/ey5TJHzooEdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="287000410"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2026 01:07:39 -0700
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
Subject: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0 in tdx_to_vmx_exit_reason()
Date: Wed, 12 Aug 2026 16:02:28 +0800
Message-ID: <20260812080229.2481439-4-xiaoyao.li@intel.com>
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

When handling the real Exit Reason, don't assume the upper 16 bits as
all-0 in tdx_to_vmx_exit_reason(), in preparation for enabling Bus Lock
VM exit.

When Bus Lock VM exit is enabled, the bit 26 of Exit Reason becomes
valid and it can be 1 with various exit reasons. Change the logic in
tdx_to_vmx_exit_reason() to check the basic Exit Reason for correctness.
Also preserve the bit 31:16 when changing the (basic) Exit Reason, to
not lose the information in bit[31:16].

Change the return type of tdx_to_vmx_exit_reason() to
"union vmx_exit_reason" for the convenience of manipulating the basic
field.

Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v3:
- new patch split from patch 2 of v2.
---
 arch/x86/kvm/vmx/tdx.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index df23db9430f0..598b85d772e3 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -924,10 +924,10 @@ static __always_inline u32 tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 /* Synthesized invalid Exit Reason */
 #define TDX_INVALID_EXIT_REASON		U16_MAX
 
-static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+static __always_inline union vmx_exit_reason tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
-	u32 exit_reason;
+	union vmx_exit_reason exit_reason;
 
 	switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
 	case TDX_SUCCESS:
@@ -942,23 +942,27 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 		 * module never attempted to run the vCPU, i.e. the Exit
 		 * Reason is undefined, but this is NOT a failed VM-Enter
 		 */
-		return TDX_INVALID_EXIT_REASON;
+		return (union vmx_exit_reason) {
+			.basic = TDX_INVALID_EXIT_REASON,
+		};
 	}
 
-	exit_reason = tdx->vp_enter_ret;
+	exit_reason.full = (u32)tdx->vp_enter_ret;
 
-	switch (exit_reason) {
+	switch (exit_reason.basic) {
 	case EXIT_REASON_TDCALL:
 		if (tdvmcall_exit_type(vcpu))
-			return EXIT_REASON_VMCALL;
-
-		return tdcall_to_vmx_exit_reason(vcpu);
+			exit_reason.basic = EXIT_REASON_VMCALL;
+		else
+			exit_reason.basic = tdcall_to_vmx_exit_reason(vcpu);
+		break;
 	case EXIT_REASON_EPT_MISCONFIG:
 		/*
 		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
 		 * non-instrumentable code with interrupts disabled.
 		 */
-		return TDX_INVALID_EXIT_REASON;
+		exit_reason.basic = TDX_INVALID_EXIT_REASON;
+		break;
 	default:
 		break;
 	}
@@ -975,7 +979,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 	tdx->vp_enter_ret = tdh_vp_enter(&tdx->vp, &tdx->vp_enter_args);
 
-	vt->exit_reason.full = tdx_to_vmx_exit_reason(vcpu);
+	vt->exit_reason = tdx_to_vmx_exit_reason(vcpu);
 
 	vt->exit_qualification = tdx->vp_enter_args.rcx;
 	tdx->ext_exit_qualification = tdx->vp_enter_args.rdx;
-- 
2.43.0

