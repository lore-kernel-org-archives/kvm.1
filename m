Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF840DFCC
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107618; cv=none; b=AKBiWqLpwrWYiiJhdPTCLqzsoD7kmoBk1RVNROJ9DuU9XlPj+jteFJQJKeWl2PReBboAzFBU3BMU4XvClMwB7y1qkHVsFTUjpX/AccaIUvU1fm9EIFtalOjkV/tWOOEXqJTr+772vhPt5G+2znRh3+kVh/cy7fak+IAFR1RZpmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107618; c=relaxed/simple;
	bh=eteect+ff8liDAlqaZm03mOtwH8hF75AgpasHuA6duE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW0OQmJfWTxFUSFcSF7MqcdJ8x7lp+oAowWcAlhtHV1CywaHst+KS1hPEHRFoBxowUqmfDdRuTzLVaWEOOetM3/AG1Kqyuhuw/EMw6EDuOMAFJOJYa9LlJ5/ctqngdh3PswoMg2KzyxXR3NTGf7NQS+pbdE40GJDY08NJyZMFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdGEa0Ek; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdGEa0Ek"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-515548f390fso1371cf.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779107616; x=1779712416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEg290J1ykCPkYwv69V6a2ExyDDaRGL6kITmZSq7l38=;
        b=HdGEa0EkjLEBR9qsQjmnI2773aUKWIaPWI9cMMb5zq1/1VAp6XaS93mYm9aQQVFMc6
         LEMl120z/GUEeZQ0Ju2L+txSCUaOvhH7X7j+JscuUnJyiwoKQvH9LeXI/NE9Fs/2aIVI
         x5gwkoOYv2/jLvAzyigAsQ1POk7328ziZZjZ6j2vGuqbBHklzG/J8qXz2/jChRcHyqow
         yZFruqGgu6prx5OXdv7or8EXMd6DBdSwWItEkHHn8Rs4AYrQf4PR9e/mMW5bLSmWZtLR
         CtcBlH2VRiHeLBP7coGtjRSVVj/7gVwkyxVcmH3sHwc/BAOs3oHd/2Rb/sMuMK0w7iG7
         8S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107616; x=1779712416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEg290J1ykCPkYwv69V6a2ExyDDaRGL6kITmZSq7l38=;
        b=KSPvfJ7wLovn8hiWVPWS1yXb73XHAf6G1HQGmN6Bq/mKWayj1IeQNNwne6fFWoSURZ
         yCQwdNjg0cekqSB/IxbzuNT19jeXL/NLA8hqTUpAUaJlKNKKix+JIGwj7jArQvWzhKWY
         YwhwD2LQ+ms7p3uO+Yd93kY014d+3Ol02C22mtBHXYmxAyagamlN/SIfK7/30y+83WGn
         T8jZTA6WmAwcY2mMPHoXJeF6ImyKDmVA8yarbWCiGaMcHld1YzY5uBNRPOr2bGb1ZyvX
         hby1JkMv2WAfJ5Ox4Q3Pt6F9PcbSsCkQy4+zyj2/xTPPO2eBs5S/QveM5QZTenXusj6d
         TUsA==
X-Forwarded-Encrypted: i=1; AFNElJ/DupMmr27b76PitIogqpavKjTW9Yte5iyDQ/HO5wXOndZrObmS+nuzMsbYoLLoxec/D6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGdRb+ikXvB63erQF6cejb//5yIkQ9y01bTZ2eXtaKmIobxInu
	IrZtOT8yFSq1uP2iF2OIZXWPoOk0qnDuXcTSLTKVnCaCoEGALrJC4DH/N05EjaOTUQ==
X-Gm-Gg: Acq92OHIYX4nvVUwYh9uutcVrB8V87+WKQpJGmEihhgE1yMT/uRS3W55+1UrUxenXbz
	FGLTGWoQ2LM3r380XkLrG+C+/RAyvfo+UDiIyuN52RvJEWRyAh5ESWUv7IlCl4tWdC9OMuzOwaa
	nFX1pDp7x5wfX+QW1TL7r3FDMjMz+eCCrS8k7sH6htTnIjtXVJJPz7rGVZ0+2LDhWjh9EsCgNFR
	0Et9oRnFzTPKeNCs8iM5o2n3q9hjwLZMM5xVX8CwhpJIV29FOa+DKacaW8Vi945hMYg6Oc90TKY
	RTlYF8xynzLB1xfxSB0kpvY3RHj9PNqonPbZ2nC1eTehQp2wj1ku3De2Yv+O5pYTHNc5/+D2AS1
	4LOHPLRfWJIYjcPJdAKAsnKjTFahL+Pa5upYX/7TDs/khJSXGA05RRpCSyE2E5PBkFf7nzyH6WG
	SraHm380UgFklnCfDiKqhISqHdpPCMua/m+c7ZksNhnWngY1YzpKyAXCtJal3Fla+cGm5b
X-Received: by 2002:a05:622a:8c0e:b0:516:3b3c:1df2 with SMTP id d75a77b69052e-5167945fee9mr12767131cf.14.1779107615481;
        Mon, 18 May 2026 05:33:35 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6cd4f5sm20692257b3.35.2026.05.18.05.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:33:35 -0700 (PDT)
Date: Mon, 18 May 2026 12:33:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <agsHFbI_FQEXiZAA@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afUe71D8JfgmA0BG@google.com>

On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
> On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
> > Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
> > alloc/free helper functions to allocate memory for the IOMMU Live update
> > FLB object and the serialization structs for device, domain and iommu.
> > 
> > During retrieve, walk through the preserved obj array headers and
> > restore each folio. Also recreate the FLB obj.
> > 
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> 
> > +static void *iommu_liveupdate_restore_array(u64 array_phys)
> > +{
> > +	struct iommu_array_hdr_ser *array_hdr;
> > +	void *vaddr = array_phys ? phys_to_virt(array_phys) : NULL;
> > +
> > +	while (array_phys) {
> > +		/*
> > +		 * Failure to restore preserved IOMMU state is considered fatal.
> > +		 *
> > +		 * This is because the IOMMU translations for preserved IOMMUs
> > +		 * were kept enabled in the previous kernel and the preserved
> > +		 * devices have their IOMMU domains still present. Not being
> > +		 * able to restore means that the memory mapped into preserved
> > +		 * domains might be already corrupted by the preserved devices.
> > +		 *
> > +		 * There is no way to confirm the integrity of the memory that
> > +		 * was mapped. BUG_ON is the safest option at this point.
> > +		 */
> > +		BUG_ON(!kho_restore_folio(array_phys));
> > +		array_hdr = phys_to_virt(array_phys);
> > +		array_phys = array_hdr->next_array_phys;
> > +	}
> > +
> > +	return vaddr;
> > +}
> 
> > +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
> > +{
> > +	struct iommu_flb_obj *obj;
> > +	struct iommu_flb_ser *ser;
> > +
> > +	obj = kzalloc_obj(*obj, GFP_KERNEL);
> > +	if (!obj)
> > +		return -ENOMEM;
> 
> Should this be considered fatal for the same reason
> iommu_liveupdate_restore_array() is considered fatal? If anything in
> iommu_liveupdate_flb_retrieve() fails then the risk of corruption as
> described in iommu_liveupdate_restore_array() is possible.
> 

Righ... Nice catch. I suppose we should BUG_ON() this because
luo_flb_file_finish_one [1] returns void. Thus, if we return -ENOMEM
here all we get is a WARN_ON without panic.

We can't statically allocate obj in liveupdate_flb_op_args because obj
is a void ptr. I believe we must add a BUG_ON() here.

> > +
> > +	/* Data must be present and valid from the previous kernel */
> > +	BUG_ON(!kho_restore_folio(argp->data));
> > +
> > +	mutex_init(&obj->lock);
> > +	ser = phys_to_virt(argp->data);
> > +	obj->ser = ser;
> > +
> > +	obj->curr_domain_array = iommu_liveupdate_restore_array(ser->iommu_domain_array_phys);
> > +	obj->curr_device_array = iommu_liveupdate_restore_array(ser->device_array_phys);
> > +	obj->curr_iommu_array = iommu_liveupdate_restore_array(ser->iommu_array_phys);
> > +	argp->obj = obj;
> > +	return 0;
> > +}

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc3/source/kernel/liveupdate/luo_flb.c#L208
