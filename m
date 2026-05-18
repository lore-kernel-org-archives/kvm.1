Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5039A04F
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140184; cv=none; b=LLInuckuhRExcXBPhgHsicUxZzFOz2xQbZn9C15Gyvn8NRfHrUqWOmE5JQQx4hEBBL5CWZtbHpdTX/WWop4kxmLKw+H9UXw9eVlrwuG2ACEZxvU5m56/svNP858x3GOveyeFAgUJQlazCz4lDiX2xosDg8ttdYPxPY4ChVfcgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140184; c=relaxed/simple;
	bh=H7Xi63DWkfe1BGbqWjPfOELabonYMm/OP+GwrSijp68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI/LWUOEhZcmnpgV6WEW9e7Dd0Rlu9F8DxuJTJtdglubB1WGQfjor1eBxJfEtOJYzxvwEqu1icRM4iesOgIlDivftv7oqkX1BOXhWj4C4NdcWZTk5I3xEJHsRoLMasgzEbVXM3kO0VJignTIXHGpgdKWdL4LsQ5uLgCg6pTueoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GwQ5hED+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwQ5hED+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so815ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779140182; x=1779744982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdhq85Gg3A+NvWbGs+q4HdNVWYpVSS2dUxoGdw9nwVc=;
        b=GwQ5hED+V+xoR/hfdBgRkkjMPJMC/tYKwSrCbNXBcT+zc+e6/TDlqbTAEj9EzRtubk
         w93VoppTf+rHJrt0dwWg0ItoU77hD9hCSyvgd9RA1QIhHK/tUdSNy5wrrRTFNvHw/LiY
         YfrQnV0nW/TeBtMVvvj2MtTqUmH1XQHthziuYUW5l7npivSECA2FWr27Mm/teWr2Kpiq
         toQlmY9cctv5+wEqbcyudzc2IGZacb6nM0mhJquFrbyX5X0VVUt+dXEXCofiJT9Gobto
         mUWu/I+FOweG4yLdob6L1l0qAkWCFeDg1RtpDtgI+7Tkck5gKTL6je48JdiOuqxMa4Hq
         eDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779140182; x=1779744982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdhq85Gg3A+NvWbGs+q4HdNVWYpVSS2dUxoGdw9nwVc=;
        b=Qa/xH8ahe8Y4Tm6EfFbEBKkrdKBHt7jl86LkORSuTgslEZcUBxCuNmqC5i3d7rR6dH
         Qk1oGSvAs5fV7ROnlJDE8gvkzZx+BNXAOquL88dd6VV07aEIRkVC4VVrJhpFtP/tx4bh
         61kjyExo0Dit/UBmZC0pWn4LdEV6z7Z2BcsVRVPy2nq85/gooLgwEZ7zWuvZZPEoiEdC
         fdBTXfM7ct8eD2D5Hvgg8+af2a8JcBoPgTj7Y+6O2gjxY6wX9xMQICQ0YZnJtnhbaTm7
         cwuH4L3ccbghikyA74aHDSpUmEBiuyuVDFBeTs36FrV/Lymlp5IBxcYJr0cVneVaKZ40
         nwuw==
X-Forwarded-Encrypted: i=1; AFNElJ+kqeQUH8cjLoqUU6X+L+4msoHEu2k0lE+xUgT2viPKRK58XCll9NkNgVJ2E46EWF+XqdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT968rieO8n+pjbxHCUY77G8u/IZB3t+xWaxbtgmqXN0fwENd7
	N2nwyzoS4QiGCrcVQJUBJ2EtbakIouJyVQ1h+T5/r1noy+ExJoR/zt8VqfItTSv2fg==
X-Gm-Gg: Acq92OHOK+eaYqnPycJAqt4PdJlJZFCM0u1UfVUlAlB3fxkVbi607fYUDHDqOHaBjsh
	fPwq5RfRD/M7O817/M2c3jhYXJSOFULhePVo6TiMCc1zAV9aVL1+1S961W9j7pC7K8UgDGR8T0F
	I9TeD2DDi6NSH7SnntstlXZjkpWrfO0FZvcmpE9nA0o9Weg20hg1GMccYHopd2Gbenr8IMHz37p
	e96o8r5Ezl/O1zlxJaVXBICVoLdCUMj+IVvPZpMF+ZyonFuuCqFkHGEW9pnwRHJo/2twbgr5yUy
	eq0/kKxUp4+qtqeqHsubQUeg8Fe63A0luStE9W1mq6QK1hB9kLW8Dj3RktPhkv41Lxw0v/2Klu4
	ptealZ6TEamDo/HJZytwyc+xkOI0HkAMPUC7FvmsZ17sIlEqoiBsEqQ93a/VfOVyRseFAkIz+tu
	ivI+Q2U3kDuKIHFopdtl9gwzcRN2zpVPGTlmy6omzXEudPacZSG6J9yXweKcrWWIE6K2l1
X-Received: by 2002:a17:902:ebc2:b0:2ba:73c3:49b0 with SMTP id d9443c01a7336-2bdb03acb3dmr4353865ad.14.1779140181119;
        Mon, 18 May 2026 14:36:21 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369514aecaesm12378424a91.17.2026.05.18.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:36:20 -0700 (PDT)
Date: Mon, 18 May 2026 21:36:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
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
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
Message-ID: <aguGR98563NEUwdS@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-4-skhawaja@google.com>
 <agsQE1lFGdo-b_IF@google.com>
 <agtenWUBOVosDCTU@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtenWUBOVosDCTU@google.com>

On Mon, May 18, 2026 at 06:55:50PM +0000, Samiullah Khawaja wrote:
> On Mon, May 18, 2026 at 01:13:49PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Apr 27, 2026 at 05:56:20PM +0000, Samiullah Khawaja wrote:
> > > Add IOMMU domain ops that can be implemented by the IOMMU drivers if
[snip]
> > > +	ret = domain->ops->preserve(domain, domain_ser);
> > > +	if (ret) {
> > > +		domain_ser->hdr.deleted = true;
> > 
> > Nit: This will become domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> > once we convert the bitfields in PATCH 2 to flags.
> 
> Agreed. I think it is being discussed that bitfields are fine in the
> other thread, but I will switch it to flags for readibility anyway.

Ack. Thanks!

> > 
> > > +		return ret;
> > > +	}
> > > +
> > > +	domain->preserved_state = domain_ser;
> > > +	*ser = domain_ser;
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_domain_preserve);
> > > +
> > 
> > [...]
> > 
> > >  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> > > @@ -752,6 +757,11 @@ struct iommu_ops {
> > >   *                           specific mechanisms.
> > >   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
> > >   * @free: Release the domain after use.
> > > + * @preserve: Preserve the iommu domain for liveupdate.
> > > + *            Returns 0 on success, a negative errno on failure.
> > > + * @unpreserve: Unpreserve the iommu domain that was preserved earlier.
> > > + * @restore: Restore the iommu domain after liveupdate.
> > > + *           Returns 0 on success, a negative errno on failure.
> > >   */
> > >  struct iommu_domain_ops {
> > >  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
> > > @@ -782,6 +792,9 @@ struct iommu_domain_ops {
> > >  				  unsigned long quirks);
> > > 
> > >  	void (*free)(struct iommu_domain *domain);
> > > +	int (*preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> > > +	void (*unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> > > +	int (*restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> > 
> > Nit: Should we add restore in the patch we implement it?
> 
> The ops are implemented in iommupt (separate scope) and it is done after
> the iommu pages patch as that is also required for it.

I missed the restore implementation in Patch 6, I thought that'll be
covered in a diff series. Mb. Please ignore this comment.

> > 
> > >  };
> > 
> > With the above nits,
> > 
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks Pranjal.
> > 
> > Thanks,
> > Praan
> 
> Sami

Thanks.
Praan
