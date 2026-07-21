Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5CF471264
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660229; cv=none; b=toEVZ5lau5KttJCI8JPcLSZOpeJgVNXhhCl0Dqcq/vHQm7MO/wNm8oAx3rHf1yolCxy+mryoSdn0BD5F6vh1OU/YTWEAyeIBW4m1K5A/ka+L4c3lV1LPnlW5aFPEPfU9bCzhovZvKMp23qDYlpAUhZIS4o9iGq6tFoPouoiNHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660229; c=relaxed/simple;
	bh=OJXd9Iee4LpN6FVzhAnGu2TU1aytgAAsvg1ynQEW/YI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=icQ8J62Iq4yweV4m4lq9SgS3hwxzlE42W0N7FBAHSI0fuLNm0hDMQUqql/ohPW9WJE2mVt4LKE9b5Yw840t1w2uR58XOhra5Vy1mh/jKPStPVhweZE4pwHvRQSujh4QjGeE7FjR+wZPneWS7r9R7IQvz1j3sO1MHwjupFaoJ4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABacr3Lf; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABacr3Lf"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so15912105ad.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784660227; x=1785265027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lW/ys+cCiLJkAHudNKdhvqn7cWvd22ADj9fa7XDBqQM=;
        b=ABacr3Lfh6iyQYkKTqG55Evd6JDCZtYQ7wVZDt20wHpRU8hNi29PKM7gCwj/L3vqi0
         t7Yy0o+hKTD7vYtcuXDHf3Kc5mBQLdcCZF5maLGSOEXy4OJ2idlnt9ABGU8NH78WXXgA
         kMt8kFJPqu5nW2O//WphrwGESSjtiwNGG6hbFI58YLkbKzHg/dBWFL5rtMwAZpQZ6j6j
         OkIwUrTN7I0f7KkSq2JBiP4/a/2BWkD3xAK6/1+fNypTP8c/O+13B2h8nut1B2AeBlXH
         /Oy3fo1JE9P1sSQ0KDUfT7XekGeyuOXEi/ehoiaEEXi3JF5noCyp8kYZlWCZHple/80Z
         Nh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784660227; x=1785265027;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lW/ys+cCiLJkAHudNKdhvqn7cWvd22ADj9fa7XDBqQM=;
        b=lCjhgy3gFe0VTVDjlIHnVx6PckzzFI7uLGvZD4tz2ZBIASOvtplMf14puMXpel3sEx
         /p2Td/ZjkaBRQaN66Yg8nuakYc3RxSHH2IdOviuHCrOc+TgeBOcETBGljA+KmaQiyvd+
         DN4xOkag8J6NNrfdir/bsg3J7jIpIj+j1KS4pMtull8eQZF+HMCX8Vm8tu6PEaWOc0Hx
         pttdDjoogJQ+K6djabXncPk6aS11WEwIHkMTiX4n1FhbdotK4v7Z6QLymvSP/XNl9Aee
         JCqZ+EWHVi93qF+e95dC2d+Ia7lLgz5HMRL5o1H5m5fJeVorz0WGP68Q/9p5eXnjeuqC
         dO9w==
X-Forwarded-Encrypted: i=1; AHgh+Rr0yWlmu1HchigStF2hE6EhoZpao02pKBuRD2ZxOrwMrOBLj+fWaVhiYKXJeZjsehueY7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4V2UAXYBuDkN9iJ1L4CQmC/AYmefntJfmRA/LsqCsx+5rqH8O
	wJrRm6f+GnsURDk+BTPqKQV1R0ahVLd3URUiwndeMiFpvuFNH7cWVTQcRvXfmUa5GdF5xzZPhTJ
	fQVKN5w==
X-Received: from plpe11.prod.google.com ([2002:a17:903:3c2b:b0:2cf:7342:ecfb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2acc:b0:2cf:7ffb:82aa
 with SMTP id d9443c01a7336-2cf7ffb8d74mr54461435ad.45.1784660227185; Tue, 21
 Jul 2026 11:57:07 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:57:06 -0700
In-Reply-To: <alc8Vi9yNIFR/yGE@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-19-seanjc@google.com>
 <alc8Vi9yNIFR/yGE@yzhao56-desk.sh.intel.com>
Message-ID: <al_BAjCNRQUvuX2c@google.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 15, 2026, Yan Zhao wrote:
> > @@ -802,7 +801,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  		folio_mark_uptodate(folio);
> >  	}
> >  
> > -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> > +	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> What puzzles me is that kvm_gmem_get_pfn() can be invoked to fault in pages for
> gmem-only slots in normal VMs, where kvm_arch_has_private_mem() == false.
> 
> Would it be odd to invoke .gmem_convert() with to_private being true in such
> VMs? Or do you plan to add something similar to the following in the future?
>         if (kvm_gmem_is_private_mem(inode, index))
> 	     r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> 	else
> 	     r = kvm_gmem_make_shared(kvm, slot, gfn, folio);
> 
> Otherwise, would it look asymmetric with just:
>         if (kvm_gmem_is_private_mem(inode, index))
> 	     r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> in kvm_gmem_get_pfn()?

Heh, I should have read this sooner.  With help from Xiaoyao and Ackerley, I
eventually got to the same place.

https://lore.kernel.org/all/al-aDRTbDOPT1UbM@google.com

> Asking this also because there is a .gmem_convert() for TDX huge pages [1].
> In [1], .gmem_convert() is invoked to emulate a to-shared conversion in
> kvm_gmem_punch_hole(). However, the per-gmem memory attribute for the range to
> convert may not be shared after the punch hole. Is it acceptable?
> (To me, the .gmem_convert() in [1] behaves more like .gmem_prezap()).

Ya, these concerns got raised by others.  pKVM on arm64 in particular wants to
hook reclaim but not conversion.  The plan is to keep the reclaim and end up with
this implementation for x86:

	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
				kvm_pfn_t nr_pages, int max_order)
	{
		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
	}
	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
				bool to_private)
	{
		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
		return 0;
	}
	#endif

	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
	{
		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
	}
	#endif
