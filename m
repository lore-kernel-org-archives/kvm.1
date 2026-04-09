Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AF30C63A;
	Thu,  9 Apr 2026 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715938; cv=none; b=qeflq1gpLyvlYNXjwNaXddKqneHfRGBgMbtGT4dBfM05Tqdwc2xvIpzQ0SwuvkZOOS/7GzZ5zjvOxQAq9uyzCK9WvtvrS1vHruq0FSBDJQ+cWe43VvAlLxRvXV2vfmrLbsyZGoGd6JyyW4K1+xkw0+6Khj5Vi7J87kHEcvp04v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715938; c=relaxed/simple;
	bh=/2qdkrzLz9bytCshgxxZhSh4YAak+4TJvSNUdfcmXCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCzcao0WhaODOHPGDAKr+hZXFsGoUmLEUd9MpURnG9+orITmjkLRceA99GKBQKp9sqGNTGeylZAZk1Dq7x5nsMKKnQD0jfwV7R7f0MgtPN3GzJCEi2E4XJ7mpqtjJSwZCXhMEf+Pf/J4/QuXfR+StX3HB8HRlzLKwHx0+nuDSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxWxIcDg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxWxIcDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775715936; x=1807251936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/2qdkrzLz9bytCshgxxZhSh4YAak+4TJvSNUdfcmXCI=;
  b=gxWxIcDgULTEBOuU3y4DnEq08tU9d93XTZdFHde/hR9udqA2wtQ2tqwZ
   i+LCSi40rn7bkGyAQfxBRBEapvjVTfJEt6Jeth18wMYGFt1CK5rmNLYE2
   LenxjGvVBFabmhoVA626Q47ZC9deMilse/YCVZADnzAhSygVg2mdo7EnH
   AJjJBs/Oj4/oN+uGwhJNZ0YsMRtwK5ZB3mulJgkOoBQAjc9vIFqp/UtQ0
   Bti74CWr3HqtetR4tUPatGUtfBHVM+7rnbDF9hC+XC8pNqQYBTZXl1z04
   E9GD6xDkkMSr4cxQi0V5ND/0zO3Ftev9KEjsPiZaKSEtOZaGxN0FV75fa
   A==;
X-CSE-ConnectionGUID: BeSp4/QsRKKyukituZteNg==
X-CSE-MsgGUID: qi6/ZU5LTam+7dDrnXxSCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87789986"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="87789986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 23:25:35 -0700
X-CSE-ConnectionGUID: fY8cDOE+QHO2k9SqDO1UQg==
X-CSE-MsgGUID: sMukncntS5SgtVPH1/RSrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="224377242"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 23:25:33 -0700
Message-ID: <6a4471fd-d7da-4a3c-aa2b-5925e033c6b9@linux.intel.com>
Date: Thu, 9 Apr 2026 14:25:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] KVM: x86/pmu: Add hardware Topdown metrics support
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260226230606.146532-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260226230606.146532-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Zide, it seems currently there is no KVM/selftests to cover the fixed
counter 3 and the topdown metrics support. We could enhance current PMU
selftest or add a new selftest to cover this case. Thanks.

On 2/27/2026 7:06 AM, Zide Chen wrote:
> The Top-Down Microarchitecture Analysis (TMA) method is a structured
> approach for identifying performance bottlenecks in out-of-order
> processors.
>
> Currently, guests support the TMA method by collecting Topdown events
> using GP counters, which may trigger multiplexing.  To free up scarce
> GP counters, eliminate multiplexing-induced skew, and obtain coherent
> Topdown metric ratios, it is desirable to expose fixed counter 3 and
> the IA32_PERF_METRICS MSR to guests.
>
> Several failed attempts have been made to virtualize this under the
> legacy vPMU model: [1], [2], [3].  With the new mediated vPMU, enabling
> TMA support in guests becomes much simpler.  It avoids invasive changes
> to the perf core, eliminates CPU pinning and fixed-counter affinity
> issues, and reduces the overhead of trapping and emulating MSR accesses.
>
> [1] https://lore.kernel.org/kvm/20231031090613.2872700-1-dapeng1.mi@linux.intel.com/
> [2] https://lore.kernel.org/all/20230927033124.1226509-1-dapeng1.mi@linux.intel.com/T/
> [3] https://lwn.net/ml/linux-kernel/20221212125844.41157-1-likexu@tencent.com/
>
> Tested on an SPR.  Without this series, only raw topdown.*_slots events
> work in the guest, and metric events (e.g. cpu/topdown-bad-spec/) are
> not available.
>
> With this series, metric events are visible in the guest.  Run this
> command on both host and guest:
>
> $ perf stat --topdown --no-metric-only -- taskset -c 2 perf bench sched messaging
>
> Host results:
>
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 10 groups == 400 processes run
>
>      Total time: 1.500 [sec]
>
>  Performance counter stats for 'taskset -c 2 perf bench sched messaging':
>
>      4,266,060,558      TOPDOWN.SLOTS:u              #     32.0 %  tma_frontend_bound
>                                                      #      5.2 %  tma_bad_speculation
>        588,397,905      topdown-retiring:u           #     13.8 %  tma_retiring
>                                                      #     49.0 %  tma_backend_bound
>      1,376,283,990      topdown-fe-bound:u
>      2,096,827,304      topdown-be-bound:u
>        217,425,841      topdown-bad-spec:u
>          5,050,520      INT_MISC.UOP_DROPPING:u
>
>        1.755503765 seconds time elapsed
>
>        0.235965000 seconds user
>        1.500508000 seconds sys
>
> Guest results:
>
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 10 groups == 400 processes run
>
>      Total time: 1.558 [sec]
>
>  Performance counter stats for 'taskset -c 2 perf bench sched messaging':
>
>      5,148,818,712      TOPDOWN.SLOTS:u              #     34.0 %  tma_frontend_bound
>                                                      #      4.6 %  tma_bad_speculation
>        602,862,499      topdown-retiring:u           #     11.7 %  tma_retiring
>                                                      #     49.7 %  tma_backend_bound
>      1,759,698,259      topdown-fe-bound:u
>      2,565,571,672      topdown-be-bound:u
>        230,277,308      topdown-bad-spec:u
>          4,966,279      INT_MISC.UOP_DROPPING:u
>
>        1.783366587 seconds time elapsed
>
>        0.313692000 seconds user
>        1.446377000 seconds sys
>
> Dapeng Mi (2):
>   KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU
>   KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
>
> Zide Chen (1):
>   KVM: x86/pmu: Do not map fixed counters >= 3 to generic perf events
>
>  arch/x86/include/asm/kvm_host.h   |  3 +-
>  arch/x86/include/asm/msr-index.h  |  1 +
>  arch/x86/include/asm/perf_event.h |  1 +
>  arch/x86/kvm/pmu.c                |  4 +++
>  arch/x86/kvm/vmx/pmu_intel.c      | 57 ++++++++++++++++++++++++-------
>  arch/x86/kvm/vmx/pmu_intel.h      |  5 +++
>  arch/x86/kvm/vmx/vmx.c            |  6 ++++
>  arch/x86/kvm/x86.c                | 10 ++++--
>  8 files changed, 71 insertions(+), 16 deletions(-)
>
