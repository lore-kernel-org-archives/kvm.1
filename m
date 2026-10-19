Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437309;
	b=IYgb8S25P1XtFQH2PzPObuFNeU6B1JHCPmGpTdqDDJy5f3cnvK2Yg1GrQMeMztMN2jNz
	 Q9KZfZ2uXwRQdHVSaYHWC3/mMYKq7YSJQHeSSE86XBLfwgCo613jtd7hRCPfMbCUepgsl
	 5lD/HFjIP6WyqAP8ZgKLaMTafROpw5A0cZkraDD4o2ckeCdwVr9DDOP5WW/I3/ClKFTw5
	 g/vr8tjajfyEnqGdsQVNCKs5wsAf4+XSPoErSdRlGhgbJC3b6zvlSUnFPtVM/S7o3XiDC
	 B1YvI1uDQprfp9zeURFsl/flMjaHyPbgOnx8QdkFZnCBACR7Cx06QkegvllzwTeI/Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437309;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rFOi8DF9otl7QSq9yN9Q1rig7a71rUpd/odhmx+OLmo=;
	b=39xE9vRizreGWRwKzMKmkARhwGDSUvhPd7W2n7efJT38LDaWC1Pinq3I36qv1wnPvBB7
	 fjnvvxDfvxsZGCMAPzPZt+1qwd2NHB3cuXRvHw4vQE9ToLajTmjCoY7J8EI/2M51egZWW
	 KdjbpX7LDRtmJGhzv4sj9YDyzCrIkj9EwzzkypaJ/N1hAnNwTb4amVQJ1JdzsAsxFtYBK
	 dCZhD6jdxtB5S5H/ZmVn+p0zwXu3uPKvenGWQ5BigTDhm8DdKFvVtr0UQeIvId8ouq4dD
	 tJLPLCFZCdHuuUlQKYe6puLGDKn3cS20zxHxkl4krpGqLVk6Dq1lqknYlDUBP+v4N9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZ20yDLX;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D6606A31B;
	Mon, 19 Oct 2026 19:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA2D6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZ20yDLX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792437309; x=1823973309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6eY0X/AE+MaCXxfTIcBVpl37SW1NNYBffDDp97xe7PE=;
  b=EZ20yDLXD+7RHJf26QwxMpEUBcS9QYPJ01fmZMQwsJ+hD0iI32L+yk30
   bYUBnVU765Vf+k5X2f7XELMdQDXTEc8OPLurEYDBFzsh4QmwgBKVyJ4DI
   TELwvOSALXP2Dv5cg0fbRJmNPl+98Se/+fNqU7447VYPSAyr4Td8sbuca
   BXUvM76v3o8DbdEb8MthhlD0ouMifWAf1JeAAh/kBKQXduBCBlEKuf551
   gV5Z3F/GONYZdvWUgL0gFD5Vb9m0r1uVrcCqLKQO9OvHEhKyy9aL1urUt
   SZZwk2K/iQeGyhR/RYVd8hfZgRXlhKGy1f5+b10l2IeOyEAXS1YZe+Wxl
   w==;
X-CSE-ConnectionGUID: 1DsutZt/RqCb4jMxsZwPwg==
X-CSE-MsgGUID: eT4GuLBNQoG8e23+np7Ysw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1144129"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1144129"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:15:08 -0700
X-CSE-ConnectionGUID: bcwaIiXyRXWlbu6WaVle6w==
X-CSE-MsgGUID: 8K6XFerOTuCcG9L7RO3GmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2595531"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:15:07 -0700
Message-ID: <354ca46e-7038-4a78-a248-6e2f60c23601@intel.com>
Date: Mon, 19 Oct 2026 14:15:06 -0500
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: x86/pmu: Add mediated vPMU PerfMon v5 support
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sean,

Friendly ping on this series. The v2 addresses all of your feedback from
the v1 review. I'd appreciate your thoughts whenever you have some cycles.

For context, it would be ideal to land this vPMU v5 series before my
other series to keep the stack clean:

1. PMU Partitioning:
https://lore.kernel.org/kvm/20260821222002.54907-1-zide.chen@intel.com/T/#t
2. TMA:
https://lore.kernel.org/kvm/20260817183143.226156-1-zide.chen@intel.com/

Thanks,
Zide


On 8/27/2026 5:37 PM, Zide Chen wrote:
> KVM currently caps the guest Intel architectural PMU version at 2. This
> series bumps it to PerfMon v5 and adds support for some features that
> are introduced in PerfMon v3-v5.
> 
> - CPUID.0AH:ECX fixed-counter bitmap (v5): supersedes EDX[4:0] and
>   lets KVM/guests represent non-contiguous fixed counters (e.g. some
>   E-core server parts skip fixed counter 3).
> - Add support for IA32_PERF_GLOBAL_STATUS_SET (v4): lets software set
>   individual bits in the global status MSR.
> - Add support for IA32_PERF_GLOBAL_INUSE (v4): reports which counters
>   and PMI are currently claimed.
> - Implement ANYTHREAD_DEPRECATION capability.
> 
> Intel PerfMon v5 doesn't support non-contiguous GP counters; however,
> this series lays the groundwork for GP counter bitmap support anyway,
> for consistency with the host perf API interface, and prepares for
> Perfmon Masking support.
> 
> Freeze_PerfMon_On_PMI virtualization is not implemented because, as
> commit 3daa96d67274 ("perf/intel: Remove Perfmon-v4 counter_freezing
> support") states, the Freeze-on-PMI mechanism violates the perf counter
> independence.
> 
> Streamlined Freeze_LBRs_On_PMI is not implemented because LBR is not
> yet supported on mediated vPMU.
> 
> Tested on SPR and CWF:
> 
> - Ran "perf test" on both L0 and L1; no issues attributable to this
>   series have been observed so far.
> 
> - Ran KVM selftests on both L0 and L1.
> 
> - Passed AnyThread tests on both fixed and gp counters:
>   $ perf stat -e r20003c,r2000c4,r2000c0 -- sleep 1
> 
> - Tested various guest fixed-counter configurations:
>       CPUID.0AH:ECX = 0x7   CPUID.0AH:EDX[4:0]=3
>       CPUID.0AH:ECX = 0x2   CPUID.0AH:EDX[4:0]=0
>       CPUID.0AH:ECX = 0x6   CPUID.0AH:EDX[4:0]=0
>       CPUID.0AH:ECX = 0x5   CPUID.0AH:EDX[4:0]=1
>       CPUID.0AH:ECX = 0x0   CPUID.0AH:EDX[4:0]=0
> 
>   Verified that the guest PMU reflected the configured fixed-counter
>   and that the following command used fixed or general-purpose counters
>   as expected:
> 
>   $ perf stat -e instructions,cpu-cycles,ref-cycles -- sleep 1
> 
> - Manually tested IA32_PERF_GLOBAL_INUSE.
> 
> - Ran some additional perf tests on both L0 and L1.
> 
> - Sanity testing on nested VMs.
> 
> Patch series summary:
> patch 1-4: Code cleanup and a fix.
> patch 5-10: Implement PMC bitmap support.
> patch 11-14: Implement PerfMon v3-v5 new features.
> patch 15: Advertise PerfMon version up to v5.
> patch 16: Fix pmu_counters_test selftests fixed counter test case.
> 
> Rebased to kvm-x86/next: 76671054f9a1
> 
> v2 changes:
> - Dropped v1 11/15: KVM: x86/pmu: Emulate streamlined Freeze-LBR-on-PMI
> - New patch 4/15 to gate BUFFER_OVF reserved bit on guest DS feature.
> - Some renames:
>   - all_valid_pmc_mask to pmc_exists;
>   - add _is to kvm_{gp,fixed}_pmc_supported();
>   - split kvm_for_each_set_pmc_idx() to kvm_for_each_{gp,fixed}_counter().
> - Add missing AnyThr handling in IA32_FIXED_CTR_CTRL and advertise
>   anythread_deprecated only if kvm_pmu_cap.version >= 5.
> - Cap vPMU v3/v4 to v2, as AnyThread cannot be safely virtualized.
> - Miscellaneous updates to changelogs and some minor fixes.
> 
> Dapeng Mi (6):
>   KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters from kvm_pmu
>   perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
>   KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
>   perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
>   KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
>   KVM: selftests: Support fixed counters bitmap in pmu_counters_test
> 
> Zide Chen (10):
>   KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions
>   KVM: x86/pmu: Rename all_valid_pmc_idx to pmc_exists
>   KVM: x86/pmu: Rename reserved_bits to eventsel_rsvd in kvm_pmu
>   KVM: x86/pmu: Gate BUFFER_OVF reserved bit on guest DS
>   KVM: x86/pmu: Add PMC bitmap accessor helpers
>   KVM: x86/pmu: Expose kvm_host_pmu to vendor modules
>   KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and GLOBAL_INUSE MSRs
>   KVM: x86/pmu: Populate CPUID.0AH:ECX fixed-counter bitmap
>   KVM: x86/pmu: Factor out fixed counter control bit calculation
>   KVM: x86/pmu: Ignore AnyThread bit if CPUID.0AH:EDX[15] is set
> 
>  arch/x86/events/core.c                        |   8 +-
>  arch/x86/include/asm/kvm_host.h               |   9 +-
>  arch/x86/include/asm/msr-index.h              |  12 +-
>  arch/x86/include/asm/perf_event.h             |  10 +-
>  arch/x86/kvm/cpuid.c                          |  21 ++-
>  arch/x86/kvm/msrs.c                           |  12 +-
>  arch/x86/kvm/pmu.c                            |  85 ++++++---
>  arch/x86/kvm/pmu.h                            |  54 +++++-
>  arch/x86/kvm/svm/pmu.c                        |  37 ++--
>  arch/x86/kvm/svm/svm.c                        |  17 +-
>  arch/x86/kvm/vmx/nested.c                     |   8 +-
>  arch/x86/kvm/vmx/pmu_intel.c                  | 167 +++++++++++++-----
>  arch/x86/kvm/vmx/vmx.c                        |  19 +-
>  .../selftests/kvm/include/x86/processor.h     |   6 +-
>  .../selftests/kvm/x86/pmu_counters_test.c     |  26 ++-
>  15 files changed, 349 insertions(+), 142 deletions(-)
> 

