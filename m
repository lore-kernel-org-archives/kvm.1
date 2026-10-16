Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E64468C37;
	Fri, 16 Oct 2026 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141833; cv=none; b=b9DxUL2hr0Tq45a/xbI2+dvu8hAhU2Gwen3Qfk5MGYO9gnm+qNhCwYMu9t1WPYfZ6W7EVryTXZWaWDak4HFz4eSOG7T9IE8SgR1nzxOsU0PGMDEhaFrT2rDLFY4l6T5uqzjuUNrPIeATdy1wa3/WE5yiifGqryJ4/AJJg6KkMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141833; c=relaxed/simple;
	bh=axyD8OVAMk3Wtc0/earijSD6skFEO+Hk+l1bvj2fTeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdKrN8linUkWGeZeSVDBDXS2/+h0MoAFzoaYnQedhTPYCv3YuOjhZTqhF2y05mjdb6PlhPpq8aZkGEOggqRtp4hajW6J99uT7Ci4ROoQF9ky2AeImECuCUg1wE/zqMgPMpsqHE4+Ud+MaJOt5UdIkEQL+fQXQ8rhTNKM9uGjww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxj74d3J; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxj74d3J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792141831; x=1823677831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axyD8OVAMk3Wtc0/earijSD6skFEO+Hk+l1bvj2fTeM=;
  b=hxj74d3JT1oLf0CraeppVCNL1RnHRfKtDz6M91LejEfz90LmiB7gysFz
   +71DC4Vs+W/I4saUSMV/Y+/31wzBg5GKMSRvSUuPMI0oSmBhyjTt+79ym
   L39kbpRDao5rdSdBvN0l6PSYZQ7WxghDCCzFB51Fh3o7UQNqGRQ63JF/7
   ctPn/diJRlq5F8CJN7Jcg/baOBIN/j6jrh9o/Oy45oyAfmlKo6jck+yt0
   9aiFFgCpgiOoFDBFQlC8FagMHWoxtnr0BVFnQbeBj6HkswsYZ1rsIpqT+
   XP6x3abxf1/3/fJoGjRQoiwnGFw+goF9zJhw5ugDMlGb7vDsEjo6thOy2
   Q==;
X-CSE-ConnectionGUID: NoffNtIFSHi3/4cxke71+g==
X-CSE-MsgGUID: pwP9jd6xQGi7/PC1QPk2sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="927121"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="927121"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:30 -0700
X-CSE-ConnectionGUID: fWEqfsMEQmic9VR31IiGCQ==
X-CSE-MsgGUID: rCr8xMiJRXOjCS26/yvOfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1812554"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:28 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	tony.lindgren@linux.intel.com,
	kishen.maloor@intel.com,
	dedekind1@gmail.com,
	adrian.hunter@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v5 1/5] KVM: TDX: Check unsupported CPUID bits against the TDX module's subleaf
Date: Fri, 16 Oct 2026 17:14:18 +0800
Message-ID: <20261016091422.3182216-2-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for unsupported CPUID bits using the subleaf reported by the TDX
module instead of the index of the matching userspace entry, so that KVM
validates the same subleaf that the values are copied into.

setup_tdparams_cpuids() walks the directly configurable CPUID leaves
reported by the TDX module and looks up the corresponding userspace entry
via kvm_find_cpuid_entry2().  If userspace doesn't set
KVM_CPUID_FLAG_SIGNIFCANT_INDEX on an entry, kvm_find_cpuid_entry2()
ignores the entry's index, i.e. the matched entry's index can differ from
the TDX module's subleaf.  tdx_unsupported_cpuid() checks HLE, RTM and
WAITPKG based on the userspace entry's index, while the register values
are applied to the TDX module's subleaf, which allows userspace to bypass
the check.

E.g. if userspace provides a CPUID.0x7 entry with index 3, WAITPKG set,
and KVM_CPUID_FLAG_SIGNIFCANT_INDEX cleared, the entry is matched for the
TDX module's subleaf 0.  The check sees index 3 and passes, while ECX is
copied into td_params for CPUID.0x7.0, where WAITPKG is directly
configurable.  The TDX module accepts the value, and the TD ends up with
WAITPKG enumerated despite KVM not supporting it.  The same applies to RTM
and HLE.

Don't reject the mismatch outright, as the ABI allows userspace to provide
an arbitrary index when KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared.  It's
userspace's responsibility to provide the intended entries; KVM only needs
to ensure that the values it validates are the values it applies.

Fixes: 6d415778f106 ("KVM: TDX: Disable support for TSX and WAITPKG")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260604024927.E22311F00893@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v5:
- Split out from "KVM: TDX: Validate userspace CPUID input for
  KVM_TDX_INIT_VM" as a standalone fix.  Sashiko reported the issue
  against the TDX CPUID validation patch, but it also applies to the
  existing code, so split it out to allow backporting to stable
  independently of the rest of the series.
- Check the userspace values against the subleaf reported by the TDX
  module instead of rejecting the request when there is a mismatch.

  A simpler alternative would be to require a zero index when
  KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared, but that would be an ABI
  change.
---
 arch/x86/kvm/vmx/tdx.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ee1d412b0ee6..ae7135784878 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -119,9 +119,9 @@ static u32 tdx_set_guest_phys_addr_bits(const u32 eax, int addr_bits)
 
 #define TDX_FEATURE_TSX (__feature_bit(X86_FEATURE_HLE) | __feature_bit(X86_FEATURE_RTM))
 
-static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
+static bool has_tsx(const struct kvm_cpuid_entry2 *entry, u32 index)
 {
-	return entry->function == 7 && entry->index == 0 &&
+	return entry->function == 7 && index == 0 &&
 	       (entry->ebx & TDX_FEATURE_TSX);
 }
 
@@ -130,9 +130,9 @@ static void clear_tsx(struct kvm_cpuid_entry2 *entry)
 	entry->ebx &= ~TDX_FEATURE_TSX;
 }
 
-static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry)
+static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry, u32 index)
 {
-	return entry->function == 7 && entry->index == 0 &&
+	return entry->function == 7 && index == 0 &&
 	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
 }
 
@@ -143,16 +143,16 @@ static void clear_waitpkg(struct kvm_cpuid_entry2 *entry)
 
 static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
 {
-	if (has_tsx(entry))
+	if (has_tsx(entry, entry->index))
 		clear_tsx(entry);
 
-	if (has_waitpkg(entry))
+	if (has_waitpkg(entry, entry->index))
 		clear_waitpkg(entry);
 }
 
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
+static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry, u32 index)
 {
-	return has_tsx(entry) || has_waitpkg(entry);
+	return has_tsx(entry, index) || has_waitpkg(entry, index);
 }
 
 #define KVM_TDX_CPUID_NO_SUBLEAF	((__u32)-1)
@@ -2381,7 +2381,13 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 		if (!entry)
 			continue;
 
-		if (tdx_unsupported_cpuid(entry))
+		/*
+		 * Check the userspace values against the subleaf reported by
+		 * the TDX module, i.e. the subleaf the values are applied to,
+		 * not the index of the userspace entry, which may differ if
+		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX isn't set.
+		 */
+		if (tdx_unsupported_cpuid(entry, tmp.index))
 			return -EINVAL;
 
 		copy_cnt++;
-- 
2.46.0

