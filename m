Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599978;
	b=yN4RdiNvilhDUZj86YQuTYEQYd34jIlXBZFnN5D9WfTWuehVsqSdkyPdq0zn54xuxg48
	 dQVnqgmgKgf9ewnJXnvtCv1qgo/jJ7DiwZMlhYiUvHkyrb8UVDTHYGuS6X4boFymZC1Q9
	 Kkz3obALExgKwGt+ZdvQ3epTNZdsW1qe+tzTqW8vTCqcFFkCHOrn58n5Tfjyz6v3nL+xL
	 nABbyOXUbH4f52EFkvDYSmbonJ9KTm2eM6GoxNTXZ39A8qVXSOenNvcdyfaYye9eUiywn
	 hy/5ardXnGLihsMEvR2mWUuPF5qpvFUcBgqn1Fj4tih/VvHhfeEkWaJ242iK34Lx8dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZZ2nZZ3s6y7qol6GLZvqI4xyT/lOQ3RMsv1KGP5S3jA=;
	b=n5NtF25ZBBZN5B+OrTl0JsjjhiMwgEl/ZopzQ/bY4vv3xl0Kqu6hhY4vxuS1KB3lCLHQ
	 Z1GXI/xgextJ4iqd+V5YQG9XGAkBm2rACGlDvb5X/k2/eFSRrF01NxAoza4glDX1sjZeu
	 OWSYW02g2Ma8HyrLWU0KUdXqPTLygpBvwW+tULJbREsFx1QJLFDTY0fwodlHW3Z28ZVXH
	 1429+euZ61Ty86aBcElmYRYRan9yB69dyfuWIaN9SHuLkZAkAW75Y6bpWZWF6DB2Sr37M
	 8PkNc6wWklpzoq6o/SUJ0c1BF+5w5YXQJ8XidJZp02OQ1HD8DNPoGauKBhkmkvlpntw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Po3n9AZ5;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCDF606B55B
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 19:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DCDF606B55B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Po3n9AZ5
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91f30ff609eso6418706d6.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794599977; x=1795204777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZ2nZZ3s6y7qol6GLZvqI4xyT/lOQ3RMsv1KGP5S3jA=;
        b=Po3n9AZ5ukCVtyxupRbbfrpLGYxngRljlMmr6URQx5mXBtNOQmayJr515hpgVNj4sx
         SfBF8u0oI8BRgh0FyosgUvP4tKwELgo4ewaKIi5JN8mRtCuCRmvkGWXjuAw/02iadmRA
         uDnxdZ7AXUvdkY1hWsdsHvfshz1nH6EsEpR5OkjhwJvolkOQui9lyzTw24vhAEBxWDRt
         KI1J+fFxELXn2bRApiz8FOoEpAjp37dDgQtZRNcDqm1xmiXUP7jrvFn6TT9BHVcob1x2
         umNuZjQRMa9C79LylxXf/Ma826OY9RYwk2x+s7ONJ5FVSABT6CpUk/vzeFrO9xuYf9Ln
         k9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599977; x=1795204777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZ2nZZ3s6y7qol6GLZvqI4xyT/lOQ3RMsv1KGP5S3jA=;
        b=w2cqRk9TVvjE1BDg2HP1IaG/esIvmrgVD/x61mJ9DbfTEXOFUY/tbZa3lLisp1IKRV
         iT2InnYg4mGyudLe2Azt1vYSdtkZmn+83fxqvWQeknvdyMXRPOAwEDGTOrcScHevEaJQ
         /b+s/FBpJKHodeNRj8juMfYbUMSD3ZhIDfCNZaeTBZ0b3/PhAz5LflO5eGkzd9lw/F+u
         i4bpNFwgDiUlofmde6SHa6hwsTrccjfODPe8HmoGEMQ5s4fjIpGlFLes8danffD+6eCH
         J6cl1syYGlISHo5RUfn1rny1lq12Bc2r/qJXSXW4h1yZFdLyK56b3Yq2NV4FzNBx90Pe
         ySHg==
X-Forwarded-Encrypted: i=1; AL+hErG40yFWiVqKmgeh34pSUvuHyVBCIH+/2BpMDin97cKLLK39KI7Aeklh0nyDE/jV+wtJnfY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9X3ca/kvBfc4DMFqnrgL6uzyhdJ/s6C3cKoi20wyyZWkoFGHMS
	YgxYPiuHScZ+davLs1KZcEmy1/R2SaAyv7hrYUsr2RZZMaD+UNH1qUnpVW8bWsdHPpA=
X-Gm-Gg: AYBFou2MJettsubKDE7jckeHI4p0f9oN1h1FbNlbJoDWzODGHeQeEq/+YB2Gk2d0bDC
	a+iNkAJpTExa6M0HGems4IIccCusUXTmYR0LsJgUBq8SBK9oSu3DAv9V9ox0lEQKBoE2RmCv+bQ
	fm6J7me3ePYxUmm6Y0RzLWfevZ86mhhfpeURkqJ+J2P5++0m8Sk2sbto6QAJNNr7JrfmknNGd0j
	B00djY/4IVsV6EznoupWTMpvoxTHW10DMkBNu9oEBKbHLPJ6CzOcvY5dELx2lHBEzwrDvwyQtuC
	EQvqcvLk09mGdsiTe5kVzP+fb55VDBQRLZCa5azIZMu858OMScyO57EC2QDiiaqyZKhpijhn2HN
	5A72EJnGDqBxUYgBcQkIedj3jB5cLDdsMBryOPAS8c2RtlAhvh18wqAWJQ8t6rrRJ6EeMLlKfAn
	HgIBgEMA0oCz9pvqzKlaZ8bwNro7e+fi6vugpTp8OEhzLIv8uHQG9t7qojd/cFcuI5HEa5+6HsP
	Bp/SSPh2qaCD8PwmqFjxEp+enJ3Pi/5brNM4T24zUS2p3OrSPI9Ba2uxNP+lOzWX6cZSEykE+XT
	hnuCoQ==
X-Received: by 2002:a05:6214:451e:b0:91e:8d6d:21c8 with SMTP id 6a1803df08f44-91f2423e922mr59090456d6.54.1794599976764;
        Fri, 13 Nov 2026 11:59:36 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db49c5sm27322246d6.41.2026.11.13.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:59:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xRxQs-00000001ekG-3813;
	Fri, 13 Nov 2026 15:59:34 -0400
Date: Fri, 13 Nov 2026 15:59:34 -0400
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
Subject: Re: [PATCH v13 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261113195934.GD2532299@ziepe.ca>
References: <20261111121602.GQ8635@unreal>
 <20261111224136.GA754433@bhelgaas>
 <20261112092326.GU8635@unreal>
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
In-Reply-To: <20261112092326.GU8635@unreal>

On Thu, Nov 12, 2026 at 11:23:26AM +0200, Leon Romanovsky wrote:

> > I guess one benefit of this series is that a path where P2P Completion
> > Redirect is set used to mean that pci_p2pdma_map_type() would return
> > PCI_P2PDMA_MAP_NOT_SUPPORTED (unless the RC was allow-listed), and now
> > it might return PCI_P2PDMA_MAP_BUS_ADDR because if P2P Request
> > Redirect is clear, Requests can be routed directly?
> 
> I'm not sure the first part (return PCI_P2PDMA_MAP_NOT_SUPPORTED) is correct,
> since callers have so far ensured that P2P is supported before calling this
> function. The second part is correct.
> 
> > 
> > That sounds great as long as the Request uses Relaxed Ordering, so the
> > Completion won't be affected by P2P Completion Redirect.  But devices
> > aren't *required* to use RO even if enabled, and I'm doubtful that a
> > non-RO Completion redirected to the RC is going to work.  So I don't
> > understand how p2pdma.c can guarantee safety.
> > 
> > Translated Requests seems similar -- are we assuming that if ACS
> > Direct Translated P2P is set and ATS Enable is set, the device
> > *always* generates Translated Requests?
> 
> PCI spec allows "A Function is permitted to intermix translated
> and untranslated requests" and p2p doesn't decide anything except
> if routing is possible or not.

Both of these are basically the question we left open in the
discussion with Christian.

To use this new TLP specific API correctly the initiator needs to tell
the API what kinds of TLPs it intends to generate, and ask if that set
is OK.

So you need to say 'I will use translated, I will use RO, I will use
untranslated' because each of them can have different routing.

NOT_SUPPORTED has to be returned if the modes the driver asks for
don't have identical routing.

I forget how this ended up when that got deferred, but that missing
driver input is an important part of the puzzle.

eg mlx5 knows exactly which of the three TLPs it is going to generate.

Jason
