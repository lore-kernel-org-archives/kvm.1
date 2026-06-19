Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F95346E51
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781867008; cv=pass; b=Ji2e1AqQzHeq5IOwE4MkiFmTGPf98hrk5VZu9+Puh8ybMHNqaubAlKsPOZpQHV2v5UWlGo8w+a2Q4TYSb8sy5DdB9M1x6+AO9GOOCzi6c/u1LGjsXryoCeBRAPBzZ+fyaUnk/9KVq/q7+iRsJ9tQuivaMD9OV4yAUsvmx7U6b0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781867008; c=relaxed/simple;
	bh=GsiXIcEdAu1JNPx0o0Rkb8mPpCDUCHPoupmGVgfFazA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYHwLf9lrUu7QRF9yO1HVagkRWtveMS38wcqWS0EXb/Jv0mzYz6tGGEYc+pcucKp5xNZBSrkz2Ot7YmBUH3BH25nlZ/ApyZTGMANr2kNg/icxsgrc14S+SA0eSNFxPREKlYC6PLSGWID2z8sndCuhKkh08xGrNcLz3aBgEUrI+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eECg2c3L; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eECg2c3L"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765331535so158271cf.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 04:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781867007; cv=none;
        d=google.com; s=arc-20260327;
        b=nLsh0yrsG2Bs7oHsF68ZUnvKc37EiDYA9gb/g3GMgATHgUU5OWbSZ/lQyvm+OYF3uU
         LUAMOxLt2MCxpmEw1V51hJ3DWkJ/GPzKmz62uF0Cutovcc3V1SNiMp9R7m2lH7aUUh3f
         bk7J9c5cKMQfqkdOw1oWYFzb2L3xMhUmFtz2J5QMgNo3SK6mcE3wcA+HMS+LFKwK4DHk
         0lvnJfBjplYYrPp02UoYx0/vdknMyWEbJHvwWvPOhs9PLE4p2077kd+jVGMpV6KNiQ8Z
         IsFsp+6ZN1asncS4mOehLaJmgWgZJSCxk3C+52JrNOPtkLQY3QoC80dFWVdmJtMzMCGI
         OOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tjw3cW/Oozrva+KBRQ9a1eMgdLYrVdyOI99ohvpEcUU=;
        fh=R/LTehMvl8Lt99dPrrL3dt4/yZifhf8OEXS3N4xAc5o=;
        b=RhF7H8emXE/1z2upzmq5x1sLjCsGkNr11eVaBuDef2b3x4jwSiX4vjnZNkB77zg6OG
         FfoAMh7bWDxu2n+rAGM7HQs4AoesuRrppqlHEgmf2i4vBPQ1jidXHfBoG+AwIukOkBUn
         WQptAB+NZmNlucoFm0/wAHC/LTQCl/H+h+8wcMAZRFeFJhi82bujI4bGop+OhOzLhJpb
         yoOs+koUEAMMa3LrJkY/JMs55SPDBUealG+K2VwMaINoSlkAJ2S8Hc14Bx0x++BwKhFv
         ljoJ1qVTvabRFlUrN4z20crGsBYY61E4yTAvT2StdRz9ji/eXTWnhDj1M/JwDkfUmm/e
         0KzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781867007; x=1782471807; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tjw3cW/Oozrva+KBRQ9a1eMgdLYrVdyOI99ohvpEcUU=;
        b=eECg2c3LwUjVdA7ELvFAfim0UBgr7EC51Au7/f1izoZSuUEEs62p6mSh6CH422nVT9
         mkz4Ga8o+nx5D334hiSawMv9UIuSaDpeTkbSeBi5XA+W2t58nQ7q94DSzOfrvWz61Ipu
         AuwNT07l8Hq2LsfX09xhsZLT+B64O520RaV6a8gMDcjMHPKxBzXZ6GrnsS5IFRZVQWvL
         RXKnLhQIef5HAsPKTkGzBlsfo8018nfHGi3vkc4y0bY+vmkd0cUXhB9AeGe3Afj0+ybT
         vGiQau0XDAMMABkwKZ8yLjaeJ3oMbbuyhzZRiJJAI6+KC910tLZUaQrAJv3tPG0VEFCu
         7/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781867007; x=1782471807;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tjw3cW/Oozrva+KBRQ9a1eMgdLYrVdyOI99ohvpEcUU=;
        b=kpEEl76/8EVkhgVj6jvVYz/HzNAs3W8dWWmSVhGsRBkkcSpeqBBEtXSLdT8J7aH2j9
         qbt6r4G0lPX+GStWxP/+m9FN5OypEPExhoBeQv7hmfHvHbEWpSYn1QrfE3/8zd+EK9Ss
         87GD4ikWkAddEcC+486j4XU27Y90FN+zZDrCDtFjNn3elSKeBNUpgdlVd3CnYRTSIMmw
         ZTBYKh3IKLuNjtB8gluzy5GH7t7NE2m/AV83///jpb+akJ8aqXm/3k/v7B7dBKzrAbYU
         JAVZ5AHDtMd/DTUcymgdl8hper/xxze6Yxnlpa+oHaLRQ3P3/4WFiw5sp80L9uWP0Pg3
         K1Nw==
X-Forwarded-Encrypted: i=1; AFNElJ8hLWftdh6nqeH68jGwFKurPmQuV2wnsuZ7yJCSQC0hmLZhpd5VHRFtu4WAOoQFOmNqm/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzMfCZ2fFJ5zPyoopBYsB7YE/ciphlHsq0bhPmq6Q8qjJLw0D
	t4+wmukciDsQy2Lh8dNoND3ZfbPUErBE25Oe3ptRRkrXU+QaIzw8FpJ23ZDIt2nylu7RLspldMU
	jiEia4kzuxhBQSv+XwSf4T7D455cjAFQJ/IXYhVd3
X-Gm-Gg: AfdE7cmGOnyZe0DFvoJkLaQ7P2lZy++w2YMk2zixy26iuVsJaqFXZaok1sByqKYPpVY
	zMi26yPuquK5xecUUftqVT4+YErB8sv2R8LD0Korts8jmzINaFE6wHwYMG4wlNivc5+NGY377VP
	eLhIMzO92DUvERCItZ6H9hziAOgYHglcm7XUQhfBGZLwylnEofIl1DNL6xh5WRasrTl/afr+/hH
	gn4SuhSMJWI/QxyaKy6u/oSgkz0Ip7gb9eArjki7yxbNkpOz5Vl2O9JUWdHVVE7FDm9VEMbmA==
X-Received: by 2002:a05:622a:5a12:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-519e878bcd3mr6572861cf.1.1781867005698; Fri, 19 Jun 2026
 04:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-11-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-11-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 12:02:47 +0100
X-Gm-Features: AVVi8CdeH8_e_cqUhrAt8PYHFeMtnUwZS7qxotCUws3_NP2cjS-AO0E0Squx-po
Message-ID: <CA+EHjTxd4_x-J8DurWuhPostfZqsxMUV87tWN5GzLCknH5wfQw@mail.gmail.com>
Subject: Re: [PATCH v8 11/46] KVM: Consolidate private memory and guest_memfd
 ifdeffery in kvm_host.h
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Move the kvm_arch_has_private_mem() stub and a few guest_memfd function
> definitions/declarations "down" in kvm_host.h to utilize existing #ifdefs,
> and so that related code is clustered together.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

SoB fix please. With that...

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  include/linux/kvm_host.h | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index acb552745b428..9c1cf1a6559e3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -722,27 +722,6 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>  }
>  #endif
>
> -#ifndef kvm_arch_has_private_mem
> -static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
> -{
> -       return false;
> -}
> -#endif
> -
> -#ifdef CONFIG_KVM_GUEST_MEMFD
> -bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
> -
> -static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
> -{
> -       u64 flags = GUEST_MEMFD_FLAG_MMAP;
> -
> -       if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
> -               flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> -
> -       return flags;
> -}
> -#endif
> -
>  #ifndef kvm_arch_has_readonly_mem
>  static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
>  {
> @@ -2572,6 +2551,11 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  #else
>  #define gmem_in_place_conversion false
>
> +static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
> +{
> +       return false;
> +}
> +
>  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  {
>         return false;
> @@ -2580,6 +2564,17 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>
>  #ifdef CONFIG_KVM_GUEST_MEMFD
>  bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn);
> +bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
> +
> +static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
> +{
> +       u64 flags = GUEST_MEMFD_FLAG_MMAP;
> +
> +       if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
> +               flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> +
> +       return flags;
> +}
>
>  int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                      gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
