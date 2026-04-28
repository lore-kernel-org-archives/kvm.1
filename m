Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D39322DAF;
	Tue, 28 Apr 2026 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353981; cv=none; b=H10pH0MwjjGXkq16cWrcdZ4ToEFxeRw6/w0HZvjzFBclsqK3Wr/Uckgq2nwjQAUqNS2YylbZuV6oZhdJmA2TT5qvdayCziLvnbvoyj6vMo/ae2laXTv04P4JFmCBbTVMtvPWzN61U4wMFlK8yNXSMZzaObItWh8NKXSYEmKuzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353981; c=relaxed/simple;
	bh=gGdnNFdK9GCgRAM1ltOEz31NvjEatsfo49ttFuoXRo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIlYdw2Tkf24ikBRZXNU4fUlQKKbn40lrOZDX10QtfQyD6lUjlecrqeUc831P+qU9Vk2Atn0pC92J0zGDepSBo6OIqyHYpTiPzs1kH1OyFoJd4PeJGz67w8MSDOlab2stZeUBgUNrXlIQmTpzFu8ohiGRiGfsROM4hfHPgCLFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cd7ZdRvH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cd7ZdRvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353980; x=1808889980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gGdnNFdK9GCgRAM1ltOEz31NvjEatsfo49ttFuoXRo8=;
  b=cd7ZdRvHd6qOvSfqiuTUU7+5NQ6WQQTD3gxDFNKvoknbuh7JW+2/nizm
   fuM0qBhOKn3DJ6KXR9ZpPD50AarZhRC1NbnX+NsTkUzqU/CXfx3XK8Od+
   OMgPsUQyletFgM0+TG0WPEYnVKig2fzLOoiJdA0T+P3jEID986QoLUys9
   6K5yUBkt+F19DjrRJ4WGT/CmnYxfZgdI/egFr/Es2MdMaA7NuBKVWfpor
   EWeQ5xLRdQRQqZ8Qoba1fLlZHLoXHwbW8IEMGAISzHtxJiWK7DhXzl7lW
   LevYDFwwJ7lVeq0pFIxO8QxRwabBKF9hqyFYpxMQHAfngUciXmuIRiC5w
   A==;
X-CSE-ConnectionGUID: qoaj9yPoRQmRe9BXIV+2xA==
X-CSE-MsgGUID: 1/Ypb+PBSwaHAew9senwWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131686"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131686"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:19 -0700
X-CSE-ConnectionGUID: F0UwGAREQi6z6zyS7gXNzA==
X-CSE-MsgGUID: jIKV0xR4SNWZMJzgWiLCuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130173"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:19 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 04/20] KVM: x86: Extend VCPU registers for EGPRs
Date: Tue, 28 Apr 2026 05:00:55 +0000
Message-ID: <20260428050111.39323-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
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

Link: https://lore.kernel.org/abL8SW5JS1aV5goa@google.com
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: New patch, based on Sean's APX preparatory series [1]

[1] https://lore.kernel.org/20260409224236.2021562-1-seanjc@google.com/
---
 arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++++++
 arch/x86/kvm/Kconfig            |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2f575c8976b4..707d7b032a44 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -190,6 +190,24 @@ enum kvm_reg {
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

