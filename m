Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD123AEF2E;
	Wed, 12 Aug 2026 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522061; cv=none; b=I31SGs5xxSTnV+Xw0xdx8P+olZJ0R7GIJ7UGO4bjW7aGdAtaIg72opDL791GeWvTEKUbrc8cggjelhxcFPfMvdYg/ylkz/PNgD5134MDEpzHy0BQ32k1KwDcj9x1dvI2XRoVuunGRb8L5wf+GN5U0AIXeufWM8Dt2FB0ZzR549U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522061; c=relaxed/simple;
	bh=Lu8Qhs9++6B5zuYN8anq/u17JE0wvBoLdBQXd6evmas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSmxpknkywPwlGFB2Lr9V1EUKTV70XtdNbsJdZ5IYzX3gIXR0qtOu+wUy+qwrcALTe4LiRzL11hLWNDpunmi6zJ4XEiF82ntphAN07luktOxZz+EBLIIHxYZjTy82deiHSWOwWISAoFO60VM5YcD+VTXyXymMs3DyIfh69w5LEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WM/L9C7p; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WM/L9C7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786522060; x=1818058060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lu8Qhs9++6B5zuYN8anq/u17JE0wvBoLdBQXd6evmas=;
  b=WM/L9C7p/fKdFGqP0QEWP16gMGhQjXuYd5jzLR/bqLPhfwKVqi7oyD1o
   2vL1POSPDFlUyt6yerTJh+9+o71wh+GCvA3asRnHpPQybVUSX7gfouWSg
   0xkilndSNIqS3YHYLPt9nMXtc1zIPHYWG1aYt89oBEKGBTdrEEs+NGnda
   rcT567KSkp5GED4jFwA9HTOBVYYNNSFO8Pi2Sp8edVICNjtMGjmFeCALN
   lUU+DA/pbbYv+/msIdrxwGUEnLjCstdF8ZQe7+JroY9DWWZVHIumWCaY3
   k3W+d+2HXCp3BituLuGiDRm3ElIlS2M+LA4MaLnFzN6aNEpIfFSWVHGcP
   w==;
X-CSE-ConnectionGUID: 4o0tNQhUQz+p4WD/UZh0wg==
X-CSE-MsgGUID: 3j/yW3IKTLKRB0XTuwcsPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97413278"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97413278"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:07:40 -0700
X-CSE-ConnectionGUID: PvpEugD9R9ycPwWbXvs4Mg==
X-CSE-MsgGUID: qp5D6KbHQi+WsGgV//ZOSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="287000395"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2026 01:07:37 -0700
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
Subject: [PATCH v3 2/4] KVM: TDX: Set bits 31:16 to 0 for the synthesized Exit Reason
Date: Wed, 12 Aug 2026 16:02:27 +0800
Message-ID: <20260812080229.2481439-3-xiaoyao.li@intel.com>
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

Set bits 31:16 to 0 instead of all-1s for KVM's synthesized Exit Reason.

KVM is going to support Bus Lock VM exit for TDX, after which bit 26 of
the Exit Reason becomes meaningful and indicates that a bus lock happened.
The existing synthesized Exit Reason, -1u, will cause a false positive in
that case.  Change the synthesized Exit Reason from -1u to U16_MAX, so that
bits 31:16 are set to 0.  This also avoids the potential issues when other
bits in 31:16 become valid in the future.

As a bonus, the check for synthesized Exit Reason in tdx_failed_vmentry()
becomes unnecessary. Drop it.

Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Note, the checking of (*reason != TDX_INVALID_EXIT_REASON) in
tdx_get_exit_info() can cause a false-positive when the real exit reason
is EPT_MISCONFIG. This issue is orthogonal to enabling Bus Lock VM exit and
it's not urgent since EPT_MISCONFIIG is not supposed to happen unless
current KVM code is buggy. We leave the fix for this issue to the future.

Note, #2, the checking of tdx_failed_vmentry() seems to miss the case
where a real EPT_MISCONFIG happens with failed_vmentry being set.
First, in practice, EPT_MISCONFIG cannot happen with failed_vmentry being
set. Second, even if it can, this is an pre-existing issue and the next
patch can address it.

Changes in v3:
- split from the patch 2 in v2.
- define a MARCO for the synthesized invalid Exit Reason.
---
 arch/x86/kvm/vmx/tdx.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 7338ac0af693..df23db9430f0 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -921,6 +921,9 @@ static __always_inline u32 tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	return EXIT_REASON_TDCALL;
 }
 
+/* Synthesized invalid Exit Reason */
+#define TDX_INVALID_EXIT_REASON		U16_MAX
+
 static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
@@ -934,7 +937,12 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	case TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE:
 		break;
 	default:
-		return -1u;
+		/*
+		 * Return the synthesized invalid Exit Reason, as the TDX
+		 * module never attempted to run the vCPU, i.e. the Exit
+		 * Reason is undefined, but this is NOT a failed VM-Enter
+		 */
+		return TDX_INVALID_EXIT_REASON;
 	}
 
 	exit_reason = tdx->vp_enter_ret;
@@ -950,7 +958,7 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
 		 * non-instrumentable code with interrupts disabled.
 		 */
-		return -1u;
+		return TDX_INVALID_EXIT_REASON;
 	default:
 		break;
 	}
@@ -981,8 +989,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 static bool tdx_failed_vmentry(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_exit_reason(vcpu).failed_vmentry &&
-	       vmx_get_exit_reason(vcpu).full != -1u;
+	return vmx_get_exit_reason(vcpu).failed_vmentry;
 }
 
 static fastpath_t tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
@@ -2144,7 +2151,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
 	*reason = tdx->vt.exit_reason.full;
-	if (*reason != -1u) {
+	if (*reason != TDX_INVALID_EXIT_REASON) {
 		*info1 = vmx_get_exit_qual(vcpu);
 		*info2 = tdx->ext_exit_qualification;
 		*intr_info = vmx_get_intr_info(vcpu);
-- 
2.43.0

