Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651F296BCF
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540116; cv=none; b=Mzi+eHvaBNHS6M7A5e5EQ7avAQgxk6YS0jKui/Thxgt+38GFFvxX9C27oD10zpW2MHzgzljDK2kmIoRKG2Z+GQbyO/1B9mimMHs4J6DiwjjjDx1v1M+p+6xexwwm6cDOIcdnbuXk6gRoIsCBIh/RUrhXMAmc+4RUOQHqDQoWro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540116; c=relaxed/simple;
	bh=Ghlr+avBEixSaVhL6xV8udcrvOQwEYxFq5oqvOlsQTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mIfOWN5UdTyhRC/m0TrIIFQsHeRG1wvlVJiAXoI8vq0+oand9dAjJjhCzDYussOFucTBm8Mr5sNoD7zZEbuQL8bjQErY3a8MO0q7mx83N3f/cv8s1TCtwzBCLgU9e3JiAz+bNxMSK9+64FOHMeT6EpiaFfDxvCBKFoz9z8rZ64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qil1fVDq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0TKygWB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qil1fVDq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0TKygWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783540114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ghlr+avBEixSaVhL6xV8udcrvOQwEYxFq5oqvOlsQTk=;
	b=Qil1fVDqn43Ninn+uIMJmwbOh7YufLT2gv5rcOrs7VLk+s+Tx8atG+DGG1Kzxn3t/WIRHC
	8M2Sad8wHu/K6sl+OSPfTFjVgbK0TCOW9NOPlsHiaVZWbTO/dHpUw2GWufPj8FknGBdrzT
	1fEXwduJRBTS4waVksnZ3MtgFKslpZE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-WPgHNsPqM8aDVI8GVSbpwA-1; Wed, 08 Jul 2026 15:48:33 -0400
X-MC-Unique: WPgHNsPqM8aDVI8GVSbpwA-1
X-Mimecast-MFC-AGG-ID: WPgHNsPqM8aDVI8GVSbpwA_1783540112
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6983e9c028dso77081a12.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783540112; x=1784144912; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ghlr+avBEixSaVhL6xV8udcrvOQwEYxFq5oqvOlsQTk=;
        b=W0TKygWBt1EIgkAxTf5kykT67WuZMD8eykar0aEOteenFhu2ZjXRKqB8VHUdYXbEdn
         /imhnibGLOQPT5vuFWnYnp/HGDpRrh37QasmkfFG0Ejdnb67tCDrflneGtsxp3cPbrKL
         o/3uY2G3AKJ33Ip2I1rALOs6U8uxBcOW2quZPcMHUy6CZB5otOGcoIlkRSCn3G0S/Odw
         k+/Jjn6QFMyIKvQnb4tKjIh2j9SSllhxbndnsQlLfx2hgerJmChxMCeCWggSWk48m7XH
         dlFe4IE8SRDJhP+fwqCiFFs9EjvMfa1tooS/2xYurJiWx2vdo3twzO58WFnFzdaUaumr
         BeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540112; x=1784144912;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ghlr+avBEixSaVhL6xV8udcrvOQwEYxFq5oqvOlsQTk=;
        b=fBIxuyc53r5TO/GJ0dxspneM/I15mpggMmC0YSM8oAlxA1RfYzQ+sDk/DLu2rb9Djy
         qsAbNQ7+yCjB0fEUYWvW++TEX9J/3/hn/TRrlFDVVhcYSagYjbfW/ne05k8ibIjPDHfm
         tQLNU6TocwvMd97vKWOKkTIPZuUHbfikKbftEaQboq+i35pAAz4dsQVAWtegvSjZ6kVj
         tA/F4S9h5W6VDtUGW2HJFWNJR1Wfux4UWlYtjrHhv4JZDcvtRlQaBX9sH4zRPoCeqH+Y
         gYj507QS/Ucmnq4lsFIL4Xm/AnIgLpXSaaNdZqjm6WwVR2u8L5vb0tMFhY+bqpcecPn6
         q09A==
X-Forwarded-Encrypted: i=1; AHgh+RqEIB4izmFn9lfxa0IFyfOvb3VBLUqgpKbaJF7yQGEYFG+uSz03R/9rfTSvMHPsGO3+bxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSR/QAZFXzL5Ej15XfOft7N8F/1MxSmwW3Z6bs3vWarD/WzTbF
	33vcv/nyEkuqLIwCIFBvzXW7OmH28dN3yOBO4WpOCtcy6eUGZ3Xs+on3SV/PH8/QZydxOPZ+anz
	+4a1CAs8EbA9rE77LvZn2wKm3nqVoKLSbhKPz4gISGIty4EHD7K1zC/TQLBl4L0UZ
X-Gm-Gg: AfdE7ckGeKzceZXdGSHVR1hH3bqvrlKKd9Ke6inunYyaZ44MucUfo521BBQl5h/6c1I
	w3IGGvUY9YwBqzdrdCLO76W2jYm+AoA+rezIWvkrDQF6UuoGhkHJ2I5TBthSwxCT+I5RLgsIa78
	o1KSLsfr6pMb2kj5hXKKwz+Q0Gogp1FO8osMBOihLnja65Wy4Ff1f1934EXbDofLE53BlGHILmN
	iayzK0/p2QrLsKHOsM3cWBTwuXn7YWDaIIXRsJNJk+54QAu5hZh52UA4GRqjvhij8/KJwpZDI35
	AoDEgeORbx0m3ok1BkhhZQIAG2JEGUr1A928gBckRK1m2C/4MNzdXn1RwHOhZAzsEKypv0nwdFB
	zq2Ox0vwlcS8BpOnb+UWEcKNopduf6iayNRlniaWoboYWJ6ncOTTS7bLxJu+zJ4I=
X-Received: by 2002:a05:6402:3788:b0:698:3ce6:767f with SMTP id 4fb4d7f45d1cf-69ab445dd6amr1730454a12.12.1783540112164;
        Wed, 08 Jul 2026 12:48:32 -0700 (PDT)
X-Received: by 2002:a05:6402:3788:b0:698:3ce6:767f with SMTP id 4fb4d7f45d1cf-69ab445dd6amr1730448a12.12.1783540111797;
        Wed, 08 Jul 2026 12:48:31 -0700 (PDT)
Received: from ?IPv6:2a01:41e1:62a8:c300:7322:3fab:8db6:d28c? ([2a01:41e1:62a8:c300:7322:3fab:8db6:d28c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cf68f5sm8795151a12.13.2026.07.08.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 12:48:31 -0700 (PDT)
Message-ID: <8b35057f72cd281637cf9d4bcbe1d0d753a3710e.camel@redhat.com>
Subject: Re: [PATCH 0/4] KVM: x86: Document and enforce APIC base memory hole
From: Tim Wiederhake <twiederh@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>,  "H. Peter Anvin"	 <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Paolo Bonzini <pbonzini@redhat.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	x86@kernel.org
Date: Wed, 08 Jul 2026 21:48:30 +0200
In-Reply-To: <ak5TojZfR04SWWd-@google.com>
References: <20260706092021.3625908-2-twiederh@redhat.com>
	 <akwrncCjosItvAeO@google.com>
	 <bceedaf195adf713db70a1dba743055fe4f20bc0.camel@redhat.com>
	 <ak5TojZfR04SWWd-@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 06:41 -0700, Sean Christopherson wrote:
> On Wed, Jul 08, 2026, Tim Wiederhake wrote:
> > On Mon, 2026-07-06 at 15:26 -0700, Sean Christopherson wrote:
> > > On Mon, Jul 06, 2026, Tim Wiederhake wrote:
> > > > When an in-kernel irqchip is enabled on x86, KVM installs a
> > > > private
> > > > memory slot at the default APIC base address (0xfee00000)
> > > > during
> > > > vcpu
> > > > creation.=C2=A0 If user space has already mapped a memory region
> > > > covering
> > > > that address, vcpu creation fails with -EEXIST.=C2=A0 The same
> > > > happens
> > > > in
> > > > reverse: mapping memory over the APIC base after vcpu creation
> > > > also
> > > > fails with -EEXIST.
> > > >=20
> > > > None of this is documented, and the error is reported far from
> > > > where
> > > > the actual conflict is introduced.=C2=A0 A VMM developer hitting
> > > > this
> > > > has
> > > > to trace through KVM internals to understand what went wrong.
> > > >=20
> > > > This series documents the two undocumented constraints (irqchip
> > > > before
> > > > vcpu, APIC base memory hole) and adds early checks so the error
> > > > is
> > > > reported at the ioctl that actually violates the constraint.
> > > >=20
> > > > Patches 1-2 are documentation only.=C2=A0 Patches 3-4 add early
> > > > validation
> > > > that turns a confusing -EEXIST at vcpu creation into an
> > > > explicit
> > > > error
> > > > at the point where the conflict is introduced.
> > >=20
> > > I'm 100% in favor of documenting the behavior, but I'm not
> > > exactly
> > > excited about
> > > the enforcement.=C2=A0 It's not needed for KVM's safety, and while I
> > > appreciate that
> > > such a goof would be somewhat annoying to debug, I have a hard
> > > time
> > > believing it's
> > > a common failure.=C2=A0 I.e. I'm not convinced carrying the code is
> > > worth
> > > the marginal
> > > benefits it provides.
> >=20
> > FWIW, I did run into this exact issue myself and debugging it was
>=20
> What were you doing (or trying to do?) when you ran afoul of this?=C2=A0 =
I
> ask because
> maybe there's a way to help developers without impacting KVM's uABI.
>=20

Experimenting, mostly with pmode code. For simplicity, I use a single
memory slot at 0x0. Due to an off-by-one error, I gave the VM only 2 GB
instead of 4 GB as intended. When I fixed that, suddenly vcpu creation
failed.

> > indeed quite a ride. The EEXIST from vcpu creation led me
> > completely
> > astray and I was very close to just giving up. If I had, I wouldn't
> > have written this patch, and the failure would be perceived as even
> > less common.
> >=20
> > I don't mind dropping patches 3 and 4 (the actual "enforcement"
> > patches) for v2, the documentation is more important in my opinion.
> > Still, if there is interest, I'd be more than happy to rework these
> > patches for eventual inclusion.
> >=20
> > Thanks for the review,
> > Tim
> >=20

