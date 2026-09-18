Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511E4F93BC;
	Fri, 18 Sep 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738310; cv=none; b=ZvpIl1gzBmXB7K6ofPiexNYN+rCZOaY0IpghXzlwJSroVYFDplNO1n4IFMJbREMaebWayW7dv4Dm2e0OgndtGrFWZAAcNPj4RiJ2gqcBdEsbc1KFcHxTkw4NDzD2TqwnCX5pbOfJCn9TM1iL8/ZB7Tf38Q1As0Ct3qfVRxuZnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738310; c=relaxed/simple;
	bh=EqfvilIIE2pdrjBJmm3xhJF1bcC03ahcTeTplAfklD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jadHwOmvade2iRfsHqplyblYzadSBVvfK7YBq9JYld97hOcTLIINGh5W54pYgzTs4ajs/D1KCidD7l3aCoR+ChV0AsJ08q5lvy5oNClX27+8awP0ZnORv7uhh4YH09YPHD3KZjnd0CQo5IJZzd94cqCdQAYrFQd5RG7YGnICOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhvN9oWf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhvN9oWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738304; x=1821274304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EqfvilIIE2pdrjBJmm3xhJF1bcC03ahcTeTplAfklD4=;
  b=LhvN9oWfxJcCa/MXJ/aUi7grqoRtqrTmGwJoPomAnV5LAbl0e8ZqHjMR
   7pAaQaiL7fsfnvI9ffqSCQy9XEDan/a/B9wYCHRpmw1vEhthlCJSBylUX
   lugDng9Se+VQk08N6eYLZz46xCCeMPKLAkT89gVxv4aSGRWYacxHyHcaW
   AHsJ5z1Rmpu/mMMfXiZe8BhLje+ckjYROHB6e4NV8/8bSbuY3DMezT7uE
   RRLjZGvVfZ6hggOrd0N1dcGuEtt6JxXRw7UiO6aJ07MPCguJB9zXh/YgH
   +J3r1cTm1SM5MyD9O4YsekmHPSfQOMhKEa/BUb1D532vDXlhkt58a6Czi
   A==;
X-CSE-ConnectionGUID: vzgi5ApUThOzWoWhmlYaCw==
X-CSE-MsgGUID: EATjtLclQ56DVOfoOeEChA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776119"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776119"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:41 -0700
X-CSE-ConnectionGUID: 9maZjgg8QpaqY3TB+XiLgw==
X-CSE-MsgGUID: /7SGrj6jS3CI0qXbiWq9bg==
X-ExtLoop1: 1
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:40 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [RFC PATCH v2 03/10] x86/virt/tdx: Convert the features metadata reader
Date: Fri, 18 Sep 2026 06:29:22 -0700
Message-ID: <20260918132946.76533-4-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918132946.76533-1-chao.gao@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
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
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 12 ++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  3 +++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 11 -----------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 0c8b571f5186..59e2396fea39 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -448,6 +448,18 @@ static int get_tdx_sys_info_version(struct tdx_sys_info_version *version)
 	return read_sys_metadata_table(version_mappings, version);
 }
 
+#define TDX_SYSINFO_MAP_FEATURES(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_features, _member)
+
+static const struct field_mapping feature_mappings[] __initconst = {
+	TDX_SYSINFO_MAP_FEATURES(TDX_FEATURES0, tdx_features0),
+};
+
+static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *features)
+{
+	return read_sys_metadata_table(feature_mappings, features);
+}
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 44124f399703..582b6ff9a0bb 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -70,6 +70,9 @@
 #define TDX_MD_FIELD_ID_MAJOR_VERSION			0x0800000100000004ULL
 #define TDX_MD_FIELD_ID_UPDATE_VERSION			0x0800000100000005ULL
 
+/* Class "TDX Module Info" */
+#define TDX_MD_FIELD_ID_TDX_FEATURES0			0x0A00000300000008ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 9510bf5f6e7d..615f4d23c5d8 100644
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
-- 
2.52.0

