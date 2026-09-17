Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463847CC96;
	Thu, 17 Sep 2026 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629721; cv=none; b=PeKLKMkdeYXwUy/VwC2vTc5OesJmpevdxZkOUxA69ZyZI7lBSYZgpI7nTidlHxJONHTMYvypY4jsfbngvA8Jgc92MMaAL2s3D4kUSFZwAftsWLdUq4nmTpzNsHXnepyzLeu38zagPAdB5nbKBc/AxPWN8tKUkO2r5QT7fUJs2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629721; c=relaxed/simple;
	bh=RFo0GcFB8WvcT8YgsNJNcG8vvW7Ir69VueovFbcFSI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVDVpfZUe2DsYJ6KFBlsoXTPvoJ7yOQIeAN5M20qh4qGv1mwC0j2JKQQ9SeE6hbmYLD+ztfDe2EXL1Cg/rrcPXquuHYgpggpWGwo8CSth4Opx84V0T2XflgfRNQoS21NuWhSu/6htT+hwV6xw3aNYsmvKEN1B8nVO1Zug0nqY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YC/ATe5u; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YC/ATe5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789629714; x=1821165714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RFo0GcFB8WvcT8YgsNJNcG8vvW7Ir69VueovFbcFSI4=;
  b=YC/ATe5uqW5mn029bDTpCkMW+ssVUSP3HcQsFg2pj30AU34FGM3+HG4P
   wBziJLOm/e+EYQO3FT5x8wQtCm3drZ1YHz6mDln6HLWbyiQbrKHTFGel3
   EXOFvxQ0z7rz+QYqVEB9Cy92si4CYYnM4gSs74cCB8fG5CgLUBKlelicB
   M4uQSGfvRXFoCfbfC+r+iPqEB+Bitln2eU1feSXTbBWKgxlAHqS41q73k
   4LRYfdGjU4fTGzFHoNBPdHaQfZutZGul4Nb9cIW7x2N8da86+PP0cCCZt
   mEhnskB3YXNteKdY2Xyl+OcExSExCpUG4tjd97W/DG+73/cMwHubj1shO
   w==;
X-CSE-ConnectionGUID: jx44EVZmRiWVTwQEVusZwA==
X-CSE-MsgGUID: B3SKfBBaRv2H2X++iMdc1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="531866"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="531866"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:37 -0700
X-CSE-ConnectionGUID: xyBy01OFQV+qnAfd3Gw78w==
X-CSE-MsgGUID: ZMkc8r9tS5uRlyEGO8j9Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1849403"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:35 -0700
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
	binbin.wu@linux.intel.com
Subject: [PATCH v4 3/4] KVM: TDX: Filter configurable CPUID bits
Date: Thu, 17 Sep 2026 15:25:47 +0800
Message-ID: <20260917072548.2314491-4-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filter the directly configurable CPUID bits reported through
KVM_TDX_CAPABILITIES against KVM's TDX allowlist, and drop the hardcoded
denylist based filtering.

The TDX module reports directly configurable CPUID bits that it supports
for a TD, but KVM must not expose bits that it doesn't support, as blindly
exposing a host state clobbering feature can lead to host state corruption.
The existing denylist, which clears only TSX and WAITPKG, is not fail-safe.

Add tdx_get_cpuid_cfg_mask() to get the mask of directly configurable bits
allowed by KVM for a given CPUID register, covering both feature bits,
which come from tdx_cpu_cfg_caps[], and non-feature bits, which are
enumerated at runtime.  Apply the mask to every CPUID entry reported
through KVM_TDX_CAPABILITIES.

With the allowlist in place, newly introduced TDX directly configurable
CPUID bits stay hidden from userspace until KVM explicitly opts in.

Note, filtering KVM_TDX_CAPABILITIES intentionally stops advertising the
directly configurable bits that aren't in the allowlist, as the
corresponding features are unsupported or cannot be properly virtualized.

Update the documentation to reflect the ABI change.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v4:
- Rename functions. (Tony)
  tdx_cfg_non_feature_mask()       -> tdx_get_cpuid_cfg_non_feature_mask()
  tdx_cfg_feature_mask()           -> tdx_get_cpuid_cfg_feature_mask()
  tdx_get_allowed_cfg_cpuid_mask() -> tdx_get_cpuid_cfg_mask()
- Update documentation. (Xiaoyao, Rick)

v3:
- Handle non-feature leafs at runtime. (Sean)
- Add CPUID.0x24.0.EBX[7:0] into allowlist. There is a mismatch of the
  description about CPUID.0x24.0.EBX[7:0], which is listed as
  "XFAM & CPUID_Enabled & Native" but should be "XFAM & CPUID_Enabled &
  Configured & Native".
---
 Documentation/virt/kvm/x86/intel-tdx.rst |  8 ++
 arch/x86/kvm/vmx/tdx.c                   | 95 ++++++++++++++++++------
 2 files changed, 80 insertions(+), 23 deletions(-)

diff --git a/Documentation/virt/kvm/x86/intel-tdx.rst b/Documentation/virt/kvm/x86/intel-tdx.rst
index 6a222e9d09541..6beeb89d7f057 100644
--- a/Documentation/virt/kvm/x86/intel-tdx.rst
+++ b/Documentation/virt/kvm/x86/intel-tdx.rst
@@ -69,6 +69,14 @@ Return the TDX capabilities that current KVM supports with the specific TDX
 module loaded in the system.  It reports what features/capabilities are allowed
 to be configured to the TDX guest.
 
+Note, a CPUID feature bit that the TDX module reports as directly configurable
+is not necessarily reported as configurable by KVM.  KVM omits features it
+doesn't support.  Generally speaking, KVM reports a feature as configurable
+only if KVM supports the feature for both TDX and non-TDX VMs, though there are
+a handful of exceptions where KVM allows a feature for TDX guests that it never
+advertises for non-TDX VMs.  Userspace must rely on KVM_TDX_CAPABILITIES to
+determine what can be passed in cpuid to KVM_TDX_INIT_VM.
+
 - id: KVM_TDX_CAPABILITIES
 - flags: must be 0
 - data: pointer to struct kvm_tdx_capabilities
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b34afc52b714e..ad7d70b36ffe5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -294,36 +294,79 @@ static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
 	       (entry->ebx & TDX_FEATURE_TSX);
 }
 
-static void clear_tsx(struct kvm_cpuid_entry2 *entry)
-{
-	entry->ebx &= ~TDX_FEATURE_TSX;
-}
-
 static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry)
 {
 	return entry->function == 7 && entry->index == 0 &&
 	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
 }
 
-static void clear_waitpkg(struct kvm_cpuid_entry2 *entry)
-{
-	entry->ecx &= ~__feature_bit(X86_FEATURE_WAITPKG);
-}
-
-static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
-{
-	if (has_tsx(entry))
-		clear_tsx(entry);
-
-	if (has_waitpkg(entry))
-		clear_waitpkg(entry);
-}
-
 static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
 {
 	return has_tsx(entry) || has_waitpkg(entry);
 }
 
+#define TDX_CPUID_ALL_ALLOWED_MASK	GENMASK_U32(31, 0)
+
+static u32 tdx_get_cpuid_cfg_non_feature_mask(u32 function, u32 index, int reg)
+{
+	/*
+	 * For a leaf/subleaf/register that will never be repurposed to hold
+	 * feature bits, it's safe to return TDX_CPUID_ALL_ALLOWED_MASK, i.e.
+	 * leave the TDX module's CPUID config mask intact.
+	 */
+	switch (function) {
+	case 1:
+		if (reg == CPUID_EAX || reg == CPUID_EBX)
+			return TDX_CPUID_ALL_ALLOWED_MASK;
+		return 0;
+	case 4:
+	case 0x18:
+	case 0x1f:
+		return TDX_CPUID_ALL_ALLOWED_MASK;
+	case 0x24:
+		if (index == 0 && reg == CPUID_EBX)
+			return GENMASK_U32(7, 0);
+		return 0;
+	case 0x80000008:
+		if (reg == CPUID_EAX)
+			return TDX_CPUID_ALL_ALLOWED_MASK;
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static u32 tdx_get_cpuid_cfg_feature_mask(u32 function, u32 index, int reg)
+{
+	for (int i = 0; i < NR_KVM_CPU_CAPS; i++) {
+		const struct cpuid_reg *cpuid = &reverse_cpuid[i];
+
+		if (!cpuid->function)
+			continue;
+
+		if (cpuid->function == function && cpuid->index == index &&
+		    cpuid->reg == reg)
+			return tdx_cpu_cfg_caps[i];
+	}
+
+	return 0;
+}
+
+static u32 tdx_get_cpuid_cfg_mask(u32 function, u32 index, int reg)
+{
+	u32 non_feature_mask = tdx_get_cpuid_cfg_non_feature_mask(function, index, reg);
+
+	/* Skip reverse_cpuid[] walk if it's already all allowed. */
+	if (non_feature_mask == TDX_CPUID_ALL_ALLOWED_MASK)
+		return TDX_CPUID_ALL_ALLOWED_MASK;
+
+	/*
+	 * It's possible that a CPUID register contains both feature and
+	 * non-feature bits.
+	 */
+	return non_feature_mask | tdx_get_cpuid_cfg_feature_mask(function, index, reg);
+}
+
 #define KVM_TDX_CPUID_NO_SUBLEAF	((__u32)-1)
 
 static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char idx)
@@ -347,8 +390,6 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
 	 */
 	if (entry->function == 0x80000008)
 		entry->eax = tdx_set_guest_phys_addr_bits(entry->eax, 0xff);
-
-	tdx_clear_unsupported_cpuid(entry);
 }
 
 #define TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT	BIT(1)
@@ -371,8 +412,16 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
 	caps->user_tdvmcallinfo_1_r11 =
 		TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT;
 
-	for (i = 0; i < td_conf->num_cpuid_config; i++)
-		td_init_cpuid_entry2(&caps->cpuid.entries[i], i);
+	for (i = 0; i < td_conf->num_cpuid_config; i++) {
+		struct kvm_cpuid_entry2 *e = &caps->cpuid.entries[i];
+
+		td_init_cpuid_entry2(e, i);
+		/* Only report the configurable bits allowed by KVM. */
+		e->eax &= tdx_get_cpuid_cfg_mask(e->function, e->index, CPUID_EAX);
+		e->ebx &= tdx_get_cpuid_cfg_mask(e->function, e->index, CPUID_EBX);
+		e->ecx &= tdx_get_cpuid_cfg_mask(e->function, e->index, CPUID_ECX);
+		e->edx &= tdx_get_cpuid_cfg_mask(e->function, e->index, CPUID_EDX);
+	}
 
 	return 0;
 }
-- 
2.46.0

