Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3B4F7CD5;
	Fri, 18 Sep 2026 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738306; cv=none; b=qSmLLjsdjJ+YhYVh7Xui/CiX6IvbYeAbnQbqRO711FNI7l7UBn3QI0oZHvMrtlqFTJYMNRXkl6KS9HcKC1bRFUP1uKp333kFzHwFYrwdO+8D6gzVerT5Hnx+iVZQoIikAKzjuUrQRwW28yY+1T5Me8yJe9xuFPoS1NP6LeU2ju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738306; c=relaxed/simple;
	bh=O3wItZforq4puw9Y7zK8QE7JChTIKNAxjV9FcIEkohE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYDmHGng6RRpXvsbOQ6UWkMk69k+0rZr5jVt8n5PdUK3Fq2CS/5Ssr46vTR9hyA6XjzFFadOeYCHO4m9R6bqU9VAEAIgIULi5UwEG1bnPfbGNkwAsUlpUPLICpH/YafGpiUIyieNBrfI/N69sR3uqjLtuyjy7XdCnJS0Qcboaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfcCq0cg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfcCq0cg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738302; x=1821274302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O3wItZforq4puw9Y7zK8QE7JChTIKNAxjV9FcIEkohE=;
  b=JfcCq0cg8urYLYHJbQqHiaEMuWBCxnhLiz3BJB9etkapHvPmFYs/NFCI
   xWdYRAbzHWBBzdAmtddku20j9HjPVS0gWsM7QhVgCPHD+jhJW7YrZKIn+
   hW/vWz3Ah5ni9rWoSCpQO/3XRJ61qToJZLoajtSBcInbH1FVoeOB66nMI
   xWbXdvvQKiWR4Sy2zqj8qljRcINNWFqn/+DyHp20Pl1V59breL7u3Cy/f
   OAFRrYCrKUE51I2SIKIBvvX4q61K+2MLviaDFia6/mUA1/hV2TqQMi1Ml
   RWGj52tw3lQ9M/ZCEAkReeZ5/pb08TCOUOqtf7y6Gyu4pvrkUP9eb1GDE
   w==;
X-CSE-ConnectionGUID: WzJu75mdQEijAtG1ipe9Yg==
X-CSE-MsgGUID: XfdQFcN4Q3mZMIJiEzi0sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776110"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776110"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:40 -0700
X-CSE-ConnectionGUID: 81Ti00v6TrCuTxtAp6i+gw==
X-CSE-MsgGUID: gjmPZXpfQxSd9Sn1cFpW5A==
X-ExtLoop1: 1
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:39 -0700
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
Subject: [RFC PATCH v2 02/10] x86/virt/tdx: Convert the version metadata reader
Date: Fri, 18 Sep 2026 06:29:21 -0700
Message-ID: <20260918132946.76533-3-chao.gao@intel.com>
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

With the helper to read a table of metadata fields in place, the
existing metadata readers can be standardized on it.

Convert the version metadata reader: add a table that pairs each field ID
with the 'struct tdx_sys_info_version' member that holds its value, and
read all version fields by walking that table.

Name the field IDs for readability, so the table entries don't carry raw
hex literals.

Also add read_sys_metadata_table() macro to derive the number of entries
with ARRAY_SIZE() so that callers don't need to pass it separately.

AI was used under supervision to review code and workshop logs. It suggests
adding read_sys_metadata_table() macro.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 21 +++++++++++++++++++--
 arch/x86/virt/vmx/tdx/tdx.h                 | 10 ++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 15 ---------------
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5cd9c6eb98c2..0c8b571f5186 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -408,8 +408,8 @@ struct field_mapping {
 };
 
 /* Read each metadata field listed in @mappings[] into @data. */
-static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *mappings,
-						    int num_mappings, void *data)
+static int __read_sys_metadata_table(const struct field_mapping *mappings,
+				     int num_mappings, void *data)
 {
 	int i, ret;
 	u64 val;
@@ -431,6 +431,23 @@ static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *
 	.size		= sizeof_field(_type, _member),		\
 }
 
+#define TDX_SYSINFO_MAP_VERSION(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_version, _member)
+
+static const struct field_mapping version_mappings[] = {
+	TDX_SYSINFO_MAP_VERSION(MINOR_VERSION,  minor_version),
+	TDX_SYSINFO_MAP_VERSION(MAJOR_VERSION,  major_version),
+	TDX_SYSINFO_MAP_VERSION(UPDATE_VERSION, update_version),
+};
+
+#define read_sys_metadata_table(_table, _data) \
+	__read_sys_metadata_table(_table, ARRAY_SIZE(_table), _data)
+
+static int get_tdx_sys_info_version(struct tdx_sys_info_version *version)
+{
+	return read_sys_metadata_table(version_mappings, version);
+}
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index a886c54decaa..44124f399703 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -60,6 +60,16 @@
  */
 #define TDX_VERSION_SHIFT		16
 
+/*
+ * TDX global metadata field IDs.
+ *
+ * See "global_metadata.pdf" in Intel TDX Module ABI Definitions.
+ */
+/* Class "TDX Module Version" */
+#define TDX_MD_FIELD_ID_MINOR_VERSION			0x0800000100000003ULL
+#define TDX_MD_FIELD_ID_MAJOR_VERSION			0x0800000100000004ULL
+#define TDX_MD_FIELD_ID_UPDATE_VERSION			0x0800000100000005ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 98ebf17aab1c..9510bf5f6e7d 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,21 +7,6 @@
  * Include this file to other C file instead.
  */
 
-static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
-{
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
-		sysinfo_version->minor_version = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
-		sysinfo_version->major_version = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
-		sysinfo_version->update_version = val;
-
-	return ret;
-}
-
 static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
 {
 	int ret = 0;
-- 
2.52.0

