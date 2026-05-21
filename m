Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359234D90D
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353647; cv=pass; b=SbsMTVhcuFZl83xk1wvM3xQkz6mOOQJJqZnIrbGeKKgWAtrAdQU16O7cW3d/E+5/o9UPtkScRZXQ6dmAQUy3/dAKtKQc6S44zvXKx1z0bWdUucfgg9ISiaojau+Id19CcFOeE8sJbByzCKYdLAxIlVCkacP9IDZwbrSDNMaz4o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353647; c=relaxed/simple;
	bh=BlROpg/oMQ6qyw2CniwdkMcN/+oY12kcabYx5q1tsm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMyD3rqofYSWAbtISRE/Y5mn63fsTIxssTrNXmS7vUPLH/cWZQucgSsNcs/UadwD+T4uZPV21AXMCw/VXWiGT1Ihs3o4Ttg5s3FPxQKzzNDH4egtpyS3XQ0btAFOYKNel8lQv4f5x93xoqRRJixc4qOOhkyJUDYRVIuJ46rJHpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BN5jP55N; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BN5jP55N"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d864c23bdso10401cf.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 01:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779353644; cv=none;
        d=google.com; s=arc-20240605;
        b=FtujSkrexgkzC/SQDLjG6vvVhIEAmBLvFsrvk6uDQUX0o+U+SoUvyREbQfOzkfu6Ql
         13zePK0+LSjIvrUnGJbiBrTGlHAfRJWAOr+UnB5TW/6V6M8hFO7+r34PEpYSMgB5Lkke
         S0+oh7U0sRk6loc7LLYIDWo5QjI1tIBQJaQqEFIpc9ftR9PSG8dAbP7gT6eZdY8pKjH8
         4ll6irHFgQEqtBNoaQVr0OmpdUQHzuWwVVE6JC+InT8mP1k2BPy06PLq49ZtrhhtYfrK
         RvNk0qyndgzmHAb7gUWw7oGy3ebKaFY+9Cev5t+tUUu4Uj9OM+EDqG9fCv/96AQabTGf
         7Xbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iMVZurvnpW2R3v2VYKC4plSUzv3+qTXQO7hckbnpapU=;
        fh=i63X1N55C85h+RsExEG1/i/jFzqmhAoDhg+0vwz3wEo=;
        b=UBrw1dgJrlZoI67Ej1J+AQKf3KJCq/Yft3rgr6DfJTfcO4TZAAFCCaHmxW0wGPlfMb
         xqQrNj0yDdxcRIERSEU6CyH8dku1hjBOrjGvE6ci9EIncNK4R+Dr2TMj0XVHIhRXMXNP
         lch/ES/+wcXZiltN2Kt9Givy7GRMjFHBGvm17qYb8furzVZ5gdvjymNfa8Yq2e7UTGM+
         CTo7MPJB0gf2oRExI8lazymM2NR6nmccIeyUdAerMeLza+eSwgZTuYdMxA0vsN4/ZQhy
         J1tifp1bhYdT4wj86XJ1DQtCojJcxPvjF5/y1COChQmMhB3yFeGJKSe4GCPM+mbUfejz
         hTVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779353644; x=1779958444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iMVZurvnpW2R3v2VYKC4plSUzv3+qTXQO7hckbnpapU=;
        b=BN5jP55NPPw9UIZ2qVQVKD7Av3ym/lEOMlvrQqeFmhYNXnSy49oBoJ4Rl387X8seMj
         XJm5/p6PiZGxnb8qiNNXME6lr5o2U0E7Xw5FHeJaKmyXVTMbkXjZo/lXs73llKDnwZjY
         TjXDU8qACJ9aOsrcDt/rYFMO8uOgqjTJJxX2DNnV9X14uQT7IwAJ+3HCHHDwseyYCpfz
         fCl3qq+SYBr4v+yOtOHsd1EHeAuqS6s6YKUMc2c/P+Q4bRwyijR2MApo/T9BioJkSibu
         rrvOqFCyxohOlBjgGWqa+EZznn6TY+YbknPOA96lCJO/1TwVEMPvtTwD1Cc73ydAZbVQ
         9sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353644; x=1779958444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMVZurvnpW2R3v2VYKC4plSUzv3+qTXQO7hckbnpapU=;
        b=Uo6ohHaEmUKOlnEKrO+9mmjvC/RWeg266FSELJCpUo9QAe09Q//gZ5oMEnoonRBdW2
         69yLHyutRhWKM1KTGcB7MNViAXIjKaNfUQF2NVXo7w42Em7IffYvyYc2O+9Hojwg0Rzg
         CLa9KYqj9+cDE0LDgBQ3xaasNUOy/LRXVcc+hV1WgVaDMjWmhKDS2AAqAewhPUS37iBb
         AYGn38Xm6LPgDwNLdFfZDcSkBqMtbJHer/dmo9MX285rYYrwcpDrQwVEGqHffzHtqEXW
         FXQ58Uf0wGWeaLAdeChKXDmTd7rE31m/nQtKY90xM9X6bYwjErUtd0Ja+gxTrtYuihBq
         V/8w==
X-Forwarded-Encrypted: i=1; AFNElJ9O0h309mKPiAgNrVjBbM1z22948DmBzINHj8/pZf1J3sSuDX8CO25fAsFoRfjKElLpVi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXILVqrYv2gMI6OjkUAkDfXLfqiV6NYlgy1bMy06peZVuH/6VF
	CBX5c7BI6DXDo0rH3TvkxMCzWMFwXYR+TDwagDUJ8ENjweEyBcw0zw7Rm6SL/ESzF1xhwxZow9+
	n72t2mBbeLFdCDhsK65DeU9h9X+CaD7KoXLCrkQiH
X-Gm-Gg: Acq92OEO6zp5bG4FWmjsNFflwjN4O2b4S8HJZ7AVL/D3CbRFoKWP6lweqwOfjUzyVdW
	w1NV5idoqMPKJtYTRTi/vy+EdlxHbpEdbqTYwIg2NN4Oqrc3fmQQWhitGQmmUXyJZRBG5rUupTG
	0fnNvGX91IFzBhobfRvgE4F3QEyYwVai5IO7PfF+ZBhcmcnGmb97v0ElR1p4NyHT5gXmxK9KL6A
	d+T62mAH1AszvMJTIeJnAigrHoPolgEfKPkGZb7+kZAqz9a0mLfVoYsH9FDgduzH2KVbcTGk+Uw
	6SwPHbmHRr0qE7Gv/ig=
X-Received: by 2002:a05:622a:2682:b0:516:cc18:4760 with SMTP id
 d75a77b69052e-516cc1848a3mr1318811cf.21.1779353643586; Thu, 21 May 2026
 01:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-20-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-20-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 09:54:00 +0100
X-Gm-Features: AVHnY4JjgkDwC5Px9qxOcGZwEfL7vQEDZaLkFA7McDQJ3moR9Atjhj_tt-FGzFY
Message-ID: <CA+EHjTwkX_K4S4CHNFvoP=vDUnzW9MyLxBFZzDrR3tM6yuKNTA@mail.gmail.com>
Subject: Re: [PATCH v6 20/43] KVM: guest_memfd: Enable INIT_SHARED on
 guest_memfd for x86 Coco VMs
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Now that guest_memfd supports tracking private vs. shared within gmem
> itself, allow userspace to specify INIT_SHARED on a guest_memfd instance
> for x86 Confidential Computing (CoCo) VMs, so long as per-VM attributes
> are disabled, i.e. when it's actually possible for a guest_memfd instance
> to contain shared memory.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  arch/x86/kvm/x86.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1560de1e95be0..6609957ecfea3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -14172,14 +14172,13 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
>  }
>
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> -/*
> - * KVM doesn't yet support initializing guest_memfd memory as shared for VMs
> - * with private memory (the private vs. shared tracking needs to be moved into
> - * guest_memfd).
> - */
>  bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>  {
> -       return !kvm_arch_has_private_mem(kvm);
> +       /*
> +        * INIT_SHARED isn't supported if the memory attributes are per-VM,
> +        * in which case guest_memfd can _only_ be used for private memory.
> +        */
> +       return !vm_memory_attributes || !kvm_arch_has_private_mem(kvm);
>  }
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
