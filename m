Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67232B132
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787715336; cv=none; b=XeJWD0flIgtfOj+VzGWAkRu6MhVtiyOTPUV65iO8UQ4yyWoRRvSU6lVzLpT9aSZqpwss+JUYgBMnZxk1sln0xslaTct/53DFVqBqBt7r7hxg5m//1s2MCSQkgAzjSmpjqftrK8E3EWb3zmCta/HWq6YidynqRHo3kfX6XQICWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787715336; c=relaxed/simple;
	bh=r8OGA1E4Kgzq5lM4GWV1Y2V9ktJQGlzkwRiX5qY63q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O46Ibu6OkNRxZQSncH4mN3jCj7lkV0g4qi/ouR6Jmu1sAHzanY8pTk2kLDwaM8os0N1KXERWbxTjIAnctI8sgB0Lk6Yt1amwxf2qchJjVujOhfNYggdRlvuU319BSQV+iLu15rqpOKOWKyI615upcqSWTIh/OCARLUOgogXnPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kly3dFZ8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kly3dFZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787715334; x=1819251334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8OGA1E4Kgzq5lM4GWV1Y2V9ktJQGlzkwRiX5qY63q4=;
  b=Kly3dFZ8SJChd6wafdrdRjkzvpZ62nTlyEK5n7CJQj0rqFJOT2BjVa5m
   SlfnHLWeG2VZhXXt8BgDIgJZplFhZAd6ycZWLSw/w4pwH4mH2dh07ibIE
   fFEtUMJH3E0GXn/DzUU4y/pf/ivpzaHy7FPmo4iuIpbUc71u17V92cEZ4
   mQyfj/TKM7mUzhHQitHMqkOZVAolBZaB5FO1Bh9OeFM+pN8QLTdAojBCw
   TVemZHLlJ5xypt87DbBigU+lVadSvkknRY1RtfmTlyAhrab+6x5ZdGGVw
   nPbj/ucVkRZqxybgSj1rinzJ+wjFCb/k27naqVzelwIt6HgCPYhv+XQgW
   w==;
X-CSE-ConnectionGUID: aWtQKI/URYa1f+YId9scMA==
X-CSE-MsgGUID: VJlam1KXT2qIablhvVeuEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728376"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="75728376"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: VecMJVsPRamcTwE1P4SDxA==
X-CSE-MsgGUID: abejyrZwQ+WzXLKojnlnMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="297364014"
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
Subject: [PATCH 2/5] target/i386: Add LASS support in CR4
Date: Tue, 25 Aug 2026 20:57:31 -0700
Message-ID: <20260826035734.114685-3-kishen.maloor@intel.com>
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

CR4.LASS[bit 27] enables Linear Address Space Separation, and may be set
only when CPUID.(EAX=7,ECX=1):EAX[6] enumerates LASS.

Recognize CR4.LASS as a valid bit by adding CR4_LASS_MASK to the known
bits, i.e. clearing it from CR4_RESERVED_MASK. Mark it reserved in
cr4_reserved_bits() and clear it in cpu_x86_update_cr4() when the guest
CPUID does not enumerate LASS. This keeps CR4 handling consistent on
paths that reach cpu_x86_update_cr4(), such as gdbstub register writes.

LASS is not emulated by TCG, so it is not added to TCG_7_1_EAX_FEATURES
and cannot be set under TCG (helper_write_crN() and helper_vmrun() both
reject reserved bits via cr4_reserved_bits()).

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
[kishen: rewrote commit message, rebased, fixed formatting]
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 target/i386/cpu.h    | 7 ++++++-
 target/i386/helper.c | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d..98c406db32 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -277,6 +277,7 @@ typedef enum X86Seg {
 #define CR4_PKE_MASK   (1U << 22)
 #define CR4_CET_MASK   (1U << 23)
 #define CR4_PKS_MASK   (1U << 24)
+#define CR4_LASS_MASK  (1U << 27)
 #define CR4_LAM_SUP_MASK (1U << 28)
 
 #ifdef TARGET_X86_64
@@ -293,7 +294,8 @@ typedef enum X86Seg {
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
                 | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_CET_MASK \
-                | CR4_PKS_MASK | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
+                | CR4_PKS_MASK | CR4_LASS_MASK | CR4_LAM_SUP_MASK \
+                | CR4_FRED_MASK))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -3064,6 +3066,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
         reserved_bits |= CR4_PKS_MASK;
     }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LASS)) {
+        reserved_bits |= CR4_LASS_MASK;
+    }
     if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
         reserved_bits |= CR4_LAM_SUP_MASK;
     }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 6836214162..43cfcfdafe 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -229,6 +229,10 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
         new_cr4 &= ~CR4_PKS_MASK;
     }
 
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LASS)) {
+        new_cr4 &= ~CR4_LASS_MASK;
+    }
+
     if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
         new_cr4 &= ~CR4_LAM_SUP_MASK;
     }
-- 
2.47.1

