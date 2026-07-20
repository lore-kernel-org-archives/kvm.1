Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFA44A710;
	Mon, 20 Jul 2026 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569567; cv=none; b=gAhBnoK94ySTffrA6zFUcGhNURAWXCGGLVVn62UiajMW/yfHAaYvDCDj2A0EGs8iW0HcwF/fG1FtZrOf8w1MN+FVSdZqEAX0wRbmJre9umA6HBada6hAeIpblgogKi6wTXadWHCApX5zzpCSTJCRiDnBAs9xU3V4chESepsoN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569567; c=relaxed/simple;
	bh=cPmzi01/ZLhdABcjMjlUHBte7VRdK4w1HW4jeNZEJ0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYyNvtPxgBDyemM5d12DlbXU4Y0M9aC6+jT0ADIOMYL+qZ72Nnf65WoKj2QwwWQY1G5Bv832037Ssf02Ov1SiAscTMEA8v85dF3svVntZ/Kpa3fBp9p/ssMM27NmOUhlzcrrnFW9cbqjq1OWgtkjYey4UOn+NSiJIn0fg4uDRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYxY5THg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYxY5THg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569564; x=1816105564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cPmzi01/ZLhdABcjMjlUHBte7VRdK4w1HW4jeNZEJ0A=;
  b=aYxY5THgMPu9JXpw0v6KhfClHmmESb+ZOd3j0ClrRyZgG0P+YCh4oDDe
   G8MIB7r9ftjckyLKcjkAB/Gf3sXQzvqkMP3wG0TNfvAcvYwhV9wUisLtl
   +DpyC2LnBRbWffP5I+NOU8gMCAW19t1a6NeLLhPsZzeBldtou6TV+KcCL
   YMZtO1pT61OEd+mPiUtV1BoCZwACofPA6yt8N085gjlcT+C7n7FhGXXJM
   MlyKm3vTCaIdt4C5L5R6jweFJRFnvLmSolA3qV1FwHtsdmOhFOqJUuBpA
   l9nJ4Vftr5v4su1MgEGkX11yEfjGutSjYFgAA21koq6G5AJ7DWsh4VQ1O
   A==;
X-CSE-ConnectionGUID: oOOxwsw/SK+tNFGhpnQ2ZA==
X-CSE-MsgGUID: NszpEmbHTP6YnlYNZH9lUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691623"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691623"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:45:56 -0700
X-CSE-ConnectionGUID: twIrDAYiSiKMuHZUZhsbGw==
X-CSE-MsgGUID: mQhICc5yRGy/yEJAh1OBLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575333"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:45:56 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 01/20] KVM: x86: Extend VCPU registers for EGPRs
Date: Mon, 20 Jul 2026 17:19:30 +0000
Message-ID: <20260720171949.498680-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the storage to include extended general-purpose registers (EGPRs:
R16-R31) when CONFIG_KVM_APX=y. This option is for VMX only.

Although EGPR state is XSAVE-managed, and thus could be stored in the
guest fpstate, VCPU storage provides a more convenient and efficient
access path for KVM.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/abL8SW5JS1aV5goa@google.com
---
 arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++++++
 arch/x86/kvm/Kconfig            |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b517257a6315..48547842d9fa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -178,6 +178,24 @@ enum kvm_reg {
 	VCPU_REGS_R13,
 	VCPU_REGS_R14,
 	VCPU_REGS_R15,
+#endif
+#ifdef CONFIG_KVM_APX
+	VCPU_REGS_R16,
+	VCPU_REGS_R17,
+	VCPU_REGS_R18,
+	VCPU_REGS_R19,
+	VCPU_REGS_R20,
+	VCPU_REGS_R21,
+	VCPU_REGS_R22,
+	VCPU_REGS_R23,
+	VCPU_REGS_R24,
+	VCPU_REGS_R25,
+	VCPU_REGS_R26,
+	VCPU_REGS_R27,
+	VCPU_REGS_R28,
+	VCPU_REGS_R29,
+	VCPU_REGS_R30,
+	VCPU_REGS_R31,
 #endif
 	NR_VCPU_GENERAL_PURPOSE_REGS,
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 801bf9e520db..f27e3f2937f0 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -93,10 +93,14 @@ config KVM_SW_PROTECTED_VM
 
 	  If unsure, say "N".
 
+config KVM_APX
+	bool
+
 config KVM_INTEL
 	tristate "KVM for Intel (and compatible) processors support"
 	depends on KVM && IA32_FEAT_CTL
 	select X86_FRED if X86_64
+	select KVM_APX if X86_64
 	help
 	  Provides support for KVM on processors equipped with Intel's VT
 	  extensions, a.k.a. Virtual Machine Extensions (VMX).
-- 
2.53.0

