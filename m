Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CB497B78
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946398; cv=none; b=Faj/cWuPnJQqadouuUngFaud28xjZIjlrmGMUbtIhXhvB15W4izEWaondCf8ey79uwM7nAIJAKqquICn+vrJUOtk7izzieb7y2na7ETF9kKVrrw5Sfo//8DR9+XlSmXqox8v6Eql9E2ZavERHj9/IvmNhBXicJuNvGrTfK2D+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946398; c=relaxed/simple;
	bh=OxoSJ4srJKDimtpmkHPLj3pXrTAzJqY42lZbitdgufg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDzLG+2x06TxQXwmEKoUHdXfD5zzD3jHGm+6rgTbKe7EklH307C2NJAEhwhPq4chbbeDdPfR2TCmzlFkZd/DY75b8c0FE49CMCegB9DYYjxBZd0haETR+2Fd6YjrvYTKHElGCXaY/7RwTQn3bc8oM0u0VWgM0UWAyvQ5i5iD79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iiRmpk+h; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iiRmpk+h"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b590a5b5eso4663831eec.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790946384; x=1791551184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M1eeIXXEBO6PHS8yDF6wQU14zHl2iX5iGebTQR/5ZsM=;
        b=iiRmpk+h+mOQdgRR1Qx3gxCq5NYPDrLHrtFOivjoAf8RykAQn6gnLZyAN5NrqYklyD
         kBmZlPbIiNmSJc+cZC/u8Ik89bI5iKQ7lrmzAUlG/Szzi53t35jDWVfjjN8JXfWFyMg0
         gPGr7CZmjgfFNck3mRFhKjFoNmP+OhFJam5god7v+NRvz3yb5FU/rLfhI3HhhyVPIwQ7
         7X9LJr83MPILTdDxms7Zbyf/d/3R4zYUqlqEVFmuQikpL1RiDqalxxZm6Ibuo2RV7qTW
         ih/vzI6uZgRRCYiwegb58fetO+4v8vbvOEVwYVFC3IA+d5yfCMfnIdHgWpZLQWGZ+bIw
         Az+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790946384; x=1791551184;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1eeIXXEBO6PHS8yDF6wQU14zHl2iX5iGebTQR/5ZsM=;
        b=lmYLxWbtL8in/1gJFP0y0kxQTHmNEzDbrRK7nyySQWqCgh8VBZfdhGGU62bMh2VeOV
         L4HgKw29TUHAzbcacwt13mFqJky0z0X92hFY2P4vaehx5hsxxgAcFyBr2K6KWPSPhlX9
         nkGjICBc+Z6+GEJhFNRiD5ALy62UpN6ea0ESznP4tGnvahpnTLC9/IGhQ57xSpR96hrh
         jVEJWqtPmvsQXBaumAw/z+u4kSUA0hsqIEravgAKBn46GaZ5wELNL5lYHkV1NagoGct6
         /MAG6sihFUiDdCkcph0qGqP/bMbEUH5Hqs/5f1fNavoi0KmdEKrrTw43loyZXkQ/DwjB
         24pQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4jbep/Z6uWAzoHxDeekgEbYz+eOcnbnMkbf5D3cwU/Q1dSWBvpHDdumdvM+xvdXlRWUA=@vger.kernel.org
X-Gm-Message-State: AFuF++kXEz36TvAUGA0K3pl5zFcSW+1m9sJkOdF6EoG5x9b4K81tpkq4
	J4c4OcjTxhXc001OI3ijii5tieQ61jacH1bHyvZrujvwnWKMTw9cLq0kbY+Jq9G9Mwc=
X-Gm-Gg: AYBFou1AOUMOTis16eycY1UrWbGBtVLueEhPtG+hckudgTexo0G1XhzWYKbfk2bJZ9y
	tHHqFh9ZqZPJOB2NhZLisbOZswFN7715+eBIGWkCw6rylk/6wPqT8bVXm46M1v/asM06wyNklHJ
	21sRPUN5YseDlxyJidGP9vY8SJofWjl28SVVsA3RBcV9Suv2IpOCDSKRecV/7ZWW5/0s+Akc1n0
	RzONDBw4PDk/LlfEyFVu+dRwieqK/GBQyEj8V6tM8umRImQe+jV33wvZDJvjD6tKct31YN1QJ8P
	StQrbAAoMG49PlU+J42TGpcmsAENbSVAgLaouoCRHIIGPBAq3os/OD6xoo0RDjlibxo8hf+u7wy
	GI3JZUYkreBkGlDvHmkfwS1pBlEo6jln3FXeAEH8m6aN8m239XrESdTOk8ksv64WGjSWjPBgeup
	YMmEDVmQZlehBY0oPPvzQNWIU48ECQ1ptxZhvU2oK1jRs2
X-Received: by 2002:a05:7022:1587:b0:148:c6ec:13b3 with SMTP id a92af1059eb24-14f5b71069amr3573874c88.17.1790946384348;
        Fri, 02 Oct 2026 06:06:24 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f46da52aesm5332231c88.10.2026.10.02.06.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:06:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCcxy-0000000GZnx-1o1m;
	Fri, 02 Oct 2026 10:06:22 -0300
Date: Fri, 2 Oct 2026 10:06:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Sonang Patel <sonangp@nvidia.com>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts for
 vdevice providers
Message-ID: <20261002130622.GB3481470@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-12-aneesh.kumar@kernel.org>
 <arq2Ql3-q9EApe3X@sonangrm.nvidia.com>
 <20260928230834.GL163130@ziepe.ca>
 <yq5av77ktyrs.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5av77ktyrs.fsf@kernel.org>

On Fri, Oct 02, 2026 at 11:44:15AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Sep 29, 2026 at 12:17:30AM +0530, Sonang Patel wrote:
> >> On Thu, 17 Sep 2026 19:31:59 +0530, Aneesh Kumar K.V (Arm) wrote:
> >> > +		if (is_pci_tsm_pf0(pdev)) {
> >> > +			if (pci_tsm_disconnect(pdev))
> >> > +				pci_warn(pdev, "TSM connection is still in use\n");
> >> > +		} else {
> >> > +			tsm_remove(pdev->tsm);
> >> > +		}
> >> 
> >> What happens if the PCI device is removed (e.g. sysfs remove, surprise
> >> hot-unplug) while the vDEVICE/TDI still exists?
> >> Since removal cannot be refused, should the remove path still force
> >> the unbind/unlock?
> >
> > vfio prevents that. It currently will block the sysfs remove until
> > vfio is closed.
> 
> This came up during a Codex review of my patch set. The question is what
> happens if function 1 is assigned to the guest and function 0 is then
> removed through sysfs. Is that allowed? 

It can happen and I don't know we can do anything to prevent it.

> If so, it could be a problem because function 1 is not unbound and
> can continue to be used, while
> removing function 0 tears down DOE and IDE via:
> 
> 	pci_doe_destroy(dev);
> 	pci_ide_destroy(dev);

Ah, PCI sig keeps on giving..

The actual measurements are per function but the SPDM channel is per
device!

At least for RMM is this a problem? It looks like the spec handles
this case the function 0 destroys IDE and commands related to the
other functions will just start failing.

So I would expect the OS implementation here to have similar
properties that even though function 0 is gone the other functions
still 'work' in that they get the RMM defined failures for these
conditions.

Basically, this shouldn't result in a TSM hot unplug of function
1.. Trying to do multi-device operations is always a locking mess it
should be avoided.

Jason
