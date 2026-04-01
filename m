Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E912DA765
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052322; cv=pass; b=F8PM5mBU+hOKqylYgfEOOlZ7dXqW+d/h4RuUPF4Jkk04amfBLu5Crh0/L4EG+aH7iY3/HA8PlmtuOsFBGpuWMuG4FJr69iuUDkOh6nJAvBZFSmJkwph9bGxek7nSjkp1ui6K5v4wGPXxsUEmULQkI2lta+ArnhpU1sZrzLN1C0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052322; c=relaxed/simple;
	bh=3T7GMoC0fS9mqAo2YBiLIAD1sZxRlz6N0Q1xMegEdoc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ2oEMrXLAbW05uD02OPBuY6H7mJAT9rDNaUsQ4yDt5ofjYD89qowuFeQdGaCMQmpuQarAEE0/JdpKYsRDzGf8VvHvvpSnrSPTMTBILoJnFLVaoaeudm0hfItmbC/3G3e4OpNE1HjfLrIt+kiGdTY6xXl6JFdpzp7gr5rKC0xMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lbow/tti; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lbow/tti"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56ce54c8c82so2233227e0c.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 07:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775052319; cv=none;
        d=google.com; s=arc-20240605;
        b=WEEREWrJXTUqFGg9/zaoNdCVJy72sASW1lh6bVIb2nK9DxEXlCPlIHS+1Le7xOJ9ZL
         hp77LJX4Ra1KFPMrflHIzLDua6o+Pq9kKe//1UL68/gC3BqpeGufTm44+LTPdIEVGGm7
         8FJSvuiUuGEwLjOjGrc5FxMRpBdFyBrmplAY6Qrn/iAWmI3ZT0VMf2VDskuJ1TCsh1FC
         RVXgLfOYRW+WdJ659Ilr3xYuuB3CMjCLkATp+g+pARNfHVFDBha2tGWV7zDL6LoJ40jC
         FVTaYhq6yeAUyrXDQJH/JY73QxFITHfos/YEr28LpUmgH9XdSSYwpUNR007XECsjPAPW
         C8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=cok0tTO+M9AY7GrL3ZPCAkrKaBzewD/gpEZeNzSpUo4=;
        fh=Hx326Hzy9KYMhk7q6x4ZbaZ1ppfuDvFJSvq+od9WOXk=;
        b=JdrbQw3nzbHjFqsv3llE4T4A2fkpxDccTGTvJIzop0npkEDHteAw4RVkAa/Qmr3lsb
         5LFTNQxdAwzj80DlFJF7J+1rQbqRl3mDd/NfGcBJRB99TEXA8hBUFiP4RZ3d0Tr01/5t
         4LSUiPcqgFBfP2u67pby9k9xnp8byR4RPKdYFJjtCh4y1vm+qDJcS468VTTadZSyMCWx
         141T3BZOdQjIXKSJtglG6kPNJREsafLFbajW/zrgY6Xn+f4lwZ711jFaumsJRa5Bvsa7
         zYDsnZRxwcH/lEx622xpqheniJzfveqzA+6E0UT61/9DqzvgaJ+UiHBQ+WpL3s19H4KH
         1Vtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775052319; x=1775657119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cok0tTO+M9AY7GrL3ZPCAkrKaBzewD/gpEZeNzSpUo4=;
        b=Lbow/ttiKEJRDtPj+OG+rTXCulIkjlrXMI+o4XPgVekF0dubJBH2HbxUjCWHu8ErUD
         6Rl42FaAmitfsneS3ngwL1QprV6hIl4DrHMdFNNw39txaSJpjYQMxNFsAZOs6RZ/rh3+
         9J1amt2st0Tz4mQgpdQLDUZ8/GlliyN6xxPBwBC7wIE8wDn8ofpuUdwpZKOTufi+4j9V
         Ql93olIqf/GlDjNMBXCTioEbclHPkXGzahuFoOjfZ4S0fpATsLLG+jnxpStxP+Ar4oP7
         nSlw3cT4m/ERiIi4XlCFujlmaMHGQGGE/6ySRbrnRm0FV101oDd7yYqfET/kPIAvOZhA
         SQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052319; x=1775657119;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cok0tTO+M9AY7GrL3ZPCAkrKaBzewD/gpEZeNzSpUo4=;
        b=oz/bzNxV0ZslGWdX6tZNOzcy4Nax1OLE6V4Tf74EKD88rzsb9BHhV92AlholAIkRFj
         VO/cABg2RpAs9RFfv1EC11YC9jpev8LWMnJ72IdCTzA59GGLfDLdIknkse3gLt+5mWhL
         JakTZyTrMFyWkfuaIO2sMbWORWdAokj/3AD6IMVyL15AY1OJDyXlz9yVz5YBWpCE6KWN
         7MFz2xWouh9N8clSSsgcX/Era54+47u+MSdwFOtINqtWEgn5/vqIis3v5oFEZmVcijqa
         ULhrM2PLJUBiGNeuCINdgkJEr2WnnYc6G/KJ7k7p0sjulS21lE0PQlM5jG43xugBfzk9
         7pjg==
X-Gm-Message-State: AOJu0YxUdlyT9QbAKFCYiwKYbdFTEaHkctH2bQ6J6acZgEAZ/MPP5yRM
	RG8hVg2GDNEF4igGwf90Os7H9ElAGkTPYYOi7s+730vYeK3IVslaCUpLolzJ7rgFZdiaC2zZFwa
	JxOe6wDjRtL1b54jlKg06ZjYQzzfFwmziLeoPxDF2
X-Gm-Gg: ATEYQzzemm7dqzpeKItLWMDy1nJz5E3wyWlaD9+0jBguQtFyV4ND4M5BU4JOuL/NoDg
	hnoGZEp6Vj40YPVW/vVZ90w7KMt/V+XBl/bh+9qhbQdvCGsk1Q8oKbNhhbpwd5McrqfOCGhLMNQ
	ntigz3owY8smWOV5fVwnGJPEXCRBfjP3DeAA3ZxApyOLQ8W/OOPqieF/6hmREoWP/m5ichDCRkQ
	bYTb3kphz9UEWh0dbGcP8B+yF4DhtAj3z0OFSsrbhmQL87KiyXeqKKIRtrAPB210wWrzitD6mBR
	iTCVBAvBeOJg8VYTreC6Yn9S2gn2PkAEHaTj8g==
X-Received: by 2002:a05:6122:ca1:b0:56a:ef89:34fc with SMTP id
 71dfb90a1353d-56d8a81bd48mr1423992e0c.6.1775052317094; Wed, 01 Apr 2026
 07:05:17 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 07:05:16 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 07:05:16 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260326-gmem-inplace-conversion-v4-7-e202fe950ffd@google.com>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com> <20260326-gmem-inplace-conversion-v4-7-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 Apr 2026 07:05:16 -0700
X-Gm-Features: AQROBzB8ZjEkM1kRtGYPSYrf1SL2xnDWxbzougnTteAKEFNAbNZQz2YVpzx5v1o
Message-ID: <CAEvNRgF+FjJ1EWSR_rzD1=N040ZitiRrM2O3N0Kj5yN5rT3h+Q@mail.gmail.com>
Subject: Re: [PATCH RFC v4 07/44] KVM: guest_memfd: Only prepare folios for
 private pages
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> All-shared guest_memfd used to be only supported for non-CoCo VMs where
> preparation doesn't apply. INIT_SHARED is about to be supported for
> non-CoCo VMs in a later patch in this series.
>
> In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
> guest_memfd in a later patch in this series.
>
> This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
> shared folio for a CoCo VM where preparation applies.
>
> Add a check to make sure that preparation is only performed for private
> folios.
>
> Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
> conversion to shared.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  virt/kvm/guest_memfd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b6ffa8734175d..d414ebfcb4c19 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -900,6 +900,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		     int *max_order)
>  {
>  	pgoff_t index = kvm_gmem_get_index(slot, gfn);
> +	struct inode *inode;
>  	struct folio *folio;
>  	int r = 0;
>
> @@ -907,7 +908,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	if (!file)
>  		return -EFAULT;
>
> -	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> +	inode = file_inode(file);
> +	filemap_invalidate_lock_shared(inode->i_mapping);
>
>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
>  	if (IS_ERR(folio)) {
> @@ -920,7 +922,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		folio_mark_uptodate(folio);
>  	}
>
> -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +	if (kvm_gmem_is_private_mem(inode, index))
> +		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);

Michael, I might have misunderstood you at the last guest_memfd call:
sev_gmem_prepare() doesn't prepare a page for being a shared page,
right? Does this work? That prepare is only called to "make private"?

>
>  	folio_unlock(folio);
>
> @@ -930,7 +933,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		folio_put(folio);
>
>  out:
> -	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> +	filemap_invalidate_unlock_shared(inode->i_mapping);
>  	return r;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>
> --
> 2.53.0.1018.g2bb0e51243-goog
