Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4437754F
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411172; cv=none; b=lCbw07VMeg+Z9GLHzih4Sd9COX/DCC7l2IXaLXYtIywdzjzuHQtM+aR5welhhqrDd69r2S48G/UZDDBh8j7ucQd7216mmyBkLoj2LF/bnXXFFaDWKZx17sJm2ucutBqf4koM43xcmDq834nNhZI4n3NNokRb1vWQXo5MsICPbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411172; c=relaxed/simple;
	bh=RnA2RDgx4YGksTcPH5qevSMHQP1B77QeRrLTogbLk/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC0iWNVzhyohofE8yw2ZTRWo1ryBJZrDri43/PZ1K7XMSGUQhq/5OKZg9+X+96UAcUka3us+ZnLQGpok1kb+fFwfnpSVfEHv//ccsfZpxLb3vwWrDqGMz43zQWJn4LXjjVVLMwcjolWHcBEkY952ZcK9sCZyGzOFUeKbUhY+dgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwVsjYP9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwVsjYP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411171; x=1807947171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RnA2RDgx4YGksTcPH5qevSMHQP1B77QeRrLTogbLk/4=;
  b=CwVsjYP9zeLQl8y7QZTSKC8yfCR6BRiHfOTrL/JFi5HpnBe+IuKmsZKr
   P/MAb1WfggRCe0Xx/ORRzyGHcVDb29ZiZKI3uU4TuZeKlu1i89kfwE4DX
   V3fZA/1gZxqdiBF/xBiwMuLw3PdkxRzoiIpz3zMD6EE0gg5xMt68t0vEk
   mk3VydQ0mad5np2fHux3fXmVL51pSEe9KdL4jRYA0W/6XvJU+OCnynRMO
   tzG0WNo7AKcf9rY7epLEOMgJ+Ce5pbkNabAlqMcGD7WJZjPflbrrCkRx8
   FQlXixo8PSozJkBHV3ocDuyhYGxK82tMZm/kiFz5MgA1oIW82+XRf2W72
   A==;
X-CSE-ConnectionGUID: rS2UMzL6T32rW1e1LNWg+w==
X-CSE-MsgGUID: rIR4u+8yT16ON7uAAq7Ftw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070289"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070289"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:51 -0700
X-CSE-ConnectionGUID: ksztmvwDSoeQBJbju6NELg==
X-CSE-MsgGUID: G2S7pRS+RdmrLknjYoSQJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285057"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:48 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 22/27] KVM: x86: Verify userspace CPUID inputs in paranoid mode
Date: Fri, 17 Apr 2026 15:36:05 +0800
Message-ID: <20260417073610.3246316-23-binbin.wu@linux.intel.com>
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

Add CPUID paranoid verification to reject userspace CPUID configurations
that set unsupported or unknown bits when paranoid mode is enabled for a
VM.

When paranoid mode is enabled, iterate over every userspace-provided
CPUID entry and check all four registers (EAX-EDX) against KVM's
supported masks or values.

Introduce cpuid_reg_2_x86_leaf() to reverse-map a (function, index, reg)
tuple to a reverse_cpuid[] index, handling subleaf remapping for CPUID
leaves with a common pattern across sub-leaves.

Refactor the vCPU capability initialization to iterate over userspace
CPUID entries rather than reverse_cpuid[], combining the paranoid check
with capability setup in cpuid_check_and_set_vcpu_caps().  When paranoid
mode is disabled, entries without a reverse_cpuid[] mapping are simply
skipped, preserving existing behavior.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 142 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 08f5bc1d26b1..2027230a1f42 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -406,7 +406,7 @@ static void kvm_cpu_cap_ignore(u32 func, u32 index_start, u32 index_end,
 	ignored_set.nr++;
 }
 
-static bool __maybe_unused is_cpuid_paranoid_ignored(u32 func, u32 index, int reg, u8 overlay)
+static bool is_cpuid_paranoid_ignored(u32 func, u32 index, int reg, u8 overlay)
 {
 	for (int i = 0; i < ignored_set.nr; i++) {
 		struct ignored_entry *e = &ignored_set.entries[i];
@@ -419,7 +419,7 @@ static bool __maybe_unused is_cpuid_paranoid_ignored(u32 func, u32 index, int re
 	return false;
 }
 
-static bool __maybe_unused is_cpuid_reg_check_value(u32 func, u32 index, int reg)
+static bool is_cpuid_reg_check_value(u32 func, u32 index, int reg)
 {
 	switch (func) {
 	case 0x1D: return true;
@@ -428,7 +428,7 @@ static bool __maybe_unused is_cpuid_reg_check_value(u32 func, u32 index, int reg
 	}
 }
 
-static bool __maybe_unused is_cpuid_subleaf_common_pattern(u32 func, u32 *index)
+static bool is_cpuid_subleaf_common_pattern(u32 func, u32 *index)
 {
 	switch (func) {
 	case 4:
@@ -449,45 +449,129 @@ static bool __maybe_unused is_cpuid_subleaf_common_pattern(u32 func, u32 *index)
 	}
 }
 
-int kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
+static u32 cpuid_reg_2_x86_leaf(u32 leaf, u32 index, int reg)
 {
-	u8 cpuid_overlay = get_cpuid_overlay(vcpu->kvm);
-	struct kvm_lapic *apic = vcpu->arch.apic;
-	struct kvm_cpuid_entry2 *best;
-	struct kvm_cpuid_entry2 *entry;
-	bool allow_gbpages;
-	int i;
+	bool remapped = false;
 
-	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
-	BUILD_BUG_ON(ARRAY_SIZE(reverse_cpuid) != NR_KVM_CPU_CAPS_PARANOID);
+	if (is_cpuid_subleaf_common_pattern(leaf, &index))
+		remapped = true;
 
-	/*
-	 * Reset guest capabilities to userspace's guest CPUID definition, i.e.
-	 * honor userspace's definition for features that don't require KVM or
-	 * hardware management/support (or that KVM simply doesn't care about).
-	 */
-	for (i = 0; i < NR_KVM_CPU_CAPS; i++) {
-		const struct cpuid_reg cpuid = reverse_cpuid[i];
-		struct kvm_cpuid_entry2 emulated;
+	for (int i = 0; i < ARRAY_SIZE(reverse_cpuid); i++) {
+		const struct cpuid_reg *cpuid = &reverse_cpuid[i];
+
+		if (cpuid->function == leaf && cpuid->index == index && cpuid->reg == reg) {
+			/*
+			 * Remapping index is only inteded for paranoid CPUID
+			 * checks, it should not fall into the range, which
+			 * is tracked by vCPU's caps.
+			 */
+			WARN_ON_ONCE(remapped && i < NR_KVM_CPU_CAPS);
+			return i;
+		}
+	}
 
-		if (!cpuid.function)
+	return (u32)-1;
+}
+
+static int do_cpuid_reg_paranoid_check(struct kvm *kvm,
+				       struct kvm_cpuid_entry2 *entry, int reg,
+				       u32 input, u32 supported)
+{
+	bool check_value;
+
+	if (!kvm->arch.is_cpuid_paranoid_mode)
+		return 0;
+
+	check_value = is_cpuid_reg_check_value(entry->function, entry->index, reg);
+
+	if (check_value && (input == supported))
+		return 0;
+
+	if (!check_value && (input & supported) == input)
+		return 0;
+
+	pr_debug("CPUID func 0x%x index %d E%cX: 0x%08x %s 0x%08x\n",
+		entry->function, entry->index, 'A' + reg, input,
+		check_value ? "!=" : "has unsupported bits",
+		check_value ? supported : input & ~supported);
+
+	return -EINVAL;
+}
+
+static int cpuid_check_and_set_vcpu_caps(struct kvm_vcpu *vcpu,
+					 struct kvm_cpuid_entry2 *entry)
+{
+	u8 cpuid_overlay = get_cpuid_overlay(vcpu->kvm);
+	struct kvm_cpuid_entry2 emulated;
+	u32 input, supported;
+	u32 leaf;
+
+	if (!entry->index)
+		cpuid_func_emulated(vcpu->kvm, &emulated, entry->function, true);
+
+	for (int reg = CPUID_EAX; reg <= CPUID_EDX; reg++) {
+		if (vcpu->kvm->arch.is_cpuid_paranoid_mode &&
+		    is_cpuid_paranoid_ignored(entry->function, entry->index, reg, cpuid_overlay))
 			continue;
 
-		entry = kvm_find_cpuid_entry_index(vcpu, cpuid.function, cpuid.index);
-		if (!entry)
+		/*
+		 * For a leaf remapped from a different index, it will
+		 * not be set to vcpu->arch.cpu_caps[] below.
+		 */
+		leaf = cpuid_reg_2_x86_leaf(entry->function, entry->index, reg);
+
+		if (!vcpu->kvm->arch.is_cpuid_paranoid_mode && leaf >= NR_KVM_CPU_CAPS)
 			continue;
 
+		input = cpuid_get_reg_unsafe(entry, reg);
+
+		supported = leaf != (u32)-1 ? kvm_cpu_caps[cpuid_overlay][leaf] : 0;
+		supported |= (!entry->index ? cpuid_get_reg_unsafe(&emulated, reg) : 0);
+
+		if (do_cpuid_reg_paranoid_check(vcpu->kvm, entry, reg, input, supported))
+			return -EINVAL;
+
+		if (leaf >= NR_KVM_CPU_CAPS)
+			continue;
 		/*
 		 * A vCPU has a feature if it's supported by KVM and is enabled
 		 * in guest CPUID.  Note, this includes features that are
 		 * supported by KVM but aren't advertised to userspace!
 		 */
-		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[cpuid_overlay][i];
-		if (!cpuid.index) {
-			cpuid_func_emulated(vcpu->kvm, &emulated, cpuid.function, true);
-			vcpu->arch.cpu_caps[i] |= cpuid_get_reg_unsafe(&emulated, cpuid.reg);
-		}
-		vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
+		vcpu->arch.cpu_caps[leaf] = supported;
+		vcpu->arch.cpu_caps[leaf] &= cpuid_get_reg_unsafe(entry, reg);
+	}
+
+	return 0;
+}
+
+int kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic *apic = vcpu->arch.apic;
+	struct kvm_cpuid_entry2 *best;
+	bool allow_gbpages;
+	int r = 0;
+
+	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
+	BUILD_BUG_ON(ARRAY_SIZE(reverse_cpuid) != NR_KVM_CPU_CAPS_PARANOID);
+
+	/*
+	 * If CPUID paranoid mode is enabled, KVM rejects userspace's guest
+	 * CPUID definition if it contains any bits that aren't supported or
+	 * unknown by KVM.  Otherwise, reset guest capabilities to userspace's
+	 * guest CPUID definition, i.e. honor userspace's definition for
+	 * features that don't require KVM or hardware management/support (or
+	 * that KVM simply doesn't care about).
+	 */
+	for (int i = 0; i < vcpu->arch.cpuid_nent; i++) {
+		r = cpuid_check_and_set_vcpu_caps(vcpu, &vcpu->arch.cpuid_entries[i]);
+		/*
+		 * No need to worry about the changes having been made if any
+		 * check fails, all the changes will be reverted when returning
+		 * an error on the set CPUID patch.
+		 */
+		if (r)
+			return r;
 	}
 
 	kvm_update_cpuid_runtime(vcpu);
-- 
2.46.0

