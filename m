Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655430;
	b=I9oPcdxKYClTdZqLZpkXf5NsMt1F0jy650XMdvhIzLHgdMQrl48rZgcK4vwuKkkgGEEj
	 8Okz37vUm3kkHOHrRsQhWl75vwrfOk55lePP0YokHEjk+49lGfm8kJNboFDOxyiJXBioQ
	 YGsOiyoMNEJnHwoEhQbo97nQ3OeuUwmmmYG0TRrspeQAzOGcqB1itkrE6gaSQWRKeBEYa
	 jsSkNN7qx0ukR0YUsrEDNj5DuV8Di7mlv9wbe4m/LJaHWfOYzUZ8ifIixaJi+3TNdvWtI
	 B1y4fr9mluoylzm61a0MTAMTHj+OxGzYrZDzkBfgPPF9v/GW4M5B39PNSOcwaTM8V+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655430;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=VeHb/7+mqIyInEKjZyFtleHGQ583OKHZZwEKQ2ya4ZM=;
	b=phJ5yEI5z3IW87HEEkJkJE7XsTtudSEJH02MUZmI54ulZQL9cPYQyO3+YEH5kKGK87rO
	 fs1xCgyRDccxjGeNR2G5lQdCr/EeJEVqisP+xhhjIwsxiw4OT8WlE3V5r7weqN/inoo/F
	 R+tkJZlcisSn6PluswjWrfsx/pHYywzHXFyxfq47DL8GA3XyE+xPN9MRC+cWKo9JThEqa
	 9kyMnVbXsPYsYT3zh8dmFxKkzjBvnv+BhS3ZJtNzTFWcIvocIYqgdVcU5TNt01YLIfJE5
	 Y2EmDoXzWCSwfGt/5D1Y8QWstxFt8g3TFAbchELpOuH4uq4iAXai6x9bI9A2qjCt4Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYvXrYYT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFE606A327
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYvXrYYT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121411F00A23
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655430;
	bh=VeHb/7+mqIyInEKjZyFtleHGQ583OKHZZwEKQ2ya4ZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nYvXrYYT8kUH8zuvCJlYV199AdYhv2UTeQEcxjvoLj+Lwh2EinEq8Lw1u6Bh2Wnsq
	 oMlxkLuxiCWtfUROpt0HGkuFunk0uILUHOzWc8e14B+tqO+TDVcJPHQItaX+buiTio
	 dDqrPACOULO8Rmzr2yzKm+C/BMe5e7wzYcHox2Jvt61YtHWbOhbDKHB5fwX47F1S8+
	 TqEvd9sLncQREHmX6/m1ZaBdwwuzu7yxG26fso9sYkLwaswDcUcGlODsYfmHax9Rpt
	 CakQXC6/ibmKWA0Z0kAtlRD8bH40leBy8b2RpulsdTZrXQndjUeA0ejfuktgfVhdWn
	 NcDvR+Nf1LrKg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c34bff61551so589916666b.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 13:37:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxrK93I3PPErHpAjZnNHaYZ9oYVI7FL7ESO5Untq7iAED4QA3gQ9OqpS+ajgBaWt1lhIUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mNq6gAmJg9ysIkcI36NPI0mla4IU5xQlb0c/e5EbNXk8R8mXq
	peDQH4PKz5wo4PmbH9uu4qxNk5f6GuYEbUeFTl/0fdDQZpSbsg2RmKQLmCJUf5+A100E7N4o/mf
	e1FtM2FSJDdf14iwhhwMx+E1ssmlovkA=
X-Received: by 2002:a17:906:2990:b0:c3f:e414:d35a with SMTP id
 a640c23a62f3a-c4cba44d6e2mr470635166b.26.1793655428951; Mon, 02 Nov 2026
 13:37:08 -0800 (PST)
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
 <CAO9r8zMxQnRLKGrW69rX7703AatWMp6KOXMObL9baHRPs4dW8A@mail.gmail.com> <6c9a13c9-e6c1-4540-a8ca-1f0e800f3571@intel.com>
In-Reply-To: <6c9a13c9-e6c1-4540-a8ca-1f0e800f3571@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 2 Nov 2026 13:36:57 -0800
X-Gmail-Original-Message-ID: <CAO9r8zOWzr61pkkF01AvEp+YSOo6bA1N=L91RYiM=ETtK5+D9w@mail.gmail.com>
X-Gm-Features: AclHuK_81Xn7MYXwfn7C7Q8S_viok9JTdCsG-LNAeRMkvievKFooIXM0eiyMCfE
Message-ID: <CAO9r8zOWzr61pkkF01AvEp+YSOo6bA1N=L91RYiM=ETtK5+D9w@mail.gmail.com>
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

> >>> 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into the
> >>> guest. If a host PT PMI arrives while the guest context is loaded, bit
> >>> 55 will be set for the guest, and the guest won't be able to clear it if
> >>> OVF_CTRL is intercepted (it will #GP as it is reserved for the guest).
> >>> Similarly, the value can't be restored through KVM_SET_MSRS.
> >>
> >> I think mediated vPMU assumes that no host PMIs can be generated while
> >> guest PMU state is loaded.
> >>
> >> If PT state can leak into the guest via bit 55, similar leakage can also
> >> occur for other status bits, e.g. when the guest exposes fewer
> >> general-purpose or fixed counters than the host.
> >>
> >> The scenario where both host and guest can be active simultaneously is
> >> handled by the perfmon_mask case, where intel_mediated_pmu_{load,put}()
> >> filter guest-owned status bits.
> >
> > Looking at the code:
> >
> > kvm_mediated_pmu_load() -> perf_load_guest_context() ->
> > perf_ctx_disable() will iterate PMUs with for_each_epc() and disable
> > them, which skips PMUs without PERF_PMU_CAP_MEDIATED_VPMU.
> >
> > Same for kvm_mediated_pmu_load() -> perf_load_guest_context()
> > ->ctx_sched_out(), it also uses for_each_epc() to iterate PMUs and
> > schedule them out.
> >
> > pt_init() does not set PERF_PMU_CAP_MEDIATED_VPMU on pt_pmu.pmu.capabilities
> >
> > Please correct me if I am wrong.
>
> My apologies, this bug is indeed real because pt_pmu lacks the
> PERF_PMU_CAP_MEDIATED_VPMU capability.
>
> Adding this capability to pt_pmu seems intuitive, but unlike
>
>                        the core PMU (which merely toggles enable bits),
> Intel PT is an AUX-based PMU. Stopping and restarting it on every VM
> transition is heavier, and I'm not sure whether it could introduce a
> noticeable performance penalty.
>
> However, whether the solution is adding PERF_PMU_CAP_MEDIATED_VPMU or
> some other mechanism to enforce mutual exclusion between pt_pmu and
> mediated vPMU, we can address that in a separate patch.
>
> To immediately protect guest state and live migration in this series,
> I'm thinking of adding the following defensive filter in
> intel_mediated_pmu_put():
>
> + /*
> +  * Scrub bits that are not virtualized for the guest to prevent
> +  * possible host state from leaking into guest state and breaking
> +  * live migration.
> +  */
> +  pmu->global_status &= ~pmu->global_status_rsvd;

This doesn't prevent the leakage, it just clears it on the guest->host
switch. So it helps live migration but I am not sure if it's better or
worse if the guest sees the bit unexpectedly appear AND then
unexpectedly disappear.

We can clear it when the MSR is read by userspace, which should fix
live migration, but the guest will still see the bit, and it will
still disappear unexpectedly but only during live migration.

The guest still won't be able to clear it when OVF_CTRL is intercepted.
