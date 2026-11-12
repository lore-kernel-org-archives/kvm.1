Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516230;
	b=Lj2g+qhOGA2i3R/WFM8/40xuAhM2PCDKA+Y0vdyndLAeuXFxFNoIyC6SM3rKRaJwDhR1
	 aLJu4Xb+X5wiVVTOEO4ujXcUiS8c/3hHZBovJU0fD/3lZ1trl+kfmFVmcysskUSYsQVLu
	 +ivR3AMLBq2Qqh2gEAAROUN0fV/DZuNmFJVkT+kI/vbYQl8h5Bpb+G3y4smOpSPMztWIv
	 aNiQpiVacOTXkr5LJRff92kgStLXfZru1MaCm7fn3lCXehUd4Ky1DJaaMR69Z+SVMtD1o
	 5t7W4J40bcgWgPI78WyRFGFVO/HsEIGCMskWQKkxlFQqYzNFBsRzgo7RXmxQmqyLY8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516230;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tJtGwxlkvnCiaAgjXp2HfJ7oN+3Ko6t9SZ5kHfwB+58=;
	b=2JND5nYI0EVhp+Do6h0RNqpTvrO6YZx8M46BFuOsElUXailpcSRnwo6gaa2mcz4OCicZ
	 tB7Snl1zR72wxkaYiV9unjLilX/7yGXpbk8bUK27I7prXwxSZINZ80x/RfU/ltuoAx7+d
	 VtgHl5vmSticlPVA7HYWVwYIi+zPqVxfTdI9DG6AabmdhjRiB0napD2K/vV0stjxNfFj/
	 bhkzJ1c1TfyyaHPkmi+MfiGQipN4rG+o60BSx+vZZOJHQLH8tITexf/9YI6GWbSfIQuv9
	 guQTIqomSdZIUORcARZwbhPZsUDRYnGUMafq1TVQft6Mro8xVvOI3Gclyw8tDMugfxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KbZbsY4J;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3660A2621;
	Thu, 12 Nov 2026 20:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BE3660A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KbZbsY4J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516230; x=1826052230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nm1dnRpER6X3/B6Ifmu7LAOCzhALKnNJNQi710JTm+U=;
  b=KbZbsY4J/JPBrD2AnL08cuP+kHZlbD+3gCAKoS0IZQRo+zXshFuTNqcI
   ASs7cX71g6c/JLBLoCL4+0I53cD4/MY1p7PFubfHU6CavA7ZWl+xhhYBw
   Od4bh/ZQGF07ErYvcS8M54zoLdkwaAE3jTv38eShfV6Jzy7k0rS/PhsY1
   6Jkwzvn0ECATo8FNsBUK0J/lOOVGqsTMXVcWNbOMw/2CJInHAKVWEjjMT
   adir3EJHHTFavExD80o6jbD5jJ1k45Z27nJkbAb3uEDnyqW1XtltKmXaV
   yyA6eJt7fHBH/58rRTC5YcOcR6Gf/XFGXhh2OwANoTsWJMZxkDDdyN0XN
   w==;
X-CSE-ConnectionGUID: UHADJw8+QbGLTceuma/HHQ==
X-CSE-MsgGUID: YJbZUBT1Q4qYChT1JgNjNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192282"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192282"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:50 -0800
X-CSE-ConnectionGUID: awNh9yAeQYOb6YeiqqbsGQ==
X-CSE-MsgGUID: 400CiIdYQAu0ay+fLK0rkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087909"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:50 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v4 12/21] KVM: x86/pmu: Mark CondChgd reserved in global_status_rsvd
Date: Thu, 12 Nov 2026 13:32:18 -0700
Message-ID: <20261112203227.289379-13-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
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

Bit 63 (CondChgd) of IA32_PERF_GLOBAL_STATUS indicates a change to
IA32_MISC_ENABLE[7], which KVM intercepts and keeps read-only for
guests.

In the Intel SDM, there is an asymmetry regarding bit 63: it is valid
in IA32_PERF_GLOBAL_STATUS_{,RESET}, but it is architecturally
reserved in IA32_PERF_GLOBAL_STATUS_SET. Consequently, KVM cannot
restore bit 63 to hardware on vPMU context switch.

Fortunately, because KVM intercepts IA32_MISC_ENABLE and keeps it
read-only for guests, neither hardware nor KVM will ever assert
CondChgd for the guest. It is therefore safe to not virtualize
CondChgd while maintaining architectural consistency.

Mark CondChgd reserved in pmu->global_status_rsvd so that userspace
writes to IA32_PERF_GLOBAL_STATUS, and upcoming emulation of
IA32_PERF_GLOBAL_STATUS_SET, reject bit 63.

Clearing CondChgd via IA32_PERF_GLOBAL_STATUS_RESET (0x390, a.k.a.
GLOBAL_OVF_CTRL) is architecturally valid per the Intel SDM, so
explicitly allow bit 63 to be cleared without #GP.

Additionally, in mediated PMU mode, defensively mask out reserved bits
in intel_mediated_pmu_load() before writing to
IA32_PERF_GLOBAL_STATUS_SET to prevent a host #GP.

Reported-by: Jim Mattson <jmattson@google.com>
Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- New prep patch to mark CondChgd reserved in global_status_rsvd (suggested
  by Yosry), addressing the STATUS_SET bit 63 asymmetry identified by Jim.
  (Jim, Yosry)
---
 arch/x86/kvm/pmu.c           |  8 +++++---
 arch/x86/kvm/vmx/pmu_intel.c | 11 +++++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e1999a6c85d7..7ba1a3b38184 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -911,10 +911,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 		/*
-		 * GLOBAL_OVF_CTRL, a.k.a. GLOBAL STATUS_RESET, clears bits in
-		 * GLOBAL_STATUS, and so the set of reserved bits is the same.
+		 * GLOBAL_OVF_CTRL, a.k.a. GLOBAL_STATUS_RESET, clears bits in
+		 * GLOBAL_STATUS.  CondChgd is not virtualized by KVM and is
+		 * reserved in global_status_rsvd, but clearing it via
+		 * GLOBAL_OVF_CTRL is architecturally valid per the SDM.
 		 */
-		if (data & pmu->global_status_rsvd)
+		if (data & (pmu->global_status_rsvd & ~GLOBAL_STATUS_COND_CHG))
 			return 1;
 		fallthrough;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a240b74ac704..4d05ec50f24f 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -603,7 +603,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->global_ctrl_rsvd = counter_rsvd;
 
 	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
-			& ~(GLOBAL_STATUS_BUFFER_OVF | GLOBAL_STATUS_COND_CHG);
+			& ~GLOBAL_STATUS_BUFFER_OVF;
 	if (vmx_pt_mode_is_host_guest())
 		pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;
 
@@ -818,14 +818,17 @@ static void intel_pmu_write_global_ctrl(u64 global_ctrl)
 static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	u64 global_status, toggle;
+	u64 global_status, toggle, set_bits;
 
 	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
 	toggle = pmu->global_status ^ global_status;
 	if (global_status & toggle)
 		wrmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
-	if (pmu->global_status & toggle)
-		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
+
+	/* Defensively mask reserved bits to prevent a host #GP. */
+	set_bits = (pmu->global_status & toggle) & ~pmu->global_status_rsvd;
+	if (set_bits)
+		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET, set_bits);
 
 	wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
 }
-- 
2.56.1

