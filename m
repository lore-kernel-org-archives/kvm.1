Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728E33122D
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652157; cv=none; b=FT3lSNTcCB0zUXN07PwbVzYypLT5p5jPmPpueBj2vIoMTZFwrCc7q2dXe4bRZy2CwragLm9i7+fTPFociWk+17m3T/aXubAYApbH1msJL8kk8MaOSB2dwu2TxX4okLl61Vikfn3oJ9bzBMiAYicefPMs4PIrhLR5qePCd38PlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652157; c=relaxed/simple;
	bh=3uwteEKYO5vieCC+VRhF4smHwDUwODJHHCgKU86UnWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HDId8Y+THGTKi8WKvm7K0jmnxc+fRqmGBS+GUgIdlfjj/cLFPnjT2klPW/L/sf5vZjJNFDmWPVeTyKmNzz+y5UZf/Gd5eUYzIFbHxVsEZf1t9eItdlZjUyedwU1vqWELGnOXa3nalfrRT2A2IRvIqotlbKFGlgf+rwCK2dCbsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nd6jd2Xw; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nd6jd2Xw"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848568a6f62so19360618b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784652155; x=1785256955; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YXDUNW2ET38mmLYW+Ago6NJJGrFZUFYF3WSHFqnsOoI=;
        b=nd6jd2Xw1gFWDewW8bq4t6XL3MN8XpInsWFA2Y4fvtubEmoLodUtMVbIXbwgvzPBhk
         dmoch6Mqq4KaBUPaYbnMePZbnOmDZGcW215oheeaFY71wt806D6PktCxR7mTm0aG6QFV
         bZVcRQ9/35+5b2+JyAO1KK7b4p/mjYoBivB0rMc3AEkCbP+6/G0+BRGx3/LYe4HqyPPx
         aFD7vTC7PEJnuEJyxdaEEzAFk0i4cJG5HmULGdqJbJc6n1sWuvC/9TujALTGSVnzEfJv
         GNZAia+JNH1B0EhmnvoP2tmd3irXL4hQh8heQj0uRc08enBjGx32iw3Oe7JzobqT03VX
         wLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652155; x=1785256955;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXDUNW2ET38mmLYW+Ago6NJJGrFZUFYF3WSHFqnsOoI=;
        b=ffYu68dIGvDVaKp/4zdcoWuB0rh9Iptd9WN79N+lBVsn1/ptBiS2KeWKm8MfE8ENe9
         4ninyrSu+aJtqJT5Z9L8QHqdESAmTDUt5/DQU4+W4feXqRGQihiOB3IZFAnzzF4KNkUd
         ulfp7Dza4r54C9ftSxOdibjbQ2KsnhToDOYfhoEBZjyII01+jZ3Bfa9ibQquE+pM7uu1
         rZ5Z/RQi2nD8LP3rCDvxwp29pX5XtvOIhdjG4zmIl4MD50AzscKycO94AkgaF7DQjGUJ
         QIE2UH0TiW3EmeQRDet5sT1yWZuf75mdNBYP59wVnvTdc6SRsAv61DKBdrKbbMPxAW9s
         0uKA==
X-Forwarded-Encrypted: i=1; AHgh+Roh3h3lgkkd0SXhJ1vwbIi9M5MBY9IR88hKV7eoQhXMl38O1V/Ad0BtJQIuQJ9l4sliD08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYY/uCp8YXbWFXuD766I9IJhlirZw8plcl+pSJPt8gHPK/Op02
	rOK6w7OzFJv9OHFnMhabkx5KACcaoLsBsPemA5KViFmk95nQWU5IsAWdDHHGjTN8bpoJwiEIVk2
	80grN0g==
X-Received: from pfoc3.prod.google.com ([2002:aa7:8803:0:b0:847:84b8:2dcf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1c:b0:848:30fe:da34
 with SMTP id d2e1a72fcca58-84c294d1feemr19239603b3a.45.1784652154580; Tue, 21
 Jul 2026 09:42:34 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:42:33 -0700
In-Reply-To: <56ff8019-f30c-4fb9-a3b9-b81dcb98eb96@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-2-seanjc@google.com>
 <56ff8019-f30c-4fb9-a3b9-b81dcb98eb96@intel.com>
Message-ID: <al-heRLiosHP1q41@google.com>
Subject: Re: [PATCH v5 1/7] KVM: guest_memfd: Plumb the number of pages and
 max order into .invalidate()
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 16, 2026, Xiaoyao Li wrote:
> On 7/15/2026 7:10 AM, Sean Christopherson wrote:
> > Plumb the number of pages to "invalidate", i.e. reclaim, along with the max
> > order with which the pages can be mapped.  This will allow x86 to combine
> > its vendor-specific implementations for conversion and reclaim, a.k.a.
> > preparation and invalidation, into a single hook.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/x86.c       | 4 ++--
> >   include/linux/kvm_host.h | 2 +-
> >   virt/kvm/guest_memfd.c   | 7 ++-----
> >   3 files changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 1f5dc685f049..a2cbf6fae118 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -10627,9 +10627,9 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
> >   #endif
> >   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> > +void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> 
> why use 'kvm_pfn_t' as the type for nr_pages instead of 'unsigned long'?
> 
> (I guess just because you kept the original type for @end)

Because the number of pages, i.e. number of PFNs, need to be in the same "domain"
as the staring PFN (and KVM's MMU needs to treat PFNs as u64s).
