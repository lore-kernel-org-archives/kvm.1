Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210255;
	b=mja3kVt0927SjwEhnQwOQ7AGJtkQwSOffrHPkZm7WpbDoJAqUh1R5CcC26yqU8VcMXZ6
	 jtCUA2mFV2SLqWRgwuXqVfzUbqy7O1sqGcW1jH7/AHRocJIsq4b+WiEI1Dqko/XDfUlNt
	 2zzPAnc4QTxr05C6LpGcZHqPN1H9go1hGFLSAeNSfLlnqei6c8NhLZNwVBeTT61oOwYCE
	 EW9FHDYHETiqutHfkkcpj6ha5OsW1Jg8I3XKmca8br4tLy/YZ9LtuzbOWXH08gIvsf+cq
	 hlAZv3U75DGWJUF6ZT7L+1ncVsPG0YieBU1CWeIq1SbOIJCy0oUD2M/z6fJZXdGlEYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=A8Qa0RXrX/7XNwbg8ZPCHY/+0wHx6NViJNjYhzl2jao=;
	b=WLFjf/vfYu3KAlKfmxWef4CPPEsXqWkDOm+NbDofm7lCeJVWSWxGR+CRw6g8+0J3FYU3
	 rQWWq9QUYoffdkDc5FirV/JFgr1y82bDIC/G47NqOAdSFguCj2o8z+/pKbJd4//HtaAkR
	 Mn2Cs+1RDD35py02xgIgmio7p0D4JtIAj4jagc0nbWK6JOTOCMJFQJvlx/lEL7+qhbyGb
	 +dtiFV7hhlU0wFyKw2Oq0JPxMO6i/DPjsc4C0vE2Il+1nI8gPVzsgKZRCyU/XvNJaNSdj
	 O6/0uKhsKNUKhQB9miGQ66V6/xfrOlgquVwSbdA02vBMIGeuEe712OZWgQPlgFc6tCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PTyR36wD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2238606A322
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2238606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PTyR36wD
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so931a12.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 10:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793210253; cv=none;
        d=google.com; s=arc-20260327;
        b=SPkPgVYUfEz2Aa8WL4MI3ywoOkZ6cykFDxNhenZ9jLnw8FBJusutJiP9PiYmn52guC
         KXgpBFPJ5QRzHI8pRNf+61rt0+i+NawchAcTQZHx3rMsqadrFwms2v5cR1Z6x1KblOSM
         WiR7wkSBHVo3oKrn9umMv1gCVGZNnHOf1ogGqJtErslg3lSoxTEKHwwSrrrC6mN+tgyF
         jt1H1yj3KiZRgpXBjsv+JUn8Xh1QspsGSur9JYUeCWl4nTnRGYlmtyJW0R3qEvOuFbs7
         CAUgVCA/pR4Dsic6RFTbAq86KZ8lxU4vkILMDuS+JpYV6QeuxeamO08egnMBLk9shOTI
         xRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A8Qa0RXrX/7XNwbg8ZPCHY/+0wHx6NViJNjYhzl2jao=;
        fh=NGJW1kiXvlIvAiDXRMb8TxYae9Y7/3EwqG2Oh6pbrUE=;
        b=Zi7oLHMUmp+G3olehNqlBBuNpp3Dpvn30YG9kM+sjJhybrXo4h7niAB1aVPknKKLHf
         IU6pzGwD/eLhFCWdR8JkaRT3UGF6dYNZtNYo/HurtEhy2Rs1DzW/Fd1rnRuGO6mSVjyk
         Wo9cYLZbx2LBi0Br3VCzxslC0Cj0p0qRJhy3VMDvasTNAmzUwHGkkzEUyFdI/z7zuyZA
         /WG4xq47lQ2TQZ6dFYqEF12MbaFEFvgnX++4rKSQcTR44So57AaAFz59TzdxM0jdgmvt
         FmLmVSuxe9vrMYoZWYeABDyHjOSzjPlAUM8n9ySIJuqC728x88cS9+eYsA6aexCCun5t
         Tlfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793210253; x=1793815053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A8Qa0RXrX/7XNwbg8ZPCHY/+0wHx6NViJNjYhzl2jao=;
        b=PTyR36wDE767qX1UcGNiYx9neazEbkrUFr6YQVJeFw5uHpzwmI8aapiA1c94+AB34P
         kCPbLvHntxY5oy8tC0Zqg0dHVxwxYvspKevFci258uZKjHvdqYsskD0C/OV8EeCXGeiC
         bkLtk76uCalpZMpSLbiJib0TdHufIb3piKcyEqWOorkpLj+Y0nPRSGxzyZloiEvfx0PM
         6myWSQ3eG+lcJ1zVe0Rr3cQRbN2qF3eT/ymud5/N0gLwU8fgiA6s0VIqh+7q+LS3SLQy
         5sKJkUZ+TDohA9EEnmhPFpEpSut03C1Vj8Xa/Dynj9OMRxPdDvLyEGB1KtIzY+JLEc9W
         C73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210253; x=1793815053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8Qa0RXrX/7XNwbg8ZPCHY/+0wHx6NViJNjYhzl2jao=;
        b=Ga6Oo9xVBL7e8FBimz68J9oVIoysMJXy5huBiyOYoV8fLfGfc/ZK7fKGlufwIwUSDQ
         /LL9NeyUG/9LPx5W8xhdlotGdX1ECc7RFyWQX8rkHPyS4sxRccCCSQL/9ZN8smfeo5ep
         6W5/4VDG6cg8VZc+E27bzHuNeXqBtyr6Y8XItXhe4nI8IP16+aF4PjTAATQWdLPTjfVk
         YI9ipUnSfkoj8C4B5/fGEHEtoB5Hp5BmTsIhYWK2NnzCVRs1bT3QgPSRfMMUZn1VxP02
         rH/8rEUUDQ9i5d4+ZLdAv+AnxkFypS1rSrmtdkjcbaqwvishEz32vrMq0bSZDG8fyStZ
         vEVA==
X-Forwarded-Encrypted: i=1; AKwUvBxCCVH+7QSlBWQDHa776xSeyE53uaedKXNooyHBEAeR+gEchlOzvcMQJBW0ioadykI+7Tc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoaIuRG9956swlZ54ysZkOeDD2hsSIcQgRuGiVmi2dU9idn5Mn
	2PyPvvsy5HAAxu7eWdf7SeN4vk6GqGQlqgUy8HLLEPoChQqlGcPQdE9YFO5KEYGDQZmUDukEYXY
	U4rIe48+1ZTclsgrgEem0lSxLXZ5s+daMn+D34v+M
X-Gm-Gg: AYBFou2GwDHMGkop1oRVk72rUROX37QsV0GCe+0VNhwXdR2Xsf1rWFs3aoFVMt5wjz8
	EtezjUFUbDvKaDznMGmbuBGR1nHmALWaKAlogXYNmW1sUtzUeZBQUqqOB2WdsnoM7UD87BbsObF
	o4mjEbhHcetXrrF14Bg8tFrZd2q1vFKie/E2zNcIwG05uicLTcjQ3QoDC9S2UXlnTSnv6xlpwsx
	XsnYw+40vd9nY9q0kWxH87wiJd1Rx7HgVjVoDi5RYO2HOCEz2SBx5clRd4vUiM5KCpkkE/1LwLg
	XISW6NtGzNDuP93EUYaPHljyS3Wa4/jIdz9letkD6gP7dW8OhNaoGXKzE5tqrnXvYyBuE4IzwO2
	/SsWKJbiMzrCfqHGPQHx1MivLs9fLuqdAUZCL
X-Received: by 2002:a05:6402:c548:20b0:6b4:18f4:94a0 with SMTP id
 4fb4d7f45d1cf-6b4b0e81e36mr9727a12.1.1793210252740; Wed, 28 Oct 2026 10:57:32
 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-10-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-10-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 10:57:20 -0700
X-Gm-Features: AclHuK_UZXIlonVDc0fZszRQciOeJw350hJpkRZR2SLL6hpILBmEJQYohIrIKt0
Message-ID: <CALMp9eSUcm3aygzDSn7qD_58AxZm6y1M58LOHXpLhcPV43L8Ow@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
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
[ ... ]
> @@ -772,7 +773,8 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_=
vcpu *vcpu)
>                 svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i=
,
>                                           MSR_TYPE_RW, intercept);
>
> -       for ( ; i < kvm_pmu_cap.num_counters_gp; i++)
> +       host_only_gp_mask =3D kvm_pmu_cap.cntr_mask64 & ~gp_mask;

Should kvm_pmu_cap.cntr_mask64 be kvm_host_pmu.cntr_mask64, as it is
on the VMX side?

[ ... ]

> @@ -556,7 +557,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>          */
>         nr_gp_counters =3D min_t(int, eax.split.num_counters, X86_PMC_IDX=
_MAX - 1);
>         pmu->pmc_exists64 =3D (BIT_ULL(nr_gp_counters) - 1) &
> -                           (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
> +                           kvm_pmu_cap.cntr_mask64;

CPUID.0AH:EAX[15:8] (eax.split.num_counters) can only enumerate contiguous
GP counters 0 .. nr_gp_counters - 1. If kvm_pmu_cap.cntr_mask64 ever had a
hole below nr_gp_counters (when leaf 0x23 isn't exposed to the guest to
advertise a sparse mask), masking (BIT_ULL(nr_gp_counters) - 1) with
kvm_pmu_cap.cntr_mask64 would silently punch a hole in the guest's GP
counters even though guest CPUID.0AH:EAX[15:8] told the guest that all
counters 0 .. nr_gp_counters - 1 exist. Should nr_gp_counters be clamped to
find_first_zero_bit(kvm_pmu_cap.cntr_mask, KVM_MAX_NR_GP_COUNTERS) until
leaf 0x23 is supported?
