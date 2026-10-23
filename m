Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771161;
	b=X3HVWaHXvGFY0fTnoplAD+9eBt4nInCdeYCVfKZigdYoFqlO2P6YEiad/xjLFQNFDfpP
	 XV6+HyOvhuIjukYka0rqINpTJXA4m/mNuAvuzcnS3ObbdlppRlFMQQ/Rkd7Z9F5HgsSXs
	 Oi6W/IQFofKu0/FGFJaCOrOUAd3RW520i7yHyTxKLBmkCiqq4tlgrrlauld6bVH9sQsU7
	 06c2mZl0ytBovfEQBQEMyKtFFQuxUgTJJiM/7yblobk7j4fP+CJwDQBKqAYUjbRhVU92v
	 yvPwuUKrashXVxsK3E3oKPQ/DeMjGxOyNgXHlETn2Tn1tx3HIvpi7LWf9zyt7ZFTC4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
	b=lo8VXRNsBJVJP3dFNWG8ufKLaCflJCHjSlrX9ma1KHb0xCOpForYdeX61ct6IywbnAqa
	 2xXS8Jbmedot2doxgMMb8mr0ARqq1H3ibasTRmbc6CtOhRJp+WzEpTAfWVCiBdt87awaX
	 YU+L2bGzNgmGsjcpP6SVEsvSzRKaDd0n20D7e0/oX1vuqoacb0IiLIqDNgOT7fWN/MBR4
	 tiWtYT2NhZX5JNJaKEXmNcfRFnq4v4I8UNEU18dNiCH0D5R4GXATkE9pcHIVP0qr4Hw85
	 0ZiF3vHsbUMn1lZoPvKDsjxU2AxGV0OEEDDv7Gl0kJhMr+WHg11EV6w+l+XLhLGDnIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pOV9sna9;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234C606A320
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7234C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pOV9sna9
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53644b28706so13933761cf.3
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792771155; x=1793375955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
        b=pOV9sna9TZaCqywtdDI8h+mSGdu3kY7TvcG6DQSaz/wzZ4RWxvzzkBqqhU+wauIVz0
         y7gqDg4Pv98+G/EoG0dUf5Bpk4Cl0e0UZ7LUISdotu9Tsw4EOlJNa9g21e1C+Zf9KMZH
         gYHQI9+v1MeGOmU6kjTdceiCLbZqOiGD/vZZ2gPbf7Lfpg+R46vh7tpjBVmQ5GGunmYC
         VtuXQ6ZEps4zStuYQLp7cEl/vePQpZ5aYQvoiujxoHTHp/fCRUKvmNk27XK19PLiHYCI
         JYluupC4j0EMlwXjgXHC4TBCzVFNeQ1eRj7qeCWp0ln6/w6oJwD1gZkKqq5ddT+khVyu
         ejmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771155; x=1793375955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
        b=AFHO9zMS4fo0EAN2fhimKYkHg37efEyEcuiXyOR+PVXLOe0qeiHhn8+fwwMv4VtTa9
         lbuFK/LxaYE7hqHsZyYQONxzuENlJIXNZlSfZxUyAc39mLog7XVYkmPrs9ZGj0tr5liw
         ngDUWOyR+Wa3Qkzq/QAuQXTfcM3cKG+kV4i8PEXz/XKX1TJEYh2SELYBr6g2NJiBD13Q
         WAPznNviqGznyuOBjsc5EkaHIJ/bOSV4ycY363T++dhHnKwSpAubI0RhZGv1eN5mueQy
         2K0zdaFbI9IjzoUfuiZvcD5pBDkwoGkKoChES/CqkrkWPBYiKcSluuXA5mXBnWx3ayUc
         +ZTg==
X-Forwarded-Encrypted: i=1; AKwUvBzJOT+PHYx6NCQCxOidO+6TGH6yjzjZ/gjPTOKYRePmHAuEuEuLeVVVqlFusQSJa56nBcs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLn3tR/IcHjKPbZnhiMWR2WTMkvxQSE9VsZegQq02M5K8/6QtwJ
	KnXjQkFlxMLdEkEpX94BXDXVBp8u4O9mofi7Xhg8azU4JsHEc7tBFVqZPH95MCx5WvY=
X-Gm-Gg: AYBFou1QuWwXc2Z5eqbaUaTr7OhXYKgwK6+1/nfR+sfaS42/hmUVgg6oBPCt0WLDjFp
	yNbyEp9T4YCY4Zz30M76X3zPH5OPpu0Q7vkHlolAGhVylbV+AAd6lCDEyjvssFLTD060MXn8jNj
	D5SygOfuBmQsTuCR4ClFqPsmUGsICvpy/bhF7Ah3yGgSUGJgQ/d0bVqsoHQj06hP7D86Te1oBL5
	S2Sf2NG+I5MEt/ltoqhTmUs3uE0hCe9LU8Sl4Rufxm2ZeWC4Q9Q0OTJ5NQDmrX+xtRH5MYu3DYL
	grSwRyMpPQbutM3u939sLcQ+iG1AbULobfN9vQxtuyEgZfmd8csMLIpCKa/VjvgHbvGfEdJbSwH
	36DWxavUxG3XPevr9Nl8HZCo/S4V0QekKHd7fdO2cg9ozwE8yRFvZImvBZdCqS2MlqdGa+s9rHS
	0gohSJ4voFu7o2/ehUVml5EBewZez5syePlYxkjBvUgkSDBPLgNnDiChWm6M6301+k+Cw0S/JTl
	QV6lfutPnnyWcuOyiu8e9oHiP0MbMRFj5RZ8haTYnZfJ7BXEsFRLfPohMNGYL9Wq1T3unzQMGIR
	fcvnVAVb7wge5kRIgF/WA16kRCNfGQiw5eUeQw==
X-Received: by 2002:a05:622a:a0e:b0:535:859c:b6ff with SMTP id d75a77b69052e-536c24e2452mr39136051cf.20.1792771155235;
        Fri, 23 Oct 2026 08:59:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53836c78f67sm656181cf.27.2026.10.23.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKHfm-0000000Go19-0EMi;
	Fri, 23 Oct 2026 12:59:14 -0300
Date: Fri, 23 Oct 2026 12:59:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20261023155914.GK3977851@ziepe.ca>
References: <20261007063227.GC7822@unreal>
 <20261007204045.GA783967@bhelgaas>
 <20261009174301.GC11438@unreal>
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
In-Reply-To: <20261009174301.GC11438@unreal>

On Fri, Oct 09, 2026 at 08:43:01PM +0300, Leon Romanovsky wrote:
> On Wed, Oct 07, 2026 at 03:40:45PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 07, 2026 at 09:32:27AM +0300, Leon Romanovsky wrote:
> > > On Tue, Oct 06, 2026 at 03:49:47PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Oct 01, 2026 at 02:55:10PM +0300, Leon Romanovsky wrote:
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > pci_bridge_has_acs_redir() treats Request and Completion Redirect as
> > > > > interchangeable. On asymmetric fabrics, a control for only the reverse TLP
> > > > > direction can unnecessarily force P2PDMA through the host bridge.
> > > > 
> > > > Does "the reverse TLP direction" refer to Completions?
> > > 
> > > In general, the P2P code treats TLPs flowing from device A to device B the
> > > same as TLPs flowing from device B to device A.
> > > 
> > > However, in the context of this commit message, yes: completions flow in the
> > > opposite direction from the device's perspective.
> > 
> > And I guess asymmetric fabrics must mean fabrics where Request
> > Redirect and Completion Redirect are not set the same way?
> 
> Yes, in some of our systems, deviceA to deviceB is going through
> different route than deviceB to deviceA.

It is a little more subtle, I think practical systems try very hard to
avoid that since many host bridges do not like seeing only half of an
exchange.

What we end up with is Relaxed Ordering and Strict Ordering take
different flows in the fabric.

> > But I asked about ordering because it sounds like this patch expects
> > to encounter asymmetric fabrics where Request Redirect and Completion
> > Redirect may not be set the same way, and the spec implies that
> > asymmetry may result in ordering violations.
> 
> My guess is that the hardware and system architects have ensured this
> doesn't happen. At least, I haven't received any complaints about this
> series during internal testing.

Yes, the ACS combination is selected to avoid ordering issues

Jason
