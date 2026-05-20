Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00B3ED5C8;
	Wed, 20 May 2026 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284436; cv=none; b=EPlDtqbM5E/oVdHS1ogIEpi20BKV0aIJ1DxPbfOamJmGZTLpVoX+cA9HuhqztF5af8lzqry+eq7n7aTueXqqXH1zNVTV9LlYBnriNvhVn2E0koTkik2stSh0ltvEqZz1GaZHQ7Kcm466ooA7p/JFAkaorXcmHVVa4/Tp4WQvXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284436; c=relaxed/simple;
	bh=hOoQJsF3eoYLl4ehmDFfBhq4rnZyHDdnTvgvj7hVnpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhBMxNHi/kJOU8NSuzac6TsfMuBHs+qTPW3U6mWr7m4aFe9niVNg+3+/iHDq30aqYqul+WskGNFXwZ4Ty4nnXIWz8xPrQDFHrUoSnPFU2PfjQfWdGdJrnQlxEkgSvsoCpVhWn7ll5/ebMaPrjStzHxDapucJ3r5F4w86XEq6wTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGHz61FZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGHz61FZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284434; x=1810820434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOoQJsF3eoYLl4ehmDFfBhq4rnZyHDdnTvgvj7hVnpQ=;
  b=NGHz61FZi6ngMylB8n9MKDrh7ecMCYcOO9n47sv69OIEezhxuF467GU5
   wo63zK7ooOsg3w19a5xt+2pLy64wHwtcfbhr9CeWPoyfh7LmoI4sbSpkx
   Z9m75hLw30wBg5WogVLIDP4xlbbXiMxczhlhpQpPSyV6Jt820ZOLB6L1c
   orv5+L3rYRZHt1HcZoUo/qrxwFrQIpzHr82j0niJ+XDIGG/Ycw47iiH/g
   8W0eEW8Yv+GqpekutsthhKHlOUJVePOcplHHhWFvokxm4/o8+Ls5sf9Cu
   6j9oOKQ5naaKfSDgW6U3RkZHWQ0eoEZLI4GruUFBGnnLWlbkNwgNzGL3J
   A==;
X-CSE-ConnectionGUID: mc+mh0WxTT26aR+6M5d8+w==
X-CSE-MsgGUID: 3AKxGXbHS+29ykrnthNsxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146636"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146636"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:34 -0700
X-CSE-ConnectionGUID: XQRyVHvfTLyiQLipH1CjjQ==
X-CSE-MsgGUID: TISOXAucRJmuzJiL2nVqVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235924023"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:28 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v10 21/25] x86/virt/tdx: Refresh TDX module version after update
Date: Wed, 20 May 2026 06:38:24 -0700
Message-ID: <20260520133909.409394-22-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel exposes the TDX module version through sysfs so userspace can
check update compatibility. That information needs to remain accurate
across runtime updates.

A runtime update may change the module's update_version, so refresh the
cached version right after a successful update.

Drop __ro_after_init from tdx_sysinfo because it is now updated at runtime.

Do not refresh the rest of tdx_sysinfo, even if some values change across
updates. TDX module updates are backward compatible, so existing
tdx_sysinfo consumers, such as KVM, can continue to operate without seeing
the new values.

Refreshing the full structure would be risky. A tdx_sysinfo consumer may
initialize its TDX support based on the features originally reported in
tdx_sysinfo. If a runtime update adds new features and the full structure
is refreshed, that consumer could observe and use the newly reported
features without having performed the setup required to use them safely.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v9:
- don't print old and new version [Dave]
- explain why it's OK to hide changes from the tdx_sysinfo users [Dave]
- update versions in stop_machine context
- don't mention major/minor versions are idential across updates. That fact is
  not relevant here.
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 6 +++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e3f5aa272850..55670365a388 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -67,7 +67,7 @@ static struct tdmr_info_list tdx_tdmr_list;
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
-static struct tdx_sys_info tdx_sysinfo __ro_after_init;
+static struct tdx_sys_info tdx_sysinfo;
 
 static DEFINE_RAW_SPINLOCK(sysinit_lock);
 
@@ -1314,6 +1314,10 @@ int tdx_module_run_update(void)
 	if (ret)
 		return ret;
 
+	/* Shouldn't fail as the update has succeeded. */
+	ret = get_tdx_sys_info_version(&tdx_sysinfo.version);
+	WARN_ON_ONCE(ret);
+
 	tdx_module_state.initialized = true;
 	return 0;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index e793dec688ab..e49c300f23d4 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,7 +7,7 @@
  * Include this file to other C file instead.
  */
 
-static __init int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
+static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
 {
 	int ret = 0;
 	u64 val;
-- 
2.52.0

