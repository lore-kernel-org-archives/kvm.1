Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D548FFF3
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832475; cv=none; b=AxV5AUCu2AoD0KVzUGq0yA8zfX8EADL+L1e6UI/z57NuAhFLrB6pGXwCQlSh+3mlAaRVOJeVo2Wal63yxV6PQrZu0sBLpqMRZ3ChqfzInAifaADtlKm0M2iUJNHAKjwLWxJl7BD9Rfz4rv7Wji6XgGWV6cEfLbeMYGE3sMvnE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832475; c=relaxed/simple;
	bh=78fOzYXj5S5tQojwlT0W4iq4r8bLtJ30CY/GnVIxDqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AFQhLsgZIvhoJqUNu0wgf/0Pxo6iAm4N6LGSwy8uNOseVEMXT1uboVWRETAeivXALoXispWKulWbHOZC3NpQ7fH/x9bbbTJrabFt6MDCbCuRs07KYUuzwMI4zYUDDHxZydnoqt4gUXWf/Ix5eOWI66ajIeTMzqRcJmEJfTE+toY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KITmmuDy; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KITmmuDy"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7f385887bso19093715ad.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784832463; x=1785437263; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FuDTvSeEe0TLJxoQNV0ifICBEAUK2JSglObuf5ff0E=;
        b=KITmmuDycVbSDWFVBIecqe/FaeJ9blFmZWJoOhLObJdqIMCvLraZPJ95xRiAqIYKb2
         jiRmYnrcluXnrjQkTHdYEvXJ1PQwns3gnFEK/swqhuDTe4ApaoQK6m9CkzSgfxLZGw8d
         TO+N9A8pgnNR3jx00//XdegrCUJiAMR+EOfIsDk2ZiPmPKG00LzFVZ8VhnAZm8uMoY9o
         mieaSxp9jsTI1mtRfFn39g2t5wjG49zTI81UVj7uitcgwOAWIEYnmHlZ4RqmuI2HHp7K
         eSZQ82c8N/PNu/vHpk6bc+jMn9qI6qLrsr5+rKWZx/tlY4hN5B/ALXBAL7UfwOfXnwlm
         OWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832463; x=1785437263;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5FuDTvSeEe0TLJxoQNV0ifICBEAUK2JSglObuf5ff0E=;
        b=mbiV1lKwjtGye0tkpuuqJI6UsDgmYtBPfRrBoX9Zjo4QAVANIANPO3Mw3Fimb3FVKm
         2kBi19R6mM0EEg1TCgLQjG4nYDk5c16pgaP49ryVyU+HqvYr5W5ACEbgbZWPd7tDxsWW
         olIE/EF6wBFxIj8CymCtKq17rEdPAdXOUzDV/ImBagv0j1mE4SZ7Rf/sWjm+wSLlXa47
         /hRqMzeKyHAgc1cWCW61ACsEMaNKGjqfFmhezXnUaYzQAcu/3uIPQBabRyNxwlmjXMwh
         59fcOVc1gc27qvwBErxnLMDcZla/iYuKVWICGM2JeXpxPCZYg/hZfW8oE/Zd3EtjQUVW
         iO9w==
X-Forwarded-Encrypted: i=1; AHgh+Rpfwq2RmL1C2dYM0RZshB0xnY4BplN1xMSPGc9a7YYTI8TuA1dgOO0l7l1mmf+bUi7xeAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6G6cOyvQDrMKWESzIGBXolgC/kSXFeZQrnae85G8oH5wAOVPE
	WvvwTt6c6S7/JlafHiPR/EYwzKtvOm09LGrYgzuyFL/6NmAKG8OAJYRBIMPN1wDJh+tFHXDyhfc
	luQ9Lmg==
X-Received: from plblg6.prod.google.com ([2002:a17:902:fb86:b0:2ce:fa1a:2684])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a68:b0:2c9:ff29:3f91
 with SMTP id d9443c01a7336-2cfa6a59f3bmr49807745ad.6.1784832462703; Thu, 23
 Jul 2026 11:47:42 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:47:42 -0700
In-Reply-To: <amAoijqis2Gn/K2Z@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-19-seanjc@google.com>
 <alc8Vi9yNIFR/yGE@yzhao56-desk.sh.intel.com> <al_BAjCNRQUvuX2c@google.com> <amAoijqis2Gn/K2Z@yzhao56-desk.sh.intel.com>
Message-ID: <amJhzgyQMVNVD1S3@google.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 22, 2026, Yan Zhao wrote:
> On Tue, Jul 21, 2026 at 11:57:06AM -0700, Sean Christopherson wrote:
> > > Asking this also because there is a .gmem_convert() for TDX huge pages [1].
> > > In [1], .gmem_convert() is invoked to emulate a to-shared conversion in
> > > kvm_gmem_punch_hole(). However, the per-gmem memory attribute for the range to
> > > convert may not be shared after the punch hole. Is it acceptable?
> > > (To me, the .gmem_convert() in [1] behaves more like .gmem_prezap()).
> > 
> > Ya, these concerns got raised by others.  pKVM on arm64 in particular wants to
> > hook reclaim but not conversion.  The plan is to keep the reclaim and end up with
> > this implementation for x86:
> > 
> > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> > 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> > 				kvm_pfn_t nr_pages, int max_order)
> > 	{
> > 		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
> > 	}
> > 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
> > 				bool to_private)
> > 	{
> > 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> > 		return 0;
> > 	}
> For TDX huge pages, if we want to trigger private huge page splitting before
> converting to shared, should we invoke the hooks like this?
> 
> __kvm_gmem_set_attributes(to shared)
> 	|->kvm_arch_gmem_make_shared
> 		|->kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> 
> But TDX needs kvm pointer, and splitting pages may fail.

Ya, but those are very solvable problems.  They just don't need to be addressed
today, because SNP is the only user of the conversion APIs.

> > 	#endif
> > 
> > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> > 	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> > 	{
> > 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> > 	}
> > 	#endif
> Is this kvm_arch_gmem_reclaim() invoked by kvm_gmem_free_folio(), and should TDX
> not define CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM?

Correct.

> As in [1], for TDX huge pages, you suggested pretending a to-shared conversion
> in kvm_gmem_punch_hole(). In that case, should we provide a new CONFIG_xxx to
> prevent it from being invoked by SNP?

No?  That code was purely for demonstration purpose, I there was zero intent to
ever land it.  The patch was tagged *** DO NOT MERGE *** for a reason :-)

> @@ -253,13 +294,18 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> 
>  	kvm_gmem_invalidate_begin(inode, start, end);
> 
> -	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> +	/*
> +	 * For demonstration purposes, pretend this is a private=>shared conversion.
> +	 */
> +	r = kvm_gmem_convert(inode, start, end, false);
> +	if (!r)
> +		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> 
>  	kvm_gmem_invalidate_end(inode, start, end);
> 
>  	filemap_invalidate_unlock(inode->i_mapping);
> 
> -	return 0;
> +	return r;
>  }
> [1] https://lore.kernel.org/all/20260129011517.3545883-44-seanjc@google.com/
> 
> Or would the following approach acceptable to you ? It renames .gmem_convert()
> to .gmem_prezap() and invokes it before each kvm_gmem_zap(), so TDX can hook it
> to perform page splitting before the actual zaps on private pages.
> Per my understanding, this op servers a different purpose from
> .gmem_make_private()/.gmem_make_shared() in this patch.

Isn't that just kvm_arch_gmem_invalidate_range()?  Which was added to fix the
SNP VMSA mess.  The only thing that's missing is graceful handling of failure.
