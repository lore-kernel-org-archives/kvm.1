Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134F3FFAC7;
	Thu,  5 Mar 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732689; cv=none; b=OjqFYowc2TV9l02osAJBX1KRdGg3X1v9/ZyYApu++Dfn1RFAMDlF/dFkcwSZBHa8lvUZF1I+uIl3DCGHHEYsAFH6kax8bKCSLDZsHZnCp6wF29elrInwHcsSHEm5K6eBulPROHa8+BtQMHMQmNb2mZMdO1WetVKXzb/URIL9vM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732689; c=relaxed/simple;
	bh=1Ct/a9/bBoOc/zftIrXLz+ZeBhZv/LgEZuxduIZrBiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4G6GJl7QIUlLR//SNAc2wgQUgnzgHM602dmEn6i/D37TK0zqTI/jrho1GfRiTunGl2GqNJSNlsRC1+u1CBOX1pth5AMrXDoPCJ6o5ZlYJI/ZSMsAeQUhWmOh4ZZVwQUzROYdRpwcoQfAVaDgbAFP6bU2o0tLpkvZ+NwaEFL/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+R5Cx/a; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+R5Cx/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772732688; x=1804268688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Ct/a9/bBoOc/zftIrXLz+ZeBhZv/LgEZuxduIZrBiQ=;
  b=N+R5Cx/aHsPvFOKJUWc4854HLaHZRJIsVWS1RZVC6bp6ldTHYL2foUlF
   Fo0XEv3E35aua1ah6ECFcD6bGl/H4516nS2So8ufnVzf6vVlWF49VPKZJ
   GbgX2rs1TnvOuVIRRHLfqmqkowUdtj6S6+7YxQHj+AXusUNsBRVLsXVPB
   Z7pNooVadt50vLb7DMLTX3Un1d3uBi1V8k0N44xuqPkVOOF1qTYptaTZz
   sBcued4U40VVjDK+HfxfiT83/0tzTj41MHibz6lbPda3/hizKly2hoh1h
   kSFvdIbaToB2Q2TGUylOAHqWO5DikMz9VGUukDPfPjestq9/wAByqJG11
   w==;
X-CSE-ConnectionGUID: GoMFQoT0SmqhkxBHghFdJg==
X-CSE-MsgGUID: K3qLwgudSreoMREb15GidQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85301949"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="85301949"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:44:47 -0800
X-CSE-ConnectionGUID: ZuVXfMIWRbO7LtRsw0M08g==
X-CSE-MsgGUID: GSWJsuRFRICVdEsYn+RMcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="222896518"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:44:44 -0800
From: isaku.yamahata@intel.com
To: kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	Yang Zhong <yang.zhong@linux.intel.com>
Subject: [PATCH v2 23/36] KVM: VMX: Introduce module parameter for APIC virt timer support
Date: Thu,  5 Mar 2026 09:44:03 -0800
Message-ID: <d8b7a892afb21bcb8b653b89da0ab134e7f86264.1772732517.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1772732517.git.isaku.yamahata@intel.com>
References: <cover.1772732517.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Zhong <yang.zhong@linux.intel.com>

Introduce a new module parameter, apic_timer_virt, to control the
virtualization of the APIC timer in KVM. The primary improvement offered by
APIC timer virtualization over the preemption timer is the passthrough of
MSR_IA32_TSC_DEADLINE to the VM. This passthrough capability reduces the
number of VM exits triggered by MSR write operations, thereby enhancing the
performance of the virtual machine.

The apic_timer_virt parameter is set to true by default on processor
platforms that support APIC timer virtualization.  On platforms that do not
support this feature, the parameter will indicate that APIC timer
virtualization is not available.

Signed-off-by: Yang Zhong <yang.zhong@linux.intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b3974125a902..0271514162df 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -119,6 +119,9 @@ module_param(enable_ipiv, bool, 0444);
 
 module_param(enable_device_posted_irqs, bool, 0444);
 
+static bool __read_mostly enable_apic_timer_virt = true;
+module_param_named(apic_timer_virt, enable_apic_timer_virt, bool, 0444);
+
 /*
  * If nested=1, nested virtualization is supported, i.e., guests may use
  * VMX and be a hypervisor for its own guests. If nested=0, guests may not
@@ -2804,7 +2807,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 			adjust_vmx_controls64(KVM_OPTIONAL_VMX_TERTIARY_VM_EXEC_CONTROL,
 					      MSR_IA32_VMX_PROCBASED_CTLS3);
 
-	if (!IS_ENABLED(CONFIG_X86_64) ||
+	if (!IS_ENABLED(CONFIG_X86_64) || !enable_apic_timer_virt ||
 	    !(_cpu_based_2nd_exec_control & SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY))
 		_cpu_based_3rd_exec_control &= ~TERTIARY_EXEC_GUEST_APIC_TIMER;
 
@@ -8835,6 +8838,9 @@ __init int vmx_hardware_setup(void)
 	if (!cpu_has_vmx_preemption_timer())
 		enable_preemption_timer = false;
 
+	if (!cpu_has_vmx_apic_timer_virt())
+		enable_apic_timer_virt = false;
+
 	if (enable_preemption_timer) {
 		u64 use_timer_freq = 5000ULL * 1000 * 1000;
 
-- 
2.45.2

