Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820A4570D1;
	Fri, 11 Sep 2026 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162861; cv=none; b=F6768CZNp1k8X6dm6eljMIzOMgQiHMviskUKeCkDx46BStdn2RrYLbuWK4itFzPsDgi4vGoA7MhqgyOD/3d9WAq/4drRYRGQh8U9NXjM3vY6rKtbayu4zE7vTXP5nPgO8uVXSlZjWp+JL16MOxJ24cgmC2oivpBuFvq+tLMVdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162861; c=relaxed/simple;
	bh=0qNqsEIyAeCzzxembfEaW2mKNJ3cFGzdVIOVID9El58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNklHi4UaAhOIm0ZE+6diklH4QjbsOmZiY/F+7fO4zBE7dyTKmgfHOzFWeP/MqL1hQbObozLUoyQopRrEqW+ioZlrAMfkvYrgLroFNyeL2QqMpDsnGGb4SKeTpyFzu/0dYKR7fod6mBDZRLkDlLZ9oVveO6ipFNEaeHsg0AqWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZ/o2cdh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZ/o2cdh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162860; x=1820698860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qNqsEIyAeCzzxembfEaW2mKNJ3cFGzdVIOVID9El58=;
  b=kZ/o2cdhQxkHcbDuNrnUAvs4Vn4KrTMJ7sXJaDLzyivPlOB9xhrRtL8V
   ws9150JdfKZCI1a5SbAN5l/+sjvB/jCOm2TogpXULRMnN18YELEnrc87f
   E8LTthh06ci/mFFm7CL795bBn87izfFjEQBSYvl+1+bzl9c0iEIJy32eE
   Wi/mkmAtiYmgAozXl8KKNBTdVDsqAYLTEb47OnX+F3AedGMFwqE+jaoFA
   CkHAdvOnTBaXyJHmuZnwwkSeT3C1bvLqrG3r7uHT9F2H50rKBbLgPctw5
   Ycytcj+NDUwmLb/2AOpeVrA1zOkHChDfEUjLcR+lvrAW0lZhz7Prpv9NV
   Q==;
X-CSE-ConnectionGUID: R5k87XRkTZa1uIpx7VfmOg==
X-CSE-MsgGUID: r0lTKtFORIS2fqpJQwmokg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572525"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572525"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:40:59 -0700
X-CSE-ConnectionGUID: 72scEmk5SxeR29gVwOMcew==
X-CSE-MsgGUID: jkbnjOJjQ0GfAT3RPsq5hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004049"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:40:58 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 08/28] KVM: VMX: Set FRED MSR intercepts
Date: Fri, 11 Sep 2026 14:36:38 -0700
Message-ID: <20260911213659.2025974-9-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

On a userspace MSR filter change, set FRED MSR intercepts.

Because the following eight FRED MSRs,
        MSR_IA32_FRED_RSP[123], MSR_IA32_FRED_STKLVLS,
        MSR_IA32_FRED_SSP[123], MSR_IA32_FRED_CONFIG,
are used by the kernel itself to take an exception at any time, they
should be context-switched by Intel VT-x automatically in order to
preserve the FRED architectural invariant that there should NEVER be
a "gap" during which it is unsafe to take an exception.

KVM leverages Intel VT-x hardware to automatically context switch the
eight FRED MSRs using:

  1) Dedicated host and guest VMCS fields for each MSR.

  2) VM-entry/exit controls to manage the automated loading and saving
     of the eight FRED MSRs.

Consequently, passing these MSRs through to the guest would only add
unnecessary handling code without benefit.

Both MSR_IA32_FRED_RSP0 and MSR_IA32_FRED_SSP0 (aka MSR_IA32_PL0_SSP)
are dedicated for userspace event delivery, IOW they are NOT used in
any kernel event delivery and the execution of ERETS.  Thus KVM can
run safely with guest values in the two MSRs.  As a result, save and
restore of their guest values are deferred until vCPU context switch,
Host MSR_IA32_FRED_RSP0 is restored upon returning to userspace, and
Host MSR_IA32_PL0_SSP is managed with XRSTORS/XSAVES.

MSR_IA32_PL0_SSP (aka MSR_IA32_FRED_SSP0) is part of CET supervisor
state, but all four FRED SSP MSRs are architecturally visible on any
processor that enumerates FRED.  Even if CET is absent, these MSRs
remain accessible via RDMSR/WRMSR, though FRED transitions will not
use them.

Intercept MSR_IA32_PL0_SSP if CET shadow stacks are unsupported (even
with FRED present).  Since this MSR is rarely accessed and ignored by
XSAVES in this configuration, interception avoids the overhead of
manually context switching the hardware MSR during vcpu_load/put.

This behavior is consistent with the current setup in
vmx_recalc_msr_intercepts(), so no change is needed to the interception
logic for MSR_IA32_PL0_SSP.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Improve the commit message and code comment with an explanation
   from hpa (Chao Gao and Dave Hansen).
---
 arch/x86/kvm/vmx/vmx.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index dc80ca5f804d..09bbbc680aa7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4304,6 +4304,72 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 }
 
+static void vmx_set_intercept_for_fred_msr(struct kvm_vcpu *vcpu)
+{
+	bool intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_FRED);
+
+	if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
+		return;
+
+	/*
+	 * Because the following eight FRED MSRs,
+	 * 	MSR_IA32_FRED_RSP[123], MSR_IA32_FRED_STKLVLS,
+	 * 	MSR_IA32_FRED_SSP[123], MSR_IA32_FRED_CONFIG,
+	 * are used by the kernel itself to take an exception at any time, they
+	 * should be context-switched by Intel VT-x automatically in order to
+	 * preserve the FRED architectural invariant that there should NEVER be
+	 * a "gap" during which it is unsafe to take an exception.
+	 *
+	 * KVM leverages Intel VT-x hardware to automatically context switch the
+	 * eight FRED MSRs using:
+	 *
+	 *   1) Dedicated host and guest VMCS fields for each MSR.
+	 *
+	 *   2) VM-entry/exit controls to manage the automated loading and saving
+	 *      of the eight FRED MSRs.
+	 *
+	 * Consequently, passing these MSRs through to the guest would only add
+	 * unnecessary handling code without benefit.
+	 */
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, intercept);
+
+	/*
+	 * MSR_IA32_FRED_RSP0 and MSR_IA32_PL0_SSP (aka MSR_IA32_FRED_SSP0) are
+	 * designed for event delivery while executing in userspace.  Since KVM
+	 * operates entirely in kernel mode (CPL is always 0 after any VM exit),
+	 * it can safely retain and operate with guest-defined values for these
+	 * MSRs.
+	 *
+	 * Disabling interception of the two MSRs offers two advantages:
+	 *   1) Simplicity: Eliminates dedicated MSR handling code.
+	 *   2) Performance: Avoids frequent VM-exits since the two MSRs are
+	 *      per user thread variables and frequently accessed.
+	 *
+	 * MSR_IA32_PL0_SSP (aka MSR_IA32_FRED_SSP0) is part of CET supervisor
+	 * state, but all four FRED SSP MSRs are architecturally visible on any
+	 * processor that enumerates FRED.  Even if CET is absent, these MSRs
+	 * remain accessible via RDMSR/WRMSR, though FRED transitions will not
+	 * use them.
+	 *
+	 * Intercept MSR_IA32_PL0_SSP if CET shadow stacks are unsupported (even
+	 * with FRED present).  Since this MSR is rarely accessed and ignored by
+	 * XSAVES in this configuration, interception avoids the overhead of
+	 * manually context switching the hardware MSR during vcpu_load/put.
+	 *
+	 * This behavior is consistent with the current setup in
+	 * vmx_recalc_msr_intercepts(), so no change is needed to the interception
+	 * logic for MSR_IA32_PL0_SSP.
+	 */
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, intercept);
+}
+
 static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	bool intercept;
@@ -4371,6 +4437,7 @@ static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	}
 
 	vmx_recalc_pmu_msr_intercepts(vcpu);
+	vmx_set_intercept_for_fred_msr(vcpu);
 
 	/*
 	 * x2APIC and LBR MSR intercepts are modified on-demand and cannot be
-- 
2.43.0

