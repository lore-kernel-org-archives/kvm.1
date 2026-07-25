Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E91A76BB
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784986367; cv=pass; b=f8RaU1I+6haL9ASLB+hermNvOOasdECcFhtSj3nRtUhQdRe/T+1KwzXhLFoaUmttn5Tn+qaEyGjtpE+PTv6AAWA0kkUW8LkjDd9rTWrL2ux2vycMtPkGMqQ/mUDZe/17fWUJOoC+RMPy0ybo5Ewelb3sXXJNmazHMlU3+vOWAzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784986367; c=relaxed/simple;
	bh=MAl6tuiHkDCC+O8A/XXwRolFrH2Z5JBaVlb0tT4muWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ST9ay9SDLx7Re+BJfeviFhyIjZHrdD+IR7U2RgwFiXt8fszkSfSf2Mb1bP7m34r5wyWAhWWYWuruTegxAsIfWasrdWzxuFmaetKCGQo+vgU3p3zuNNrx3MYiogjcI9eH2oTBhLc9LruFZ01S1/FxHZ2ajkqgbwDhhHEEc9jIEG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuCa/P9B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENkNPc8k; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuCa/P9B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENkNPc8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784986364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojCywNXwjuZV9F+KXvxIymh/QU/GqbkUx+RZi0hm3zo=;
	b=NuCa/P9B7qmzW8C71Ft+7fbGNfkMgEK0Z4s1WnMeC5LX/gju6wp4rVla9FkprsTLy3YrzI
	9ObxXs3NKuPFV7GSLxDa+fCY0Bb41JEQTmQlFAqWetwZxWJdnwmklSb/nF7i/+a+rH/RVE
	ZFUbo42rqBN8Fj14EfIIriCz3Th4pyA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-l1z4x45fPjq788uw4D-_yA-1; Sat, 25 Jul 2026 09:32:37 -0400
X-MC-Unique: l1z4x45fPjq788uw4D-_yA-1
X-Mimecast-MFC-AGG-ID: l1z4x45fPjq788uw4D-_yA_1784986356
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f8158485eso1062643f8f.3
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 06:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784986356; cv=none;
        d=google.com; s=arc-20260327;
        b=Q7YTcwb6xK/dvQWv5vwMC5mR4hk9P8elCBjW33xk4ilHimbmtpqQR0RMPnnopw+6sa
         JNpvMT97oGlxdWDOVkrXWzA7I531bH4RfQq3S98BwWYzVvCCvS4ipEZ6DyFFv1Rn/48m
         YKbDG/YRrrdYA7eochEQbtQwR42PYGJzLGiirAA2ROkHGQFIB+o5LaC3dxJ1sv+pogLx
         sz0c7SQxd3kx8dEH9IwdQCA+QEdSXkFdmQQVJARXKhL4sNkIw9j6DSx6vlKswUAyUUyb
         GkxmMqI40SRip5RpH9iETCNxijullcRzSsc8MtMqk/N0/XAOrLmc12tNC5i69fl2hFfw
         g8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ojCywNXwjuZV9F+KXvxIymh/QU/GqbkUx+RZi0hm3zo=;
        fh=DYzPQFtxtJDx6fOcdIY97tZk4N3NKBYpEC0lvvcPHyU=;
        b=c2pjIbAvJh8hNp5OCHnBUsQQBJigR7/aX4YQREAUV0Yo1GKvEwhMlPLfscDPgtxWSi
         qBlPZ6vVZFzSW+nLDaFu55e1iIbvWvEM/mYs/+KTeq/mS15REchWQk9uJ8LqLaRkWWii
         eW2GjBYBaXCPik4OqME/roQOf8fvgojKNvKGq51zvcTjhbkUk7ZrOCHloRCHpgQ1Q4Oa
         CfjrTy7a7Zxanr4jnZdV5VyfWlXwU92T9T++SLhzPW6BPDfDDSitcZotsl94hYNibvrk
         okhR6SbYTbUNr8Vf8u1kdUdywx63yXFbg2YpMgbNoBI5N5bt3gmlOdKc9oPicSquU2oJ
         KxVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784986356; x=1785591156; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ojCywNXwjuZV9F+KXvxIymh/QU/GqbkUx+RZi0hm3zo=;
        b=ENkNPc8k5Sbjj/VdNQsTIFZUtKPFMkCIKTTEC7VpgkxYj+hrVEhaBPdUoWgaOzq00r
         acR6b0rrUXTEGco6/wkFQ/9p+7murtu2KGw7IAQK7DtbK2n5BzO8W0x4skabLNlL8+Ax
         znP0RFKNGF1GyObF9bONQISoEng8pIGvdh3dWRY2UEuFQbceXQ1AOkLx9FnfotBrfDix
         DNttIZ90gehX2/QfxMJvjFJZkq3XM9+SEWgFgt8ECD6RMLHip0zPPhYu4rWajGb7D08Q
         kLUk3/erNnifmAA/s+0Rrz27DyRWGiQJQa56E1cnoKBvUvaA0Qj0AW/Td67+oR2u5OwD
         98Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784986356; x=1785591156;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ojCywNXwjuZV9F+KXvxIymh/QU/GqbkUx+RZi0hm3zo=;
        b=UhNSJyL0KHYqpEBi1vnEizMNlofjWBURHgg1doBTI8dI4QHJD9ZNLOpT6RPdVUGFI9
         vnn7d2AJocHs5O/ziqPfeFiTIYPgaGXb1czcDNmwSrgPhe5Hg2KpjC0PNEkpV+8/3+um
         Mhfl26KuAi2JfYk2tAHC3IoRghEWDNC5DBi33wDPJi+aD5vbkUh8dq3lU7p+ALsKWDXG
         +mP8yEnXq4HEDpTyNeADDy4z44v7Jg6ciiHnpJyKpfXQDcCkP3+1u9qNdtZ+TTaUuD2R
         xKcmtEPyGIOGldO5apGPNtcqkR0gOW/Gq6LVaBVfX5KXDGDDR/FnaD+huK0JXodEXa+x
         PzHA==
X-Forwarded-Encrypted: i=1; AHgh+RqXivYwEo3tsa9/uIJlizARgTkhtdDxqWweHbMQCqgHKw7p8OJD9VeDEoGFGJ1Yqi+HyOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYryLMVQHF29RvzvjrBuyGUOc7iTnhCwsjhBJOqU0lD5JS67uR
	cnmN7di3p3ZHGgCBNw6QjQG/ITstz58Ch653RXFcCnPzwB+HlHQmWTKeTdoNuEZcvD0gtqwuDHm
	K5eIZw8VlxH3f1VT9poTDt/LqrV3JIk1qOcPp+IdptsznMnT2v8Nfkd9HBcicjl6gyP47qp53ci
	3eq8rm9WyuK4sAcsCZdhp3OXO5rtvI
X-Gm-Gg: AR+sD1229daUFM6ORTl/syM4HMSjBk8CLxf8UXY1et2sK3VLJahZZVoZ6yQg/C4oFtj
	o/vZsnQQZOUJ5etNI1wHrQfFdQztcU8bdIyHw8lEqvsbQoniGvQw1eLdf5eCHiFMRybvgnCsUnj
	SW+mcOGZiTbuJANR9EjapxDz4+lV++E1cYtitk+cAzcQwinKomkRnK8CHZ6EhQXKrE9BplQHNIP
	WwyKeev/tGyvD+J89AwFGj+QI8NYIuJtRUBai34ZVT/NOi0DpUnOQGtmZkp
X-Received: by 2002:a5d:588d:0:b0:47f:9650:6748 with SMTP id ffacd0b85a97d-47f9fc9569amr2588396f8f.21.1784986355693;
        Sat, 25 Jul 2026 06:32:35 -0700 (PDT)
X-Received: by 2002:a5d:588d:0:b0:47f:9650:6748 with SMTP id
 ffacd0b85a97d-47f9fc9569amr2588374f8f.21.1784986355307; Sat, 25 Jul 2026
 06:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723094419.630204-1-pbonzini@redhat.com> <CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com>
In-Reply-To: <CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 25 Jul 2026 15:32:23 +0200
X-Gm-Features: AUfX_myxKzTGNHvvqQ89V0s3SZYcZaGC8AqyzdfM5uYY--NcItHzRmZ1zEO4VjU
Message-ID: <CABgObfYhsq-h4t=onAhCrbUX3p0beFM9jvj3bCKY8r2bRs=y-A@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
To: Yosry Ahmed <yosry@kernel.org>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Lougovski <alougovsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Il sab 25 lug 2026, 01:44 Yosry Ahmed <yosry@kernel.org> ha scritto:
> > +       /*
> > +        * INVLPGA has had errata on Genoa and Turin, and even on older
> > +        * generations there were reports of Windows BSODs if INVLPGA
> > +        * was used for Hyper-V tlbflush.  Use it only for shadow paging
> > +        * where it seems to be okay.
>
> Is this an actual errata documented by AMD, or is this just an
> empirical observation?

There is the VMware knowledge base in the commit message that requires
new microcode:

> > For Turin, the microcode version was 0x0b002162, which (assuming
> > this is the same issue) should not be affected by the problem listed in
> > https://knowledge.broadcom.com/external/article/419026/bsod-on-virtual-machines-running-on-amd.html;
> > on the other hand that problem should not apply to earlier processors.
> > AMD has not provided any information or analysis yet, and when we asked
> > we didn't know yet that it reproduced on Milan as well.

and I interpreted that as an erratum. But we reproduced it also on
Milan and with supposedly fixed microcode.

> I ask because the APM says:
> ---
> The input address is always interpreted as a guest virtual address, so
> INVLPGA is typically meaningful only when used with shadow page
> tables; it does not provide a means to invalidate a nested translation
> by guest physical address
> ---
>
> While this is terrible wording, it seems like KVM should *not* be
> using INVLPGA when TDP is enabled

While it is certainly an odd case, here the guest has requested to do
an invalidation by GVA on its behalf, so INVLPGA should have worked.

"Not typically meaningful" is a friendly hint to read the manual
twice, but reality seems to be more like "doesn't actually flush the
right entries" when NPT is in use. Especially since Intel has INVVPID
for the exact same operation and it works just fine.

Paolo

