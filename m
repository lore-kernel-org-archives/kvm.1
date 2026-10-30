Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398405;
	b=Q+4AFdvrlyEeZsPSr6UHHq9Kdb8wNYhh7+BOGNjJbFvim8RWi6U359+Y3euQwrzJIGWN
	 rWjrs5eBWuofvY59caGiOuV4xOuPlLyk99W9vlSwkA1skHtxLuff32f9W/pVMBoTwMdOc
	 Y7q5HkC13hhg3DjR8zCjbajsedZCCzlGCBjLpTdI0yTpXdeKS7JjuxBunDTMNptpJWlUQ
	 xe7DcFsxhw38gez+SbIQ/Fb/JUAGEKYwl/GXPIsgMilWqXo5ZLN6kRqeu0NAlJIH9ZTWB
	 UOJl7DsuCSW/TflAStD5JU/eBzQ3n3vYmSWOvkYRTJ/vknZXvPX+gt4SKZ5BAIzK5mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398405;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ad9G+QJKWBbiVuK5/YoploQz2oiKmEWZuVEvN3yaNqw=;
	b=hNOZxLgOFgbHhu3b4fVvlfJuo+Q7XENAY/TKtdQBuat+tdh1NlH5J8rymytDowOggJ6V
	 0u/lJdHRRUlzpbJtTavzu43V4dk1Bg6Iq9Aay8xNDZ6w08KSnDGzPMxsPYvOgUVd1wtmn
	 7o8pWhGFLiNkvzhR5UnPbpeOBcdmyyCqBB3Pomu4e/FfQSnkFU6MxJ+c/GfO257OWrbf3
	 okVBZAPH1SNKa08HV+bpeV/g/oR0RQaqqro6/asGh/mOp3xY4r40hbvueBMWgNo5SLXYm
	 tTlz+LeBSnWxZBCCIX/hCFiic6NXZ92ISeaGNwA0kxVlhPI8Od5e149WpX3H/f1mCew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7ObQvDf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A1606A31A;
	Fri, 30 Oct 2026 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7ObQvDf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4501F00A02;
	Fri, 30 Oct 2026 22:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793398404;
	bh=Ad9G+QJKWBbiVuK5/YoploQz2oiKmEWZuVEvN3yaNqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G7ObQvDfVzQMhL9YU3BBDjDOOiDuO5NdUysaQvuK8wMrnjXG9HCwCj4Aq8P+3LhCv
	 Lfj9ol/XzrhECCeeJDlrMfPvdLs99VU5hIynwGeqJ0fqUUcei+MlogrsyRVV+Zpstd
	 mrF6/Z8KRz04ryc4QfLIdnU9XjZ2C7ze57sXl5h+2R9KPIolmWKywEXajvIgTL3TXg
	 gZ6VI6fFuK3cGqO5g8aQnRPOGXb7z2Y2jKbHHcyufb3fWewhk3WoiEA+vhOKk6PNr6
	 gT2IfgZBM0rpdV82D27h8YhrCrjJDNwToEd/T3VexyuO7N49HwZMkzIk2gJ6lQHHXj
	 csZYBM8+MPCSA==
Date: Fri, 30 Oct 2026 22:13:22 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Jim Mattson <jmattson@google.com>
Cc: Zide Chen <zide.chen@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
Message-ID: <auUQgRVFASkWtkoK@google.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>

> > @@ -865,6 +867,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
> >         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
> >         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> > +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> >                 msr_info->data = 0;
> >                 break;
> >         default:
> > @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >                 if (!msr_info->host_initiated)
> >                         pmu->global_status &= ~data;
> >                 break;
> > +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> > +               if (data & pmu->global_status_rsvd)
> > +                       return 1;
> > +               if (!msr_info->host_initiated)
> > +                       pmu->global_status |= data;
> > +               break;
> 
> According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"),
> IA32_PERF_GLOBAL_STATUS.CondChgd[bit 63] cannot be set by writing to
> IA32_PERF_GLOBAL_STATUS_SET, because IA32_PERF_GLOBAL_STATUS_SET[bit 63] is
> reserved.  In other words, it is not possible to save/restore
> IA32_PERF_GLOBAL_STATUS when bit 63 is set.
> 
> Because bit 63 is clear in pmu->global_status_rsvd:
> 
> 1. An intercepted guest WRMSR(MSR_CORE_PERF_GLOBAL_STATUS_SET, BIT_ULL(63))
>    succeeds instead of injecting #GP(0) and sets bit 63 in
>    pmu->global_status.
> 2. When bit 63 is set in pmu->global_status (whether it was set by
>    kvm_pmu_set_msr() or by intel_mediated_pmu_put()), the next
>    intel_mediated_pmu_load() will try to write an illegal value to
>    MSR_CORE_PERF_GLOBAL_STATUS_SET. I don't think we get a #GP, because
>    every wrmsr is "safe" these days, but the write will be ignored.

On SPR, it does produce a #GP that gets ignored (and logged) and the bit
is not set.  Interestingly, on CLX, the write goes through and the bit
is set. Didn't check other CPUs.

> OTOH, what about PerfMon v4 bits 58 (GLOBAL_STATUS_LBRS_FROZEN), 59
> (GLOBAL_STATUS_COUNTERS_FROZEN), and 61 (GLOBAL_STATUS_OVF_UNCORE)?  Per
> Intel SDM Vol. 4, Table 2-2, those bits are valid in
> IA32_PERF_GLOBAL_STATUS, IA32_PERF_GLOBAL_STATUS_RESET, and
> IA32_PERF_GLOBAL_STATUS_SET when CPUID.0AH:EAX[7:0] > 3.
> 
> When those MSRs are passed through in mediated mode, the guest can set bits
> 58, 59, or 61 in hardware via IA32_PERF_GLOBAL_STATUS_SET. Leaving those
> bits set in pmu->global_status_rsvd for pmu->version >= 4 will break
> KVM_SET_MSRS(MSR_CORE_PERF_GLOBAL_STATUS) as well as any intercepted guest
> writes to GLOBAL_OVF_CTRL / GLOBAL_STATUS_SET.
> 
> As I pointed out in patch 04/16, we can't pass through the PMU global
> controls unless their reserved bits match hardware.

I think there are two other relevant (but pre-existing) problems here:

1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into the
guest. If a host PT PMI arrives while the guest context is loaded, bit
55 will be set for the guest, and the guest won't be able to clear it if
OVF_CTRL is intercepted (it will #GP as it is reserved for the guest).
Similarly, the value can't be restored through KVM_SET_MSRS.

(I think the PMI may also be lost as LVTPC points at the mediated vPMU
vector)

2. On AMD, bit 58 and 59 have a similar problem. HW accepts those bits
but they are reserved for the guest, so the guest can set them if
GLOBAL_STATUS_SET is passed through, but userspace cannot restore them.
