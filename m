Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7A51AED3;
	Wed, 30 Sep 2026 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804093; cv=none; b=XHRbJOstj9NdPb+LK7eXeQTTQYZ7KWijNdbaziq26CzkrdnfHnBPtm8SuN4tTp2A3Wr4M+wxWM7HQtHPB8m8uchk4IkhMjw/Uj2J49YU76FL2Q+O9ju3ws851116vfyUoERxCXd6xRTDpuCIb9Apgj58MJMLcfs9gs7fehFJf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804093; c=relaxed/simple;
	bh=DLwm2D7guphK9heillcs0wC5KZLW0Q6z6RMbkLKDHz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkkNjLFCTSfZeBptFam5oFezwq6pnx4LuYf54pdzIW11BwTUP6AHUDpV7xDxaeEMxDqX/fIuPucqHQ0UUzlsut2UdILW2v5qyx1uW8aIYeiFjtbLGxrS00oJpBYMxHdeZgVgCftt3Vr/v3v0Gz9WEv4RR8Xch3lyuvANi/7w9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXkN5CCC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXkN5CCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804091; x=1822340091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DLwm2D7guphK9heillcs0wC5KZLW0Q6z6RMbkLKDHz4=;
  b=bXkN5CCCSmvduT793utqx404rp+JFCPKN0/vjM815mrpWforG7QpfC+K
   +JHjcaKPo5mndYezgFUvwBl8qstTxNqhN/+WlMk92V6KOGPwurvUoiWLO
   oPCgTtXlYJQpmXiV08+vqBqmcKUbin2StIXswOnHYlOXCDQ9DNxqiGH5L
   aXgJvz0KkV2S3kuElaUkRccjsYjhlQrXmX2s3VF13e19Fz7Tela6sz6ai
   tJMCOQdCYju0Z0gm9jEtUY/LRa56Gl9HKejx3wy65Af/gUTLKKC0Z8oLv
   pBuE7qscGTE/zrHQLgTdrYSZZBheD3bY2BrU7GybaJR6Uxr+CbOQDYcIf
   w==;
X-CSE-ConnectionGUID: 9gso46boTdecerVkP0/ecg==
X-CSE-MsgGUID: w14E/BqMSbWmAg0gj0UzMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432643"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432643"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:34:50 -0700
X-CSE-ConnectionGUID: Ba8fX20kQ8GUuwFHtibqwA==
X-CSE-MsgGUID: 4FJolYx3R9W+et4U/xQylA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867191"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:34:50 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 01/20] KVM: x86: Extend VCPU registers for EGPRs
Date: Wed, 30 Sep 2026 21:07:31 +0000
Message-ID: <20260930210750.1487547-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
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
index 3af7395c2430..690de9606d6d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -163,6 +163,24 @@ enum kvm_reg {
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

