Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5D4CA282;
	Wed, 13 May 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685118; cv=none; b=MCnvEivE0LZUMCC2VvIDtKmPJT0ZuSdh3WOouznrbTq4um03rzcu8r8Cy4w/ObH8iHGItji02Hvn2wCQSy159KDIt3eJNPg8vW0DKRkfywSGXJgAVAQ7SMFTujV2v4UJGINwZVjEesVtHbaeEellIQyMPupMDzu1Pyq330CAKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685118; c=relaxed/simple;
	bh=mA+Ls5mGcVtIkKcE5YQQTXwY+Wu62lieuDPPD5IDV2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX0NMbqyQppFQ9TRMQX2oose6VCPlENCnVN26vyn7ZWauyyfPjSNQyHBSPlV8T6zkBD1wgXsNda1wSBM8R1Hqhyq/mb/Kt5Wy/X2MQ+/muDGV3YRa8SPvEORtcBTUX7+xs6RL/oZxnk3u90V0anCenWQUhrm6jB0qYSvdRw5pps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd+7S6zx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd+7S6zx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685117; x=1810221117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mA+Ls5mGcVtIkKcE5YQQTXwY+Wu62lieuDPPD5IDV2w=;
  b=Cd+7S6zxj1/+JdEXE6s9OcAz0C8UCcMzNT3P5ej2/mysm45alClXQ4iZ
   /V6Nb7AxnYpgkGSbgJ6EUH0bJ00XPLkGaMueINOHSlV/Rjgd+VvHs5jpi
   ODFuU98502OCZ8jr1CLtqkFGc8gVtEoxqMOLFA0sJbdJLF3HFtSjyHrZb
   UMG+rJSf/IzDwR+5YFNiHRsO50lYf/lQigeLLZfxPYqfovvo3ZzbsPHZ9
   bB+svFIPw/wEMHcAfV8I9xRw6zHxN8ECf1I1iGqpgVeKWwy/D7UHlDkbR
   n+I6bWTaIFQZLoW671POVmmUbLCRtcRYxi44aHVeKlIDLgD9Rr5zyMlmD
   Q==;
X-CSE-ConnectionGUID: N8d6vPNFRLWdYiBHdVKB2g==
X-CSE-MsgGUID: lh/i0Fb9QSGMvpo+/x3wIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921763"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921763"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:55 -0700
X-CSE-ConnectionGUID: XlXgSa/VQhiRTCB7DMjWzQ==
X-CSE-MsgGUID: i+xQEzbwSGeejNWG9hF06Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716893"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:54 -0700
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
Subject: [PATCH v9 16/23] x86/virt/seamldr: Install a new TDX module
Date: Wed, 13 May 2026 08:09:59 -0700
Message-ID: <20260513151045.1420990-17-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
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
index 6114cab46196..9d0e7e8c6c20 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -19,6 +19,7 @@
 
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
+#define P_SEAMLDR_INSTALL		0x8000000000000001
 
 #define SEAMLDR_MAX_NR_MODULE_PAGES	496
 #define SEAMLDR_MAX_NR_SIG_PAGES	1
@@ -74,6 +75,15 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
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
@@ -166,6 +176,7 @@ static int init_seamldr_params(struct seamldr_params *params, const u8 *data, u3
 enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
+	MODULE_UPDATE_CPU_INSTALL,
 	MODULE_UPDATE_DONE,
 };
 
@@ -240,6 +251,9 @@ static int do_seamldr_install_module(void *seamldr_params)
 			if (primary)
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

