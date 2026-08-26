Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CE032B10B
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787715336; cv=none; b=GStrmgmNnUIsL9z2UzXAi7az6nshjCZfH3A7KOSJ0JCW6LBi5LpV4r88B4NcYFmuVA69gYMONzE30VCXJzpFpF5BkFEW2rEYbxwIcSrek2lMfrsv4AXhSRUjdzGgovfIEjivji/RYNdVM+h3daXOTypLPuWNZPLVD7edlw4XaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787715336; c=relaxed/simple;
	bh=mKgfwYnh3Nxsc7j3MuW13LeqbxyzE/A3vdhb9NnzUFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3O+Pa7YW3yfzlxWBuO1PrmntyU7jVpuhfn/VBj8Hf8zeun90vcRWa34ww40qHGyLbsobiwf25IoAvsbOIAMUq98RKDWFecpzSBNVGXKIgHKXpkc+JzQPgAM62+OAIDwRTYigMKYy78WYG9Jg2dfmqg7sOwQ//u2yaJvoOD+yXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPPaMQj7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPPaMQj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787715334; x=1819251334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mKgfwYnh3Nxsc7j3MuW13LeqbxyzE/A3vdhb9NnzUFI=;
  b=aPPaMQj72oF1XB253SQn+UhoHZPHw+RI9DTiViK/Q3i2m/XX0C96dPdv
   0l+0bicnr3sxl6Djgki0tTMMDp/yaPVFqHOzgN1Vcmi/RndENS2tF9Xqm
   /liVHZEKzSps1Uv5GP18emE26iL7+RfmOvJ6SuuFZ0x1nSxtS4fGB/GbA
   FQmsMpND9ZYDwOl6X3kK50ybDLHAhoDSdM+y2DgecA8rWnIUiCww78cxz
   pHhARMv/1s7MH6baEIrE53CBDMw5m5/Z7zyJnfwkriQ5Ow/2Eg9GIAzZm
   Kaftav6D++PtqLO6pABejXsmCWjT1nuy1sqIzzdccrRFRFMGWiMcm5yGN
   w==;
X-CSE-ConnectionGUID: MTewbT/PTg+/Sw2mrovZew==
X-CSE-MsgGUID: vlcYrY4WTxu68ypZzUeS1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728373"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="75728373"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: Zouley78REiWurQpir744w==
X-CSE-MsgGUID: +b4IBeoWQXm0LteFefmUYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="297364011"
Received: from d404e69c8b80.jf.intel.com ([10.54.34.91])
  by orviesa002.jf.intel.com with ESMTP; 25 Aug 2026 20:35:31 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	zhao1.liu@intel.com,
	kvm@vger.kernel.org,
	sohil.mehta@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	farrah.chen@intel.com,
	kishen.maloor@intel.com
Subject: [PATCH 1/5] target/i386: Add support for LASS in CPUID enumeration
Date: Tue, 25 Aug 2026 20:57:30 -0700
Message-ID: <20260826035734.114685-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260826035734.114685-1-kishen.maloor@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Isaku Yamahata <isaku.yamahata@intel.com>

Linear Address Space Separation (LASS) is a security feature that
prevents a class of side-channel attacks relying on speculative
accesses across the user/kernel boundary. Paging, along with SMEP
and SMAP, already provides mode-based access protection, but
enforcing it requires a page walk whose timing can leak the
layout of kernel memory.

LASS applies the equivalent protections during linear-address
pre-processing, before any page walk. Given the usual partitioning of
the linear address space into a user half (bit 63 clear) and a
supervisor half (bit 63 set), an access targeting the opposite half is
rejected on the basis of bit 63 alone, raising a #GP. LASS is enabled
via CR4.LASS[bit 27] and applies only in IA-32e mode.

Feature bit:
  CPUID.(EAX=7,ECX=1):EAX[6]

A CPUID_7_1_EAX_LASS macro was previously added in commit 31df29c532a9
("i386/tdx: Add supported CPUID bits related to TD Attributes"), but the
bit was left unnamed in feature_word_info[FEAT_7_1_EAX]. Add the "lass"
feature name to expose it via -cpu host, -cpu max, or an explicit +lass.

Exposing LASS to a guest also requires KVM support: KVM must validate
the CPUID bit and CR4.LASS, and enforce LASS violations in its
instruction emulator.

LASS is not implemented in TCG, so the bit is not added to
TCG_7_1_EAX_FEATURES.

More details can be found in the Intel 64 and IA-32 Architectures
Software Developer's Manual, Volume 3A, Section 4.3,
"Linear-Address-Space Separation (LASS)".

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
[kishen: rewrote commit message, rebased]
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
KVM support for LASS is currently under review:
https://lore.kernel.org/kvm/20260806011536.4172258-1-sohil.mehta@intel.com/

 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab9..5496e9475b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1243,7 +1243,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "sha512", "sm3", "sm4", NULL,
-            "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
+            "avx-vnni", "avx512-bf16", "lass", "cmpccxadd",
             NULL, NULL, "fzrm", "fsrs",
             "fsrc", NULL, NULL, NULL,
             NULL, "fred", "lkgs", "wrmsrns",
-- 
2.47.1

