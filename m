Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793224226;
	b=hoyA4+d4Q8EUJEc4V7s3GKDz/uVNBYELJmAlXOrfSd6vbLh3LipeytxjV83XY5p5zE8M
	 HPeaHefiIXeawaffa1IK7GgHRZCZn5o0nJmKc2XWqrzDcsQNelY+hgXtrL8OI5hQeZ4sx
	 cSgVKqkEvPl5PS+OcJHPiqOt7Frs2dHoi+xOVVC7R9qDmSjqmeVFuS418Z1JuRnT4eERK
	 3ow0tAN0f1FK7B+4keonD3k4R2Ldr/hNMfkEyrEYcuncxYH+GL/1UpYVDZnrWAT4gww57
	 EuS3AdELgVVTe7gL1HDTRmSSYAvtca7mQjTTkjJS+xhyiGqjz/lioqGBJatXI4HXWYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oVkrmmtCx8Wz/yMOuP0167k9m9+QdMkDrba4QH5xysg=;
	b=I5TJy2nP9gI5zlRGNn8eu6tE51sBUzcPbKlP8aDLZhAjHAOJ4wCm+EdNbZ0Z1aRJOIzG
	 jtrNbeafE+3FIsanVzGAz3Twab/D3djE0s1fuw6Z4mtP0x+gnmJ2VaJ8Uoi+9mo7MKK3I
	 +AobeQv2ajA3obfHM6KRibGzOrgUiivZZ6/AWkI5jXthvqQqbMZ/kxWdPW7SxonKIviEY
	 DszC2yu+opGb5TZmgtqGcdsiNc27Rs6iJ4vy2ax4rUy+X/ebAs4CcOas4DYrBIpKUb1EX
	 CKL7Y3TeW1WQC0Oc8uoDCCbweE8WyV73lfRAlspd2Sr2MwHk2VyxxOdBidDpxgYvozA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ck0EDRnj;
	arc=fail smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB8606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 21:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7CB8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ck0EDRnj
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533202fe429so116141cf.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793224225; cv=none;
        d=google.com; s=arc-20260327;
        b=MrC9ElHe6CTVVyPsi5KlsiQ6fkKgaPutSScR5eBSYYbdaOJNh096h8Cr4aCyPdtwW8
         2vzApk6O/yNh75At37ZHMZpG4PGjvXiQe2LKpsw0ao2zAZcd+SWTJ94mxYKfrXSb/2TB
         iqpiQVmGVeQr+GYvutcMX/3fVXS31oNNyvLbJVa0Oza/af0xd91VxrG1zNNmIx+kR5JO
         Oo8lA5H18zRXhhRZSMavocWJSJz81f/1BJvFG/I88NfDXSS3XXgXAazsRj/b6/D5qGRI
         Lux6fG8CrciuRpB3dmZm8wwbUtZgFqpr43/mlFdLa3w8wRzuHzKisoHdocymax9QokQQ
         RlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oVkrmmtCx8Wz/yMOuP0167k9m9+QdMkDrba4QH5xysg=;
        fh=s6sLU3vU0+LRT/oc7qnr01cu1JyqhTHMStDOpBbm8sw=;
        b=dkvLHEqpHbJeUkxnW2kuLAHSs8CucbJsROJ0QwqQSQUWEOB6z5l27n5IvmaEHW0dKD
         /IBxrY2f/OQ45G6ivIHvxM/3YuJcaki/LDqLq0d+tx8FtqBeh7StAMLj1VnUpRks7WXb
         ChgbyOuPHhF/LQMO+vuN517lQtYDBVOEk+rIF+B7tlShXVwRS0KtUKduQ8NVouYWmtdO
         mMz36sRLMUMkmQPkOUAuMEB+zkCFrgCMerCiJSh3IifM/zQu78CpyzXVAUQLOoyyEsRW
         gNE1lV6alebpOJ5reNEBFC5ktoCtSWWzqroMgwxu8HBTG9pmwEATfKx9s5BQmQzFz1jZ
         mrww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793224225; x=1793829025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oVkrmmtCx8Wz/yMOuP0167k9m9+QdMkDrba4QH5xysg=;
        b=ck0EDRnjLKay09UM84zGm1JVefEzd3YbVqAzsZSMjjotDQg6LmiDbJkH3c94ItREUn
         u1z/eRZ7MuZGZoCUEsb1K8spkWIdz4yXDM14DApiLWgu4IGn3joQziWF6ox99pbYO5Rr
         yu0aVIrTA4X1CIpIVU04f/y0FyVVyM0St+wAhgmx7uwflXlcImRhn6An9WYPHIc+qZQ9
         VhUSy6djLWm8jnzCsboEJHN9Xv5W4/ectCwU8xHPyCOzl9Cjp07Py95Q/TU4Z3f6K2WV
         +EW6QttUt3R9AkwIimZmUmR17AbuCKrbIjSHFKPn/W10HiJ/iuTJovy+F2h7oTHHYY02
         ej9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224225; x=1793829025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVkrmmtCx8Wz/yMOuP0167k9m9+QdMkDrba4QH5xysg=;
        b=bBCGgTzo6j/PC79qGyZIXgWNMUVFj7mybSf+8MsQaJHppkFT40jw52q3Eq+4KSQgYM
         KVbEWng3YxVHllGe0o4Q5jhcTA2MC6Klw1WSxpPnFzNo7vN5U6uB0oKqYZ7yqWMr7xhN
         ma7uXzCRyjdrQocZVkYXpMHgkayhbdD+ACvKwImBinT33WtU1GNnIjBto6cTQOYz2Kjc
         W+kSZ4yh+2BuRUD0rOWZTik3GSL1Ec26KG822xbyLHAAkIZ4zqBHEnTZnkk0LvX/Dxb3
         9/IOGiU/BBdJ9WFAi2e77pvQSN+DJusW1h7RPpQTyKv5qidVxkXj3tNPTrlt3X6iiKSd
         Y+Qg==
X-Forwarded-Encrypted: i=1; AKwUvBz0tx6mYVFp8y1KKxMQdleUE6PHIog5kzA6yiE56KZ7an6bKTKgFrk96uFhQZsxGu59vBI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ+hUcWgw940+FnwG7+0pt18VkdBQUCTZc0CBDyt0PykX3KH/M
	yW+ThWCo72jb00D2po+hY4K5CVWXloWHKbyBAWAoHa8nCl8XEMhDaax7yKqxYM2b4u1GJI30HOo
	oDCHX7PXU2OV+U+bVgmp8w7v4u6kP+/ki/OZsoJmP
X-Gm-Gg: AYBFou3x0HRy09DlWubpPCYQ+jMwf/5uWE8etJrY/DvrUl4qCd6tVavImpQc31Nmg+s
	JeR7mtLElcBiZ/Q41NhEEUIT+8S6+JVCE1W0tTkSCYCaq6+DxouGvW+LstOjoDqXiIRTlgCqgCU
	siFI31yZIfEC/ARXslqLpJgOyqs6ae67Tj8ZxpMJdy+LUXbQtz9Br3S5W5x3bFgQDBhn1pa0b+u
	D5Z8eObsNvUTfDAr445I7jfjsnzPHmMnWR1jdvnTdKS/YWbpdahM4EjmHwXy/VBjhNpUc6HgX80
	D5SgEpJfj3c/csE3TFoF8hTStA9q2oFz0P1rd4PYsusD0JKsG3w0TJfV2E5uj4BJ/buyCCgdlfz
	/g/RQ6P/tyx2rofAR47vqFmM6tdy0htiH7zN8
X-Received: by 2002:a05:622a:5c0b:b0:533:9731:f0f1 with SMTP id
 d75a77b69052e-5414df1402dmr3259361cf.10.1793224224056; Wed, 28 Oct 2026
 14:50:24 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-15-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-15-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 14:50:09 -0700
X-Gm-Features: AclHuK-liHGzIvCMjGYc6qSRUa3UjMY3TGndjwxwFoPElrqbY_zUPbSfw_KI05g
Message-ID: <CALMp9eRypTqSvMUes6PVB8z30EcppLJ3i_votpMnJOawP1c4sA@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] KVM: x86/pmu: Ignore AnyThread bit if
 CPUID.0AH:EDX[15] is set
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
> Intel PerfMon v5 introduces the ANYTHREAD_DEPRECATION capability
> (CPUID.0AH:EDX[15]) to indicate that AnyThread counting is deprecated
> and that writes to the AnyThread bit in IA32_PERFEVTSELx are ignored.
>
> When ANYTHREAD_DEPRECATION is present in the guest CPUID, emulate the
> architectural behavior and silently ignore writes to the AnyThread bit
> instead of injecting #GP.
>
> Continue to inject #GP when ANYTHREAD_DEPRECATION is not present in the
> guest CPUID, e.g. for PerfMon v3/v4 guests or when the capability is
> not configured for a PerfMon v5+ guest.
>
> Advertise CPUID.0AH:EDX[15] only for PMU version 5+ guests, since the
> bit doesn't exist below version 5.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Advertise anythread_deprecated only if kvm_pmu_cap.version >=3D 5.
> - Add the missing AnyThr bit handling for IA32_FIXED_CTR_CTRL.
> - Update the comments to be clearer.
> ---
>  arch/x86/kvm/cpuid.c         |  2 +-
>  arch/x86/kvm/vmx/pmu_intel.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 63201d4ea4a1..ef208906b3ee 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1542,7 +1542,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_=
array *array, u32 function)
>                                             KVM_MAX_NR_FIXED_COUNTERS);
>                 edx.split.bit_width_fixed =3D kvm_pmu_cap.bit_width_fixed=
;
>
> -               if (kvm_pmu_cap.version)
> +               if (kvm_pmu_cap.version >=3D 5)
>                         edx.split.anythread_deprecated =3D 1;
>
>                 entry->eax =3D eax.full;
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index c7472778137a..599c69dfa6e3 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -446,6 +446,12 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
>                 if (data & pmu->fixed_ctr_ctrl_rsvd)
>                         return 1;
>
> +               /*
> +                * This is to emulate ANYTHREAD_DEPRECATION. Guests witho=
ut
> +                * support for it would have had the write rejected by
> +                * pmu->fixed_ctr_ctrl_rsvd above.
> +                */
> +               data &=3D ~intel_pmu_fixed_ctrl_bits(pmu, INTEL_FIXED_0_A=
NYTHREAD);
>                 if (pmu->fixed_ctr_ctrl !=3D data)
>                         reprogram_fixed_counters(pmu, data);
>                 break;
> @@ -494,6 +500,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, s=
truct msr_data *msr_info)
>                         if (data & eventsel_rsvd)
>                                 return 1;
>
> +                       /* See above comments for MSR_CORE_PERF_FIXED_CTR=
_CTRL. */
> +                       data &=3D ~ARCH_PERFMON_EVENTSEL_ANY;
>                         if (data !=3D pmc->eventsel) {
>                                 pmc->eventsel =3D data;
>                                 pmc->eventsel_hw =3D data;
> @@ -603,6 +611,17 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>         pmu->pmc_exists64 =3D (BIT_ULL(nr_gp_counters) - 1) &
>                             kvm_pmu_cap.cntr_mask64;
>
> +       /*
> +        * AnyThread counting is not supported by KVM due to cross-VM
> +        * information leakage concerns on SMT cores. Therefore, AnyThrea=
d
> +        * remains unavailable for PerfMon v3/v4 guests, where AnyThread
> +        * deprecation is not enumerated.
> +        */
> +       if (pmu->version >=3D 5 && edx.split.anythread_deprecated) {
> +               pmu->eventsel_rsvd &=3D ~ARCH_PERFMON_EVENTSEL_ANY;
> +               fixed_enable_bits |=3D INTEL_FIXED_0_ANYTHREAD;
> +       }
> +

According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"), only
Fixed Counters 0, 1, and 2 have an AnyThread bit (bits 2, 6, and 10 of
IA32_FIXED_CTR_CTRL). FC3 has never had an AnyThread bit;
IA32_FIXED_CTR_CTR[bit 14] is reserved in PerfMon v5 and becomes
METRICS_CLEAR_EN in PerfMon v6. Passing INTEL_FIXED_0_ANYTHREAD to
intel_pmu_fixed_ctrl_bits() will wrongly clear bit 14 in
pmu->fixed_ctr_ctrl_rsvd once Fixed Counter 3 is enabled.

On hardware with CPUID.0AH:EDX.ANYTHREAD_DEPRECATION[15] =3D 1, if software
sets the AnyThread bit in IA32_PERFEVTSELx or IA32_FIXED_CTR_CTRL and then
reads the MSR back with RDMSR, does hardware return 0 for the AnyThread
bit, or does it return 1 but otherwise ignore the bit?
