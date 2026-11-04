Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820701;
	b=zT1TRbGf/1cEOSaiygk2EhMlZtp3itgYX6mVW0/+tyM3hGhxxpAT2B+FIRAtRMkPNHc9
	 HEntChymPiEhhaRX/h9Pr+o+cVVNEbzPwaPPRFPbXxPoGPcM7QompSREruDrIp6g1kUhF
	 Mi4xbAuKgvs7/ZN+2ZUJE0FNBslFcZKygm/qLIiUH/Osx4SBspDQJ/GkjLHWXaIe5yCYC
	 m3IAhyLPkerUf8DhmHT3LvYgkm5HhloJMUER8QCULBsf7phiPY+QNou0tMXHAZ3d6wMrq
	 DXZmHzZwo47pMpjF5PeMZsoSYze3bt79gbuRht9e8Ie3rQSoFijoIM+bB07ad1TBtVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U6VmJzWY8/ktSu1tEfSH85YFZcsMq7VS8KWsZUWMCkc=;
	b=OXVihc2rY3PnoIcIMuLZWL9SFTBPucuCkuIr2mQRsGfPaS+ATCbvhyM8w0cU/V9/lR2x
	 EL7xYPcAHvrvpHz11MOLZGQzl68iWndCQMOBlMpJbgSDyl9SGdfIVgtiW9dmegdQuEo/K
	 KoRST1JSUt6NA2HsQh127PqOx2p91BwN9/9waKomsQ09CwLxl7tBtc0O4cFdjhprg7TZb
	 pefv+UDYwrKwbSU0qrUMA4Z/Y+nrEX9ewxQ1c1cgLSTfiGDJDQKUXsN7DTd6GcOHCD7oi
	 KuMpWWVxL1Xn1lmy6nwxwFGuAKlrIJRI1U2ypFap2HsD+KodBJMYSGWL61b4vrm0gow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2856078162
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 19:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2856078162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e515769d3so105058685a.3
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793820700; x=1794425500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U6VmJzWY8/ktSu1tEfSH85YFZcsMq7VS8KWsZUWMCkc=;
        b=EZcf2wTkD+DUBFkK4Kf7IDSujj65CxJ1zv9d2f8p3SG06gtvsT0t+m2FBEKwTaLbdx
         FjlAU/gzIVFzN48oCK0JegUU3l6CcBvJYreTY8FfKEqN+7xSbQMxUyxTzpJuRNInWtNX
         bU34dNFsk1Hz4MbrSLbWANgqJFVMh3fjtT+PhutTYP31XcpWwodufBHzJysUUvDTjzjm
         z2wlWgpMF/QNFWFWE7mx8gDC6FV//vyjLuAhsthVQBtJiTVxhVJTyMJrETbYVwJRAVJH
         vpeGwkg4fYdDVWnxGdeXV6ybzqiM6icctzpK30WFh0sYTH5osJ07n+0FWdDxwzHibYfd
         YaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820700; x=1794425500;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6VmJzWY8/ktSu1tEfSH85YFZcsMq7VS8KWsZUWMCkc=;
        b=yEzbZkAzR6qy5q+1z4zwmOpcX4DUWf/hooT3wiOhcJcOU0pdk0LMuyL3oSBYKyrnnI
         A5HgkgyGMpMRb3H1KO2PEYw/gCrj6eKX7TDv1RlMisVlSOmNHrmcOlxt6d7oxHlrOtwz
         1DtOfTb41T0sWMBpXwtYoIErb1WXonQzYv+WwLmTYyekVBWNUGGf8Gn0BXVCJqy+UN6h
         BcMxMSxIswCGkMHqn70vWCkAEWuN4aLykHg1ID8IKQi6k2Ay/50W/vXv9KkzWao0WkPt
         zmjgktVs0l7SWxVJObFKa4XXXmNv7fH7Vryixw6sYQv7zaZi1hX8JgxnrgMnfPJVIKJU
         6pKw==
X-Forwarded-Encrypted: i=1; AKwUvByfOxXG602Jfxl5ce69TLyz7LDZDNVpsW/SwWj4qRyTMxsdHoCc+sD949Ixjtwu11hE8Cs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ww6tIUDXEPQ3ZeLLXbTLKOjeNfAVbDa9ewMUzwuzqz4AEbc+V
	g4NxIPvm+dvPDprv+OwLNdpa3RWPfVWBDSb/ca3kbEQ4R3DDqNZbJfMdKWJRrzDqgGQ=
X-Gm-Gg: AYBFou33l9uqMlTUXXOsnwPnIGMHJw9I/FfASUDcfu4JjNowvq2KVnuMpMppMNgKtZp
	C0tFMn9/h0LW3yBaN4ARGqE0oCl/S9tz9hK1tNJKPGGnuWVYf/IxztdEaMIr0ZGePYxQeWwBT9C
	9RUKbIUb0MI54Y9iohtbgy69+bfhw+ix/8hruwQp/1r/GctcePG1lh/+bZQvYdV4YPcb9R11NG4
	bvO+Z7bRNqRlooYFRDPuhRQnRdb4IQKErbdIHszNdcKhIMI52O/aSPPg0v/PnCOSAK5aqi8Uhi8
	0yvcByUdIFbZIzxmwJ3bQnevXxzU8xdUSKSMh9+Z9Tb+1t3na0YcVAnNWxBjiUm4kX75R70aOLf
	ziR4si9TUROfnVRWwUir0e/aR/WxQCl5pnicsb4qxN2YNJ6CPBj2T2bWSZz9VsWfs6pQrOA0zXe
	QGy6s0FEQ3vlEfHxpXknh90qjz0LFvNGL8ENi7RfG/qH4+k6vXBI4WAivj8j4ImvIvy1Az4wNMm
	7/MPaWnxRwPUuO3YUpypkVgAnQt5AVxx4eDZqNqlDMWgs/inSVEwF97a8BT2Upnw3581A4wc5Qj
	gYAZj9pCH1VAti1xtDlc5AQxBvn9RJyc2MnJAIqArKvyzEXpRUR6b8+4ixOiKuI9OW+Eig/3K9w
	WzJvXQVEx+w==
X-Received: by 2002:a05:620a:1a24:b0:93c:6534:d04d with SMTP id af79cd13be357-9442167725emr2767779185a.35.1793820700269;
        Wed, 04 Nov 2026 11:31:40 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4844991sm278199585a.28.2026.11.04.11.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:31:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOghv-0000000HG9b-0zIw;
	Wed, 04 Nov 2026 15:31:39 -0400
Date: Wed, 4 Nov 2026 15:31:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
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
Message-ID: <20261104193139.GB3889730@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
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
In-Reply-To: <auuBjRjQwXl7UvvO@nvidia.com>

On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> On Wed, Nov 04, 2026 at 09:46:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > VIOMMU_ALLOC currently requires a nesting parent HWPT_PAGING even when
> > the selected vIOMMU implementation has no use for one. This would force
> > implementations such as the following Arm Realm vIOMMU to create an
> > unused parent.
> 
> IIRC, MSI on ARM still goes through the NS pathway. So, it wouldn't
> be "unused" if the device attaches to it (or its nested hwpts)?

It is unused by the RMM VIOMMU. I think that is what is Aneesh is
explaining.

> By dropping the nesting parent from VIOMMU, it just simplifies the
> attachment to an S1 paging hwpt, right?

Yes.

The VMM must always maintain a S1 paging attachment that is the
identity map of the VM on all devices, same action as when there is no
viommu.

Jason
