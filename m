Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0EE3C9EED
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109101; cv=none; b=oq3ydl9MoiLLqtkrGRvtv8GECjhFzb8Y0x2blvHIMrcSz4c2tN1OWTbWNE2UXBWnZi1XaemDsChv4t4zEdxAussPEzUJUwbvZYStp2uTe7otN5fXNx00O00w5uyh1U6DKfF/8c/CEDIfKAYqNnzb607ZfB8zr7BjJ4+vsBlyWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109101; c=relaxed/simple;
	bh=vgpOVl54xSLawGRRiTv+PQzU838/Ayz4EuHFe94C2qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6clpQEdh90SOY5JoW3/914plnQyF2NOH4Cx5hEH6QTOjVpgvCCUGu7y+yqoavmg719IwV/vL8p0MDHiM9urqD+JFnZFSf/vVzO3kshw3BxMJ4vQFPptxLydj2Pml/OPTj58fp4jGOVdfYBehmY3eiu9xkNo0cQujIs2LM/o++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b7xctS5o; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b7xctS5o"
X-Forwarded-Encrypted: i=1; AHgh+RoPbEsxD/YTWdggnl/SkwYujB4Pr9hIgnW9gN7ZIThSLXTlrYVPPXDjM0sq8jA3zcpr1AQ=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784109096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jv37YEa+kZ47/e/5gR27j2l2phzpCKy/yX2qgbYoqAQ=;
	b=b7xctS5okCASfsXjURKN2UBdvfYIU1UMbD4QSS8wzvetMvV/eSU/u5TJYVrVhbhPLMCnsZ
	9ezgm9EpgYVpxqD06il9zCv3Cdj5B3wyeTvynMReQPcygVoMLZi/fLTLW+H9THD6gqnzH2
	ituXPSz0gIjVYyAl/1h/HoX78J26LEM=
X-Gm-Message-State: AOJu0YxVsH3smPerlW9FNYApMZIeeuufuJ3GVvCboJh+7ljyXTyMmI+h
	VSjmznOr3xkqqaJ9jyEsHA16NRv7JdxnKRrWj7cd6PzaOxJ1Y36cbqGnmyQugC6LtGy1dbgjUSd
	XjuYONFIO6vIUN4o0nZbYakKkUUkExjZ7P8wezKhp
X-Received: by 2002:a05:622a:1b1e:b0:516:d570:82c0 with SMTP id
 d75a77b69052e-51d7bdcdd78mr24766241cf.15.1784109078558; Wed, 15 Jul 2026
 02:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-7-seanjc@google.com>
 <CAEvNRgG1Jm7k1F1H9TK3ACvsbHYBzoNEohvii_N0_da_ForTRw@mail.gmail.com> <albQErGisdVyHoQL@google.com>
In-Reply-To: <albQErGisdVyHoQL@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 15 Jul 2026 10:50:41 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzgcg6WHw5=Sap_9wp1dR=0n47VQSfxVCkJWr1HNBQfKQ@mail.gmail.com>
X-Gm-Features: AUfX_mx5vZ9VWVxHsb37mY_3lcN8WF7InyDJ92r4yyNYF-dWvfSVR43rXARgrEU
Message-ID: <CA+EHjTzgcg6WHw5=Sap_9wp1dR=0n47VQSfxVCkJWr1HNBQfKQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] KVM: x86: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wed, 15 Jul 2026 at 01:11, Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jul 14, 2026, Ackerley Tng wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> > >  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> > >  void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> > >  {
> > > -   kvm_x86_call(gmem_invalidate)(pfn, pfn + nr_pages);
> > > +   WARN_ON_ONCE(kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false));
> >
> > This setup means later pKVM would have to define a .gmem_convert but
> > actually only use it for reclaim, which seems kind of an odd
> > definition. (We can fix this later.)
>
> No, pKVM (on arm64) would just implement kvm_arch_gmem_reclaim(), and then do
> whatever it wants under the hood.

Right. pKVM would just select HAVE_KVM_ARCH_GMEM_RECLAIM and implement
kvm_arch_gmem_reclaim() to scrub; the reclaim and convert hooks have
independent Kconfigs.

Thank you Ackerley for checking, and thank you all for the respin.

Cheers,
/fuad
