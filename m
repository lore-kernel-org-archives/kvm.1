Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283006;
	b=QQwkbZFnJJNMTAiL3Yi2USxWDyEgJmYRAE8IPYjvbP89CHVgVusJCBaAjHaZwVo9qmyP
	 AxFV2/CVCNjOWwWskUa9gSxpif7nYgMakKuRD7HPWnfisTt/hX8B62b1XCm3E5O1ORV48
	 LdQaktXN0YAPkEaYOY31o+0pDtqc+C+K7Vx2qq2nQBC+9+0AtnUpGUq1ERe/Y+HKNCV+j
	 NOp8+uPSysU8rA020r0bkOR4qtZO0oBLBCukO4mTydmLYujKy7a/JC3zOmWec/ow9LFM3
	 WUl5yRk2gPxgPbBrJ4/yb4jm0QqiuAJDwtfGjnViqi/9nWLLHgJv5ngCoqq4PlPbsMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=u/mTL+S+jT7oJspNq9ZedMuDxLFktRxLqgiEWs4bjJc=;
	b=Ngk43pKt8/o3wSL3QMBMEvbb7Stjm8kLH0N908a5RsQXFmyOT1aanVnp4CR/9Yqz0dqX
	 rTfjKe8D398W6K7+DTXDWadAVumGiBl6FRHFei25umlTKABfuWrVKjDylrGReYoLv/cAE
	 pLMbtB9QWem0dj3jxwCpt7FMLlTovs88dqF5MfD1/ytt20/SQyyJ3bM0c01o107Twp3fL
	 eaYZTv343eOZOQ5vcWHWSKhX3KEpbCsDZ+On2CZ8nCFSsq0h3u6IAZ0Am1wjBgTikWNNB
	 aTbI+Lk5MsRRGYddvFQF6lkuFBErpT0Z4PKFrDVWPaGX0L+UGoirkqAODZwVELgJrGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172AE606A322
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 14:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 172AE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93ece7a73b9so242784585a.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793282997; x=1793887797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/mTL+S+jT7oJspNq9ZedMuDxLFktRxLqgiEWs4bjJc=;
        b=oqoCkjVszR8u8wCAtEPVJAxDRDmSU97Ltyl0epD2Lt3u2UIIXdVHNDGujjYdwY6WRE
         SKBt6uYgdBnT6o5KdL7GbgHiWWlXLYlzp8oWVtx/63snb1x0A/98UMN9nSo5V6B5ls/h
         9u535mipY84FplFJ5MHPeqQly0KmoyExjUBmnPmbZgYUFhtaNmzu1pOR7TqeL6ghQvnJ
         wb2AWZsJdkzFI9sCrqTqK7UV5M+ZSaa+yHEEkToHs9S+zZdwlj+JO6pofP8F4CYTjz8w
         BisOYjY7MDZGSlzjpRbTYDWgiYT+BJxMePPhJG1Ck8ZG82Y4PAMfi9RC0ZL1zm8pkkMN
         jT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282997; x=1793887797;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/mTL+S+jT7oJspNq9ZedMuDxLFktRxLqgiEWs4bjJc=;
        b=eY+228r5tlR2Khbc2VJjazuMZrkwdOTiseX66zPfBj4mtaXJRlUt1gKSaWOw2TIUrU
         V1Q7ZXy0lk/LUHDs7al2eW3ydFCtKmhx8Uip60TZiNjqVz44KWj83txoaWCuxB14OFpq
         QPixOfR6Mkr3Hy+XTOMddwFtfKq8posc1Y2E74nKCNuSHqIZdhcPbPEp/2YyJgUD/ENd
         75XOx16nrES/VYmmKxcd6iYx7EitTm1TjwQwCqBvE44R6lF5r/HTK2xQHu0yZKON4S9n
         tV6Ksu7fBcsk8plclme23whGMfWrPLx4XLGk1u5luNRkIFYtK/tKELFjoboCeiZi3dvX
         aM/w==
X-Forwarded-Encrypted: i=1; AKwUvBw1LzdqqEp2OmYaNLoLDC6JsCwgg483PpbnJGFkWVS+KXzlIwRCfdPWdlJka1mNvOUhDOs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZ/zCa1im8cvnNe5jrvg6weteSim/fzQzScxzw0e4G95Czl8ZK
	skxbPfvchWT4OT8ooGhO85CT1wPbpchXHUKlN6mz8+6rhRO0Nm0fSm8g1Pgfh+CADEI=
X-Gm-Gg: AYBFou0srdXTBi1e2JiaSXuFkCwg5MPzsC1NuwpB3CI895c5r2nx5xqgObjAtMCrb2F
	ZDm88MKuScMEP5gAtUx7s0S/iy3ItCjajsS280qlAM8n3qiRoKiuNu1Xed0UK7oFmoAu+xwQ7y+
	QqnvFcoLiROhk0N/9md2tKpxTy0+2EBVRUVP7+iKdAzv1rUZ5oqPvPjhgchrdJR0K8N7HPTXdmt
	qOpALKK2WnX1hTsLNALtc5LpvMBuRkvQvXJ1+FtXaKb9w5R6eA0ksWYVxN3CU6XWFpDqHCelCgo
	rbPFlJj+pxUp7FJ+5MNXPDzjuG9keBphe+Pzgr4wKWOLFIIFZb12MGCN1jskS/3F7lXdQfncu27
	AAfs+J65b47/ID53VoJAkd7k65wFQ3xPiC4cNn+Ewgj0mKW1WZ9pi6DuRBx0chxH0022HNpWKWG
	jVjKUGK2MNjxxXJiOpfDqxjm7H1FMXkHcsWxQYx+9hj5s56uibb4mhxAxofmK6nQhMfHzJL+siD
	yrfVuVDTSI4b8yeJ3wDxAtJCnQd3hKoXC8oJxAqxVrpoDg+5tLa5ESBA7nxHde53HcLaWIgMQIt
	r/l1IvkrqtAb9rJYKFcZOeyN3+d6nB5VzxTa6yzdn05qZGZpakm44AvopMJuq58EldQPpL0BUnD
	buGPcKLacY8c=
X-Received: by 2002:a05:620a:29c5:b0:93f:59b8:e28a with SMTP id af79cd13be357-94408cf4114mr838476185a.28.1793282996749;
        Thu, 29 Oct 2026 07:09:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47cb4f56sm162421066d6.35.2026.10.29.07.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:09:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMQpH-0000000FhyS-1U83;
	Thu, 29 Oct 2026 11:09:55 -0300
Date: Thu, 29 Oct 2026 11:09:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org,
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com,
	drdeeglaze@gmail.com, James.Bottomley@hansenpartnership.com,
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com,
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com,
	ankita@nvidia.com, suzuki.poulose@arm.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX
 support
Message-ID: <20261029140955.GO1685504@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <592d643f-e97d-4de8-9a87-e47d57dc8457@intel.com>
 <20261027193629.GK1685504@ziepe.ca>
 <5f33aeed-a20d-4881-9ccf-a69bc308d348@intel.com>
 <20261027234658.GL1685504@ziepe.ca>
 <c57c45bb-5047-4aa9-9f06-6ac5f36ff3ce@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c57c45bb-5047-4aa9-9f06-6ac5f36ff3ce@intel.com>

On Wed, Oct 28, 2026 at 12:16:01PM -0700, Dave Jiang wrote:
> 
> 
> On 10/27/26 4:46 PM, Jason Gunthorpe wrote:
> > On Tue, Oct 27, 2026 at 04:09:19PM -0700, Dave Jiang wrote:
> > 
> >> There are two issues for TDX Connect. One, the device info is collected at
> >> SPDM connect (TDH.SPDM.CONNECT), not at lock. TDH.TDI.BIND only returns the
> >> interface report. So the measurements a TD sees at lock can be from well
> >> before the lock. To get measurements taken after the bind, the TD has to
> >> ask the VMM for a recollection with its own nonce.
> > 
> > IMHO measurements taken before lock must never be made visible through
> > this interface, it defeats the security property of evidence within
> > the locked session. I would expect the guest kernel TDX driver to
> > prevent this.
> 
> Agreed. I'll change the guest driver so the lock asks the VMM for a
> recollection with a nonce the driver picks. Each lock then costs one
> recollection.

I do not understand why cached evidence exists in the host. What
reason is there to ever provide a stale signed evidence? None.

Other things may make more sense to capture once and are not permitted
to change, but evidence is not one of them.

> >> The empty challenge in my provider means something else though: don't
> >> recollect, return the evidence collected earlier. So it's less "omit the
> >> nonce" and more "no new collection". Maybe that's better as an explicit flag
> >> than an empty challenge?
> > 
> > I'm not sure 'no new collection' is an especially useful thing. Since
> > the kernel won't be validating the signature you still need to pass
> > the expected nonce from the prior collection back to userspace so it
> > can check it.
> > 
> > Is there some specific use case for this?
> 
> Getting the lock event's evidence. With the suggested lock change
> above, the guest driver collects it during the lock. But the lock is
> a sysfs write and returns nothing. Userspace still has to read the
> evidence to appraise it before run. The device was already locked
> when it was collected, so the read needs no new collection.

Why collect evidence during lock with a useless kernel made up nonce?
What is that even for?

Signed evidence must always be collected with a userspace provided
nonce. Any path that doesn't do that is pointless and I wonder why it
exists at all.

I imagine lock should only put the TDI into the locked
state. Attestation should later collect the evidence with a user
provide nonce.

Do not collect evidence during locked. Do not hold stale signed
evidence in the kernel for later retrieval.

Again, we need a flow where we get into locked and know we are
continuously in the same locked session until we reach run and dma
enable. That should not be done with evidence or evidence generations,
it must be some contract inside the TDX driver to provide a locked
session generation.

Under these rules it does not matter when we collect the evidence. Any
time during the session is sufficient, it does not have to be done
instantly during locked.

How TDX does this is up to its spec, if TDX has to capture evidence
and do evidence compares internally thats awful, but has to be hidden
in TDX and not leak to userspace in any way.

ARM should do it with the sequence numbers I mentioned earlier.

> The guest driver picks the nonce for the lock's collection and
> checks it before publishing. If userspace sends a challenge instead,
> that nonce is its own. The collection's nonce is in the evidence in
> the GET_MEASUREMENTS request that asked for the signature.

Unless the kernel is decoding the evidence to check the nonce this is
security broken. I'd rather not have the kernel decode the evidence
like this, so the nonce should always be known to userspace and
userspace/verifier should be checking the signature covers the
expected nonce.

Jason
