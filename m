Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21337449B39;
	Wed, 19 Aug 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133276; cv=none; b=rmrTZCbD+yiwUzoTT62om6PuZCIx/7UiNTJ/vTY3Cpz8d+OWwu9paQoU3QWlKVzCyKxVHsf756u7xv0V7IRnnqaa1+2HxNGAZWL9QTjqIXsAqZ1doP07HkgUsy697ATcY2g75eempi4/unO1HHYYhQPz3FONvAE7CskPazNvXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133276; c=relaxed/simple;
	bh=IFIMZt6tYK7hDTH+pkH++eIOLwXZmAnKBFd3ZaAKOPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8fW9FWD3ZQGNa0N2wGEeyQLgNVK8tKaEzhJaTiIQr85TS0TtV81vBFGYFxFYc78MJAqg/IpDoIv03ApCQdTQ5BsoRLAHkTQq+EzbOXl07d1TMkjMHlPzNoevty59z5Ut+8C5LOP7/hnu7jqOQkdMdq24r/5HUsvEM91J35uXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zwk1K+Np; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zwk1K+Np"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787133267; x=1818669267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IFIMZt6tYK7hDTH+pkH++eIOLwXZmAnKBFd3ZaAKOPc=;
  b=Zwk1K+Np44Qc0zPDRQ8TSTEq9P/lMn5AYLmva679n1h0ngZK+pbH8xjB
   70WXyou5+yyDWLHeq7FLso8oXWqkv43IWKQH/+LAvrlzs938eNwFwqnJM
   UxJ6nhSSA1shBvWs2ws3dZ/IKV1PhviReH4lDEo9hDzndMB+9/Ed/7Cui
   D2LVCfT8eRsjeZ58YzqMl1TKYBINbYgnGwWnVq5tucJbqy9GHEgeDsAhM
   7rY+2CyZL2FDONuj11rhcLunsouiVw0WUXaPvsDuJqCLMYZ9ASoeVALUc
   GiceAiA0zOFY6w3lhgw0SXZiJPXKMBQ6NOz1+iyhXGoAuufYHsohSNL/U
   g==;
X-CSE-ConnectionGUID: ugUXu+dKTVOCcxa492i4+w==
X-CSE-MsgGUID: DkToUJhDTiGterKryB7Biw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87514884"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87514884"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:54:23 -0700
X-CSE-ConnectionGUID: WcQt4xfgQ+i1ftWktXVR6g==
X-CSE-MsgGUID: cUz0Ey+DS1yi6OLAMIaUcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303708870"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 02:54:21 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	nik.borisov@suse.com
Subject: [PATCH v4 4/9] KVM: TDX: Don't assume exit_reason[31:16] is all-0 in tdx_to_vmx_exit_reason()
Date: Wed, 19 Aug 2026 17:48:58 +0800
Message-ID: <20260819094903.3060020-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819094903.3060020-1-xiaoyao.li@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
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
valid and it can be 1 with various exit reasons.  Change the logic in
tdx_to_vmx_exit_reason() to check the 'basic' Exit Reason for correctness.
Also preserve bit[31:16] when changing the (basic) Exit Reason, to not
lose the information in bit[31:16].

Change the return type of tdx_to_vmx_exit_reason() to
"union vmx_exit_reason" for the convenience of manipulating the basic
field.

Fixes: c42856af8f70 ("KVM: TDX: Add a place holder for handler of TDX hypercalls (TDG.VP.VMCALL)")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v3:
- new patch split from patch 2 of v2.
---
 arch/x86/kvm/vmx/tdx.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 4e275cb6927a..987092283955 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -938,10 +938,10 @@ static __always_inline bool tdx_is_exit_reason_valid(u64 vp_enter_ret)
 /* Synthesized invalid Exit Reason */
 #define TDX_INVALID_EXIT_REASON		U16_MAX
 
-static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+static __always_inline union vmx_exit_reason tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
-	u32 exit_reason;
+	union vmx_exit_reason exit_reason;
 
 	/*
 	 * Return the synthesized invalid Exit Reason, as the TDX module
@@ -949,22 +949,26 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	 * but this is NOT a failed VM-Enter.
 	 */
 	if (!tdx_is_exit_reason_valid(tdx->vp_enter_ret))
-		return TDX_INVALID_EXIT_REASON;
+		return (union vmx_exit_reason) {
+			.basic = TDX_INVALID_EXIT_REASON,
+		};
 
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
@@ -981,7 +985,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 	tdx->vp_enter_ret = tdh_vp_enter(&tdx->vp, &tdx->vp_enter_args);
 
-	vt->exit_reason.full = tdx_to_vmx_exit_reason(vcpu);
+	vt->exit_reason = tdx_to_vmx_exit_reason(vcpu);
 
 	vt->exit_qualification = tdx->vp_enter_args.rcx;
 	tdx->ext_exit_qualification = tdx->vp_enter_args.rdx;
-- 
2.43.0

