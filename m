Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30637DEB2
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300657; cv=none; b=LzeAnRvQaa54cxjFlCBFZO1X8lL2eJH5cGhEJq0g911/R3PmiLEItfWNu+w1N8YpLIjAYLfOBQgA5sVasmpr25C/4OybzK0i9kNyT6O1n4x5NLXTo/k283uDBK6+ALiM7dLC5S020naSG1VP+7uarjB6Ed9FrQrlD2zQzBsYfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300657; c=relaxed/simple;
	bh=Nm+VZTxnT9qw3EFPipXSMTWJ48lruE6BGIiYuVcKFcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVzgxTK+vnwixY4qZfr8+QJkgq1KZQN/M2PStmaq0mlX++qq7mRwkI+YbObRDpC8ASoqS/+OT1iae85pRrxa0UtDy2b9GCOfeSVLZ4h+KT82E70jAgnW6quR5jsnF8azSmlTMm5vc4r0IuX9wqgNZm1u3jw7RCXv8NWoQNOZpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c61Ts3gt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c61Ts3gt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b052562254so31235ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774300654; x=1774905454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=layxP6Fhjqp+wTdLPHecG2YnZ/zXdi50jvGwdG06cGQ=;
        b=c61Ts3gtnAu2t8de0j/2MHv47QAf3V13VebXbfJUAPH5K3XURZ78ssAjKFXT8Nfmy2
         0mZEEHXSue843jJI6wvzx91Qb0h/Zp76fnnGQe6RGqMgtgN6FtdSdHIiJvdqaoT8v90l
         QLDxscz2EUyHHQD5GOTQfp3Jdx/j9t5+hX1CSvlzI9CwzdDRULDPoZI5uQzI6/XGHIsw
         NzoMy9tyCFj5qZCtyt2eT0zS0XkC7yYTpuGu18whr0DrU3ay60Tn6B5bASEcBio/bpMh
         bZyLmVmWY2S4xZbC0sMxqFEr9zw9/N2hc54x9LbFwmEJDg+G7NityR8NKzOy2hrqxYwM
         2RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774300654; x=1774905454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=layxP6Fhjqp+wTdLPHecG2YnZ/zXdi50jvGwdG06cGQ=;
        b=ocJG2BX5vbcalJbsS4bjX3AzENmPX7vx3BsskmtXurgmCtcLFpByIxLBZeueUlOzqj
         fULAdJ+5Sx7j7jExTcH90FYANKeIr1GueP44hC/nw3X7xrKW2E/y4iIQaEt9CUzni18v
         N0FXcJhz17npAYwRvadNvL01cCGq8xm5wOIpF830adICRlcaesJmCwDDyHpxj7anJDtI
         jN4z4BnQquG8eAU2bHEy4XDuva1bnDQPQgwglhjIuhAEUVFPegt31s73vELY9BDGAp4r
         LMgs4XWaW9/o10e1U7EsysPEqrl27OIxxbrn/m/FcVsm2Vjd9bHQvICQd5/MYkTz7KA1
         hXbw==
X-Forwarded-Encrypted: i=1; AJvYcCWzSyikv1S8yLVteVD/yr4+4Nyn78e0ffrJf7+47cBAwgTBeygPqL/dFy46ch6ofEAHd9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTN9QIJcc+sTRBCK10zvPHGUJxEQPhsE/iiQKA4fedE7VsJkpT
	ln9e8S4kEraZcTukkApR/cDgykMIrhp8LpnLbuGMFSU0cuJ7MwwLxcvd/0APtOSn/A==
X-Gm-Gg: ATEYQzwyFlUuskCGHpWjsAdfTEfErvlwTcjGXqxKbzATUaJhhv2oC0IOpMYaW7vSi9a
	GtoVKx6MhmgC6K2ESR0UEkL4QN4Ydnh+leSSbNUz29w+RgF+WSVVf9kvykirKoAAsOrGpXOwZTM
	s6CrqI+rBmVcEeEenR/rcGc036PIantwh+YtjTkD6aFv4Yo1h4gxbd2wYD/YnyCM2xtMl3ClEga
	zOSy/EenpDM/yq5Q2gB6f77xIZJvnHcctHVEXwGSMoXc9dK3ikLI37vz+ijqZhqFnXHt21cJu2r
	6mlUgcY2qVwKbdPQFSk1QOV/zKlU7Nq3iDwnsBOYaGdMTv3hI8F/qfMXIlFmOWWEpx9oSBcZpqQ
	osEydbnOhkky/ARLJq21pJGyWvAkZ+YIoRKhqnpHtAhzqHLY+7PMJbl0UF95gV6GNwHW89d5EQ7
	O38EoAmTtbdroBRLSZ2FOH/yp7yqCECfXC2DnzwWVNV86EMa8Ji72FFsB6bw==
X-Received: by 2002:a17:902:c943:b0:2a9:5bfa:54ef with SMTP id d9443c01a7336-2b0a540776emr966405ad.10.1774300654128;
        Mon, 23 Mar 2026 14:17:34 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76565c35desm1829840a12.15.2026.03.23.14.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:17:33 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:17:29 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 13/14] vfio/pci: Preserve the iommufd state of the vfio
 cdev
Message-ID: <20260323210111.GB2571566.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-14-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-14-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:47PM +0000, Samiullah Khawaja wrote:
> If the vfio cdev is attached to an iommufd, preserve the state of the
> attached iommufd also. Basically preserve the iommu state of the device
> and also the attached domain. The token returned by the preservation API
> will be used to restore/rebind to the iommufd state after liveupdate.

Lets add token when it is used in restore/rebind patches in future.

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -49,15 +51,32 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	if (vfio_pci_is_intel_display(pdev))
>  		return -EINVAL;
>  
> +#if CONFIG_IOMMU_LIVEUPDATE
> +	/* If iommufd is attached, preserve the underlying domain */
> +	if (device->iommufd_attached) {
> +		int err = iommufd_device_preserve(args->session,
> +						  device->iommufd_device,
> +						  &token);
> +		if (err < 0)
> +			return err;
> +	}
> +#endif
> +
>  	ser = kho_alloc_preserve(sizeof(*ser));
> -	if (IS_ERR(ser))
> +	if (IS_ERR(ser)) {
> +		if (device->iommufd_attached)
> +			iommufd_device_unpreserve(args->session,
> +						  device->iommufd_device, token);
> +
>  		return PTR_ERR(ser);
> +	}

driver/vfio/pci/iommufd.c has all of the code which interacts with
iommufd in VFIO, I think we should follow the convention and add a
function there which can be called from here.

> diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
> +/**
> + * struct vfio_iommufd_ser - Serialized state of the attached iommufd.
> + *
> + * @token: The token of the bound iommufd state.
> + */
> +struct vfio_iommufd_ser {
> +	u32 token;

This is u32, whereas the token above is u64.


