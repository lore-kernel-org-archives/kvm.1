Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516231;
	b=CSfd6/R1/S94HC0pLF3YsvtW5D81JimmVamQYbLa1l79E9LOhT7uLyxE0nVmztDkn0gP
	 bjFWke217BQ1pWW87p4MuQ01G9XFZBxTYco0zCIkh7IO4dT6j0aGgE0HM/kMYSopa3xd2
	 MxEEmLe7CD0I4sNWn2dn7pBWVYvISPk57P4vzEiUup1By+png+V+lrHL5jttGsd0DqJSR
	 yMl39a0uZPv7IFO9pxL7P3MEGpTwTR3paM5Y46ye7rXzB8BMt6YCAZYZTNLG8XLaDJt0g
	 gOfZdRdh3UhYTlxSK4/dujoH5vGajc8XeQX6f5By571VqFXOzG7I50WY1srHLSNbhnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516231;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EAcQzPAw1+Psg8X+AZXVaCy3iCDXB7Wn8UKMK++nhag=;
	b=QCofRLY+oPUHXDbcJkMmpPrmZ9wAB/rW5PyPUhe3c/UJbg7QFk+n4psWjSDnGNT9HlJp
	 QzDfDlMDKOltmJYYdBlcLaXwDogtYXaRUKHZsVU7sLtZUU0VKzwuDX8l2KEtTNxHuakT0
	 Mr8kWFYhWWfIU5krQkmtXTZl9K/jmCX3eJ2/iKUBZW0/XC5MeB4isNMsL9GzNn4xtb8Yp
	 jwjt0Agvm7q3NI1qllLwNPl0B140nqnIUNeCGGGyBU5NBCsJDFF8aTIj5fY0G/nDZ/YDB
	 l9bgZzEgODmflDOBhd717Z+yjqJt2SYGhZAKmVImrWxQqaPFzpntJVrzbuI720jPrKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kobmeSUa;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926960A263E;
	Thu, 12 Nov 2026 20:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A926960A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kobmeSUa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516231; x=1826052231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vU925Ee9hxkymS6X0aRiMM8mK3SL+ft2IDusVEUbiLY=;
  b=kobmeSUawDR2v9lRu4Y1UNRnSSorHOlNjGz84N0v/EzXMj4tCZpsXY3s
   cRQuQIJSzYe73Hyos3mLv071nfOS+Q0ZovULxCPHSQ5OHM2FLkLXr0PFP
   bEx9H+SO2VG5VFZ596tZN+XZ6hcq3ONf9H2StW9lFTb7d4/uaH7u2uX7t
   TJ8/KEs2af+NBe9kQEwlCCFVHYfP1/jC8oByBhe0kd5unTLdwoA1hy1i9
   FCkiJCcpMAYsNjZmKGxLVfTENta4K5ID3TLGMC2RC/UMw7GViEHBXuPQ8
   GawB6Z/F5BB7wIDjofYn0/eH/e7xPUB903vcG7W+04Hio54PUT+TflWfb
   A==;
X-CSE-ConnectionGUID: qu6P+1llQKSDveI5LqH/qg==
X-CSE-MsgGUID: 5XWD/nQiR8CV7KRndp2Sdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192294"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192294"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:50 -0800
X-CSE-ConnectionGUID: qztbxu0NQgmSWYDnwkyQzw==
X-CSE-MsgGUID: L4SB/Py3QVOqDxzqUUKwQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087918"
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
Subject: [PATCH v4 14/21] KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_INUSE MSR
Date: Thu, 12 Nov 2026 13:32:20 -0700
Message-ID: <20261112203227.289379-15-zide.chen@intel.com>
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

Intel PerfMon v4 introduces IA32_PERF_GLOBAL_INUSE (0x392) to track
which counters and the PMI are currently claimed by software agents,
allowing independent software agents to check counter availability
without a shared scheduler arbitrating between them.

IA32_PERF_GLOBAL_INUSE is a read-only MSR, and any write attempt
results in a #GP. The MSR is not part of the VM state, so it does
not need to be advertised to userspace, nor saved and restored during
live migration.

Always intercept IA32_PERF_GLOBAL_INUSE to prevent the guest from
erroneously observing filtered fixed counters as idle.

Originally-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v4:
- Pass 'pmu' directly to kvm_for_each_{gp,fixed}_counter().

v3:
- Split from combined v2 patch into standalone GLOBAL_INUSE patch.
- Always intercept MSR_CORE_PERF_GLOBAL_INUSE. (Jim)
- Use '!!' for explicit boolean conversion. (Jim)
- Relocate PERF_GLOBAL_INUSE_PMI_INUSE to perf_event.h.
---
 arch/x86/include/asm/msr-index.h  |  1 +
 arch/x86/include/asm/perf_event.h |  3 +++
 arch/x86/kvm/vmx/pmu_intel.c      | 34 +++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 30cd04c0ace9..25dda50fbdc1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1242,6 +1242,7 @@
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
 #define MSR_CORE_PERF_GLOBAL_STATUS_SET	0x00000391
+#define MSR_CORE_PERF_GLOBAL_INUSE	0x00000392
 
 #define MSR_PERF_METRICS		0x00000329
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 17b0bc7dfce7..2937e8a27891 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -454,6 +454,9 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
 
+/* Intel IA32_PERF_GLOBAL_INUSE MSR */
+#define PERF_GLOBAL_INUSE_PMI_INUSE	BIT_ULL(63)
+
 #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index c18d24b5c385..5eac64ba8832 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -197,6 +197,7 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
 	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
+	case MSR_CORE_PERF_GLOBAL_INUSE:
 		return pmu->version >= 4;
 	case MSR_IA32_PEBS_ENABLE:
 		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
@@ -345,6 +346,36 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static u64 intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	bool pmi_inuse = false;
+	u64 eventsel, data = 0;
+	u32 fixed_ctrl;
+	int i;
+
+	kvm_for_each_gp_counter(i, pmu) {
+		eventsel = pmu->gp_counters[i].eventsel;
+
+		if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
+			data |= BIT_ULL(i);
+		pmi_inuse |= !!(eventsel & ARCH_PERFMON_EVENTSEL_INT);
+	}
+	kvm_for_each_fixed_counter(i, pmu) {
+		fixed_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
+
+		if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER))
+			data |= BIT_ULL(KVM_FIXED_PMC_BASE_IDX + i);
+		pmi_inuse |= !!(fixed_ctrl & INTEL_FIXED_0_ENABLE_PMI);
+	}
+	pmi_inuse |= pmu->pebs_enable;
+
+	if (pmi_inuse)
+		data |= PERF_GLOBAL_INUSE_PMI_INUSE;
+
+	return data;
+}
+
 static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -355,6 +386,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		break;
+	case MSR_CORE_PERF_GLOBAL_INUSE:
+		msr_info->data = intel_pmu_get_global_inuse(vcpu);
+		break;
 	case MSR_IA32_PEBS_ENABLE:
 		msr_info->data = pmu->pebs_enable;
 		break;
-- 
2.56.1

