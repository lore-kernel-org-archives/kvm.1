Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB91AAE17
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777607482; cv=pass; b=PX0Q2Ja50SOyf3FMO7XR4Jjlv0FMQjUglZ8NJwu6hMO8UJRdlaUWosmCb3+z9pwcGEU07wWVH1MQNmXTT8Y0NZxRO+5zDPAHDJegHXEZcJvwtFSb4f3v4xsfOIbrLYO67ozXpCcjStfNQQ+IEXlRdeZYl24I5+D+Jtwp8oVmvqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777607482; c=relaxed/simple;
	bh=L41Qpt9S9WXakj/oOdWmq4Q89DqIK3kzbkrVAOLPElA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlV6/KPE7F16e/bbyrNpKJK/DK06ULxEwoJvjM9jRjZoNrkjkvi+QCRb79KL0earPf5jQHVegjlkqKNUlAVHK0JHYPF77U/v6qYPWlM82MoyEpWUxPGFNpZtrFuTtLYokMswdG6wkZsplQWYeVAgXDK9+80h8JY/0FHH3ZpGwjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPj7wEKS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bpu18I3B; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPj7wEKS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bpu18I3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777607480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fM37629V4k5fQbExohzRACiWrKux1WK9Bn1fac6dfo=;
	b=EPj7wEKSYBIBqSJVG5Il/IMhhjsUcTb2IB5qwuhJy0XdGsQhwvxEiTQr8SXM4PpdwSIqrd
	T2s9rU5D9HmChPymeHAF07jOYXVIpD5qDQsAhLVFJtgIn5gx5Q2DS/5kAHRRxHZEW3yJXT
	BiwE/bWoYTXB2qRmnxNCtV9c5yyXYsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Th5Qq2FAMke3jl5LDQskMw-1; Thu, 30 Apr 2026 23:51:18 -0400
X-MC-Unique: Th5Qq2FAMke3jl5LDQskMw-1
X-Mimecast-MFC-AGG-ID: Th5Qq2FAMke3jl5LDQskMw_1777607478
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso17765185e9.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 20:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777607477; cv=none;
        d=google.com; s=arc-20240605;
        b=HJdLZ1F/cjCYtuN1jQRar6j5Hu5yk6JcJA6cU8X4WnO968LG9ipckvegVfZCPHnLKB
         4/WL/axj6/M9Bt1YL+pY1EbFLtASrLRBRtv0ASh5mWLk5Q2UQ15iYk0WTF9KdWPXICNo
         9kZryn2b6dLGcQeperpgKJUkVfjXIgC7eFqGpMHsr67it+cBXMavDCcwHqNNvrx+BO9p
         pwocXH5lnSah74hDlIGBPOV9JpiXK1aXYZ9LKnd19hX642BW/4tZ6Kdh8bDFJdCemNjm
         99al80WIl/NiqtqKK6V63HrSGYO5NzEHryBo1xjX1bSD7BScHM9y2hzjUqoTHtjxgISo
         aW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8fM37629V4k5fQbExohzRACiWrKux1WK9Bn1fac6dfo=;
        fh=wmBf1dbj+fyn03B6R+FHCJsNOA3L2e2pKVFGQFuezUY=;
        b=ACkbmk7YUEwG6+OEWwhlVWNS4zx50BDDq0MP2HOAyjsOy2vrPHiX+KPbqi/6SUkNFF
         U1jQYht1hPPsRoaE29L3p6G7Yw63Ty0SePYImvPV7wKv3//0dbDJg6zovXTyZD3UaD/e
         ApOkK3m4LuhaHW1VKwiTs2/Qzz25bl0L2WpZQGNjBhS42FnAJU/trjbr1GMgKUEcZIhT
         Aeh/JwROLo0npU/BaOgyCy9dh/7Z4TBIwHkPxSoTzAfqJdkapCJnx8A7ZgOTNzv2XNPC
         r5Uy1c3c4xF/Q57jPbjzYBQomSgVat5r9npJZvWxqK7oeU+HGLXKIHm1BnN6Yl0ROVue
         eBtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777607477; x=1778212277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fM37629V4k5fQbExohzRACiWrKux1WK9Bn1fac6dfo=;
        b=Bpu18I3BlC/SKkqcX36tFwn29j6VFjWzsi40xIkWjCz0nlIq0sx4TjcbQtysmaseJm
         aRWUEHSi1+1Y11wmU7qsVayKNzyJ8KKI8dwiLVIfJ65kEp/tskOZYQkjZ82mPKPbIMvz
         7drCmkn3Br5nudQsn7+T5D7I8i+s8jfxtxynF/Hiu//qzhxST2dM9LzsKWCYEPYl8oy3
         NIFaHiUBxyn/r7lndHhrLj/b8eLr0B+A3+D/pRxXOVCAPSajU62GR/jp1jtap6Mrf4ru
         7M2xmOwoYEXDnTwlYZ0qtedUvnpx4gLH1ygRGCDSnPZhJPREONmGLrLiy6urpsIng4Or
         YOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777607477; x=1778212277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fM37629V4k5fQbExohzRACiWrKux1WK9Bn1fac6dfo=;
        b=BhwqYNA5yqKRSIi7gxm+Pj0cJZyREHb0l10MJpglreGACM+CUDOJZGmvMJQhh4ywJt
         0TfcKn7rIwG7z1wdOJff4+IWUfqhPI6j5VlsAmsVPl/2a9DZhO+fhfyvc19+dBfL5cZc
         rCQjxFWdrbpVTLaVhI/w4oZvOkPAfzoGOxMRmsP5ZKwzFkf9nTmR1jqMdRNgFb0cBglz
         SE5mg9/EwUb1n60FsLS7aH7fg6toVkIQNkvoQiNhn6y6R5RiopVAQwID4KzAaawKyHkq
         Xt0jo3vdv4pT+E+9dytwRjGnwfVrT3mOssX68kYsUEx0+Cff/bv7REZGVhMlBtx0pUfU
         OQCw==
X-Forwarded-Encrypted: i=1; AFNElJ+BsmzeZgihti/lEwFkJAokAYiIbbgP+OfgVlUxE4euNG0SbVxWyEMC5zxRXRXzoSeZCTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKE8chyB4XUkhfoymATTI6prFJGyDAcPtNG5POTRAAQSTTfr2
	KrEcGEvoAfv1EBfzhVp57v4qYyg7klAlxDICE1CQm84dXROE6uWsJrROwwetEcsn6Ja9gK40k13
	ZIJbfGIzLl+2o3mMU2ObgKZJjqCJ1dXdXwImFphvdVMgUl6vugqQfgjUIOtzbw3o1YkwyI5wsv/
	lHPQBlIylJuX23y0B7cy6d9XES79X2
X-Gm-Gg: AeBDietNE+KbAcjj+bDTr2k0V7cHCcrsuxUvOYXxbmQBH9c3nzClz63U2JJLc2x1PBZ
	7XrxwZY9zO82wvgaliHQbk3RCBvYUFZYwafA0upMKKDfszRlTnii9Spvo5nNgPGZMKdUCAidVO5
	KZrrCI2hp76rR4xdTOIfIReq6V2IiQEqORlEHHleDE5g7bmXb2jklTMcIHoseWoKwETUXGDNEPE
	AVvBvMQoohKk5TVslATqcKqzytNH4zQBrk+GgjkMQzyG2VZDGvnvRYFlCAZOlSyoOwvgzb7zrB1
	JJ2Al2Zw1B3wOyo=
X-Received: by 2002:a05:6000:1789:b0:439:ccd7:cdb6 with SMTP id ffacd0b85a97d-4493d02ad0amr9103386f8f.14.1777607477537;
        Thu, 30 Apr 2026 20:51:17 -0700 (PDT)
X-Received: by 2002:a05:6000:1789:b0:439:ccd7:cdb6 with SMTP id
 ffacd0b85a97d-4493d02ad0amr9103371f8f.14.1777607477213; Thu, 30 Apr 2026
 20:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-7-pbonzini@redhat.com>
 <afOd3ppLy_RhqaSy@google.com>
In-Reply-To: <afOd3ppLy_RhqaSy@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 1 May 2026 05:51:04 +0200
X-Gm-Features: AVHnY4L5Accw0WbVndBttegj6piTh54y6uL8XWqZkIaZWnLjhqwpIJfXKtnNEew
Message-ID: <CABgObfbSkX8QXhPcxZ4PfjqTQjLdWWdpn0pm1VBfVhpiTMy4wA@mail.gmail.com>
Subject: Re: [PATCH 06/28] KVM: x86/mmu: merge make_spte_{non,}executable
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 8:22=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> > As the logic will become more complicated with the introduction
> > of MBEC, at least write it only once.
> >
> > Tested-by: David Riley <d.riley@proxmox.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  arch/x86/kvm/mmu/spte.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> > index 85a0473809b0..e9dc0ae44274 100644
> > --- a/arch/x86/kvm/mmu/spte.c
> > +++ b/arch/x86/kvm/mmu/spte.c
> > @@ -317,14 +317,16 @@ static u64 modify_spte_protections(u64 spte, u64 =
set, u64 clear)
> >       return spte;
> >  }
> >
> > -static u64 make_spte_executable(u64 spte)
> > +static u64 make_spte_executable(u64 spte, u8 access)
>
> make_spte_executable() is a less-than-awesome name for the combined funct=
ionality.
> I read it as "Make an executable SPTE", but when called from make_huge_sp=
te() it's
> obviously not making an executable SPTE.
>
> What about something like this, either as fixup or on top? (completely un=
tested)

I'll keep my code but rename to change_spte_executable().

Paolo

