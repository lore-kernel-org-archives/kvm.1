Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697641;
	b=01CVnS56dDq10COc0vKXlb9Ds673z2Oe6t1lUi5EWNVAA1lS1Z628O5Qo/V/bS0xMPKl
	 Jjgzf9s2pHNESAviVTuz4AT4zFDKeqUEhHVavvMN9vWqG+ZuRi+CgxwP6mnMo48BA2wqH
	 7SNYTLzlwctupUURSjPBZHXJiw9siCTPq1aovrxRBxfAWNTleG3PiTbzl+gvHIWwDGc2P
	 w1CxFC6kkX1R5Q+sdH+v4qqOLw9y9leYWG/580AxHtJRG/1cgmEfjNzoCh6i4S2SIOEUH
	 WTWm00X6KC4cduu1NUZCaWbtNwbTa1ofxEdzqiJtPoFOr6oRlLJCOcWsqiA3jGMAtXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1WFg6Cm2FvST/tWX04Ds4MFu/JJiRPf7HeaSO2EoRtU=;
	b=5nq1uaA0Q1Opym1N/hkwXcMbSFRq9ff7+zLZTq+GTY771S747YN6qsf1zzGdY+CYxQw5
	 hnR2wf/8DPwK37OsySfrWqukVtUFrGeLeUtiutYlFfkpaZm54kkhVmi1qIav8qdkD8Xaa
	 VkCngsQlMMSBSIII1Vo6BzFsXhrTKO8+m06ManXcMI76hLYyNB6QKJFeydFvBEMs20lvA
	 VTTfcIdbUH8Ws86cHTnPpTL4eSrXmlw5vnnCVGjPF0LSV1K3u7gqi9g2k8NGISQKvfzNb
	 O28HzeHgXwBrtuTkEASJvRYKg6ilcurK2XcgJc9vGfAFbx/GeArdv+qv7qAj4LyS6wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QFEORPwo;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BC606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 19:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 411BC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QFEORPwo
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-534e6545939so635481cf.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792697640; x=1793302440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1WFg6Cm2FvST/tWX04Ds4MFu/JJiRPf7HeaSO2EoRtU=;
        b=QFEORPwoUEIZuJ6NMDraZpk/wRs4MPUQ6+p+re/ljnQxioxyGas4xfpR0cT5ehG81a
         UQFccCXpSFwMD1Bd21MdjG4x3bc3qNLfvbJjpYtUNp/PD48xYJ3Ur5tL//4MRckupdD1
         tCgAmbOtfk0zHxdZ2BNwjy7HoKdmvcKdu43eoST/zJ0Ro2QHszrudTbcDUNQCBxlU8VQ
         9rcNc3BL7PbRQjlXvp3L4JL+FBDowJGHfPUuJm5zfR3+ZwU3Wrh/UZ+ogfxNuZqK9sGN
         IPAT0Dc9Qy5pM1n8P3okX6HGQmPNVznIkfOfBbsTbXsT5a0VhuO365oKBEZoNsDFjHI8
         3iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697640; x=1793302440;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WFg6Cm2FvST/tWX04Ds4MFu/JJiRPf7HeaSO2EoRtU=;
        b=IqBIer5kCd/jBDNxJfZgvYhhvFHzU1ZCjAWnvz3mVCjNJ2vqYMMuQpsaQ78Y99X6df
         MF2MAPEjw4Dzfl+XLBCplHp3MnCP69c0iKMKgSrm9EOco624Ya8prHzQk5scU8HsHreL
         LDVoTbeFEQlLcajJAXvnfEZR3vxgY1GLHYq39fsTuW2H7RGiT1qyaJC3zOMcDapoPnt2
         EsZyacUUsvkWxK8t/wmPWFd3R1rJfQSr2zow7Qbp05//+Nekgb8uCkJIL4d3RjvDxlJh
         4VvvBs6zqt3rTaBixqheA0Nue35jWC9p4zbOXKQAKwL3nhGS+95dbYTB8u8ARzccHDQ9
         7xQA==
X-Forwarded-Encrypted: i=1; AKwUvBzJfvcnWVq6oWeFd2Xw9j+bkqXSAfd6b1A8BZROiia4Fh2IAF8UcaNVDg06/4tfAi2ZL3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrZwknL6o4e+eyceeet10pk8LzM8nS0etn1v4r2OJjDgEFnqvE
	MUvhVkX0cwWhpJzf05aPxM6vEgXj/4sUa1Av27MXG8Rv41rfOGm2kzkvs97OLu6bgx4=
X-Gm-Gg: AYBFou245VCL3mz8TaCaY9fvGtlunSl++4RAP8u0G/jg7UqSAJ2nGgx0OG9PjcwD1pd
	yMVQI4N6DRU7RhMb+zJj9adMZVjdJ785w0Z5N8TCSHSnscmcweAG+g1SunpMJGwsl2/IJsxkxkA
	DJ2YTsmVtaKDxtzpLlxBE4Nsm9Q+pXEy3RPpNYMe2a1BJTeKGgLQsqcJpTN9igne95h2J27jpA9
	4OKSMdyUDogYKsJql7H++MESTvhGdA90juM+bfNZK26e7oHfkY2Mj45xwvSNg/tn8uh/vWxAJ1Z
	+lF2QZjF/7awKj0qoVdLmh/n+h77cZeIYed/VfnaGqYW2SIxunu3U9ELLckse2LIq2mPTvcobzO
	kofD4wpnFu0omG48g8ZUxqlB8U7paKf/sC9JYrlK0iz7Ah3jMmcy8AAi6NEhgCW5AxvGOHu/DK/
	5YtSWq0pYGPL1YpXPmLVksILl9CmknY8wvAxdnRn8CDnZSSCQ8Xbddt2GFjAnMg0JbqoQPyebbX
	NRlzy4jP+Xi3IlrombHmim4su2GRSFINLKKVrxBl0268d/3Uc8R6zbHpJInc5s7DfR5JQCukIkp
	maSR09/LCNGyuyaRgOTDXPBKliwVzrAaCHWDuw==
X-Received: by 2002:ac8:5cc1:0:b0:535:a5fa:ee0d with SMTP id d75a77b69052e-5369bb95d51mr93655331cf.77.1792697640024;
        Thu, 22 Oct 2026 12:34:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396e8d07sm449806d6.22.2026.10.22.12.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:33:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJyY3-0000000FmMC-02vs;
	Thu, 22 Oct 2026 16:33:59 -0300
Date: Thu, 22 Oct 2026 16:33:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: alex@shazbot.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v3 2/2] iommufd: Add IOMMU_GET_PCI_MMIO_WINDOWS ioctl
Message-ID: <20261022193359.GF3381610@ziepe.ca>
References: <20260921115513.GK11599@ziepe.ca>
 <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
 <20261004162213.3787623-3-guanghuifeng@linux.alibaba.com>
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
In-Reply-To: <20261004162213.3787623-3-guanghuifeng@linux.alibaba.com>

On Mon, Oct 05, 2026 at 12:22:13AM +0800, Guanghui Feng wrote:
> +/**
> + * struct iommu_pci_mmio_window - a PCI host bridge MMIO window
> + * @start: First PCI bus address of the window
> + * @last: Inclusive last PCI bus address of the window
> + *
> + * A memory window claimed by the PCI host bridge that a device sits
> + * behind.  Addresses are PCI bus addresses (i.e. what appears in the
> + * TLP), which differ from CPU physical addresses on platforms where the
> + * host bridge applies an address translation offset.  For a device
> + * using an identity (1:1) IOVA layout the IOVA equals the bus address,
> + * so these are the IOVAs that a PCIe switch could misinterpret as
> + * peer-to-peer DMA and route to the wrong device instead of memory.

iommufd has no way to use devices that are not 1:1, don't talk about
this stuff in the kdocs.

> +/**
> + * struct iommu_pci_mmio_windows - ioctl(IOMMU_GET_PCI_MMIO_WINDOWS)
> + * @size: sizeof(struct iommu_pci_mmio_windows)
> + * @flags: Must be 0
> + * @dev_id: The device bound to iommufd to query
> + * @num_windows: Input/output number of MMIO windows
> + * @windows: Pointer to the output array of struct iommu_pci_mmio_window
> + *
> + * Query the memory windows of the PCI host bridge that @dev_id sits
> + * behind.  This is advisory: the kernel does not reserve these ranges, it
> + * only reports them so userspace can choose to keep its IOVA allocations
> + * away from them and avoid accidental peer-to-peer DMA routing.  The
> + * reported windows are pessimistic (the whole host bridge window, not the
> + * precise BAR ranges that may actually conflict).  If a IOAS has devices
> + * behind multiple host bridges, query each device and take the union.

State clearly in the kdoc if the list is strictly non-overlapping, or
the list can have overlapping ranges. It makes a big difference to how
userspace has to process things.

> + * On input num_windows is the length of the windows array.  On output it
> + * is the total number of windows.  The ioctl will return -EMSGSIZE and set
> + * num_windows to the required value if num_windows is too small.  In this
> + * case the caller should allocate a larger output array and re-issue the
> + * ioctl.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if @dev_id is not a PCI device,
> + * -ENOENT if @dev_id is invalid, -EMSGSIZE if the output array is too
> + * small.
> + */
> +struct iommu_pci_mmio_windows {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 num_windows;
> +	__aligned_u64 windows;

IIRC out_windows is the convention in iommufd

Jason
