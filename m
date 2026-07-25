Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994637AA91
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784968752; cv=none; b=GoDoehTml+8sS7D7v5u+Sj+HRdTEGohhofoOl+J0Nc/n5Dh9owPQYvBU4dg+Bv9CAEhp9vriniIa5QSC1B76Xn/1bgi6Vv/uH4goQDPJITaL1bFMr0/07lunjm46bonGSIqk32uQYzt7RhqJlFQQwl8gkju7HEBt/tfl58j1gZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784968752; c=relaxed/simple;
	bh=xtGwDz0P01bYJir+APMy/wf/fTLb8WeZzZ7zrgi40Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjY/nbbW7t/TTHkF3DSEJ7M1E6p485CSO1+Hcl0WXFcdcYzSP0AQtv/K4l71dWzl+4si8xbl40I1wKeh+bUbg2nloIxy+oPUPqdgR8Qlg3eZ20PwkO60vgTD2waO8emoMJpj+WHbADf+vT7kgqoKa/bmkunnk0vPL4QVsYxd+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WuJ8IBge; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WuJ8IBge"
X-Forwarded-Encrypted: i=1; AHgh+Roaye46IAHtjh7KYPXQgIzIhm8tm4ESpImb7M5U4j1iQ4aK3uR+GWppCDc/FpUIofxxS8M=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784968743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ak98DNL/UFREAxbR/UyGgQjP3i1sDHFMoYqS8FS4ZD8=;
	b=WuJ8IBgeeSPsoDHzG3s2f1RnsF9JAvN9YLfG9SML+5N/paPP9MsTQExy5kCmGuHz9jYr4R
	1N9RS6Ee992b9j5gi1J+8PKy1me7myL55XQ3FYULLh88bXlYkJV54e/9YkqSLS7pCWXLIh
	8PiPz8B78PQKf75uNHhbOVfP5VQ2z3g=
X-Gm-Message-State: AOJu0YyXpCOWnbNh78LrKBx5ekTXHQOUB/ua38IKg9eMWc3/+RwG+avv
	KZsFjBP7RMoFCjLFGFWYaZNbXaHPUuB7zF1Fv3KZ1ckOmOLVlNoWDEaf9oBRkGt/dtLGmjozfpB
	jNPWzKcIEuehwuSQTiVYGQ6RLuoL63HPnMA0Fey62
X-Received: by 2002:a05:622a:a9cf:20b0:517:5ac7:332e with SMTP id
 d75a77b69052e-529a5e705b1mr11118201cf.6.1784968740923; Sat, 25 Jul 2026
 01:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-6-seanjc@google.com>
In-Reply-To: <20260723210811.72720-6-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Sat, 25 Jul 2026 09:37:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTz+OcLK+kADrAZ73saJh9c1ARLPgrRczojvb8TKx3scWQ@mail.gmail.com>
X-Gm-Features: AUfX_myvK-DQi5EWCFA3mqACFVjgyDMjEc_5E7tScRF_Le-X10NpWvyQtdU320w
Message-ID: <CA+EHjTz+OcLK+kADrAZ73saJh9c1ARLPgrRczojvb8TKx3scWQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] KVM: guest_memfd: Add helpers to query SHARED vs.
 PRIVATE for a given page
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Thu, 23 Jul 2026 at 22:08, Sean Christopherson <seanjc@google.com> wrote:
>
> Add helpers to check if a given page in a guest_memfd instance is PRIVATE
> versus SHARED, and use the "is shared" helper instead of an open-coded
> equivalent in the user pagefault handler.  In addition to the immediate
> usage, providing an "is private" helper will allow cleaning up the so
> called prepare() code, and eventually will be heavily used once in-place
> conversion support comes along.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  virt/kvm/guest_memfd.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 2effff582f50..e9d61410e5fb 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -60,6 +60,16 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>         return gfn - slot->base_gfn + slot->gmem.pgoff;
>  }
>
> +static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
> +{
> +       return !(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED);
> +}
> +
> +static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
> +{
> +       return !kvm_gmem_is_private_mem(inode, index);
> +}
> +
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>                                     pgoff_t index, struct folio *folio)
>  {
> @@ -397,7 +407,7 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>         if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>                 return VM_FAULT_SIGBUS;
>
> -       if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> +       if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff))
>                 return VM_FAULT_SIGBUS;
>
>         folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> --
> 2.55.0.229.g6434b31f56-goog
>
