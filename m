Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80A8450F2
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764767; cv=pass; b=FzsFlk/AxDLfltqYp009NXElpp1VscxJeCWcr9mvRq/9e0zkKDTCnU0fyKnqjH1XQJayufzNmzkARvuSYQhVRFOSUaXOyhOebS3pPsAuWE7a27R0lqlGjrFpHgfVij6QA8lFAJMZOKgCcb4CwMWRe+pr6/BXETN3M11QyxviCaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764767; c=relaxed/simple;
	bh=9ICCk+OyIj4L7gOwVp8C185KAvEAgb6yccg57WP1JdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fwnJ88I4VWb421RTr7gw9YZ0gwiqBFkTETtwRLrL+49d7KJDJ/LpwKK3xZ/8CcmKRQViaX+E6Td+dS/j9qftxJjsZlRisq8bAYY9RMz0WWvbPtJPyXIFVglwDval7h0yt/yahXx9lBKpDMbWCF3ubOZ3Ex8ACgbpqOIuWjYr8Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXZNxTfb; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXZNxTfb"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so7914a12.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 06:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778764764; cv=none;
        d=google.com; s=arc-20240605;
        b=a5UmT4EqraAr8Gb2FX3H7IMhp21iuIqaraYMKj0UL/ORAUK8AmjqG9xJ8MSwIQdCw4
         c4HkDYHLeHiTDAUXzYY9/CanLQqAJ4StO8zDhpgXqzHvuRZEYGnFh4CqGDfJwE7YXrSU
         Zjhb9G0g/4mFyZRP9Lga67vst1cv2teHhLzmKz8rS7+xalSC8x0q/HuLEsmhPHTjJRa2
         DB520FK2CxGKyPnRO4aUOs/w34KAdlbU00mo4IcvxcwM6BAX5tUtTtug+QpRpeMrwizW
         R6764ROefZpt59jrfrDoUM2XZ6y1M6aLsdeoW8KpxiGa89pdPcnP0qL82NxWziXcFRJo
         Mz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y25x6EGUZpuJV22gmOWO4iW0decpRTYPeoGdvBoHF4Q=;
        fh=2BfowOTTscqRf5wrx8Uzw7jmcdYKKlBFrf6RErd3uh0=;
        b=GsPVeZYNhwZ/iPEJhB1c5Q54BzPWpFN8Kbn+dUdi4q0RupPDj4bvo5E6Jf1ccADLJ8
         Lg9TLEgLMNH4zPrObH858UqohwHcHAhwC4p0dUE1Bpjit3kHTjKvJoIp8a+zNYejlKKS
         yKCnC8k5l9GA0vcfquVDujDVJyBsd4moQPrvJMgTWhj3Sm1GfPOpQc7sJ9pNHnSvwNnb
         DfhDqNe+g3s8Y3sZxtodmAtIDkaTf6VKGwsdD8ipcaMLF85sItztn/BFEyZb+h050s0u
         17shR7pSlQ1iWoC5ev+4UGof1G+Zl+2Aju/sJbCMAMtrbNEpksI85Nu2EZ5TC/Q0+WCa
         VYRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778764764; x=1779369564; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y25x6EGUZpuJV22gmOWO4iW0decpRTYPeoGdvBoHF4Q=;
        b=pXZNxTfbZCpaIuLlsxLdzI9HtwQPuoYWNY7ATKkxYVhb3JgQ1foNjBMztkaUN3dr2x
         OcHRT3+hu+n4XyuoU7HIQh5ZYscUFDJAQgaCJJHHqtF1nwsW8R9rInewkjUuFBi8lCII
         pA31gJGhQ+XG6h3iEN9jrWg1j4bw+QtT6sBHeMbbJ72RE7LwQiXwHOosejMUwYxeIipd
         clfiobpfLtuYaS9t8I4/+sQg4E2ujkDnH09pr6ERb+kIMs7wgdubv9POlEIxHR0cRHkD
         3z85ZIGFKu4eteXYc+CsWs3QqinimvG7aGpNje+n73fKZcjjMQUgvyzGhkHQiMxh/dGQ
         S9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778764764; x=1779369564;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y25x6EGUZpuJV22gmOWO4iW0decpRTYPeoGdvBoHF4Q=;
        b=a75/uQUYukfOTcjfK8hJeWoEFRvIP8CbrEdoWrOTSfnaY41F9T3z6pNK6YCWX0fkGk
         ixOg+v4ggFDezGHfSV7zPQ5fg6potWz6Zrs5TF+c4Ry6rEb2DeaALRcxW7/7ZUTDG6bR
         W0fvzjhQwjuj10U8geg6TIQyn36SX57YiwT1AbniufIBWh4xMkHAYQFU3bLz4qEWJ53f
         TDj9E0RmPKukhZq4RU1+gQ+VL2ZhswRbsu3jBem3/2r/tmZ+lgLgNaX1cJj8oom+VXhO
         AxglL7u5+ntG7zCMQjec7UtRyAeC5ZNMat0gAg73kPEMwfBXw1m+qsSJZzujwRcCfryl
         ledQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OV9FSh/K55Mae2Wl0ZFyTf5vEz7kYHiu0fJ2kI2jqBL+9Gz/Ulamo9TT9ocDnEB+FYyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mMJdNSGPwecF/C9mtv8+ca2BiKdOLx7D79G8EY+EzaQJ3Jp2
	SSLG/3DeDdBgNwkTGT2VOCWRYaXssni1PV0Q7/AXRvs8AIqzrhttKSIZfHSBOu1MB9mQKi5CCAY
	Bf/trRPOAhz/4YXTmF0T80bEK0nw687oIDuT67ka1tR+ZpYj7XxEt7QfTZNI=
X-Gm-Gg: Acq92OE9imY2KQ4rcHXLuc7GHt2VqaFZlwV84wnCJsbyjIN9KZKcAiiCFB/PAPMxgkH
	MQ+ud6h1RGErOpVdOBSrcXUI2NvswMMdHKaRrjgNKARWVU7pwbmytfoXiVkFIMrZ/cPbkMvU6Lm
	aShFSkjJp1U0JUGWhO7r8hkD7rIKkgPfUJmsWKiXDpY+zcoziD34sE1SFQC03RuDEZhkB4GbltE
	1wLsqpYe0w8mH/N+jTNvcNshldfVdLxgvgfRHAQV3o7rIiF6AqlUtLng3eP1cxArHKpQvFZAjrG
	G7skutKoVRj4oH7yYg==
X-Received: by 2002:a05:6402:2238:b0:670:9e9f:1a5e with SMTP id
 4fb4d7f45d1cf-6830f43b08emr39904a12.2.1778764763802; Thu, 14 May 2026
 06:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com> <20260513224608.1859737-4-jmattson@google.com>
In-Reply-To: <20260513224608.1859737-4-jmattson@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 14 May 2026 06:19:11 -0700
X-Gm-Features: AVHnY4LivttTNL3HjqWlJlQ4S9FC-nQBWB86x_2g_vxGuW5W--oiKXnJqk7-Eb0
Message-ID: <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 3:46=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On AMD CPUs, CPUID faulting support is advertised via
> CPUID.80000021H:EAX.CpuidUserDis[bit 17] and enabled by setting
> HWCR.CpuidUserDis[bit 35].
>
> Advertise the feature to userspace regardless of host CPU support. Allow
> writes to HWCR to set bit 35 when the guest CPUID advertises
> CpuidUserDis. Update cpuid_fault_enabled() to check HWCR.CpuidUserDis
> as well as MSR_FEATURE_ENABLES.CPUID_GP_ON_CPL_GT_0.
>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/include/asm/msr-index.h |  1 +
>  arch/x86/kvm/cpuid.c             |  2 +-
>  arch/x86/kvm/cpuid.h             |  5 +++--
>  arch/x86/kvm/x86.c               | 18 ++++++++++++------
>  4 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index 6673601246b3..0eeae121b0a6 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -888,6 +888,7 @@
>  #define MSR_K7_HWCR_IRPERF_EN_BIT      30
>  #define MSR_K7_HWCR_IRPERF_EN          BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT=
)
>  #define MSR_K7_HWCR_CPUID_USER_DIS_BIT 35
> +#define MSR_K7_HWCR_CPUID_USER_DIS     BIT_ULL(MSR_K7_HWCR_CPUID_USER_DI=
S_BIT)
>  #define MSR_K7_FID_VID_CTL             0xc0010041
>  #define MSR_K7_FID_VID_STATUS          0xc0010042
>  #define MSR_K7_HWCR_CPB_DIS_BIT                25
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 1c95d1fa3ead..8e5340dd2621 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1248,7 +1248,7 @@ void kvm_initialize_cpu_caps(void)
>                 F(AUTOIBRS),
>                 EMULATED_F(NO_SMM_CTL_MSR),
>                 /* PrefetchCtlMsr */
> -               /* GpOnUserCpuid */
> +               EMULATED_F(GP_ON_USER_CPUID),
>                 /* EPSF */
>                 F(PREFETCHI),
>                 F(AVX512_BMM),
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 95d09ccbf951..fc96ba86c644 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -185,8 +185,9 @@ static inline int guest_cpuid_stepping(struct kvm_vcp=
u *vcpu)
>
>  static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
>  {
> -       return vcpu->arch.msr_misc_features_enables &
> -                 MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
> +       return (vcpu->arch.msr_misc_features_enables &
> +               MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
> +               (vcpu->arch.msr_hwcr & MSR_K7_HWCR_CPUID_USER_DIS);
>  }

Sashiko raises a good point here about a pre-existing issue that
probably warrants a fix before propagating it further:

> Does this emulation of CPUID faulting respect architectural fault priorit=
ies in a nested virtualization scenario?
> According to the AMD APM, if CPUID faulting is enabled, a #GP fault takes=
 precedence over a CPUID VM-exit intercept.
> Because KVM emulates CPUID faulting in kvm_emulate_cpuid(), the fault che=
ck happens after nested VM-exit intercept checks. If an L1 hypervisor enabl=
es both CPUID faulting and a CPUID VM-exit intercept, L0's nested exit hand=
lers will observe L1's intercept request and immediately reflect the VM-exi=
t to L1.
> Since this reflection happens before evaluating kvm_emulate_cpuid(), does=
 this allow L2 guests to completely bypass the CPUID faulting restrictions =
imposed by L1?
