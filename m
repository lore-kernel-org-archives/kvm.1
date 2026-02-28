Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B33B3BE2
	for <kvm@vger.kernel.org>; Sat, 28 Feb 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772303348; cv=none; b=dycjDh37XF7Zq0UP5ITEE/OtaJIs1hb4zWM45xRGxponpMwDGmw7bHJYxiDN+TnneVOPW5Y9z+kxmQ7bySmxOUEAuVf1/QBRPbPWRjAEeJ9eZBKKN8kj5zBsKZ5yaSD1HH2hb9Yr6Mb7BA2/6pyiRgYC2HTyFaml9tI9FMLOkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772303348; c=relaxed/simple;
	bh=rkzmltbCB7oYdQAHuLM1PEc4LQu8jhDMt38DwB5M/W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgu+z5OMp8WSQC387CfYbrwyJ3uLXoYkWY6watTJiLF++8oVxn9oaReDD2U2i5H4XloZG7IkwK6/bVo9lPS5MpORVIoHASYixGa1sgPZRHN4VqiRxo1xo42IgOPiol946eV2SVP5fOtVlxk85U3aTXPzfRDrYW9uDXIvD1g4zkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K00HouUK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K00HouUK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-896f9397ecdso37663876d6.3
        for <kvm@vger.kernel.org>; Sat, 28 Feb 2026 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772303346; x=1772908146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htHav7RfCL20FBhzRA0W1wS3HhKQenwSmiA0/DmxMnY=;
        b=K00HouUKZsJ6yofhTGJ0y/OJayrg2Rsbz/GeTxPCJWzmcZsFElp0hZ7EKb+Rn/Qvv4
         wR+PylfQBXK+AxGiU3Z59C80ZvmbSqGS6YsTSwanJhY78/jhBPUdb/mUAGl0cMpD+cxD
         WegdScwcg4S/V0UJDNFYNF1oVir02y0RqUHhurykjNSgjrQNTYyGgGcPJahJibb7BoIh
         hKqYM6jmiKxNBaCKkiE+uwgFGb9wll501tkQmwTIlaBNtCIgkQgAz79/nXfOV0T6Na2W
         eO2WBVU+ql4+Iqbib8RKBVi4jsEWODNOaZCMxdyuV4ed9G/yOduHEtrOXqjCMDPDa7R7
         NuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772303346; x=1772908146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htHav7RfCL20FBhzRA0W1wS3HhKQenwSmiA0/DmxMnY=;
        b=ELMIYt01nwmz3RYtBdyNFUiD6him5Uc6Z8jMyFU0Fx6YuAl3Lq6BbGI4Qd0T05iXkR
         85O6UNucHppnsXSFEjRTrxupUcF12kea2mjtgWP2NuQ8DskwFD0VCrTE/EQmjFFZPoPC
         WR/d6Hi3Te252R1GNLIa7V+9YA4aMog0cWJJ8qXCmA8lnrXzreNLnF4gZvLkvBn/l8Z3
         hl2xFNo9G6xghBfV2d08jrulu+6bsnMxz+ULwrcmKWEnhPdt9m5RpfvXDHoRRCVFWOfQ
         99qzjZ6DUd2Dv5BefbVBgBxqmX4sT6C4ogsRpFL/KL1x/sy3n+9Ypl7OyCWjR9eSAk2g
         EF0g==
X-Forwarded-Encrypted: i=1; AJvYcCX8tKU4gD77ynThtptdzgnaAacOmez/65npBdE46OCxlXJhUBeR5qv7u1PoK17AsHYNl/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzinyQChrYZV6KuGEeFNEg6zVysgpncT7gkup+emjP8605V9Kp6
	TWs30tULYvtUGyr2LO6DG1BiIYxB30iu9Jtl/mA+ow36k/Hzx8fF+GyglNIgyi8i0q0=
X-Gm-Gg: ATEYQzzUMokuA2sBGWx1wThIzXlLfQkO/XM5Fr2lLPnluCjSb5seO9e07O7Rs53zo9j
	9dQT7HJfCb3e+bccXt0v2IhSue23upv/XUKjiMzisDFrYq3afrBNm0hlzIiH3/+kMKuE2U96rup
	lgilVp4hoAHylYuFJYzq/W8EvzyaR5TXtV3vp3H7ajdjOrcobc/VmI5DCHHVz7R5A7dNFskjlr1
	rV9Ah34Cokamf0fHMUeypVf2ViPf/xHpd5Tjueo9MF0qLB2tUHerglp9jx15H8Wf/OcXmmy1Oi/
	w1dh1eGfgykE8qEMEdbxzR2eIWONcOgPQWETobpEDrKdh2BMyqxFRXD/8IkrHMnwtPStb2AwnCo
	IRSl8JpqwTfi+KmXUwAdcjanMhWTBQhc5/rv+jH3s/1cXzcydDyC351ULgHmKE9fR6onBEUaGfe
	hR9bslJdFC9X4DlthEsaPDk+PQdtQL2tnVSgjlziryjaAUpD2H17RO4UQA1UFWFc9DGJZ4IbgyS
	Y+6WW8c
X-Received: by 2002:a05:6214:1943:b0:896:fe42:e8a0 with SMTP id 6a1803df08f44-899d1e8b1camr101368936d6.63.1772303346029;
        Sat, 28 Feb 2026 10:29:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7376847sm71654726d6.28.2026.02.28.10.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:29:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vwP3o-0000000250x-2vIE;
	Sat, 28 Feb 2026 14:29:04 -0400
Date: Sat, 28 Feb 2026 14:29:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	"Pratik R . Sampat" <prsampat@amd.com>,
	Fuad Tabba <tabba@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	michael.roth@amd.com, vannapurve@google.com
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
Message-ID: <20260228182904.GR44359@ziepe.ca>
References: <aZ7-tTpobKiCFT5L@google.com>
 <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>
 <20260226190757.GA44359@ziepe.ca>
 <aaDL8tYrVCWlQg79@google.com>
 <20260227002105.GC44359@ziepe.ca>
 <aaDlRdnhIqRXEbPZ@google.com>
 <20260227010902.GE44359@ziepe.ca>
 <aaFzgGTpZI0eZWdD@yilunxu-OptiPlex-7050>
 <20260227131815.GG44359@ziepe.ca>
 <aaJroUzTZXZfbRAl@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaJroUzTZXZfbRAl@yilunxu-OptiPlex-7050>

On Sat, Feb 28, 2026 at 12:14:25PM +0800, Xu Yilun wrote:
> On Fri, Feb 27, 2026 at 09:18:15AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 27, 2026 at 06:35:44PM +0800, Xu Yilun wrote:
> > 
> > > Will cause host machine check and host restart, same as host CPU
> > > accessing encrypted memory. Intel TDX has no lower level privilege
> > > protection table so the wrong accessing will actually impact the
> > > memory encryption engine.
> > 
> > Blah, of course it does.
> > 
> > So Intel needs a two step synchronization to wipe the IOPTEs before
> > any shared private conversions and restore the right ones after.
> 
> Mainly about shared IOPTE (for both T=0 table & T=1 table): "unmap
> before conversion to private" & "map after conversion to shared"
> 
> I see there are already some consideration in QEMU to support in-place
> conversion + shared passthrough [*], using uptr, but seems that's
> exactly what you are objecting to

There is some ugly stuff in qemu trying to make this work with VFIO..

> Further more, I think "unmap shared IOPTE before conversion to private"
> may be the only concern to ensure kernel safety, other steps could be
> fully left to userspace. Hope the downgrading from "remap" to
> "invalidate" simplifies the notification.

Maybe, but there is still the large issue of how to deal with
fragmenting the mapping and breaking/re-consolidating huge pages,
which is not trivial..

To really make this work well we may need iommufd to actively mirror
the guestmemfd into IOPTEs and dynamically track changes.

I will think about it..

Jason
