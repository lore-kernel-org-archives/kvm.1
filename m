Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558B536B928
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843271; cv=pass; b=pxlVHX1KmSbdA8j1cgft+J9hyRH9ygpg2ad7Fjz4it18CkMRDuMUcXfQN7gELm1A+gtzHHcYtWEwoVYNVerm1IQb2clz47Q2eIZxcD7BZOMTF9xVjAkqTZcPfwUobMK2HFknr6Vm5+u6wjgcyzfJdCm3YYO+eMUpCg0UumC7KL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843271; c=relaxed/simple;
	bh=d3SpETdU7HWL5mFxQmlAXCuDOvPf1EcITRNFk+WOaIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oadcC1HB2arEKxyNhEvQhvdIEc3wxpNka9ggfhR/m0DGDpKO1+1z6uex7Arwp8c+lD+xaTkZom1CTjtmIUQLN083yN8QpJMUTH6MKiNtUXMbPk5WUsYlCiBJGYW7k8i+DOznLQ1LzINVKJwXXlQXb2s62THvkSiDcLfWjsKoY7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UI94nLXn; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UI94nLXn"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so1545a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784843267; cv=none;
        d=google.com; s=arc-20260327;
        b=nUM8shHTqBEL2PEBnWkdcZDxkPE912cKYklrBwjxmYkKUkwN+NyRNADSm3v86hk02d
         tHZeg/CkFruXDeO+NmFEZHhg0/jlKvCXzOMJUiVqoGg47hFHYOgoWv2ZIyUj4IfYnJPH
         yinEP+Qb0pW2Qory5a5sUVdUYSMSO3p1+/Dya38NbQai2LVHuKVjUQkHINiFgMw4nAWO
         ahkXrMRESmu6X6z3Z7T1oz3Ijm0x7M6kyVxt6Dm57zQZKOvg1Y9/N3r2SsDvpj/5+7Zn
         VTGe91pkJk1JB8U9Ncidxl2rE92O6EGJSaVNW3/24qmiMdv/Fh1AixBXBvAkpXW8ZQZi
         +Gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ax4AluIJ+SHy+UQHzjw3OCrtHQ2jyJNCc1qXAjEnvKU=;
        fh=JeO+v/KEtWbDoG2MAasp7KZVbr8xxOX1qp2BIMdDd+M=;
        b=dNSpEHBNx5tgSnW3JO9tmM8RCth70gsOExEOeCLTsRFovc0Phtk0qDedYaXJQ3xZkT
         AlH3qwCPWRgzRuET631U+36mPDkVVE4/ND0nLHQTumKuhUmhfhKvKMTcS8N4pGKEzQfu
         ZtWRxhFP9ZWfotXa8f0iYdtPaDTHABPxizwan5Bgr5ANHZCGg9YNmFXgiHsemdTLWGel
         6vDYvBZpjGiqoUIvS8hkHZ/wIexpqFYQnTXaHb0mxUpIsxaHPt66HoOIoam5LmkjCVce
         mSdjc5QBU7o97MjUS2bx6ZMw3k99VlrgGruAe3RhMCFZ6eYmT15lTEfKL+KtaWeiqMzk
         PvTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784843267; x=1785448067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ax4AluIJ+SHy+UQHzjw3OCrtHQ2jyJNCc1qXAjEnvKU=;
        b=UI94nLXn/ebAM/QghHGKNo5ekmTElAlzqFONZSG2K2wm09RMpLHZuGCtR95Goka+0l
         Z3/hfoxb0x/MTJCMCKByvDlvd3Yyy3br6eOTeTEZ+79yRXqqvSFIIjtg6pwfpoKkLK8a
         YhpgXNCfrxZ+I33gI2nuG2znEGTpe6aJYb2ynuQiIWGk/T0Vz6aLLMOaVGpOEAzZbndE
         x4BzJ0zNwbUoMYmjScDWYOoIEdlqVrRm3b/vEjSp8U6g1STpcOD0V1dq6dQf4C8LIr1z
         QL6cDoE5LDStIE/kbyBuRk+nvoDa7X75Xp+9uMPzXzTQaxDX9crw3JCmBzQgrD4v08dc
         Hm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843267; x=1785448067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ax4AluIJ+SHy+UQHzjw3OCrtHQ2jyJNCc1qXAjEnvKU=;
        b=Rx8dVdAn42pDB9P7WxQa+DSbGa+svzHdrd5OqMmH2qlEfN3Uh4dGfFf8Vvhn13+/zG
         F9h1ytdlL4K+XS8E5IH5D6mWXYVXe0FraEPsb0ZxDQu1+bIjrjbxCzY60iVzCDL1iggc
         YYGO7IsaLPv94D4gFTRpf0NsXV6OCXzB4Ntk0nYfogwC5pebEmnw64Pdn0x5Dxph/brm
         ypUBOsYD5gCUvI6pQo1mMbi5+kWvebqpaxl+oalFfLxWwumZCHkmN0iaFT1ZInxFCWLW
         jPIe9L3cr6R0DcNWiZs05qXPigxA/6eoYpg4JiEPSGvonvDnZnpuVGrRPLUGLMEbDVxk
         nj4A==
X-Forwarded-Encrypted: i=1; AHgh+RrV/rwQlRGsOqwikRFT7ejbXAbXDlBPPLBKYtvmamSyMS9RRqWTYVZuC7BmrOXwBhcNVTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rxsvp87QwEdObTro0GhoeidUWU894hfUMzMMKK+qdq6LflAG
	MOEhQRbhpfS3NCUQWBIj9g+wWX4EpmNTYXdthruRvMfyCfp20878wKZp799+6+87opzOmzwH7KM
	CXltFqJkjX9FaPMbljV0iCFoGg2SsCoxsdHq0J8pw
X-Gm-Gg: AR+sD117VdKuguZ69IhSRPhmPHAa+g2Q7FtcOZNtIx9XfGRSHS3ePqgEx01UtJ6BMvE
	QC0xBUo0tU5puk6PadBw/lUs9yh0vpYMiOfZiJYPv09f+bP4VhfXfnjCQwg9hKfa6Oat+fYclI4
	JqAr6lvw0Ijg5EDaukWvBKQFJg0pvn7sB4Y/Q7dMjcE/kHmzn6NDKIcVaX2pcZothB3OXMmLcGc
	PCQI8x2FzubcCEbg44CWe3IHNsTiTX0Q/P2AYO70w9qDwctI2p1BvVcJ9rD+dVaUnW5AvWW
X-Received: by 2002:aa7:dccc:0:b0:69a:df95:f1f8 with SMTP id
 4fb4d7f45d1cf-69f8ed6a2c0mr20095a12.2.1784843266795; Thu, 23 Jul 2026
 14:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707183405.15571-1-zide.chen@intel.com> <20260707183405.15571-9-zide.chen@intel.com>
In-Reply-To: <20260707183405.15571-9-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 14:47:34 -0700
X-Gm-Features: AUfX_mxP6Y38oZWhwFmph-5wt0lEPX1Eii5wBkZanjwm2qjMT-arn4A5DN87y38
Message-ID: <CALMp9eTYWFvB-ji31Mu=vzJo2HFPL0jZFAiXVGpJx-H8S2mHOw@mail.gmail.com>
Subject: Re: [PATCH 08/15] KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:44=E2=80=AFAM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
> starting with PerfMon v5, and support non-contiguous GP counters
> through the Architectural PerfMon Extension (CPUID leaf 23H).
>
> struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
> which may contain sparse bits representing non-contiguous counters.
> Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
> bitmask fields.
>
> CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
> counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
> the number of consecutive counters starting at index 0.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/kvm/cpuid.c         | 14 +++++++++++---
>  arch/x86/kvm/msrs.c          | 12 ++++++------
>  arch/x86/kvm/pmu.c           | 34 +++++++++++-----------------------
>  arch/x86/kvm/svm/pmu.c       |  2 +-
>  arch/x86/kvm/svm/svm.c       |  9 +++++----
>  arch/x86/kvm/vmx/pmu_intel.c |  7 ++++---
>  arch/x86/kvm/vmx/vmx.c       |  7 +++++--
>  7 files changed, 43 insertions(+), 42 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 2698fa42cd97..151a4794f834 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1514,10 +1514,18 @@ static inline int __do_cpuid_func(struct kvm_cpui=
d_array *array, u32 function)
>                 }
>
>                 eax.split.version_id =3D kvm_pmu_cap.version;
> -               eax.split.num_counters =3D kvm_pmu_cap.num_counters_gp;
> +
> +               /* Contiguous GP counters only. */
> +               eax.split.num_counters =3D
> +                       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
> +                                           KVM_MAX_NR_GP_COUNTERS);
>                 eax.split.bit_width =3D kvm_pmu_cap.bit_width_gp;
>                 eax.split.mask_length =3D kvm_pmu_cap.events_mask_len;
> -               edx.split.num_counters_fixed =3D kvm_pmu_cap.num_counters=
_fixed;
> +
> +               /* Contiguous fixed counters only. */
> +               edx.split.num_counters_fixed =3D
> +                       find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
> +                                           KVM_MAX_NR_FIXED_COUNTERS);
>                 edx.split.bit_width_fixed =3D kvm_pmu_cap.bit_width_fixed=
;
>
>                 if (kvm_pmu_cap.version)
> @@ -1882,7 +1890,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_=
array *array, u32 function)
>
>                 cpuid_entry_override(entry, CPUID_8000_0022_EAX);
>
> -               ebx.split.num_core_pmc =3D kvm_pmu_cap.num_counters_gp;
> +               ebx.split.num_core_pmc =3D hweight64(kvm_pmu_cap.cntr_mas=
k64);
>                 entry->ebx =3D ebx.full;
>                 break;
>         }
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index c751a8dbd45d..7524d019f1be 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -2631,20 +2631,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>                 break;
>         case MSR_ARCH_PERFMON_PERFCTR0 ...
>              MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
> -               if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=3D
> -                   kvm_pmu_cap.num_counters_gp)
> +               if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_PERFCTR0) &
> +                     kvm_pmu_cap.cntr_mask64))
>                         return;
>                 break;
>         case MSR_ARCH_PERFMON_EVENTSEL0 ...
>              MSR_ARCH_PERFMON_EVENTSEL0 + KVM_MAX_NR_GP_COUNTERS - 1:
> -               if (msr_index - MSR_ARCH_PERFMON_EVENTSEL0 >=3D
> -                   kvm_pmu_cap.num_counters_gp)
> +               if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_EVENTSEL0) &
> +                     kvm_pmu_cap.cntr_mask64))
>                         return;
>                 break;
>         case MSR_ARCH_PERFMON_FIXED_CTR0 ...
>              MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
> -               if (msr_index - MSR_ARCH_PERFMON_FIXED_CTR0 >=3D
> -                   kvm_pmu_cap.num_counters_fixed)
> +               if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_FIXED_CTR0) &
> +                     kvm_pmu_cap.fixed_cntr_mask64))
>                         return;
>                 break;
>         case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 3647ce3f0e3f..bc2ca60114e9 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -20,7 +20,6 @@
>  #include <asm/perf_event.h>
>  #include <asm/cpu_device_id.h>
>  #include "x86.h"
> -#include "cpuid.h"
>  #include "lapic.h"
>  #include "pmu.h"
>
> @@ -136,8 +135,6 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_=
ops)
>  {
>         bool is_intel =3D boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTE=
L;
>         int min_nr_gp_ctrs =3D pmu_ops->MIN_NR_GP_COUNTERS;
> -       union cpuid10_edx edx;
> -       u32 eax, ebx, ecx;
>
>         /*
>          * Hybrid PMUs don't play nice with virtualization without carefu=
l
> @@ -159,8 +156,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_=
ops)
>                  * there are a non-zero number of counters, but fewer tha=
n what
>                  * is architecturally required.
>                  */
> -               if (!kvm_host_pmu.num_counters_gp ||
> -                   WARN_ON_ONCE(kvm_host_pmu.num_counters_gp < min_nr_gp=
_ctrs))
> +               if (!kvm_host_pmu.cntr_mask64 ||
> +                   WARN_ON_ONCE(hweight64(kvm_host_pmu.cntr_mask64) < mi=
n_nr_gp_ctrs))
>                         enable_pmu =3D false;
>                 else if (is_intel && !kvm_host_pmu.version)
>                         enable_pmu =3D false;
> @@ -180,23 +177,14 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pm=
u_ops)
>
>         memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
>         kvm_pmu_cap.version =3D min(kvm_pmu_cap.version, 2);
> -       kvm_pmu_cap.num_counters_gp =3D min(kvm_pmu_cap.num_counters_gp,
> -                                         pmu_ops->MAX_NR_GP_COUNTERS);
> -       kvm_pmu_cap.num_counters_fixed =3D min(kvm_pmu_cap.num_counters_f=
ixed,
> -                                            KVM_MAX_NR_FIXED_COUNTERS);
> +       kvm_pmu_cap.cntr_mask64 &=3D
> +               GENMASK_ULL(pmu_ops->MAX_NR_GP_COUNTERS - 1, 0);
> +       kvm_pmu_cap.fixed_cntr_mask64 &=3D
> +               GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
>
> -       /*
> -        * Currently, KVM doesn't support non-contiguous fixed counters; =
make
> -        * sure only contiguous ones are retained in kvm_pmu_cap.
> -        */
> -       if (kvm_host_pmu.version >=3D 5) {
> -               cpuid(0xa, &eax, &ebx, &ecx, &edx.full);
> -               if (kvm_pmu_cap.num_counters_fixed > edx.split.num_counte=
rs_fixed)
> -                       kvm_pmu_cap.num_counters_fixed =3D edx.split.num_=
counters_fixed;
> -       }
> -
> -       if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > 3)
> -               kvm_pmu_cap.num_counters_fixed =3D 3;
> +       /* Legacy vPMU exposes at most 3 fixed counters. */
> +       if (!enable_mediated_pmu)
> +               kvm_pmu_cap.fixed_cntr_mask64 &=3D GENMASK_ULL(2, 0);
>
>         kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =3D
>                 perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
> @@ -796,8 +784,8 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcp=
u *vcpu)
>          * KVM's capabilities are constrained based on KVM support, i.e. =
KVM's
>          * capabilities themselves may be a subset of hardware capabiliti=
es.
>          */
> -       return kvm_gp_pmc_mask(pmu) !=3D BIT_ULL(kvm_host_pmu.num_counter=
s_gp) - 1 ||
> -              kvm_fixed_pmc_mask(pmu) !=3D BIT_ULL(kvm_host_pmu.num_coun=
ters_fixed) - 1;
> +       return kvm_gp_pmc_mask(pmu) !=3D kvm_host_pmu.cntr_mask64 ||
> +              kvm_fixed_pmc_mask(pmu) !=3D kvm_host_pmu.fixed_cntr_mask6=
4;
>  }
>
>  bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 02cf960a215a..d519eba518bf 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -208,7 +208,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>         }
>
>         pmu->all_valid_pmc_mask64 =3D (BIT_ULL(nr_gp_counters) - 1) &
> -                                   (BIT_ULL(kvm_pmu_cap.num_counters_gp)=
 - 1);
> +                                   kvm_pmu_cap.cntr_mask64;
>
>         if (pmu->version > 1) {
>                 pmu->global_ctrl_rsvd =3D ~pmu->all_valid_pmc_mask64;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 3b3e98b6abb6..002cdd074fd7 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -754,6 +754,7 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_=
vcpu *vcpu)
>         bool intercept =3D !kvm_vcpu_has_mediated_pmu(vcpu);
>         struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
>         unsigned long gp_mask =3D kvm_gp_pmc_mask(pmu);
> +       unsigned long host_only_gp_mask;
>         int i;
>
>         if (!enable_mediated_pmu)
> @@ -769,7 +770,8 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_=
vcpu *vcpu)
>                 svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i=
,
>                                           MSR_TYPE_RW, intercept);

Our internal Sashiko says:

This is a pre-existing issue, but does the legacy MSR intercept need to be
reverted here as well when gp_mask shrinks?
When guest PMU capabilities are updated and gp_mask shrinks, the new
host_only_gp_mask loop correctly reinstates the intercepts for
MSR_F15H_PERF_CTR. However, looking at the code just above this hunk in
svm_recalc_pmu_msr_intercepts():
    /* Legacy counters are always available for AMD CPUs with a PMU. */
    for_each_set_bit(i, &gp_mask, AMD64_NUM_COUNTERS)
        svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
                                  MSR_TYPE_RW, intercept);
There does not seem to be a corresponding loop to reinstate the intercept
for MSR_K7_PERFCTR0 + i.
If userspace initially exposes 4 counters, disabling intercepts for
MSR_K7_PERFCTR0 through MSR_K7_PERFCTR3, and later updates CPUID to expose
only 2 counters, could the removed legacy counters remain unintercepted?
This sequence might allow an unprivileged userspace to grant the guest
direct read/write access to host MSR_K7_PERFCTR MSRs without KVM
intercepting them.

> -       for ( ; i < kvm_pmu_cap.num_counters_gp; i++)
> +       host_only_gp_mask =3D kvm_pmu_cap.cntr_mask64 & ~gp_mask;
> +       kvm_for_each_set_pmc_idx(i, host_only_gp_mask, AMD_GP)
>                 svm_enable_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 =
* i,
>                                              MSR_TYPE_RW);
>
> @@ -5574,9 +5576,8 @@ static __init void svm_set_cpu_caps(void)
>                  * access to enough counters to virtualize "core" support=
,
>                  * otherwise limit vPMU support to the legacy number of c=
ounters.
>                  */
> -               if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE=
)
> -                       kvm_pmu_cap.num_counters_gp =3D min(AMD64_NUM_COU=
NTERS,
> -                                                         kvm_pmu_cap.num=
_counters_gp);
> +               if (hweight64(kvm_pmu_cap.cntr_mask64) < AMD64_NUM_COUNTE=
RS_CORE)
> +                       kvm_pmu_cap.cntr_mask64 &=3D GENMASK_ULL(AMD64_NU=
M_COUNTERS - 1, 0);
>                 else
>                         kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_COR=
E);
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 31422bd20d96..425f17aa9be2 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -518,7 +518,8 @@ static u64 intel_get_fixed_pmc_eventsel(unsigned int =
index)
>          * have a known encoding for the associated general purpose event=
.
>          */
>         eventsel =3D perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
> -       WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed)=
;
> +       WARN_ON_ONCE(!eventsel &&
> +                    (kvm_pmu_cap.fixed_cntr_mask64 & BIT_ULL(index)));
>         return eventsel;
>  }
>
> @@ -575,7 +576,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>         pmu->available_event_types =3D ~entry->ebx & (BIT_ULL(eax.split.m=
ask_length) - 1);
>
>         fixed_cntr_mask =3D BIT_ULL(edx.split.num_counters_fixed) - 1;
> -       fixed_cntr_mask &=3D BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;
> +       fixed_cntr_mask &=3D kvm_pmu_cap.fixed_cntr_mask64;
>
>         /*
>          * The number of counters comes from guest CPUID data. Clamp the =
value
> @@ -583,7 +584,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>          */
>         nr_gp_counters =3D min_t(int, eax.split.num_counters, X86_PMC_IDX=
_MAX - 1);
>         pmu->all_valid_pmc_mask64 =3D (BIT_ULL(nr_gp_counters) - 1) &
> -                                   (BIT_ULL(kvm_pmu_cap.num_counters_gp)=
 - 1);
> +                                   kvm_pmu_cap.cntr_mask64;
>
>         entry =3D kvm_find_cpuid_entry_index(vcpu, 7, 0);
>         if (entry &&
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0a6880bb7ebe..2a59bbe52bd8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4226,6 +4226,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kv=
m_vcpu *vcpu)
>         bool has_mediated_pmu =3D kvm_vcpu_has_mediated_pmu(vcpu);
>         struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
>         struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +       unsigned long host_only_gp_mask, host_only_fixed_mask;
>         unsigned long fixed_mask =3D kvm_fixed_pmc_mask(pmu);
>         unsigned long gp_mask =3D kvm_gp_pmc_mask(pmu);
>         bool intercept =3D !has_mediated_pmu;
> @@ -4248,23 +4249,25 @@ static void vmx_recalc_pmu_msr_intercepts(struct =
kvm_vcpu *vcpu)
>
>         vm_exit_controls_changebit(vmx, vm_exit_controls_bits, has_mediat=
ed_pmu);
>
> +       host_only_gp_mask =3D kvm_host_pmu.cntr_mask64 & ~gp_mask;
>         kvm_for_each_set_pmc_idx(i, gp_mask, INTEL_GP) {
>                 vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
>                                           MSR_TYPE_RW, intercept);
>                 vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i, MSR_TY=
PE_RW,
>                                           intercept || !fw_writes_is_enab=
led(vcpu));
>         }
> -       for ( ; i < kvm_pmu_cap.num_counters_gp; i++) {
> +       for_each_set_bit(i, &host_only_gp_mask, INTEL_PMC_MAX_GENERIC) {
>                 vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
>                                           MSR_TYPE_RW, true);
>                 vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i,
>                                           MSR_TYPE_RW, true);
>         }
>
> +       host_only_fixed_mask =3D kvm_host_pmu.fixed_cntr_mask64 & ~fixed_=
mask;
>         kvm_for_each_set_pmc_idx(i, fixed_mask, INTEL_FIXED)
>                 vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 =
+ i,
>                                           MSR_TYPE_RW, intercept);
> -       for ( ; i < kvm_pmu_cap.num_counters_fixed; i++)
> +       for_each_set_bit(i, &host_only_fixed_mask, INTEL_PMC_MAX_FIXED)
>                 vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 =
+ i,
>                                           MSR_TYPE_RW, true);
>
> --
> 2.54.0
>
