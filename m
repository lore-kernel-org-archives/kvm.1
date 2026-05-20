Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4F3E92BA;
	Wed, 20 May 2026 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284433; cv=none; b=QTCfoqFDYWyXWMN4ef7GOXUI0UezWurNSVjZO3SbYNxzabvHhU4cBh5SdtR9T1AfOoH9nU44x5PXAiO+AJ/EL2bh0IJShkkk6JLwx8z8pkVOWgNRaDEwlfoZAd/D9lcKmoEMv2m9yOQhSk9mthvYoiy5hvHoYxymWJK/bUs9fVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284433; c=relaxed/simple;
	bh=x+zSpLlvXkFLQ91oeRt+Qpao7+rP7ECB/QZPTdOkZ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db+LPxj79jhU7U7emSj45Fpmv913QOnmx5GcD9bQZp4I6IbHQMI5MeU4krC3MAZNblBHY/UyBG9JXKv/6eMgzk/QXcgWxfSJesgOKl3GPNVlMUl4Jnd1qV7SEbZQNTs8wCu8MgZagJpFvb3eFq6NePZabg2y+BG5xhneReObrZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zw11qEyO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zw11qEyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284430; x=1810820430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x+zSpLlvXkFLQ91oeRt+Qpao7+rP7ECB/QZPTdOkZ1Q=;
  b=Zw11qEyOn1Ip139LqBiLr/wM/1fO58gK1ulZHLP6gL+jJeSfXUpogQXP
   Nj3QlqCCSoxubFwY/G4cDPHhVrA8+J0KCcWfqHHaxKr49d+2EQxQQeC7D
   4Yt2QKjuQqvKE5VGoPTi2F9q02E8bparI47WHYvBaHYL+vM9IpUGJvzlr
   ZCvwUCGUSPwqfiTe+nji+TR9bMORkQnTY5qbQKWFWkf9AP1nP63hi3kC9
   fajSV57aRj8AzgelMP0Wfkgrk3wxKFQdTw8Z2Plnqg92QfuBjg6+2GlOp
   AoV7NnSAyAwyTxkiv9LqdcBJBjqmYDmKPAJnqxEkeZSB/RAp7Nzs26Qn1
   A==;
X-CSE-ConnectionGUID: JDiNtZ/4QqOFp/bytrPQeA==
X-CSE-MsgGUID: nIJg5/fDSwi6eQBVv34EFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146564"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146564"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:24 -0700
X-CSE-ConnectionGUID: SqIAl3EBQDivEsUzz8rNjg==
X-CSE-MsgGUID: d94DxpP+QAKF1sVvcQ1Kfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923939"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:23 -0700
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
Subject: [PATCH v10 18/25] x86/virt/seamldr: Install a new TDX module
Date: Wed, 20 May 2026 06:38:21 -0700
Message-ID: <20260520133909.409394-19-chao.gao@intel.com>
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
v9:
 - Add a comment above seamldr_install()
---
 arch/x86/virt/vmx/tdx/seamldr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 217b3c962aff..afd8179e5c98 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -19,6 +19,7 @@
 
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
+#define P_SEAMLDR_INSTALL		0x8000000000000001
 
 #define SEAMLDR_MAX_NR_MODULE_PAGES	496
 #define SEAMLDR_MAX_NR_SIG_PAGES	1
@@ -76,6 +77,15 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
+/* Call into P-SEAMLDR to install a TDX module update */
+static int seamldr_install(const struct seamldr_params *params)
+{
+	struct tdx_module_args args = {};
+
+	args.rcx = __pa(params);
+	return seamldr_call(P_SEAMLDR_INSTALL, &args);
+}
+
 #define TDX_IMAGE_VERSION_2		0x200
 
 struct tdx_image_header {
@@ -177,6 +187,7 @@ static int init_seamldr_params(struct seamldr_params *params,
 enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
+	MODULE_UPDATE_CPU_INSTALL,
 	MODULE_UPDATE_DONE,
 };
 
@@ -251,6 +262,9 @@ static int do_seamldr_install_module(void *seamldr_params)
 			if (is_lead_cpu)
 				ret = tdx_module_shutdown();
 			break;
+		case MODULE_UPDATE_CPU_INSTALL:
+			ret = seamldr_install(seamldr_params);
+			break;
 		default:
 			break;
 		}
-- 
2.52.0

