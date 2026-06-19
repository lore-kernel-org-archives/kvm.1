Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8C35F5F7
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857553; cv=pass; b=lOb7mq68XBStA6w2ZVW0d0xn5FoG7DAZU5dSJGHKNzLSqxjj3+5rJxjcPOjOmsLLLmQEADuNGf0Tcums4fiQi2bX8/lJ6CC8KM2F1whOW/iU0DRThjX71WBWuxSDunikcYvNRUnEM7OzNCc5pcHofOEtx5WfLWQdP1PyMvGW8fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857553; c=relaxed/simple;
	bh=aURqg38Q2gAlcr/J29NBP9ZvAVEI/c5mS9i6CA7HUZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKngcKUDO2KODkmK9uSBbdaSpepUXhM7iKveIfmCs1ZfEEKb9zoqhWVAOWBytZx2vbQf79kgbmEtVrMct0rXc6FNP1pjDKGJnAT6iQA7qFqds3d2mTFV8fmyZEc3D/ussBMPUDR/TJ0RbB1GwIRAS05TmllPzlW9Znm3FE9iQ3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C1qAv+DG; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1qAv+DG"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-519ed52bcc6so102471cf.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 01:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781857548; cv=none;
        d=google.com; s=arc-20260327;
        b=I8LI/I7RL5gmupMkJOwBm0MLOb3L5aK4lp/XgsAXEN4ePjhJI4/Yny3chlJQIf/rK5
         hodVhWwAtRfPJYts5IKSjCIxaguUeMgW8uv6HRQ9P0r6Pv9xDVkXlhZ4j0uRcxIc7Lwx
         2X6AoNEfKg5oTSWSnzjzwrTmsu3bEudtW38cFaVxKdWnnaIhH068H8ghKumUFjZqdVeo
         WYzNBqaIPHSJtxfeThgcmoo9LWEBWhIH18Mo38wc4aT+MXLPiTnCFJUdjtBtlhGi/oDc
         lIhwBfpJnKgVoQ5WNfjfOGJkcC7HKf+For7BuPHWW9J1Jd1RatpyvwMZekUbFx4N+DUt
         um1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3cFYWLK/FtmAY6SmJ1SGh+iq0DuUVi9vERhh19AGAVg=;
        fh=FakWZxl8JcF2WFeNj7FkHY4q8apOrZt5L5x39+MI1X8=;
        b=NG5pKXNVoLOKtZJWWUhEszILhu0vxjLYZIv+b4lgzv3n2vkp0PuArfEUhFROTef0bK
         /e/xmHINnWC0vwHgKxbDR0MVvmJXMmRbWJsVqZ3uHXwcTebaCASwHuwfth1cNrzKGiLV
         zI54/ca7xkUV8l6ghpfI1pc3vJzW4fRi3GYiuv3jan7wVN84cSyok4ARMOTkzzcHeM36
         9zY7r/Y8avrg4bmcRlZCYF+ofHtlQa6gvkROCFB1v/u1pIdUTbWrL0FjW0P8AY9UiygD
         Z3vlfcnWfYVTiUpPaVd1A8L/tXBMLFHNqJOwA3HLRSDgtKZahKR51XxiJ6uLCMChQs2c
         RuUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781857548; x=1782462348; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3cFYWLK/FtmAY6SmJ1SGh+iq0DuUVi9vERhh19AGAVg=;
        b=C1qAv+DGMEKxnVxM+sBr4NP5i8XNi81E7eDwYk+miFa0/XEfJlMADbx4X47I7GtYT/
         WmyQqfdv+tO5fw60wpGhgKzcYvy4V04y3fjSa55R3r6mFZ05u5SY4YlS6TnIDX6Zrugx
         N7ju1RVu+51gd+3UoThKClmRN1aw3Q0SL0UwMxPhmOFmteLLAi+rxWQ+8nhr4l/altit
         DhO7YwkfLwHvaykFsRDjKRpdRNkKCcFR1EMQo39iRVF2PK7aBdgoATs6p3Y6Selk2uiL
         e+Q5ZY6hCuTzkAZJkLNb8IdWfgwhRXyUdm7Q04hn8PPqZsaFfJn03rUcF8UmwPfobzCH
         9rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781857548; x=1782462348;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3cFYWLK/FtmAY6SmJ1SGh+iq0DuUVi9vERhh19AGAVg=;
        b=l0j8M56DVDbRiygnER3t+tnqI6gkDJWRacptdLX7K1Ixpda5/7C7eTkzx2Mjxj89le
         fl1105uDYGgsIUw7hGEL1InXB0ujwtGI7tIUDWVbeVRwPwFrImT1Hiv37/nepoYTVTVg
         Ygp0x4NzANxPhsOnDg5I7HPoIUqPK5tyI9jUb6AgNf+kbQdBxh+ZD49pQmCIawKQvfBL
         bVGeC11CNh5j1ROKjMy4o37o2gbhLks7S5ti12jGOQ3BsfW344ZvJ+cChnoVf6AmpFYz
         Kbaxgw44AIxTz6cJxNNsiJLIloV5wSXKBxmuN4jO7ZY4JyDEzZWKrI48xJAdNA61GRN9
         yTqw==
X-Forwarded-Encrypted: i=1; AFNElJ/T/4dWHyD38wFiEyB8YUktFb7jzyDBkxNCN26w38Ntu3LW/GGCl/sYc+kuSkFuE5/BfSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8qqG98gakYXNloPw5waU4DHZYGlo+a4SaqoIoHeFvpCI/zLW
	0sDe55fiv/z8P6ru/MM2sbL0uICMfqJumCbFkQammmEbSLJHGVVESFFBO47SvC9EBs46Tw5Ft/H
	2TFN9IhWtwbeA/SofcArxum2hcdS49AVocXmZ4Xzc
X-Gm-Gg: AfdE7clREnvCk8Hsp1Zb9pZ1nZ8yPBOAXH/k00XTKgdHfyR5W/Ud77f8sEulq8gABEG
	5nz/3r/mb/+dyr3J1Hgp/HGqn7vMUOPyhyOZCGIzHhW9e2OnVBysj62PE/GGrC7pk37tCgN1NRI
	vCF9Wz2hjEIWBVhgD/MejJOT2xl8x6Sfgd39PPhLVmaqXLW9Vu+4z1z+uMKzw/l8t9DkY5O/32o
	dOiqLxz6BVhP1fPCWHWhC9wMZ31aUTDd0/5NF4iNss44Leg6LZowYSR2/59+TbC11CKjj8K6Q==
X-Received: by 2002:a05:622a:1b88:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-519e891c801mr4739831cf.7.1781857546581; Fri, 19 Jun 2026
 01:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:25:09 +0100
X-Gm-Features: AVVi8CeyI3PAg86WrGg3AslQ1YuW7acL6Ym-NulDiNjx1M0Fc6iTcS7y2ypGj0E
Message-ID: <CA+EHjTzh+iThoVnLOGbRDgacKFcvbBxx9m_72bhfafE4J7a7jw@mail.gmail.com>
Subject: Re: [PATCH v8 09/46] KVM: guest_memfd: Introduce function to check
 GFN private/shared status
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
> From: Ackerley Tng <ackerleytng@google.com>
>
> Introduce function for KVM to check the private/shared status of guest
> memory at a given GFN.
>
> This will be used in a later patch.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  include/linux/kvm_host.h |  2 ++
>  virt/kvm/guest_memfd.c   | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3915da2a61778..27687fb9d5201 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2575,6 +2575,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn);
> +
>  int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                      gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
>                      int *max_order);
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 8101f64e0366f..bca912db5be6e 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -510,6 +510,37 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
>         return 0;
>  }
>
> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
> +{
> +       struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> +       struct inode *inode;
> +
> +       /*
> +        * If this gfn has no associated memslot, there's no chance of the gfn
> +        * being backed by private memory, since guest_memfd must be used for
> +        * private memory, and guest_memfd must be associated with some memslot.
> +        */
> +       if (!slot)
> +               return 0;
> +
> +       CLASS(gmem_get_file, file)(slot);
> +       if (!file)
> +               return 0;
> +
> +       inode = file_inode(file);
> +
> +       /*
> +        * Rely on the maple tree's internal RCU lock to ensure a
> +        * stable result. This result can become stale as soon as the
> +        * lock is dropped, so the caller _must_ still protect
> +        * consumption of private vs. shared by checking
> +        * mmu_invalidate_retry_gfn() under mmu_lock to serialize
> +        * against ongoing attribute updates.
> +        */
> +       return kvm_gmem_is_private_mem(inode, kvm_gmem_get_index(slot, gfn));
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_is_private);
> +
>  static struct file_operations kvm_gmem_fops = {
>         .mmap           = kvm_gmem_mmap,
>         .open           = generic_file_open,
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
