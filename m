Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616300;
	b=m+ZBsEktxNOC8JuuJ8ZmKilpIWKVZNqC2V+jQPK9uwclJNtgJ2YgmjUhy84xjJLdXpOK
	 +Q1nPYFhxosbT4R2NEK9um1FL+euSKhE+OuhWQSaRPlMWB2SNni9h/srNBWyn9EtVzWy/
	 VCy6X8EdNSZkIeSKtiNx5ZrpY8A603qYThHrAEbb0dwB/YdCbx8iKxFnOtVDDNWsRwc48
	 eusgxGSAPN/DHJKQoGWiE++WpmDReaAUZuU+SBR0DlO9dXznD7MEFZP8ePqWgWyxzdqws
	 XjPfrtTHsK4hayP1aV0zQ1oo22EGCqPsCMOxySYIDUridP+J6ODu9qKN24QPjXWCbjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5bQ37Dr+87om1NS6c4tle8Uvo6AzgbEUJjiMwoZ0S2Y=;
	b=sp7G0SNzNEV9RSRb+Qh5n35jJo5qHjHWcvu9Axor8OhRdo98L8y1NiBya4nnuv0X22m9
	 U80iF4WY23yZA779dxOoET9m72jEm03caXr5PmpAwVcdDZ5n249cX8CIUNgkLNI5k64HJ
	 T9UOdhiLeFoAd6wZtHhLI40Bk5GougVfxPzs3sqO0BVRldBeW15Jv2+w2Ijd7+mz0MpJF
	 kVEo8cx/rsZ6si7DVSSaHrNQP5GuuRgxFq8p/9Mku2OjhImcI7uREXN6zgjXHyFhsCCdL
	 PwFnlZMVrRoYAzHE86HOFVYfVDKJ0uAVW4kqK9fWeuROeNV6y6CKwB57pNhwLxX6hTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MEOlNfo1;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F96606A327
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 14:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F96606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MEOlNfo1
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55c48582654so65463451cf.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795616299; x=1796221099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bQ37Dr+87om1NS6c4tle8Uvo6AzgbEUJjiMwoZ0S2Y=;
        b=MEOlNfo1qg/cH6pOCcqk4ewoVEubf9v6YcxURtGIvBBQGSH7BYhhAR/7yNbMt52oXF
         cwJD4Ula5C27GWRWIuZyRf1qoGWwVhVrOfUMJAZqd1T9NV6yoYdvh7cwofFrwaLvPsvP
         nXgjg8PrYVcw+zwoh2nefGddsw8MzZm61FOsXTicEsr7kXgXb4nA6XLAob/bfzKUmbMh
         4uktg9UZY5A2VfHDOTINNECmxxljQBDBKm8WedEnVZJViFLZCg3jEEPYETtfvbfUHFgl
         Tj0YqSHGdT9EqoKamB2mQVQpkznFGnIyqjYQDh8bxBf1lJRXHB2bmdbRm40ZGvr1jet7
         hh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616299; x=1796221099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bQ37Dr+87om1NS6c4tle8Uvo6AzgbEUJjiMwoZ0S2Y=;
        b=tCJNdBpqO6Jc1KtEQ3Pu6oXXoNG27U8eOYJAP3azEphZWiwyHx4zv+4LrSc8WELYTa
         SP6NbA/Az7Jn2rol13iY5wYCVOWYSgeB2RweETQHoiFlHmtX3Q+L8f62F+fzO/AQs5Sb
         WwoBJgQ0mJWnExAKXj3QldC3Y87cda3uOfNt45qxbNkKoYQKeMMibFp/mL1s+FYbErvv
         NP5ShhtCEwa5rXAtyBTjqOPVZSx8v/Qx7XR9P287/b/+Q/oP+a3eRYi0WYZlTY92UJ74
         AcdMQdAbX/L9OFzBcx33t9amTLB0Cfi9UsIJciDvcA09MzHMFtG2WPn+Mb5rKPmJpvIp
         c4jA==
X-Forwarded-Encrypted: i=1; AL+hErHOlTcpfusDmIc7I0wrZQhYFM2L9M0r2c5SirVKCbi2i5IEKpMtKRLUwUNcrUYRnxHX5Gg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nGG+pqQhIcvXIpXgAOnp/1vbvMtJbexop21+koPJ3+rhRmbLs
	vegeN5nwozfic9at+k9xvzDx0aDtuA3RX8HEULLr2ZwkpFEMxBsfSzU/Tb0f3MUB0Zk=
X-Gm-Gg: AZFdTZcKE2eNhrepgKbz4sg/JSHxtwfBWBMG35J6izY1aYT77xSVl8XBlRDABDrHfit
	4ndFKLr/WIzv+18glVfaOvNEy/uvjkQHU2xdploTWLDL/gK9pJ6ecfEvGXHGZ3VSrCuxfxfB46l
	PyDjohY0fp2LPDA5toiiUJEt/NhN5mbPlxEEz8cmarCQ5tHUp+jjICeqbch08p6SSCpx8cs6FLx
	a2FaFFKRsBXKeIqbw9ufUkxPlFphS3Zq7kv+kbQtUVsH/jo8xeazGBFiu7cXSUJo096dIeT7mnJ
	cGyDqqefna4QMJIgN39co2cEn1Fs8V4HNm9JSTERVY5VkhQAIdvHeFBNWqd+bVZ+5+1qfX3nm5A
	2np8+tnclg1Ypo6YUWh2wAKAbDc7oHw6J6QO+3ViKMdDdG7yD1stRvEXdeNJ0mpWkj4EY41qJx1
	UEl6XNZjNiYUSrz1lCiD8z0jX/p7rTpL0VAA3iXW2GuJq/+6gxfxbBuq/L5alqQBjvpZY8NjwC8
	oDo7bu25TmyhY2uLeSybHLkWeKzqwKPtBCtOhoKFEGUqcdyY6gazBQ0G5B7X8Dar+sNHf+kQ16S
	CR1ngg==
X-Received: by 2002:a05:622a:1aaa:b0:55d:3721:872e with SMTP id d75a77b69052e-55d76b34525mr321765931cf.69.1795616299369;
        Wed, 25 Nov 2026 06:18:19 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55db5bc2f31sm27755541cf.20.2026.11.25.06.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:18:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWDpB-00000001jOX-3H6e;
	Wed, 25 Nov 2026 10:18:17 -0400
Date: Wed, 25 Nov 2026 10:18:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 02/10] coco: tsm: Register the TSM class before device
 drivers
Message-ID: <20261125141817.GC246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-3-aneesh.kumar@kernel.org>
 <20261123152903.GG179082@ziepe.ca>
 <yq5awlq19v10.fsf@kernel.org>
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
In-Reply-To: <yq5awlq19v10.fsf@kernel.org>

On Wed, Nov 25, 2026 at 01:56:19PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Mon, Nov 23, 2026 at 02:03:29PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Register the built-in TSM class with subsys_initcall() so it exists
> >> before a platform TSM driver probes, independently of object link order.
> >> CONFIG_TSM is boolean; remove the unused module exit path.
> >
> > Why isn't it modular? This is going to force alot of stuff to be
> > non-modular.
> 
> tsm-core.c contains only a small number of helpers. Most of the tsm
> implementation is in pci/tsm.c, and even that codebase is not large.
> 
> This differs from the architecture-specific backends, such as
> arm-cca-host and arm-cca-guest, which can be built as modules.

So, why isn't it modular anyhow? It doesn't matter that it is small,
the expecation is most systems wont need this stuff so we should have
a clear reason why it isn't modular.

Jason
