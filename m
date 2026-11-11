Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369422;
	b=pHSDABCgRq0QU7HFj6/0GKAFhp0WPbkQatzm390vLRAEyYBwLdh1sRxvBhxGWOG3cXRY
	 BKz+lCgHQ0o8DDdNVQMUjQ0+aBdhQRKCto2mbrisO3OVZlPS/nl0gXuWZxuj0nV8HtugD
	 Eooh52K1PdPC33S0rxNH6i7YjY5C2fPtk6TRntEgUK12YxkX7Q0aDW4Ay9R6UzcCbixGU
	 11jrB9Ojbh5QdyeCU7e2cCUZiweakPlWjCoz7tn2m5nHn7WKeoHrQWpqBkJnfw/wRg6MC
	 lsiM+fZTaixSuyfJc/euhEe64yGzC+ldNJJBL6rrXoLrBmqmJGs4+jqGXSdYTEpzwuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369422;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=aW52MSVMDUNqdZBYe8tY4GK6/Ss5cefT5msxBqz4Pw8=;
	b=vYUDcWSiQAbqWsJ8qn5+FswNk0yqPZdNfnn+r4A7tR8UY7vAe68EUQ8Xd9mKmDPX+D3q
	 GWq3oaX8NZXEro0Typn1XdflMPGANjGdE+HJDWSgqLL1BnDF8ovQIMjjlQC87IkH6IWPr
	 tWOkIAOLa8df42lmRWpSHN0o+EBg3qZF/DXIVHcq8uG0BGczo1/D6cNca0jLV4BbH2sky
	 H5ZedAT6PVS6uWnKXrixEmGXelVFBLtTigzCM5hcdQyI0Hv4jo/gxIqnPYfv/zChDN94y
	 7Rd3Bnxpg0KDwbjSHKJcNt1Pc89EuDPHzIMq6NGteSGQUrvv3YuUg0hWhvXnlxNYrtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VAZ7groP;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB5606A330;
	Wed, 11 Nov 2026 03:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AFB5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VAZ7groP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794369422; x=1825905422;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ytxrf9xHT5lRbCb14me1YZtsQUFkAuoEaA5HyzvQy6U=;
  b=VAZ7groPif+2a/JenjCgleJjJWKmNIVHfr5yIbchAagxTF3p4Z/Btokp
   t44ls8fo5u+xVNI94qzSFPf+Y4IU/jOw2ikoAhcUtluJxF23qF5HFV2Sc
   9WxOYBPUxfqE2Hjr+02txH6LNL2mnSp5JTcbPnSbTAIOT5CD6xdRhp2kQ
   R+Tz1G3GS/J3f8ykwSvCnrVvdoAnh85ouLq+gyUrsZQ86DwdMFIeOftIf
   dmzIbxVzBHZWyf2BYhUEyC15KwY5DRwvLAcKxq8WJJz6F8aaaMDccFmad
   zAxxfWXRv2JfkOL37m1TuXFUh/MfE/WaEvZ9k7xsePbLSlDNxqi8hB8bC
   Q==;
X-CSE-ConnectionGUID: 85ihy/IeRemORLlSOcyFmA==
X-CSE-MsgGUID: KdGBjkx2RKGxkaL7xfijrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3220276"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3220276"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:57:02 -0800
X-CSE-ConnectionGUID: iTq/pHswSaqElNNUK2y9EA==
X-CSE-MsgGUID: dfeMHGvDSzuLBsUsydYiPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10199227"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 10 Nov 2026 19:56:58 -0800
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Wed, 11 Nov 2026 11:48:42 +0800
Subject: [PATCH v5 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into a
 wrapper
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-tdx-module-ext-v5-1-c74f764abc3d@linux.intel.com>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
In-Reply-To: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3847;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=ytxrf9xHT5lRbCb14me1YZtsQUFkAuoEaA5HyzvQy6U=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWR9frp89cES5hdna4Ilv8dlfa+cEbB03cKLFj4rJiQ8N
 zTcvao2tqOThUGMg8FQTJFlgccspynts5i2ftp5DWYOKxPIEGGZysyc0jy9ilKHzLyS1By95Pxc
 Bi5OAZgq7gyGf0pT0z93fb0+6ULpPZWwq8d6dR6LH1u279ZuPrtJwT2n1lkwMpxe4qXupdludvV
 jm+pP3xeX+GXyU2tdZoXofXU7vbZ2HgsA
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

TDH.SYS.CONFIG is currently not wrapped in a SEAMCALL wrapper because it
is not exposed to external callers (such as KVM), also because the
level of TDX ABI details needed to perform the call is low enough to
flow well with the calling code.

But as more configurations are being added to this SEAMCALL leaf, more
ABI details are leaked into the surrounding caller code, which decreases
the readability of the caller logic. The first case is that the Dynamic
PAMT (DPAMT) change [1] tweaks the R8 argument based on whether DPAMT is
supported by the loaded TDX module.

A follow-up case comes as the TDX architecture has evolved the ABI to
introduce new leaf versions. The host must select the version to call
based on what new features are supported by the loaded TDX module.

Before the version selection makes the caller logic even messier, move
the register ABI operations into a wrapper.

The original changelog was written by hand. AI was used to help correct
grammatical errors and polish individual sentences for better
readability.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Link: https://lore.kernel.org/all/20260904215841.303070-10-rick.p.edgecombe@intel.com/ # [1]
---
v5:
 - Drop the tdmr_info_pa_array stuff (Dave)
 - Simplify the changelog (Dave)
 - Remove all Reviewed-by tags due to code change
 - Better clarify the AI usage

v4:
 - Cut the redundant opening words in the 1st paragraph (Rick)
 - Collect Reviewed-by tags

v3:
 - sizeof(tdmr_pa_array->phys[0]) instead of sizeof(u64) (Rick)
 - Re-phrase the code comments for struct tdmr_info_pa_array (Tony)
 - Refactor the changelog
 - Collect Reviewed-by tags

v2:
 - Remove TDH.SYS.UPDATE wrapper (Dave & Rick)
 - Talk about the handling of in-memory ABIs for SEAMCALL wrappers
   (Rick)
 - Refactor the entire changelog according to Rick's suggestion (Rick)
 - Add code comment for struct tdmr_info_pa_array (AI nitpicker)
 - Use kernel data type for nr_tdmr_pa parameter (AI nitpicker)

v1:
 - This patch is split out from the last series (Rick)
---
 arch/x86/virt/vmx/tdx/tdx.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 96ced0494b68..c7bd0b01786d 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1033,10 +1033,26 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 
 #define TDX_SYS_CONFIG_DYNAMIC_PAMT	BIT(16)
 
+static __init int tdx_sys_config(u64 *tdmr_pa_array, unsigned int nr_tdmr_pa,
+				 u64 global_keyid)
+{
+	struct tdx_module_args args = {
+		.rcx = __pa(tdmr_pa_array),
+		.rdx = nr_tdmr_pa,
+		.r8 = global_keyid,
+	};
+
+	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
+		pr_info("Enable Dynamic PAMT\n");
+		args.r8 |= TDX_SYS_CONFIG_DYNAMIC_PAMT;
+	}
+
+	return seamcall_prerr(TDH_SYS_CONFIG, &args);
+}
+
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 				    u64 global_keyid)
 {
-	struct tdx_module_args args = {};
 	u64 *tdmr_pa_array;
 	size_t array_sz;
 	int i, ret;
@@ -1058,16 +1074,8 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++)
 		tdmr_pa_array[i] = __pa(tdmr_entry(tdmr_list, i));
 
-	args.rcx = __pa(tdmr_pa_array);
-	args.rdx = tdmr_list->nr_consumed_tdmrs;
-	args.r8 = global_keyid;
-
-	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
-		pr_info("Enable Dynamic PAMT\n");
-		args.r8 |= TDX_SYS_CONFIG_DYNAMIC_PAMT;
-	}
-
-	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
+	ret = tdx_sys_config(tdmr_pa_array, tdmr_list->nr_consumed_tdmrs,
+			     global_keyid);
 
 	/* Free the array as it is not required anymore. */
 	kfree(tdmr_pa_array);

-- 
2.25.1

