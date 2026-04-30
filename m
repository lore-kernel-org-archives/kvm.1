Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039434D385
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591463; cv=none; b=Q0pO02xcrbzxM3KovdDm9F4LwuatAnB35fX1+NYyqwmNnFWbmcIfxBAUG+LEbYjSh4SXmSG33jgVdrlI5ZygtlsEC6JKQ5uTkiugYTZz07e/pBbv4cjzbmTT1WcBLBF48KK8D/1HGlO1F8YLHlbsyGQjnysn4nfAlcGloN5PZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591463; c=relaxed/simple;
	bh=w1lweLcjjg0Qfs5vsUT2w1GKty2lmuv55R41cHzFcr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZ/FR3ZwctqTWSKUSpM3qGeTHe0UpZZbN8TTa07EV+n9Bpp0g1W6uY5NAxbzPZjqsYLmwVhYzqRA12aYjGbD9LqTaYskQ+LygVLIfM9z2wGYLSmsww7IlT3uW+8X3iSMrAE4rPdKbpzYAaPTT+qhovKjPS9CW9R1caozXBTGa3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClH4o6AG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClH4o6AG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF70BC2BCF4
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 23:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777591462;
	bh=w1lweLcjjg0Qfs5vsUT2w1GKty2lmuv55R41cHzFcr0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ClH4o6AGdhTDS4fkU1lqg78E94Y/cAj5TRwhYK/Ql/Vc60rYHol5OnuMtIESPuVbX
	 vmS/eFFhy6yxvA0k/u5LNGpdjajz8/8QHp6kD42DmZUe23K+xxPI4NhOzUdTEuuWXK
	 hxTUX1e8GgtWlaOjMWSkgcIMneizlE3Fxn6v23m43KwScn0+25iFEMptjO/KiDxH0V
	 oC2GJyF/r+HomAKwaWbOsLjRFU5VOZGyS3ozNAn77bx8L5I0yr1OlTJKmcD9qo7EkO
	 AhkEgSBrUXRcTYKC00HSwdb9l+yhtfo5zqF4sX93uqo3TL6xoD4vcsEaXArkLHxuER
	 igIU+WMan2gJg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso190516066b.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 16:24:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ829WFSIs15Qcv+43uqMzjJ9h24ESof/wBbp78CXLdRHf3EqyPR1L2DcC3L2z7kGzfB/QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdM0Wdh4RIOrliSSwmUqn8MEXuk2llK9O8tFIXzyQTk5cA/olg
	Lsn7Ue7gLZRgMYqmq4qQZROT/vflMnOpvGQdCJ4bW8iFoBstjZGgGABBL1HVS8p6kmOgnqsGBxF
	Cx5u6JhG/O/asYavsR8S8v2B9J1dDnk8=
X-Received: by 2002:a17:907:6d15:b0:b98:595c:a76f with SMTP id
 a640c23a62f3a-bbac61ba9e8mr331134066b.16.1777591461396; Thu, 30 Apr 2026
 16:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430202750.3924147-1-yosry@kernel.org> <20260430202750.3924147-8-yosry@kernel.org>
In-Reply-To: <20260430202750.3924147-8-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 30 Apr 2026 16:24:09 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
X-Gm-Features: AVHnY4JGu4jLc02AIHLgSwmwN3L5kduB0UvxiUM1kGlBPgCQ-Trl6GN9EhrEdLk
Message-ID: <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 0e99022168a85..0c372b9f8ed34 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -36,6 +36,7 @@ struct kvm_pmu_ops {
>         void (*reset)(struct kvm_vcpu *vcpu);
>         void (*deliver_pmi)(struct kvm_vcpu *vcpu);
>         void (*cleanup)(struct kvm_vcpu *vcpu);
> +       void (*reprogram_counters)(struct kvm_vcpu *vcpu, u64 counters);
>
>         bool (*is_mediated_pmu_supported)(struct x86_pmu_capability *host_pmu);
>         void (*mediated_load)(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 7aa298eeb0721..fe6f2bb79ab83 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -260,6 +260,48 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *vcpu)
>                 wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
>  }
>
> +static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_vcpu *vcpu,
> +                                                   struct kvm_pmc *pmc)
> +{
> +       u64 host_guest_bits;
> +
> +       if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> +               return;
> +
> +       /* Count all events if both bits are cleared */
> +       host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
> +       if (!host_guest_bits)
> +               return;
> +
> +       /*
> +        * If EFER.SVME is set, the counter is disabledd if only one of the bits
> +        * is set and it doesn't match the vCPU context. If EFER.SVME is
> +        * cleared, the counter is disable if any of the bits is set.
> +        */
> +       if (vcpu->arch.efer & EFER_SVME) {
> +               if (host_guest_bits == AMD64_EVENTSEL_HOST_GUEST_MASK)
> +                       return;
> +
> +               if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu))
> +                       return;
> +       }
> +
> +       pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;

Sashiko raised a good point here. In the following patch, we reprogram
the counters synchronously on nested transitions to update the
counters' enablement before counting VMRUN or WRMSR(EFER.SVME).
However, this updates pmc->eventsel_hw while
kvm_pmu_recalc_pmc_emulation() checks pmc->eventsel to check if the
counter is enabled.

I think either pmc_is_locally_enabled() needs to check
pmc->eventsel_hw or we need to update pmc->eventsel here.

AFAICT, pmc->eventself has the value written to the MSR, so I think we
want to keep that as-is.

On the other hand, ARCH_PERFMON_EVENTSEL_ENABLE is cleared in
pmc->eventsel_hw in kvm_mediated_pmu_refresh_event_filter() if the
event is not allowed, and kvm_pmu_recalc_pmc_emulation() has a comment
about intentionally ignoring event filters.

We can also separately track enablement for nested purposes, but that
would add one more thing we need to check aside from general counter
enablement and event filtering.

None of these options are ideal, perhaps directly clearing the bit in
pmc->eventsel would do the least damage as (pmc->eventsel &
ARCH_PERFMON_EVENTSEL_ENABLE) is only checked by
pmc_is_locally_enabled().
