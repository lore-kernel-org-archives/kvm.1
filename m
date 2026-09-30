Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8EC3B47D9;
	Wed, 30 Sep 2026 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746869; cv=none; b=JHCS84Bva0QEg0u+OqhyXUepPr3ANfSeV2CSXnb7bRZpP9KBvPCg83HbaG5kFRIQX0xq2iHIVgkzX6sV/dyPHVeGATP97kzQHRkd/LJ68Q7MVXd9LmKXpgSnD76Rzddi0D1xF5I6NYsAJxFq7M/f6lLp4DOEzbDn+k7bVhcKhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746869; c=relaxed/simple;
	bh=SdQqq/oRL4CEYqQuixCNqv+VHen61iBhlGgfKJxYsKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPglOli1r2vkL35z4XNVcFMu74onpOp+Sx+3hFap4ISXZ1HD7idMORQST3HylaiQdtyRt4bgHL69U5HvPJmYEuBmng6rBjh3pLrMrRbFrIZTZuwX+3jK8qyjQfZ7r2xEfnXQ8Pnwf1k5n3iXQRdUy0E/DNod2NkIBraYjA0oUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzhNYH6y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzhNYH6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790746867; x=1822282867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SdQqq/oRL4CEYqQuixCNqv+VHen61iBhlGgfKJxYsKE=;
  b=EzhNYH6yG19TwtPPRgqcJM9UU5TWvCNLwLMpptJ8WMdFThbOBg8si/gP
   dkMRKhUGlLDoPLLRutcp9sOVgdRF12N0O4AYHB4rnCexnfCHXvU3cmenO
   pWXHZamuRnbJ+JlWsWPnZVbSOpnuoXxYVz/ugX9+Y2Lvd7CdseJArUypA
   xxSCO/O+1Lrc119TKfQe04s95Ghe8TBDBONo2LZ0Kca9i9lScDAA8VCHF
   9GAd7t2qg6MaSEaa2Z5HfZVVtF9MLm0/hQu8VHh24IPTE7kfoM5EAgdoP
   QWq5RkS++IjVojO8khQB/jTt+bq4rabiLXt22x9MkRR3FIiYMyFki6Sv5
   g==;
X-CSE-ConnectionGUID: ZzHFE4TVQoetdvmem5C5Gg==
X-CSE-MsgGUID: SFvca1y9RSiFkbAQKgKh2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102149096"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102149096"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:01 -0700
X-CSE-ConnectionGUID: SlQ+8CupS9eQy8BTLL3yFA==
X-CSE-MsgGUID: pyHwcwGQTWi6gsvtqMIYpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278936405"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:00 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v3 04/10] x86/virt/tdx: Convert the tdmr metadata reader
Date: Tue, 29 Sep 2026 22:38:38 -0700
Message-ID: <20260930053901.22528-5-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260930053901.22528-1-chao.gao@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continue converting the metadata readers to the table-driven helper.

The "TDMR info" metadata class has two readers: one for the fields that are
always present, and one for the fields that exist only when the module
supports Dynamic PAMT.

Add a table for each, both pairing field IDs with the 'struct
tdx_sys_info_tdmr' members that hold their values, and read all fields by
walking the tables.

Annotate both tables as __initconst since they are referenced only during
init.

AI was used under supervision to review the code and workshop the
changelog.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 16 ++++++++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  8 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 35 ++-------------------
 3 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c78bb3be6303..24d22d8a2016 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -450,6 +450,22 @@ static const struct field_mapping feature_mappings[] __initconst = {
 	TDX_SYSINFO_MAP_FEATURES(TDX_FIELD_TDX_FEATURES0, tdx_features0),
 };
 
+#define TDX_SYSINFO_MAP_TDMR(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_tdmr, _member)
+
+static const struct field_mapping tdmr_mappings[] __initconst = {
+	TDX_SYSINFO_MAP_TDMR(TDX_FIELD_MAX_TDMRS,		max_tdmrs),
+	TDX_SYSINFO_MAP_TDMR(TDX_FIELD_MAX_RESERVED_PER_TDMR,	max_reserved_per_tdmr),
+	TDX_SYSINFO_MAP_TDMR(TDX_FIELD_PAMT_4K_ENTRY_SIZE,	pamt_4k_entry_size),
+	TDX_SYSINFO_MAP_TDMR(TDX_FIELD_PAMT_2M_ENTRY_SIZE,	pamt_2m_entry_size),
+	TDX_SYSINFO_MAP_TDMR(TDX_FIELD_PAMT_1G_ENTRY_SIZE,	pamt_1g_entry_size),
+};
+
+static const struct field_mapping dpamt_mappings[] __initconst = {
+	TDX_SYSINFO_MAP_TDMR(TDX_FIELD_PAMT_PAGE_BITMAP_ENTRY_BITS,
+			     pamt_page_bitmap_entry_bits),
+};
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 87e055a2546c..4faf07925dc0 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -65,6 +65,14 @@
 /* Class "TDX Module Info" */
 #define TDX_FIELD_TDX_FEATURES0			0x0A00000300000008ULL
 
+/* Class "TDMR Info" */
+#define TDX_FIELD_MAX_TDMRS			0x9100000100000008ULL
+#define TDX_FIELD_MAX_RESERVED_PER_TDMR		0x9100000100000009ULL
+#define TDX_FIELD_PAMT_4K_ENTRY_SIZE		0x9100000100000010ULL
+#define TDX_FIELD_PAMT_2M_ENTRY_SIZE		0x9100000100000011ULL
+#define TDX_FIELD_PAMT_1G_ENTRY_SIZE		0x9100000100000012ULL
+#define TDX_FIELD_PAMT_PAGE_BITMAP_ENTRY_BITS	0x9100000000000013ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 3996af787ff8..870caac6a585 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,37 +7,6 @@
  * Include this file to other C file instead.
  */
 
-static __init int get_tdx_sys_info_tdmr_dpamt(struct tdx_sys_info_tdmr *sysinfo_tdmr)
-{
-	int ret;
-	u64 val;
-
-	ret = read_sys_metadata_field(0x9100000000000013, &val);
-	if (!ret)
-		sysinfo_tdmr->pamt_page_bitmap_entry_bits = val;
-
-	return ret;
-}
-
-static __init int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
-{
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000008, &val)))
-		sysinfo_tdmr->max_tdmrs = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000009, &val)))
-		sysinfo_tdmr->max_reserved_per_tdmr = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000010, &val)))
-		sysinfo_tdmr->pamt_4k_entry_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000011, &val)))
-		sysinfo_tdmr->pamt_2m_entry_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000012, &val)))
-		sysinfo_tdmr->pamt_1g_entry_size = val;
-
-	return ret;
-}
-
 static __init int get_tdx_sys_info_td_ctrl(struct tdx_sys_info_td_ctrl *sysinfo_td_ctrl)
 {
 	int ret = 0;
@@ -111,7 +80,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 		sysinfo->version.update_version);
 
 	ret = ret ?: read_sys_metadata_table(feature_mappings, &sysinfo->features);
-	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
+	ret = ret ?: read_sys_metadata_table(tdmr_mappings, &sysinfo->tdmr);
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
 
@@ -122,7 +91,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	 * DPAMT but don't expose the metadata.
 	 */
 	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
-		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
+		ret = read_sys_metadata_table(dpamt_mappings, &sysinfo->tdmr);
 
 	return ret;
 }
-- 
2.52.0

