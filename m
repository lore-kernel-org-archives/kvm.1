Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678452;
	b=a4a33CYHEU+3qOFPKMxqX/DikJlzg6nkgDPdWoSGSM9rl65M0lq8d681mp63POD7orUW
	 CuSd7SrFetO4wzTh58UD5saBojDy+u+SO8JXKbedu1jMdFCtz6u3zydCnfIGVEk4YX7Mb
	 MlRk4XyrngmVmbIdmafCMw0UG8tIMf2ih6pbsMZ38jd7uiQNCGMeKXn1PaatnTz3ATCry
	 2bL6Fkq3PjZ5DGVCz+CvOC51tPuPrpZXM+wNQL8NqG5g1+o8sKbB6/XtcFMRAuU1O29fu
	 1adAd5Oe6eAo1O/7It/4zzqGxgrDowe7MjrXnVifFR5c008d57ZkwQhUQzqNuPPZsSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ar1E8sP3jvEI9uhwbxm9hO7paRp/1SObcXepAZxmBtQ=;
	b=nfM8icY4jIqp8Q1sW7JtPtjPK9mKY3Gov8YHIAzBJX8vrq13Gnny8sFkYkorFiWzvVJE
	 QTWwCqnTia0ah/1nVCJ2Dw2JHmceQC0EXxbuu2Fkn3iJO5dlT7zj5w2OsZWmj8gcT6eFh
	 K2fINJlngWz7yGsSg1opqYF6Cw5KUJigjuDYUZdzAazV6lV8lFadXsy4oayYa+nb37OVM
	 s+81FwF3WtYua1EQwA9wpF6/PSWCAE5FE4AGtG9KU+Y0dNEWDed2ij5PFA44WbIzsU0Eg
	 MNbOQKw0qnOm9qHvXmq+jh8TQULXShN6Q8AFnujybZmUlxwRFrei5eG2WH8Orkncglg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oarfeyxf;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D792606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D792606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oarfeyxf
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-74ab99038afso274192137.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792678451; x=1793283251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ar1E8sP3jvEI9uhwbxm9hO7paRp/1SObcXepAZxmBtQ=;
        b=oarfeyxfEjEhCOV2PRbr2HmPUgigNYcvYFz+Bo0jWDOGvyJEyzRACvL0BB5m5iwLam
         la+JCSgOlKiVLTki/x5TP/kzdLaD45y4DUyehUyLTAUpLb1GuphHqCoVbnf7oevFUSMO
         YK0J9bOin5mX7i1si8hc30kK2l0zD1uVHSMxxTBIO5sk/YpzjhO4xk4JZXHsboQGB1B0
         p36y/RBJilfJA19LJP0ODeDhnuSC95jR6wY+8zsCMeRzGkufuSbetiutPLLy6dd8sxW8
         mEpbeZ0sY3nJRFE2CDesoZPmW/58xDFqgNs2Q9dhIJxFf/OK5rU0dtJGhSNHRHWaaf1q
         4nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792678451; x=1793283251;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ar1E8sP3jvEI9uhwbxm9hO7paRp/1SObcXepAZxmBtQ=;
        b=Yolh54m6aulhfXuGaP9QaOtxyvuinQtm7VbPJUPghm3jEOy0nHFOUhSoj7lNm0iR+u
         bI4SI6pdK8UAg6KXfgd7yZ6LCYfIQVNgSU2ncVVvJDRPWoWCvwXc01zTUqXpaMiwKjXw
         5OQv8nfYL9ZojFuK9E7tKoK8AsNP1sQcHF+PIdAUOacX+9jkGkRMupMpShRzLA0M5ubO
         FVkm5gGm18TOZ1sODOuKn82bVZNX7mh24/MGL86cnb4iDESHNObyXMgdxOYFCwosQAzn
         r02YEC3M2rlENXXOI9Lj3wIjpr6fCSSmTXzbsmzL7+Y1eqRQ8vo0lfnIdxdXebwF6Qcl
         LG/w==
X-Forwarded-Encrypted: i=1; AKwUvBwDuHgDkiMgikUxNf4v+EejjV38NJMtoFXdvDqqMhduOCccm+eIaasRT14pGq0QxvbWA+o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXpd0znjmxHDOnjqdmvylIUgmOCKXAxywe0UUrtj6jpQmz/x3e
	4pXXmQsahrUXS4vSvR9jRFFsEkK7lcexne88+/6SlEWtfx4LKPXrzXVA
X-Gm-Gg: AYBFou0o/jIpXiGQ17C1u+3Xl46WqTHr+h9wYc58mzJXGuZj50KRbcUxY9nnkQCQkZh
	c4nokuFe4MV3QV1tY8qJ0H1sbyb5y3bNV00Lf4/Kt71u0VUIoFnkfWmPBruxYhlxSz7oHLYItKI
	vQrQIcL8CFZTuUPU851EFDDc7UYl1J6LtyGNEQ+TFha0NgzfuNy2ymeFuL8OAiJvF73okfEHQvP
	dQSf7a4ht++y5yEFpMzAWDIC5VVNnzLPtxvNMXi5YnOMti8JOQyVUs6SkaNz7ebDozTzHgaNZKi
	BELsXzJb79JH1VWcQx0Y+LDALOmy7pd23bx3jDD1G2XETuCydMhA3OAyMnYgtdJlGyMJAbpNCSv
	c6p8+RvqD/S+fAnm00F5mSNZoSTElKoEOn2j8Otaa2Mk42oqTDLk3V3JC/5+XLyWOCu611aaVG4
	BjY/Zo1tvmz9tfdtttPZcO3cdiGGsjeU1PpcXeJkjJy8meIsRizwqISwbsu2yc92WACoMNaArZn
	SC997T1WIoZzKlf/OocZTHZwT9X5J3HX1oEoIPyoDC1LyYCWSfib3HBY8l7GJtpjUTS9SDyNald
	keqaDAHuSBnEkFqbWgBngB8lABq6wnlIf9PMP6GNfC+cD6tyyKxLm2h4hrlviNrXZOTmkSCKHoW
	I34Jywr5LuMSS9xd1Hgk=
X-Received: by 2002:a05:6102:160e:b0:7c3:f07c:f49c with SMTP id ada2fe7eead31-7cc9264273fmr2170632137.11.1792678451117;
        Thu, 22 Oct 2026 07:14:11 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ccb8fd4dfbsm1074530137.10.2026.10.22.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:14:10 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:14:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Cheng Yongkang <teel4res@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Eugenio Perez <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.78222817ba37@gmail.com>
In-Reply-To: <9756cf25-6951-4330-959b-3260f4760c3e@redhat.com>
References: <20261022091847.3654028-1-teel4res@gmail.com>
 <9756cf25-6951-4330-959b-3260f4760c3e@redhat.com>
Subject: Re: [BUG] net: tun: zero-copy path can expose uninitialized packet
 data
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 10/22/26 11:18, Cheng Yongkang wrote:
> > The experimental vhost-net TX zero-copy path can hand TUN a user buffer
> > whose effective vhost virtio header size is smaller than the TUN
> > device's configured vnet_hdr_sz.  TUN computes an skb copylen that
> > remains larger than the bytes actually available after stripping its
> > configured header, publishes skb->len from that copylen, and
> > zerocopy_sg_from_iter() initializes only the real payload.
> > 
> > The resulting frame contains an uninitialized tail.  The tail can be
> > read by userspace from the TAP peer through normal forwarding.
> > 
> > Observed on Linux v7.3, commit
> > 08ab31164c55f20c7a2653de3186ae333470e2c1, with:
> > 
> >    init_on_alloc=0
> >    vhost_net.experimental_zcopytx=1
> >    TAP vnet_hdr_sz=200
> >    vhost TX total length=256
> >    real payload length=56
> >    TUN copylen / skb len=128
> > 
> > The exact control with vnet_hdr_sz=10 delivered the expected 246-byte
> > frame.  The corrected trigger delivered 128 bytes after submitting only
> > 56 payload bytes.
> > 
> > Sixteen of sixteen corrected triggers produced the overlong skb.
> > Eleven of sixteen had nonzero bytes in the 72-byte uninitialized tail.
> > Several contained recognizable stale kernel allocation content from
> > previous skbuff_small_head users, including fragments of environment
> > entries.  Those bytes were never supplied in the virtio TX buffer.
> > 
> > This is a userspace-observable kernel-memory disclosure on a
> > network-forwarding path.  It is configuration-gated by experimental
> > zero-copy and an enlarged TAP vnet header, but the overlong skb occurs
> > regardless of init_on_alloc; init_on_alloc=0 is needed to observe the
> > stale tail in this test build.
> > 
> > This is distinct from candidate BR-023/BR-025, which exercise
> > IFF_NAPI_FRAGS.  This reproducer uses the non-frags tun_alloc_skb() /
> > zerocopy_sg_from_iter() branch.
> > 
> > I found no direct upstream fix or CVE.
> > 
> > The vhost ring reproducer and complete program/console logs are
> > available on request.
> > 
> > This was found with a multi-agent workflow; the
> > information disclosure was reproduced in QEMU/KVM.
> Please stop this AI-generated test-walls dump: it's not very helpful
> except for other agents consumption.
> 
> Really, please stop now.
> 
> Please instead ask your LLMs to try to generated fixes for each of them,
> manually review the generate code if you have the skills, and share
> the patches on the ML, at a very limited rated (no more than a couple
> of series in flight at any given time, with no more than an handful of
> patches overall).
> 
> Please consider collaborating with other already in place projects
> (i.e. nebusec) to make you finding available to the community in a
> responsible way.

+1, see the documentation on how to report and help address potential
vulnerabilities at

    https://docs.kernel.org/process/security-bugs.html 

Do not just send reports of unfixed bugs to a public list.
