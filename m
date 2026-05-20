Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FB23C39A
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284902; cv=pass; b=B2b+rmklXJHnWwfOlS1HkJCJP+/pG1RcISj7TpddKl6zPSonr/rqR0SadK8YvNGzTeisrehQrmojZitEkbNtyokHxplhJh7YDnrChO78ceDcvwH/Yfhzs/9qDS8OwUP50z9AEAXO7hSaclZo6Xz+Okop2MXHQezNskJra7sftjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284902; c=relaxed/simple;
	bh=qiAgR915c2CmHYVIagAz0GZLLG4P/KRD0iJeIn6q8LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR7VYhluTbTfbzc3AOtLopcOEgSS9T6jOERhf/LRnk1ybp5rF0DeMXNGHfExPBQKo5Slb2UO4d4LUvCSZPgo0IX1COEXd5fiNPoZHSuSdNNFCxts1PB80OG28asapeVBFt8P7Yef7GZTjBrE5VXtiV8NPwchyXFeZsCd1CQowzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qew81pfk; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qew81pfk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e61648f10so7371cf.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 06:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284900; cv=none;
        d=google.com; s=arc-20240605;
        b=QTOn7aVleJCi8gdN39EQWfqbJKguGxilFxcA+GQj5jSu4AL+W6KcHsR9XCiBsvGvOS
         1/99DbNRu8F48OwEkmCgXGs+jCZLRB7jct0wN+aEMpcZQCewVs2KtpHOwIO2ttBHAQwc
         d86tT8z3gtwiGBgabrSaorsbTpJB+w2Wp3F/32s7Rl3TUecQoTse3i3i4xqHuEF3UjpO
         r1ImYQdGUAM/gpyUxH8G4L4YI6AsHeWzOF5p1iWj3ylfVcXnCpFmb/HOodld2Fqs3D5Y
         4vYNWeY4Yy9oGsETCWq5FjedIEZKSZAKFT5ThOwacpK80fqz0/yIlet6dsu5zyOHowtK
         jHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ztFmjo5Zo5EuBU+qrePea2SHE7ZHtOIa9devh9QKOJ0=;
        fh=VyToQrAyDRM9Yo5dEJ0vrXXh9UuZtZ3WtvlOnf6swIo=;
        b=GeVAe1u96Q+q9Py3h+wOQB7ntBnVCWrXWqdeZsBxlks85yemm5ig201cqG2oo4Plxt
         ypgPicFX8QHWHwoqb6OcOQbDfs0EI0sksUo9GpRlPqGfGW157NraAo4BHatmAjtjFm6h
         vMY+0i9WfNFHOQToDe/R2NqyaAdBYjDdcgTiiRmcDctbC61ckeZAJHgZWVRjzkKS15NP
         4vWKfLny3/2QL7Ql+BCj8rUM7AXkdQoR+2VqdOf4wMl6p4sM8c3p6d+oG8/G9Y/HFSu8
         w2eJE0/Ie0JVA9DiUzNoi5WlSNwL9e/yU0mYS8a2wdAhF3Okv5AJWHALyf4baij3d2ds
         n5vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779284900; x=1779889700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ztFmjo5Zo5EuBU+qrePea2SHE7ZHtOIa9devh9QKOJ0=;
        b=qew81pfk+dznjk9ySsOa3iFLCE/35ucGoWMUldI5nEoFwBebWwB8dDq5+GkmryD3/4
         kj/94R3ElJJLEwnyZnog1ytD3tsaQWU6KoHGoCnuHVPGXcv09kp0J9+00BGFzMjlApCg
         DzdUHjC6CbxQznzeAKZDuzFei83A3JitKfhHFiuygiM4Yb4wga8dQZ2Ws6jRISTZ51r6
         i9n2mco8z6cvWUPIBzTPRYsZVWgbyBLTyiK5Of/om00jN0Y89jO9WXmX+ppDvdMtX3sj
         4V70Ups9Jjfyw49YUiTjcD6bIgPvqV+dXy7OEV9E6hS24NvTFERgLvFjRJstwEk2qh2A
         /X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284900; x=1779889700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztFmjo5Zo5EuBU+qrePea2SHE7ZHtOIa9devh9QKOJ0=;
        b=VHEPz4+ueGPMkQncRVUrR0xEBjKKt39VlkyuGxGcrxCqukT/Izm2l51JHGPVoDVasq
         n+sKPiWgjgJzZcikCOPGrLtB2tQYCuF4wxYzk95UFWpgmBVUnXBTOIQo4Sl25AxygYM+
         qFB/1HzxtJOw0A2jOPcGhBEq1RKgKSVi1n6bgFq5KX9DRNrh/StnQFL8eaNKXKf/YWVK
         dYQjfu0F4pNNehvS4rSuryYL2I6ZmlTrZ+tEwO9Pd0pLCdJAC7Z2aUaQA2xLe8uCgG4q
         ZINeDumPYlT/UY14CTk2/W/mFmBzEToepQxAdkvYp0QqchG8g3J2kwxNGjzC3amlfrTT
         SCqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ewIhKIA2WTAD1N3kbEJKIGFbCf9DrpSA15QI2IiXbYguB6AFt7DOiKqtltZt+U5hg1PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIUOUKlHvdNmZ7W5OjuCnaFXtSXFqaifo6CfDeRW1+spgj5KO
	0RKbIVx2ivHEwO0avNPGVUUkZYPhIa20LI1zs7AMh79D3s89L1dpT4QDJTfQgsdafm/7LW4SBxx
	J2UFdMQvdSNuzofyNp7JxryFbQChpgFm/XWjdOD+Q
X-Gm-Gg: Acq92OECJikxdJ2/ByQazUNtZDlYN1J4tZLEr4sZjThs5+JtVNv9VFb0S1Byi/UVHOT
	ybXK35HkdioS2uaestC+rGRxXddn3Zw9aI63vvzrl3ShsvvXoZNm+ZIPCJCJtt3HDHi95yF23EE
	dQix7GQOTqJcsnzOnbnRNV1s/xFLACSQRBhKVYp7MGvWexKrDNlZUo0WpzJRlL1tLdIBnUXFynA
	Fb603d/tkjq9xQoLzR/xYvnrVOextWFDS6soggCx+TlFkLbYL2DpfLiBLRbM8UyfMfpe2SCTsbE
	1MmzmOdRb6O6NCe4Kfe16DiMZHq4Rw==
X-Received: by 2002:ac8:7fc7:0:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-5167b683f38mr8972121cf.5.1779284898204; Wed, 20 May 2026
 06:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-7-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-7-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 14:47:41 +0100
X-Gm-Features: AVHnY4Lt4aJCZG7zHyyVEbse7TC1B-amOpcSsUxTZmECQsMY0Fon9T-IHHMiF9s
Message-ID: <CA+EHjTxg6f0v40EBDE3APXrF_qt=8GTx0dGKrKDLqiNwdU_dQA@mail.gmail.com>
Subject: Re: [PATCH v6 07/43] KVM: guest_memfd: Update kvm_gmem_populate() to
 use gmem attributes
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
> From: Ackerley Tng <ackerleytng@google.com>
>
> Update the guest_memfd populate() flow to pull memory attributes from the
> gmem instance instead of the VM when KVM is not configured to track
> shared/private status in the VM.
>
> Rename the per-VM API to make it clear that it retrieves per-VM
> attributes, i.e. is not suitable for use outside of flows that are
> specific to generic per-VM attributes.
>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>
/fuad


> ---
>  arch/x86/kvm/mmu/mmu.c   |  2 +-
>  include/linux/kvm_host.h | 14 +++++++++++++-
>  virt/kvm/guest_memfd.c   | 24 +++++++++++++++++++++---
>  virt/kvm/kvm_main.c      |  8 +++-----
>  4 files changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 153bcc5369985..bfcf9be25598e 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7997,7 +7997,7 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
>         const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
>
>         if (level == PG_LEVEL_2M)
> -               return kvm_range_has_memory_attributes(kvm, start, end, ~0, attrs);
> +               return kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attrs);
>
>         for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
>                 if (hugepage_test_mixed(slot, gfn, level - 1) ||
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 28a54298d27db..1deab76dc0a2c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2549,12 +2549,24 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  #endif
>
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> +extern bool vm_memory_attributes;
> +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>                                      unsigned long mask, unsigned long attrs);
>  bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>                                         struct kvm_gfn_range *range);
>  bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>                                          struct kvm_gfn_range *range);
> +#else
> +#define vm_memory_attributes false
> +static inline bool kvm_range_has_vm_memory_attributes(struct kvm *kvm,
> +                                                     gfn_t start, gfn_t end,
> +                                                     unsigned long mask,
> +                                                     unsigned long attrs)
> +{
> +       WARN_ONCE(1, "Unexpected call to kvm_range_has_vm_memory_attributes()");
> +
> +       return false;
> +}
>  #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>
>  unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn);
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index f055e058a3f28..9d025f518c025 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -924,12 +924,31 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> +static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
> +                                     size_t nr_pages, struct kvm *kvm, gfn_t gfn)
> +{
> +       pgoff_t end = index + nr_pages - 1;
> +       void *entry;
> +
> +       if (vm_memory_attributes)
> +               return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
> +                                                      KVM_MEMORY_ATTRIBUTE_PRIVATE,
> +                                                      KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
> +       mt_for_each(&gi->attributes, entry, index, end) {
> +               if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
> +                       return false;
> +       }
> +
> +       return true;
> +}
>
>  static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>                                 struct file *file, gfn_t gfn, struct page *src_page,
>                                 kvm_gmem_populate_cb post_populate, void *opaque)
>  {
>         pgoff_t index = kvm_gmem_get_index(slot, gfn);
> +       struct gmem_inode *gi;
>         struct folio *folio;
>         kvm_pfn_t pfn;
>         int ret;
> @@ -944,9 +963,8 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>
>         folio_unlock(folio);
>
> -       if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +       gi = GMEM_I(file_inode(file));
> +       if (!kvm_gmem_range_is_private(gi, index, 1, kvm, gfn)) {
>                 ret = -EINVAL;
>                 goto out_put_folio;
>         }
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4139e903f756a..0a4024948711a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -103,9 +103,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
>
>  #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> -static bool vm_memory_attributes = true;
> -#else
> -#define vm_memory_attributes false
> +bool vm_memory_attributes = true;
>  #endif
>  DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
> @@ -2450,7 +2448,7 @@ static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
>   * Returns true if _all_ gfns in the range [@start, @end) have attributes
>   * such that the bits in @mask match @attrs.
>   */
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>                                      unsigned long mask, unsigned long attrs)
>  {
>         XA_STATE(xas, &kvm->mem_attr_array, start);
> @@ -2584,7 +2582,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>         mutex_lock(&kvm->slots_lock);
>
>         /* Nothing to do if the entire range has the desired attributes. */
> -       if (kvm_range_has_memory_attributes(kvm, start, end, ~0, attributes))
> +       if (kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attributes))
>                 goto out_unlock;
>
>         /*
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
