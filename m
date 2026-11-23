Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447536;
	b=hKJYi8I0+D5sBbQraG/4Z/M4eWvTgQxcRficZtZ8CEoq1VlSRZOwyVjMzlO0pvCs0RZn
	 7cwy9WZ3PJAHQ7Zz9KcMYhLDGtlQDsDFNUiElugr4mk7NO1bN9swMDKfWbGrliLaCDELM
	 EAIXpq7V2zkvGdvTlMOOWsFEkQzxMRHgggUrN2YpHZo5tiy5e2vPtUpoe2xcbE76JGm9i
	 LU8ifZF+wJLXL3PZlUpUvBUDbAYRgBbhrJfAKJ+6VyYRveQYJPAA2SfpRz6I1EZE+t+us
	 wCbO9zaQ9+9Km3gYhBaeIR9ZVihY05qrTvSAPsVnJQWPd58AyvTGbIvGUqNyD88UM/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uJeUtw5BXBG6B+iGuyb9j1OIKHpejrpTmDWG1agjBxs=;
	b=0nPWRD2rMuL1Cgul8ZOvtL+4ZTbnY86ioOn3ZQZ5KeRCZYaJUUl1GK6aCWD/ovDrN3EY
	 Wj6ffYvx10DCKTJBe80xLJplI0Al9n5NCyRSXBRrkGLtyQiMcqUPUsR7Dr+OansaQqNOq
	 RBaiomNiT7qaFAiulxyoMZM0g+G6aCXGYTEkhQVd1sFhKMriNbEcYgsagO9B4G6PYyDJZ
	 n1iMg42zRbjk9CMv66XJMEqx140rqua8Rb782lS9DYMY+WyBBFd8LavboXeILUC9lJ+TS
	 Ap8QGhN+naCEBf+0YmEcj3oLhLBdGwj9NyCnJPyOi5ie7hEiDxjE5YtFjXG8UjAtBTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=geoPWgr8;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA3606A68E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2BA3606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=geoPWgr8
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5366ae57896so36085991cf.3
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795447535; x=1796052335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJeUtw5BXBG6B+iGuyb9j1OIKHpejrpTmDWG1agjBxs=;
        b=geoPWgr8pjlKGEIIcx+8rA9w4a9tBfQSb+P6nZ0h8OI3kaSiBQooskyMLiAJ7nlLf3
         62PVhWMEdz5UigRXrToyzNc9e0u+Bnx9964Yqkk2CUTWiptoSuzymfa8TmInECK2oyjp
         2Y3pBgJpgKxlNC83kDnU9shnFHCC/chXWN7qFVTmPhxi397iv4CpiMsbnqHxSVtHcMb1
         x9KNCHsyDTvdT+iGfKlkD8pvhc6lRHiq2w3l4NpZgI2wTy5Rn0aX6pYfw8HVx3P87Sla
         8v4avs48PteoKsIj4PSk4s1imRhLqSsK394Oq1RM7vWNYz4iNmtSsFWQDB7FuAhiI77I
         0tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447535; x=1796052335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJeUtw5BXBG6B+iGuyb9j1OIKHpejrpTmDWG1agjBxs=;
        b=a8KJyuqLIe+8xXVy4wob6sH49XFee1qcpxMqyHUrkFoWGwY7pjJeNbQpnSaF0Roda3
         TF4jbXKp+rEQldffcPTqk8zE2X5ec4mAZFDt4P87cS+ojeZ2x9OAQGxvvp7O5V9LXvEk
         CFpc3Lbmq+cUHKXoMfmRiNpIXX6Q5gDAeE0VklrRVIVBLKmjqPcqbSPPjKCchAjo9qoE
         O+RxOkb1q0wEtIqOoOe6r9qqjfT0ORVXG14z6oXXdRTX8n6dAHwf17KiXNPVC2vGhvmg
         QT4zXiNcYx9SZUV6opoqgZO7uTeTigT5ONl0BEbGExaqXWGcuBDkA9oa8w1T1cDq0wRs
         U1FA==
X-Forwarded-Encrypted: i=1; AL+hErGl5L0SPflxQV3y/Ej1jKMTXxqLAyn8572Aixy51Vwg+DWJ6XoHyueBDXM1SPm+/xoY1JU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GP+EAKHEJ/EWGaNg7lkESpWnzLB7Tecy+bhIuKI9WQB3G9V9l
	SvJL1qn5av6O8f4xdMxltDK3y7vzykRQKKAy5zZSJeJ4HfJMXFENP5dr7F9dDOd2uN8=
X-Gm-Gg: AZFdTZfxPo5a9Gdp7BwfpQM0UZvcs9vn7RCpKZn8dPeqkH+PHirt4dlouhoYryXeTyX
	nE1wBrKGSODLd0n8puy4Cje/T9sDJU3t2IzaOvHGtEyNB6j4oU+qYgELm/nzpW8srAW630OhE8n
	r6xA/Naa29HmbOVbH0gIonZmCv9GKN1MLCTrV/v5+pjoAIJaaRT8BNGdlc6WfVjHkmrEQFRpILV
	8eoNowgu9Ejcs0ypkPVxCa5NrYAu+Nnky8WK5yWM6mDmX78vbgw4fdulemziqJcu3g4IYJZBDL+
	oOUqz8rNv8loYAtIf+srLaF5p3M9105Uqhmeln3OtVoDcs7bfXht9+zQsKhq3Xu6p4zjQOIJYWT
	NQDIgd04DhM1o5a8kbGqc+LuEUhqDYse8Ha2tquPJkq15y87763mJcIchqE1wVOh+1XNMxYAgY8
	lpNEO2zt9Z8voSlkHsP1+FJXQ78SWrD86TPQSZmedQBySHNU28bCnnNriO69XPXFjIboC4h0IqJ
	rkiFeGLZV3m43JEvT4z0ARapf1Ep5j4rDcAT70OwQh5m9XGAabBNbiuow5+P9JKbgQgkyI5GHlD
	JH8UCDGu/2vz0b51nE8wUNCWDtMMbTZtVhG6EF0k3B+7WxQ2bh2uURX9YBKFRs4358yYDTuSZQA
	b9Dk=
X-Received: by 2002:a05:622a:a881:b0:536:6f7d:1145 with SMTP id d75a77b69052e-55d76a27f9fmr215459771cf.21.1795447534734;
        Mon, 23 Nov 2026 07:25:34 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78807b5fsm100671031cf.6.2026.11.23.07.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:25:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVVvB-00000000sLi-2ANX;
	Mon, 23 Nov 2026 11:25:33 -0400
Date: Mon, 23 Nov 2026 11:25:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 00/10] PCI/TSM: Support guest TSM drivers
Message-ID: <20261123152533.GE179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <2026112325-emit-squeezing-5d96@gregkh>
 <20261123090623.GK14811@unreal>
 <yq5a7bi3riha.fsf@kernel.org>
 <20261123115803.GN14811@unreal>
 <yq5awlq3pto0.fsf@kernel.org>
 <20261123135638.GO14811@unreal>
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
In-Reply-To: <20261123135638.GO14811@unreal>

On Mon, Nov 23, 2026 at 03:56:38PM +0200, Leon Romanovsky wrote:
> > >> >> But it should not, as you are making driver core changes that will
> > >> >> mirror the same thing that that patchset is attempting to do.  Please
> > >> >> work together on this.
> > >> >
> > >> > +10000000,
> > >> >
> > >> > Greg,
> > >> >
> > >> > This series came as a surprise to me given the fact that device trust
> > >> > series is exactly for that - allow confidential computing.

Device trust's primary role in enabling confidential computing is to
give space for the userspace to do all the TSM and attestation stuff
to get the device into T=1 private DMA mode.

It is the userspace that does all this and the userspace bridges from
"I got the device into T=1 mode" to "Now it meets my userspace policy
to be trust level Full" and then finally "Now I can bind and start a
driver"

The two concepts work together, but they are not linked inside the
kernel.

> > >> > Adversarial is equal to the "cc_accepted".

I expect most policies would make "cc_accepted" as a full trust level,
but we do want to allow adversarial as an option too.

> > >> I think the confusion stems from this thread:
> > >> 
> > >> https://lore.kernel.org/all/yq5amrr8yldi.fsf@kernel.org
> > >> 
> > >> Based on that discussion, I understood TRUST and eligibility for private
> > >> DMA to be complementary attributes. Device acceptance determines whether
> > >> a device may access private memory, while trust determines whether the
> > >> core must enforce additional restrictions. 

Yes.

> > > Device trust does little beyond preventing driver binding and recording the
> > > trust decision in "struct device". The missing piece, which I would expect
> > > you to address, is ensuring that the IOMMU and private DMA are configured
> > > only after the trust level has been decided or as part of that decision,
> > > rather than beforehand, as they are today.

They are orthogonal and unrelated.

All the TDISP and T=1 DMA flow is about how the DMA API works and has
no direct impact on trust level. You can choose any trust level for a
device using T=1 DMA.

Getting the device into T=1 should influence how the userspace decides
to set the trust level, but it doesn't interact inside the kernel.

Aneesh has it right that these are orthogonal and unrelated
activities. There may be some confusion as Dan attempted to couple
them, but after discussion we have moved away from that since it
doesn't meet all the use cases.

> > What I am still trying to understand is how you view the DMA allocation
> > and mapping paths determining whether a device can access private
> > memory. Paths such as force_dma_unencrypted() and SWIOTLB receive a
> > struct device pointer and need to decide whether to use private memory
> > or shared buffers.

It is Nicolin's work here that needs to go before the TSM drivers:

https://lore.kernel.org/all/cover.1794343501.git.nicolinc@nvidia.com/

Because that is going in and starting to fix the DMA API to work with
T=1 DMA devices.

The TSM side should sit on top of that to enable it for PCI devices,
not just integrated devices.

I think for now lets just focus the TSM series on the attestation side
and we will tackle the PCI and DMA API issues as another series.

Jason
