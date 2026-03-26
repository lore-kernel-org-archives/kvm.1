Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A903C1412;
	Thu, 26 Mar 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514745; cv=none; b=TQ//nloA83ilSA/71V1uVvPdZ1JG++gzpsyC5FGEnUMQMb2fJKGJmcl+DSYavemHlczNMWDpqyfgAKp27HWDzi/IAzIG807J0914Y1JmH8TILBhXDq8GvCDpd53cCo5aL6uRysuFNExNQXJ0fo196GVxvT39FuAEZGLU1EPfT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514745; c=relaxed/simple;
	bh=Xsfo46nlclfFy6U09yRzSstZCwBgdA7D6/oVyRXAANQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IltzhjmyIRwmfzlLqeox56KagRVSZDluih1aqmLRw2Abu3U3ipxACqjCBJ+fAMYw7zn/CYreCjemj70Zcekv+gcp9rlM0LZ/icHzc91GbCRyGnDMCMzsb6i30d5sM+iMQbj1Ueea3koIh7f+39gC5c9ctAkTwguhc1bwAE7ojwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJciR8PZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJciR8PZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514744; x=1806050744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xsfo46nlclfFy6U09yRzSstZCwBgdA7D6/oVyRXAANQ=;
  b=FJciR8PZksBLiu1g29V61CBhg9gV/l+oPU7neoWKBk1i2RFCw/fPZOZ2
   Etfq9kj/uHz+6B4ouz2qHXs/j8b89FBTLLiI/u636UBtbzbIpMCWtfzgn
   +UyWbfWuswDP4PmDA60M2qgvm/jJUFWABfXhPKogKUdo+l/LNuW4nfb1g
   1qa28XGSHbFQBxLvlUg327yXhForj4TuJ3eK7hw3/TCAgPDnP+SWFB2mT
   kh0/rO+zdprDTR0kp0I5PluI/q4K5mptWvvyMjsAtSdDSKvdFhv2gVtIo
   ZQXGCiYbuaT77IKphZwfV1wo5ny529msGOHSo0hDdfZbiaThNTOOaDnWR
   A==;
X-CSE-ConnectionGUID: pahSF+FURxmID2pbVk7Jwg==
X-CSE-MsgGUID: jFj49ko/TYCsLO7+jmN6RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644711"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644711"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:23 -0700
X-CSE-ConnectionGUID: RMBBDnk5Q/KrHbEm9yV4uQ==
X-CSE-MsgGUID: DL5dmLBORuCyWaX7IJoX5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967221"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:23 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
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
Subject: [PATCH v6 13/22] x86/virt/seamldr: Install a new TDX module
Date: Thu, 26 Mar 2026 01:44:04 -0700
Message-ID: <20260326084448.29947-14-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
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
---
v6:
 - wrap seamldr_call(P_SEAMLDR_INSTALL..) in a helper [Kiryl]
v5:
 - drop "serially" from the changelog as it doesn't matter to
   this patch
---
 arch/x86/virt/vmx/tdx/seamldr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index a8fd29818378..0c282a7565a1 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -19,6 +19,7 @@
 
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
+#define P_SEAMLDR_INSTALL		0x8000000000000001
 
 #define SEAMLDR_MAX_NR_MODULE_4KB_PAGES	496
 #define SEAMLDR_MAX_NR_SIG_4KB_PAGES	4
@@ -73,6 +74,13 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
+static int seamldr_install(const struct seamldr_params *params)
+{
+	struct tdx_module_args args = { .rcx = __pa(params) };
+
+	return seamldr_call(P_SEAMLDR_INSTALL, &args);
+}
+
 static void free_seamldr_params(struct seamldr_params *params)
 {
 	free_page((unsigned long)params);
@@ -192,6 +200,7 @@ static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
 enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
+	MODULE_UPDATE_CPU_INSTALL,
 	MODULE_UPDATE_DONE,
 };
 
@@ -249,6 +258,9 @@ static int do_seamldr_install_module(void *seamldr_params)
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
2.47.3

