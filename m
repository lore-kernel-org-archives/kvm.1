Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645365;
	b=ddVIlkPgh6QtYtKsW+jIU0mqdJhC1AVO6X361EUpssXZjyjaQweEy3p+mPdTROmBc6nP
	 2Yctu11x3bQladcKgrynhQr9+yFYEnfMDVkurALiwnUI+aw3f4UqhyuDnoDjLY6GDIo5r
	 Nm5seob43UvRXGWXEYxV5dO8qqdQM8ZlfG1iOxmz/04Ea635z/q+G2sBym25X8w1DsJFI
	 ayabG+Yo+UIQJ/FEs+ELuCq1lAYgMrtUN9dDHwUiwzexgVID8Nf65618oBFz8Mr0L2WUH
	 SDh0mAgFtiCIwJlUS9zRR2Fd0ljSgiB3DY+lEGHx9Z9b7b6eV7hHF1iyuhRSRd40y9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645365;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=k3mxN1eIB0dDqgp1tKW7+mAdNCuHH0HDF+C6icwQ5rA=;
	b=efJw3Q4UL+sldW4o/cy8MNHNms67scHzp38U5KQyv9iyYvQJDTuNUGVQpoXA7MOCEF2x
	 Av2AwJslxXRpc+nTnXprS0eeHextDxpgjZMIZY15LJnAVIHGzpRRGXe1Y5EiTPcvh+neD
	 H+ZxxpNcKaRX9ZW/6+xZvN5VvdSCrNHAGiw6zAXoVFvms58gukCxkgL6NK4HsgMU08JH8
	 yWWjC/w7H09zvPw5KwzWTndQ59JW6SyzopmynsYnqkvJ8SWEoFqW1HByu2cGGohpnFW6P
	 f/n/IZsUxbEh8BM1bXfSgDa8meQdw+pV7FqcBHypc1kgemCQBHUL/v34xB8vDyGbIaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=id03i6PG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A82606A32D
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=id03i6PG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580061F00A24
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793645364;
	bh=k3mxN1eIB0dDqgp1tKW7+mAdNCuHH0HDF+C6icwQ5rA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=id03i6PG121xVfB+h0TVlj83nfP00/RSI+PHIj4cskZQfqMEbEvBLQETdTRaBR47n
	 PFhRyATJ0AeK3FiJlqvcs+xlZpbSQfNHXvMHEzyU/PF/OHd9rV1hRS6wgz2YdIgTAY
	 Z2b69gxX4ZblU4xbj8p1jjI9fD8aJYD9r2kcnFoohQP8Z2wQMky2HSJM9+Ki1w2kR6
	 JMmQbHkcrEZAZWc+NLdgJEU4IVDcOtA/gXr6pBj9x6vN4jjVQ+ocYsoitFi0+rBhMD
	 wRqxxqrrN/SD2qfGUNYvXZ8xfl2Qw9GwHwMNIivtfo5Npaf9ToyuDKp63Hg57pEXqJ
	 qquFDFrj0v/Eg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c40f29667e6so516622866b.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 10:49:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBymkO7tKiHlJPlLLHoAFV5CDwDJkiOf87g3vLg6Hn5Q0lq3qWK6GCOG0clX4LID0zAa9n0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hJZhp01F8P7BZcY1z7yJ8bCKIL6hiCHphtLO5C0FYQWmOF8k4
	2lTaV0W4naHd6btQTQHWbfg7GGQ1FQiHxF21nGCAsxQS94A2iA4+TZExuOUJjwiLwzpGgwJ7cbi
	blx6L7a7Aa1IB9hpROdZx8vD1rlNGpSM=
X-Received: by 2002:a17:907:84c:b0:c46:ba0d:3728 with SMTP id
 a640c23a62f3a-c4ca7a408c7mr889875966b.18.1793645363150; Mon, 02 Nov 2026
 10:49:23 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <auUQgRVFASkWtkoK@google.com> <3276824d-f6a0-455a-bf0c-703fc6d52cf1@intel.com>
In-Reply-To: <3276824d-f6a0-455a-bf0c-703fc6d52cf1@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 2 Nov 2026 10:49:11 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMxQnRLKGrW69rX7703AatWMp6KOXMObL9baHRPs4dW8A@mail.gmail.com>
X-Gm-Features: AclHuK9elA3bTuNibJToBPiP04Z-isYfdu9yIT10eRqfuhSX3CWvUF7_3hpSAQY
Message-ID: <CAO9r8zMxQnRLKGrW69rX7703AatWMp6KOXMObL9baHRPs4dW8A@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"

> >> OTOH, what about PerfMon v4 bits 58 (GLOBAL_STATUS_LBRS_FROZEN), 59
> >> (GLOBAL_STATUS_COUNTERS_FROZEN), and 61 (GLOBAL_STATUS_OVF_UNCORE)?  Per
> >> Intel SDM Vol. 4, Table 2-2, those bits are valid in
> >> IA32_PERF_GLOBAL_STATUS, IA32_PERF_GLOBAL_STATUS_RESET, and
> >> IA32_PERF_GLOBAL_STATUS_SET when CPUID.0AH:EAX[7:0] > 3.
> >>
> >> When those MSRs are passed through in mediated mode, the guest can set bits
> >> 58, 59, or 61 in hardware via IA32_PERF_GLOBAL_STATUS_SET. Leaving those
> >> bits set in pmu->global_status_rsvd for pmu->version >= 4 will break
> >> KVM_SET_MSRS(MSR_CORE_PERF_GLOBAL_STATUS) as well as any intercepted guest
> >> writes to GLOBAL_OVF_CTRL / GLOBAL_STATUS_SET.
> >>
> >> As I pointed out in patch 04/16, we can't pass through the PMU global
> >> controls unless their reserved bits match hardware.
> >
> > I think there are two other relevant (but pre-existing) problems here:
> >
> > 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into the
> > guest. If a host PT PMI arrives while the guest context is loaded, bit
> > 55 will be set for the guest, and the guest won't be able to clear it if
> > OVF_CTRL is intercepted (it will #GP as it is reserved for the guest).
> > Similarly, the value can't be restored through KVM_SET_MSRS.
>
> I think mediated vPMU assumes that no host PMIs can be generated while
> guest PMU state is loaded.
>
> If PT state can leak into the guest via bit 55, similar leakage can also
> occur for other status bits, e.g. when the guest exposes fewer
> general-purpose or fixed counters than the host.
>
> The scenario where both host and guest can be active simultaneously is
> handled by the perfmon_mask case, where intel_mediated_pmu_{load,put}()
> filter guest-owned status bits.

Looking at the code:

kvm_mediated_pmu_load() -> perf_load_guest_context() ->
perf_ctx_disable() will iterate PMUs with for_each_epc() and disable
them, which skips PMUs without PERF_PMU_CAP_MEDIATED_VPMU.

Same for kvm_mediated_pmu_load() -> perf_load_guest_context()
->ctx_sched_out(), it also uses for_each_epc() to iterate PMUs and
schedule them out.

pt_init() does not set PERF_PMU_CAP_MEDIATED_VPMU on pt_pmu.pmu.capabilities

Please correct me if I am wrong.

>
> https://lore.kernel.org/kvm/20260821222002.54907-1-zide.chen@intel.com/T/#m90394fda6d71ed0dd539a579abfb0c1df1e044fe
>
> > (I think the PMI may also be lost as LVTPC points at the mediated vPMU
> > vector)
> >
> > 2. On AMD, bit 58 and 59 have a similar problem. HW accepts those bits
> > but they are reserved for the guest, so the guest can set them if
> > GLOBAL_STATUS_SET is passed through, but userspace cannot restore them.
>
> Right. That seems orthogonal to this series and could be addressed with
> follow-up fixes.

Maybe AMD folks on the thread will take a look :)
