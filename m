Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369427;
	b=l4nCyifN4OHP1qXPjGMno9eWiV+ARI8l5oJIy6JlF2Z6neHZHhyO42LA+wg332htWGHp
	 +u7frXHmFJv9e7gDJMXI2xPk/cTuIqGxoezuMOmpgp4PI3Az0/vXJWO7QslnEWKOC3Ra5
	 udDJBxmr/tIOJ6FW3pmE9PWnFGuRlKzSiD43fIIS6pFDy1v60Uzz+XjZQvg92934kR+VD
	 rmwr8SjbONT0n3aKXXQyF3BQCdMtjTf2aRqIOHwsOQR1dMPWXPBYrMnPKp5BhfN9DaL/+
	 Jxg4hx8LLLQaKO2VZICkeeEst2rH0UDemjibe5hqhe+aMAONMyT4uDFtT2y44EyhbBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369427;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=CSEz8qxghozwaDtTAs+AP/lbLZJS5cfpZ0YaPk3UawY=;
	b=vjbg2LWPDV6eIc6NO3CM1O4giWcOSJ4HOHd3dkaQpGL0AiuagM2JX5wba5387igoZHl5
	 eU5hnxLeX53gkCbTJQfW9SdrVJ9eacbrMzHPsx7h5O5MFxnl6SmMMStNFQ1km9s9O0kJj
	 y9XxHCkzLYo8x1gz8rFoqKR3Fa/AhracqOA14uuhaMLSy8n8g5YJqp7fDBKTprjMh3EEl
	 45sWhObt7D6NR3MxpXwPvPwentUUIU2SboGhTJM06+bWFhYKXKA7cfFpPLPwM7tVQu6CQ
	 NOMorLAmL2hMYSZ6E5FeukU7ZA14+/8BNNNMiD6wbLgJ2MN8+wiw5Neqya0LF1FhgNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dAwJfF3K;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1268606A324;
	Wed, 11 Nov 2026 03:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1268606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dAwJfF3K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794369427; x=1825905427;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1AgkZMDZ9wupKpCh5EP7vtfRDJS7fB/MjH80W+f07lc=;
  b=dAwJfF3Kn0tNnki9kbmgrPCy0olgLnRfbbUNkqFpdPrP7u8Ln29ScggN
   0ubi+6xHKn/U2b2ccyb509ejji/LINA4ktaC88SefyM2v3/y/OzI/+Azn
   68copSynapPFH96tGG2n62YxfyYR3eXqaCGN08ymhECleCKkJUcrCznPL
   FWjoeyi7DOqLroV3Z2fKYmsY1SvgN2p7dGaq7NUe7xL1+HXl53zZOn2/7
   +6IBfi4nl1ZCY2n9NA+wCygZ+TSZrXrTHWpkT8t+wljPjFJpmEV/PSmfy
   iC6NzHXehRLGTwkHQs4jEO0NQBfwhUk4IJVs9/jtauuN4caCmAMGNUpAZ
   A==;
X-CSE-ConnectionGUID: huSvUD52RiOSLGG5oUZovg==
X-CSE-MsgGUID: mTNVikPXTyOWyNPRnC7hjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3220281"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3220281"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:57:07 -0800
X-CSE-ConnectionGUID: +8MGP+gYReaiQ6k3MS2Zhg==
X-CSE-MsgGUID: dXsbyxssTFKDp7T4cpu9UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10199240"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 10 Nov 2026 19:57:03 -0800
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Wed, 11 Nov 2026 11:48:43 +0800
Subject: [PATCH v5 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
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
Message-Id: <20261111-tdx-module-ext-v5-2-c74f764abc3d@linux.intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4418;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=1AgkZMDZ9wupKpCh5EP7vtfRDJS7fB/MjH80W+f07lc=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWR9frpcT+3Kz62Pk+aJHj+4I8rB083KUk9E0PJf0f3Fx
 jMusqmKdHSyMIhxMBiKKbIs8JjlNKV9FtPWTzuvwcxhZQIZIixTmZlTmqdXUeqQmVeSmqOXnJ/L
 wMUpAFN14xfDX7mMp1qHT235dnh6OuvMTYHT7Z4Iqs3c8tj4aNf5KUZ3J01jZFi7YH30efNPoQr
 8jztCJ9/+s2VtjaOX4N3Mm/KvjriX63ICAA==
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

The TDX architecture identifies some features that are off by default.
They are classified as add-on features because enabling them affects
existing TDX systems: they may change existing feature behavior, or
reserve more memory.

However, the impact of the first add-on features will be low enough to
pursue a simple approach - the kernel just enables them when supported.
If a feature with a very high overhead appears in the future, this can
be revisited.

The TDX module extends TDH.SYS.CONFIG with a new register argument to
specify which add-on features to enable. This new argument is a bitmap
that uses the same feature bits as TDX_FEATURES0. Note that Dynamic PAMT
is an exception: although it is an add-on feature, it is controlled via
a legacy, dedicated register argument [1].

Pass the bitmap of features that are supported by both kernel & TDX
module to TDH.SYS.CONFIG. Initially, the bitmap is 0. It will be updated
to contain specific feature bits as full kernel support lands.

The TDX module requires leaf version 1 for TDH.SYS.CONFIG when passing
the new bitmap argument. Set the version field to 1 if the argument is
used to enable any add-on feature, otherwise keep the version as 0. This
retains backward compatibility with older modules that don't recognize
version 1.

The original changelog was written by hand. AI was used to help correct
grammatical errors and polish individual sentences for better
readability.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://lore.kernel.org/all/20260904215841.303070-10-rick.p.edgecombe@intel.com/ # [1]
---
v5:
 - Simplify the changelog, saved 5 lines
 - Better clarify the AI usage

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
index c7bd0b01786d..3bfe78b4b538 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1033,9 +1033,19 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 
 #define TDX_SYS_CONFIG_DYNAMIC_PAMT	BIT(16)
 
+/* List all kernel-supported add-on features0 bits here */
+#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
+
+static __init u64 get_tdx_usable_addon_features0(void)
+{
+	return tdx_sysinfo.features.tdx_features0 &
+		TDX_KERNEL_SUPPORTED_ADDON_FEATURES0;
+}
+
 static __init int tdx_sys_config(u64 *tdmr_pa_array, unsigned int nr_tdmr_pa,
 				 u64 global_keyid)
 {
+	u64 addon_features0 = get_tdx_usable_addon_features0();
 	struct tdx_module_args args = {
 		.rcx = __pa(tdmr_pa_array),
 		.rdx = nr_tdmr_pa,
@@ -1047,6 +1057,15 @@ static __init int tdx_sys_config(u64 *tdmr_pa_array, unsigned int nr_tdmr_pa,
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

