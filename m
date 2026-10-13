Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0D551995;
	Tue, 13 Oct 2026 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905620; cv=none; b=J3Xg+twaNPZMVAm60edYbxw/9KBL9k8H47rmoqwUjz0TxW9QMa4H9nPOMmBC7v8oXfNDGtAnDjMOcEuAhb8DzMhEwxM3aNSrbR+VZ/tAC9D40JrkXhJ4fbTjAQCo1h8EUeVxM4BjiA08vb13gxYoj3g6hpgLBiD0vlhoosxxpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905620; c=relaxed/simple;
	bh=2Cq492Rda5Gd/cA9Y+c2DXrNjFoE6IDDtt8RDzeZ/7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itMuJPoJ3xl6BLbCN9u6SQH+9Wbah8py7oEHDlruRjQvoIZkFKLWr61/O4f5/3Lyv/xqOOTDwNBLy6pma9ydET+EFACF+h3TKNZEtZrIfDOVr7QYPgJIk92AveElmszEUNtEDY4qyxTZdxLaTP+ccw96BljbDaG7Sh4RgFQbw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHXxJV32; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHXxJV32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791905618; x=1823441618;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2Cq492Rda5Gd/cA9Y+c2DXrNjFoE6IDDtt8RDzeZ/7E=;
  b=bHXxJV32gVdRJXPkRjH7gc1sclIETkAaQXruNI/5ls6/ju+y3pKh2EBC
   60ZXg5JZY2w+LFJWRSZdyIgEQqspEOOGVQjITN9XHgylqMKrinx2ZQ3vX
   utiUzOxxwsNF8u4rb8MVNqP2BPsUSpqbQHW/7Vohyp5KQuZoQdIorwihX
   xhDjBNbKSp5p4f4AIY4AlP1SQDYGOh1H1Svcppc9Rh4Yr8/AImA2sahhj
   Jp6TxBG1S6Z16bO0/VJisZYyTMjmaql8TS/nM+dlnIoRDt1WRj4AbEjWx
   fUe5aUV+BzpYFEiWtWO+8qalE+rFhPCAPFoSsYwc8jjxBrv8y3XfQSXgI
   w==;
X-CSE-ConnectionGUID: CApqsB5yT5+fMTioxb4RHA==
X-CSE-MsgGUID: di+7b//MRwSfE8rNQ9Q2jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="643394"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="643394"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:33:38 -0700
X-CSE-ConnectionGUID: TVLNEhQNRJSPsiDScobThg==
X-CSE-MsgGUID: uWJc5um8SNKuDVcxx2kP8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1388135"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa001.fm.intel.com with ESMTP; 13 Oct 2026 08:33:34 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Tue, 13 Oct 2026 23:28:52 +0800
Subject: [PATCH v4 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-tdx-module-ext-v4-2-de5ffac65470@linux.intel.com>
References: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
In-Reply-To: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
To: x86@kernel.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, 
 kvm@vger.kernel.org, yilun.xu@intel.com, yilun.xu@linux.intel.com, 
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4689;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=2Cq492Rda5Gd/cA9Y+c2DXrNjFoE6IDDtt8RDzeZ/7E=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWSd8wv/5/bL8ptEyeFJ8vUlxSIxPxXO+nQ08ngFBBjd3
 XSmZyFzRycLgxgHg6GYIssCj1lOU9pnMW39tPMazBxWJpAhwjKVmTmleXoVpQ6ZeSWpOXrJ+bkM
 XJwCMFU+EQz/fTfIW+//ZfphidyiqgNvk70rNLZONPE5s2OZyNqmu++Wv2b47/140d0lF9V/Lds
 ZM4Hhi2GMv5oAh8SqOunkaZ4uTC6vuQA=
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

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

Despite that these features can be add-ons due to introducing some
overhead to TDX runtime, the impact of the first features will be low
enough to pursue a simple approach of just enabling them when supported.
If a feature with a very high overhead appears in the future, this can
be revisited. Add a get_tdx_usable_addon_features0() helper to return
the bitmap of the add-on features that the module & kernel both support.
Pass this bitmap as an argument to TDH.SYS.CONFIG. Initially, this
helper returns 0. It will be updated to return specific feature bits as
full kernel support lands.

The TDX module requires SEAMCALL leaf version 1 for TDH.SYS.CONFIG when
passing the new bitmap argument. A previous change [2] supports the
versioned SEAMCALL leafs by adding a "version" field in
struct tdx_module_args. Set the version field to 1 if the new bitmap
argument is used to enable any add-on feature, otherwise keep the
version as 0. This retains backward compatibility with older modules
that don't recognize version 1.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://lore.kernel.org/all/20260904215841.303070-10-rick.p.edgecombe@intel.com/ # [1]
Link: https://lore.kernel.org/all/20260921-seamcall-version-v7-1-cf05fe76b467@linux.intel.com/ # [2]
---
v4:
 - Add explanation why kernel enables add-on features solely on
   available support in the 3rd paragraph of the changelog. (Rick)
 - Collect Reviewed-by tags

v3:
 - Update the stale changlog for bitmap arg of the wrapper (Chao)
 - s/get_tdx_addon_features0()/get_tdx_usable_addon_features0() (Tony)
 - Collect Reviewed-by tags

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
index b099aa4056f5..f08278a47aff 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1042,9 +1042,19 @@ struct tdmr_info_pa_array {
 	DECLARE_FLEX_ARRAY(u64, phys);
 };
 
+/* List all kernel-supported add-on features0 bits here */
+#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
+
+static __init u64 get_tdx_usable_addon_features0(void)
+{
+	return tdx_sysinfo.features.tdx_features0 &
+		TDX_KERNEL_SUPPORTED_ADDON_FEATURES0;
+}
+
 static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
 				 unsigned int nr_tdmr_pa, u64 global_keyid)
 {
+	u64 addon_features0 = get_tdx_usable_addon_features0();
 	struct tdx_module_args args = {
 		.rcx = __pa(tdmr_pa_array),
 		.rdx = nr_tdmr_pa,
@@ -1056,6 +1066,15 @@ static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
 		args.r8 |= TDX_SYS_CONFIG_DYNAMIC_PAMT;
 	}
 
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

