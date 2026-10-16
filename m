Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351646D08B;
	Fri, 16 Oct 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141845; cv=none; b=eG+DzCwUHryjHuip8oefOafe0kpQQQ1VLO5b9jW91O+yWBfg4EA/ktLYW0bLa2qfp6PGNYN4acU6t4S7/MRzOxXrQlvJz+3EyJZDi9XWISy96E0x9bw4bZ1+PmZT9CsjWuWNC1r9tM7THcRnAaWVqde0zDg6B8yvE0uTpTHoH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141845; c=relaxed/simple;
	bh=UwtedskteHEfwPpomQVJHlmFRoP613RxPRet4OITYZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtcomvQVlVjIGzznhq7EA9sqhyoRNfVPN07553cuO1U31NuJ5k7TylAeGR/irlQuEcJ1oQWr4HEgvbnL5NezbZb6gWAuHzMPMZAWx0+8ibEbqF08e2B0H1Qs7F6xHzZK4CucmleYstwgboDEp4s9+qwPfD8VnvPAX/3N1SOMbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvZ5N8n/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvZ5N8n/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792141841; x=1823677841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwtedskteHEfwPpomQVJHlmFRoP613RxPRet4OITYZg=;
  b=hvZ5N8n/rGg9BwNb/gqV37C7AO46Di+4UlM5SMRjFJmA+O9AaDrEwBqM
   GmJkWGFIQXEu4rmgJkUg19IgU48+nV+xCp/7P/NYCbqe92dplZJS/jfUT
   q7QADJ1AClD/75/I0ZtdO+m9omCzqGcDL3u3Sj3eQkbKcWHMvf7N58TuR
   M3FSCiMQnm0GaC9Mb4EgwWL899qfQVCTQgVLP4GpHzH4DuQ4Wxvr8homh
   TiYc5t1FUzry9iO3nV5whYCyc0ViCaxxhVG2q8S6bNe7NrYj1ykmYYAD1
   m+iwJdpxTDpv0hGIvhD22Yba7oRb29StvLGnWxk4HqLS99Tmmfbo0CkPC
   g==;
X-CSE-ConnectionGUID: rK7fivzzQzC3PKNJT6yg+g==
X-CSE-MsgGUID: KEbhiyz3T9C7AeSaSasggg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="927158"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="927158"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:41 -0700
X-CSE-ConnectionGUID: v3j4pE/BTMCTPCAF+ui2pw==
X-CSE-MsgGUID: prcfNw+rQNayTSziTL0JqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1812578"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:38 -0700
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
Subject: [PATCH v5 4/5] KVM: TDX: Report only KVM-allowed CPUIDs in KVM_TDX_CAPABILITIES
Date: Fri, 16 Oct 2026 17:14:21 +0800
Message-ID: <20261016091422.3182216-5-binbin.wu@linux.intel.com>
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

Filter the directly configurable CPUID bits reported through
KVM_TDX_CAPABILITIES against KVM's TDX allowlist, and drop the hardcoded
denylist-based filtering.

The TDX module reports the CPUID bits that the VMM can directly configure
for a TD, but KVM must not advertise bits that it doesn't support, as
blindly exposing a feature that clobbers host state can corrupt the host.
The existing denylist, which clears only TSX and WAITPKG, can't account
for such features introduced by future TDX modules.

Add tdx_get_cpuid_cfg_mask() to compute the mask of directly configurable
bits that KVM allows for a given CPUID register, and apply it to every
CPUID entry reported through KVM_TDX_CAPABILITIES.  The mask combines
feature bits, taken from tdx_cpu_cfg_caps[], with non-feature bits, which
are identified by function, index, and register.

Treat CPUID.0x1.{EAX,EBX}, CPUID.{0x4,0x18,0x1F}, and CPUID.0x80000008.EAX
as fully allowed, as these registers enumerate non-feature information,
e.g. family/model/stepping, brand index, CLFLUSH line size, APIC ID,
cache/TLB/topology properties, and address sizes.  Allow the reserved bits
in them as well.  Though there's no architectural guarantee, given what
these registers enumerate, the reserved bits are expected to be used to
extend the existing information rather than to enumerate new features.

Also allow CPUID.0x24.0.EBX[7:0] (AVX10 version), which the TDX module
reports as directly configurable when AVX10 is supported, even though the
CPUID virtualization table in the "Intel TDX ABI Definitions" currently
lists it as not configurable.  The table is expected to be corrected.

As a result, directly configurable bits that aren't in the allowlist,
including bits introduced by future TDX modules, aren't advertised to
userspace until KVM explicitly opts in.

Note, the change is user-visible, as some bits that were previously
reported as configurable no longer are.  The ABI itself is unchanged: KVM
already filtered unsupported CPUID bits out of KVM_TDX_CAPABILITIES, albeit
via a denylist, and the set of configurable bits already varies with the
TDX module and KVM versions.

The change isn't expected to break userspace or guests:
 - Userspace that honors KVM_TDX_CAPABILITIES simply stops setting the
   dropped bits, and KVM_TDX_INIT_VM still succeeds.
 - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
   still allowed.
 - The dropped features are either obsolete or unsupported by KVM, and in
   the latter case, a guest relying on them would already have run into
   problems.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v5:
- Change the shortlog to make the change more clear.
- Update the changelog to call out the user-visible change more loudly.
  (Rick)
- Describe CPUID.0x24.0.EBX[7:0] in the changelog rather than in a code
  comment, since the comment would become stale once the spec is updated.
- Update the changelog/comments for the CPUIDs that are expected not to be
  repurposed to hold feature bits according to their definitions.
- Drop the note in the TDX document as the ABI itself is unchanged.

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
 arch/x86/kvm/vmx/tdx.c | 95 ++++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 13aaf7eb11b5..d617d1a0f63b 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -283,36 +283,81 @@ static bool has_tsx(const struct kvm_cpuid_entry2 *entry, u32 index)
 	       (entry->ebx & TDX_FEATURE_TSX);
 }
 
-static void clear_tsx(struct kvm_cpuid_entry2 *entry)
-{
-	entry->ebx &= ~TDX_FEATURE_TSX;
-}
-
 static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry, u32 index)
 {
 	return entry->function == 7 && index == 0 &&
 	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
 }
 
-static void clear_waitpkg(struct kvm_cpuid_entry2 *entry)
-{
-	entry->ecx &= ~__feature_bit(X86_FEATURE_WAITPKG);
-}
-
-static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
-{
-	if (has_tsx(entry, entry->index))
-		clear_tsx(entry);
-
-	if (has_waitpkg(entry, entry->index))
-		clear_waitpkg(entry);
-}
-
 static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry, u32 index)
 {
 	return has_tsx(entry, index) || has_waitpkg(entry, index);
 }
 
+#define TDX_CPUID_ALL_ALLOWED_MASK	GENMASK_U32(31, 0)
+
+static u32 tdx_get_cpuid_cfg_non_feature_mask(u32 function, u32 index, int reg)
+{
+	/*
+	 * Allow all bits in registers that enumerate non-feature information.
+	 * Note, CPUID.0x1.EAX, CPUID.{0x4, 0x18, 0x1f} and CPUID.0x80000008.EAX
+	 * contain reserved bits.  Though not architecturally guaranteed, the
+	 * reserved bits are expected to be used to extend the existing
+	 * information rather than to enumerate features, so allow them too.
+	 */
+	switch (function) {
+	case 0x1:
+		if (reg == CPUID_EAX || reg == CPUID_EBX)
+			return TDX_CPUID_ALL_ALLOWED_MASK;
+		return 0;
+	case 0x4:
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
@@ -336,8 +381,6 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
 	 */
 	if (entry->function == 0x80000008)
 		entry->eax = tdx_set_guest_phys_addr_bits(entry->eax, 0xff);
-
-	tdx_clear_unsupported_cpuid(entry);
 }
 
 #define TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT	BIT(1)
@@ -360,8 +403,16 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
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

