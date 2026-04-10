Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE60388364;
	Fri, 10 Apr 2026 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863623; cv=none; b=Oo3pJB8ag8PdeMcd0tEsMqL/HLfMN2KchZQkrikxUooItBNPbyhJfdDpwZUhOhsqZv2kBw+NyhuwDP89gWgfYvNaEp2CBhZb9bqBCQnmPxeDMGc0qdIgUwIWCoxOQ+jdO54Gl2pgh1XICfWlY16iqnxHT63PWTJMZXwO3cunW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863623; c=relaxed/simple;
	bh=UGP5izu4nnpiCHFMCNeJx2oAVUkflwDSrC1V1t4b8vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MloSMYTU2hZ2W8dVGR2Rm0wBjE0CzLva7aFxlPQaG9YWpmDWsREQQLSRXztSC6pZ08P8QvCc6/0231LaoLtRSjdcQDqaDRRu4hIH9uk5qCyHv2nHD2mWmhV/t59IKFNBjvuhNjGiBSQsWPKA2jrdVQ9eRaH7dF8FrUfWZf+zqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYxaTz6b; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYxaTz6b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775863622; x=1807399622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UGP5izu4nnpiCHFMCNeJx2oAVUkflwDSrC1V1t4b8vE=;
  b=bYxaTz6b6rxrSO0Go/en6ZC9mVShu/jcooLjxZWzhIlTyGelNC0c5OD1
   HieyXt9EEXBYgLZ8DGoSfmDTpBCWZbjodHH79BxGrT3loKvCwflz6r7WS
   U94y6yg2cLoyp49bvhiJy/60025kNL8hacWNWBya/8aMRAtzYdRj0MA7k
   pN/giqxVRSq+mtNiiQkjKKcNJ2dsYiOtBml409AMauTIV+Y/AU9Gk76Su
   8YaD5YfM2j/W5hHcxW5aGAYUZYN446/AtPpKH+i2nYvGKzV9fRSmjM/S9
   THuqOlEMcfS3tgy6a/fu7v4bgu8ckrjAeotrUhMb+MtCaybX76eJYrVAJ
   A==;
X-CSE-ConnectionGUID: wiJhFqnOSE2DpQSkwZe8uA==
X-CSE-MsgGUID: WJ/lJML5QzStDc36QRMcVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="77005966"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="77005966"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 16:27:01 -0700
X-CSE-ConnectionGUID: mPgZWE5TRaGPzaO/bKZqIQ==
X-CSE-MsgGUID: XpMsfk3mQ12kIUpJfZy2Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="234155065"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 16:27:01 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	binbin.wu@linux.intel.com,
	dmaluka@chromium.org
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v2] KVM: TDX: Fix x2APIC MSR handling in tdx_has_emulated_msr()
Date: Fri, 10 Apr 2026 16:26:54 -0700
Message-ID: <20260410232654.3864196-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework tdx_has_emulated_msr() to explicitly enumerate the x2APIC MSRs
that KVM can emulate, instead of trying to enumerate the MSRs that KVM
cannot emulate. Drop the inner switch and list the emulatable x2APIC
registers directly in the outer switch's "return true" block.

The old code had multiple bugs in the x2APIC range handling.
X2APIC_MSR(APIC_ISR + APIC_ISR_NR) was incorrect because APIC_ISR_NR is
0x8, not 0x80, so the X2APIC_MSR() shift lost the lower bits, collapsing
each range to a single MSR. IA32_X2APIC_SELF_IPI was also missing from
the non-emulatable list.

KVM has no visibility into whether or not a guest has enabled #VE 
reduction, which changes which MSRs the TDX-Module handles itself versus 
triggering a #VE for the guest to make a TDVMCALL. So maintaining a list 
of non-emulatable MSRs is fragile. Listing only the MSRs KVM can always 
emulate sidesteps the problem.

Suggested-by: Sean Christopherson <seanjc@google.com>
Reported-by: Dmytro Maluka <dmaluka@chromium.org>
Fixes: dd50294f3e3c ("KVM: TDX: Implement callbacks for MSR operations")
Assisted-by: Claude:claude-opus-4-6
[based on a diff from Sean, but added missed LVTCMCI case, log]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

Thanks to Dmytro for finding this. They said to feel free to take this 
over, so here is another version with Sean's suggestions. Tested in the 
TDX CI.

In Sean's suggestion LVTCMCI was missed, so it's added here.

 arch/x86/kvm/vmx/tdx.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..76ab6805ab29 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2116,23 +2116,27 @@ bool tdx_has_emulated_msr(u32 index)
 	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
 		/* MSR_IA32_MCx_{CTL, STATUS, ADDR, MISC, CTL2} */
 	case MSR_KVM_POLL_CONTROL:
+	/*
+	 * x2APIC registers that are virtualized by the CPU can't be
+	 * emulated, KVM doesn't have access to the virtual APIC page.
+	 */
+	case X2APIC_MSR(APIC_ID):
+	case X2APIC_MSR(APIC_LVR):
+	case X2APIC_MSR(APIC_LDR):
+	case X2APIC_MSR(APIC_SPIV):
+	case X2APIC_MSR(APIC_ESR):
+	case X2APIC_MSR(APIC_LVTCMCI):
+	case X2APIC_MSR(APIC_ICR):
+	case X2APIC_MSR(APIC_LVTT):
+	case X2APIC_MSR(APIC_LVTTHMR):
+	case X2APIC_MSR(APIC_LVTPC):
+	case X2APIC_MSR(APIC_LVT0):
+	case X2APIC_MSR(APIC_LVT1):
+	case X2APIC_MSR(APIC_LVTERR):
+	case X2APIC_MSR(APIC_TMICT):
+	case X2APIC_MSR(APIC_TMCCT):
+	case X2APIC_MSR(APIC_TDCR):
 		return true;
-	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
-		/*
-		 * x2APIC registers that are virtualized by the CPU can't be
-		 * emulated, KVM doesn't have access to the virtual APIC page.
-		 */
-		switch (index) {
-		case X2APIC_MSR(APIC_TASKPRI):
-		case X2APIC_MSR(APIC_PROCPRI):
-		case X2APIC_MSR(APIC_EOI):
-		case X2APIC_MSR(APIC_ISR) ... X2APIC_MSR(APIC_ISR + APIC_ISR_NR):
-		case X2APIC_MSR(APIC_TMR) ... X2APIC_MSR(APIC_TMR + APIC_ISR_NR):
-		case X2APIC_MSR(APIC_IRR) ... X2APIC_MSR(APIC_IRR + APIC_ISR_NR):
-			return false;
-		default:
-			return true;
-		}
 	default:
 		return false;
 	}
-- 
2.53.0

