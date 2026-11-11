Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418682;
	b=JNOWEIJgHM30x87gv7BeLmoyR702DXQ4XXl2YTKrAvXqVARrSKu666nrQeVvA7NY1eGl
	 SeXtpKcFrjjKEKWlkDPyJrsM9IsBK8rsXuPWA9eTJaAFLrYa0fxlUENvWQ+dv9hKa9y34
	 e8tUrXU9q2DpW6Ko4WCT3GG4z67RiWIFfJDXcSY6QyX7RPmmAUMVdFRzj19LiJJ/VZhb7
	 +lhLopNUsgNKmpEMEFKs5+LXimHIC7JeOag/45o67g1LU7Ye5yENnAGaXbJgloXysbahr
	 jRJNGJC+pWUUqOTr4xTlugi8Wi+Lrn1cnWpCXUZsDal4ni2z26uCxVFKbGaWtcf7S3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=IGymzurcCAqkuazrSBLvvuD8i7vbGW+naOWdeyf6NCQ=;
	b=uhuNZVLXm5GddLxP1AEps20Dj34ZZqyzhVkGT1kdlZ3bL5yqLcEq7feKw0KKX38DVmh3
	 sbc21Zojr/kpnf4SnsU7sKIyMhv2WhpDeJFBdUDgqpJi9B2HVmH27sri3gMJB8EprS1Fj
	 EG6pVpWu1vhLDP692mb7SyKEO9O3K/4i734gn0mtFJB/A6aXtEeAxnHJ9k54IwJS2cNyh
	 HpfdlpautsqBW2v3tSI9+z+I6d3uPoyJRm5mr4Aw58hXho8g+t7CwgjJjvu1o60cBh1Ak
	 oKQR03feXca1WYXbgLt/vqoVOJWa6wP+Xf2+euLf0EkBQewcfuJ1f4kXfbQi2OOqGKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W3hKeEu5;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD58606A324
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 17:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD58606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W3hKeEu5
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb91e288d7so2983725a12.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418682; x=1795023482; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGymzurcCAqkuazrSBLvvuD8i7vbGW+naOWdeyf6NCQ=;
        b=W3hKeEu5ne0Z6PaSfmfb9DW+puWYizeutlxNeO2s90LplTe7xMtet67BGtg+i4FoAX
         5jJAIJ447E0tWe6RkDMVfNacWyREuOXywZDYUQZooM1/VSBCTrfp8mIXlHqgqxwLMniN
         5cCBagiWFIxmwglO0dKp3xdbN27i4S0UhUM5L7kgP6u9nHqLIEVvY/5G4a+r1S7s6ENZ
         ouFk9/0+5KOapKMs2UKBcVzcM406tcPyr0z1BCrPzAIpnU6aCQxObxRxpQ8fc5E3Dpmy
         FuupIhRV4IqHTJ30Z+zcEu2cNqTCZEtAmqGA71lw8FUXBRPr02UsYVz0SOzRO1lWw3mm
         WFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418682; x=1795023482;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGymzurcCAqkuazrSBLvvuD8i7vbGW+naOWdeyf6NCQ=;
        b=1zZ1q8SfJYksdQbN1asvULvi5l9SrrxN7QhEcMSsL30U5hZbLYyucT9SyrcQseIuaA
         XSl04EuttLS46IFqsTS4XfsWvOlLX5Z/B34Eha3+rPvZNTL7v6qW835PeutO+4htrc8D
         GRqMukJjiuYNhUE3vz1KDPhvah4UhRFG2qib2EdmER42XL2TbQceqB6Jc5np3FE+ljuk
         iwFXEu735x5TYE54arV/bVhq1nU4Y+JCQ0eJDn1sOpDH7+I6SD7VAetSlalquJx3TXax
         xT5TT8mG8pbwczEMB26qhsDN5PJepMVn2UBBOgLTIfN1yeWxYCDYzVKO60S1ys2xYI3Y
         O7fA==
X-Forwarded-Encrypted: i=1; AL+hErGj4P2byv2MZ2sMKZ9QHVUTG8fch/dDFL/4EsNR1tpnT2MrAvVkYsfTz55w7Pjk5inXE60=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nfowwSZ+/Re7smJUaTp2m4zN5eGDVWjFrgAQceAiAAFRb7iF9
	DzOqjspLoY5qXk1eo8KRXB/2ELpHBfPfwIpA+QAxVuwjLQgu2A+B0YjdgpgS/MaSQPfOd+NVmcI
	gKEcPWg==
X-Received: from pgoo5.prod.google.com ([2002:a05:6a02:3485:b0:cd8:b51c:c0b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7349:b0:3e2:6b5a:fea3
 with SMTP id adf61e73a8af0-3f2ff4cfa62mr3490465637.71.1794418681497; Wed, 11
 Nov 2026 09:38:01 -0800 (PST)
Date: Wed, 11 Nov 2026 09:38:00 -0800
In-Reply-To: <auzSxEsGAcm3MYtN@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260714160411.302386-1-alexandru.elisei@arm.com>
 <amPCdAswlk24Xilf@google.com> <anxAGkdyPYXBlS00@raptor> <autwsR83Ii-tRrqF@gremlin>
 <auzSxEsGAcm3MYtN@google.com>
Message-ID: <avSn-IW8DMybO-Tg@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2] KVM: Ignore MMU notifiers for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org, oupton@kernel.org, 
	suzuki.poulose@arm.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, david@kernel.org, mark.rutland@arm.com, 
	ackerleytng@google.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Sean Christopherson wrote:
> On Wed, Nov 04, 2026, Lorenzo Stoakes (ARM) wrote:
> > [updated David's email address to @kernel.org]
> > 
> > On Wed, Aug 12, 2026 at 10:42:50AM +0100, Alexandru Elisei wrote:
> > [ ... ]
> > > On Fri, Jul 24, 2026 at 12:52:20PM -0700, Sean Christopherson wrote:
> > > > It'll probably take me a few weeks to circle back to this, as I finally crawled
> > > > out from underneath a pile of urgent and am just now getting back into review
> > > > mode, but this is fairly high on my todo list, so with luck we might still squeeze
> > > > this into 7.3.
> > 
> > Hey Sean,
> > 
> > I wondered whether you'd had a chance to look at this?
> > 
> > After discussing this with Marc and Alex it is clear that this is really a
> > blocker for Alex's SPE series, as we need a sensible means of ensuring
> > that stage-2 mappings stay in place.
> > 
> > So ideally would prefer to get something like this in in the next cycle,
> > if you don't have any objections to it? :)
> > 
> > If it'd be easier, I think a smaller version of the same patch would also
> > give us what we need? I.e. your snippet from June with the page ageing part
> > dropped, as below.
> 
> The GPC invalidation fix landed, so we can go straight to the super simple v1.
> Compile tested only at this point, I'll formally post this (hopefully today),
> assuming nothing explodes in testing.

/facepalm

I spaced on sending this (and I think on testing it too...).  I'll try to get it
posted in the next few days.
