Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5444A3E1;
	Wed, 19 Aug 2026 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133266; cv=none; b=b2sVKiPXkiL1EyRhY8+CCCdbF0F8abSTU6R2Xumbh1JzqYo1pNn1jyW/ti4WHYRF6MBcyk+uf2zDGiKiltzqIDFFetNV6dBSARMPhYRvw1OzWjaeXrNev6IrB5pogf9v7/FzYARUCvP/xKOSzr+98B9ZmAHAG/eMSlA3Ckz53Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133266; c=relaxed/simple;
	bh=qxUBLF2aXio14BNU3z4PahoymutUqnCKnIYScYetdQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVkxIEbVzkpos4MR19jsK25PEd2uKwfF+Hvh2pEMyn9m31cj8c+m26vWyPGYItIYtV8pzy1xTCGQgChgOeB4FcPZahpeu7zPnNokN9rwFNITyEAVa45z3Xa/AGIgSxdw2Hva5/HyDJZ06rZ+OGI3Tjbed4uINAcF19SKWMP2EwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5SArvk5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5SArvk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787133261; x=1818669261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxUBLF2aXio14BNU3z4PahoymutUqnCKnIYScYetdQs=;
  b=J5SArvk5Qeg+RaCPICvvPWtr3VbMPrDDKADRyOtNiKwxrLp0XFLm4iXB
   iiTWHHTMkJw/YB484TCIQE5Jhk8w2oZoGNv9PLLPJdL6UeNoya19h2HNX
   XB7MEh62G2Dmlw9h68F8ItRHMg1cA8AOMI0pfbw1tIS/Ice5nNktDC8kN
   iIb5+PFDafdlODSL/EobP0M3bkisovBXRPtj/NNCcU5tPQceNuIQT77Y5
   1KDVwRmwA6Hiuuqh/M5I8ngFRJunSQgRaPMIho1x8VJ5i0J4cxwESodep
   NDn5CEBTV/+uO8gjcNZ06+7wYzgFhypAu0qrmf7+E9DIBRxvJNCug0dec
   w==;
X-CSE-ConnectionGUID: 3/f9Rt2NRlWkzsb81u+7ZQ==
X-CSE-MsgGUID: 90jMdCpQRUyw8SPZKNadKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87514825"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87514825"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:54:17 -0700
X-CSE-ConnectionGUID: PdOQyOaZSwGBNrhuzbzhJg==
X-CSE-MsgGUID: S2AAHbpuRrqJPmN/OhS0ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303708840"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 02:54:15 -0700
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
Subject: [PATCH v4 2/9] KVM: TDX: Check if there is valid exit infos based on vp_enter_ret
Date: Wed, 19 Aug 2026 17:48:56 +0800
Message-ID: <20260819094903.3060020-3-xiaoyao.li@intel.com>
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

Check if there is valid exit info based on vp_enter_ret instead of relying
on the clobbered Exit Reason, in tdx_get_exit_info().

Current KVM uses "Exit Reason is not equal to the synthesized invalid
Exit Reason, -1u," as the condition to identify there is a real TD Exit
and valid exit infos.  However, there is one issue with this approach:
KVM updates the Exit Reason to the synthesized invalid Exit Reason for
real EPT MISCONFIG as well.  This is a false positive for real EPT
MISCONFIG, which has valid exit infos.

Though the issue can be addressed by changing the handling for real EPT
MISCONFIG to not update the Exit Reason to the synthesized one, relying
on the clobbered Exit Reason itself is brittle.  Instead, check
vp_enter_ret directly to identify if it is a valid Exit Reason.

Fixes: da407fe45908 ("KVM: TDX: Handle EPT violation/misconfig exit")
Cc: stable@vger.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v4:
- new patch.
---
 arch/x86/kvm/vmx/tdx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index d557840687d2..1dead84e6077 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -921,21 +921,27 @@ static __always_inline u32 tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	return EXIT_REASON_TDCALL;
 }
 
-static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+static __always_inline bool tdx_is_exit_reason_valid(u64 vp_enter_ret)
 {
-	struct vcpu_tdx *tdx = to_tdx(vcpu);
-	u32 exit_reason;
-
-	switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
+	switch (vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
 	case TDX_SUCCESS:
 	case TDX_NON_RECOVERABLE_VCPU:
 	case TDX_NON_RECOVERABLE_TD:
 	case TDX_NON_RECOVERABLE_TD_NON_ACCESSIBLE:
 	case TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE:
-		break;
+		return true;
 	default:
-		return -1u;
+		return false;
 	}
+}
+
+static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_tdx *tdx = to_tdx(vcpu);
+	u32 exit_reason;
+
+	if (!tdx_is_exit_reason_valid(tdx->vp_enter_ret))
+		return -1u;
 
 	exit_reason = tdx->vp_enter_ret;
 
@@ -2144,7 +2150,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
 	*reason = tdx->vt.exit_reason.full;
-	if (*reason != -1u) {
+	if (tdx_is_exit_reason_valid(tdx->vp_enter_ret)) {
 		*info1 = vmx_get_exit_qual(vcpu);
 		*info2 = tdx->ext_exit_qualification;
 		*intr_info = vmx_get_intr_info(vcpu);
-- 
2.43.0

