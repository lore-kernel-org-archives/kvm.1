Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A436377035
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411182; cv=none; b=WTk2Fmyzv+iIqYmszHnsLlfBLZXMnBxnjppqFKZtTbZWwq8hOxbynQpKvvNGomMWyQr8VAocYY99JSGbROvcq65pYb8r8r4rk98DnBgHjKh7s8/tRT/SS7RueYp2n7d2HMq7Qad87axzvS4cQArHOMwPQAuJFfjPJQCEUxZmcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411182; c=relaxed/simple;
	bh=cSgSUz3cuAT7UNhfIbeGujSqw+AjOOcXMzgCAZGW+O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exGgzJvfNujZgfSXd4gNkm9AiGd2ZQrVHMelRRASW4sEBwFs3qTvMHmGl6KJ0xUWppXqSPcYSk1diH9WpN9yUEYm3W7eI1YQgU5JTQi7wmKa7tqx4kmQcL+urJ1M01m3U3dhetPGBT/q49yJN7MnuXIFhl9xShr7oP8JZ0y2+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k36W/Egl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k36W/Egl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411182; x=1807947182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSgSUz3cuAT7UNhfIbeGujSqw+AjOOcXMzgCAZGW+O0=;
  b=k36W/EglqDBorfvF9Vq8d5Mb2Bcu0+68+kOZqhagBx38YYnFj6jfsbOs
   e2MsB5Bbckl4vNJ+xifNYlD+e/BlmVB/nkQIqklzvmj+g2vJ9vL7vRWrx
   0nc5Z/yy0OZEyNepT8nU1JJMBFW7NvFhERwXJJpqRzIezm+nuTFt/HVfN
   P/Oe0NaHGaBf+CAmtyvC2CscCoV0elcisR6INHXsCDLX70GTmSwoZlBIO
   rIvCb3iQzMRhU/Fe8zlAIgCELmDZM103AAVAFQGb/URXQDCDx7xAqxGmw
   9kUXdYbLVyyUTtfjo+OXPG92KuA+JSz27t9ZM0VH/DTvNXjfCfjbmAQMn
   g==;
X-CSE-ConnectionGUID: SNhHbi84RU6KP3ApQsDMHw==
X-CSE-MsgGUID: r0Vch1fbR+KfbCMeVBErFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070330"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070330"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:33:02 -0700
X-CSE-ConnectionGUID: UfO4M+zcSqKIFiF7Cksm2A==
X-CSE-MsgGUID: GmdbJKmjTbSiu+taaYquZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285112"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:59 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 27/27] KVM: TDX: Replace hardcoded CPUID filtering with the allowed mask
Date: Fri, 17 Apr 2026 15:36:10 +0800
Message-ID: <20260417073610.3246316-28-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace TDX's ad-hoc CPUID filtering of TSX (HLE/RTM) and WAITPKG with
the generic kvm_cpuid_get_allowed_mask() helper, which returns the
allowed bitmask from the TDX CPUID overlay for any leaf/subleaf/register.

This makes the TDX CPUID filtering automatically cover all features
governed by the overlay infrastructure, eliminating the need to add new
per-feature helpers as more features are restricted for TDX.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index a996e7f761ed..2b980335b667 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -120,42 +120,26 @@ static u32 tdx_set_guest_phys_addr_bits(const u32 eax, int addr_bits)
 	return (eax & ~GENMASK(23, 16)) | (addr_bits & 0xff) << 16;
 }
 
-#define TDX_FEATURE_TSX (__feature_bit(X86_FEATURE_HLE) | __feature_bit(X86_FEATURE_RTM))
-
-static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
-{
-	return entry->function == 7 && entry->index == 0 &&
-	       (entry->ebx & TDX_FEATURE_TSX);
-}
-
-static void clear_tsx(struct kvm_cpuid_entry2 *entry)
-{
-	entry->ebx &= ~TDX_FEATURE_TSX;
-}
-
-static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry)
-{
-	return entry->function == 7 && entry->index == 0 &&
-	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
-}
-
-static void clear_waitpkg(struct kvm_cpuid_entry2 *entry)
-{
-	entry->ecx &= ~__feature_bit(X86_FEATURE_WAITPKG);
-}
-
 static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
 {
-	if (has_tsx(entry))
-		clear_tsx(entry);
+	u32 *reg = &entry->eax;
 
-	if (has_waitpkg(entry))
-		clear_waitpkg(entry);
+	for (int i = CPUID_EAX; i <= CPUID_EDX; i++)
+		reg[i] &= kvm_cpuid_get_allowed_mask(entry->function, entry->index,
+						     i, CPUID_OL_TDX);
 }
 
 static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
 {
-	return has_tsx(entry) || has_waitpkg(entry);
+	const u32 *reg = &entry->eax;
+
+	for (int i = CPUID_EAX; i <= CPUID_EDX; i++) {
+		if (reg[i] & ~kvm_cpuid_get_allowed_mask(entry->function, entry->index,
+							 i, CPUID_OL_TDX))
+			return true;
+	}
+
+	return false;
 }
 
 #define KVM_TDX_CPUID_NO_SUBLEAF	((__u32)-1)
-- 
2.46.0

