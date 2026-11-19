Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074490;
	b=InKgP4FB3yb72m2r+ks82+Mg5//W3mySKdxR7Q7a/w11NmGjTK2gBSNKFvm09tJx+tUb
	 Yz8p6KqRe4OQPY+zAmRnUdbQBNxyjAK3V/X8161Y180jVR80+GIyw/AshLQw8FHR4UsMM
	 KlZvyu81FBvHkvuw+WUzKSWaqhMD0ZDVOqyoIGsgE0oT6NWcJzEInvMnosE0FXQyTWVKa
	 Dr0I6eVh2jNNoz0MsbO7JRvy77OgFfKvakeLGqjqGWEMB+sWpxB2+o0oBOxjFwU44pVz/
	 qE25GS2VHQNLkS5CCt3FAMoS3052o230Ng+QybBkIFvWUUWlJ5O3D2tulGlvpMTKtGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074490;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p+W+nkV7IahZLhG90sl22pTY4rr0VDZilhazml71WH0=;
	b=kRPLVLtzk0vJWwmGl5mprbYLCrth/bTs2eO3VfgUUjyqcvLKeQGuDBWhb2Ut8appZh/x
	 4bTpsduWPBEYK2z8TUAzC3QRemGvqsQttPQS28gAxUh4+/q2Fq4+4gOeRw8Dur9tgxxRV
	 g/JDny8CTnOWv9xlXuOX9gpMIgwBxiOMiOZ4VOZaLN6j/sHN50bNtB92jMluZQDwB5FPJ
	 muvPNN1VWh9FpSDN80MQxFYt9zf0CrAILLSn/7uAEQ2Csraw4ARYKDBq+v6U4Fn1wU2e4
	 8qMpCH//NmG4eJUu7ljzKa/7Lve3P/v332ieO5KU+kJFd0mVQQnVQwoK3gRO0PysUTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WPSjzp48;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0860A2601;
	Thu, 19 Nov 2026 07:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A0860A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WPSjzp48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795074489; x=1826610489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ba6sfheeRgP/aP6WxF0hAJLgfESdlWbGDkAvNE2nhB4=;
  b=WPSjzp48S/KkK75FjTxrhIbULxojpCpvvq2vTjTs5F0kNoujuZ9lPNaV
   IeSb22kPj6xNkILPDW1qzte6LhRAwE9akkcrUJ7KZ8UU+vDnUrBb1CixI
   gXYZ5M7fyayYSu3focTkfzPzjoK2QaNR4y9xsldrvjglJ0SPQQzv+omUG
   QsvIZwfBT9+lOwlHlsjbzRZLiZH+nDSLVuzSUa9HEz9gaRAKgbxuuoG2X
   sxVu3KcvCiGfp1P3Vm+1Q4orQkP5G/ZfTgKUOHZoJYwb3eLoReDk+/Fs5
   hap9JNVTCZ0orAPDSMD60kB4jPNjpYPhcDMaWEZR3+Ahp2bMVSbtiVyEj
   A==;
X-CSE-ConnectionGUID: zfvT7W+oQuGB4uxCGKsE4A==
X-CSE-MsgGUID: 7xBdTs5zSfCrhxGDp/nNQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3941755"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3941755"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:48:08 -0800
X-CSE-ConnectionGUID: 543kSmQdSDuoqi9M2Wbxgw==
X-CSE-MsgGUID: YIF/MEsfRVKudmY8NOd+aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10725817"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:48:09 -0800
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@intel.com,
	arjan.van.de.ven@intel.com,
	binbin.wu@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v3 2/2] x86/virt/seamldr: Support multiple sigstruct pages
Date: Wed, 18 Nov 2026 23:49:22 -0800
Message-ID: <20261119074925.3933804-3-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119074925.3933804-1-chao.gao@intel.com>
References: <20261119074925.3933804-1-chao.gao@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX module sigstructs are limited to 4KB. Each update image carries a
sigstruct, which is handed to P-SEAMLDR in 'struct seamldr_params'
along with the module binary. The structure has room for the physical
address of only one sigstruct page.

TDX modules are moving to a post-quantum signature algorithm. Its
signatures are far larger than the ones in use today, so the sigstruct
no longer fits in 4KB.

The P-SEAMLDR ABI was extended to take up to four sigstruct pages
(16KB). Setting 'version' to 1 tells P-SEAMLDR to use this layout.

Grow sigstruct_pages_pa_list[] to four entries to match. In anticipation
of this change, the list is already filled in a loop, so filling the
new entries needs no new code.

Use version 1 only when the sigstruct spans more than one page. Old
P-SEAMLDRs reject version 1, so this keeps today's modules working on
them.

Do not query P-SEAMLDR for version 1 support. Userspace selects the
update image and is responsible for ensuring the module is compatible
with P-SEAMLDR.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
v3:
 - Explain why sigstruct filling code is a loop already [Rick]
 - Drop the boilerplate AI usage note [Dave]

v2:
 - drop macros for versions to keep the diff minimal
 - explain why the sigstruct filling code needs no change
---
 arch/x86/virt/vmx/tdx/seamldr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 6b9657a28129..7c09c84df1aa 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -38,7 +38,7 @@
  */
 #define SEAMLDR_NR_MODULE_PA_ENTRIES	((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE - 128) / sizeof(u64))
 #define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)
-#define SEAMLDR_MAX_NR_SIG_PAGES	1
+#define SEAMLDR_MAX_NR_SIG_PAGES	4
 
 /*
  * The seamldr_params "scenario" field specifies the operation mode:
@@ -59,7 +59,7 @@ struct seamldr_params {
 	u32	version;
 	u32	scenario;
 	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
-	u8	reserved[104];
+	u8	reserved[80];
 	u64	module_nr_pages;
 	u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
 } __packed;
@@ -173,6 +173,13 @@ static void populate_seamldr_params(struct seamldr_params *params,
 				    const u8 *mod, u32 mod_nr_pages)
 {
 	params->version		= 0;
+	/*
+	 * Use version 1 only for multi-page sigstructs, to stay
+	 * compatible with old P-SEAMLDRs that lack version 1 support.
+	 */
+	if (sig_nr_pages > 1)
+		params->version	= 1;
+
 	params->scenario	= SEAMLDR_SCENARIO_UPDATE;
 	params->module_nr_pages	= mod_nr_pages;
 
-- 
2.52.0

