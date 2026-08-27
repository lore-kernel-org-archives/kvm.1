Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBA388E6B;
	Thu, 27 Aug 2026 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800448; cv=none; b=E9x+KY/TerjNc5AzkifLaw24V/sFjCOQCfGzw8ofAZyX0zHH8avXct2G6E13bEGUCkUl31h6m7ohkz1eIYK2v7fDu0U8iOOF5Z7h33M3AG2t/V1dzr1jLGL0gvbqrBROJJgtQHhiEjyPj/t5co4FfStbI4MA+Iv8i4ru9cSyRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800448; c=relaxed/simple;
	bh=QOR5BllIEIxYwF69J+nzg+NHNYPor5+EuELD4Kql4dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9g4bWSyDR7ldHBI9RlgpC5JtOjoPCTCGl1Botdnx62UO3H6SqDNN+m6gdZqJXdTLomHisH8Hqo/EwYY0mHdHwaf5G5GrbkonPsYr9Ga2E+5AWfo7fQpaAX5J7SoJCpsx/Sn6jJDvtRUA6RFezXu6MjvnvoEQnJUBXVM7qJM3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip1Txlix; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip1Txlix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787800447; x=1819336447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOR5BllIEIxYwF69J+nzg+NHNYPor5+EuELD4Kql4dI=;
  b=ip1TxlixT05lPdgc7SGPlk1hcNyZYNNrNg1GQtjd8RvwYVu0kSxuWO3b
   K54fgEXp9LWo3naEQo515sJHL7D9LyROF7WdMcU83BUf1h6kAqdl5jWhr
   XDbqXh96wbvd7Kw19JzpG0lNcd+piXBtBNdpGvoEkhKtA0RWEGHCYau2C
   rblI2YDBKncdFDtyoKax+OBEmq+YA6LElWKchDRJlnqn2gxFmxigiUqBt
   XDbfJGPVsxsuMnLfdp26YO+CDoSbtB2ilopvuCIuH8Ri/3l+SP+ZDJ3jk
   RyJQeYfaTkWDU1lalezJS4BlxLTXvihuMxKiWwupjnO+ynnL+M5lje1O9
   Q==;
X-CSE-ConnectionGUID: 3oMH0IAiRnKaYy+RxN48SQ==
X-CSE-MsgGUID: L+ahKcQlR1aMcRqERznzYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98964564"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="98964564"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:14:07 -0700
X-CSE-ConnectionGUID: 4EEIuD7ZRh6PwztRZ2YW8w==
X-CSE-MsgGUID: iiBgwFayQDS/D1laAu0m6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="271264125"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:14:04 -0700
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
	binbin.wu@linux.intel.com
Subject: [PATCH v3 4/4] KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
Date: Thu, 27 Aug 2026 11:18:37 +0800
Message-ID: <20260827031837.2863609-5-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate the CPUID configuration provided by userspace through
KVM_TDX_INIT_VM against KVM's TDX allowlist, and drop the hardcoded
denylist based check.

The TDX module lets the VMM configure certain CPUID features for a TD at
initialization time, but KVM must strictly govern which of them userspace
can actually enable, otherwise a host state clobbering feature could be
enabled behind KVM's back.  The existing check only rejects TSX and
WAITPKG, i.e. it is not fail-safe, as any bit that a future TDX module
makes configurable would be accepted even if KVM has no idea about the
feature.

Add tdx_has_unsupported_cfg_cpuid_bit() and reject KVM_TDX_INIT_VM if
userspace sets any bit outside the mask returned by
tdx_get_allowed_cfg_cpuid_mask().  There is no need to first mask the
userspace input with the bits the TDX module reports as directly
configurable, as anything outside that set is rejected by the TDX module
itself.

Also reject CPUID entries whose index differs from the value expected by
the TDX module, as kvm_find_cpuid_entry2() ignores the index when
KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared, and so a mismatching entry
could otherwise be applied to the wrong subleaf.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v3:
- Check CPUID entry index mismatch b/t userspace input and TDX sysinfo
  configuration. (Sashiko)
- No need to mask the userspace input with TDX module reported directly
  configurable bits first, since the userspace input should be subset of
  directly configurable bits. Otherwise, the input will be rejected by
  the TDX module.
---
 arch/x86/kvm/vmx/tdx.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index e8951353de73..12dea8775fd4 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -269,25 +269,6 @@ static u32 tdx_set_guest_phys_addr_bits(const u32 eax, int addr_bits)
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
-static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry)
-{
-	return entry->function == 7 && entry->index == 0 &&
-	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
-}
-
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
-{
-	return has_tsx(entry) || has_waitpkg(entry);
-}
-
 #define TDX_CPUID_ALL_ALLOWED_MASK	GENMASK_U32(31, 0)
 
 static u32 tdx_cfg_non_feature_mask(u32 function, u32 index, int reg)
@@ -2533,6 +2514,17 @@ static int setup_tdparams_eptp_controls(struct kvm_cpuid2 *cpuid,
 	return 0;
 }
 
+static bool tdx_has_unsupported_cfg_cpuid_bit(const struct kvm_cpuid_entry2 *entry)
+{
+	u32 function = entry->function;
+	u32 index = entry->index;
+
+	return (entry->eax & ~tdx_get_allowed_cfg_cpuid_mask(function, index, CPUID_EAX)) ||
+	       (entry->ebx & ~tdx_get_allowed_cfg_cpuid_mask(function, index, CPUID_EBX)) ||
+	       (entry->ecx & ~tdx_get_allowed_cfg_cpuid_mask(function, index, CPUID_ECX)) ||
+	       (entry->edx & ~tdx_get_allowed_cfg_cpuid_mask(function, index, CPUID_EDX));
+}
+
 static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 				 struct td_params *td_params)
 {
@@ -2556,7 +2548,16 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 		if (!entry)
 			continue;
 
-		if (tdx_unsupported_cpuid(entry))
+		/*
+		 * Reject entries whose index does not match the expected one.
+		 * This catches userspace passing a CPUID entry with the
+		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag cleared when the index
+		 * is significant.
+		 */
+		if (entry->index != tmp.index)
+			return -EINVAL;
+
+		if (tdx_has_unsupported_cfg_cpuid_bit(entry))
 			return -EINVAL;
 
 		copy_cnt++;
-- 
2.46.0

