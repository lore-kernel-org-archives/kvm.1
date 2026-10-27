Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138988;
	b=TNzxeyjZOyaYmD8ZKHQ3rTvqk+BKb0utH5Ae/K2rrRb5wg0nqnYCmDLNpkApJwudsc+p
	 ei8nr/93oZ4DJErsCFha+bmm+ApDyJ9ZUva26c5fOnBxNsTQ9a8AoiaoMUGd8govZvd7j
	 kSljz+0X2mdnyBNQSSfvXUsdGOHbFhyV1fyZ5UiMDElr85mRXXeTItRv2sy8POfvrSCpY
	 RrAm0nz90x4Ktw0MZPv04E1FA5SSo2rBsI0GIMJjNcFrbiEpS2a/9ogOnr4n84ZYM3psv
	 8p2HdA7EQdO6GjQrg50lf60F1E7wskE3JIiFg8ObDebknnrtzAdOCbV5UAtH8cXAjdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138988;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=C3yDSyTVIHoKB3jH8aCOChCJ46WC+deb33ZaKBNRmsU=;
	b=aQmhE0DXJJiPwBTTUo4BlA9doc3tpiiciFEUM7tcD1lwou7LivEBgQefhbDvPP96N80f
	 pgPvk4HFpKUuw5b89J0AzhvgUC48gSlYGBWPh7R/Jwgi261WIxEim6jji9I3X1tBmrhUP
	 0lsfhlJ5S9MvEEw/64P0uTA9YX6MXUHSPEbJ7ZT0eb3RQ36dFv9KA31wm5FsKdcZXJ5Zs
	 pv95PUl6yPoXZs/ydRZDwsjHGj+7b0YCtA+5qwHT2n7uL9Pqq8B7x1WW9tQtcRGOJ40os
	 tMdDHsWmPHqAaPxQw3rNrc8F3lrYrvR8U592tVu7SaQ6/aPtW28tC4yURfJ++u2JRVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EyYPwQ72;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAED606A31A;
	Tue, 27 Oct 2026 22:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AAED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EyYPwQ72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793138988; x=1824674988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tEl3vdBEf6ngwULHa3r7A28OiOnmCpS7OuFXwziP5GU=;
  b=EyYPwQ72YEyhnhDanCJFDe8z7qsDzRmg35YDS03bmvK/RWyWc+DNAlNK
   fdqsCbUtnMAPCBwsQj1Az9aUQfaOVPwEv/i26xybZbl1z4miRD5t0MiQM
   IZdKU2bX2tdlnYdGGIx1wqbp3XSjjCZtwd6ZZY+5j30d+IkJ8d/KeqXnZ
   I+bQEd+HiNCqK+OWgVls9ty1UffTRjBcxTnA6ld+6fQVgjcoYRI/RZiFt
   7vnI+zzm+p3ZO4CYCbxzRX4ye5tjYGCMf5Gw8JLPx5JIHzFHPkDlPu3sr
   BpTtiMsUs6cYnF2rHzl+a58E0PJ2drBkacEd1rwLdDO5Ggos2f29qMb3y
   A==;
X-CSE-ConnectionGUID: E6Ixz6Y0Sh69nMyI92zBMg==
X-CSE-MsgGUID: gEMHDBIWTc+TiGQ81mZaHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1884141"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1884141"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 15:09:47 -0700
X-CSE-ConnectionGUID: zXz8nBh0QUmnGFKJEBZsdA==
X-CSE-MsgGUID: jFi5twpsQN2n/NBoUm+Maw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5005018"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 15:09:44 -0700
Message-ID: <6da36d01-c456-4bd9-8d3a-591e98ab3481@intel.com>
Date: Tue, 27 Oct 2026 17:09:43 -0500
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
Subject: Re: [PATCH v9 11/12] KVM: x86/pmu: Reject writes to reserved
 MSR_PERF_METRICS bits
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-12-zide.chen@intel.com>
 <20261023184505.3284911-1-jmattson@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20261023184505.3284911-1-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/23/2026 1:45 PM, Jim Mattson wrote:
> On Fri, Sep 18, 2026 at 12:39 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> +		if (kvm_pmu_cap.num_topdown_events < INTEL_TD_METRIC_NUM)
>> +			pmu->perf_metrics_rsvd =
>> +				~(BIT_ULL(kvm_pmu_cap.num_topdown_events *
>> +					  INTEL_TD_METRIC_FIELD_BITS) - 1);
>> +		else
>> +			pmu->perf_metrics_rsvd = 0;
> 
> perf only sets x86_pmu.num_topdown_events for the models it knows about
> (Ice Lake and intel_pmu_init_glc() users). On a non-hybrid part that
> perf treats as "generic_arch_v5+", PERF_CAPABILITIES.PERF_METRICS_AVAILABLE
> can be set while num_topdown_events is 0. (intel_pmu_init() even sets
> GLOBAL_CTRL_EN_PERF_METRICS in intel_ctrl in that case.)
> 
> vmx_get_perf_capabilities() will still advertise PERF_CAP_PERF_METRICS,
> but perf_metrics_rsvd will be ~0ull. The guest writes PERF_METRICS
> directly, and the hardware updates it on its own, so KVM_GET_MSRS can
> return a non-zero value that KVM_SET_MSRS will then reject. That breaks
> save/restore. (The selftest's write of 0xdeaddead would also fail.)
> 
> Shouldn't vmx_get_perf_capabilities() withhold PERF_CAP_PERF_METRICS
> (and PERF_CAP_RDPMC_METRICS_CLEAR) when kvm_pmu_cap.num_topdown_events
> is 0? 

Yes, this is safer. Will updated vmx_get_perf_capabilities() to gate
advertising both PERF_CAP_PERF_METRICS and PERF_CAP_RDPMC_METRICS_CLEAR
on num_topdown_events.

> The SDM, volume 3, section 22.8, says:
>> IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE[15]: If set, indicates
>> that the architecture provides built in support for [four] TMA L1
>> metrics through the PERF_METRICS MSR.
> 
> So, four could be a fallback, but if the part actually implements
> eight, the upper fields would break the round trip in the same way.
> 
> Also, since the guest's own writes go straight to hardware, this check
> really exists to keep the wrmsrq() in intel_mediated_pmu_load() from
> faulting on a bogus userspace value. The commit message should say so.

Agreed. I will update the commit message to clarify that because guest
writes are passed through to hardware, the primary purpose of this check
in intel_pmu_set_msr() is to prevent userspace (e.g. via KVM_SET_MSRS)
from stuffing invalid metric values that would cause the unchecked
wrmsrq() in intel_mediated_pmu_load() to #GP on VM-entry.
