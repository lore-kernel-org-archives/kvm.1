Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC23B42FF;
	Thu, 18 Jun 2026 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771975; cv=none; b=lk8NSb6iZm4A9BjiIVpa5g+rGKRETIHtJpQIxT61cQEbNn7GpTqmOafm4ISugKJUQ6AFywKSAcTol3SsT7cN2011r8qz7F6cTgYbcutczK85pvgXMPE/uUmldSxo6t5A9X82ybWQSb9JPrTxoS/6Ll6eheehjk/ox94KRXbUx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771975; c=relaxed/simple;
	bh=TIB2F7YRBjL4L5978YA/6Ry03QFBEmGlq2UAe/qXOpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEwXHNCheYBN4sMhHpytuHcnqytmZ+s2HgKHSt3IkyJrt4laphrpjIa/8eSuBs2xrvZQGqV0LmQSkqnCPRYDompf1bT/OBhjRdEeKAR2Wt/tyTxbSP537YVVtXdr5dRFCfIe8ps+6+vp6UvC4wA5uK7aMZDtFBlMvdHSdjSOKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sah4lnus; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sah4lnus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771974; x=1813307974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TIB2F7YRBjL4L5978YA/6Ry03QFBEmGlq2UAe/qXOpc=;
  b=Sah4lnusQBHrZV5ELtNpC1uhqaYzEjKZcQmFGovehs3pjMT6rtlvqmJV
   fkndMMRcBrKbJtixyZONq9aOR/MOvSKcPxjWNelxHxV4ZVxoiY14khFeC
   xEfRZWUCujZ3SPZ+NRkPNGYo03QVi3U82yYS8lZLzitW3lY7LKaEp0J2j
   00j0WOvNVrNFcT2W61vBLyKX5UbLkYJJ3UkpkmEvVxGwfVZMKb3qYC2SX
   oFZAjflmL51j+ugp9Df5CQ97jw5zyAXX1QJmd8LELmstOOLJ5DSv66gs1
   WTXM4CrVvuWqorma3QZMhZPLqbTnT7UJIf2RGM5/mSARJk45Vi8QQBpbQ
   g==;
X-CSE-ConnectionGUID: kcJMpazdS4W7X7Bxd+509g==
X-CSE-MsgGUID: fCtWMnDyQQCx1kmR3NODzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584710"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584710"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:33 -0700
X-CSE-ConnectionGUID: IO5a5jEbQDOspBBOaeMtKQ==
X-CSE-MsgGUID: o897LFxITPur9HHMb+isxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392273"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:29 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: djbw@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: [PATCH v2 07/17] x86/virt/tdx: Initialize Quoting extension
Date: Thu, 18 Jun 2026 16:13:45 +0800
Message-Id: <20260618081355.3253581-8-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Fang <peter.fang@intel.com>

Initialize the Quoting extension during TDX bringup, after enabling TDX
module Extension.

Because Quoting is an optional TDX feature, do not let initialization
failures cause TDX bringup to fail. In that case, TDX can fall back to
the existing userspace flow via a KVM return code.

Only lay the groundwork for TDX Quoting support. Leave the opt-in
portion of the initialization to a follow-up patch after fully
implementing the feature.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  |  1 +
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 34 +++++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 5fbf89d5317c..741fd97cc199 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -36,6 +36,7 @@
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 #define TDX_FEATURES0_EXT		BIT_ULL(39)
+#define TDX_FEATURES0_QUOTE		BIT_ULL(50)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 2deb0a5c902e..1afa0b10dfc9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -66,6 +66,7 @@
 #define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
+#define TDH_QUOTE_INIT			100
 
 /* TDX page types */
 #define	PT_NDA		0x0
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d2940f4538a..06c42b86b05e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1167,6 +1167,32 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+/* Initialize quoting extension */
+static __init int tdx_quote_init(void)
+{
+	struct tdx_module_args args = {};
+	u64 r;
+
+	do {
+		r = seamcall(TDH_QUOTE_INIT, &args);
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	if (r != TDX_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
+static __init void init_tdx_quoting_extension(void)
+{
+	int ret;
+
+	if (tdx_addon_feature0 & TDX_FEATURES0_QUOTE) {
+		ret = tdx_quote_init();
+		WARN_ON_ONCE(ret);
+	}
+}
+
 /* Initialize TDX module extensions for extension SEAMCALLs */
 static int tdx_ext_init(void)
 {
@@ -1305,7 +1331,13 @@ static __init int init_tdx_module_extensions(void)
 	if (ret)
 		return ret;
 
-	return tdx_ext_init();
+	ret = tdx_ext_init();
+	if (ret)
+		return ret;
+
+	init_tdx_quoting_extension();
+
+	return 0;
 }
 
 /*
-- 
2.25.1

