Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733A3D9DBA
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758639; cv=pass; b=jDXcDQ+rOivO0gpLraulxmHAcUQA6gqJ0MtuqxpuzAKOCKb5ui8vwlcBLfK3K8azuL7G2oVlxqNVeAsUmKbeI6WviFMYh6glyN5189USFCs0WF57LalhxDgwrBUPL6RK2Wlvgyki/z/vqmd/x6MCfUPLrkcNQSLaRnhWEiODwq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758639; c=relaxed/simple;
	bh=4ToVA20FSGMvo/phv3ifi9KkkXDHnBrCgQOq6C7eok4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXPs73k+1uNpQc94eKgLnqs45zQNTsvlT0Te4S6KjuSRinzWL1lYyVCirOKtjxRqRo0jyI7Wx8GMRuO+SlXXdazi9VMWONSmR5jA60a+FChLHjrzX5P9w9Ls3mDJNeC86AljGnMIFEUsFkiarfV99Lve07eYAIx41/y+2aOlaSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FsCDZwEZ; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsCDZwEZ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c01c79467so89621cf.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784758636; cv=none;
        d=google.com; s=arc-20260327;
        b=Du9STKEUk0unFbKsl/ktuQfjEX5zc8MaeBpKR5NIyhNxUMffLo8wZz7WJ90ymgqYkH
         RdoEkJwFxehKk4u4mednInj+V7F/9m163/wu3ZIQKU3SQ5l2ySyWkzEcaCoARrFKLtkp
         WMPNrBbkK4W4yM2lDuBUrHmC2HPkx5An3Q4TRr1YdegfsHDWjjkpjssnE5/0bpWFrq24
         jOKbCm/CFOAN5Gz6rX1uRdeedEyZY76z/Ps9K+F6xqt/ut0YCRCB/arxeqbNH1F2E+Ke
         kHb38Vw85IKnKUqKVLua4B0w7BAUunAkwNp0/kJG0m6TQloWgFXpJvyTi/MPjjdQr6Kw
         bVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d22CEwn150DL9jjuujDZfyRJhB3qURoF29Y1nbP4I8s=;
        fh=lEccua3YvbNm18ClMpp7QLdhiL+BqmPW5RuX7C8VaD0=;
        b=JSRZlzBoXZWEu/xlEk+xAuaQS6eWCTsH9EBAU5M3VNMMHaxIqh2BEihawTbYFP0s9f
         KvEEtwSo/+lnJbmkOKj0lolAHuXr0XSLr6XQPDhhpjBUj+AceS5u7UJWKz7Qjfx6W3jn
         7VYGkbHauoFnAJ6xJ29G57IjK7ul0E0RDnv2pL/P+gZRGHYJK6gzbgpNlVGZczRsFBHt
         lU4Uv8ESSiMaMRr+KrAmbDl4T+1Ei2g5fJhwp6eWqfYSF7ZVRIywY9cZgrnzHX4/7Rtx
         9qEdEXOmMIDO4kYGE9wa6Jzr4F9aizHA2NbwP8szoRHFrbZWLODM+oR1ucbVPGkhYsMT
         QVmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784758636; x=1785363436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d22CEwn150DL9jjuujDZfyRJhB3qURoF29Y1nbP4I8s=;
        b=FsCDZwEZ8n6SwqHhZmtq/vLk2AqkadIGlz3IzOPn68fQvP04tI8zJkZRewk5p0s9rQ
         8MVlaf4tN7MGR/wIYooWlRKbvHH7n1xnHP+SC97pgypx+a6r3KM0Wd4lu2XCC5gtdqwO
         7xoOJDIm4wAmGVYZHAM2346UI4hzUB3tdVHerZkOx+YEAvalwRKaC4eWeFyECYe+LeOc
         yoTEVp2TFjJ/w7aT1MH2fVkb6pJs6N5pxtza5XwCgRZcAl+Db/vIWMe1LrS9he7sXN1V
         RXBhJBlymMb3Grck1lVXCXufBujBjqLNGvjKGAeymDDxU6KZthCqXbM8FbXsL/7GHbWT
         5ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758636; x=1785363436;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d22CEwn150DL9jjuujDZfyRJhB3qURoF29Y1nbP4I8s=;
        b=LqoF6aWPKUTQFdG+HuA4f9JV8MjBy6RtVQiZIE6SvZ43odx3DGruuuEEBUkvrl8RSm
         FCf6fJHf7wG4y6MvPNUjwzK8uPuA7EYkgZx3LujYtM5/Sa9VyNRah34BI+njWmHTMgkE
         Bxq/Ugp9vhiNO4eLfXn4V+182VyFFRzcZ8yoqXkh3YtB/nRhtj3e4pm+MWYxhdeSoxJt
         NAbboqa6CLgVHPRqTM2iHlJ0gHUB+8UBgm/5MDRRJUr8NxNru+rAVN4aTHie6qjXXSFX
         YaPvxAsppstoMcQiCQqy4sfCvwsw9X8pqQ36jGBWuoNNWHu4bm1Kh/ev3BP6PNh4s35J
         d1xw==
X-Forwarded-Encrypted: i=1; AHgh+RqNZ/dyzqQWmnAXyKLaRsMDrGr2KQxYMa77gNvsoqfpI20uaDMW/WdAv7HK9apwfQoKp1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35d8yPlxqhLApO4xG2HdcWjEH7KLSKgZX/hZeO5Ak24ODbOQ8
	dh8XTftSaGL0oF8+tbfEYBDUq17WQN7zVq3fYqSov7uzoZLg7a48BxB5avSFEjqDecz9br0cTe+
	iO60khxa1idqisO5WpfBKMNz8wY1tVVbmuTeVHbxm
X-Gm-Gg: AR+sD12SdL2IScblC1b1x+28WsBL2S18rI5Hi4qNPFAiVo2iZFrs1sc/9xGYXaDYSXn
	oJdhnfJ1DBe/TxQOLMbzcf8phTVADsif7ez9WJmYoTt2XJge+uDI5AJgUwCymxPw/fFo5PeX6Dx
	914ByBLzqrqvZeXOCqjIE4Q3bX5rzF31iqC/QTW66zQLrinj1zAlGN7YqMrbJeJ/HH05BOzb/ad
	LqUMfjdGLVzJgFLI0oXwMZirdkhTrBT0/Eg19x4dDCxgvux6vdRuMVh8duflg==
X-Received: by 2002:a05:622a:1b07:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-5283bbeaf9amr3579581cf.16.1784758635771; Wed, 22 Jul 2026
 15:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-3-zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-3-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 15:17:01 -0700
X-Gm-Features: AUfX_myire5_saEJy6KGv-uCCOKllE6qlVMfHNvGIJQoAWM2IV7m6BxO0BUaE0c
Message-ID: <CALMp9eQoHnj2QYBtOZisjB4oTaAUeoWbk3Hoj4+CdTGD2EJB3Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] KVM: x86/pmu: Support Intel fixed counter 3 on
 mediated vPMU
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
> Starting with Ice Lake, Intel introduced fixed counter 3, which counts
> TOPDOWN.SLOTS - the number of available slots for an unhalted logical
> processor.  It serves as the denominator for top-level metrics in the
> Top-down Microarchitecture Analysis method.
>
> Emulating this counter on legacy vPMU would require introducing a new
> generic perf encoding for the Intel-specific TOPDOWN.SLOTS event in
> order to call perf_get_hw_event_config().  This is undesirable as it
> would pollute the generic perf event encoding.
>
> Moreover, KVM does not intend to emulate IA32_PERF_METRICS in the
> legacy vPMU model, and without IA32_PERF_METRICS, emulating this
> counter has little practical value.  Therefore, expose fixed counter
> 3 to guests only when mediated vPMU is enabled.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v6:
> - Update comments to replace 2 with KVM_MAX_NR_INTEL_FIXED_COUNTERS - 1.
> v3:
> - Move the non-contiguous counter filter code to pmu.c
> v2:
> - Don't advertise fixed counter 3 to userspace if the host doesn't
>   support it.
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/msrs.c             |  4 ++--
>  arch/x86/kvm/pmu.c              | 18 +++++++++++++++++-
>  3 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index d8700eb848b4..dc9e4e8bfc07 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -609,7 +609,7 @@ struct kvm_pmc {
>  #define KVM_MAX_NR_GP_COUNTERS         KVM_MAX(KVM_MAX_NR_INTEL_GP_COUNT=
ERS, \
>                                                 KVM_MAX_NR_AMD_GP_COUNTER=
S)
>
> -#define KVM_MAX_NR_INTEL_FIXED_COUNTERS        3
> +#define KVM_MAX_NR_INTEL_FIXED_COUNTERS        4
>  #define KVM_MAX_NR_AMD_FIXED_COUNTERS  0
>  #define KVM_MAX_NR_FIXED_COUNTERS      KVM_MAX(KVM_MAX_NR_INTEL_FIXED_CO=
UNTERS, \
>                                                 KVM_MAX_NR_AMD_FIXED_COUN=
TERS)
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index c230b18d87e3..3bf42d90ad14 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -228,7 +228,7 @@ static const u32 msrs_to_save_base[] =3D {
>
>  static const u32 msrs_to_save_pmu[] =3D {
>         MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
> -       MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
> +       MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
>         MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
>         MSR_CORE_PERF_GLOBAL_CTRL,
>         MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
> @@ -2688,7 +2688,7 @@ void kvm_init_msr_lists(void)
>  {
>         unsigned i;
>
> -       BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS !=3D 3,
> +       BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS !=3D 4,
>                          "Please update the fixed PMCs in msrs_to_save_pm=
u[]");
>
>         num_msrs_to_save =3D 0;
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 62d0ed99ebe9..f82ba63767d0 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -99,7 +99,8 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] =3D=
 {
>   *        all perf counters (both gp and fixed). The mapping relationshi=
p
>   *        between pmc and perf counters is as the following:
>   *        * Intel: [0 .. KVM_MAX_NR_INTEL_GP_COUNTERS-1] <=3D> gp counte=
rs
> - *                 [KVM_FIXED_PMC_BASE_IDX .. KVM_FIXED_PMC_BASE_IDX + 2=
] <=3D> fixed
> + *                 [KVM_FIXED_PMC_BASE_IDX .. KVM_FIXED_PMC_BASE_IDX +
> + *                  KVM_MAX_NR_INTEL_FIXED_COUNTERS - 1] <=3D> fixed
>   *        * AMD:   [0 .. AMD64_NUM_COUNTERS-1] and, for families 15H
>   *          and later, [0 .. AMD64_NUM_COUNTERS_CORE-1] <=3D> gp counter=
s
>   */
> @@ -134,6 +135,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_=
ops)
>  {
>         bool is_intel =3D boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTE=
L;
>         int min_nr_gp_ctrs =3D pmu_ops->MIN_NR_GP_COUNTERS;
> +       union cpuid10_edx edx;
> +       u32 eax, ebx, ecx;
>
>         /*
>          * Hybrid PMUs don't play nice with virtualization without carefu=
l
> @@ -181,6 +184,19 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu=
_ops)
>         kvm_pmu_cap.num_counters_fixed =3D min(kvm_pmu_cap.num_counters_f=
ixed,
>                                              KVM_MAX_NR_FIXED_COUNTERS);
>
> +       /*
> +        * Currently, KVM doesn't support non-contiguous fixed counters; =
make
> +        * sure only contiguous ones are retained in kvm_pmu_cap.
> +        */
> +       if (kvm_host_pmu.version >=3D 5) {
> +               cpuid(0xa, &eax, &ebx, &ecx, &edx.full);
> +               if (kvm_pmu_cap.num_counters_fixed > edx.split.num_counte=
rs_fixed)
> +                       kvm_pmu_cap.num_counters_fixed =3D edx.split.num_=
counters_fixed;
> +       }

Nit: Should this CPUID.0AH decoding be left to perf? Perhaps struct
x86_pmu_capability should include an additional field:
num_contiguous_counters_fixed?

Reviewed-by: Jim Mattson <jmattson@google.com>
