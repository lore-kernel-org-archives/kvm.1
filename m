Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308E3E95B3;
	Wed, 20 May 2026 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284433; cv=none; b=BsXc24ZW4aYxbuB3Fa5F2ARSOIjSWKWDYyizQrSYiCujQ/DaRVV9gKaT169e8fKFywAwoFiGQXd0BYg+4CBdb8QNAnv3FgcC6Spnq5AQfws98IbdVBZVODWQtTuW0PNBRAkpa+JkZ/5sMXnaGF+8hpyCwo3emvm+pn9OU0fCWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284433; c=relaxed/simple;
	bh=hSwqZtE6R79puNZ3iGIjxtW6FnHjj4i3G49DAaZ7Vmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9kDaBgURCfczZccxa2R1GodGPqHNfWGDvpkm54VhA6qjG18chQCKbjb0J7NBBwCaXQ+ANjuwzu9fEMTg3dxp2VoNwxvw0/XuZp3LcLIFm3+Y9NUNK/iuxVh6UiMJV2kuPugmMbq+nGMXeVZnSfCXkUsnkW7T5dolqY/jD0Zv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAYwmicl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAYwmicl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284432; x=1810820432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSwqZtE6R79puNZ3iGIjxtW6FnHjj4i3G49DAaZ7Vmc=;
  b=mAYwmiclGUkVxr80eC9/yumrXm5qfkgs6mWjNliYC8eZdKJDNiej9gtl
   mJj1S/BxtfzBEUCsCEmlDbaCHx4qTkXMvOWmFynSXiSJJDktlWkDXeKAB
   xjBlonzzeZbH0KkL5YRdBwRT7NcRybFC46EdpM87JbR8jNMk0u6xeHRN9
   9upnEdI5+RHWiMgvE4+MverNhLl9OhRUPg7BaM1abKHA9xU+hm4K8/gCB
   JUD/Kf7029WuAMkeKNMDuMQKeNnMXtQzTWyxLniyzLKJQt46KHg4of1zZ
   XhOIWuXOx7oVBBNEJlFmWRA0qQ30vy+QB0ZM5r2B8NlGLF5uK5tdeTYBw
   Q==;
X-CSE-ConnectionGUID: rILT+avfTrChiDx7SPu5xg==
X-CSE-MsgGUID: 4u+VRQRtRau5Fbp3fzlcCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146581"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146581"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:25 -0700
X-CSE-ConnectionGUID: JkHN4SE5RR2j/GWSJNdyNg==
X-CSE-MsgGUID: Fe8wMNq/T5i/XxNNfdT7zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923956"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:24 -0700
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
Subject: [PATCH v10 19/25] x86/virt/seamldr: Do TDX global and per-CPU init after module installation
Date: Wed, 20 May 2026 06:38:22 -0700
Message-ID: <20260520133909.409394-20-chao.gao@intel.com>
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

After installing a new TDX module, the kernel must re-initialize TDX
before resuming TDX operations.

This post-update initialization differs from the initial boot-time
initialization. It only needs TDX global initialization, TDX per-CPU
initialization, and restoration of TDX state from the handoff data.

tdx_cpu_enable() covers the global and per-CPU initialization. Export it
and invoke it on all CPUs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/tdx.h      | 1 +
 arch/x86/virt/vmx/tdx/seamldr.c | 4 ++++
 arch/x86/virt/vmx/tdx/tdx.c     | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 27376db7ddac..5d750fe53669 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -107,6 +107,7 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
 
 #ifdef CONFIG_INTEL_TDX_HOST
 void tdx_init(void);
+int tdx_cpu_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index afd8179e5c98..a026de7f7bcd 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -188,6 +188,7 @@ enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_CPU_INSTALL,
+	MODULE_UPDATE_CPU_INIT,
 	MODULE_UPDATE_DONE,
 };
 
@@ -265,6 +266,9 @@ static int do_seamldr_install_module(void *seamldr_params)
 		case MODULE_UPDATE_CPU_INSTALL:
 			ret = seamldr_install(seamldr_params);
 			break;
+		case MODULE_UPDATE_CPU_INIT:
+			ret = tdx_cpu_enable();
+			break;
 		default:
 			break;
 		}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 01d0087180a0..5292dd8d1e36 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -113,7 +113,7 @@ static int try_init_module_global(void)
  * (and TDX module global initialization SEAMCALL if not done) on local cpu to
  * make this cpu be ready to run any other SEAMCALLs.
  */
-static int tdx_cpu_enable(void)
+int tdx_cpu_enable(void)
 {
 	struct tdx_module_args args = {};
 	int ret;
-- 
2.52.0

