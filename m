Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E1480357;
	Tue, 15 Sep 2026 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468033; cv=none; b=Y7sgrRPMLQzc8a8Phlp1oqYDHaOFT/C9/5jjyWSvicCKAU9zjP6wNDc1iYKQJXqXozMLjNzXqlHTI29IXGCzlnvAB7m4P+iQhAHu6X0sXlhLPZf4dWYnSOkLmbHd7osmjCnbt4+a+uJHpxqob5ZS50au0de0ilEyae7bT6/L1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468033; c=relaxed/simple;
	bh=bp+z2jdgbjJpVOGjoCjP1FdJENz9rAxFgp9vAKK+8eM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxEyERjtnh7M5P9OrGu2hVzM42VxICdaPtg3PaIc6FdtJGHao//AKHhZZUO8l0ObPaJC+G3Gk3T1uImRNyggmBFWy9t2pQKeEdhZY6fdzsbZpcW+ldxy5ImKQk/8QlunWY5pkEXe99jQ0HpKXGbXUoWGZRuAkzjFDCPDHhJvPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByiMAkRb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByiMAkRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789468032; x=1821004032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bp+z2jdgbjJpVOGjoCjP1FdJENz9rAxFgp9vAKK+8eM=;
  b=ByiMAkRbijI3JYoaDcNSxgNY1uwrPlHQOuJ7TyHVpt4wBp/o+upLj7vw
   JHTUvhxWyCh0fTcYjS4yu9pY4LBf67r/nEK9iEgX+R7daF6MM7RiHrK2J
   pjew8qR1THSdXorxC817pXCpV29GmGbMPdcyLIw/JQ/fXc0uus7+rZGE+
   R6+1rcmztsq/s2+WrhanhqQub4QDIWR9V7PwRXffLg/OMZSCJBV/MfQzK
   AMjzXWdrEMo/AhDJSuLQiGxpz7XIA5Ii4FJopEmq5Oj2ov2ke7vcURvmE
   B6BQq0ou9Qc2cfp21j1Oi36l48ngkIweVQ7Jo5rGnA6YT8+Ji9EGdMYLE
   g==;
X-CSE-ConnectionGUID: dxG0hX8SQx6yF/zzPzeYRA==
X-CSE-MsgGUID: hJXPRnneTdWEO47bTwRtCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115362202"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115362202"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:27:12 -0700
X-CSE-ConnectionGUID: X/px7hbeTIinkAJf5rUFZg==
X-CSE-MsgGUID: 5S+KW7TSSRSA/zMaeAqPyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277084267"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa005.jf.intel.com with ESMTP; 15 Sep 2026 03:27:08 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org,
	nik.borisov@suse.com
Subject: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX module init
Date: Tue, 15 Sep 2026 18:26:55 +0800
Message-Id: <20260915102658.713079-3-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915102658.713079-1-yilun.xu@linux.intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX architecture identifies some features that are off by default
but can be enabled by the host during TDX module initialization. They
are classified as add-on features because enabling them affects existing
TDX systems: they may change existing feature behavior, or reserve more
memory.

The TDX module extends TDH.SYS.CONFIG with a new register argument to
specify which add-on features to enable. This new argument is a bitmap
that uses the same feature bits as TDX_FEATURES0. Note that Dynamic PAMT
is an exception: although it is an add-on feature, it is controlled via
a legacy, dedicated register argument [1].

The kernel needs to enable these add-on features when it supports them.
Add a get_tdx_addon_features0() helper to return the bitmap of the add-on
features that the module & kernel both support. Initially, this helper
returns 0. It will be updated to return specific feature bits as full
kernel support lands. Pass this extra bitmap to TDH.SYS.CONFIG wrapper.

The TDX module requires SEAMCALL leaf version 1 for TDH.SYS.CONFIG when
passing the new bitmap argument. A previous change [2] supports the
versioned SEAMCALL leafs by adding a "version" field in
struct tdx_module_args. Set the version field to 1 if the new bitmap
argument is used to enable any add-on feature, otherwise keep the
version as 0. This retains backward compatibility with older modules
that don't recognize version 1.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Link: https://lore.kernel.org/all/20260904215841.303070-10-rick.p.edgecombe@intel.com/ # [1]
Link: https://lore.kernel.org/all/20260722084634.131020-1-yilun.xu@linux.intel.com/ # [2]
---
v2:
 - Don't pass addon_features0 parameter around, get it in the wrappers
  (Dave)
 - Remove TDH.SYS.UPDATE wrapper (Dave & Rick)
 - Drop the changelog section explaining why add-on feature enabling is
   needed in this series, as it is a generally understood pattern (Rick)
 - Add a note in the changelog that Dynamic PAMT is not enabled via the
   new bitmap argument (Rick)
 - Add __init tag for get_tdx_addon_features0() (AI nitpicker)

v1:
 - Use tdx_module_args.version to assign SEAMCALL leaf versions (Dave)
 - Remove DICE specific descriptions (Rick)
 - Remove the global var tdx_addon_features0 (Chao)
 - Add a Macro to collect kernel supported add-on feature bits (Rick)
 - Changelog & code comments change
---
 arch/x86/virt/vmx/tdx/tdx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e06932f80395..763c2d1b25d0 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -998,6 +998,15 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 	return ret;
 }
 
+/* List all kernel supported add-on features0 bits here */
+#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
+
+static __init u64 get_tdx_addon_features0(void)
+{
+	return tdx_sysinfo.features.tdx_features0 &
+		TDX_KERNEL_SUPPORTED_ADDON_FEATURES0;
+}
+
 /*
  * This is an array of HPAs, each points to a TDMR_INFO data structure (see
  * struct tdmr_info).
@@ -1012,12 +1021,22 @@ struct tdmr_info_pa_array {
 static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
 				 unsigned int nr_tdmr_pa, u64 global_keyid)
 {
+	u64 addon_features0 = get_tdx_addon_features0();
 	struct tdx_module_args args = {
 		.rcx = __pa(tdmr_pa_array),
 		.rdx = nr_tdmr_pa,
 		.r8 = global_keyid,
 	};
 
+	/*
+	 * Use SEAMCALL version 1 that supports add-on features if any are
+	 * requested. Otherwise use version 0 for backward compatibility.
+	 */
+	if (addon_features0) {
+		args.r9 = addon_features0;
+		args.version = 1;
+	}
+
 	return seamcall_prerr(TDH_SYS_CONFIG, &args);
 }
 
-- 
2.25.1

