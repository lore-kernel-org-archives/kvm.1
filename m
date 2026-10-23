Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792912;
	b=AoBqlMNDvWxTQe6FlLS2pw6N+aXiqhghkoi5HP+MFx82Cj+14H465MLYjqstzhgM0J0t
	 J+sR2iVSBpX0GDo3EZum3zeB4QrA+Oh4eBUI6Vzb8FhEJaFHSmTrX1tOt25U3dXi5hauf
	 +IlNBAFIn3msYqXbVmHfSYUbzzAy7WZBGJ1fFVCz+yf8QZ792miX9F+HrM9r9G6lyj+gY
	 FLmNWhbMWA45myqbRmH84snz0QOE4CgLbpRAuF43hUuwYhmEAkMX410OwPlgN470QRgn2
	 ogrWzSUDZOkXaZcskcQMnZ9lhkRfYbDmFw9eg+iBV99c4pi5OXKonCCg6QqZQ0LquoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
	b=yNUvbJkyeo8xv/Ja+MSMywL7y8luBvEswSE1yDQde6G0rIGyncgPApYj2taQ0qGeRf/R
	 6GV00KQKTqr4hPXYbdVuUMM/MnP3peS2SRgaORRPB4o+qHgKaiK2jiflpK5bdyWUNBSqx
	 BseYWgd2zVE2kJHzbDWt2CdH77FLurOmuJj5z33OaU31TJeKZLTzhPQp3RQ5QklXRo/Ht
	 f01FHoYMlCY3JD0NMQ9QiQC2cFJTmahbhZSrrBNJfCrDAlCLyuQtDv32SlLUBCEHnzESG
	 z9WZukFMyv6/zxe/cQWPQyA+pFDrFLJ5OlOCoGBq3zTDT27x463P8D50tFemYgrTHdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=H2Nk80SC;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03CB606A321
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 22:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F03CB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=H2Nk80SC
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e503815adso137009285a.1
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792792911; x=1793397711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
        b=H2Nk80SC0IE0suPURnYr9e6hZbC4LBCNbP2UbticIu/vM5Zx8lZxl1WF9oIVeOGweJ
         W19x63RIXk3jCkb/8AZ9w0/6q6ZaY29bsZqX8VJh3ACjKIAi6gixXOH39qqPhJV0UGZD
         h9hrX7AQMBlOV6X6RgQiCpuKPLs0LqoIe0SH9hdfWiIr6eNHUZFFbT0I/kCisS92xxMY
         Ucn1ZlEpvxoCWlvTmp2e0dWk4YFXYfROdABgbIgP0F4SF8jcDI2aMT5TzMY19oaj7RhQ
         ktu/3+o+78VzxnRBhNe+IMPeqMjRjTTMOSsOLuA26L6BAOJT0HaC4+T4MRB1PHDXmGMo
         Ignw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792911; x=1793397711;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
        b=AB+zyyv+uLH6mqpNagDWcR51JomQPhHxvp1/XSRZrv195AEIMmL3HBZxewPwUkyi4i
         42JCEEt4Ysh9ZqVMSS+kRQmYuok/U/QunjLasanJcBbVWjZrlhdyKJFuFhSOqp71acx1
         TyGoTgYsEzg00qhKcuy4L8uagTTpkx2NEBP81fJ6WQZHfDYpBYa24F/ZBmP4xEEPe/cj
         QcBW9x0ZBlw7qpVZgA0nhv9oeVFhKaGep9XpLCpS1u/8uvK+8qkzDa+3IJAYjIVUnMdF
         28ygMGnZ2IY9XxUBosgPY6GB82JTzzhHpVfKKqqFTaSnr3eS19C5H2r4JH/dBlzuqpaI
         ItGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCbHY2dKqGeHYmh1ux/E97PYeE/EPFTUDhMWu+OxIszV/izdrg7FdRMNpZoLAMwR5SY2w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlcxJl3RPdfMtjZtB837+1nG9Xt6wTDwSACGZvp9MSMMo/MKa0
	x26u+B1O9b1+xdx0Y9ZV4qX9tRzM37evlUPVvFv2wvE6BIT9AS7TGeN4U+El9ApDATI=
X-Gm-Gg: AYBFou3BrOX3EzYUnATGjKapFZrCXvRJw4F8MxCekgP/x4ZVpLo25YlzN9p2GeGxB/1
	K4/1nzbh/I5Q0ZlRB/5oIrJyMGiaEXmXNq6dhlP3HG2ZZsl+1FBNTo+ovbKFLmTtA2RGUzL+x2T
	D0pQDmOoIw/27ybZQxFtszh4J8Ii9uTSwRDorCOA1wZTNkf3jua1s29O3SdfR/1CxRtIIbSkEGx
	EUlTgKrHS6aKf5D9pac6OsM8+NKfxBV2v932jsglCJHdif/+aBeuaXjzaotBGyVn3CpM/Tt1KyU
	CFvfTfhhc2GJWbXiP4DN4apRczptrI0UlBMAxE6juMsEonpPfSbZAukGIFbKzcp+eNtFczqJD+C
	7w5DdzZnrWIsW/w/XFi3e0ABo/xFa0Z9Qb//VTX2kzvQj4BqK8C6G+t/Jq2tozc1X7aUWx8hjbt
	88oWunlsFSGpnVxQA0jmhWzH29KkAFjG5tIXzoxceJPItN3NZPGkcz6uiIlWrN7lborftBSYgwY
	XfO9oxL8qTyK3wZE6AuFHzx7AifEsxDgFBaJyqYdbUTKUnykp7ga+yLRZLe5CijFP13dRiJ5YqR
	3URuO+mCQHqXL4ITNY6kck/4RL0mqLoAVVFCKg==
X-Received: by 2002:a05:620a:4441:b0:93e:c12c:f137 with SMTP id af79cd13be357-940ef9c87e0mr54142985a.82.1792792910841;
        Fri, 23 Oct 2026 15:01:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078a762sm18520585a.30.2026.10.23.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:01:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKNKe-0000000H7Vk-3jIV;
	Fri, 23 Oct 2026 19:01:48 -0300
Date: Fri, 23 Oct 2026 19:01:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023220148.GN3977851@ziepe.ca>
References: <20261023190036.GL3977851@ziepe.ca>
 <20261023201531.GA2805244@bhelgaas>
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
In-Reply-To: <20261023201531.GA2805244@bhelgaas>

On Fri, Oct 23, 2026 at 03:15:31PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 23, 2026 at 04:00:36PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 23, 2026 at 01:27:15PM -0500, Bjorn Helgaas wrote:
> > 
> > > > Yes, the ACS combination is selected to avoid ordering issues
> > > 
> > > Does a user have any way to know whether the configuration is safe?
> > 
> > No, unfortunately in PCIe so much is really difficult when it comes to
> > deployment :(
> > 
> > > I'm wondering whether users might use "pci=config_acs=" to configure
> > > ACS so things appear to work as they prefer but may not provide the
> > > ordering guarantees drivers depend on.
> > 
> > I imagine that could happen, but on most practical systems the root
> > complex will blow up if you do asymmetric routing so there is an early
> > indication.
> > 
> > I know this because I've help debug such configurations at
> > customers. Some servers helpfully MCE if you do this. Lovely.
> 
> I'm still confused about this because earlier in this thread, I
> thought Leon said you do asymmetric routing:
> 
>   Bjorn> And I guess asymmetric fabrics must mean fabrics where
>   Bjorn> Request Redirect and Completion Redirect are not set the same
>   Bjorn> way?
> 
>   Leon> Yes, in some of our systems, deviceA to deviceB is going
>   Leon> through different route than deviceB to deviceA.

Yeah, that's what I clarifed, it isn't quite accurate. The asymetric
routing is between Strict Order and Relaxed Order TLPs, not
request/response.

Jason
