Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246EA220F49
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710760; cv=pass; b=ac5bGl0HQm7SgRRpNxBMl358/0OphbuSbd2kP7mQycZ0ta44vuzQ8yx7xG/ko8Xpxa/2Wa6IQpCMbCmY1w4jQfAuaVZIKf4eL1rWN/hGhggHXZd5cvFnqrE5c5TXzyGNq6b0zsSXPLSm50qqJg2U96bkDMWBcW7hS6NMBavcENQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710760; c=relaxed/simple;
	bh=DnvqOOF+ITAq2SzDf4iKVHLDx18iuL+m82CTXlD5y0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GA5xIONZ9B4UUkyhgZNAencEyZtOlgpTyZ5YxKX1U1+VMgAkRHEoYv0ZXaG24LgkJwGybKhHJpFHZwmK21piqN5pNz8Pciy/0wNvEjmKKw2rWRl8SQFHbGkqpdotC2vPdlB2FnYQPIGz5RR8BgeVdQNgNFxItN7d2VQ5aPIPDVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+jKFc1e; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+jKFc1e"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso4753a12.1
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 21:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775710757; cv=none;
        d=google.com; s=arc-20240605;
        b=XUtChi6JXDqMokzzUlJo0x0biQ9djXLRET1b21yx2Am0EOkk2dOEYEmTOmaxJHHt2y
         HRy0dg26bbW1op5BrJAZMlxnOBbA4Alb4/NtGxiR/IX/1mMQn57Gg52+MQ0+eJJNe+04
         x4L/oDPLaB9tzKxW7XhUeFVz0nmMw2bwTyzEBvpo+YIn9JJ2BFPDtSd9cHuUxfcze5jH
         yhKoAFS7ls0yMdcg24NMwjskwgsFvtVNwquB/oMp9i3P3u2xcKiYr7ZvlnH5P7q5rfuN
         UZpq8ho8KM8TRe5JFf7m6uNLrS0mqsOlDGwJTVCn6m9uXs/+3h33I4K2RFymcZvIB04v
         VANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EzCd/9dlVN5v6Ko0k4ev8I8DqI68kkGDXc0pAYHHS+o=;
        fh=iunG0WwBN+h7UNzQFVKwEB7rHQDkyVX8en5tnPAicss=;
        b=UJ1OA5oW/c9lG0G209IzQVKZrpwcIJ/aMe0m4bcz048L9L9Vjeh5lghtqXPoi0Keoo
         157a59eqzZ7y8KS/SvL2k8IAhGKe+qWM4wyh0OFNWRzGn0BIMTXvmO3GA4FHL+XXAEYW
         cuP39KROKZorDbh2KQf/Q+kIIpuiWckVg6WPFq4apHG30VX2deviiNdz2b6Dmx4l7uYe
         cp5mPOjguuvJyymyCOU9l6j0PvwOAqpjY4kUDG8QDDZyWQCu+oooJyNqjP9YO3Mg72e6
         LVOgkiO4OCOQcf//6p44qlqKgUI/MYnMUV6EraOzP0TpxUNZdAtgkPgepm0FJI5Ilcp2
         djHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775710757; x=1776315557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzCd/9dlVN5v6Ko0k4ev8I8DqI68kkGDXc0pAYHHS+o=;
        b=q+jKFc1ePtJJEvr4NZBhJaVl240mexZof+hM1xVYsZd0+ERTDSTy4mQztz3uC+16w1
         UG3TJMG/RnMAFFFkMhrt0SP/k9NTd7tLROe2pqxCZaKRPCPTd908ZUAbaXNsnOvsPX3j
         vzxDX2eRVLPRoy+/34Fb5fain5PgvWXZ2sCHB6j9RlUPKMx9WFY0RyEcZUrEE549S18u
         eoJpxMWIxpY8y4KDyaRrCxH5m8+OZg42t310Ha9keNiZfLmFjW3b7Nvm5rcmlscSu+95
         LS6nWDvPbXwhz/A2sLFTvN3h+9A1QN+LlchDqJQ0SBkLwzSopi0bR05+57fRUdjzW6el
         vC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710757; x=1776315557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EzCd/9dlVN5v6Ko0k4ev8I8DqI68kkGDXc0pAYHHS+o=;
        b=j/hkIzAuzYLb1l1kqzZawwC/n80kVyE+MYZSjZ9BCDAZGsZj87Xc4dJ9kB/6rO2IjH
         xWvsD7ZR9gKii90yFhe+7M+dlZ/LecIwRhMKM15wvPA5thCiPpO17/EZI4H1AO567/PI
         +vNK6ftnamqfmag+Jo1QjCXtNIG7Pnsny/eSahEI+4yQpQvjy09nenuSPx5yUi8Q0aMw
         r3/eT8VvDBE+41M2bVv/I9oVCqCfdxCJFD81WIeWFlbKbsJi0e6A/BkgOjz/kW/iJWUB
         IZxP8hyMnKzhA4O5eYZByijg6tyFOqX8Dqglvc4F/A76Mu1GCgwb29/p267zJoh3dQx+
         O8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWd3Y/yDrXycHc5Dm7dJSDp5TYsZRpVDLR/61yxBhsPDUI3IOWNEcCvNlC57VEq0tBVHX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydFv77DxRlEKdoV8llR1IEpjePrgDCF+CI+mpkF5A8HpbFdG0r
	LSXR1h2sGbDkFrfOt+c16STwJ2WsUQNWUOxD74Y3RQrGUVLQqPYkc3GaKJptniXPxwkFWJk2ATs
	r5vZRJiSgX4vpwk8SQ8hef5/wSO6gcBhtIpjHKQfQ
X-Gm-Gg: AeBDieslZaSUW4nmIfFPnaZTLo9CBKOGgNiJPtXfkYhwIoc0+FQw5HrUc/Fn8+WLaWE
	s8TujY0UswjSs+KlTmKewm5DU4Jhbbn4BdWhdODmVY1vtFq37Lm1uacc1OkQVZVVO3vNxnAnjwV
	uGo0oDXFpjm6OuiLu5VQQo52AtE8EHrdIYbbdCWezASDNxyjXGINr45jSJdIjjeEBxmL8W7c7RG
	Mdejw8VI+daaMzEZQQ+IB2KYAlruGKzEDK3nGezUOODWzIBQlIhRKQy8zpPx5bwgQmgKYttpKiP
	sydZrI4=
X-Received: by 2002:aa7:c302:0:b0:66f:9da6:bd33 with SMTP id
 4fb4d7f45d1cf-67011382d9bmr26345a12.14.1775710756745; Wed, 08 Apr 2026
 21:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
In-Reply-To: <20260326031150.3774017-5-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 8 Apr 2026 21:59:04 -0700
X-Gm-Features: AQROBzB-Sc7AWvWU_aN3Nn0eMbFZZmB2RLGbdW1PWsiHwSUpY-1SIhrwjb7cqi0
Message-ID: <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 8:12=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Reprogram all counters on nested transitions for the mediated PMU, to
> re-evaluate Host-Only and Guest-Only bits and enable/disable the PMU
> counters accordingly. For example, if Host-Only is set and Guest-Only is
> cleared, a counter should be disabled when entering guest mode and
> enabled when exiting guest mode.
>
> Having one of Host-Only and Guest-Only set is only effective when
> EFER.SVME is set, so also trigger counter reprogramming when EFER.SVME
> is toggled.
>
> Track counters with one of Host-Only and Guest-Only set as counters
> requiring reprogramming on nested transitions in a bitmap. Use the
> bitmap to only request KVM_PMU_REQ if some counters need reprogramming,
> and only reprogram the counters that actually need it.
>
> Track such counters even if EFER.SVME is cleared, such that if/when
> EFER.SVME is set, KVM can reprogram those counters and enable/disable
> them appropriately. Otherwise, toggling EFER.SVME would need to
> reprogram all counters and use a different code path than
> kvm_pmu_handle_nested_transition().
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
> ...
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index bdbe0456049d0..fb73806d3bfa0 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -248,6 +248,19 @@ static inline bool kvm_pmu_is_fastpath_emulation_all=
owed(struct kvm_vcpu *vcpu)
>                                   X86_PMC_IDX_MAX);
>  }
>
> +static inline void kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcp=
u)
> +{
> +       struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> +
> +       if (bitmap_empty(pmu->pmc_needs_nested_reprogram, X86_PMC_IDX_MAX=
))
> +               return;
> +
> +       BUILD_BUG_ON(sizeof(pmu->pmc_needs_nested_reprogram) !=3D sizeof(=
atomic64_t));
> +       atomic64_or(*(s64 *)pmu->pmc_needs_nested_reprogram,
> +                   &vcpu_to_pmu(vcpu)->__reprogram_pmi);
> +       kvm_make_request(KVM_REQ_PMU, vcpu);
> +}

In general, this deferral is misguided. The G/H bits should be
re-evaluated before we call kvm_pmu_instruction_retired() for an
emulated instruction.

> ...
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index f1c29ac306917..966e4138308f6 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -9,6 +9,7 @@
>  #include "kvm_cache_regs.h"
>  #include "kvm_emulate.h"
>  #include "cpuid.h"
> +#include "pmu.h"
>
>  #define KVM_MAX_MCE_BANKS 32
>
> @@ -152,6 +153,8 @@ static inline void enter_guest_mode(struct kvm_vcpu *=
vcpu)
>  {
>         vcpu->arch.hflags |=3D HF_GUEST_MASK;
>         vcpu->stat.guest_mode =3D 1;
> +
> +       kvm_pmu_handle_nested_transition(vcpu);
>  }

This happens too late for VMRUN, since we have already called
kvm_pmu_instruction_retired() via kvm_skip_emulated_instruction(), and
VMRUN counts as a *guest* instruction.
