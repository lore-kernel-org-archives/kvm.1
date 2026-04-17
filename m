Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF3374E43
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411174; cv=none; b=B75ocaZKJ3goUlEhWKG3RMjp8nL2Dq6LQ8SsvcHKpH94d7H531I5/9I+NNBI/uIiwsGgJOcaE2/rFcILLNTnWjVdOpBl/EcIrL9+s7Fhhv7F3R+y1XhqebDWZZ/Mw+jOTa5tUagxJimMIuaL6u7uzPAB6FaU8PGrYiwrn8FimX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411174; c=relaxed/simple;
	bh=Enosa8EeI+5ZC6iQxXbNvM6Z6iDd38jqga5FNBCby5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oM6D/8fBsCziKdqhKh4lgDjvC+inQbDJtxj5y2wOby1xmsfzuWCXT8vLy86h9gtKUKbmDFwTwWRBMHp+WN3W8mldoF/IpkaSx4K/E7pImvchNIeCT17QGbaLwhrjgg2hkCQqY+jMeH4SqS508WZC77zajlg8Ijwfecpwr9OO1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmbvlAsV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmbvlAsV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411173; x=1807947173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Enosa8EeI+5ZC6iQxXbNvM6Z6iDd38jqga5FNBCby5s=;
  b=FmbvlAsVbuPuoLWFe2hEpVqlBYXwptG4ykrUzIAc7XBjhNeo/pciugcZ
   0Bz0hAnMD1izIL/h4zhiR9dVC2Ksb6/ElKCN+JpybUYIF6iL+zMXDGgWi
   zEdkLjec+B9+zpgrNyAUVo1/2wAktQpoux28klyMyN5dQ4UKBrZNrd6EO
   4hwuRzDgaVhJXaGj+0XZtP9ozGQnwVp1ILDPbo38MaK0J2Tkn1oQDJj9n
   YQl43Y/wLIB6kC7CnnC6j8LPH49Pj+lUJjjLntL/6nh2NLwLmqfeNc61I
   bHDeZ9zqVO3LWrMl6AXUrxn3FmF1JCqNj0wAeV2glzygrIMA8EQ+aTuAW
   w==;
X-CSE-ConnectionGUID: TFJ7RcxxRTShakx7HUHUOg==
X-CSE-MsgGUID: Mk7BgEA7QXikZOonOp7hnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070298"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070298"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:53 -0700
X-CSE-ConnectionGUID: FmLEunK8SBSjaOJk9htpzQ==
X-CSE-MsgGUID: Lc770OK6SrSxF8TXLOhdRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285065"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:50 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 23/27] KVM: x86: Account for runtime CPUID features in paranoid mode
Date: Fri, 17 Apr 2026 15:36:06 +0800
Message-ID: <20260417073610.3246316-24-binbin.wu@linux.intel.com>
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

Include RUNTIME_F() features in the supported mask during paranoid CPUID
verification to avoid false rejections of legitimate userspace CPUID
configurations.

Add get_cpuid_reg_dynamic() to return OSXSAVE and OSPKE as supported
bits based on the vCPU's current CR4 state.  Both features are declared
with RUNTIME_F() and thus absent from kvm_cpu_caps[][], but userspace
may legitimately set them when CR4.OSXSAVE or CR4.PKE is enabled.  TDX
guests are unaffected as these bits are not configurable for TDs.

For non-TDX guests, MWAIT is already permitted via cpuid_func_emulated(),
but that function early-returns zero for TDX guests since KVM cannot
(even partially) emulate these features for TDs.  The TDX module does
support exposing MWAIT to guests when the host has MWAIT and userspace
configures it, Declare MWAIT with F(MWAIT, F_CPUID_TDX) alongside the
existing RUNTIME_F(MWAIT) to populate MWAIT in the TDX overlay.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2027230a1f42..af87b803572c 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -498,6 +498,24 @@ static int do_cpuid_reg_paranoid_check(struct kvm *kvm,
 	return -EINVAL;
 }
 
+static u32 get_cpuid_reg_dynamic(struct kvm_vcpu *vcpu, u32 func, u32 index, int reg)
+{
+	switch (func) {
+	case 1:
+		if (reg == CPUID_ECX && kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE))
+			return feature_bit(OSXSAVE);
+		break;
+	case 7:
+		if (index == 0 && reg == CPUID_ECX && kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE))
+			return feature_bit(OSPKE);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int cpuid_check_and_set_vcpu_caps(struct kvm_vcpu *vcpu,
 					 struct kvm_cpuid_entry2 *entry)
 {
@@ -527,6 +545,7 @@ static int cpuid_check_and_set_vcpu_caps(struct kvm_vcpu *vcpu,
 
 		supported = leaf != (u32)-1 ? kvm_cpu_caps[cpuid_overlay][leaf] : 0;
 		supported |= (!entry->index ? cpuid_get_reg_unsafe(&emulated, reg) : 0);
+		supported |= get_cpuid_reg_dynamic(vcpu, entry->function, entry->index, reg);
 
 		if (do_cpuid_reg_paranoid_check(vcpu->kvm, entry, reg, input, supported))
 			return -EINVAL;
@@ -1025,6 +1044,11 @@ void kvm_initialize_cpu_caps(void)
 		 * that KVM is aware that it's a known, unadvertised flag.
 		 */
 		RUNTIME_F(MWAIT),
+		/*
+		 * For TDX, MWAIT could be advertised to guests if the host
+		 * supports it and userspace configures it.
+		 */
+		F(MWAIT, F_CPUID_TDX),
 		/* DSCPL is fixed-1 in TDX */
 		F(DSCPL, F_CPUID_TDX),
 		VENDOR_F(VMX),
-- 
2.46.0

