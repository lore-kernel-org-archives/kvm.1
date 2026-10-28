Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793223014;
	b=DrGJ7ebtBDbtLcwkeorpGWP8ToZCr2NrQe7BjC4UMeVgA9FhbSD/FvXNFQ3E5QbsC0IQ
	 05jFLJ+JZhtODte5u7ve235LOv35hhmvRSPb3zzNN2UH1xkKAS4YUsU55+9vkz/jZLbAx
	 72AbKzYhj3OPCwMpRUb60QQLORbARGiuv+EbxT74WGdf9VnrWABsSAuF0exLeSsN3+bU1
	 eRD7N/X9N4rzRUV+bbq2Or84Co1509ItZEi8NPeVX8MML7oqQFQiGIgiPNzSs9uCmK7An
	 eI+7JzqDhswS+H99inw1oev3lg8g4hAGPWGFDnJ6TNBnMc8WH18ZjYdqpFts5093pEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f/iuDxmqrMhl1VYOTXsTvpTzJ5X7HX9OcrfeaMqu1fU=;
	b=t6XaNP0h9bsItdg3Fx0W4VwpYKSzDK2eDbThOsuOUWrJ1rvMETd5bJqkDyq/YwUOum6h
	 2JSM4omIQs8giURo46uq24zz7Grevpg7zbauRPqAUCLi01hcVg54jkxLpmfdPLHppI9Zf
	 qfQ2vd/97zZ/QjVQG/zRhR5o9gCuQ3yIJLNSHulAlg3N8jmt5oR5h/LEoLgjnIvvm7+n3
	 Kp/jf7NGV8y7VWtCq2u/u33qIrRBPypikU23joVoxUNlG1ovaJ5UGdzUSX1IyRK1VW+4z
	 aqX6nSCdnhT7FAJT1RD9AUmdwazk16qZevMXtVdCd+rp0CpRL8FZWqqOUIBD+5YYx4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="d9vz7P/k";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2145606A320
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 21:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2145606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d9vz7P/k
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-535f598d126so37671cf.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793223013; cv=none;
        d=google.com; s=arc-20260327;
        b=SZELPe+kGlNiKn1mt8jXCztVfC2iEVeW/+FCD+6fYCzyg5M6Lq+SbePeqU12VjQuYP
         Z4j3JRjuObQyyLbFxwmQkoRfLJSb485yRQ1uUm0I3AWQuviL9InFhNCq4gIr0Uc1VYB6
         Z1/Guzb8BvuHhkM9yqCEnjV4SADpbYU35/UJseepboxcDe96NHKrdlg7PohQum+cetvk
         u/pyoVgQHH1YM1boE1tAjqll6huZjLjoI9XecGB0u1kyfa52OHOALR8IVoJ7mgvoIrnd
         3/Y+uYvZjxoU2WyYdZtFIXFDL97IIPjiUrNubaoujI1rfx47drKE40j/ZbQVqv1SNR99
         6voA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f/iuDxmqrMhl1VYOTXsTvpTzJ5X7HX9OcrfeaMqu1fU=;
        fh=6MyMWwhzS63VC6JkSCR0SGibb/jo/BvEWaHJq3zIfhQ=;
        b=IDz1hhE8oA49eRAacDy+/6UEB60gbRQVILndMJcbjjUIk6Gq2YntsAAmZ1Xzf/YNjK
         2v6bpk1c0wX8TEhO/9MK0ChHtCJL1HRDHn9CITCkw449pBfgGqabcEYVGN1cMiXeOy+C
         0WW1arklEpfsIYsPbxoeA1V9x7yE3d85BBXemO4/M35+8+uweEZw30ahYGT+Mzgsd8k8
         JCN+aVzluAFc+KjdXoM22FsRRixHv0KUPBl/60wSlzeKyEInjFlYRtbZOk5d2R4nOXXO
         JNpMb/+r8IzAYGrDZUsSD36FSkjI6sL8NzXNx0jYIExqOiXzs1zv4pmqAo5ixEBquWuu
         u9EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793223013; x=1793827813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/iuDxmqrMhl1VYOTXsTvpTzJ5X7HX9OcrfeaMqu1fU=;
        b=d9vz7P/kZsRdWzQMueEQu7hgoDTHyZsYXDaAprTmxt5bZZ2pFNNNetqD3Uk/VuJTAl
         bixqckmvrn+TLsxSytAyjcpXSW2uvyJa0JicafLN5M2p0eSmDD0yts3eAcaDztvynoU2
         0QPdaRefu3W3eD4wDhHzczRk2f9/opD8qNUkUHX6+kRJLOTMP5Zl+ieCgiR+FYtmjd0y
         H2QNPGJtWoSGHhLAF8A+ZgAvMwEYL8sBPZxJKsZMJuaKieIBwr4oRSmNvTdN0oneIZwH
         YDlUkK/2ymrzNIwAqGJvJ1VFVDw8xHmXaU5+sLHcyDWF5fPId3MzcbDk/Rt0gmZSwzSA
         uvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223013; x=1793827813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/iuDxmqrMhl1VYOTXsTvpTzJ5X7HX9OcrfeaMqu1fU=;
        b=mKz/pAcrrxaaVzaXeQWOyzsIvcYaA6lSJerFBxYM+bUu+enhVy9HZiqTk6BfPhsOnz
         sWOY44COYAtxRY/bSReAQXhlZxCsaHAZnpxmrM5zk08RXiTxRBWeiFNgbF0bh57pPVOy
         Yn+g8CbgOH4UTlOHRqPIq32NLsHhK2IH5juDysIEnOF0y7TZRQd0WxuMBVhv/MYRW276
         SxwqvX5YOv79lDZMuApVdkWhe8XLIwihVRESpWke1inlU4NPxvTTM5blQ9euDPxmhv6V
         AsT/Cz4GPy2F7uFga/OCkqu5vd7eoWNhz48MIxjB63j2FfVhVjrU/N7tPgY2WyqezszF
         6ZCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVOkpQEoyF8VpTjD1j+I9bPz+Q+EiJSbfP+O352+5NxY7X40DdPuFl9cVUa0egyxcNDas=@vger.kernel.org
X-Gm-Message-State: AFq9FYIq6ZIbXo21Ns200pkzZ60x4CTlqYupGeiiadCO5brVXhaAlILt
	y9gVwMttDqRTnOfmfxWks3KPXjjmmLPOr6bRkHCM+TyHg3yE8xxjwiFfe+j9xnB4bTjaxJqXkJE
	vFmthYe9RLFMQHGIOpTMBL4BHdK+UVYYRYBZ8z2vv
X-Gm-Gg: AYBFou0dtmMHajjuTqAmHEQiEEA4Db44BJcS7NnmLqpPuXRu+aFd2Cr/T6JOvBv6wob
	gI1xERwbBMfhIQFt7SQLorZ8uBLz+UQCEPBCYaOzP0fMXrMr8OjtduN7qO3B94NV1wULHhis2WD
	MxcCSXLjEscpwWBzojrYqLIlyEJ4HCKfFQ/4edbzxykNK9cNVFu2uegkGisozvjLM0LAeFFTbL+
	gP7RRvY2BcaqGmsOSblQA0VHALGOHVvpkEYFc/Siz1FMyLJA9boWaoo7nw1qzPMG+H+CQ7rGsp/
	R+DSk8asr/HEt0VM9NZf1xlHefcJlMA/ZcRQBwzxMQPhJ4BKGhxM27YxEdLpW2WcKW1hx4xaCIj
	M4bG6x6Eko9oMXCfCAlIfpVGIFL46Pah3cRZOEKOTnm6tA7D6LtdxLJGAmQ==
X-Received: by 2002:a05:622a:114b:b0:536:6ea4:e6a0 with SMTP id
 d75a77b69052e-5414e3fcf9emr2352421cf.11.1793223011921; Wed, 28 Oct 2026
 14:30:11 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-13-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-13-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 14:29:57 -0700
X-Gm-Features: AclHuK8vezI6NYvSp2Xp1TdTy1Mae1XRDaHylKueLYQF7kDBtJS4PPhPLDPkSq0
Message-ID: <CALMp9eSz6eXpuR2R2dfU+fek8iYHOQNP07L3UZGxeRugyGKRng@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
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
> PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
> This is the superset of EDX[4:0] which indicates the contiguous
> counters starting from 0. For backward compatibility, it's recommended
> to use the following to determine if a fixed counter is supported:
>
> FxCtr[i]_is_supported :=3D ECX[i] || (EDX[4:0] > i);
>
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/kvm/cpuid.c         | 5 ++++-
>  arch/x86/kvm/vmx/pmu_intel.c | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 106e719e7aee..63201d4ea4a1 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1547,7 +1547,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid=
_array *array, u32 function)
>
>                 entry->eax =3D eax.full;
>                 entry->ebx =3D kvm_pmu_cap.events_mask;
> -               entry->ecx =3D 0;
> +               if (kvm_pmu_cap.version >=3D 5)
> +                       entry->ecx &=3D (u32)kvm_pmu_cap.fixed_cntr_mask6=
4;

Is the '&' necessary?
