Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4444E05B;
	Wed, 19 Aug 2026 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133268; cv=none; b=ri708iJ2ZjcaEd4gsUVisUPEJpfTDhT0Oyo98zFBaw/rw3LxCOax2w+8pbECR2Hlhpv47iUYuV/Xp46G6e0MjFkgQLtGTE/BC48BBoJ9R3RIK52oxdBTSPYIwVqrVnLTfD9EWqSjXgWrvf/FMTzURpJj47gmmBg3bby/p90ZXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133268; c=relaxed/simple;
	bh=sqS+snPYKVZCRCXS2ZM/sjjsZEp9XzJ8UJLAmcIVFBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk4z8jnaNCOgJ44V5a/5wTCUtTpt0HGRGh2oU7YodetTqvrDKklydOymJfhg7y6xj2Sxb1a4BwBqc16uBVxk1UN+IQNvdqAb0dkgfl6pFcs8VUBibkSoQSYB3SLOO/B5+9J+AofPNn0RQ/PnToi9EZYbxrA3whROTwY5ht5lcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0V08n9o; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0V08n9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787133265; x=1818669265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sqS+snPYKVZCRCXS2ZM/sjjsZEp9XzJ8UJLAmcIVFBU=;
  b=J0V08n9oeccDEp+J/hQ27WUNBdy6j/QYRc8yoXEv33/kNEL+Io/fi/JA
   BZt8c0T3P96tpTNuQUKY9eOnACMdk+q282YXaPRuJOX0y/WxwT0q04W3q
   zM7PHmgHodeQum0cDtrL4zMKz0a3jDF17hWBT4/Kk9hM2xmkuXYhgZlNF
   usjxfYWFfdx/ne7C5IWntcboiq3LOxXHuv6aKYmE2LLqZP6Ef2Ll1U/5z
   /oflpaoaYT3XmyZ+i7g+M3yF/6XNUI1c4VYFBHGDc4r5gL6QAQTtIian6
   DLTep8D/eQDD7EfgdCn03RmRKLlyM7gHO/uwFeStO71qPhSaLvpBOLlN4
   Q==;
X-CSE-ConnectionGUID: 9vQUPra8T+WaFDOYPM62Tg==
X-CSE-MsgGUID: uTJUbEslR8mPTquCcENIJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87514854"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87514854"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:54:20 -0700
X-CSE-ConnectionGUID: DH1I/gUnQgWMN9V6Vw9gBA==
X-CSE-MsgGUID: Ftx4oFy5TUuDfovSbbISwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303708853"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 02:54:18 -0700
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
Subject: [PATCH v4 3/9] KVM: TDX: Set bits 31:16 to 0 for the synthesized Exit Reason
Date: Wed, 19 Aug 2026 17:48:57 +0800
Message-ID: <20260819094903.3060020-4-xiaoyao.li@intel.com>
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

Set bits 31:16 to 0 instead of all-1s for KVM's synthesized Exit Reason.

KVM is going to support Bus Lock VM exit for TDX, after which bit 26 of
the Exit Reason becomes meaningful and indicates that a bus lock happened.
The existing synthesized Exit Reason, -1u, will cause a false positive in
that case.  Change the synthesized Exit Reason from -1u to U16_MAX, so that
bits 31:16 are set to 0.  This also avoids the potential issues when other
bits in 31:16 become valid in the future.

As a bonus, the check for synthesized Exit Reason in tdx_failed_vmentry()
becomes unnecessary.  Just drop it.

Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
Note, the checking of tdx_failed_vmentry() looks to miss the case where
a real EPT_MISCONFIG happens with failed_vmentry being set.  First, in
practice, EPT_MISCONFIG cannot happen with failed_vmentry being set.
Second, even if it can, this is a pre-existing issue and the next
patch can address it.

Changes in v4:
- Collect R-b from Rick.

Changes in v3:
- split from the patch 2 in v2.
- define a MARCO for the synthesized invalid Exit Reason.
---
 arch/x86/kvm/vmx/tdx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1dead84e6077..4e275cb6927a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -935,13 +935,21 @@ static __always_inline bool tdx_is_exit_reason_valid(u64 vp_enter_ret)
 	}
 }
 
+/* Synthesized invalid Exit Reason */
+#define TDX_INVALID_EXIT_REASON		U16_MAX
+
 static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u32 exit_reason;
 
+	/*
+	 * Return the synthesized invalid Exit Reason, as the TDX module
+	 * never attempted to run the vCPU, i.e. the Exit Reason is undefined,
+	 * but this is NOT a failed VM-Enter.
+	 */
 	if (!tdx_is_exit_reason_valid(tdx->vp_enter_ret))
-		return -1u;
+		return TDX_INVALID_EXIT_REASON;
 
 	exit_reason = tdx->vp_enter_ret;
 
@@ -956,7 +964,7 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
 		 * non-instrumentable code with interrupts disabled.
 		 */
-		return -1u;
+		return TDX_INVALID_EXIT_REASON;
 	default:
 		break;
 	}
@@ -987,8 +995,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 static bool tdx_failed_vmentry(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_exit_reason(vcpu).failed_vmentry &&
-	       vmx_get_exit_reason(vcpu).full != -1u;
+	return vmx_get_exit_reason(vcpu).failed_vmentry;
 }
 
 static fastpath_t tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
-- 
2.43.0

