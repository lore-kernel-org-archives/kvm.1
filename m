Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516230;
	b=wxjMOH/xX3LIqGAbR1+2d2fv7iVFWd7N2K17v8uSaDxqP+SbBiJW9yPhGdv5a75t/vz2
	 cO9K/QmEElldXTBowEAm2OvL2XmxPbRf7KSeq0JbRyvRW8neceBfFfGis5WG6+ZZsK7sp
	 h4+KF6GKxXtfuhiAuUovoYTzB9HXFAHtG3roQGNBIUkwO3X+5HQ6A65RIdD9KJfvmrzCx
	 2AOTgXaAlW4zq3zAhIX2qMCvHl+KHdDrXB6vztNIwUUoH46hWAXaM5wO0l6YlztvMOfaz
	 fYo/N6OZlj0iaA243cMT36uZ3SubQkKuRAgaUTL1AXZ7umyIJuJZEfdVXQOcWVOLLrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516230;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UzNzdRd0x/gC1vXrK7OIsILOVhuZjmbxPOEa7oijBv4=;
	b=knprx/RUFur/sgw3Z5qMsouycU5MWQsTUfNPjZ5JaFSnS2r59O1ylrB+d/FTPp8ipqwp
	 SbWJjRpX8lmKSLbWDKOUBOrVYEDAq5vYD7cWhxW8JiAurXwg0sn0J1vYRnLPDmt72Vowv
	 g5fhtoOtbQz9baUosXoRbe7vgftDuTfYraWVPh15vWUQY12zIxMuJogcizrCP7fYIFuTb
	 oJln2cgv3n+yXItmBG5wPxLZGmwl9Bvn4jiXo+6+rh9VtGLWONoRleQYGQCub7PorXW7/
	 Q/xY28QNi939RRN2rIxl6TGfiAF1bV/byUZLKhXra/eHN3apZGPJ40rJk5ujw9NyJpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=geMJm+jq;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5760A2629;
	Thu, 12 Nov 2026 20:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C5760A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=geMJm+jq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516230; x=1826052230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e18J8JIuiPEJfWRhb5zkP/Dr3OwsoPb5Az1+R4Fb8mg=;
  b=geMJm+jqQG4MwsbLbel6oNZl7Ui/RUF95ARMExWIU2VYhE4SQV6eiNmp
   A8hMPlgYHMqfAY0R6seb3sCwhj3CXERyR6hhV5+PS1gLUIURx73JUHgkB
   l6idGRC96c3v/bnO5MoJOu2j1NRdPjlYQ94lWm5Nxf4bK8uRCh8WQEoLu
   jsjfTlSv/ta2KupHtWgiTU8T6PjBiQNYY//e+rS7HMryYlbH7PR54o0xH
   4gYh8bFa6/T874ytrCTLRQ+6wp9TvYOilRgZt0GOcm4Yq7a4RdxUO7ME5
   PDwMtcVKP7suEmQ35zFBbhniHpYWN1oYYx/kZ0qoLK5DHi+Za0+oBQk/4
   Q==;
X-CSE-ConnectionGUID: iTZCbYqETCeFzrJ7BELRcA==
X-CSE-MsgGUID: 6aJFmd+ETPaqoB0wQpp16w==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192288"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192288"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:50 -0800
X-CSE-ConnectionGUID: 64noEFMjTHiYnLlpKWmXrg==
X-CSE-MsgGUID: /RtzGQzHRa+qSrrbacr6SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087913"
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
Subject: [PATCH v4 13/21] KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_STATUS_SET MSR
Date: Thu, 12 Nov 2026 13:32:19 -0700
Message-ID: <20261112203227.289379-14-zide.chen@intel.com>
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

Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
allow software to set individual bits in the global status MSR. Reads
of IA32_PERF_GLOBAL_STATUS_SET always return zero.

IA32_PERF_GLOBAL_STATUS_SET is not part of the VM state, so it doesn't
need to be advertised to userspace, nor saved and restored during live
migration.

Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent the guest from
modifying status bits that are not virtualized by KVM.

Bit 63 (CondChgd) is architecturally reserved in STATUS_SET per the SDM.
Reject writes to bit 63, injecting #GP for guest writes. While older
processors had silicon errata that accepted writes without #GP (e.g.
SKX95), strictly enforce the architectural specification for
deterministic behavior across migrations.

Originally-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- Split out CondChgd specific handling into a separate patch since it
  impacts MSR 0x38e and 0x390 as well.
- Move the defensive filtering code in pmu load to the new patch.
- Do not carry over Jim's Reviewed-by due to above changes.

v3:
- Split from combined v2 patch into standalone GLOBAL_STATUS_SET patch.
- Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent passthrough of
  unvirtualized status bits. (Jim)
- Reject writing bit 63 (CondChgd) to IA32_PERF_GLOBAL_STATUS_SET. (Jim)
- Filter out bit 63 before writing to hardware in
  intel_mediated_pmu_load().
- Store status set bits in a local variable in
  intel_mediated_pmu_load(). (Yosry)
- Move validation for MSR_CORE_PERF_GLOBAL_STATUS_SET to pmu_intel.c
  rather than common pmu.c to avoid exposing the Intel MSR on AMD.
---
 arch/x86/kvm/pmu.c           | 7 +++++++
 arch/x86/kvm/vmx/pmu_intel.c | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 7ba1a3b38184..bd5954e62080 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -855,6 +855,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
 		msr_info->data = 0;
 		break;
 	default:
@@ -923,6 +924,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated)
 			pmu->global_status &= ~data;
 		break;
+	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
+		if (data & pmu->global_status_rsvd)
+			return 1;
+		if (!msr_info->host_initiated)
+			pmu->global_status |= data;
+		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!msr_info->host_initiated)
 			pmu->global_status |= data & ~pmu->global_status_rsvd;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 4d05ec50f24f..c18d24b5c385 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -196,6 +196,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
+	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
+		return pmu->version >= 4;
 	case MSR_IA32_PEBS_ENABLE:
 		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
 		break;
-- 
2.56.1

