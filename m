Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8794D956C;
	Mon,  5 Oct 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222355; cv=none; b=YrZwNJxKpwZG1XPXurzuOFIvV4UGIHpwW7IsaPaRzMx+0CXHx6zRQ+YQJ8bY/GTS7kOmD3o5MzYJFClDtKuJeaoY9cu0A3kYiBac6OQJApaqSlBcaNZAw+iiAoKwn62UMnZSDF325RX87ZqRWiFyZEQIy0z1Paz8F4SvsikRCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222355; c=relaxed/simple;
	bh=xAJ3F/8TMk8dJ3G9TqJ1KpfpzrZU03LViVTNLIDeiCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzhgXdW/nb8Ke7l4SO8yAJP5tQ46h42hTg0uoKP0tjTOVfNlGczdmCpeoV1kFb7Tc0Z5mjBVUftubLFavV9lh0gHz5gIBndX7eHopEdt58pcGREmjdVDzOoBNjdwvIR5V0zcklMobmKsYHCHgXu9PAj/uvwBxIk89z+sfKRwW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmIGfrgm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmIGfrgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222353; x=1822758353;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xAJ3F/8TMk8dJ3G9TqJ1KpfpzrZU03LViVTNLIDeiCM=;
  b=nmIGfrgm+HXvBR+6SghM3NIjHCGgTocT6RZdaOxrpjwu0gKTM09sDG8y
   ZclN/rNYkNl/MrjzqsX0JZKXC4nHFYJh3hszJ5EuT/PAOfcC0vcFuR2jf
   KWBNlMxSxbmU49CwIHUKSAPuhp/64CcHgszHyN6ZHhYf44alxLYjPUFZF
   iPC1zjnmo9K0BFOwcOUEViZvyf1s0/DIVJd24bZwRnVwg38/9ZNHGmIEE
   v5nR7WKwDxtHb6515VoIrQfnVZchd3iizzpqdmOhyzKhMce5IAkOTREdd
   NidLQB8tFE7GeFp6K9+x6BOA7AujqgkCjmPkWzVRTrHELFPHqxddIftba
   w==;
X-CSE-ConnectionGUID: rHpb2bfUTrmDSUy2yRBhvw==
X-CSE-MsgGUID: /k05p0OwRWSaCgzmLUEEVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102419780"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102419780"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:45:53 -0700
X-CSE-ConnectionGUID: xPUn1QPHSYCWjZ7Gxfd+iQ==
X-CSE-MsgGUID: WW8GYm0+SNOI60ey/ddXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="276002286"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 05 Oct 2026 10:45:49 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Tue, 06 Oct 2026 01:41:46 +0800
Subject: [PATCH v3 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-tdx-module-ext-v3-2-db52cb05b918@linux.intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
In-Reply-To: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4115;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=xAJ3F/8TMk8dJ3G9TqJ1KpfpzrZU03LViVTNLIDeiCM=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWQdfjir48Ee6/j7mj8aiw/9WHVisYWobWhmwKXs9q7mn
 XdiP87d1NHJwiDGwWAopsiywGOW05T2WUxbP+28BjOHlQlkiLBMZWZOaZ5eRalDZl5Jao5ecn4u
 AxenAEwV01yGf9o+B2O+abR85+bl9XrN5LMklsn1VteiJ8fPzp0hv0zq0yWGn4win9IU67VMlVO
 FDIPKZn9ZrOJz9Yau/GST/QLf5704zgoA
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

The kernel needs to enable these add-on features when it supports them.
Add a get_tdx_usable_addon_features0() helper to return the bitmap of
the add-on features that the module & kernel both support. Initially,
this helper returns 0. It will be updated to return specific feature
bits as full kernel support lands. Pass this bitmap as an argument to
TDH.SYS.CONFIG.

The TDX module requires SEAMCALL leaf version 1 for TDH.SYS.CONFIG when
passing the new bitmap argument. A previous change [2] supports the
versioned SEAMCALL leafs by adding a "version" field in
struct tdx_module_args. Set the version field to 1 if the new bitmap
argument is used to enable any add-on feature, otherwise keep the
version as 0. This retains backward compatibility with older modules
that don't recognize version 1.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/all/20260904215841.303070-10-rick.p.edgecombe@intel.com/ # [1]
Link: https://lore.kernel.org/all/20260921-seamcall-version-v7-1-cf05fe76b467@linux.intel.com/ # [2]
---
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

