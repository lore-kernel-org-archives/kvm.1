Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793222713;
	b=0zoWOcuoEus2mAtRV/IYBmGBmxTtBM7E8+D+Dpz82R9EPcFbBR9TbGlz7J5gb9w2r1VF
	 E6Cjk298rqjqfaeq4Un1/XQV4d74ZmsnkJEAPc6cXLs73/N+LO3Wf6cI+gyl05Xay6K/1
	 m7ilVhuXku8Les6LGC1gL7eInCzcgeFzmZNpXRbX+JbP7SsRSdLNhBKFvUZ+lKGjHWavu
	 S9Mbe/WPLGoyMzlSq9WeGpKCJqXbpLNiktoCQOYh2mZKxXOCq7fpOhaytrBxS803TCrcx
	 iDmsDtPjqw5pi7+/dh4hyy/bk0si3TPSY563o6AIz08gNfAwAXqZw7AkhEtZlJQf0Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ENw9Q5VwwMeL1RTcYiZmzftcc9Hrpk/z8YkgEUgfUU8=;
	b=OL7UOJEA7qRtYUFf7JeIZnN1Y8CQ+37z61O1sjg222gq5ofIOj9Nfvt6swsowOLJWh2K
	 /M4tzPJayLEyJ3CHNZV5lhlV086jGd1xu8AnVQAK0eFbVCPIYwvFwog99cj+YU3iYzr45
	 yklFlQeInZAjoAzyNmKV/XJUwPmiF7zLSr95TGHLHEL/EaTU0gNuckPaM7wprK2TcRDsi
	 yQsXH/JlZa3XwZ30JWSi1eUmwDLMjLrdfWMaFcopPjBccQ0t4Sm8khKyr+6tOKWZNBWmA
	 BFrjskWaG2Ig8k4789NfOvZuXnaX+XS33vdkbC4oVeNiJay+EedPJpQ28IWwBcUT/zQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XVcCHliF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CE606A327
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 21:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B49CE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XVcCHliF
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-535f598d126so36281cf.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793222711; cv=none;
        d=google.com; s=arc-20260327;
        b=ENPYR6VlGM6xRG4u40M2uuTLHi68inc0NbC56HtXBrz6knuazNMmflxhJxnsTnWACf
         coan1Mg6cA3Puo9TWDZy8rFvbzLWzbLLvJHmYnqXVYLrztWh4PhyoyR/bkowHE8YGXXI
         1xIt5//XrY6yE1bcQArwCiSt1DG9acEk8fP0WzAZCK3YT2xS2xuYfq9W2aNsTXOzuLe0
         /x5TVHT29D4qn6rvf1JOj6mMcxrl1Nw7umM2SdQ03ZOYPjLDyMNXlEh7Euyxlcjb9Tw5
         PPqRgUEfJsIoEsgstvliN9k7eBQ+CPHvAPJqids9k3benH90GQaDahHUdVY7B78nc85u
         NQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENw9Q5VwwMeL1RTcYiZmzftcc9Hrpk/z8YkgEUgfUU8=;
        fh=ngkmZgDB4RkR90rvbvVjmd6Nz+ItJpEY3tYcaHnHSKA=;
        b=JKDzqDtVXB3MGFEHLLMsi6dBfXV1znS23kIx4MAGNM92tp5nXoWsLtgtbzWbmOfSeq
         hnHMymdjASVI8gROUtbZh++BndMSXHlPphM7ojdBBDgukPryGgKmMcMmcD+BuQ/DUdRy
         WmapYw4naTgF5Dbya4v8M+V8Fpzvw5Yor2ozYQ7PlEPG7lF4XOae9p7FC38uANmlFloM
         k5z6Hyh6KaXx9U8g63ZV43oULmMwkGiIz8sjC0AXpLR1wc2t50sFeWsgkpcLkHAnMFfv
         01XRjRZETaWTd9vbfovVeXRJHrAksyf7RwwEyya9Tgg1Gm44/Ltrc8zC8Ix44nH9v4JP
         g/RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793222711; x=1793827511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ENw9Q5VwwMeL1RTcYiZmzftcc9Hrpk/z8YkgEUgfUU8=;
        b=XVcCHliFMA6rjXQU2QBUHQSqm4R95UTxBEYXa8U2XPSb5amj03DiOpVoZ9DXvZtYSC
         bG8i9cwDwTpHFbx+8ieyM/KOzxpOKaAvQR5ghVUahJKuNjTqtxqHWu8wbLCf+BJZbgXF
         LkjtWCaSJMi0RuFIEeOoKhEtJAd3+PXko0XtWWWEXO4JLo92fuuMSRHAuN4X3zm3E3cg
         4oI+SG6FaOBhvO3DC8OMbi9Fvx0LN4k8bhK2OMWMRcATpULbO8asZIw8nhDuVknXiszP
         FwJauEIFO0F0ug+kPPyND47rU0CJ1xWVofLCzS+4MquEbHlDXY6GLhmT/gLg5sUr16jp
         wNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222711; x=1793827511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENw9Q5VwwMeL1RTcYiZmzftcc9Hrpk/z8YkgEUgfUU8=;
        b=NtxBvn37oh+rMhuChBwflx1IbyTC9/FqUK+VD97xwslqQBILow2AUo7ak+OnLOD7pv
         4vNLCgDXK1TRwNVPe3s07Ts+gDvhynOALr6iLtfeU5Ix+4xyO+iO1whJAKb+RbUrt2xY
         cNSXaj1gCt6fwRPAbI4+0Y23K07UI8UeQuetLihb3rVOQQA+8OmyQmPGdtU5zpzEqJWf
         FT/HKRVnICfb8X79L+rfR41w/dHrlOrfbPY/2/NtHcz22f0P+BV74IbYUN2W3/Of9trK
         PEs/HmXL022bA+4cCcAOQtwJEb+G92pXJluy4ptb3b0bwJe05mRHR3/g8mOCoqKIeijA
         5T3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwh+Tc6S6aMgQ9z8mzB4H+qHdmkPQl/JUB0/hF7u1nEHXFp7hXXg1lEFDC2afFSlCSOBZg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuWYIy/h0EW7PKwZf9mkcoeUZ9F2opynl3XzZS26KkpQtsdNkt
	TkWC6pSAKDoetmIFv4FsoOC8IYPvJGy/fLDjGLogTg7MmmwlWXZFYDL5Req0k2eeWE+g524Dsuq
	fwZPmer3VNWFDqh4Jk01U6psE43ttLzGE5Petb3rH
X-Gm-Gg: AYBFou19Oh2AkdP3MKWsnqjxicQFaKKOki1UwfUIGgJ7v5MrWgQw9L5o1g2+Lkj1YAq
	XkCZozs81SfxGz0alPQgeCFztzv/dCa8/U2nCD6T1j7hlYqihaLdEfeHLAhOARS+D5VU6q+VTXX
	4B1Jd13ketbrctj+QtmUEz6q2tG1XhbJOFPfOluDOvP6uab0+6IFo5FQ+rFr6dPGdF6ha/T6XT0
	VAG7F4IDTRpJt8xSB+KliOrvsmqZCN11vis0S2GRbgZKu4bcXlrzWOlkA9Tb+E287rc5iX8I7xS
	IcRsi/OeUMIX2+mH7isxA0TTec9OewOeX+Xww2YXZ9hkYQCsly2VYBKJf5LCCCguOjkrOzW7sgV
	rm+V8EX+RfQG+PN8I1quJ5T5YAji2epVefIVj
X-Received: by 2002:a05:622a:2298:b0:536:d46:ffa7 with SMTP id
 d75a77b69052e-5414e3fe9afmr2752931cf.12.1793222710639; Wed, 28 Oct 2026
 14:25:10 -0700 (PDT)
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
In-Reply-To: <20260827223755.143247-12-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 14:24:57 -0700
X-Gm-Features: AclHuK9dEqdUmO-HHiIIftvXmEGOnx7VGEu94hz8TxQGo8ovabGloAkS3SRkWVQ
Message-ID: <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:48=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
> allow software to set individual bits in the global status MSR. Reads
> of IA32_PERF_GLOBAL_STATUS_SET always return zero.
>
> IA32_PERF_GLOBAL_INUSE (0x392) is also introduced in v4, to track
> which counters and the PMI are currently claimed by other agents,
> allowing independent software agents to check counter availability
> without a shared scheduler arbitrating between them.
>
> IA32_PERF_GLOBAL_INUSE is an read-only MSR, and any write attempt
> results in a #GP.
>
> Neither MSR is part of the VM state, so they don't need to be
> advertised to userspace, nor saved and restored during live
> migration.
>
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Change intel_pmu_get_global_inuse() to return u64, to match the
>   surrounding code style.
> - Add the missing vmcs02 updates for these two MSRs.
> - Change "> 3" to ">=3D 4" to make the "v4-gated" more obvious and match
>   the existing code style.
> ---
>  arch/x86/include/asm/msr-index.h |  4 ++++
>  arch/x86/kvm/pmu.c               |  9 ++++++++
>  arch/x86/kvm/vmx/nested.c        |  2 ++
>  arch/x86/kvm/vmx/pmu_intel.c     | 37 ++++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c           |  4 ++++
>  5 files changed, 56 insertions(+)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index 11b99d237e05..0b093cf41edf 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1240,6 +1240,10 @@
>  #define MSR_CORE_PERF_GLOBAL_CTRL      0x0000038f
>  #define MSR_CORE_PERF_GLOBAL_OVF_CTRL  0x00000390
>  #define MSR_CORE_PERF_GLOBAL_STATUS_SET        0x00000391
> +#define MSR_CORE_PERF_GLOBAL_INUSE     0x00000392
> +
> +/* Intel IA32_PERF_GLOBAL_INUSE MSR */
> +#define PERF_GLOBAL_INUSE_PMI_INUSE    BIT_ULL(63)
>
>  #define MSR_PERF_METRICS               0x00000329
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 437a7bc49bf8..7c05cf5157bf 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -832,6 +832,8 @@ bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 =
msr)
>         case MSR_CORE_PERF_GLOBAL_CTRL:
>         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>                 return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +               return vcpu_to_pmu(vcpu)->version >=3D 4;

MSR_CORE_PERF_GLOBAL_STATUS_SET should be handled in pmu_intel.c? It is an
Intel-specific MSR (note that commit 79a71cc2568f ("KVM: x86/pmu: Move
Intel specific MSRs to pmu_intel.c") moved all of MSR_CORE_PERF_GLOBAL_*
into pmu_intel.c).

Moreover, checking "vcpu_to_pmu(vcpu)->version >=3D 4" here without checkin=
g the
vendor will expose MSR_CORE_PERF_GLOBAL_STATUS_SET on AMD when AMD's
pmu->version reaches 4.

> @@ -865,6 +867,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr=
_data *msr_info)
>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>                 msr_info->data =3D 0;
>                 break;
>         default:
> @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct ms=
r_data *msr_info)
>                 if (!msr_info->host_initiated)
>                         pmu->global_status &=3D ~data;
>                 break;
> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +               if (data & pmu->global_status_rsvd)
> +                       return 1;
> +               if (!msr_info->host_initiated)
> +                       pmu->global_status |=3D data;
> +               break;

According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"),
IA32_PERF_GLOBAL_STATUS.CondChgd[bit 63] cannot be set by writing to
IA32_PERF_GLOBAL_STATUS_SET, because IA32_PERF_GLOBAL_STATUS_SET[bit 63] is
reserved.  In other words, it is not possible to save/restore
IA32_PERF_GLOBAL_STATUS when bit 63 is set.

Because bit 63 is clear in pmu->global_status_rsvd:

1. An intercepted guest WRMSR(MSR_CORE_PERF_GLOBAL_STATUS_SET, BIT_ULL(63))
   succeeds instead of injecting #GP(0) and sets bit 63 in
   pmu->global_status.
2. When bit 63 is set in pmu->global_status (whether it was set by
   kvm_pmu_set_msr() or by intel_mediated_pmu_put()), the next
   intel_mediated_pmu_load() will try to write an illegal value to
   MSR_CORE_PERF_GLOBAL_STATUS_SET. I don't think we get a #GP, because
   every wrmsr is "safe" these days, but the write will be ignored.

OTOH, what about PerfMon v4 bits 58 (GLOBAL_STATUS_LBRS_FROZEN), 59
(GLOBAL_STATUS_COUNTERS_FROZEN), and 61 (GLOBAL_STATUS_OVF_UNCORE)?  Per
Intel SDM Vol. 4, Table 2-2, those bits are valid in
IA32_PERF_GLOBAL_STATUS, IA32_PERF_GLOBAL_STATUS_RESET, and
IA32_PERF_GLOBAL_STATUS_SET when CPUID.0AH:EAX[7:0] > 3.

When those MSRs are passed through in mediated mode, the guest can set bits
58, 59, or 61 in hardware via IA32_PERF_GLOBAL_STATUS_SET. Leaving those
bits set in pmu->global_status_rsvd for pmu->version >=3D 4 will break
KVM_SET_MSRS(MSR_CORE_PERF_GLOBAL_STATUS) as well as any intercepted guest
writes to GLOBAL_OVF_CTRL / GLOBAL_STATUS_SET.

As I pointed out in patch 04/16, we can't pass through the PMU global
controls unless their reserved bits match hardware.

[ ... ]

> +static u64 intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> +       unsigned long fixed_mask =3D kvm_fixed_pmc_mask(pmu);
> +       unsigned long gp_mask =3D kvm_gp_pmc_mask(pmu);
> +       bool pmi_inuse =3D false;
> +       u64 eventsel, data =3D 0;
> +       u32 fixed_ctrl;
> +       int i;
> +
> +       kvm_for_each_gp_counter(i, gp_mask) {
> +               eventsel =3D pmu->gp_counters[i].eventsel;
> +
> +               if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
> +                       data |=3D BIT_ULL(i);
> +               pmi_inuse |=3D eventsel & ARCH_PERFMON_EVENTSEL_INT;
> +       }
> +       kvm_for_each_fixed_counter(i, fixed_mask) {
> +               fixed_ctrl =3D fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
> +
> +               if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_US=
ER))
> +                       data |=3D BIT_ULL(KVM_FIXED_PMC_BASE_IDX + i);
> +               pmi_inuse |=3D fixed_ctrl & INTEL_FIXED_0_ENABLE_PMI;
> +       }
> +       pmi_inuse |=3D pmu->pebs_enable;

Nit: I am always complaining about unnecessary use of '!!', but I
think it is warranted in the two assignments to pmi_inuse above.

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 56daf5c61082..2dabb7e64956 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4282,6 +4282,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct k=
vm_vcpu *vcpu)
>                                   MSR_TYPE_RW, intercept);
>         vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>                                   MSR_TYPE_RW, intercept);
> +       vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_STATUS_SET,
> +                                 MSR_TYPE_RW, intercept || pmu->version =
< 4);
> +       vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_INUSE,
> +                                 MSR_TYPE_RW, intercept || pmu->version =
< 4);

When a PMU event filter denies a fixed counter in mediated mode,
kvm_mediated_pmu_refresh_event_filter() clears the entire 4-bit control
nybble in pmu->fixed_ctr_ctrl_hw (written to physical IA32_FIXED_CTR_CTRL),
while pmu->fixed_ctr_ctrl contains the guest-written value.

If MSR_CORE_PERF_GLOBAL_INUSE is passed through, a guest RDMSR of
IA32_PERF_GLOBAL_INUSE will see FCx_InUse =3D=3D 0 (and potentially PMI_InU=
se
=3D=3D 0) from hardware even though RDMSR(IA32_FIXED_CTR_CTRL) reports the
fixed counter as enabled (and intel_pmu_get_global_inuse() reports it as
in-use when MSR_CORE_PERF_GLOBAL_INUSE is intercepted).
