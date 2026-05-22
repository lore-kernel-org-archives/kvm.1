Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A137BE80
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478170; cv=none; b=a9CBtdb+VH/BbtFtiTOlWiUMKr9Bmhe184gYjgU7JApR/q2CU4W/AvhVF4SGQ3mW2jVnOtuqGb5IcCxZETwgmLP3xpXZM1UJy7BS6SQpR22gFj9MJGrKgwYrFVBbpd6A5wn/prfXau3KrWLFb0wAjMkcivC9JsTlHkjEdAZY8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478170; c=relaxed/simple;
	bh=ffzvcdohYfK2Nhcc6YKxgUldy2MbL1zw2CegD7bxo5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svf6wxCDPjYvuWjqaSvgLuZ24N02wxnPtHAiC3vfo7P1KsV0X5NsXv8S4GRCgu34y9XaENn98VbhNrFbLP0YN5pD8Kr7C/C1/Sc4qvq/ImQZI095JwmCLQ9QL57vi7LaGF+U4dUMG2+b1qbUgK6JiuY/kw63WGF/Qa5vrkcrAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKuHknHA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKuHknHA"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba180a022dso895ad.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779478168; x=1780082968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rXutVjEtLFCH+2KhZxwAs98V/nz+fnBuy6pdFon3Xw=;
        b=MKuHknHA+uK7OFtqGD9Vt8RZuG37VqaX+LHhb3O/JsqQD394shaLmVAk9ZWnBA+Rbs
         VFNzdiOOpDyeYPJSYCYMfdman2t52svpSCNm3vgMPPvCXY+XdtItwduwrX4mHoY8E7f4
         blWwe4I/zRoBfWFN4HMiq395N7DKnD97nyz38b/6c9jYLWj0PitTpUwFzXrC/etUfr97
         LwJzyu5J6+eaQfD0KoVc1slkLh4WbsQun90GaxjwH69HE+JJealOuEAlP6W082VkI66X
         GDX/o4hdzw7BVtzdxeA1i7Esn1dpdPHY5fdacpRFiGxcMzVCMGvRPog36kZn8BiQZ3cN
         JC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779478168; x=1780082968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rXutVjEtLFCH+2KhZxwAs98V/nz+fnBuy6pdFon3Xw=;
        b=Kzh7vqjO8GVNvaiC6QwkTEb0Ev4PRW117tNi3hewyha89fLbyRja5PYcVVMl1qgSof
         wm+shwh+ZJrGp7xcbWwfeA8vs3Ovg6N2zZ86rwYVKabsnN/kDqk+hGWEyexGDJjyMTMs
         BQk2/jSkrXYNDzINUURPasFg0PXpx/8FgQfabrpod5IlW7v+vfTN+WafVd8tjimc/MGg
         xwUABxvdBtj2nR3o8LPwcdJ3YuFMuk82eclbqAagMrMhoLsz022fR8SF2GLjIoD/AzYC
         KYHkj9rOehw68Ddvq3jSBMASwN3KoTyoCtx92k2buKJpQ1QmGdFU8VTNzTNzLr4BKWzL
         hPgA==
X-Forwarded-Encrypted: i=1; AFNElJ98NwycH6M+vC4aohVKfB9iTvCkryqYE5qKQanL84fCHjwmZfuaig5+WqxlUEO2cu86ljk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIFTpr0nvyjOLmGDqoJQlGav4o2bil19pPm+SpHWFgxgMPlL+
	+hHJbrOTkBc935Wrn7kLTUSFBBU4J/T/HlNnBBvpe0s5dnZnKCk2XMo0gFE0LkrAKg==
X-Gm-Gg: Acq92OE9SfDIIDd3OmP/xN8ROloVguHk4/0F/Ye5Dop7l/FXUNjtBIW6laAAJfteXUO
	gqSi9AoqhZuRYBgpIsfsziFt3eXCU1WoexJCMQqwVuBkoipufoI6GfkxoBOagPXonwYBssO9V+9
	qs1w/fSFDM3cvWZc07YTVo1HGWDpAuNhvUdx7hF2jZKyKSmsWKlU9IjuSbu0GaPUn5BRv0Y5lnS
	LP1OMu3vvbjeMsaBd0fx940KhEr0KbS2ptWTAug4BjmgiK0wARFJgK2+zIEEH1iXDZFjZcJKZRd
	umlGpQwggLhKdUDcJDzyrDdEKQbLZT9v6yVaT5skWJijFxok9OqjWzE4WQS9CWcE5Du9o3+wW6O
	d9yBoCdWFn8j/8rOoaSFK3b9tvqaySl6ItUxrjQJrn1GDmbRH2VE3VetDxd9bCFgV/WyKouMH7+
	4mN1mIz9ZJAcNhe7H3+HeyNFs04rqLDEde7XfBH2l5mApHaIo0wULkTXEmpQbMwcCo4ycF
X-Received: by 2002:a17:903:17c4:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2bebe9eff1amr388115ad.12.1779478167409;
        Fri, 22 May 2026 12:29:27 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm2981586b3a.2.2026.05.22.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 12:29:26 -0700 (PDT)
Date: Fri, 22 May 2026 19:29:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	YiFei Zhu <zhuyifei@google.com>,
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 13/16] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <ahCujtmNUzE9XDa1@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-14-skhawaja@google.com>
 <agz5rFcl27H8yzTY@google.com>
 <ag4DzYZ4ToDcyfn3@google.com>
 <ahB957SICkiVzZBv@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahB957SICkiVzZBv@google.com>

On Fri, May 22, 2026 at 04:01:43PM +0000, Pranjal Shrivastava wrote:
> On Wed, May 20, 2026 at 07:40:05PM +0000, Samiullah Khawaja wrote:
> > On Wed, May 20, 2026 at 12:00:44AM +0000, Pranjal Shrivastava wrote:
> > > On Mon, Apr 27, 2026 at 05:56:30PM +0000, Samiullah Khawaja wrote:
> [...]
> 
> > > >  #include "double_span.h"
> > > > @@ -1421,6 +1422,7 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> > > > 
> > > >  {
> > > >  	struct iopt_pages *pages;
> > > > +	int seals;
> > > > 
> > > >  	pages = iopt_alloc_pages(start_byte, length, writable);
> > > >  	if (IS_ERR(pages))
> > > > @@ -1428,6 +1430,11 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> > > >  	pages->file = get_file(file);
> > > >  	pages->start = start - start_byte;
> > > >  	pages->type = IOPT_ADDRESS_FILE;
> > > > +
> > > > +	seals = memfd_get_seals(file);
> > > > +	if (seals > 0)
> > > > +		pages->seals = seals;
> > > > +
> > > 
> > > Can caching memfd seals create a TOCTOU issue?
> > > IIUC, iopt_alloc_file_pages happens at map time, However, the userspace
> > > is allowed to map a memfd and then apply the F_ADD_SEALS via fcntl()
> > > later in its setup sequence? For example a sequence like:
> > > 
> > > 1. VMM creates a memfd. It has 0 seals.
> > > 2. VMM calls IOMMU_IOAS_MAP_FILE. IOMMUFD caches pages->seals = 0.
> > > 3. VMM finishes its setup and calls:
> > >   fcntl(fd, F_ADD_SEALS, F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL).
> > > 
> > > 4.VMM initiates Live Update.
> > > 5.check_iopt_pages_preserved looks at the cached pages->seals
> > >  (which is still 0), sees the seals are missing, & kills the LiveUpdate
> > >  with -EINVAL, even though the file is properly sealed..
> > 
> > This is true and it is intentionally this way to make sure that the seal
> > is applied during mapping otherwise user can apply the seal after
> > resizing the memfd and preserve IOMMU mappings that are pointing to
> > unpreserved pages. Consider following:
> > 
> > 1. VMM creates a memfd and seals is zero.
> > 2. VMM maps memfd into ioas/hwpt.
> > 3. VMM resizes the memfd.
> > 4. VMM seals memfd
> > 5. VMM preserves the memfd (it only preseves the current size).
> > 6. VMM preserves iommufd and it succeeds as memfd is sealed.
> > 
> > But the pages being referred by the iommu mappings are refcounted in
> > current kernel, but not preserved.
> > 
> > Check the comment in check_iopt_pages_preserved() also. I will add a
> > comment here also.
> > > 
> 
> I understand the intent to enforce a policy to Seal-at-Map to ensure
> consistency. I am wondering if this policy is a little too restrictive. 
> Should we consider performing a dynamic i_size check during preservation
> instead? I can't think of a good use-case as of now.. (maybe let it be?)

On another thought, I guess we should go ahead with the current policy,
to ensure we preserve the right pages. If an unsealed file is shrunk and
then grown back to its original size before preservation we might have a
problem. We can ignore this comment.

Thanks,
Praan
