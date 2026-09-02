Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1C306768;
	Wed,  2 Sep 2026 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317083; cv=none; b=lXBsKPLQLzQIm5zMgV7oGONhK4uSfg9Q/4LWb/+3zghYNpwvm13jP1Kbd975uoTcLnNVLNIA7jDq4dK+MI9ZKx0goriXZDLbBpUPx/O8AvbpcDsgdrwis5w6CgSn+fy7eclWHk949qjnR5Q8etJ1k4zvmJgVfFzeVh0HVS3pGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317083; c=relaxed/simple;
	bh=w6oRs73KV/ZjgCNXze7vDDKG9jo5kLXzNKXr8ZD8KAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ud0XbUeC+5uplSZhbOiHumJQNgSUs94DcJhZhbp+0//AKPMNaAThlK8o0vdiKyUjHjgPNort95qbNTD+aTsrEo1B7MVb43s9EO0N1J6tELPmef7PRJXXqBl8vLoXdmg2IyBYeZMn98qe/NAGs5bC+f9F3ptfZMo0G0gk0Vi03iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjB3EDlS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjB3EDlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317081; x=1819853081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w6oRs73KV/ZjgCNXze7vDDKG9jo5kLXzNKXr8ZD8KAA=;
  b=cjB3EDlSfQNe3BbOIzLD2mbhXtEk/huDxsPLkwqSa39F4Ciu7SO+45ge
   lzGId7+4X3RdKydSzrt0p3NLQA4niMDkSIV0hQRV4+MOzjs8GO3sIvUtU
   qml4c8FWo6lO+X5DNC/QfX0FNeJft9Gp9PawYbstMrYrUHbxw6Ljf6MDf
   MTsvUwRWLXrX8ph3nRCXE+mDSyJHZPTz+Vo/6AgA7qtHLPxU4Hg4AS+Xy
   dU7FUOlvRIOagqI8pSPwD4qOlWoDvQ1ShjSoCwCZJJpakodnBmfR31nR9
   BgqECMGoikGpdylZRimoP03oG8lkKGr1M4lItuJmZNvjnhZgY0NmAS6KK
   Q==;
X-CSE-ConnectionGUID: k6Mmwei+SfOQ/5mIE+HdBA==
X-CSE-MsgGUID: QsBaC7YDQ0exOT97vhIUrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282879"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282879"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:44:41 -0700
X-CSE-ConnectionGUID: ny6ZoG16Re+OupETZQIBDQ==
X-CSE-MsgGUID: 7RKUaJIXS6KeVCzb5lVi1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775482"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:44:41 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 01/20] KVM: x86: Extend VCPU registers for EGPRs
Date: Wed,  2 Sep 2026 02:17:45 +0000
Message-ID: <20260902021804.718676-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
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
index 683bb8bf43a9..8a0de8b847ea 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -162,6 +162,24 @@ enum kvm_reg {
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
index 538ed1e80332..db1427a8b099 100644
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

