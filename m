Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD53B42FF;
	Thu, 18 Jun 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771970; cv=none; b=mqyPjafnmiXYwbclTKWpjO8wUuzCasscjLUXeg+cWMqHUDiRWCObBNe14EDuSMz6zqG8u9TLGnBlX1TlDvFB4SIT071nVfslpwEiPkjles3ABqg+jRFmh5a9jSVsmfH+wpY8x7VSJgTUw6uTOQHsk4Ku12YACJR1P2wli2XxYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771970; c=relaxed/simple;
	bh=JE5Yt3KxMiVOd4Qzw1Ln3lPWaPef8j8osC967JmHKQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFVQ5B/3ZY1i/h1RN29w/kIcH+Y0YRFFpwI4+pmIyZjNJ0CMo9yuCfoQKBLzNLPwh5sLWe+SWrr7mKTEjlZfHIuvnAlXCz6B09wYdyr53ENzOgodh6kFk+aJGOGAlHHmbVGo/iLkrvmC5/GyTq43e5v7KGi13gPayoYMEjNnXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgWNpV8X; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgWNpV8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771969; x=1813307969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JE5Yt3KxMiVOd4Qzw1Ln3lPWaPef8j8osC967JmHKQ4=;
  b=dgWNpV8Xru+EUkH0mgALU56V3jFBwyPVYP7isWtmUswQQNDcdA+aM/2f
   +asMFlGrpgSoYsVtO8C3xX37FFNUeZgg729ydy+5EZlm5SLBd/3pxyZRp
   lklazIYV7OFcOpv6nlFaDQqzIiG8IQyQTiba2g8vcJ64Bt41leIavvjZ5
   AmEhC1JaZd8ElQNypo3VwsXvJT+pm2iDjtPaTeRokU532FjyFv7wwAjra
   E653H/jm048rgRt+BgpdCKVQbZTPMdZO0ZtWksDiIj2R2R0hsBL/sLM/6
   xZ8uUwA3N9LicMQ/lYIOY7fHVFKN0N9zsxfkUuTg92UhEwO92zp7TY1q9
   w==;
X-CSE-ConnectionGUID: MgtHxaZ1SjizvL6g8/yZVQ==
X-CSE-MsgGUID: JXDuNRnpSE2Uach/M6oT9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584673"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584673"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:29 -0700
X-CSE-ConnectionGUID: EpzOfugUTf2c6HEWKJGBbw==
X-CSE-MsgGUID: tZAC3xGrRNGxHSp5QikK2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392252"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:24 -0700
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
Subject: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on runtime TDX module update
Date: Thu, 18 Jun 2026 16:13:44 +0800
Message-Id: <20260618081355.3253581-7-yilun.xu@linux.intel.com>
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

Runtime TDX module update introduces a mechanism to update the module
firmware while preserving and restoring TDX operations. As part of the
restoration process, the host must re-execute all extensions
initialization steps to restore extension SEAMCALL functionality.

However, Linux runs the update in stop_machine() context, which prevents
memory allocation. This introduces a hard restriction that the updated
TDX environment must not consume more memory for the extensions.
Consequently, the post-update initialization for the extensions is
implemented as:

  1. Detect if the extensions are supported and required.
  2. Detect if the extensions require additional memory. If yes, fail
     the update.
  3. Initialize the extensions via TDH.EXT.INIT.

The memory allocation problem is greatly mitigated since Linux applies
a policy that configures the same add-on features for boot and for
update. This policy minimizes the chance of increased memory demand. So
now the restriction only affects the compatibility rule for choosing the
update image.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 31 ++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  2 +-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 900928de373a..4d2940f4538a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1168,7 +1168,7 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 }
 
 /* Initialize TDX module extensions for extension SEAMCALLs */
-static __init int tdx_ext_init(void)
+static int tdx_ext_init(void)
 {
 	struct tdx_module_args args = {};
 	u64 r;
@@ -1308,6 +1308,31 @@ static __init int init_tdx_module_extensions(void)
 	return tdx_ext_init();
 }
 
+/*
+ * Mostly the same flow as init_tdx_module_extensions(), but rejects adding
+ * more memory.
+ */
+static int update_tdx_module_extensions(void)
+{
+	struct tdx_sys_info_ext sysinfo_ext;
+	int ret;
+
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+		return 0;
+
+	ret = get_tdx_sys_info_ext(&sysinfo_ext);
+	if (ret)
+		return ret;
+
+	if (!sysinfo_ext.ext_required)
+		return 0;
+
+	if (sysinfo_ext.memory_pool_required_pages)
+		return -EFAULT;
+
+	return tdx_ext_init();
+}
+
 static __init int init_tdx_module(void)
 {
 	int ret;
@@ -1498,6 +1523,10 @@ int tdx_module_run_update(void)
 	 */
 	WARN_ON_ONCE(ret);
 
+	ret = update_tdx_module_extensions();
+	if (ret)
+		return ret;
+
 	tdx_module_state.initialized = true;
 	return 0;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 720cdaf76492..84364da89649 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -132,7 +132,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	return ret;
 }
 
-static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
+static int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
 {
 	int ret;
 	u64 val;
-- 
2.25.1

