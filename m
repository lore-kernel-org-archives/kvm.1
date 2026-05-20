Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD333E120E
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287493; cv=pass; b=Pl5jhwEjRB36xRvsC4elA+JC+CX+ZVsQyuenhJKJBYrRAuHHEvKh/mub6o5tD7ab9xcN8BYgRio5dCaR6CC9ftvH2xCewtZUYpdFqux61QCkjBZCh3FgNHDa8O2kU17fBD5SCzQMiAskPag4pJkXDftAF4g/JHGLo434Agk5EQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287493; c=relaxed/simple;
	bh=X/hV5ljxWA12U5TVhXUBeSsDz7VPis8ajbh1wO1J3cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raqbaaBOEy+0y2FAsHePt1hoGJt72gbuUk2ZKCSZkMGSKGrYrvhoEo2U8G33yLUJPd5EfJe+xwwzsrphugFZxkxoMaZnJrpaWWa9ZlgltY9gTUt546YmBXuD9n3szi4B7fJcn0LQ5vfNcQZ0HwkztFx3Pf3En2hXsVO1yFtsu68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAgWSPAS; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAgWSPAS"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e61648f10so3971cf.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287490; cv=none;
        d=google.com; s=arc-20240605;
        b=Lzd8R3MCCPDik29IUR2n6p0QZ6ey1dto4Utp4awFvThG0GPgplLu5ca/zNt+6LI7oO
         u6e1Ic1pKGc4LArLqMIxHnH3OiXMZ7K2WOTzD0EqU5mC7Ete+qsRRKf13fUy6vO1j+Su
         PZ633vTlC8BpJ6Fp+n+tg8fhD4teJKhdFqtmFgXtRX9D5L4Ur7b2zWr9QjkQHbPFcWFi
         QRzoF1gJvxOuWdoZOYf4CtxVOzkWQ0QO0zKIOU7kZpuTtFOHKr4Ad3KZGQH4iibvRtlM
         3eh3Z9eZF/NvFyhO2zuCmivZ7fDb5UERH96fmvVrtVTVjwn+uQvxj4HDJgMx/YylO1/U
         LFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7N5NasgJypbMdlNYb/j7e6t6w9YfyUO25pmJjvirfi4=;
        fh=82fMbEC5DCm5JcmOOGs5n80s6ngWP5KYWkrV8uuk13U=;
        b=dAcebhCUD9V1nvNbb9SBdQPw1civyVMsPviBuPEQCSFsRBFc49DVPQUk/9iEMCeYIZ
         /DWKUM5DXpgBgOj5mgabJZslhEHsSZz4M5+lZnPa1jFj1XRhAo1HI6S79mpdpFfUXEBG
         c5heG19hyyUwTvLzm9f2fIhcA2IEHBtrIJdJptFeMxksGj/EvPptSg6rEJG/EeiLLBC+
         lX+aKF1lyx+99n6cNIgjIa0zb+HQ5k3MbmwIQYxXEYxzxxfnGhMT+8spH1YPzWdNFqjh
         Ua8dyhh8Pxz+nbfoH4RZTsECNqLQgr5nQJXo3dJA6ZJE5D9Cg8AlNFFnBdG9Lo/mjQLx
         xIlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779287490; x=1779892290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7N5NasgJypbMdlNYb/j7e6t6w9YfyUO25pmJjvirfi4=;
        b=sAgWSPASz84xDaiHsHZWK61DKD8v70jyk6s3eX5y4Zcouu0JcgAQWDfhoP9fop4DGn
         4T02M3rvi8nCBwxAC9vovMI0Csfczv8MHiqxfoeenk++CO7UczOzat2siilMScimN24a
         Arxgx+NXokXs789j9Rwuiqs9OeWVWgTxHuJzAbVCH82oQv+znvfaPM4bV8bYa0F/HgS3
         YjvChslZ3w3cqcVTjy26MDzx7/wRJsqaih1tSMNg4VxFg7OjPMt0HLfSq1vqSnbPfCgY
         AXI02dKrVpLyqtFflMy9HDGDtfPgf9bQCyvVNyMmK+btJyWVuFhlyGte6gexcrbAIKnn
         /fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287490; x=1779892290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7N5NasgJypbMdlNYb/j7e6t6w9YfyUO25pmJjvirfi4=;
        b=Z85boKISPcocVjea5dfJ6d9mBGFxtzZjQgOyrJ+g3NybKcBL4XlkhreP3LWE9YLuBe
         7NVeFC1u2jL96JZERA/6iDz9xou0FrInBFf+M5DU4OoH6ss3RBHJ/vARbZEgYdafauC9
         x77vPSivlB14gRfnnIWUAHr5kH2bw3LvgNjz2AY/T2HPYBUlKdwHt1H5ui0yf7GEa7t7
         nKkBvEkG7Rpbo4/nLxspPwvZSfXUQTj6tm+VHuIIY4pZOTXK8CuGGrQWnPp/6U0QmUCe
         9uRvkDBBQRlnpmA779yssBT54D4ewZGFIAp1i16govSjiNO0r/IZnVt2wK1P24zakqtI
         unnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+I6ZvKJrj2h7UOEvZLdbw6WG3DWRDdpz4SN6OFQLeJKbOchBGnGVQZwDw7qq6sQUUYR0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6pm3nYqks7OemYTaWcguLG8/dhc57cQTA68lLmAD4UWRYyDN
	eesPQ28a47We0HPLWw227jDgWd9CqX986xE+quuLMnw/S3MkkbLp0E3VgZhS7x75TQNEzK/8DDg
	HVfpZ0O8bM7TChTmeNV/6kOp2g3GIjSGihl2VRBDP
X-Gm-Gg: Acq92OGjRZJM9FvxQ9SKrLBSql7/3B/O6fpQr60uh27peBwVcnESM/UnGvQ/mOxcs5z
	/0wlknvVV719mJYJaymG/i/xlpMjB9NPPLnaG8zjn5PvXpynRX0R0KzDTx7mj1wKqBKq9WhWODQ
	W/dGYCQC9tCq8fqlJMegRncBNoW6ISyiJ1+0EsI/TzgEwywHA8oB/UEAsQYCC/DZcM40zO6ujer
	0ZKZ8v6HMa6aeLKuyS38Pe7d1cE8L1LZzfINGff0FvtxFlQw/xMOEpdpgobunluHa9XzRo2R1OV
	0gaHe9FX+CYHdqAAbKk=
X-Received: by 2002:a05:622a:989:b0:50e:6360:96e with SMTP id
 d75a77b69052e-516791fe73cmr46959761cf.0.1779287488674; Wed, 20 May 2026
 07:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-12-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-12-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 15:30:51 +0100
X-Gm-Features: AVHnY4Lo4l5leoGwp4MOUhUOXd-ZR6_GPypj6bN4fnpU5Ptxtsw2Fzt5rIYMAIk
Message-ID: <CA+EHjTwOfJ=nCRoX3m5uDt=CcF_zrqGsZVBBmo4MscmPqrBxOA@mail.gmail.com>
Subject: Re: [PATCH v6 12/43] KVM: guest_memfd: Call arch invalidate hooks on conversion
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
> When memory in guest_memfd is converted from private to shared, the
> platform-specific state associated with the guest-private pages must be
> invalidated or cleaned up.
>
> Iterate over the folios in the affected range and call the
> kvm_arch_gmem_invalidate() hook for each PFN range. This allows
> architectures to perform necessary teardown, such as updating hardware
> metadata or encryption states, before the pages are transitioned to the
> shared state.
>
> Invoke this helper after indicating to KVM's mmu code that an invalidation
> is in progress to stop in-flight page faults from succeeding.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Minor nit below, but lgtm.

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  virt/kvm/guest_memfd.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 9d82642a025e9..baf4b88dead1f 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -603,6 +603,42 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>         return safe;
>  }
>
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
> +{
> +       struct folio_batch fbatch;
> +       pgoff_t next = start;
> +       int i;
> +
> +       folio_batch_init(&fbatch);
> +       while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
> +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +                       struct folio *folio = fbatch.folios[i];
> +                       pgoff_t start_index, end_index;
> +                       kvm_pfn_t start_pfn, end_pfn;
> +
> +                       start_index = max(start, folio->index);
> +                       end_index = min(end, folio_next_index(folio));
> +                       /*
> +                        * end_index is either in folio or points to
> +                        * the first page of the next folio. Hence,
> +                        * all pages in range [start_index, end_index)
> +                        * are contiguous.
> +                        */
> +                       start_pfn = folio_file_pfn(folio, start_index);
> +                       end_pfn = start_pfn + end_index - start_index;
> +
> +                       kvm_arch_gmem_invalidate(start_pfn, end_pfn);
> +               }
> +
> +               folio_batch_release(&fbatch);
> +               cond_resched();
> +       }
> +}
> +#else
> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
> +#endif
> +
>  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>                                      size_t nr_pages, uint64_t attrs,
>                                      pgoff_t *err_index)
> @@ -643,7 +679,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>          */
>
>         kvm_gmem_invalidate_begin(inode, start, end);
> +
> +       if (!to_private)
> +               kvm_gmem_invalidate(inode, start, end);
> +
>         mas_store_prealloc(&mas, xa_mk_value(attrs));
> +

Why the unrelated extra space?

>         kvm_gmem_invalidate_end(inode, start, end);
>  out:
>         filemap_invalidate_unlock(mapping);
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
