Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B235F8D2
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784759190; cv=none; b=FUPj8lpQokkIoIygqycI0fHd+SbTgGi8VrHnv5BKe7zJbAutWLNbmjm9JIQBgegpKZ3MMdEBjIk8pF5mSSDRuUiRYk3rLWGDbrQxHm/Zpvlzu1x6d63pw+lTpXEa/ag2PDvKpJPAtQcZym6nDWYRVQK3cesyTjDjldkIV2low00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784759190; c=relaxed/simple;
	bh=VnD3Bpu6SQo7s8kYJiYD4WRAvJSHFyyrB3+VCI1FZOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L0QRkTN7wpWBVqWJTIrfHv+KLMuaSMy+oCn9TcM3VjvOw7gAbFlg6yjLB7rvqQDNJ3Z+c+kv5HwX45SOGzEgbln7ajTYoq1ewmH4tCNWNe9+Fy/YcGyxlfs3o3tZJsOHgvhXq81w8qr8SeEG1uchkOgDAr8RbSCgnOc4JZmxpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkzQBDlo; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkzQBDlo"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so24443789b3a.2
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784759189; x=1785363989; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=laTo4SBwQXEAnLcKiaqv4FvHxqBPf3bTLFGxEPIn6aI=;
        b=BkzQBDloZPxezwQ1ZrEL6pGPkqQSbmKZnv3RA/8GJWIG3OZSiT4lGcMDv8U29N9YBc
         hMfd3Hy3hPuFsjy9wv/Pd7k3mle+s59wUCv57xJD1WjHlmnRQ9bp1uKAXfB7hSH8VYfO
         vfnBiNB5N5C/GK/UXMDzhxIQvRnDQH27gMzOESHZwXPbWkS8zyuAITUZNLZph+9G9E00
         36BWYaSwtGeJNJNf5yTuTEQX+7HYVVSsB+7MwpAnmWeRVh46BSDxg7uxlJ5WEnNY/r8y
         HnOAbIDhLNRwHCi3J55hIKNNecGYHVSRyJ0NrtE9vqL+FnSwAN1gcbhEmVk/8f1So69V
         Q4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784759189; x=1785363989;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laTo4SBwQXEAnLcKiaqv4FvHxqBPf3bTLFGxEPIn6aI=;
        b=EMl1xcbmNHsLUPhQw+4xYl/sSyralVKXSC4596JRGZHYtRXVOVfAadu8S9wHcAq3LM
         ezbtCGVVUvQepu/3fqZntBZl4FJBGR5YEEQ0rB7Q0dkf2QObqcZXDLMZzDL041hCrfNq
         aTxTlOicqN2XojNJ7Z6kvBeduG/hNqmPNgRaDGHq2ucxLqXBwtw+ZvRmcuRzFMMHEt4m
         2yZ66+YM45U8K+9+Yrf3RAWiI5nf7RGnGLtCMfaTlXJZaNfl+lRNicBL0QZy6vK6SSO7
         s1tbuxPXFB+Q9xk89It7Q2BiherzI5qErWGBjvlsZVrdt/4RNguOHRT8R3iBMwbbTvlm
         VFTw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+Wjy7GgRHjrJJ323oUei6fiL1u4a3LlxG6MIgxnl8iByUiqGeS/hl01DaCZ6PJshvxhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQloqCJRKB/KMCH4T9KXGeXKzujX8wt3CsQfKrZW7sr2MqidF
	BmI1TQGA1W9hUtoyeJppB/xpfFGkiDPuUW0jvCg0tcspEgkAlUV/sS7ONMdrRa0lUMd40Q6xul+
	Inh0aKg==
X-Received: from pfde19.prod.google.com ([2002:aa7:8c53:0:b0:84a:894f:23e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a05:b0:848:56ff:6ced
 with SMTP id d2e1a72fcca58-84e2b7e5a66mr797401b3a.8.1784759188398; Wed, 22
 Jul 2026 15:26:28 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:26:27 -0700
In-Reply-To: <20260616004155.1435766-4-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-4-yosry@kernel.org>
Message-ID: <amFDk2aenQTZUHs-@google.com>
Subject: Re: [RFC PATCH v2 03/25] KVM: VMX: Generalize VPID allocation to be vendor-neutral
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 9368a71336fe4..e021ed562502f 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -8192,4 +8192,68 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
>  		}
>  	}
>  }
> +
> +static struct {
> +	spinlock_t	lock;
> +	unsigned long	*bitmap;
> +	unsigned int	nr;
> +} tlb_tags;
> +
> +int kvm_init_tlb_tags(unsigned int nr)
> +{
> +	if (WARN_ON_ONCE(!nr))

I think we should cap @nr at 0xffff, i.e. at VMX_NR_VPIDS -1.  If we end up on
a system (e.g. in a VM) that supports 4 billion ASIDs, KVM will burn 64MiB for
the bitmap, without any reasonable hope of actually consuming anywhere near that
many ASIDs.  Burning at most 1024 bytes is far more reasonable.

To provide some defence against future systems, maybe pr_warn() or something if
the number of ASIDs is capped?
