Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3D386C3D
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308476; cv=none; b=EHx8PvCBbEmz2sMsMxSE1FmFPihyAJ3RovGLwSYjvnjECIdztD3l3PYaqvofGliAlUI/C7o1QDLMFxRNgpvIdKhMagsJvA9VOewttC/c17n2IiE+iOPhq1g+nBj6tDLaHO5C4UGLGFggnayzGiWmp5QuPO34Ah1s/WggjcK/vfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308476; c=relaxed/simple;
	bh=xyTAlm/nDzLtoICM+Sme2HT8wUexULM0SnT44f8iKLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSyCvwm1c0eHZXOsrMHjuNKA0wQ8fg81RE3/xvT7Y/IpTU9IIKVagqDawLUykUrBiaeNUZhOc6ZcjHCadkQkcpyavi2BQ4MApOiE5xFxytupxxQwTHdGuTuOqxIokjlnFCFJWIg9dMaAPgneI0Tt+FqmER3hTY7L30woiHzkEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0luZFFD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0luZFFD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b052562254so39865ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 16:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774308475; x=1774913275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ooi+h3bcAW5zP8MJCZDzVnX7Ev9079/RsplLPW5OVU=;
        b=t0luZFFDLyuIF/agrfFZ4v18UP/MUMmW8j7Mza+Nkr8oIvG044Jad114TblPWYzuEg
         BMuaqDj1QhKKRVBeXldC/fA3wfAH710Gn/XxJAVxHJgTWgL0LcrTfbY6CqKajT6E8heF
         yER4m/cZ608px8+yMRiMnU+oGuUxAc+FA0fQw9eQRqAtHiUZjf9iP0/6O8TnA9sKpAIw
         XEhsWeDY8psPbew41qtXhlv12ewuUdRhb0x1X+eWo9G55wDOnddH6jmWiewrL6Kk7T+V
         7p5ROhvDaYglxX2g8b4VK/0IXDYa66mKrRVTRR5Mta2+V+9CH2PxGWkOMRgbnMS3BryE
         cwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774308475; x=1774913275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ooi+h3bcAW5zP8MJCZDzVnX7Ev9079/RsplLPW5OVU=;
        b=oyf5iQe1HepJ/Iuw+m3DTzBf8dIBqKQAZSoKwpFH9rotBJtj50jMjFrOPmMHNl1V9Y
         zF23/TlnyFSfCnFQI9WIp6nk2o/chAj4f/FG++TjgDGTboYI66r69A0aoSOjNd4YiX6V
         6mSQiV+BWbg3O/gw4q+FiDrRERQEGvHn7sYGHnPhuK7n7Daz8+tUfLtxbOwOrK9/FIAS
         PU4YgMO3Z/hMCDRDsvdC5Atr7DtjevFvNiKTnUSrr7kqL8KrO871XeArfmfj2nB/V7ur
         6JzCt70TAw7qIPasU2nzMl0xiRL73YeSGUDXEeCiSDmbZqOqK7/3WnlpBZepUDb4OmO6
         D/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXYE89OqqM43PqjT/NMXz8IF/sAz1i+CoSOMh7xnn5Vw/XamHs8KV7SV3c2ro1ePF0WiCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAsFvlX83lU2YJn82ePFVUVAdh7ak0uAz5px/DYpXjf+bufp3N
	j0FkyADVFNKdnBf0NTKKukWk1A+j7pAEmhi5ylnj+sdE2L9JWGJF0rlKrtSRR2B0pdlNLyozG7J
	IuSaSyZQ+
X-Gm-Gg: ATEYQzzX87A6m97iHJV4i6XtCTdDaH0hpSVHg041KSigaNLNhZChJlaK5PaH08Zzy9W
	SCL84PEY6aaD1nVqvu//35K4MNJWRmgzGnjUwD966tCd5cS7aXK2AD1T2BZO1VDCM4dGPJbQALl
	EYwAG1uC/52Zc5pk2+Ls+VGZYwh3kWVGDbehpax18TygvePnRlM5q+Tx7ON0H1sk/+x8VnXkj6I
	HKNUuUMtxF4Mifn22QpAgiv5Lony4i+nTf+sUpPdumEEVmisNxh2dDgqhRHCEn0rvdm6lJUA0D5
	cb+5KKzrGqDcMmH/kW5wzf+CFSoHtT+7a5qUUz3mONLcBT1LxgLFdZkRGVNICwDJmcA2VoTYptc
	9gupxcv2k1IdlZiEcBz6yQiThbOB5K9G4P90Q5gjCwRllpb4liruvGYg4Du+grps8PEDSWN75dc
	23e3NSzcQqN2I9pD2TOaSnkanpln1CJz73wAcjJNAJ76syYH4YFUf0dqAFDQ==
X-Received: by 2002:a17:902:da89:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2b0a5404e00mr1421495ad.4.1774308473977;
        Mon, 23 Mar 2026 16:27:53 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516cb9sm125384965ad.2.2026.03.23.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:27:53 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:27:48 -0700
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
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <20260323223639.GD2571566.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
 <20260316165018.GA1768676.vipinsh@google.com>
 <abidn8EGmi88wpCr@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abidn8EGmi88wpCr@google.com>

On Tue, Mar 17, 2026 at 01:06:34AM +0000, Samiullah Khawaja wrote:
> On Mon, Mar 16, 2026 at 03:54:50PM -0700, Vipin Sharma wrote:
> > On Tue, Feb 03, 2026 at 10:09:35PM +0000, Samiullah Khawaja wrote:
> > > +config IOMMU_LIVEUPDATE
> > > +	bool "IOMMU live update state preservation support"
> > > +	depends on LIVEUPDATE && IOMMUFD
> > > +	help
> > > +	  Enable support for preserving IOMMU state across a kexec live update.
> > > +
> > > +	  This allows devices managed by iommufd to maintain their DMA mappings
> > > +	  during kexec base kernel update.
> > > +
> > > +	  If unsure, say N.
> > > +
> > 
> > Do we need a separate config? Can't we just use CONFIG_LIVEUPDATE?
> 
> We have a separate CONFIG here so that the phase 1/2 split for iommu
> preservation doesn't break the vfio preservation. See following
> discussion in the RFCv2:
> 
> https://lore.kernel.org/all/aYEpHBYxlQxhXrwl@google.com/

Sounds good. 

> > > +static void iommu_liveupdate_free_objs(u64 next, bool incoming)
> > > +{
> > > +	struct iommu_objs_ser *objs;
> > > +
> > > +	while (next) {
> > > +		objs = __va(next);
> > > +		next = objs->next_objs;
> > > +
> > > +		if (!incoming)
> > > +			kho_unpreserve_free(objs);
> > > +		else
> > > +			folio_put(virt_to_folio(objs));
> > > +	}
> > > +}
> > 
> > Instead of passing boolean, and calling with different arguments, I
> > think it will be simpler to just have two functions
> > 
> > - iommu_liveupdate_unpreserve()
> > - iommu_liveupdate_folio_put()
> 
> This is a helper function to free the serialized state without
> duplicating multiple checks for various type of state (iommu,
> iommu_domain and devices).
> 
> Do you think maybe I should add these two functions and make it call the
> helper?

Read the next response.

> > 
> > > +
> > > +static void iommu_liveupdate_flb_free(struct iommu_lu_flb_obj *obj)
> > > +{
> > > +	if (obj->iommu_domains)
> > > +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, false);
> > > +
> > > +	if (obj->devices)
> > > +		iommu_liveupdate_free_objs(obj->ser->devices_phys, false);
> > > +
> > > +	if (obj->iommus)
> > > +		iommu_liveupdate_free_objs(obj->ser->iommus_phys, false);
> > > +
> > > +	kho_unpreserve_free(obj->ser);
> > > +	kfree(obj);
> > > +}
> > > +
> > > +static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
> > > +{
> > > +	struct iommu_lu_flb_obj *obj;
> > > +	struct iommu_lu_flb_ser *ser;
> > > +	void *mem;
> > > +
> > > +	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
> > > +	if (!obj)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_init(&obj->lock);
> > > +	mem = kho_alloc_preserve(sizeof(*ser));
> > > +	if (IS_ERR(mem))
> > > +		goto err_free;
> > > +
> > > +	ser = mem;
> > > +	obj->ser = ser;
> > > +
> > > +	mem = kho_alloc_preserve(PAGE_SIZE);
> > > +	if (IS_ERR(mem))
> > > +		goto err_free;
> > > +
> > > +	obj->iommu_domains = mem;
> > > +	ser->iommu_domains_phys = virt_to_phys(obj->iommu_domains);
> > > +
> > > +	mem = kho_alloc_preserve(PAGE_SIZE);
> > > +	if (IS_ERR(mem))
> > > +		goto err_free;
> > > +
> > > +	obj->devices = mem;
> > > +	ser->devices_phys = virt_to_phys(obj->devices);
> > > +
> > > +	mem = kho_alloc_preserve(PAGE_SIZE);
> > > +	if (IS_ERR(mem))
> > > +		goto err_free;
> > > +
> > > +	obj->iommus = mem;
> > > +	ser->iommus_phys = virt_to_phys(obj->iommus);
> > > +
> > > +	argp->obj = obj;
> > > +	argp->data = virt_to_phys(ser);
> > > +	return 0;
> > > +
> > > +err_free:
> > > +	iommu_liveupdate_flb_free(obj);
> > 
> > Generally, I have seen in the function goto will call corresponding
> > error tags, and free corresponding allocations and all the one which
> > happend before. It is easier to read code that way. I know you are
> > combining the free call from iommu_liveupdate_flb_unpreserve() also.
> > IMHO, code readability will be better this way.
> 
> I had that originally when I was writing this function, but it gets
> really cluttered :(. Instead it is more clean without code duplication
> using this one cleanup function here to free the state on error and also
> when doing unpreserve. Please consider this a "destroy" function of obj
> and it can be called from 2 places,
> 
> - Error during allocation of internal state.
> - During unpreserve.

It is removing code duplication in

 - iommu_liveupdate_flb_preserve()
 - iommu_liveupdate_flb_unpreserve()

However, there is still duplicate code in iommu_liveupdate_flb_finish().
Another thing is iommu_liveupdate_free_objs() is doing two different
things based on current liveupdate state (before or after kexec) passed by a
bool argument. IMO, it is cleaner if we explicitly write whether we are
doing unpreserve or just folio put.

I meant something like:

static void iommu_liveupdate_unpreserve_free(u64 next)
{
       while (next) {
               struct iommu_objs_ser *objs = __va(next);
               next = objs->next_objs;
               kho_unpreserve_free(objs);
       }
}

static void iommu_liveupdate_folio_put(u64 next)
{
       while (next) {
               struct iommu_objs_ser *objs = __va(next);
               next = objs->next_objs;
               folio_put(virt_to_folio(objs));
       }
}

static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
{

...

err_free_devices:
	iommu_liveupdate_unpreserve_free(obj->ser->devices_phys);
err_free_iommu_domains:
	iommu_liveupdate_unpreserve_free(obj->ser->iommu_domains_phys);
err_free_ser:
	kho_unpreserve_free(obj->ser);
err_free_obj:
	kfree(obj);
	return PTR_ERR(mem);
}

static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
{
	struct iommu_lu_flb_obj *obj = argp->obj;

	iommu_liveupdate_unpreserve_free(obj->ser->iommus_phys);
	iommu_liveupdate_unpreserve_free(obj->ser->devices_phys);
	iommu_liveupdate_unpreserve_free(obj->ser->iommu_domains_phys);
	kho_unpreserve_free(obj->ser);
	kfree(obj);
	argp->obj = NULL;
}

static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
{
	struct iommu_lu_flb_obj *obj = argp->obj;

	iommu_liveupdate_folio_put(obj->ser->iommus_phys);
	iommu_liveupdate_folio_put(obj->ser->devices_phys);
	iommu_liveupdate_folio_put(obj->ser->iommu_domains_phys);
	folio_put(virt_to_folio(obj->ser));
	kfree(obj);
	argp->obj = NULL
}

This way code is pretty explicit and clear what is happening. Let me
know if you meant something else by cluttered code.
> > 
> > > +	return PTR_ERR(mem);
> > > +}
> > > +
> > > +static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
> > > +{
> > > +	iommu_liveupdate_flb_free(argp->obj);
> > > +}
> > > +
> > > +static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
> > > +{
> > > +	struct iommu_lu_flb_obj *obj = argp->obj;
> > > +
> > > +	if (obj->iommu_domains)
> > > +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, true);
> > 
> > Can there be the case where obj->iommu_domains is NULL but
> > obj->ser->iommu_domains_phys is not? If that is not possible, I will
> > just simplify the patch and unconditionally call
> > iommu_liveupdate_free_objs()?
> 
> Are you suggesting that on flb_finish() the obj->iommu_domains should be
> non-NULL as flb_retrieve() succeeded? If yes, then that is correct. I
> will update this to call the free_objs() without checking
> obj->iommu_domains. I will do same for other types.

Yes. 

