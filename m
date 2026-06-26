Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7281CAA68
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782435023; cv=pass; b=EGn/ZeRjpaFA3ajaRtkJADf6AmCWYv03JTm0cxThKPRXlT12LDWSLBNArgOw46wRPMOr8JJN2BxJPni1S0HWBLzQmE2NJ1zxb+bcaQDv4dsZN6NBnNTrLUf5v43zTpTVhBXoLTKjbw9absY5FJFmT+4idZOtRWb61Ar1fgbWwTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782435023; c=relaxed/simple;
	bh=CqxMa2BdZtijcwLS2L1MlCR0M0V7HrJ5csdOu8LCdQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lhFNkDhmZcyXldXggVN2sHmK/WicGUIEnOryO1V2GigTeb8EH2DoC9zP1wON0GVkbJ57zDUCGtWbFwaBrOtmpJRhBlML9OhXDyK0nRmtbjRArVWeo+4C05hHl8pl6ySYp6WLAKWLmz3tJbHZ2BKsKcRpu6KmFVSH7q8r3DnXRdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=J0/cjlgD; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="J0/cjlgD"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59d7db12342so201397e0c.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 17:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435021; cv=none;
        d=google.com; s=arc-20260327;
        b=MhYWX6pzn+kouvd83bWMYKPHQYzlGUXOAdkWydH/WNUJkPenVPEr2MbzucIQEXylMD
         kUx2FG31dvIHOzxvOZFjVoxtBSKQknpaibQnQYr1NlOIIvjPBzxy271DPiwKuiGFIqsx
         KzKocfcnnO2TtHwcC0pX1uSenUzfJn7DmJ3Q2B8anaXrmSnMIyE+DTcY6OrcCm3Ptzm0
         ybthS3UShov/sDpOj5bzFZwNmsFFJt6gHzlXNrPrWwufx9V6xxD1zKKuvk4Q+TC0yZzH
         /eV1kuxwVTXEVfvV+Zn1d81rOkBha0+S0aSvZyCwhvDm0WL/v66M0mgPJA5KsbeSRonT
         S65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BqQCfvlMdspaXATh6pvzxGuSsYISWZsRSeThdGphm0U=;
        fh=xTtn1uyyg/6OUx32ziRmU0Q7IhiHgE/5EyeEpbyOW38=;
        b=F3j+pI6A8LFo1N94AGxYyqNypukEQfHOzoyfYYc6Rm+aAe8c4AycdhJYIG0K65QrrH
         vw8Nc4yh+1UEt15AyMuOAu22pbut3EB3q7b8dVZ9TX0HWnBa1OL3EoK3Obt7n0OTD4LM
         RAgIDNlsc8b5QeH8aPnWFp2DZqaKoJv9q22rJzc0F4G3Ftl1OZKzlhPV9MEtI7Dk713k
         XZmcKs0uMlhVNB7qJ5/w/V9FxCBgef5J7psXO9GDNCZDJdDcmgRj9wLRWXsYzgid5hk7
         6egilQWzzPmiKxPyfv4oz0Ebt5QNGFXKWfSQgW4xMKacba+UHUhEgAGBRBsvov9bCOno
         sP6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1782435021; x=1783039821; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqQCfvlMdspaXATh6pvzxGuSsYISWZsRSeThdGphm0U=;
        b=J0/cjlgDPof2OX++i68SEsvOpa/4c1bWHEcfm4UM2prb87Jd3AulfXg3ra6DvtFxHL
         Nmynu2JdJAjZM8sWow+2V2bmDVC989QTqg04HK/yE9mU+l+iNr1OJXo0uDRb61ZX4aI2
         SJhYdWz3RJMcBI1cMPQzotImRaRtBFAufyulI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782435021; x=1783039821;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqQCfvlMdspaXATh6pvzxGuSsYISWZsRSeThdGphm0U=;
        b=qENzLnd/Ws40U29CwncxkYQ4duYHMomN8YbdjZqLIaPKIs9FMc/P4xEyMxuFICgDYF
         /Ec5OjxOjvZE1tmSsllGS28CTlUU+AgINYGf+YiWZ8llR2Pk8IhHPLHpTPgtVSKtkHV5
         97GvOkdSdmEwQt8Vms3/uFjjRgtLZ9yFVhaS+DH8AdvPLb7yTuQXB6h7KXqNgUaaIWAH
         wlKkiTtgRiPeI4V465nADUG0I19tfmjWqsGaaDwICjLz5/6hALQhlXOQW0Nc2FWt029f
         ZHvTfHo7BrggBywUxqzovq0tXG3bpxKcwzxHbUKI8OTxPbpXJz8d6AKIP+/3+pBjuQ75
         fkSw==
X-Forwarded-Encrypted: i=1; AHgh+Roh/5ZFRWiZTcOYmUWXo50iY+Q6L70xzB6Ehy++EN14W13lpiMb7jydA8f6UYfPoZ5wGfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUOKHlZdHhbHaZTu4hiHOclkLkNKc6fkxz8hLR1PmPT3VGpJj
	6Pu7tgv5AsNWufU5bWPsgO89BMJXrnSBngVobYieEJBCY6MmP4IlMJ/94Lyq8IewKt3Gi6rxRqD
	nSP6+QQ1z9/govA0ovoUMTpSS59RPvEr1o6QbufVGc4Ien26x+x5mCPOfJA==
X-Gm-Gg: AfdE7cnzfaOvweBFCVsXFq+bwL7CNYpklVyweNfqBVme18x2aPJrWwrrPR+PVBYxjTJ
	G7lLgT5C0eVraWYWtKxu5yxH+iqrf8ql2lKzK8ciC36/h1itZmHzf/tb1X0CDT3YFANPrBfVsoO
	7/tSQdb6bj7/LEBtrTCeGpQuZ9uxnUhz4c5/9KzuMUc7LVw9VPqq9b5nkAvnCC+oWaYewUnIaUM
	gDRZQHn50RP8jnKC4Mac03TsliXyaGdcmRI+OKeNRQcbsAMfB2mzVK7l6MB6g1kj+HNN0pT5g==
X-Received: by 2002:a05:6122:7d0:b0:56a:fff5:b4d6 with SMTP id
 71dfb90a1353d-5bd69dc5b2fmr2355161e0c.4.1782435020693; Thu, 25 Jun 2026
 17:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602140348.774203-1-anderson@allelesecurity.com> <20260602140348.774203-2-anderson@allelesecurity.com>
In-Reply-To: <20260602140348.774203-2-anderson@allelesecurity.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Thu, 25 Jun 2026 21:50:05 -0300
X-Gm-Features: AVVi8CeJehDJerDlbCkjrru-3HwZDmENMGLl3AYEjyWjtgkFiQESrM4n-Vq5pNI
Message-ID: <CAPhRvkygtCgfHaD5eHT-aFKSnQ1OA9-YBDOFNNwX+SukYFrhPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF passthrough
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	zhao1.liu@intel.com, mtosatti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:05=E2=80=AFAM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> Introduce support for exposing and enabling APERF/MPERF MSR passthrough
> for x86 QEMU guests when running under KVM.
>
> The Linux kernel supports a KVM capability allowing the hypervisor to
> disable read intercepts on the IA32_APERF and IA32_MPERF MSRs, enabling
> guests to track effective frequency directly without VM-exits. QEMU
> currently lacks a native way to request this capability or expose the
> corresponding feature bit to the guest.
>
> This patch adds the `aperfmperf` feature flag via `FEAT_6_ECX`
> (CPUID.06H:ECX[bit 0]). To ensure safe tracking across power states,
> the flag ties into QEMU's existing host power management framework.
> When host CPU power management is explicitly requested by the user
> (via `-overcommit cpu-pm=3Don`) and the `+aperfmperf` flag is provided
> to the CPU, QEMU will invoke the KVM ioctl to drop the APERF/MPERF
> MSR read intercepts.
>
> This implementation allows guest operating systems (such as FreeBSD
> or Linux) to dynamically calculate CPU utilization and turbo-boost
> metrics without incurring performance overhead from hypervisor trap-and-
> emulate loops.
>
> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> ---
> Changes in v2
> - Added migration flags
> - Link to v1: https://lore.kernel.org/all/20260602022048.752453-1-anderso=
n@allelesecurity.com/
>
>  target/i386/cpu.c     | 18 +++++++++++++++++-
>  target/i386/cpu.h     |  2 ++
>  target/i386/kvm/kvm.c |  5 ++++-
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 8929a75c7c..544738d406 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1544,6 +1544,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =
=3D {
>          .cpuid =3D { .eax =3D 6, .reg =3D R_EAX, },
>          .tcg_features =3D TCG_6_EAX_FEATURES,
>      },
> +    [FEAT_6_ECX] =3D {
> +        .type =3D CPUID_FEATURE_WORD,
> +        .feat_names =3D {
> +            "aperfmperf", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid =3D { .eax =3D 6, .reg =3D R_ECX, },
> +        .tcg_features =3D 0,
> +        .unmigratable_flags =3D CPUID_6_ECX_APERFMPERF,
> +    },
>      [FEAT_XSAVE_XCR0_LO] =3D {
>          .type =3D CPUID_FEATURE_WORD,
>          .cpuid =3D {
> @@ -8770,7 +8786,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
>          /* Thermal and Power Leaf */
>          *eax =3D env->features[FEAT_6_EAX];
>          *ebx =3D 0;
> -        *ecx =3D 0;
> +        *ecx =3D env->features[FEAT_6_ECX];
>          *edx =3D 0;
>          break;
>      case 7:
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 67e2ecf325..87864969c7 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -700,6 +700,7 @@ typedef enum FeatureWord {
>      FEAT_SVM,           /* CPUID[8000_000A].EDX */
>      FEAT_XSAVE,         /* CPUID[EAX=3D0xd,ECX=3D1].EAX */
>      FEAT_6_EAX,         /* CPUID[6].EAX */
> +    FEAT_6_ECX,         /* CPUID[6].ECX */
>      FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=3D0xd,ECX=3D0].EAX */
>      FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=3D0xd,ECX=3D0].EDX */
>      FEAT_ARCH_CAPABILITIES,
> @@ -1232,6 +1233,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU =
*cpu, FeatureWord w);
>  #define CPUID_XSAVE_XFD        (1U << 4)
>
>  #define CPUID_6_EAX_ARAT       (1U << 2)
> +#define CPUID_6_ECX_APERFMPERF (1U << 0)
>
>  /* CPUID[0x80000007].EDX flags: */
>  #define CPUID_APM_INVTSC       (1U << 8)
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 9e352882c8..ca722ff9e9 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -498,6 +498,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, ui=
nt32_t function,
>          }
>      } else if (function =3D=3D 6 && reg =3D=3D R_EAX) {
>          ret |=3D CPUID_6_EAX_ARAT; /* safe to allow because of emulated =
APIC */
> +    } else if (function =3D=3D 6 && reg =3D=3D R_ECX) {
> +        ret |=3D CPUID_6_ECX_APERFMPERF;
>      } else if (function =3D=3D 7 && index =3D=3D 0 && reg =3D=3D R_EBX) =
{
>          /* Not new instructions, just an optimization.  */
>          uint32_t ebx;
> @@ -3291,7 +3293,8 @@ static int kvm_vm_enable_disable_exits(KVMState *s)
>          disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
>                            KVM_X86_DISABLE_EXITS_HLT |
>                            KVM_X86_DISABLE_EXITS_PAUSE |
> -                          KVM_X86_DISABLE_EXITS_CSTATE);
> +                          KVM_X86_DISABLE_EXITS_CSTATE |
> +                          KVM_X86_DISABLE_EXITS_APERFMPERF);
>      }
>
>      return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
> --
> 2.54.0
>

ping

Is there anything I should do to get this patch applied?

--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com
