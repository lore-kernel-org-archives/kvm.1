Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDB364EB1
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941560; cv=pass; b=f8r/VDkK6JtPy6z3zQtIXAEGMmpXlNAFpOMYWmgmj9vyo73QW98xeVh6rfrEckMEEteLrSQ5ifEa0glNpNNsPw8leeWVahsbWKhDSiExrllIXiNubfpzJ/T8k9Mr1Plj4YvnOIsT70BYmZWq7Pphw52kXQ/di58Lf2Bu76oGCwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941560; c=relaxed/simple;
	bh=Yh2vF4TIAGag+raZttED/lbT/nnkLgvDu0weKA8pAqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cr+cIZBJYINJvYDJAlTgBXCcCxB1o5rK/7cssuIkhgt9jU7zpn4v9z+RnNNJUGGfJmYPnoV5jyuRTyAgms6eZFGNFC4VoBK9EB8REYq7pV4kZX/yu7RgWOgHs0E0tX9oWXDLpmp0NZDACndYN158hrixKPYzs9HpmGd5RRdwA1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUY6YrOQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnZxSl2I; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUY6YrOQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnZxSl2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780941558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8d2xpklGhwQZIXzXL6uTt/rbyfEnaEp9dTHG5HoHQ0=;
	b=AUY6YrOQ9plNq/CYRGbRoQJRYkCPVvA2/akADym9mecp+aeKLvwtw+Ry3h4rDKYS7BG1XC
	tsnSApEkjhrVZVzJmiGTO1BTgX0Osrwb2R978KntObSeKnp8n7TcRFLqrVGDPIXfCoNLPR
	d8kZC+Qz5T/fIpSBvXkCxGcqwqxMgx4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-wttLog98M7mvngxiMuBfRw-1; Mon, 08 Jun 2026 13:59:16 -0400
X-MC-Unique: wttLog98M7mvngxiMuBfRw-1
X-Mimecast-MFC-AGG-ID: wttLog98M7mvngxiMuBfRw_1780941555
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b37e1f48so38261895e9.0
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 10:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780941555; cv=none;
        d=google.com; s=arc-20240605;
        b=H/FDbsbp/YjSUBsn8sHttIgrk8jgIMjlLG8TL8GQyDugtLQWNBoeK6ut7siOPrAkrC
         +47Xts9zG7mZPrLrG8YjfkumOeTjSd1Ump1Wv4PIZX9VbpQY92teHDmGGRT2+5NSfdzM
         2r5R3m1FuEOpeyZTYGRNaalsBlGXIWo7OOONBiCOFA1fC0w+x1feCh1fhothm7nMt7Dt
         +YSY2jHP07Bz+6arRLrGS1E18e7vQbbBbkTGtwHu+Y/umybinJAEE+GVeNjiXoDxZzsA
         ItKW9LQUIex2mes36llLeJn/CBxQndxHg60zXzrUfs1JqEHX0RakZBKdLyhYpFsvcCVQ
         W3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B8d2xpklGhwQZIXzXL6uTt/rbyfEnaEp9dTHG5HoHQ0=;
        fh=cLDwK3rpTR93pTSX+LxJezZZRTacd/hozOni0mMxVwk=;
        b=cwWOSeuhyBoclBgiN1hFMgs0Nbu9ozJSi1Ryji3BdtAsNFTS6Ebzz+MVrQCWyqP94F
         0/qrXePd3KfbwD0EicAokgnNlihpTGGj6I0D/45cLP8nWgAKGFTV597tzy36ReT4bm/h
         OCBr5TBOUfHmlvX+hIeaheb3ro1/tOAAzcj2aTUoxCvDeiYVPUarFr0b+h1mtktXOV8/
         zCsbYJfZzkog6RbG6FqqPdZalyql8m3CJdYVxPWDhyIm8qHDGybNOIG+ZA/m5Fa60gwM
         I81u2Wl+88IJhh6MA/DwwFpbj765FwO70S2JY/X0vH6UJyGf+SDcAIG2r8NAfeKh/+Qt
         IIzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780941555; x=1781546355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8d2xpklGhwQZIXzXL6uTt/rbyfEnaEp9dTHG5HoHQ0=;
        b=YnZxSl2If3IairZCo5RwmZA0ERyuP5/oDA1FWmQLNRqHU7nK5c2RW9kT5bBLGER+CD
         ohmLEBOR5E84BaUiii7qAiFBG2YwK5y+x7yU+wg7PZu14+flVgfmgNqljsmdVehCepOA
         5JMF9fDnc+pinhWDeHPNeXx8nl/4PfwvUMeeUZsr4Sq+9hHNipmyirubiQjng99ZfFAQ
         iSzTDuysZd1z1F7WDKDj1Xidh0Em3U7biKnIBvJ3mHHDoChYjp8ijr3teyNH02+jTOx6
         mOVfqnBEdhmH7mzlTZJB02Qz0PnSF0DV+/ul9yo0FULtby3xS3qWdxMoqWvJd4PpMEMd
         xdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941555; x=1781546355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8d2xpklGhwQZIXzXL6uTt/rbyfEnaEp9dTHG5HoHQ0=;
        b=XkwPmnmNGWe+k5o0qkkE8nq459Vp4ovXDt24rbz75GwEPDyRDcp3eyJshkx10/LNAC
         1p08AAqjw7cKRvM3Poerwts3s3n5EWXDZBvSrmrCMU1hSSA3MCwayoXjE/zPw62aKSAQ
         e9bfhcnTA/XFyvx8/CMbeiWFVW9cNx6138SLl897npeNpSLp+8oCk/uMbXC3IwIU1PBy
         6+wFvFEDuff9FUZpQHxpu0mf+UyLnu20FkThZkBChopc7NjeXm8WcUey/yIoZehTT4HE
         b9vGUyEUIXYP7BAZmxaRqdVNU5aYF9UVAZ9uVZ+mZZP4ob9/EldhwCWy9s0rys0mx7dt
         RtMw==
X-Forwarded-Encrypted: i=1; AFNElJ80C/ekTLqQupZ7KoLZHXEAcQ2chYgPisqe53B15KTA74Z+KYZpFrzgRID5BVFg88b9tRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbD4bHW93IskA71Q9iSedWlfMsEuNw/e4wNuvP9jUtJZypBbV
	hu6PfoP5tac57BykazWZu+0pQAQb4+0r8uPHN4GB+KWkB9KmlJISJ5zsLSxHOuKJhUbge7Q/Mxg
	8Zpne9VNXcS+M8lQF9tbnYW9dbbY1INp7rgqAxz4hmejqeifh0MNQ61XwftA/be0PYqZ9eOtEKd
	RrCs6DnoY2uSf8TJbT3v/OIoYWkzNj
X-Gm-Gg: Acq92OGsYW9Rywz+BsDnAaCpKCBR4NY8LPt6Pru8LzZFUGYQWAQOBMuxBMKt/oNbdNL
	0wCf9mD3QyK9eIfqzCEUFBJ+q9l0PcybnfuuFl2pdMyG5phTHN0KZ6gsFgD9JlpcarZBZCNJLiI
	Rs+j2HyOLZC6tQFz8qRL4CcSHRc/LqoCjBjNyw7Xai3AqZN5yn17wrVCVqXt1XXKJAhokrtT5GL
	ciSURXCbS+5Lbe+fbSAS/FspsEiJxsq4dEdZPTfsKVjWTmVWpH1IJPCiCCz2vtz7ZXHI/qTQM7g
	bVkoB2sG6gB2FkeZ
X-Received: by 2002:a05:600c:1908:b0:490:b5d0:598f with SMTP id 5b1f17b1804b1-490c25b5f6cmr285228205e9.13.1780941555096;
        Mon, 08 Jun 2026 10:59:15 -0700 (PDT)
X-Received: by 2002:a05:600c:1908:b0:490:b5d0:598f with SMTP id
 5b1f17b1804b1-490c25b5f6cmr285227865e9.13.1780941554714; Mon, 08 Jun 2026
 10:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608144252.351443-1-joro@8bytes.org> <20260608144252.351443-36-joro@8bytes.org>
 <e7eb0dba-790a-4644-9895-5c9a7420d7fe@redhat.com> <aib8n5lO6HKbLC4Y@8bytes.org>
In-Reply-To: <aib8n5lO6HKbLC4Y@8bytes.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jun 2026 19:58:43 +0200
X-Gm-Features: AVVi8CcaSI98hh9wFoB_n6cKHV5EHNPF6kPS5m5gs3YdhiTjEhtRfK4vGBfAwzg
Message-ID: <CABgObfbUsDeStnZF-7oyR-W-Bvd4qTMoeUwGizgn10UTdKtZ2A@mail.gmail.com>
Subject: Re: [PATCH 35/60] kvm: Add VCPU plane-scheduling state and helpers
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Sean Christopherson <seanjc@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, ashish.kalra@amd.com, 
	michael.roth@amd.com, nsaenz@amazon.com, anelkz@amazon.de, 
	James.Bottomley@hansenpartnership.com, Melody Wang <huibo.wang@amd.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, x86@kernel.org, 
	coconut-svsm@lists.linux.dev, joerg.roedel@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 7:52=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.or=
g> wrote:
> On Mon, Jun 08, 2026 at 06:47:54PM +0200, Paolo Bonzini wrote:
> > On 6/8/26 16:42, J=C3=B6rg R=C3=B6del wrote:
> > > The algorithm is to always run the lowest runnable plane. Plane
> > > switches are done by stopping the current plane and setting another
> > > runnable.
> >
> > This was left arbitrary in my version because for example Hyper-V VTLs =
use
> > highest-runnable instead.  It also made pure userspace scheduling possi=
ble,
> > though that may not be very important in the grand scheme of things.
>
> IIRC what Hyper-V does is always the run the highest-privileged runnable =
level,
> no?  Maybe in their numbering level 0 has the least privileges?

Yes, exactly.

> Anyway, I am happy to make changes here, also based on input from the VSM=
 side.

Related to this, let me know if you want me to pick up again the
common part, especially with Sashiko being hard at work on it.

> > Did you drop it because it didn't work, or just for simplicity?
>
> The user-space scheduling worked, my 6.17 planes implementation used it. =
But
> there are some problems with it going forward, because TDX Partitioning (=
and
> likely ARM CCA Planes as well) do not allow arbitrary switches forced by =
the
> hypervisor. All they allow is a forced switch to the highest privileged p=
lane,
> the SVSM on SNP will force the same constraints by making lower-privilege=
 VMSAs
> not-runnable when it executes.

The idea of the userspace scheduling was that you're not forced to use
it - the kernel can always choose to override it if it's using an
accelerated implementation of planes (and of plane switching). But it
also leaves some leeway to different accelerated implementations, each
of which can pick their own algorithm.

Conceptually I'd rather keep the possibility of userspace scheduling.
But maybe it doesn't add much.

Paolo

> So exposing an interface for user-space to chose which plane to run does =
seem
> to gain some weird, platform dependent semantics going forward. TDX and C=
CA
> also require in-kernel switching as they can switch planes without a VMEX=
IT, so
> I decided to have it from the start.
>
>
> -Joerg
>

