Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2F3939B9
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829579; cv=pass; b=Pt2c5IDOXlIEoF8jhaYUenh61LfsCjpHLSl2Ru3ygSx6P2AyAD8G9VXCroeuAKTTYmWA73AB0l+EPAnPO8Q2sD3H2P7ps0aF/PVUBldxVouw1jz9up0qWjPWv9ceNS9gCg7wK555ggCgiYR7PGWVtWgFHamPWcINAX7JfvNvqkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829579; c=relaxed/simple;
	bh=Ak2hhfq74f9Zm/gmPMPGdDmV5mUmFOoXo2dmBoYygmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdp8eT6un4hXXunjHY9wQTQGYTaoWdAwWuE2KNhnbFCfXs4pkvVqc1pbdO5b6PoinXP3w5Ag91G/Rd0B78j2mnVeaLQmOahVkRTmHNxZ7+cnvahw9IMeidoaJjfH4CKnQRJB3yN4ANx4Air7dHYXFmvDCZEB5t3dXsnVUpPOBtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lj9TFzNY; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lj9TFzNY"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so1102a12.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784829575; cv=none;
        d=google.com; s=arc-20260327;
        b=MMRK06bfh2+5I2TLwzxDSCoO7qWKBO0ClgQInDEIcfu6oD/QAIdkgXYsLVGX5TajLC
         N7KL4v2PKuTI0Lmo2+CDndRNeiF4NWi+rnWWJnzYPmZuM8XXDrue9tqOWTpFE7Sl7HN5
         OWye73/XtctW/O3XjY5lfUZmbpqHKrZrnUuX9ZN0xQK0oHn/IDUuz1GufAw0Yr7p3mUg
         Q9yOKRLh5NVcsrYezVuSSpzjgFRCb2yD83INMfB12/jda9ZCwwqgFqAo8+lurP/fZRLH
         Mupk5uYo3bNugi5qu2V0uzhtzH+seNZaZLxOicfs7hdy83rbBKTqHi74SKX76uCBJ5Bq
         V1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oQyrQ04nVhGGUzljW2LsCNmsPwR5Ku8jcnD71d/GARk=;
        fh=0h0B+yFcOXBMHk2Eqd+kY2D93kOTOTlpnxwROShh3Lw=;
        b=YdEPGwprNUDRaqwAI0LEOjuKw4qDo1vUMBzK69PMXlfhya6HEeafnI7hvs1Wsd8r37
         iZ4JPRzOKQQAYRptLFFFKhGoFfVYmqsofHGEhSax7v5nadMbJxsQp9d6MGT5nXPo25pq
         va6iH5QCJE9jXv9oKOIE5ojjanpMxzk9iDfTPAgbSjRFMhx6RBG3w5XR3wdLFxAVcG8B
         7dr7jWfLwCIjBOFs97Jx8GQWUC9Rkrg26szLbMmvFSGp303MM3DguZMdh7rHkFfh0xAJ
         y8+D5bbM280xuts//S1ltjAXw6mN+vxRaq2EITYbiv1U/GfAQZpShvTr1TgoDctbCyjI
         8Y2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784829575; x=1785434375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oQyrQ04nVhGGUzljW2LsCNmsPwR5Ku8jcnD71d/GARk=;
        b=Lj9TFzNYpZXIrZGAr1kYS8zihpVp96yGNsw9qQBEy7vX+yihoWxjBpOnRYQ5EqVNQ1
         IfXlpyJYP66pVZXIin+I5/2sOhfs36e/ZZb3qm5WVAQkCnRaDTwOcpw8BT6LiuS1Zjpc
         WblsZajyGQAc4HLkm4RQ5Fs/vhIQlwTif9NLWuoV0hYMU3vvutCldEE72j0e8akp7OzB
         gp1GxMb7lfhFcTnhadVivKKQfTvEoInI77FDFRbWe6Ra+BZMxbktiWUs0dJYCRhfTwIA
         SW6I9sKgfccQkOEP6t+9ObqM9qfM+1YzvVXbibJwrRkf2TfWj6E87oRa7dHoiElq/sRu
         MP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829575; x=1785434375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQyrQ04nVhGGUzljW2LsCNmsPwR5Ku8jcnD71d/GARk=;
        b=pNUS8MJA3cpp/iUsoUvuCB57u/JLLMe0OGGZZm7D6zWpEbcObW501gVMNg7G/fU8PB
         J9Lci0Llur90zR99netFsPkNZwjYdOFvH74LXplCBkmDHVLJopP1760pYJsglacj2NCI
         cqo1wCPllz2xzRxqvlniqtMOPD3757q2V7wmIvAioTeNFUcsadF8VMwLPMw/E+MEhIX5
         rQWMLRTTTg39KSxMTUaj+vAJa/0ogBq2VoCznFqBcu3TJdKPZ9P4qmuw4Nu2UIZ4sZd1
         svf3Ik2a9n+NF1lhUQ+6ds2t3TtptvxFjJR5Xd6X6FrGpLaeCN9GISCbgSeg+IKZpzaP
         cNzA==
X-Forwarded-Encrypted: i=1; AHgh+RopO/A9bOjCyQ8wixSNA+lMOIcNFziIkc8dE8WH/ZpLMuPf7EMoMF/i+yFaoJOH0w09GYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kYmrt3Req5rosbFMEekk4oLJBoAQOQ3+BS89+45G3VXaFuZr
	dZmAQXNKqEHqsLw0BcdhjTnB6mb9nywnhKamwhb0QOaLGsUfs5f8cSABzEe3L/uejeUFVqHXU2W
	0kkwY2lgpFrbE1U7x5KgnMjq1N7CfTkqaAk6HpOUJ
X-Gm-Gg: AR+sD11bsCst36QAwSA8pISNnrifscQh7nuE2xfFE6ZOc1Hn3Hqb74V87ON/RPRUuOB
	4yMK85ya1RsQ4KecTZENqA9b3/JxGQpvppDztDSt7thnIwy74wWNORtQpmb0d8xQyif3ol4aL0A
	MF18/LzeiWHdRgtvtF0pYCLD93hs2gK63whm8n1xT1y7A5aD3a8v/B9YsKiMaPfkD7pNXj8YiYk
	FevJvuqFt2kfmatP1Blo+M++LCUyUWE3FqxqUbI7Em8cKm3k8EkOp1jRfqUBQ==
X-Received: by 2002:a05:6402:25b:b0:69e:98c8:e958 with SMTP id
 4fb4d7f45d1cf-69f8ef1d4cdmr1666a12.7.1784829574768; Thu, 23 Jul 2026 10:59:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-6-zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-6-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 10:59:22 -0700
X-Gm-Features: AUfX_mywLAbfgEj790odwUmAEcaElAW8ITGyed1psAx9kfnhALUs19X3KBvvgsQ
Message-ID: <CALMp9eQv3Z8w2UoxDFMyb-zpSAD7RpL6Bzc9kfk=oGpDF7VySA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:28=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Bit 15 in IA32_PERF_CAPABILITIES indicates that the CPU provides
> built-in support for Topdown Microarchitecture Analysis (TMA) L1
> metrics via the IA32_PERF_METRICS MSR.
>
> Expose this capability only when mediated vPMU is enabled, as emulating
> IA32_PERF_METRICS in the legacy vPMU model is impractical.
>
> Pass IA32_PERF_METRICS through to the guest only when mediated vPMU is
> enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES.  Allow
> kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.
>
> Save and restore this MSR on host/guest PMU context switches so that
> host PMU activity does not clobber the guest value, and guest state
> is not leaked into the host.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v5:
> - Remove host_initiated check in set/get MSR handlers.
> v4:
> - Remove WARN_ON_ONCE() and simply reject the guest accesses by checking
>   host_initiated. (Sashiko)
> - Passthru MSR_PERF_METRICS only if has_mediated_pmu is true. (Sashiko)
> - Remove the redundant !! in vcpu_has_perf_metrics().
> v3:
> - Replace WARN_ON() with WARN_ON_ONCE(). (Dapeng)
> - Add comments to explain why we don't validate writes on PERF_METRICS.
> ---
>  arch/x86/include/asm/kvm_host.h   |  1 +
>  arch/x86/include/asm/msr-index.h  |  1 +
>  arch/x86/include/asm/perf_event.h |  1 +
>  arch/x86/kvm/msrs.c               |  6 +++++-
>  arch/x86/kvm/pmu.h                |  5 +++++
>  arch/x86/kvm/vmx/pmu_intel.c      | 31 +++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c            |  7 +++++++
>  7 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 80f638588bf7..96376d8a5199 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -630,6 +630,7 @@ struct kvm_pmu {
>         u64 global_status_rsvd;
>         u64 reserved_bits;
>         u64 raw_event_mask;
> +       u64 perf_metrics;
>         struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>         struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index 18c4be75e927..fdcaeb6c8352 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -331,6 +331,7 @@
>  #define PERF_CAP_PEBS_FORMAT           0xf00
>  #define PERF_CAP_FW_WRITES             BIT_ULL(13)
>  #define PERF_CAP_PEBS_BASELINE         BIT_ULL(14)
> +#define PERF_CAP_PERF_METRICS          BIT_ULL(15)
>  #define PERF_CAP_PEBS_TIMING_INFO      BIT_ULL(17)
>  #define PERF_CAP_PEBS_MASK             (PERF_CAP_PEBS_TRAP | PERF_CAP_AR=
CH_REG | \
>                                          PERF_CAP_PEBS_FORMAT | PERF_CAP_=
PEBS_BASELINE | \
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/per=
f_event.h
> index 1eb13673e889..bc2e1cbcd9b9 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -447,6 +447,7 @@ static inline bool is_topdown_idx(int idx)
>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT  54
>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD      BIT_ULL(GLOBAL_STATUS_ARC=
H_PEBS_THRESHOLD_BIT)
>  #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT     48
> +#define GLOBAL_STATUS_PERF_METRICS_OVF         BIT_ULL(GLOBAL_STATUS_PER=
F_METRICS_OVF_BIT)
>
>  #define GLOBAL_CTRL_EN_PERF_METRICS            BIT_ULL(48)
>  /*
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index 3bf42d90ad14..c751a8dbd45d 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -230,7 +230,7 @@ static const u32 msrs_to_save_pmu[] =3D {
>         MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
>         MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
>         MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
> -       MSR_CORE_PERF_GLOBAL_CTRL,
> +       MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
>         MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
>
>         /* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. *=
/
> @@ -2625,6 +2625,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>                      intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) =
* 2))
>                         return;
>                 break;
> +       case MSR_PERF_METRICS:
> +               if (!(kvm_caps.supported_perf_cap & PERF_CAP_PERF_METRICS=
))
> +                       return;
> +               break;
>         case MSR_ARCH_PERFMON_PERFCTR0 ...
>              MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
>                 if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=3D
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 1b2f66a2e915..3066cade5790 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -279,6 +279,11 @@ static inline u64 kvm_vcpu_get_perf_caps(struct kvm_=
vcpu *vcpu)
>         return vcpu->arch.perf_capabilities;
>  }
>
> +static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
> +{
> +       return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
> +}
> +
>  void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
>  int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index e426ddc8add4..225afd3937c3 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -188,6 +188,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu,=
 u32 msr)
>         switch (msr) {
>         case MSR_CORE_PERF_FIXED_CTR_CTRL:
>                 return kvm_pmu_has_perf_global_ctrl(pmu);
> +       case MSR_PERF_METRICS:
> +               return kvm_vcpu_has_perf_metrics(vcpu);
>         case MSR_IA32_PEBS_ENABLE:
>                 ret =3D kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORM=
AT;
>                 break;
> @@ -345,6 +347,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, s=
truct msr_data *msr_info)
>         case MSR_CORE_PERF_FIXED_CTR_CTRL:
>                 msr_info->data =3D pmu->fixed_ctr_ctrl;
>                 break;
> +       case MSR_PERF_METRICS:
> +               msr_info->data =3D pmu->perf_metrics;
> +               break;
>         case MSR_IA32_PEBS_ENABLE:
>                 msr_info->data =3D pmu->pebs_enable;
>                 break;
> @@ -394,6 +399,15 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
>                 if (pmu->fixed_ctr_ctrl !=3D data)
>                         reprogram_fixed_counters(pmu, data);
>                 break;
> +       case MSR_PERF_METRICS:
> +               /*
> +                * On platforms that support only hardware level-1, bits =
[63:32]
> +                * are reserved and ignored by hardware. If hardware leve=
l-2 is also
> +                * supported, they may contain valid metric data.
> +                * Either way, guest writes are passed through verbatim.
> +                */
> +               pmu->perf_metrics =3D data;
> +               break;
>         case MSR_IA32_PEBS_ENABLE:
>                 if (data & pmu->pebs_enable_rsvd)
>                         return 1;
> @@ -589,6 +603,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>                 pmu->global_status_rsvd &=3D
>                                 ~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA=
_PMI;
>
> +       if (perf_capabilities & PERF_CAP_PERF_METRICS) {
> +               pmu->global_ctrl_rsvd &=3D ~GLOBAL_CTRL_EN_PERF_METRICS;
> +               pmu->global_status_rsvd &=3D ~GLOBAL_STATUS_PERF_METRICS_=
OVF;
> +       }
> +
>         if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
>                 if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
>                         pmu->pebs_enable_rsvd =3D counter_rsvd;
> @@ -632,6 +651,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>
>  static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>  {
> +       struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> +
> +       pmu->perf_metrics =3D 0;
>         intel_pmu_release_guest_lbr_event(vcpu);
>  }
>
> @@ -803,6 +825,9 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *=
vcpu)
>         struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
>         u64 global_status, toggle;
>
> +       if (kvm_vcpu_has_perf_metrics(vcpu))
> +               wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
> +

Our internal Sashiko asks:

Does this write to MSR_PERF_METRICS violate the architectural requirement t=
o
write IA32_FIXED_CTR3 first?
According to the Intel SDM, software must write to IA32_FIXED_CTR3 before
writing to IA32_PERF_METRICS to properly clear the TMA internal state machi=
ne.
During VM-entry, kvm_pmu_load_guest_pmcs() is called before
intel_mediated_pmu_load() to load the fixed counters. However, it
conditionally skips the write if the guest's counter value matches the host
hardware's current value:
kvm_pmu_load_guest_pmcs() {
    ...
    if (pmc->counter !=3D rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
        wrmsrq(fixed_counter_msr(i), pmc->counter);
    ...
}
If skipped, KVM will unconditionally write to MSR_PERF_METRICS here in
intel_mediated_pmu_load() without a preceding write to IA32_FIXED_CTR3. Cou=
ld
this omission fail to reset the TMA state machine and potentially break
TMA metrics?

>         rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>         toggle =3D pmu->global_status ^ global_status;
>         if (global_status & toggle)
> @@ -831,6 +856,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *=
vcpu)
>          */
>         if (pmu->fixed_ctr_ctrl_hw)
>                 wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> +
> +       if (kvm_vcpu_has_perf_metrics(vcpu)) {
> +               pmu->perf_metrics =3D rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS=
);
> +               if (pmu->perf_metrics)
> +                       wrmsrq(MSR_PERF_METRICS, 0);

And here:

Will clearing MSR_PERF_METRICS here occur before clearing
MSR_CORE_PERF_FIXED_CTR3, reversing the architecturally mandated write orde=
r?
In KVM's mediated PMU context switch out (VM-exit), kvm_mediated_pmu_put()
calls the mediated_put callback before clearing the guest PMCs:
kvm_mediated_pmu_put() {
    ...
    kvm_pmu_call(mediated_put)(vcpu);
    kvm_pmu_put_guest_pmcs(vcpu);
    ...
}
This means intel_mediated_pmu_put() writes 0 to MSR_PERF_METRICS here, and
then kvm_pmu_put_guest_pmcs() conditionally writes 0 to
MSR_CORE_PERF_FIXED_CTR3 later. Additionally, if the fixed counter is alrea=
dy
0, the write to FIXED_CTR3 is skipped entirely.
Could this write to MSR_PERF_METRICS without a preceding initialization of
FIXED_CTR3 corrupt the hardware state machine or cause undefined behavior?

> +       }
>  }
>
>  struct kvm_pmu_ops intel_pmu_ops __initdata =3D {
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b736b9ff965b..21eb4b339fa6 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4273,6 +4273,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct k=
vm_vcpu *vcpu)
>                                   MSR_TYPE_RW, intercept);
>         vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>                                   MSR_TYPE_RW, intercept);
> +
> +       intercept =3D !has_mediated_pmu || !kvm_vcpu_has_perf_metrics(vcp=
u);
> +       vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
> +                                 MSR_TYPE_RW, intercept);
>  }
>
>  static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
> @@ -8095,6 +8099,9 @@ static __init u64 vmx_get_perf_capabilities(void)
>                 perf_cap &=3D ~PERF_CAP_PEBS_BASELINE;
>         }
>
> +       if (enable_mediated_pmu)
> +               perf_cap |=3D kvm_host.perf_capabilities & PERF_CAP_PERF_=
METRICS;
> +
>         return perf_cap;
>  }
>
> --
> 2.54.0
>
