Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB03DE43F
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426849; cv=none; b=NOkcIfTjRW9Dx0h9gtbI+Dc7x63+iB3EkorNe8WC5V8JaD50bwcltukygaONY3MOzbqIH8Xs7dQZYjUBptZwqz7+ZwyvVo3sBSqNmm71Yh2W/1X+B1Whb5MwUB8rJeJZxJotLPZyD86z6dA2BcCeOz+h7nT8ehcBWhkO0KmA31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426849; c=relaxed/simple;
	bh=ixTPhrH4yxjOjUAI1IZHEE8s/TP9E8YXfjx9uEw6cE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY8D5ncMuTOBoxBbeoneLluPSXdShoAXLoQRp1uypZkUWdaHF6607v8As0S6dbz6VHbGnW8IGouaMKUeEsY0nroa2XUg6rJe62V4N5sHe4v+8ORNcyqb8L2Qjyep7eFYfezFETy3fctyqnqvwn65EU6ETBP1kOIJm0Awx4LGufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W1BS4Y4u; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W1BS4Y4u"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so21962016d6.1
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773426845; x=1774031645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETmpjYkPNXw5/q7d3Ssx+upItrwKqh5NDijfiDruMZ0=;
        b=W1BS4Y4usm3MhXYBIdMTvkN20uyGnXFihYRk7vUYEPr39PILxWoikUnB3leV1gZ4w5
         ELAIib1kh4za7wl3w/E73V5r7E5ktl97Dlrk3yL0u1NBCoxNjtCppezHdF0pmVIDmE5Z
         m6qbWVH+Mxbv6wB9EtoUtcW6//nYzF8eOIvi72VjMjfasTD6Nisc+gve2x+CLALgCqmW
         TXgFtGYpkl941962Mh5sTqWg8fZlIfxaba5RYJWKUm3hYEGh3PkHHVa5gsv12oizAmAE
         0zy7bnIXsxykIn/nPWJop+NsVGmkkJzcanezN1g3HpewKjl92+PnyhtHuk2HH7wX51XU
         DEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426845; x=1774031645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETmpjYkPNXw5/q7d3Ssx+upItrwKqh5NDijfiDruMZ0=;
        b=EVMlcFA6Lvw1ut98t0xmVSI2Ha56EbxEwdwG+PXt+C+x8S1wzNloEHLMAnTZLyNvxs
         x/ClHy6iteRrTG5mVdy4RBRROgNIh+klISQpLK97yQ027W1gbWX3HMcpHKpQ7OaBVLS+
         ChPIiCQ6qMfB9yUaq6caOLx4d+LYOeGWnHxhiswGbxaE57QM3Vopr7YHpJqr4YndYJFb
         ZXGv+KRAV/zU1Q0cpxjLeMIicAc7He+6M351hu873WOYPMnpQOeXVSVscmGv9G6HSxkA
         NMkpekgiZmIlZE7qAZEb3NpDtfLS5zqqvI+rOEZ/rbZ5j6zANqcoqOrWVV7OsRebsgi9
         vCQg==
X-Forwarded-Encrypted: i=1; AJvYcCUA8OE5T9ORisfzLJcYzwgdenM1dR48mGKsf1J3i5qOlVmgsVQFj5hjO8CjbSMouWA89+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcoedMZ0yAp4IALMon58POx4/jDZMqz9A72EOPr3+V9V1wUxoe
	r8an/pIKTv7hH7KhvYu1bWrYc5XXdXnaUCDAhKOFRz3BK0zDaaeQmgdFOhSc34OjxCI=
X-Gm-Gg: ATEYQzxrUxpIj5W5neHrIpEBHiv5+2cQDprt/r+O28Ay2k6PP5ckQoSR5UuZ6flrXH5
	Ez7CNGzB48PCODsB4zGut/5DrwQtD9+PxvvlS1SB/ipUuP43+T5eCUwxkeaMMU8fc2AAAnqOkMY
	2/BSBXtL9KTAUmVM/3W18k0hNQjMFdK4Zcioc7v5272213eMBmjoWaYoSh9Bcu9FVW9gWBZWnpq
	ZpotBJfv6njg06uwiQ52SNo5rybY5mDvZNsev0LErZa1pG6YU7IU9PvPjVMc8ITFDPQhUBjTInR
	kjsiSWkYLvDK0hOvhFcSJni65zdwwEsYTWpAPIOK2/dv9eX581862Whyd/eSOEtW45bdzpWrCa0
	4twqxLow2+QH0aisrCahlbvURRhlY3acsd8jH/5IinQ+E6gBHljaITujbuDSkutUohPMzXJIqLZ
	e+/Gan4e27B6aJpVYHJO+HLUOeJ+HekfsbpWinYnT1MjbymulmAwOnJGX8X69DmjvyQit3HkxcM
	23btMeH
X-Received: by 2002:a05:6214:5010:b0:89a:502:6060 with SMTP id 6a1803df08f44-89a81d4cb1fmr61055306d6.25.1773426844964;
        Fri, 13 Mar 2026 11:34:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d0289dsm58661806d6.40.2026.03.13.11.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:34:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17Kl-00000007Lsf-2UJ3;
	Fri, 13 Mar 2026 15:34:03 -0300
Date: Fri, 13 Mar 2026 15:34:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd
 with a vIOMMU
Message-ID: <20260313183403.GL1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-2-aneesh.kumar@kernel.org>
 <abOrdFR4L2n334MR@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abOrdFR4L2n334MR@Asurada-Nvidia>

On Thu, Mar 12, 2026 at 11:15:16PM -0700, Nicolin Chen wrote:
> On Mon, Mar 09, 2026 at 04:47:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > Add optional KVM association to IOMMU_VIOMMU_ALLOC by introducing
> > IOMMU_VIOMMU_KVM_FD and iommu_viommu_alloc::kvm_vm_fd.
> > 
> > When the flag is set, iommufd validates that kvm_vm_fd refers to a KVM
> > VM file and stores a referenced struct file in the vIOMMU object, so
> > later iommufd operations can safely resolve the owning VM.
> > 
> > This is preparatory plumbing for subsequent patches that bind TDI state
> > to the associated KVM VM.
> > 
> > The patch also switch file_is_kvm from EXPORT_SYMBOL_FOR_KVM_INTERNAL to
> > EXPORT_SYMBOL_GPL so that iommu module can use that.
> 
> struct vfio_device has the kvm pointer already. So, I think it
> could be forwarded from VFIO side v.s. via userspace ioctl.
> 
> Shammer had two patches before and Jason partially reviewed. I
> took those for a side project but haven't sent anywhere. Would
> you please check if they for you?
> 
> https://github.com/nicolinc/iommufd/commits/wip/viommu_kvm

That looks pretty reasonable

Raises the point we should not allow mixing kvm pointers, so no matter
what the vfio, idev, viommu all need to agree, and the code should
check that too, eg when associating an idev with a viommu

Jason
