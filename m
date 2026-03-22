Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0A367F44
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774194279; cv=pass; b=jGvA3hRpCymCYmel2Tqw5D7yHu/lR/nCmbvMqMCbeT+Kure9EL0SX6mYGrSeeNnzFOo8yLHSoegIPFTfT5XEuWOGp8RDEXS+teLRH6BkMmt69GStR6GjnARqi/1DGB77sovy/zFylBO8kQhGA6OSTTTBtKAS0ehqe7Ff1lhoNSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774194279; c=relaxed/simple;
	bh=qe6ufksEAl3fXYhd7OFfdXbBxI1wGaRCuq6Vve5so4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2A83jYTmPslaU7nvxeT3945HN7BwJKWtiFNS8TyuVeOOgU0x+Aib9IfbuqZdRs8QplRn3Xl4mg0BdxBITzPZXuFYWFvQlE1bfSRX1pMti3g3aMe7XXt1o6YYpd7/o8EzhvylxzrCmexElWY2eorzXl2GAQ4o6cyBLOMPfZJWLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+8H5HcR; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+8H5HcR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5091ed02c54so688211cf.1
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 08:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774194276; cv=none;
        d=google.com; s=arc-20240605;
        b=ck/PrG7AAAOxPy0JkiGmE1moh6pqiN7OfcBYKRhpPo3MvD2r+QH4KiK5hX7Ky4Xjwg
         ZMD3TbMjYfb3b+ZxTbnVcG7p3s2zSrRFjxKbHqi8aXavak6udTGraubCZ4e59ZoP35uL
         2cmxEjg9WC55ycKjI8UOhWBaxyHBLzqWF2KCbE4Ich82VgtZuvoMw1nXX9n6InoiLZ4c
         LwmhHEYd3Rwvsl/8YYv5xKYSU5crEVVh3Bve7r/Ihqm8cSnSlUnZRTY/azSdOLvddS7P
         gkZfJBDu2+m66eQYnv9kzKwmXPlBRq4L5UqV+wv4jWUXUv9NbGmsnX/hTJ0eL1KnePxY
         wEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7g8MY1vCtLNn6W/YkPkDXFGjyD7zE3ehnXdpUQaG3r8=;
        fh=rNFeymFAqzBnBTxn68Pbdr4Px46Wkrou/w//2jXcSlI=;
        b=OtQVdd/KVOwvVxQNwSWMXEgZpyGapsXvcsnGDdAVN22GwpX/7VVLvsx5xDu10W8KdU
         cH0o2gUJ5zUuaOKD0bzNgx3urtzoY17iGxzy25LGMYt+H54KxgnSWoCfX8ETh37xnEhS
         c5fALQsYBgqy+oI+RtUxJd82xAvpIXrflPjlv0wy3nOcAvRSUC2RSxxA/aq5ZuifWqZl
         yPJ75wDMfeXQx/pktyBne9DhMFD3pOf7OUCGwqbxcUFPtOqUYQb+QkOYICydpoQ4qrEt
         mY7UIWh7yYP4mQNQvNMgP72MUrakKHc0ZOE5kb4eQ5/lkZF7mNndL1kgWa3vMRrhBb++
         71aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774194276; x=1774799076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7g8MY1vCtLNn6W/YkPkDXFGjyD7zE3ehnXdpUQaG3r8=;
        b=N+8H5HcRRhtXiMVn5mryACZufjtLuFo1ALceKyzVIthpu3j3bjs3o3febUbvJk/iA2
         VeTd9DJlOXz3pD3aCAYf0ArRCYnsAwP8QvrUOrlm/AsMdbUiqM9vVw7z4O9EXpGskiu7
         itGR19wqaYj3BAH8NEELlpULM8E1gWR0Dk4Dhqy+lvTHF3isdm0fMer+Ouhhg2h6F9oS
         /3s4eacJybXMm3PJ0ugnUFLfJf6PT7O6viafCilHAbI5Bb/VSYoop493LwJ69OfwIMGv
         2lGfnvaNqhT7kjQTwOEqS+GBs/dq4rNxgz1MzS6juP8tNBJSjIudIOoj17oL/kegI5J1
         FhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774194276; x=1774799076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g8MY1vCtLNn6W/YkPkDXFGjyD7zE3ehnXdpUQaG3r8=;
        b=iOGBokjjE7/6QEhjj6Zob5NcNOGWXo1LSI7X4fE0P/DRXxcJYgiFhHvENEIKv5vBCC
         3Qv6Ex/9Icu6JxdJWmIBrtTvrfpOWhtIrVpZqxVW4igXmih4PcDK/sjm6+4OwOpkWUSs
         DRngT/RV0JW+nCVWZG26zoS0K1lyP1A+w6pYatn0hcBlMyuc+bA2bWaCng3XFbWST0xJ
         qQ2x6XaQ+pkcQ5YLHuvwvQD+pzGcGgz68SAG2wWb2Vk/JcwX1euLlAByjYlCVPGZ32to
         qzQ99CdTuNxxvOqERgF9iAlD0GY4Uw4H916xU9lLcPqmXo1lqoYOzsPNvChQfnYFrWUN
         uzPw==
X-Forwarded-Encrypted: i=1; AJvYcCW8PdaepYJkSF3fS6CjTcNBtlpKqpHAfhlkWY4NKJA3+YVdxX7iJfdBzutzuFQGBVknoOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7k09rezwnjlbGkLQY1sGqThjFAWmv+JrmT0+hg6PlFwAgxxxv
	H6RRXU2MPqh1LLLqrajJ/qWDFZM6+VM12n/A7NrM5UN/4zP9m+7iTZDx5chIVqwW4dBgq+hr8Mt
	oHwMhZCofwGEr2TaQ7Q25CKSTlcelxytkfxpwESt1uBOjVAsEGDrKzPLQtGg=
X-Gm-Gg: ATEYQzw8zU3PP49upc8MNKupFvyFJrOdvk9hC1wI/eTXDEYT6NGBgcvDk3cuA7hscMT
	7koQoe7IgsZozIYJmorBls+wwaaDr6hrfVB1vwHZChJ86UayLw5lfD/9MtJ5f78VGWd+E24H6Mz
	beDnSpupS6mW6ImJ1uySXa4n4Mnptp+JHkgOIFuuR3YOcF7ZpuzNhFeQ4kd9v9mBw71JWrVFH8z
	X6XsLTj5zBoeu8BNVFuzfcYh6a5G/6ibFC+EAHP6g5OkKdphZiAQQTbYUwIJaJHax5UJSz7ttOS
	nGw9F7Fo
X-Received: by 2002:a05:622a:8c04:b0:509:14f0:bff2 with SMTP id
 d75a77b69052e-50b46cb352cmr19351491cf.12.1774194276032; Sun, 22 Mar 2026
 08:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321212419.2803972-1-maz@kernel.org> <20260321212419.2803972-4-maz@kernel.org>
In-Reply-To: <20260321212419.2803972-4-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 22 Mar 2026 15:43:58 +0000
X-Gm-Features: AQROBzD3Objm2EQkQmOztE3PUeZpkFxeB6Okjt6XWmW0dH-3UyAexaWM0HnGGdI
Message-ID: <CA+EHjTycbB1rZGALB0L1iyOkaVuH+5a5bBD0teo79YHNEE5-Pg@mail.gmail.com>
Subject: Re: [PATCH 3/5] KVM: arm64: pkvm: Turn __kvm_hyp_init_cpu into an
 inner label
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Mar 2026 at 21:24, Marc Zyngier <maz@kernel.org> wrote:
>
> __kvm_hyp_init_cpu really is an internal label for kvm_hyp_cpu_entry
> and kvm_hyp_cpu_resume.
>
> Make it clear that this is what it is, and drop a pointless branch
> in kvm_hyp_cpu_resume.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index 55e0dce65dc56..2e80fcbff2dff 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -175,7 +175,6 @@ SYM_CODE_END(___kvm_hyp_init)
>  SYM_CODE_START(kvm_hyp_cpu_entry)
>         mov     x1, #1                          // is_cpu_on = true
>         b       __kvm_hyp_init_cpu
> -SYM_CODE_END(kvm_hyp_cpu_entry)
>
>  /*
>   * PSCI CPU_SUSPEND / SYSTEM_SUSPEND entry point
> @@ -184,17 +183,8 @@ SYM_CODE_END(kvm_hyp_cpu_entry)
>   */
>  SYM_CODE_START(kvm_hyp_cpu_resume)
>         mov     x1, #0                          // is_cpu_on = false
> -       b       __kvm_hyp_init_cpu
> -SYM_CODE_END(kvm_hyp_cpu_resume)
>
> -/*
> - * Common code for CPU entry points. Initializes EL2 state and
> - * installs the hypervisor before handing over to a C handler.
> - *
> - * x0: struct kvm_nvhe_init_params PA
> - * x1: bool is_cpu_on
> - */
> -SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
> +SYM_INNER_LABEL(__kvm_hyp_init_cpu, SYM_L_LOCAL)
>         mov     x28, x0                         // Stash arguments
>         mov     x29, x1
>
> @@ -223,7 +213,8 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
>  1:     wfe
>         wfi
>         b       1b
> -SYM_CODE_END(__kvm_hyp_init_cpu)
> +SYM_CODE_END(kvm_hyp_cpu_resume)
> +SYM_CODE_END(kvm_hyp_cpu_entry)
>
>  SYM_CODE_START(__kvm_handle_stub_hvc)
>         /*
> --
> 2.47.3
>
