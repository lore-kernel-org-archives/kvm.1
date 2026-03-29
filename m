Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DB299A81
	for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791722; cv=pass; b=KkAgfuDaBkbIuCdXNElyjap4E96BD3eGkyxNl3s5rsjvOW3Aqkzbwsaj8X/2pXqBVgmCnRYEHX6D24166csMv3stPc5lBv66FD8BvT3hyudhbC/Tw3Uo/3wMyT4ebWnLW8C/T8ho1hn8jj5O5ulbn6qb3/qbyo6ncA6xmhuOvHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791722; c=relaxed/simple;
	bh=yG0GY9Z7DdEjRqq/jjl/HZBwFW+WK1FwgjS1QWQk1HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeZ6DvSuzCkzSVTnxxFs3NNs0+ncmovgnzel6mJr62zxnL/QPDa/0QQrAHXx/LjZJN/7mcIaeGeJ7MYy31XYCkDUKXbP+PKqpXBYWWLgbZPK1r5UdF3GQBh4JOJRka9RWnGy083ZSG9WUdKGEbBarG9DLn9C11e9tPaW1/2w9v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HT4Gxsi3; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HT4Gxsi3"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5091ed02c54so629331cf.1
        for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 06:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774791720; cv=none;
        d=google.com; s=arc-20240605;
        b=YtXJaJofQ4grcvaTiumfH5kGFgH4ZykMLqhq7cZBDuWPRYYAWzDNspm/WLhIXh5uYY
         7+GlLh4zF6J50eZXLxowxnYZdXgQqOMeHELvhdCY+qdBKSy8ippLG7Qzowtqm9KJdzt5
         ZjY07cBlqt3/1N18N3Ft+l54LgjUBFl8fZYbBgMCTk7j5WyDB6zi0uq8BsYFSGFxw5gx
         GBldxnurcxPVKL+4e+EXFAx9cowUN7ebvJeFMKYabB+wh6v5uoVcz6gKwML5FQGwkaTP
         I2KvvCls8Zde0I2McEhidLm06LvGqy4LE/pNUhowQeGdXy0ofCHPuX9A6bbZXo/s74r/
         ThFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aF4Epmx2n9nntDB8c7LNu8cL/wQsJEEhS1gBTnU+6mE=;
        fh=CfMDX/fA7/FNbjiKLAkiUPaCnvtvICR3FSR1LKL6PHE=;
        b=k3LzDftBKLxKaAqXdnUcth/oIDz6KB3gPY6dUp6bJbJnhjgkMd/YmLoZHVwDA2qrZR
         YZXRVW9oFSujClPzpbLHqkt7IVOzj7P5QmVyjaUZma5K0+rKfCFWpmPxP8M9rY+SIuE/
         s+aeoW2sZ2dcZwzt0KoswvY5vkhFzRZ+epoyRLPzdKQhu9lJRRkXhvAl1OIVi8LQmBXz
         k4xsiVguna3/PQoB8dIGMYsMuP5tMFDW5ZJOWGdBLyaDF/J2OKrTNK5CN+hq76YR0zVm
         fkj9Sx8m6RwATXbKe9X+/ynSGdIJfEXWkuBiXYGjmG3NbqB6y4d2n5pZCazfuzIEfgjq
         AHwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774791720; x=1775396520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aF4Epmx2n9nntDB8c7LNu8cL/wQsJEEhS1gBTnU+6mE=;
        b=HT4Gxsi3Mf9YoNvm7wwrU3VZmqN3c0vmNcp6ngKGBHCXXKIDiR6wn5EMw2VXLgv7aV
         FkRMPAqw9gdXJvW1CHQNl6BBXH7gVfEEcLZYcLHd53e4P5Kw1wKG9ZgeAjP0OKq+Z6bx
         PyiGPwZD7vP6Sw4OIFjQpjwpm5ko/bH10CpWRZbfrlOQBhY87etDcQZYTR47yWxpHcU+
         Ua85FUVy0Qo3mI/y6kgfjfbMFeVhbnX22o5+6WMf0914MJIxezAJG29CwyvF9uRa5RkE
         S+z5KvOwluY7OcRwHZ4kdvvMJzyEnVkjjZkHKxmYOzVzvTXqqC5bLum1Owxf5WsxrGZ1
         fo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774791720; x=1775396520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF4Epmx2n9nntDB8c7LNu8cL/wQsJEEhS1gBTnU+6mE=;
        b=jjV6w55b1ETskMN2VUKT8izy29ga7ktxWTVFAEWKVz221G3BgOR0kQIQ8sugrjravf
         4M9pf1Fda11Q8+NGeSxVIZoqIvjvu6KZelWZtzCfeNN+ILe0iBR7Z7z+MFfvdzPKzJ1p
         neu6nd21gsYP8OayVZ5t5ztGXlTExwZCMWDNaxjeP3q0FSxiRAAGH+kcmydPKl81t+ZA
         4MoLxccSj5lgCOhil7vNEa2T0A/nduFwnFH91xdcQCZSQyMMGPE18DCngfqs62JGt8+L
         eOnFPUoZGOncs60yeWyqTlZsSpn8VRJOqui2elDHp7NhtYRg7+ULMA0+VIEyZx2OedaN
         8xYA==
X-Forwarded-Encrypted: i=1; AJvYcCUWzULWAiDKPtKqT/v/Ki/HzX8gilj+v+0D/5/Mj5bpwtHZt2qp4wrLM+DBYMpxYw3wDEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCkkcsEoDiyCDXy4z+DBvXKD/7ddBSbXPJhcLXLFEU4h35xEw9
	JaWBJ74p4ILqPEH45pNIk98zrqV+vJP43wglJx7uP5q8R4uptD9kN4YEyTpIGO4zcjymdOfjCkz
	vyn9s4KO+ALC2NQaZ1HpJqCRvKRsYv7MCPxiGdzW5
X-Gm-Gg: ATEYQzylvr045v/D5XWghRGrMLEUkwad35OD51L9k2Y1z0NSzWwcze9NLEKiSuIYzi6
	klysInWKmFTC8K67tar/iT8T1qcTqBSycEDpZ9LNKNhrpyau095hgmnIa8Kl9QG9EuXE6TErxPS
	rNIsMUoboY3OvVUV96OcajLG+sAqzUUkSwiUQx6yz2jq/jpCZDjsE/GCFfJiU3ENEvGOsRHLy2G
	l51lLW8N9Yn36WqEb9L8Jfl6hGCUnw9FU5LLadrLQkzGvsUhLdofjJgXNPCXFQbrcQXjl/xwqyo
	VUrK7zU/
X-Received: by 2002:a05:622a:3cd:b0:509:1d4b:f86f with SMTP id
 d75a77b69052e-50bb27f6ef2mr18579571cf.14.1774791719904; Sun, 29 Mar 2026
 06:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327113618.4051534-1-maz@kernel.org> <20260327113618.4051534-22-maz@kernel.org>
 <86ecl549aw.wl-maz@kernel.org>
In-Reply-To: <86ecl549aw.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 29 Mar 2026 14:41:22 +0100
X-Gm-Features: AQROBzAIIIl4BXFhMlior6x1Oks2QHN0i-uK1SaLiMYW9yClQIV8jdg80mHlByo
Message-ID: <CA+EHjTz60sr7sVaizJT3Cxg+AHLBy09032VBvmqc-dRtEFeNeg@mail.gmail.com>
Subject: Re: [PATCH v2 21/30] KVM: arm64: Kill topup_memcache from kvm_s2_fault
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Fri, 27 Mar 2026 at 14:49, Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 27 Mar 2026 11:36:09 +0000,
> Marc Zyngier <maz@kernel.org> wrote:
> >
> > The topup_memcache field can be easily replaced by the equivalent
> > conditions, and the resulting code is not much worse.

This is easier to reason about I think, so (not sure if it applies to
fold-ins, but fwiw):
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

> >
> > Tested-by: Fuad Tabba <tabba@google.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/kvm/mmu.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index e8bda71e862b2..5b05caecdbd92 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -1712,7 +1712,6 @@ static short kvm_s2_resolve_vma_size(const struct kvm_s2_fault_desc *s2fd,
> >
> >  struct kvm_s2_fault {
> >       bool writable;
> > -     bool topup_memcache;
> >       bool mte_allowed;
> >       bool is_vma_cacheable;
> >       bool s2_force_noncacheable;
> > @@ -1983,9 +1982,8 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
> >               .logging_active = logging_active,
> >               .force_pte = logging_active,
> >               .prot = KVM_PGTABLE_PROT_R,
> > -             .topup_memcache = !perm_fault || (logging_active && kvm_is_write_fault(s2fd->vcpu)),
> >       };
> > -     void *memcache;
> > +     void *memcache = NULL;
> >       int ret;
> >
> >       /*
> > @@ -1994,9 +1992,11 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
> >        * only exception to this is when dirty logging is enabled at runtime
> >        * and a write fault needs to collapse a block entry into a table.
> >        */
> > -     ret = prepare_mmu_memcache(s2fd->vcpu, fault.topup_memcache, &memcache);
> > -     if (ret)
> > -             return ret;
> > +     if (!perm_fault || (logging_active && kvm_is_write_fault(s2fd->vcpu))) {
> > +             ret = prepare_mmu_memcache(s2fd->vcpu, true, &memcache);
> > +             if (ret)
> > +                     return ret;
> > +     }
> >
> >       /*
> >        * Let's check if we will get back a huge page backed by hugetlbfs, or
>
> Sashiko has spotted [1] an interesting corner case here, which is that the
> original code always initialises memcache to its correct value, while
> we now only do it in a limited number of cases.
>
> I'm proposing to restore the original behaviour by folding the
> following change into this patch, splitting the retrieval of the
> memcache pointer from the top-up and avoiding the ugly pointer
> indirection:
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 1fe7182be45ac..03e1f389339c7 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1513,25 +1513,22 @@ static bool kvm_vma_is_cacheable(struct vm_area_struct *vma)
>         }
>  }
>
> -static int prepare_mmu_memcache(struct kvm_vcpu *vcpu, bool topup_memcache,
> -                               void **memcache)
> +static void *get_mmu_memcache(struct kvm_vcpu *vcpu)
>  {
> -       int min_pages;
> -
>         if (!is_protected_kvm_enabled())
> -               *memcache = &vcpu->arch.mmu_page_cache;
> +               return &vcpu->arch.mmu_page_cache;
>         else
> -               *memcache = &vcpu->arch.pkvm_memcache;
> -
> -       if (!topup_memcache)
> -               return 0;
> +               return &vcpu->arch.pkvm_memcache;
> +}
>
> -       min_pages = kvm_mmu_cache_min_pages(vcpu->arch.hw_mmu);
> +static int topup_mmu_memcache(struct kvm_vcpu *vcpu, void *memcache)
> +{
> +       int min_pages = kvm_mmu_cache_min_pages(vcpu->arch.hw_mmu);
>
>         if (!is_protected_kvm_enabled())
> -               return kvm_mmu_topup_memory_cache(*memcache, min_pages);
> +               return kvm_mmu_topup_memory_cache(memcache, min_pages);
>
> -       return topup_hyp_memcache(*memcache, min_pages);
> +       return topup_hyp_memcache(memcache, min_pages);
>  }
>
>  /*
> @@ -1589,7 +1586,8 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>         gfn_t gfn;
>         int ret;
>
> -       ret = prepare_mmu_memcache(s2fd->vcpu, true, &memcache);
> +       memcache = get_mmu_memcache(s2fd->vcpu);
> +       ret = topup_mmu_memcache(s2fd->vcpu, memcache);
>         if (ret)
>                 return ret;
>
> @@ -1993,7 +1991,7 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>         bool perm_fault = kvm_vcpu_trap_is_permission_fault(s2fd->vcpu);
>         struct kvm_s2_fault_vma_info s2vi = {};
>         enum kvm_pgtable_prot prot;
> -       void *memcache = NULL;
> +       void *memcache;
>         int ret;
>
>         /*
> @@ -2002,9 +2000,10 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>          * only exception to this is when dirty logging is enabled at runtime
>          * and a write fault needs to collapse a block entry into a table.
>          */
> +       memcache = get_mmu_memcache(s2fd->vcpu);
>         if (!perm_fault || (memslot_is_logging(s2fd->memslot) &&
>                             kvm_is_write_fault(s2fd->vcpu))) {
> -               ret = prepare_mmu_memcache(s2fd->vcpu, true, &memcache);
> +               ret = topup_mmu_memcache(s2fd->vcpu, memcache);
>                 if (ret)
>                         return ret;
>         }
>
> The bot has also pointed out a couple of cases where memcache and
> permission faults interact badly. I'll look into them separately, as
> they predate this rework.
>
> Thanks,
>
>         M.
>
> [1] https://sashiko.dev/#/patchset/20260327113618.4051534-1-maz%40kernel.org?patch=12134
>
> --
> Without deviation from the norm, progress is not possible.
