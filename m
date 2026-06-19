Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF616330666
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857027; cv=pass; b=IbGsRFyS/j1ejQE9MZdjuuXDpvImMt5OOI3zg3tK5GZJjvybPxJ/CbUsZCXvYfqfgDNIaM+4LGhM0qXiOJy6WtvySpHOOuES/lJmTMg4/wGcz9sKodp+aNMxkDFl7Y8D9rAK/tJxahom7gtqN18vYmuAzMAKVWw20sE+Zz94OQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857027; c=relaxed/simple;
	bh=GdVp3nhFsAiHzr2W7O9A7vMg2rpsv70lslLj5RH2A9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVMABpGbLf3nPP4TuRljNeFx01x7PSp3itzDMR60/61bXlmsr1qSa+sgzAnTivDzpNWZVNfJSk4D9tPvusWeScAWZv2gwDIgmNZC5qcCMN9ce8k3n/uXaLF7DEd/pguVv8/NTnDeb+6Y1CevqmVgqBzifLU2kIyX3S4dgkfRxpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDLqSLvt; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDLqSLvt"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5177d1ff061so114461cf.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 01:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781857024; cv=none;
        d=google.com; s=arc-20260327;
        b=JszzPSxj6xdaDdY2wJTE8t3A5J1HTYah7TfD1v70BDEo6PG1tPwUr9v5r+H8C0U02Q
         YqIaO9o+51zR82gLgHcBogg7L8I0T4fIdandQOt31Q3YdzjFGqAgHQgg0+6/v/2OwzEP
         FV2hjHsIYaQZU5HiXVyWdcxClu9BKXyt29bQts3lteWyda4/jzHxD40YJNg23JeLSLFX
         qpZpvEceVRJIOt5z+SbVBBIL5VjWSIf421l+XUu0byukkVp4uKLDmR80yyXoAR+2QCZS
         Gwb5TA97hNkXEi59qtMCQGP4m48X7lzqacckOiIKZLZZaagbBfEm560IaxLl4mKHaaQ3
         024g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Up+XrPQNLPb5sD2pRt6yFkeckwFFZAw2wSW2pQjWH24=;
        fh=9cjixIY4Nn//yME928HWejKT5ah2YkOqusLt5DNsvTU=;
        b=mDTE7hGwfl1kLfCoOChWpPYX3M0RGnq2KOTOjbc12v8pbx44nImqSj+NyRO9gCTc1W
         f/EGabHcVBdfVJ8fL4cpqEUq7EQY9sPKQfP9hjfKM6ypbMiV6B0fhAYLhXTUBUW/M5cP
         XWNofsxXkdhddFl//Qxohlfxzx/whSRE+rugQB3sw8ygKdxcEJ5o5FO4ElwBU/5pg3bp
         z25xL9RdZ2lzlHnuynwi8cgPMliEenrRI+sDAzInDmm8knegwt1SSzbbB7HnIA9BmQCH
         afcuTifIQCAOjLBTT/hxZJk14H+Ydfhvhf+R3WJidyis37oHO4KPL507//uXATMKpNe1
         8RCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781857024; x=1782461824; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Up+XrPQNLPb5sD2pRt6yFkeckwFFZAw2wSW2pQjWH24=;
        b=UDLqSLvt4iF7TyH3pz76Oet8dV39AocjdkeMZRMzPIr3DJNcS/yNOu6MMgFdK42wr6
         37VLcRn8ENjvnGAJLGl48tvk53NGF7mF2rTy9DF9V35aDfx1nV7ZnUTQq+MHggAKEjVU
         CL06XzxfgJqe51vlXg+HqnCQPVdvPZun4SAbCUzFAkj60zOQTR+BjS2SnBEaNV53+OfE
         qABEHoPQfY/rKdbG3+gJ7nOYXlmtPdLfC5aiGiJhMojDZLMq9LBwn7LTMGHbgvfosoSA
         zQM4khc1baNTqd1ksWeKTIzijcmx2M/susAkVPpm5bLUf7fmevpLnn6vMPc/kwjmm/I6
         G/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781857024; x=1782461824;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Up+XrPQNLPb5sD2pRt6yFkeckwFFZAw2wSW2pQjWH24=;
        b=KM8B1Qlf27/rYbGxU0nxzVou/h6QLB5CAeSLwurnOATr6mvPms/ql1JoqZj5dj5to8
         XfiB9yEqRWvmtEak3BuyLmcAC58I8WQdgb8Il7w+NixK4yVoknRa3q2oeXmr+YAdMuIN
         1euglfGH9j7FXiq+RDKjM2/9tR/55qinni4fGll1B9WfnqFAN3Ncp7R4sV50dD5ut8d6
         7RRXxRvNk+xo9nWXhOf6PpI2iHpgPf79VrsZz5+ft6KdvDhIwMD7CvP4Bm09NCQ1mA1P
         cVKT0leqAbeJiQEMeLOVzkm7HeLnZdAAS2g7SW0Po37CfbFc8/tcE1rwcbC7IEs50yKR
         ygcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1vCnrlBg5KcWpVl8mbjAjZlaaRD7noGLqqKqjSz3aWAouamNgdtdLOjVsaJ5K5vSDNpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshMzlXd9whvkfyjL+iyjX17gDpRwTYhn57fm8ApN/7tbamwd0
	qq7asJZMXjCNF19/npVKeqx44gwdOCBUT1mQjc+A/dc7tpGa3ahvg31NR3IVU3jaffsre7m48Af
	XtESaQ5xHvs03jCXFWaxKcyM78qgxZGD3QMj0UnUw
X-Gm-Gg: AfdE7cn+bAuS8Rf2YQw4UNt3j87JSeM1e5BnHiiDI5tSbRIwmnKZ9l3GqiJIbCQHOdn
	i3KLqs4pxB6Fz8GTf6vs0h/s4tBzg+fxoSm/jhAIm3Eo2dbIFk1X1OvGdS8DTJj2uDyppcD7FTP
	OnhpzhHgmsTplaZWWdIjJP8lJGcG7OhFHzZKGYire4xVvvh3uTZyGEX7RqLRB/1z4q/PYR/DbvN
	Q4AHZ1tw6qi2ae/1TaiBjkY4vo+2ZrPXtd/Jnktd1mHOuGKLtO7krJzN1G4+1PoIBTCzf3YEFFE
	KMBoL9Ir
X-Received: by 2002:ac8:5e0d:0:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-519e890f9bfmr4864371cf.9.1781857023534; Fri, 19 Jun 2026
 01:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:16:26 +0100
X-Gm-Features: AVVi8CcXSm3jW4-FHN7kYYGC1TN5KZ4bglqmRK39sQa6uZ2xmU2eoLlZ45Vf7AY
Message-ID: <CA+EHjTw0yrHqAPFUc6bK=u3D19mRyh-eeQgDmGioN+LLk2DXDQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/46] KVM: Rename memory attribute APIs to prepare for
 in-place gmem conversion
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
> Rename memory attribute APIs to add a "vm_" in the name in anticipation of
> moving PRIVATE tracking into guest_memfd, to allow in-place conversion
> between SHARED and PRIVATE.  At that point, there will effectively be two
> (potential) sources of memory attributes: the VM and guest_memfd.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Missing SoB (other patches as well, I won't mention it again). But for
this (and other patches I review with a missing SoB fixed):

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  arch/x86/kvm/mmu/mmu.c   |  6 +++---
>  include/linux/kvm_host.h | 15 +++++++++++----
>  virt/kvm/guest_memfd.c   |  6 +++---
>  virt/kvm/kvm_main.c      | 16 ++++++++--------
>  4 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e0005a21b6e22..cbc50aef801fb 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -8087,11 +8087,11 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
>         const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
>
>         if (level == PG_LEVEL_2M)
> -               return kvm_range_has_memory_attributes(kvm, start, end, ~0, attrs);
> +               return kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attrs);
>
>         for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
>                 if (hugepage_test_mixed(slot, gfn, level - 1) ||
> -                   attrs != kvm_get_memory_attributes(kvm, gfn))
> +                   attrs != kvm_get_vm_memory_attributes(kvm, gfn))
>                         return false;
>         }
>         return true;
> @@ -8191,7 +8191,7 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
>                  * be manually checked as the attributes may already be mixed.
>                  */
>                 for (gfn = start; gfn < end; gfn += nr_pages) {
> -                       unsigned long attrs = kvm_get_memory_attributes(kvm, gfn);
> +                       unsigned long attrs = kvm_get_vm_memory_attributes(kvm, gfn);
>
>                         if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
>                                 hugepage_clear_mixed(slot, gfn, level);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index d370e834d619e..eb26d4ea8945a 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2534,13 +2534,13 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
>  }
>
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> -static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> +static inline unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
>  {
>         return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
>  }
>
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> -                                    unsigned long mask, unsigned long attrs);
> +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> +                                       unsigned long mask, unsigned long attrs);
>  bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>                                         struct kvm_gfn_range *range);
>  bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> @@ -2548,7 +2548,14 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>
>  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  {
> -       return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +       return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +}
> +static inline bool kvm_mem_range_is_private(struct kvm *kvm, gfn_t start,
> +                                           gfn_t end)
> +{
> +       return kvm_range_has_vm_memory_attributes(kvm, start, end,
> +                                                 KVM_MEMORY_ATTRIBUTE_PRIVATE,
> +                                                 KVM_MEMORY_ATTRIBUTE_PRIVATE);
>  }
>  #else
>  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b4c24fdf159f6..8101f64e0366f 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -915,9 +915,9 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>
>         folio_unlock(folio);
>
> -       if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +       if (!kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + 1,
> +                                               KVM_MEMORY_ATTRIBUTE_PRIVATE,
> +                                               KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
>                 ret = -EINVAL;
>                 goto out_put_folio;
>         }
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 7b989b659cf82..6669f1477013c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2419,7 +2419,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
>
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> -static u64 kvm_supported_mem_attributes(struct kvm *kvm)
> +static u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
>  {
>  #ifdef kvm_arch_has_private_mem
>         if (!kvm || kvm_arch_has_private_mem(kvm))
> @@ -2433,19 +2433,19 @@ static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>   * Returns true if _all_ gfns in the range [@start, @end) have attributes
>   * such that the bits in @mask match @attrs.
>   */
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> -                                    unsigned long mask, unsigned long attrs)
> +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> +                                       unsigned long mask, unsigned long attrs)
>  {
>         XA_STATE(xas, &kvm->mem_attr_array, start);
>         unsigned long index;
>         void *entry;
>
> -       mask &= kvm_supported_mem_attributes(kvm);
> +       mask &= kvm_supported_vm_mem_attributes(kvm);
>         if (attrs & ~mask)
>                 return false;
>
>         if (end == start + 1)
> -               return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
> +               return (kvm_get_vm_memory_attributes(kvm, start) & mask) == attrs;
>
>         guard(rcu)();
>         if (!attrs)
> @@ -2567,7 +2567,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>         mutex_lock(&kvm->slots_lock);
>
>         /* Nothing to do if the entire range has the desired attributes. */
> -       if (kvm_range_has_memory_attributes(kvm, start, end, ~0, attributes))
> +       if (kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attributes))
>                 goto out_unlock;
>
>         /*
> @@ -2606,7 +2606,7 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
>         /* flags is currently not used. */
>         if (attrs->flags)
>                 return -EINVAL;
> -       if (attrs->attributes & ~kvm_supported_mem_attributes(kvm))
> +       if (attrs->attributes & ~kvm_supported_vm_mem_attributes(kvm))
>                 return -EINVAL;
>         if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
>                 return -EINVAL;
> @@ -4926,7 +4926,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>                 return 1;
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>         case KVM_CAP_MEMORY_ATTRIBUTES:
> -               return kvm_supported_mem_attributes(kvm);
> +               return kvm_supported_vm_mem_attributes(kvm);
>  #endif
>  #ifdef CONFIG_KVM_GUEST_MEMFD
>         case KVM_CAP_GUEST_MEMFD:
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
