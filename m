Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B53EE1CE
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288331; cv=pass; b=uNf81SZ5P+FrcIKS3GdETfinJlXcAQWWaU8vdLBDMjOlNxDZTfkcdAjzYi7LWouhYURR3oaf6baMjIOUkmzOQVcoAyXGlnlhIKqcA7zhUNdieIfw/bACr/goVKduMkefbipyKOw06ByicE1WCc5n7XJO9SCRU3n9wXeQfEpD0bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288331; c=relaxed/simple;
	bh=mWVxXGnAXrLsmeGW6dcs9mbi7yfF/v+MCyKGHC9nj44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU5jOxb3Gt6z2abqY8hn27Y50vyiO+5TiGPOIWLGzZhTuGroB8odReKaCtn3vnuPmtE29t73d2Jz23lnILCR8ds6TinPBL9OGgJSaHcuC2XznBeuMbVhPhnCmFoOK1gFSDft/f5Z2yCAP2wFEwL52EF5UL6lWSo29R5OBHG5BKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HrgJw6lz; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrgJw6lz"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d864c23bdso19511cf.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779288325; cv=none;
        d=google.com; s=arc-20240605;
        b=F5ez6ZMsETQplY2iFRQEHtCKUVC7IUytXLi9nl4e209DjXlAwS2wyLmIkO+2a/HcxZ
         VT468/8vkLtSebYfJHTp4/RW1MBo9T5StvxCxIbZEnszjYIetcrOKKgTgMoAn7cosKHM
         72Cu2cTbB9Ruqb2IzqdJlTBLDLWg6lJ1VIM/n2aiY3Y+sJUggb8CTjz1YzbK7pdaYLQg
         JYsp2Z9YsQjIJAOOE+sHrTUFuCzR1z42wjzLj0nN7nS7NmGc7gJLsAcg2VNCvjoZ7IK1
         JxLER91KAX6jGLhBTSNXHhKFtx8+2mEuam5FDnDnBWkeRBxghby0FV9JAJSBH01gIA+c
         sUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BXmdRbmYCHoIn3PGJ6dUolIetDSUosv3AORcVct4e6A=;
        fh=zFmWpOy2vdLrLayFYspZe6daGA8ppU4jfjA20EwFQCc=;
        b=YvuKk1TLxsrnNuLc8KDeVogJL2D2rgVmiKo5sQrnAsvFDkjNg+bj/9yAKDBFx5fnII
         KgPJg7ReWrStwLk8HtJ4KsiDZmEE3ok/4dhBXkqMdDeH5dY+5F7SEB37rFp4qdlVKMcr
         m5uXtJhn6h9euMoDSkulkm5yyYDrzv5UZyJD+egyDGMuH4ufIWpMyfZe4lOE4nXb+NRz
         cd4OxxJVRE2eaVBXJm7M1Ja2dsgTk3vtLfnsJ4tHZN4ZY8IDoUkkAZvlMYD83wIoxkaF
         +km+8bUemKffWLafQ9aoPtYJbP03WYiBS2SN6oqsZqQeQGYKyyM8eVpQIVNuU/g8RYvf
         B9lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779288325; x=1779893125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BXmdRbmYCHoIn3PGJ6dUolIetDSUosv3AORcVct4e6A=;
        b=HrgJw6lzSpp3OTjOPsfe07y/5/LGj41QMshFbBcCCovdB/gwd0mgKix6USycrkSb7f
         rvgylZ5JWzygWvTi/b0MwpNN47/8Y5ePHiziLvc++o1GPEPbhdNb4kDQn/z/RxYZ8y4e
         U6/wbsWDtsLSYsOki9uUIsSmadDDrDB1rn3oV3g5al8XmO4QM2alR8DWEZBE0ppShA9R
         szTjJsRJqBb7H8molO7D5QofGuQKi6W9O8G8R5u9Gj+Zq93cSDV04CHIdMUJa6XfH+kU
         GL63mQwpAev3N3npvPtVW61A6MaLJVm0DQKoN9eYGlPvg8rmjsrsdllGq7aR5MdL0Jeu
         5d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288325; x=1779893125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXmdRbmYCHoIn3PGJ6dUolIetDSUosv3AORcVct4e6A=;
        b=jIYnXVxzzoJK4ah2ou39jrb4pMi0nnuhGE8iNu7OU03g6kUj+SLjtLoou3hc1Ox0h+
         5kCYMZqv0+VNXWLcaEu87dGd/6Sc8wyCmSD/yjmxlLbd3RvkzatP7PTZzDxaoRUg+OWD
         TxFX/dHnfDmmPj/8/UmEVBlQ2OkIubOoUOPeAaGctsEWEH4/kVjvKyZOHBjmpcyLzv+P
         EGPFPYWPYmaiJ83I4F1SjgO485UXOhWC9evR8xvg5HaTnz1rP9rZQf5isM9mGAqucmoa
         BRQGSsN6CtBLXj6Yw0fD54XjRdNugc+xjNd4TuxDiu7o1fftkv5wd21GU07mEwYbKkQv
         IGeg==
X-Forwarded-Encrypted: i=1; AFNElJ/WtciPwu5sL/sG0bLVV6uzgpj/3PlUxjIftVfHpcbpoBF1oAHwh1Ho4QTssGIE10Xzsr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZZWI/KVl6muYHDvM/pOoKGdZQPiardlEtXps1mL9TCZR0wxl
	3ZgSqYhF7SV0ZqqCve7wIyfRmYANkW7ePNivY66p6XeiAyOmLvM5pLNO6Lp7cQYgRwcQczMOazs
	Dnf3ZsQTl/L3opvRtcTJvyeGHI8357AhqLGU8eg/q
X-Gm-Gg: Acq92OFehtGQUnOfEJl6oF+NgH/pmPEGpL6IxiLRrd35gzR95kCeipA5XHFeHV6SimQ
	VulOY0Fo2f1Zeu/Sbwp+Z6DBuvUeE/+Tmey6qWJ7vEwiDR+87y73J7poYdYUXkqcrkc3tl/fw3m
	bq5LZBqyvVr5JkjBXpRlygo6qFZZlFPV14nAtmPIIn6AxrZPhTczbVDGe5SXVS55DUiQruTwnZG
	cjbqUwcTYZZFM2DSOJjkWzS6Y6wlXxAfy9XZnRKYEkOtflmTTeGfEtil6pxtcQFgeOuHcxc7zbL
	iMjBK4en+jMA7diJep0F2/3/wX9dcA==
X-Received: by 2002:a05:622a:5d4:b0:516:4197:361 with SMTP id
 d75a77b69052e-5167937f111mr20387831cf.4.1779288323895; Wed, 20 May 2026
 07:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-13-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-13-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 15:44:46 +0100
X-Gm-Features: AVHnY4KqHADZuRuQJRLOmHo6Gq8ybi2wyD-GO9LIDMQsvWy73n-zAaUp_TqUxxQ
Message-ID: <CA+EHjTzDx01W5Xy=eMg54DGe8-+Pfz9u8XDgfSDiAJYu8MznmQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/43] KVM: guest_memfd: Return early if range already
 has requested attributes
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
> Extract a helper out of kvm_gmem_range_is_private() that checks that a
> range has given attributes.
>
> Optimize setting memory attributes by returning early if all pages in the
> requested range already has the requested attributes.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  virt/kvm/guest_memfd.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index baf4b88dead1f..034b72b4947fb 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -86,6 +86,23 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
>         return !kvm_gmem_is_private_mem(inode, index);
>  }
>
> +static bool kvm_gmem_range_has_attributes(struct maple_tree *mt,
> +                                         pgoff_t index, size_t nr_pages,
> +                                         u64 attributes)
> +{
> +       pgoff_t end = index + nr_pages - 1;
> +       void *entry;
> +
> +       lockdep_assert(mt_lock_is_held(mt));
> +
> +       mt_for_each(mt, entry, index, end) {
> +               if (xa_to_value(entry) != attributes)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>                                     pgoff_t index, struct folio *folio)
>  {
> @@ -649,12 +666,15 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>         pgoff_t end = start + nr_pages;
>         struct maple_tree *mt;
>         struct ma_state mas;
> -       int r;
> +       int r = 0;
>
>         mt = &gi->attributes;
>
>         filemap_invalidate_lock(mapping);
>
> +       if (kvm_gmem_range_has_attributes(mt, start, nr_pages, attrs))
> +               goto out;
> +
>         mas_init(&mas, mt, start);
>         r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
>         if (r) {
> @@ -1140,20 +1160,13 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>  static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
>                                       size_t nr_pages, struct kvm *kvm, gfn_t gfn)
>  {
> -       pgoff_t end = index + nr_pages - 1;
> -       void *entry;
> -
>         if (vm_memory_attributes)
>                 return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>                                                        KVM_MEMORY_ATTRIBUTE_PRIVATE,
>                                                        KVM_MEMORY_ATTRIBUTE_PRIVATE);
>
> -       mt_for_each(&gi->attributes, entry, index, end) {
> -               if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
> -                       return false;
> -       }
> -
> -       return true;
> +       return kvm_gmem_range_has_attributes(&gi->attributes, index, nr_pages,
> +                                            KVM_MEMORY_ATTRIBUTE_PRIVATE);
>  }
>
>  static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
