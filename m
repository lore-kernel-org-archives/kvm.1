Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2D3B71B6;
	Wed, 26 Aug 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730731; cv=none; b=DxhpGHS7bd+ijKsCHbIbbEJWu1Sk5tUGv2zwCLAHm1QljP5qXY4fhgqmv5bio/TYkmVaQDCC3Qk0yd+P4IPph86wjVf2QJegbg8xTxRg+vrVnFgWtcxSg5rWVXAjm7j6an/6urgY/XtOVGBiWYJaDLPs9vpcJb2renzsQ89OJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730731; c=relaxed/simple;
	bh=0fGJfOEtc8czz6EdZoluX714QPBncmSm4CCN+XdiM2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejDZBxoibgmapm/LFl6IFBnweiq1gM5phY769vAi0qj+8Ei/Rn+5/w1Ue9T/TdnYwBBmPz5LUAiaJkFeccWbhD3wBNs5opbNftCHfhlMFe8Cyj2kBRyCvR43ZXem+fARCctmP2ou1KPbCQdPmdkHl3Jb2a+cRjoj6K8rWAKVlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBn3ofuq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBn3ofuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787730729; x=1819266729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0fGJfOEtc8czz6EdZoluX714QPBncmSm4CCN+XdiM2E=;
  b=gBn3ofuqdvr+XtC14zPQN9MTT1jozE9GVBK1l54V+jVgOa1igp9e/tBN
   vgYQuDDoT4HbuIYTyiSxa02jCLRQOe/WcY6OFoY6TZEar1fgVBIbh5NIh
   +AWpbDJUnEa1jSn7iR3THsxcWC6u7W36Q3qV0iceiqJMBqSSPU7LAvAs2
   FfljtvQfbzrFYhyOqF0nKXWlu/hj/raVB0bmgFcyIq6eTPmxCtDuj03+x
   KkfI2ZYm6+127H45Ecm40jLFnIJKeukECEBv2+BO0zXRIREfk9Qt1OmKB
   uYmmt54L4xC4/2ByuAeuwgyNYpPHeCXO2Vppr3Ab+Lt6mgqZ3sABLGAYN
   A==;
X-CSE-ConnectionGUID: vZF1SUiGSVOfrJjaVAGSFw==
X-CSE-MsgGUID: uxHctUuERv2kvN/0Eluqog==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="105731314"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="105731314"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:52:08 -0700
X-CSE-ConnectionGUID: nehh6uUATfGEzUVOsRyW8w==
X-CSE-MsgGUID: kVHuJNhETlCbPnpmXenRrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="267528551"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:52:05 -0700
Message-ID: <78327226-45f4-460f-b6ab-eb00fed3b9f8@linux.intel.com>
Date: Wed, 26 Aug 2026 15:52:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] perf/KVM: Support PMU partitioning for x86
 platforms
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/22/2026 6:19 AM, Zide Chen wrote:
> Introduction
> ============
>
> PMU partitioning allows a VMM to assign a subset of PMU resources to a
> guest while retaining the remainder for host use, enabling concurrent
> host and guest PMU usage while the guest is running.
>
> Intel PerfMon masking provides architectural support for PMU
> partitioning. This VMX extension provides fine-grained, bit-level
> control over global PerfMon MSRs and RDPMC, allowing a guest to
> natively access PMU resources while hardware ensures that guest
> accesses cannot affect host-owned resources. This eliminates the need
> to intercept those accesses for PMU isolation.
>
> The feature is enumerated by IA32_VMX_PROCBASED_CTLS3[17] and enabled
> via the new PerfMon masking VM-execution control in tertiary
> processor-based VM-execution controls.
>
> A new 64-bit VMCS field, PERFMON_MASK (encoding 0x2054/0x2055), defines
> the guest-owned PMU resources. The mask follows the
> IA32_PERF_GLOBAL_STATUS bit layout.
>
> When enabled, hardware enforces guest access to selected PerfMon MSRs
> and RDPMC according to PERFMON_MASK, reducing the need for software
> emulation and interception.
>
> The full description of PerfMon masking can be found at Intel ISA,
> 319433-062 [1]. Diamond Rapids is the first platform to support this
> feature.
>
> Design
> ======
>
> 1. KVM
>
> This series builds PMU partitioning on top of the mediated vPMU, which
> allows guest access to PerfMon MSRs without emulation, making it a
> natural foundation for PerfMon masking.
>
> A new Intel-specific KVM module parameter, perfmon_mask, defines the
> host-wide PMU partition. The mask uses the PERFMON_MASK VMCS encoding,
> where set bits identify guest-owned PMU resources and cleared bits
> identify host-owned resources. The setting is shared by all mediated
> vPMU guests on the host.
>
> KVM constrains its PMU capability based on the perfmon_mask parameter,
> so only minimal additional changes are needed to manage PMU capability
> advertisement and MSR emulation.
>
> Upon VMX transition, unlike the non-partitioned mediated vPMU, KVM
> always preserves the host-owned bits in the global MSRs.
>
> This series does not yet implement the full PerfMon masking software
> guideline in section 10.5 of [1]. For example, the RELOAD_{PMCx,FIXED_CTRx}
> and IA32_PMC_GPn_CFG_{A,B,C} MSRs are not yet supported by KVM.
>
> 2. perf core
>
> The perf scheduler is taught to honor the PMU partition mask:
>
> - Loading guest context: reschedule system-wide events onto host-owned
>   counters.
> - Putting guest context: schedule out system-wide events before
>   rescheduling in so that they can be scheduled on now more available
>   counters.
> - In guest context, don't schedule in exclude_guest events, but allow
>   !exclude_guest to be scheduled in.
>
> As a current limitation, !exclude_guest events that rely on exclusive
> PMU facilities (e.g. Intel PT, LBR, or PEBS) are not supported under PMU
> partitioning and are rejected.

Hmm, scheduling events on each vmx transaction (especially twice events
scheduling) would introduce performance overhead. Strictly speaking,
current design looks like a dynamic PMU partition, host events can be
scheduled to the counters which are allocated to guest in root mode.

It's fine on functionality, but I'm not sure how much benefits can be
gotten from the host events rescheduling on each vmx transaction by paying
such performance penalty. According to what I know, most scenarios could
only need 1 or 2 monitor events on host and it would be good enough to keep
1 or 2 counters for host. In such case, the events scheduling on each vmx
transaction becomes unnecessary.

An alternative way is statically separate the PMU counters for host and
guest, e.g. host occupies the counters 0 and 1, and guest has the left
counters 2 - 7. Host events can only be scheduled on events 0 or 1 and
guest events own the counters 2 -7. In this way, the host events scheduling
can be  thoroughly eliminated and the whole design and implementation can
become simpler. 

Thanks.


>
> 3. perf/x86
>
> Apply PMU partitioning constraints to PMC allocation: while a
> partitioned guest is running, guest-owned counters are reserved for
> guest use and are unavailable to host event scheduling. Outside
> guest execution, all counters remain available to the host.
>
> In PMI handling in guest mode, handle only the host-owned bits that
> are set in IA32_PERF_GLOBAL_STATUS, and leave the guest-owned bits
> for KVM.
>
> 4. PMI design
>
> Unlike mediated vPMU, PMU partitioning does not switch LVTPC to a
> dedicated guest PMI vector. Host-owned counters remain active while the
> guest is running and may trigger PMIs.
>
> PMIs therefore remain routed through the host NMI handler. PMI handling
> is split: host-induced counter overflows are handled by the host perf
> NMI handler as usual, while guest-induced overflows are left pending
> and KVM injects the corresponding PMI into the guest.
>
> Related Work
> ============
>
> ARM's PMU Partitioning series [2] solves a similar problem. It relies
> on MDCR_EL2.HPMN to enforce the host/guest counter boundary and lets
> the guest access its counters without trapping.
>
> Similar to the perfmon_mask parameter, ARM's series has a module
> parameter, reserved_host_counters, that defines the maximum number of
> guest counters; userspace VMMs may then configure a smaller number of
> counters for each guest, up to that host-wide maximum.
>
> Probably the biggest difference is that ARM's series chooses to
> context-switch guest/host PMU state only at vcpu_{load,put}(), and
> evict host events from would-be guest-owned counters if needed, while
> this series continues the mediated vPMU design and performs it on
> every VM-entry/VM-exit.
>
> Also, while a guest is running, this series allows host events to be
> scheduled on exactly the complement of the effective guest counter
> mask, whereas ARM's series uses the single, global
> reserved_host_counters value, regardless of how many counters any
> given guest is actually using.
>
> Tests
> =====
>
> Tested in the engineering environment with various perfmon_mask
> configurations.
>
> 1. Passed KVM selftests on L0 and L1.
>
> 2. No issues related to PMU partitioning were found by `perf test` running
>   on L0 and L1.
>
> 3. Host exclude_guest events do not count non-root activity:
>   # The following host command reports similar counts with or without
>   # guest workloads.
>   $ perf stat -e instructions:H,cycles:H,branches:H -a -I 1000
>
> 4. Host system-wide !exclude_guest events count non-root activity.
>   # The following host command captures counts generated by guest
>   # workloads.
>   $ perf stat -e instructions:HG,cycles:HG,branches:HG -a -I 1000
>
> 5. Put test 3 and 4 together.
>   # Guest idle.
>   $ stat -C 1 -e cycles:GH,instructions:G,branches:H -a
>   Performance counter stats for 'system wide':
>
>        113,933,309      cycles:GH              (100.00%)
>        135,454,451      instructions:G         (100.00%)
>         26,966,970      branches:H
>
>        1.959020017 seconds time elapsed
>
>   # Ran sysbench on the guest.
>   $ stat -C 1 -e cycles:GH,instructions:G,branches:H -a
>   Performance counter stats for 'system wide':
>
>      5,012,158,432      cycles:GH              (99.94%)
>      5,468,621,724      instructions:G         (99.94%)
>         26,654,821      branches:H
>
>        1.948625192 seconds time elapsed
>
> 6. Host system-wide !exclude_guest sampling events observe guest-induced
>   PMIs.
>   # When running a guest workload with a known PMI rate, the following
>   # host command captures the corresponding overflow activity.
>
>   # Guest idle.
>   $ perf record -e instructions:H,cycles:HG,branches:HG -c 1000000 -a -- sleep 10
>   [ perf record: Captured and wrote 0.322 MB perf.data (1432 samples) ]
>               SAMPLE events:       1432  (30.4%)
>               SAMPLE events:        730
>               SAMPLE events:        549
>               SAMPLE events:        153
>
>   # Independantly ran workload on the guest to know the expected PMIs.
>   $ perf record -e instructions,cycles,branches -c1000000 tchain_edit
>   [ perf record: Captured and wrote 0.176 MB perf.data (4536 samples) ]
>               SAMPLE events:       4536  (99.0%)
>               SAMPLE events:       2037
>               SAMPLE events:       1821
>               SAMPLE events:        678
>
>   # Profile this on host again while ran tchain_edit on the guest.
>   $ perf record -e instructions:H,cycles:HG,branches:HG -c 1000000 -a -- sleep 10
>   [ perf record: Captured and wrote 0.433 MB perf.data (3959 samples) ]
>               SAMPLE events:       3959  (55.0%)
>               SAMPLE events:        762
>               SAMPLE events:       2362
>               SAMPLE events:        835
>
> 7. Perf Metrics tests.
>   # If perf_metrics is assigned to the guests, guests can run slots and
>   # metrics events. Host exclude_host slots and metrics events are not
>   # scheduled in non-root mode.
>   $ perf stat -e '{topdown-bad-spec,topdown-retiring,topdown-be-bound,slots}:G' -a --sleep 1
>    Performance counter stats for 'system wide':
>
>                  0      slots                  (18.11%)
>                  0      topdown-bad-spec       (18.11%)
>                  0      topdown-retiring       (18.11%)
>                  0      topdown-be-bound       (18.11%)
>
>        1.001590434 seconds time elapsed
>
>   # Same events run on the host if perf_metrics is not assigned to the
>   # guests. 
>   $ perf stat -e '{topdown-bad-spec,topdown-retiring,topdown-be-bound,slots}:G' -a --sleep 1
>    Performance counter stats for 'system wide':
>
>         14,632,663      slots                  (100.00%)
>            918,127      topdown-bad-spec       (100.00%)
>          1,319,808      topdown-retiring       (100.00%)
>          3,514,335      topdown-be-bound       (100.00%)
>
>        1.001938038 seconds time elapsed
>
> 8. Some other sanity tests.
>
> Patch Summary
> =============
> 1. perf/x86 core enablement (patches 1-8)
>    Introduce guest-state tracking, host/guest PMI splitting, and the
>    counter/event constraints the mask depends on.
>
> 2. perf core scheduling (patches 9-11)
>    Propagate the partition mask into mediated-PMU VMs and teach the
>    generic perf scheduler to honor it when loading/putting guest
>    context.
>
> 3. KVM PerfMon masking (patches 12-20)
>    perfmon_mask module parameter, PERFMON_MASK VMCS setup, MSR
>    intercept relaxation, and GLOBAL_CTRL/GLOBAL_STATUS/GLOBAL_INUSE
>    handling for the mediated vPMU under PerfMon masking.
>
> 4. Enablement (patch 21)
>    Turn on PerfMon masking on supported Intel platforms.
>
> 5. Selftests (patches 22-23)
>
> Many thanks to Kan Liang for the original PerfMon masking design, Andi
> Kleen for his guidance, and Dapeng Mi for the many discussions,
> reviews, and suggestions that helped shape this series.
>
> Rebased to kvm-x86/next: 1b731e5ded48
> Thie series depends on the PMU v5 series [3] and Topdown metrics series [4].
>
> Code also available at [5].
>
> [1]: https://www.intel.com/content/www/us/en/content-details/922690/intel-architecture-instruction-set-extensions-programming-reference.html
> [2]: https://lore.kernel.org/lkml/20260612192909.1153907-1-coltonlewis@google.com/T/
> [3]: https://lore.kernel.org/kvm/20260707183405.15571-1-zide.chen@intel.com/
> [4]: https://lore.kernel.org/kvm/20260817183143.226156-1-zide.chen@intel.com/
> [5]: https://github.com/ZideChen0/linux-kernel/tree/pmu_partitioning_v1
>
> Kan Liang (3):
>   perf/x86: Restrict !exclude_guest events to host-owned counters
>   perf: Skip exclude_guest events on PMU partitioned counters
>   perf: Reschedule events across PMU partition transitions
>
> Zide Chen (20):
>   perf/x86/intel: Guard counter masks against zero counters
>   perf, perf/x86: Pass partition mask from KVM to perf/x86
>   perf/x86: Add GUEST_PMU states for PMU partitioning
>   perf/x86: Split host/guest PMI handling under PMU partitioning
>   perf/x86: Allow exclude_host events to run in non-root mode
>   perf/x86: Apply PMU partition mask on static constraints
>   perf/x86: Export available PMU counters to sysfs
>   perf, perf/x86: Allow host !exclude_guest events in PMU partitioning
>   KVM: x86/pmu: Add the perfmon_mask module parameter
>   KVM: x86/pmu: Set up the PERFMON_MASK VMCS field
>   KVM: x86/pmu, perf/x86: Update effective PMU partition mask
>   KVM: x86/pmu: Relax MSR intercept policy under PerfMon masking
>   KVM: x86/pmu: Handle FIXED_CTR_CTRL under PerfMon masking
>   KVM: x86/pmu: Handle GLOBAL_CTRL under PerfMon masking
>   KVM: x86/pmu: Handle GLOBAL_STATUS MSRs under PerfMon masking
>   KVM: x86/pmu: Always intercept GLOBAL_INUSE under PerfMon masking
>   KVM: x86/pmu: Request guest PMI for guest-induced PMIs
>   KVM: x86/pmu: Enable PerfMon masking
>   KVM: selftests: Fix PERF_METRICS test by checking FC3 availability
>   KVM: selftests: Allow no general purpose counters on the host
>
>  .../sysfs-bus-event_source-devices-caps       |   5 +
>  .../admin-guide/kernel-parameters.txt         |  30 +++
>  arch/x86/events/core.c                        | 227 +++++++++++++++++-
>  arch/x86/events/intel/core.c                  | 185 ++++++++++++--
>  arch/x86/events/perf_event.h                  |  20 ++
>  arch/x86/include/asm/kvm_host.h               |   1 +
>  arch/x86/include/asm/perf_event.h             |   3 +
>  arch/x86/include/asm/vmx.h                    |   3 +
>  arch/x86/include/asm/vmxfeatures.h            |   1 +
>  arch/x86/kvm/pmu.c                            |  53 +++-
>  arch/x86/kvm/pmu.h                            |  13 +-
>  arch/x86/kvm/svm/pmu.c                        |   2 +-
>  arch/x86/kvm/vmx/capabilities.h               |   6 +
>  arch/x86/kvm/vmx/pmu_intel.c                  | 206 +++++++++++++++-
>  arch/x86/kvm/vmx/vmx.c                        |  86 ++++++-
>  arch/x86/kvm/vmx/vmx.h                        |   3 +-
>  arch/x86/kvm/x86.c                            |   6 +-
>  include/linux/perf_event.h                    |   8 +-
>  kernel/events/core.c                          | 122 ++++++++--
>  .../selftests/kvm/x86/pmu_counters_test.c     |  29 ++-
>  20 files changed, 929 insertions(+), 80 deletions(-)
