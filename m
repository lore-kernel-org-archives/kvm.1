Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822210;
	b=1JCXmRd5MF9oIgnp6eXZfnN5a6X5vUJT+QoPkd5d+nf0raIHQjtLWLPA9miefhdMk/37
	 6gu+5FKJ25Ezzed+dooQVeCNnNvdPkb1wEiFpMlAqs/EviWt/XQsiMy5JjVdcFDPUPXpH
	 Cqy+N6Bi3kFeoF2twvGsFYWHw0C23jhGVrgVWLNhFYmm9SvxpeOCoxD7mxV16XIqs5pR4
	 dthYsA/236OVZKVEy7pQsg/vP7IzHXfJfH7aR9VAvPXtnJMH0C8qHYqo8mxb7f129dU1N
	 ciyWv5SQ8z8e5/dhImdIf5UZr8xrKvBkUtgOvyXJejfZxIC4y+2/2YESq6OKAJWavDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
	b=mWgap4e69eFWJfb+KZ8Ls2jb4N7JXJ4Sm6CQKUYHDAtgdylNaQgiuLpQwSq4Pz9LNm5S
	 OJMnhemDdgS7vQk9b1PpS+alfkr+st0VzfgwtgbiqFfxdwVy+3znxgNCjA3JOUFfYT2lm
	 GIXnY0BlHbJEvun5mLc9n7jD2I5zBxIXaCLZbPqup0s5OAE1qf8vsxXTLg6yDPQSDGX4u
	 UBC5Ll+oU1DcO4LlA9PeeLRhhmZHKEi2r65XAEclbuEcf9fpMwHpwMjaIFP0Z//wlgSDZ
	 mByxtqd7oT/pE27HFi8kazr3XbJoYHkYsGhOJA9lumsVMI6R9LdRWK3fap6WLjpMmQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NOYbjt4I;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B160E751B
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 19:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B12B160E751B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NOYbjt4I
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c9cfd8b1bso13620176d6.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793822208; x=1794427008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
        b=NOYbjt4Imc3+qorIumC+DRJZJAO0qhFz2+pHwAqi1zEfxbu5bWra1k03HlG+YF8OE0
         WKjfE/pOBFyetohPjOlWRIhA3mHsvRg3GEzx+kZNd85Tcw9pNYivl5EYC1NXy62tmniP
         gfHDnSvMNrT/1wmCWo8qKmeaA6avWngSwYmx+WOENThvjaf8vGgHAM8uDVShiGtqafNB
         dZi4T7vTdEPrAERrYO9q6y9kwI0R3aYEicWhk+Jpjlz0jrkNcq8bxHaiqcO0GVGivwc/
         nsafW92bbB7UgGLKxsQlYu14YFh/SmKKEmptiEwveqc9jy3+1WkRK+IFeCBabo6QyWsw
         eAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822208; x=1794427008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
        b=YyLtcFiTIQex4NJcfZhFuhRoQVSNviHKuCl/aGdrC7wiJRcoji2OasAyRnYhqqXdAA
         h0HoBQl7caZD+qaLKxr5t0qxJIIdsZGEY7ds8SQebPXCc4oi0INua85Y+FWTBwuRjv55
         suvHOTOXUOuraszom7EhKSPzY2qpYPqxQlNLjiSpGM89tCHpqe8daqQo4x8DF7WwFLYm
         MdRjtH5zwSF+El5VZYMzr0j7zbH5hpMdYjzibW2Y3sNsm7kVRPeTSFB1IuA6lkcoRyMr
         KgWedQJq7Lrr/W6/Y/JObZqDBP4ctok/6qFkBZkkefDuW+qievsmZtobUNLz0paxXaNe
         Z58A==
X-Forwarded-Encrypted: i=1; AKwUvBxAkWmzeBbDhfAae2WrZUhceGEdtn7iZ/sLHV0pHIW5MmJEQzYPxoPMYBYEulzdHBPDwRw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FROZWPvg6Mim4sf7mL5YUH7zk3wvd+WZapQo7z2MaTnZgLnFN
	ZhtyDpsOChEDS90I3y1k3Yd8p/hbqA4/XQsFo0Z8U3fYBt6Ckfg8/GEw2M2sXSgY4TQ=
X-Gm-Gg: AYBFou0uvk2ZGNyoc5FjixmeiU4NnPGdWGNGbz2qPr0QJRMLOSq4cbbqcvGPIXPHSQS
	deupCAu7FjJnz7Ya+cIYKkNXeFOjn8qX9CvjxE7m8r01ABBhQRiN3wKCzt+o9H86zymihjuZh/U
	bhMvA+xvxN8lL5DBogEEwoI0+RmopMuxTiaKoJMm8CaPNEWQuxsJMJpVYCsmEJ6dASGyevtS1nP
	SiEhz1TXGr2/VkDhh6OQhg9f0jzn+ceSy3vyCeZGdquyZkDJ3Dh3W2Wkg+2d5WoSv56LBPxdMHl
	3zokI8X7csgTkC1dkpHH+SW4RBtL94oMu8bj8lYg1MMKLeMqIbU4rFKtOBeXaJY+lvV2MsO1tW6
	y88SjaQCc6RZEQlmWtLJq6OxI0Bmd43hTCSctGhUl4xtEb16Jo2zuvN4l794bR4JMAjSBEu3SvI
	/7oa1Z3MsgqjrZx+y+5TPRMgvWE59YLzWShnDYPDkcOrS5DSDlra97D+Rfw/C0ST76jVNCfk3lq
	Vcruso7+AQx3j75cVDf2ibFaWUv0cL275JQSlfTrghQQ7F/2TK2z8MT2vPV7CkWSZr2XqA9ntj8
	6Y8L4FDBRaEeBMi5172x7v6Ud0axqSqMHY2nmHPnHHwUZ5W9//pErRVXHU78E6UoI7WADdGF12o
	nFFe8Pm927Q==
X-Received: by 2002:a05:6214:2dc2:b0:917:9cd8:f26f with SMTP id 6a1803df08f44-91ca4b1b1afmr281180966d6.25.1793822208495;
        Wed, 04 Nov 2026 11:56:48 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e7b1e92sm27199686d6.45.2026.11.04.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:56:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOh6F-0000000HJlF-1F1D;
	Wed, 04 Nov 2026 15:56:47 -0400
Date: Wed, 4 Nov 2026 15:56:47 -0400
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
Subject: Re: [PATCH v12 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261104195647.GD3889730@ziepe.ca>
References: <20261104084328.GP264423@unreal>
 <20261104171412.GA1247928@bhelgaas>
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
In-Reply-To: <20261104171412.GA1247928@bhelgaas>

On Wed, Nov 04, 2026 at 11:14:12AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 04, 2026 at 10:43:28AM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 03, 2026 at 05:37:42PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 03, 2026 at 10:29:39AM +0200, Leon Romanovsky wrote:
> > > > PCI P2PDMA applies Request and Completion Redirect throughout
> > > > both paths.  This misclassifies asymmetric and nested switches,
> > > > and reports one answer for every kind of TLP.
> > > > 
> > > > Three ACS controls act on TLP attributes the Requester chooses
> > > > rather than on the topology: Translation Blocking and Direct
> > > > Translated P2P act on a Request's Address Type, and Completion
> > > > Redirect skips Completions carrying Relaxed Ordering.
> > > > 
> > > > Evaluate each direction at the path divergence, decide every
> > > > class from the one walk, and treat a client with ATS enabled as
> > > > translating unless its driver declares per-mapping ATS.
> > > > 
> > > > This completes the P2PDMA side; dma-buf and mlx5 follow
> > > > separately.
> > > 
> > > Is there a one- or two-sentence explainer of why we want this?
> > > I'm thinking in terms of what Linus will want in the merge
> > > request: a fix for something that's broken or some new
> > > functionality.  It sounds like this is solving a problem, but I
> > > don't know enough to translate the nitty-gritty details to the
> > > higher-level user-visible problem or feature.
> > 
> > Not AI; these are my own words with grammar fixes from AI:
> > 
> > "The existing implementation of PCI peer-to-peer assumed that all
> > PCI TLPs were the same: ordered and carrying untranslated addresses.
> > It did not account for the variety of traffic types defined by the
> > PCI specification. As a result, only simple systems supported
> > peer-to-peer transfers in the upstream kernel; real-world systems
> > required out-of-tree patches and careful platform design.
> 
> Can we be any more specific?  E.g., what makes real-world systems
> different from simple ones?  What does careful platform design mean?
> Something about ordering beyond what PCIe requires?
> 
> ACS P2P Completion Redirect affects Relaxed Ordering (RO) Completions.
> Translation Blocking and Direct Translated P2P affect Requests with
> Translated addresses.
> 
> So I assume the existing P2P implementation breaks somehow when RO or
> Translated addresses are used?  How does it break?

Let me try, something short for Linus:

"Enhance detecting if the PCI fabric can support a peer to peer path
by evaluating the full bi-directional fabric path over each of the
three traffic type ACS controls. Expand the number of fabric
configurations where the P2P algorithm makes the correct determination
of support to include non-uniform ACS and situations where translated
takes different routes from untranslated."

Jason
