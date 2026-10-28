Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175209;
	b=0uHRMoC3/KGceZIkWmHALOZ72pgUd6X2tdT7wbF0AGrE5K8v+mT3yKOV6Px1CSZhY7Pz
	 YZNX6gS/qar/Hj2/YFPSxLJfsGA3vnnaWPxWBgDgcmx1m8z+/HBgfAfau+zsKnI0L2eTd
	 Ve7I/cMUaAS+6ZkAgoGZKIgTIX7f6ZqXxjI1jnE5JFmOAbk01sflnnZ8o6yB3SlbXhCiA
	 mSSYO8HY/KcN4n/PJ3zVLmYjXsi2sol4MuKx3GLJOXfRIrbYT/WmQtRnbm+GDYFVELiph
	 e5sOOMOf3Zf/0NH6hIVfhBLiMlWUPzoc5A3O0XAEDtzATGXJzOK5RtTl2XCfwX1vEkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175209;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VUzBHhWhDxOLvkLJk+E77UmTIWfq3Yjnsro1mI6SDTw=;
	b=VyNGY4zpifu2XWGvqPcj+WxhNmCbHtkR/48vrX2+fK9mk++xvVLuu3LsbNWcy5UFZiHD
	 HbbwKUloWKEpisdT8UiD4XLzacFlVXKncHWhvkt09QjsDVT548pjDV8QMG7O0PgxD9OjN
	 JVvQprE/araR7JX86iIZNwPcEgHhV2eop3ZaPmcII8r38oolXTT64bipUZDfiwYAWK0oj
	 dn226PkI4vvoQn+M+SX4Lowxjl3gw8Xo2pf9TMYr7kgFNSk3c2Cp+tjZkUaeVFJSGveoM
	 YzZAjMeYq1mcaSooNn+lk/0OJGGvGiXNyw/8By2BmYKZNYbUU0UDf4SwyijO4tAYPGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ijjngkcf;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31360A2611;
	Wed, 28 Oct 2026 08:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C31360A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ijjngkcf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793175209; x=1824711209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aVa2hkQPjq4qDne7EdqmA9CNHEkPAbwUq3TJXBaTmRk=;
  b=ijjngkcf620Bba9G3iR7fTiexfVcWAjuR/qd0ZhfxI5fAblcoWyLJMGB
   +4oHBX43vrHiK2CaEb80L/hRBIKMsADowWyhp9FdzCeFhwqC/sOWD1pWJ
   NSYGpyieTyKUnvcUlKKRBooJ0qEVZ5Pu1o2S+qtfP4/qj6yqjscp94xXH
   y8TVVF10fH5iKlb1oLKumCI5Kt19Vwfh6hgVPV8RmFDNkhNLY0o90C5m2
   n8tX8HTY8n+BaQ0n9NQDn+bpmg+r4zwW0OVSrl8NqKE4eEcX42/gCu+wV
   lIrDIhSxnq0AMIyPOHqQD4Q9YK09oBiDBXwinNOS1OCXphlhUFbUu/Iqx
   Q==;
X-CSE-ConnectionGUID: aZPRE2yDQBGL+wgkEBm0vA==
X-CSE-MsgGUID: NlEOwD0kStWj/l8ZJYq/nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1902943"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1902943"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:29 -0700
X-CSE-ConnectionGUID: UN/KtB3PTEC9FC404Nxqjg==
X-CSE-MsgGUID: ORhPM2GkSU+2pZawUG2tYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5118504"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:23 -0700
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
Subject: [PATCH v6 3/4] KVM: TDX: Report only KVM-allowed CPUID bits in KVM_TDX_CAPABILITIES
Date: Wed, 28 Oct 2026 16:16:56 +0800
Message-ID: <20261028081658.1228484-4-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
References: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
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
CPUID virtualization table in the "Intel TDX Module ABI Definitions"
currently lists it as not configurable.  The table is expected to be
corrected.

As a result, directly configurable bits that aren't in the allowlist,
including bits introduced by future TDX modules, aren't advertised to
userspace until KVM explicitly opts in.

Note, this is an ABI change, as some bits that were previously reported as
configurable no longer are.  However, the semantics of
KVM_TDX_CAPABILITIES are unchanged: KVM already filtered unsupported bits
out of KVM_TDX_CAPABILITIES, albeit via a denylist, and the set of
reported bits already varies with the TDX module and KVM versions, i.e.
userspace can't assume a fixed set.

The change isn't expected to break userspace or guests:
 - Userspace that honors KVM_TDX_CAPABILITIES simply stops setting the
   dropped bits, and KVM_TDX_INIT_VM still succeeds.
 - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
   still allowed.
 - The dropped features are either obsolete or unsupported by KVM, and in
   the latter case, a guest relying on them would already have run into
   problems.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
v6:
- Rebased on patch series "x86/cpuid: KVM: TDX CPUID fixes"
  https://lore.kernel.org/all/20261022210134.612848-1-seanjc@google.com
- Fix the changelog on ABI change. (Rick)
- Collected RBs. (Rick, Chao, Xiaoyao)

v5:
- Change the shortlog to make the change more clear.
- Update the changelog to call out the user-visible change more loudly.
  (Rick)
- Describe CPUID.0x24.0.EBX[7:0] in the changelog rather than in a code
  comment, since the comment would become stale once the spec is updated.
- Update the changelog/comments for the CPUIDs that are expected not to be
  repurposed to hold feature bits according to their definitions.
- Drop the note in the TDX document as the semantic of KVM_TDX_CAPABILITIES
  is unchanged.

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
 arch/x86/kvm/vmx/tdx.c | 97 ++++++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index becdd5aa9e682..0741c3ef4745e 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -284,31 +284,12 @@ static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
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
 static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
 {
 	if (cpuid_function_is_indexed(entry->function) !=
@@ -318,6 +299,70 @@ static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
 	return has_tsx(entry) || has_waitpkg(entry);
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
@@ -352,8 +397,6 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
 	 */
 	if (entry->function == 0x80000008)
 		entry->eax = tdx_set_guest_phys_addr_bits(entry->eax, 0xff);
-
-	tdx_clear_unsupported_cpuid(entry);
 }
 
 #define TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT	BIT(1)
@@ -376,8 +419,16 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
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

