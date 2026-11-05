Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909259;
	b=X3l/ATHqvAi/RJPpkwrmceJ0b8hkqwm0dImj1XCpUCAAbP1AH0n7ZtNsoR3MhBwQablv
	 Bhh9DcL4KU/lCXHleHj5MR45KU+IbR3HkcUSe9VtIgi4KGfEOuD03qgIMjJSggBM0paZC
	 Q6X/fq5qBjGjPjF32+xBVV02PPnQn+CEWVmnIspO2FEt+m34Onr6gb7iECMxoIpYr6URD
	 IR32zX8uyvGNzeDF+LjUINpOBQFSso1KOWdwEQyT0bcG/2QpbEGTTCpxWQD2f+fDtFOn5
	 99tblkfx0/2FwaQlPamTftc83z1fvH6Oj58IW01zZV2FfHkdmLpcaqM1mBFka+lgMZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=z52AWMMx/NPlxXG7BPdw5LHgxa12llcgL1Kha+Q5UfY=;
	b=coqDGyoZdPy0pJ5fPpCK+hjGIY+BzB7xvaeujGbw3yxafabgI6m51O4xmCx56cqBzIlB
	 hHBjoIzX4GcUmh7jNRuEicb0O+adcnQQfo8Jl2VsNNhIPyh2QkVEEwV0p4JNWmQ24IQKW
	 qvV7BP07jTe0w3F5Qt4zh/A41TKscHSFbawlkf7nGqjLo9ZeJ2KcDfnmi9xrQ81es325O
	 PzcozpMQTfpCawJSXuvSXh4J8L+FztxLEWT6A0t5oYLdVCMXSKtENEMoBvYAzpemM6oUf
	 GrAClPT32BkJL8ZGX66ENkXHp3WsrM5T2IjxoYpUJCSFAkvsbCIXovJFyyy4VclCPrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pWAcW2zD;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD3606EEBF
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 20:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2BD3606EEBF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pWAcW2zD
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1906795e0c.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 12:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793909257; x=1794514057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z52AWMMx/NPlxXG7BPdw5LHgxa12llcgL1Kha+Q5UfY=;
        b=pWAcW2zD/63HAANui/KgQteFGf23DIFTBPKN5TS2f+lZtRer2UXQWE5nmZ7E6+0NmL
         NOOCXte1XvmkZBJozDZeonddr7WOhKYwoxG0t/prTXufgqXucApuu46Sd4uUJbmVTObR
         7fBoftmI0x8C5OBoveyYTeiR5CzcpDKIDS2NqP2Zi4JYmMvse+F1UJ+tD5iRjIQbUeMi
         N0hs7feA4M3cPYsGIWBxIU+8M+cR5rQpjj7DVMZCRulJVbB4tHdrN+Gqsr/Umk190Esz
         gMQTgholi5MoO2YuumyOWyN+Vz/Zl26KLlq1hDXbDxh17QeLxWCQNp/kJGIw8NnG5ysp
         ISqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909257; x=1794514057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z52AWMMx/NPlxXG7BPdw5LHgxa12llcgL1Kha+Q5UfY=;
        b=EEOWO1vo9UpEeqJV7jwoyYkA3WIImR9DYxwDQfyA2CPq3bdr1w2rCaKEGYRnDJH/3l
         /6pgaoF5KA8lpifTYm4ZkrRN6k/su8QXYyEvUx8P2Z8mPpQP8bVpqogwme1tjbHmPdk9
         9qsDoTvXp8f8RO+08zWV78yWD1aV51xrGJN5kQAblvatDZmlPVPFoi+35IwSxNUGqoXN
         Jy07YIdla/IkN8c8LthaqE5OOKhQkg5be7nhRlqJInfhh5VT3xw7vlF3y5dghYWB2pgh
         aprkDt1G/FSdTlGXbeDSbSzZn9BHCMN8OO5WCx9A2HHyx3AGXzZ1mKf9DDCpxUUkSSSu
         n6gQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0rZ2xibRq+mJRvRgBAWiDfahjgnC15MGoU2OcIV5frZZPLeefPKZzj6ymZRk7i90oQv0=@vger.kernel.org
X-Gm-Message-State: APuU4Z96f6VdY8WTMfbQTQ4H6OM+/+mEkG0uT8Ej64mEuE8R0mXCO4x8
	66rQUvLaX10OLFbVsYombhv0sWp2jIB+za0fx559V2AA9WIDeV7mhbQ95LjtDD0MNl8=
X-Gm-Gg: AYBFou2bJS/6EsfTcRxMLzMfCWinr3X9lqiJc45glgDtyXnZx2louQDmRqyL0LZ/jk+
	jwRTk1mRaIynyAXwVCFzM+tfUsmn9Aj/+DsPDu8114rXI+TgDoLERR/B7UGTJoApsgMuNDQLpeX
	rQ+vFJR30iqvXYB0epUvb+xSe5gwacOHV/TtKmb7zDdpM5VpvPx/a1pTZ9BCnVBrXN+oLbwgv+p
	Cj10XKPMI67X+IcEPVvLWC0ROiVPF95ZMLoO8VuiA+0Y98LL/+YwcCaf5hH+nKFggsWal85XSkI
	cGXaJ1EaBGcY5LuZCEsChD021SKmTIO6jWQosrJ+QdHDD+D7H9ASMG6PwpqPyyzwEMH7AbF0pBz
	KetvmcOcIVkfsHq0CbnRLGo+JBFW8v4hP53Sn9yg4W/jCfRp3Hz6lD0wgmmpvEYVXxCfD5/VxBY
	1JxW8GajvQe168AD4oAJSGHWb13nhYtUzO98KV2pMUIhhMcLMF1+qijX05r7pZYBWsQaNt7jX/E
	FCgWyB9nXbVq5QFcoo07V51jqW7ED+DJwNIc97olt+DIFiXPmoAoOXuLgdxvjSoyF0Cg5A8f1V3
	kH9XVlO7cU3SH2ujA+Dus3/7ssLeGnWSk5vGpgVqykWO4xi33b9aNKsupAQ2vTEAhJPlgLNDN+G
	MrdgaX7aTZw==
X-Received: by 2002:a05:6102:390f:b0:7c3:99a3:314a with SMTP id ada2fe7eead31-7d2a1509e88mr658597137.9.1793909257584;
        Thu, 05 Nov 2026 12:07:37 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecb6d79d9fsm2610604e0c.7.2026.11.05.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:07:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP3kF-00000003dYX-3Q5c;
	Thu, 05 Nov 2026 16:07:35 -0400
Date: Thu, 5 Nov 2026 16:07:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Message-ID: <20261105200735.GF663069@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
 <20261104193139.GB3889730@ziepe.ca>
 <yq5afqxf97a1.fsf@kernel.org>
 <auzAivzpzSUHjEQj@nvidia.com>
 <20261105182106.GD663069@ziepe.ca>
 <auzNkAGFLH6da8fq@nvidia.com>
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
In-Reply-To: <auzNkAGFLH6da8fq@nvidia.com>

On Thu, Nov 05, 2026 at 10:40:16AM -0800, Nicolin Chen wrote:
> On Thu, Nov 05, 2026 at 02:21:06PM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 05, 2026 at 09:44:42AM -0800, Nicolin Chen wrote:
> > > On Thu, Nov 05, 2026 at 10:58:06AM +0530, Aneesh Kumar K.V wrote:
> > > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > > > On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> > > > >> By dropping the nesting parent from VIOMMU, it just simplifies the
> > > > >> attachment to an S1 paging hwpt, right?
> > > > >
> > > > > Yes.
> > > > >
> > > > > The VMM must always maintain a S1 paging attachment that is the
> > > > > identity map of the VM on all devices, same action as when there is no
> > > > > viommu.
> > > > >
> > > > 
> > > > I am currently creating an S2 paging attachment. This results in a
> > > > configuration with S1 disabled and S2 enabled, which is used by all
> > > > untrusted devices.
> > > 
> > > For validation, that would work. Yet "no viommu" should would be S1
> > > paging, i.e. hwpt allocated without IOMMU_HWPT_ALLOC_NEST_PARENT.
> > 
> > It doesn't matter, consistently using a single S2 for everything is
> > probably better..
> 
> Hmm, I am confused: if we use a nesting parent, why do we need to
> allow a viommu without a parent HWPT here?

It is because it doesn't *use* it. It is a confusing to pass in a hwpt
that is never used for anything.

Jason
