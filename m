Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B7376475
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411131; cv=none; b=nOO8/gX6ngzfyeq1K1sCgaAbwUSgWxwVYwFp3uxcQJsSEdLYkBAQetJTMzoV0LPU0MwX2ygQwMfAarRQruvQj0JYM07+cr8lGiRN5xRpNOqOPYMPqqlwy8AZ9OTIZ2FGmoVEvszSlkM2o+SnAk1o6WOeHFx+xWS/n9Th6q2stoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411131; c=relaxed/simple;
	bh=vJLhfTGXgbyWmQy4mJdm0Q13aSbe11cQZIkVK2DsOQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjtHaEHn8a86+4LMpEzVHoOmEYdm9RHTd147Gu5C7vMqhC499ncMuPglAxfgZkH2Uaeoe3m9SLzX8uc7JbXQ4DQ9DRLHO1cLeFW4u3mx677EUN2lhkaMv1PUErb2fuN9BxOV6sv5lCN2YARjfxb8zwhhGY567xW5EV5VlGOn+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ujv90E12; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ujv90E12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411130; x=1807947130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vJLhfTGXgbyWmQy4mJdm0Q13aSbe11cQZIkVK2DsOQo=;
  b=Ujv90E12k2qYl4XfgR9/w61sC7sL5l1O/c5q+EzqGHIL06tCV/y97sUt
   WzlPAip1fymXB77YtgWenTpc4sL5wXnpGcvQUv8hVjOWMubl4K7I/0GGQ
   DxJeHYaUNjoOFl4bbe2B+pF+07U/IDTImKZcMCNqfZs97feihUsgy2mFj
   jFiWGqjbqPpaii4CqrSTiRvkgumZaETsx0rCn4Kg5gng7abYpxm6FiVKZ
   0Eo0qk5/RLBQkbmkl2JZgBD3Te/uNEVxi0J1OOjUuAYt4oL6XH4GZzvl+
   LDOdWY3/SVo3TZJrduKwLDjx3rGFhhNAZx48YznhGET5eYokrdCMCXOvn
   w==;
X-CSE-ConnectionGUID: 3Si51YTmTfSpMNPpWDuKDQ==
X-CSE-MsgGUID: OtUBgmfMQKiH0pFw8w1FEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070128"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070128"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:10 -0700
X-CSE-ConnectionGUID: IGyGQtVSSZSomiVjpcbLtg==
X-CSE-MsgGUID: jKCvWl/xTVyF23GiL2NOTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284841"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:07 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 03/27] KVM: x86: Add definitions for CPUID overlays
Date: Fri, 17 Apr 2026 15:35:46 +0800
Message-ID: <20260417073610.3246316-4-binbin.wu@linux.intel.com>
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

Introduces definitions for CPUID overlays to handle varying CPUID
requirements across different VM types on Intel and AMD platforms.

3 CPUID overlays are defined and will be used as following:
- CPUID_OL_VMX for KVM_X86_{DEFAULT_VM, SW_PROTECTED_VM} on
  intel-compatible platforms.
- CPUID_OL_TDX for KVM_X86_TDX_VM
- CPUID_OL_SVM for all VM types supported on AMD-compatible platforms.

Having separate overlays for VMX and TDX helps to handle the cases when
there are differences about KVM's support for some features, e.g., TSX,
HLE and WAITPKG are not supported for TDX in KVM. There may be new
features like this in the future.

Having separate overlays for VMX and SVM helps to handle the case when
a common feature having support for one vendor, but not for the other.
Setting the support in common code requires additional handling in
vendor specific code. E.g., SVM code needs to clear IBT, BUS_LOCK_DETECT
and MSR_IMM.

More overlays can be added in the future, e.g, AMD may want to have
a separate CPUID overlay for SNP.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 039b8e6f40ba..f41f8d3db794 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -7,6 +7,29 @@
 #include <asm/processor.h>
 #include <uapi/asm/kvm_para.h>
 
+enum kvm_cpuid_overlay {
+	CPUID_OL_VMX = 0,
+	CPUID_OL_SVM,
+	CPUID_OL_TDX,
+	NR_CPUID_OL
+};
+
+#define F_CPUID_VMX		BIT(CPUID_OL_VMX)
+#define F_CPUID_SVM		BIT(CPUID_OL_SVM)
+#define F_CPUID_TDX		BIT(CPUID_OL_TDX)
+
+static inline u8 get_cpuid_overlay(struct kvm *kvm)
+{
+	if (kvm && kvm->arch.vm_type == KVM_X86_TDX_VM)
+		return CPUID_OL_TDX;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		return CPUID_OL_SVM;
+
+	return CPUID_OL_VMX;
+}
+
 extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
 extern bool kvm_is_configuring_cpu_caps __read_mostly;
 
-- 
2.46.0

