Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2604718DC;
	Mon, 12 Oct 2026 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798632; cv=none; b=TzdgmGhMvEuxhgZ+UfkQkPbE/JP2lgyL786QasyYYKGUa8prdjDDAnijFlccw1S2yQRi748lYhe03kyzLLp2+a52F7hLDsYa1v9Vyo88OKayvwy53qCOnDNqbkqPrxHHvD9iKQaXInthLbsqSTUHNYy1/Leswjyo5AKMWNRK/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798632; c=relaxed/simple;
	bh=UiUS5EuJB4k6Wiznlg0CzN1qlFKXyEz1z1F4KFce5tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+3nrXfDMZFtWmsep4CunXPMo7nXp4VkNN0yzmWx2eK3K/PgOI5Rl6IO/Tg6hjDyUXuxq4wf2bAQtPiLC9vgYj5Ie2SRXF4kUxcouOick2g10hOGxLTCxUtbpZQ2XIfUdYTDwafSuOaV6zs7AICNjBE7HvspUGuRw2Oxtt4ZtBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaqE+y1a; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaqE+y1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791798628; x=1823334628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UiUS5EuJB4k6Wiznlg0CzN1qlFKXyEz1z1F4KFce5tM=;
  b=HaqE+y1aXeGi2fGFy+zKPtUJHbC2ZMENbfa3n+qzbvBIvoqpZhPO7SuQ
   kfD1RXXONtUXtfnCQVV9yE+wzFUaIYpuyIXszzzGMktYURBwtvBH+hHa8
   WFPl3TRa8437q/QmqT2KtFH+n3NOcYcVZX5VhYOTCm/ir4xo+JKfqYCfs
   nGsZiTIDCPO4MKtuBXAtEFDiWYHZb7HEJEfGZjYe/bheR4I9u1hck1+qh
   paTtkXXWNsXRz9/ycBg86sC7AnMHvnO1kgGIlT+WcCqtBSWAFfgGc3+dA
   feuYRFacWL/+lzgXHnnC1SsTsOMw8Rgyf64kpvtijcxthdKr1J0T1GWab
   Q==;
X-CSE-ConnectionGUID: o0oqH0piRzGi3aW13AqrTA==
X-CSE-MsgGUID: l2LsG4v9RnaoNJgF8sfADg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="388002"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="388002"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:21 -0700
X-CSE-ConnectionGUID: /JL+81tIS8WExHQ5EgDPwg==
X-CSE-MsgGUID: hAMHD2XrR8monAM38jFqNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="776836"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:22 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	rick.p.edgecombe@intel.com,
	nik.borisov@suse.com,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH v4 03/10] x86/virt/tdx: Convert the features metadata reader
Date: Mon, 12 Oct 2026 02:47:30 -0700
Message-ID: <20261012094754.27702-4-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012094754.27702-1-chao.gao@intel.com>
References: <20261012094754.27702-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continue converting the metadata readers to the table-driven helper.

Add a table that pairs each field ID with the 'struct
tdx_sys_info_features' member that holds its value, and read all fields by
walking that table.

Even though the structure has only one field, add a table anyway for
symmetry with the other classes. Adding a field later then becomes a
one-line change.

Annotate the table as __initconst as it is referenced only during init.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v4:
 - Collect tags [Rick]
 - Drop per-class macros [Nikolay, Dave]
 - Rename feature_mappings to features_mappings to match
   struct tdx_sys_info_features [LLM]
---
 arch/x86/virt/vmx/tdx/tdx.c                 |  4 ++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  3 +++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 13 +------------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 3b7d13a1aa32..9f17c52c026a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -443,6 +443,10 @@ static const struct field_mapping version_mappings[] = {
 	FIELD_MAP(TDX_FIELD_UPDATE_VERSION,	version, update_version),
 };
 
+static const struct field_mapping features_mappings[] __initconst = {
+	FIELD_MAP(TDX_FIELD_TDX_FEATURES0, features, tdx_features0),
+};
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 10cbc2d77a5a..87e055a2546c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -62,6 +62,9 @@
 #define TDX_FIELD_MAJOR_VERSION			0x0800000100000004ULL
 #define TDX_FIELD_UPDATE_VERSION		0x0800000100000005ULL
 
+/* Class "TDX Module Info" */
+#define TDX_FIELD_TDX_FEATURES0			0x0A00000300000008ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index c55674cd4ce6..62c24dda0ca9 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,17 +7,6 @@
  * Include this file to other C file instead.
  */
 
-static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
-{
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x0A00000300000008, &val)))
-		sysinfo_features->tdx_features0 = val;
-
-	return ret;
-}
-
 static __init int get_tdx_sys_info_tdmr_dpamt(struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	int ret;
@@ -121,7 +110,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 		sysinfo->version.minor_version,
 		sysinfo->version.update_version);
 
-	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
+	ret = ret ?: read_sys_metadata_table(features_mappings, &sysinfo->features);
 	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
-- 
2.52.0

