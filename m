Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7FC339870;
	Mon, 27 Apr 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303808; cv=none; b=aUjE0OxIWyIG6nCAhkzZstn8whVGjvMe45SIEHCl1B/hjUAOJia2LQ6lpwVXmufwUo3SF4233ChOr3iljhOLcLiGZHgf+eDb4Uf6RDwBF7+nY5MJQ/qS3p0hXjcfiyDKgIfN4V2niO7fmygdPMQxBb0PPxQsC9ahY28W83aL4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303808; c=relaxed/simple;
	bh=mts8SbAtAwcOd/F1PusePI37tMIYQmD4hBm991kmt24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsTzYpdfTstpWY++16KA1m3FrDY18+sd1bbCXzXDyUlGaI8xQ//htZs/d+2RtZSgiuDfdH5kwerbmwMVJ1oyOLZv764jTYM7ujaEJHZ6v1qXonOWtvxVA6k4DfhEblqcWDAMXDGQ3gHKbJYb2hyF/3GUueabtSSejqVjtoK3pT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkAkQuPK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkAkQuPK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303807; x=1808839807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mts8SbAtAwcOd/F1PusePI37tMIYQmD4hBm991kmt24=;
  b=JkAkQuPKAW4CP+/kb/6ZU/rq8z1HbudQe20zFpxuH8pOICjvLIHIV+nI
   1uKC0lYIqwUSb85s5uZyBqBVKy0t6pALSVxNmWBXZagIpavykvmQJjDo7
   UHsOwIMb1eABIzZVRwQuQD43a4pZ5nINld7iBSGu9z47PXXAnxHAITx87
   i5+JaFG1ypBGg160y6pNV+phviklmteU1gQw4YpiSxVoYYoHwdz302wOp
   n9PoCPkfUwJxeqYoj5efxCeAbpzE82bIgi1k2DvXSNNfuQOYitw2WMAMl
   TB8Amyweah6fTAnVFoHmThk96H3WAL3jA8DpvTjui1RVAf/UuQzQ7wVCH
   A==;
X-CSE-ConnectionGUID: 51VrlNxoQxOSlTp84tYzKA==
X-CSE-MsgGUID: RoC+Lp0wQ9a6Yf2j5YIGaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77900743"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77900743"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:02 -0700
X-CSE-ConnectionGUID: cpxoUHpkRL2Ttopqwajpyg==
X-CSE-MsgGUID: dejvcafKTBaVvIPXEKZK0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232673278"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:01 -0700
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
Subject: [PATCH v8 12/21] x86/virt/seamldr: Install a new TDX module
Date: Mon, 27 Apr 2026 08:28:06 -0700
Message-ID: <20260427152854.101171-13-chao.gao@intel.com>
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

Following the shutdown of the existing TDX module, the update process
continues with installing the new module. P-SEAMLDR provides the
SEAMLDR.INSTALL SEAMCALL to perform this installation, which must be
executed on all CPUs.

Implement SEAMLDR.INSTALL and execute it on every CPU.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v8:
 - Standardize tdx_module_args initialization. For consistency, initialize
 each field on separate lines after declaration, instead of initializing
 them in the declaration.
---
 arch/x86/virt/vmx/tdx/seamldr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index f995153f24b9..317b38c4aa19 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -19,6 +19,7 @@
 
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
+#define P_SEAMLDR_INSTALL		0x8000000000000001
 
 #define SEAMLDR_MAX_NR_MODULE_PAGES	496
 #define SEAMLDR_MAX_NR_SIG_PAGES	4
@@ -74,6 +75,14 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
+static int seamldr_install(const struct seamldr_params *params)
+{
+	struct tdx_module_args args = {};
+
+	args.rcx = __pa(params);
+	return seamldr_call(P_SEAMLDR_INSTALL, &args);
+}
+
 /*
  * Intel TDX module blob. Its format is defined at:
  * https://github.com/intel/tdx-module-binaries/blob/main/blob_structure.txt
@@ -202,6 +211,7 @@ static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
 enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
+	MODULE_UPDATE_CPU_INSTALL,
 	MODULE_UPDATE_DONE,
 };
 
@@ -258,6 +268,9 @@ static int do_seamldr_install_module(void *seamldr_params)
 				if (primary)
 					ret = tdx_module_shutdown();
 				break;
+			case MODULE_UPDATE_CPU_INSTALL:
+				ret = seamldr_install(seamldr_params);
+				break;
 			default:
 				break;
 			}
-- 
2.47.1

