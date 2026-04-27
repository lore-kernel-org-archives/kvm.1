Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8C34D90C;
	Mon, 27 Apr 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303809; cv=none; b=uMPwKsFnxl6fDBXHdmCw2mz8+fygvrC6WgkiCofmVznIeTCrzr4O68dONqmahbCj6BIToz7JFoRPB7Ab4aG7LazEY7BQWMCYNM48G7H8R7DlxZjnSAUgl+F+enJHqgcJFwPXHnmPAYd8+0zPt7gbzOwgb7/f/Ij06hArNWbECcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303809; c=relaxed/simple;
	bh=awQLLVxSD7rc3F1aejYYETIC3I3QjxeXun497n3ZsXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6KYcUIa4x/BbPLsVaKV2jWOFj7eLz3g6ak/HpVp6HuKYDrG81T0Le+bAsKRPEusKGf0dhE39O2FXHu6boTcy7xB98HHTk44SpJ1Dc4xSHbmAzh93ByOq2uSv+9eY/2z6NTLk6gao0rGPAHhrh/GNY8a9E//MYTHTo7celp3N6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyVOMoPH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyVOMoPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303807; x=1808839807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=awQLLVxSD7rc3F1aejYYETIC3I3QjxeXun497n3ZsXw=;
  b=FyVOMoPH1Iae0iB+SVaH0IeiekjUedTTJ8iqmZRMUrEEaSi4vYuhQiKf
   jwiQmIMjE2HR8FqOGJAuOoudRZ1kk7waz4ekYTuAZ5/0oEYckRFHOlWr4
   yHwZHxsR0CYH4fgX2wDKV9FWiQUMc69yjB/bNLtYpTQz+46S2oxW4bldr
   D1Fjf/PPnEoMNejBQV7P88d0vhkcnrmy55ubzwoRY+6IK8KkLncFKT3ro
   4u2H/ErfTjUJBw5F7dZvHLlYTBvaxKG5mPFNrHD68qE2714N5DDKuwZe9
   kCuTTge0gzDCkC1KjPemxnVU2qwIRyW1tFUKuNswfxEdKS0LMUJcHNd8g
   Q==;
X-CSE-ConnectionGUID: AKVctQ9VSQm31wz9zXm78Q==
X-CSE-MsgGUID: KkvTnSiBQ2SiE/7zPUaLvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77900751"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77900751"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:02 -0700
X-CSE-ConnectionGUID: +1JjX1oVRASxTQq2sMninw==
X-CSE-MsgGUID: YcezkSyaRHycFt+3JCK/Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232673288"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:02 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v8 13/21] x86/virt/seamldr: Do TDX per-CPU initialization after module installation
Date: Mon, 27 Apr 2026 08:28:07 -0700
Message-ID: <20260427152854.101171-14-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427152854.101171-1-chao.gao@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After installing the new TDX module, each CPU needs to be initialized
again to make the CPU ready to run any other SEAMCALLs. So, export and
call tdx_cpu_enable() on all CPUs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v8:
 - export tdx_cpu_enable(). it is unexported by VMXON series.
---
 arch/x86/include/asm/tdx.h      | 1 +
 arch/x86/virt/vmx/tdx/seamldr.c | 4 ++++
 arch/x86/virt/vmx/tdx/tdx.c     | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 1c5981453ff8..de822ed9ef0b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -104,6 +104,7 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
 
 #ifdef CONFIG_INTEL_TDX_HOST
 void tdx_init(void);
+int tdx_cpu_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 317b38c4aa19..04c7a87ac7df 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -212,6 +212,7 @@ enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_CPU_INSTALL,
+	MODULE_UPDATE_CPU_INIT,
 	MODULE_UPDATE_DONE,
 };
 
@@ -271,6 +272,9 @@ static int do_seamldr_install_module(void *seamldr_params)
 			case MODULE_UPDATE_CPU_INSTALL:
 				ret = seamldr_install(seamldr_params);
 				break;
+			case MODULE_UPDATE_CPU_INIT:
+				ret = tdx_cpu_enable();
+				break;
 			default:
 				break;
 			}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ff5644f5daa4..3bbb12aefb4b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -101,7 +101,7 @@ static int try_init_module_global(void)
  * (and TDX module global initialization SEAMCALL if not done) on local cpu to
  * make this cpu be ready to run any other SEAMCALLs.
  */
-static int tdx_cpu_enable(void)
+int tdx_cpu_enable(void)
 {
 	struct tdx_module_args args = {};
 	int ret;
-- 
2.47.1

