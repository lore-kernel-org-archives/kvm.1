Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10219375ADD
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411176; cv=none; b=aM74ZsoizlErflplxorV42w2zQzYnQh1DvDugJ4b3lZD4RwHvddWWF5DUodxIlb2jEdV60Ggq545NJt36CT6JSHiEf7WZpLbVLMMtRFSINpPneAPqAJaCO7pEIwjauBmtL6GJN1t1x3ZootGqfPX0K2/4z+SdfEjnUjxZdK/ckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411176; c=relaxed/simple;
	bh=wqvfKrVz/qg0d+NegcU05KGdAiWHyA/PUlc0+QSQNQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J655jC+TjiGoOycLdElCV30RD2QRxq8ce4m898zlsNutAXbXHksgL1ZZ6vS1Qad82CH5u+HJ/uFt/O0NMegxspfv+0MnCcUl7zGgUJpXrHxYULCB+3bR046QL8VDcAsLhDltg47qipdGEykIxm4oXFY8iRtq5SyudxDAppdLx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9puzJYD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9puzJYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411175; x=1807947175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wqvfKrVz/qg0d+NegcU05KGdAiWHyA/PUlc0+QSQNQg=;
  b=I9puzJYDAckbX/Ap2JYwbhfJbqiwhSr5xbHDbxdqwIKMAmqudBnS0lf+
   hlbgPo/MavKRll6EoPlZO+2v+Y2UO0+h2hxPWeoOYFddlYTvI00si8UPE
   kLtc548ArgZCKUp+eEwa+iOeJC+klKIJdouC6SnWdOJPaIQFPgk7g3ZqD
   jIP/+g2Sx2FwcNkewvSNFgSUXQRiCIzkwM0vfol3amiScTznla8EkH3bu
   MPwpw8XM32PCI6m1LIajOVKK2xmycndbuDbaX5QSOqgcOPOkFhh/iVE0Y
   rL5BmlsjGg5vfg8iVWR63RQLBCMcKFv/vG6dhjBcTkIu+/WBIpXEYdcfg
   g==;
X-CSE-ConnectionGUID: FWV6PzOHQEeEuuNU/aTW9w==
X-CSE-MsgGUID: FhNl7YBGRX+/vmbmawJIOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070301"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070301"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:55 -0700
X-CSE-ConnectionGUID: LRbsor9cQHyHVJjUPoxZbw==
X-CSE-MsgGUID: C7PRsDXFS+OGn5pZ1aM5Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285077"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:53 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 24/27] KVM: x86: Skip paranoid CPUID check for KVM PV leafs when base is relocated
Date: Fri, 17 Apr 2026 15:36:07 +0800
Message-ID: <20260417073610.3246316-25-binbin.wu@linux.intel.com>
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

Handle the case where the KVM PV CPUID base is relocated from its
default location (0x40000000) in paranoid mode, e.g. when userspace
advertises support for both Hyper-V and KVM.

In CPUID paranoid mode, if KVM CPUID base is relocated, skip the normal
per-register paranoid verification. Just rejects the configuration
outright for TDs (as TDX does not support other PV enhancements) and
allows it for normal guests.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index af87b803572c..e6f0ecadc290 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -516,6 +516,16 @@ static u32 get_cpuid_reg_dynamic(struct kvm_vcpu *vcpu, u32 func, u32 index, int
 	return 0;
 }
 
+static int kvm_check_pv_cpuid_relocated(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *entry)
+{
+	/* TDX doesn't support other virtualization enhancements. */
+	if (get_cpuid_overlay(vcpu->kvm) == CPUID_OL_TDX)
+		return -EINVAL;
+
+	/* TODO: Check PV CPUIDs when KVM PV CPUID base is relocated. */
+	return 0;
+}
+
 static int cpuid_check_and_set_vcpu_caps(struct kvm_vcpu *vcpu,
 					 struct kvm_cpuid_entry2 *entry)
 {
@@ -524,6 +534,11 @@ static int cpuid_check_and_set_vcpu_caps(struct kvm_vcpu *vcpu,
 	u32 input, supported;
 	u32 leaf;
 
+	if (vcpu->kvm->arch.is_cpuid_paranoid_mode &&
+	    (entry->function & 0xFFFF0000) == KVM_CPUID_SIGNATURE &&
+	    kvm_get_hypervisor_cpuid(vcpu, KVM_SIGNATURE).base != KVM_CPUID_SIGNATURE)
+		return kvm_check_pv_cpuid_relocated(vcpu, entry);
+
 	if (!entry->index)
 		cpuid_func_emulated(vcpu->kvm, &emulated, entry->function, true);
 
-- 
2.46.0

