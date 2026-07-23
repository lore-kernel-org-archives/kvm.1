Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C741E5B64
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766483; cv=none; b=TW+8reuAJ3LEN7QA1A4x1d98QVC48EhiEwMU9qOQZPgNgbQwfPE43XohAsiJ/0D3cr2YFh56KWFI6vTlzOMf5Z9e5iOjoVlzsdwXZ9Jd9dM/c4HXXV6jyS6yM7chX2MmsyH6wK5wkgwEe2iWVMs+SsQ7CWXnye/UNLkt44OfJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766483; c=relaxed/simple;
	bh=/UZySirpid/MfDWu44GC6SToSJ2/wtOHnG0Mh+touCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LxK572wEvEMQ4rt0sVFqSUP16//r8E7Nom9xrTAYEYAyVxtbu4Q17jejUzX7bQUjq/egaYwiVdO74Cq/mnX4DAEzbbnvpoWQTJ+6YoCvjTSpzqZHldjLkNJbnNsowuu4Vmc05eYG5uhvy9gG6k2jyF3D1gYscAF+Aps+CtVx+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBc/AfBI; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBc/AfBI"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84877b362f6so114858b3a.2
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784766482; x=1785371282; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkJ7G3XJxikXzwURxYlXUdmxo4NZ//WfuDj4slMPc3E=;
        b=OBc/AfBIIUM1e8RISOuxldZ92ty+PBxhJIrLWYzzicF/xcnt9/yOwJVF5KRYWHkLso
         UWXWfxC19GiIHoI+MD991lv7TMBlrhGvNiyDCOUnd7UtK1aTckC2/A8ZmBll5c3e7vSM
         trz6qr19F3NMAfebPRXRg2jI8EESZp5V0tm1yqMaGZzzvvIT9PJXD4k/VhOJhrkreHdX
         67hND8E9/SIH2a5AzMyi/rKMTUzjD5sdVCuEtwEHoxC04O1kOfUOR/GjrBDrFlI+6ztO
         QLX3IxRpyn2eFdDwk2ax+18vbFNoUSOD9OqLVjB+p1XUonYRNgkVX7khbJjcst4r1iDh
         z4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784766482; x=1785371282;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkJ7G3XJxikXzwURxYlXUdmxo4NZ//WfuDj4slMPc3E=;
        b=AqlIywn3CYjofcSGKNijWtmvuDUHKBPy4pfz3QCaaC+AfGaYBPa9HPLV9PzNhB8s6/
         qciXrefUYzQLJGdM8zgQX5pfqo2Ge5kIKtFnZZo8DCghErnTiTkpHcI1NTE7imPBvDnj
         2LSRMaGRPb7hl2pzW+3/1gzNR81BBKRrKxuavdTMI/JTJjNxZpv6r3fgSfqReL24HGLZ
         KyytyOc9TapnwZMnGymazjm4WWh0XLFSbwgEG4oY/N+E3nm2Z5uQO+kFWv7l4QJD9QnU
         WfEBbT+JYUe8S9THKAZeHiimACmPe7u7c26TxwFOV4bwpI8zzRIJGkmHXThlqoBhrnJi
         D9VQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOsNrrbxiDmqIHSt4YCyJrwV5+pOT31VFD6bTtv2dJaObqUlQqsp+dT3LqZcr6u8p4Adk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDKUm7xPmMiXFhMIH0fqV+fQ3Q0kRlmqGIk5fsayy/3iDxbsO
	tUJ0taUjwJ3MoHjv2il2E7VFEnJvIxHpvMS+TzOG8wuF5mgK5CLgRwAHt03lkvTxG4TimkPBdO9
	yMhv9PA==
X-Received: from pfbll22.prod.google.com ([2002:a05:6a00:7296:b0:84b:6d07:4d38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2347:b0:847:9745:2f83
 with SMTP id d2e1a72fcca58-84e2bc2ead6mr1152550b3a.18.1784766481557; Wed, 22
 Jul 2026 17:28:01 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:28:00 -0700
In-Reply-To: <20260616004155.1435766-5-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-5-yosry@kernel.org>
Message-ID: <amFgEO8NnEql1MmC@google.com>
Subject: Re: [RFC PATCH v2 04/25] KVM: x86/mmu: Support specifying a minimum
 TLB tag
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> In preparation for using the TLB tags allocator for SVM, which has a
> range of ASIDs allocated for SEV/SNP, pass in a minimum TLB tag when
> initializing the TLB tags allocator. The bitmap is conceptually shifted
> such that bit=0 corresponds to tag=min.
> 
> Specifying the minimum value during initialization also makes the API
> clearer, as the passed number of tags becomes the actual number of
> *usable* tags, and tag=0 is explicitly excluded by the caller.
> 
> No functional change intended for VMX as VPID=0 is not used anyway.
> 
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/mmu.h     |  2 +-
>  arch/x86/kvm/mmu/mmu.c | 38 +++++++++++++++++++++++---------------
>  arch/x86/kvm/vmx/vmx.h |  3 ++-
>  3 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 9a2916012cbff..cfffee92b8b71 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -337,7 +337,7 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
>  
>  typedef unsigned int kvm_tlb_tag_t;
>  
> -int kvm_init_tlb_tags(unsigned int nr);
> +int kvm_init_tlb_tags(kvm_tlb_tag_t min, unsigned int nr);
>  void kvm_destroy_tlb_tags(void);
>  kvm_tlb_tag_t kvm_alloc_tlb_tag(void);
>  void kvm_free_tlb_tag(kvm_tlb_tag_t tag);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e021ed562502f..bf2e0c2205631 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -8197,24 +8197,26 @@ static struct {
>  	spinlock_t	lock;
>  	unsigned long	*bitmap;
>  	unsigned int	nr;
> +	kvm_tlb_tag_t	min;
>  } tlb_tags;
>  
> -int kvm_init_tlb_tags(unsigned int nr)
> +int kvm_init_tlb_tags(kvm_tlb_tag_t min, unsigned int nr)

Hmm, I think this code should handle "nr - min" instead of requiring the caller
to do so.  Because people that know how SEV+ works, but aren't familiar with this
code (like I am right now), will probably find it confusing that nothing in here
appears to account for the "reserved" ASIDs.

Maybe this?  With documentation that reserved ASIDs start at 0, inclusive, and
are contiguous.

  int kvm_init_tlb_tags(unsigned int nr, unsigned nr_reserved)
  {

  }

And then tlb_tags.min becomes something like tlb_tags.offset (that's a terrible
name, but you probably get the gist).
