Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B82989B0;
	Tue, 12 May 2026 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550025; cv=none; b=uCDHpjbNx/WPWUAglSksnKgGx5xRBEOcl5qVUZ1GyqRDkP2dStq9s1tgzyu18hUZ/XS6YdvDUZpOOpASpuEOfvQPWV8GQgoVMOkOvftgHT/trJkb0RlYTJKs623a1gOclEePyovHyY9VXHzMV4C1TT6n7XkKxd/jq22pSw8tTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550025; c=relaxed/simple;
	bh=2TGAuMuXZXBMg+CMihQ+9JLMd8mCwZ+D0TVpxQ1UN/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY8ZNXg1nm+uvLPjiItDBqJkU3BMmJLxm3REkMz5rAlm30Z8gdKypRc6OtUH/mPBWG1HmzHFlj1o47s1B/wsXyYdjyPOW5NIF49QMM/wDyr6X4u3Tq7bv2FKMURyx5vOKI3Q1n1pJiZlKNX+30zOhy/vMwnnk/OxOwlJUVwzWII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l22rjVLA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l22rjVLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550023; x=1810086023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2TGAuMuXZXBMg+CMihQ+9JLMd8mCwZ+D0TVpxQ1UN/8=;
  b=l22rjVLAt8Nw5yjZA1f5Ke2S4EoEvpao0GJ5MvfaQ0qrlwLERzFqva37
   d0m2xi1iyGhxEVxtjykyeU7FM5iNiH34wMQWi+tLcMchvI4iqM7ZuzimB
   7fAe82EAUSz15sZTMQKAwsbFhkPHZOqzoEBOLxXu40GsCdz6FqT8VLmDG
   TiuCrNJBI3K0qczAj4vfBS3+y4En/AHEpaWyK7S1LiiONaDzZh0S3xloj
   zH0MshQjwPgsC5kHi91c5N3YmDpVvqZ7fmLgLWo4NSJKsUX0HqnsKc4wa
   erNU0zrUzp4xPFgrjCh4Gfjv1ilWDtiuO2qQg44damQVA+jZt7JVCFnOF
   w==;
X-CSE-ConnectionGUID: +zreieEQQ2i/2v8P36KnOA==
X-CSE-MsgGUID: zvp3YzQQTJKjwJRQI9MfhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322113"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322113"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:21 -0700
X-CSE-ConnectionGUID: qpRTF3u4QhmarKQOQX2gSg==
X-CSE-MsgGUID: ofe+mE1bSmS8qmk5LpCQ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572752"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:20 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 04/21] KVM: x86: Extend VCPU registers for EGPRs
Date: Tue, 12 May 2026 01:14:45 +0000
Message-ID: <20260512011502.53072-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
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
Dependency: Based on Sean's APX preparatory series
            https://lore.kernel.org/20260409224236.2021562-1-seanjc@google.com/
---
 arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++++++
 arch/x86/kvm/Kconfig            |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a70ed9a6a4fa..76c91efca722 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -189,6 +189,24 @@ enum kvm_reg {
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
2.51.0

