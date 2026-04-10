Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2478F4F
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863014; cv=none; b=QwlRrrYoOLsoRXQWZSbhVJ7ZzJg2qWWd6Tb+CaksubIGrgB6SJ6WN4jX1nN7rWDTyMgEs5fBRbD8Br5exLr7keG24M2H7Huo9voQmSso/8luOSUtpnFtfYkBFS2sqwS1rXbh1ZcRRc2742JoaZ2rmT7J2ZDxVNVce/tLa4o7vSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863014; c=relaxed/simple;
	bh=uuKi1X0TZzBYQCH/+D+igtqxtVeYjyboC6Wv2+XouX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alrPBkYdxg1S2QwIozJuYxSxKv5GqakgmYMMD5nyk8XyNx1OlWiXIJu3ryrBoMJakJk6vSHFc13wTwfDqrYLJUMA/p6mXyFAuroFiSJJYSGGdmTo0tje/UzvlZOxi9Hbq3OofDpPeEPh6/abltwrarjQka/jKPix3EvKYCBKEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cqPJLr8y; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cqPJLr8y"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cfc085395fso242328485a.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775863012; x=1776467812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cd4+5YI3Ts2enNXoZMTCszEKCVLBE3ELOgKW1U5A4o=;
        b=cqPJLr8yVXPROM6EfXG8H1Ts6hFdodrVBQYkn54U2TVYYIExlXx8H/5Zecmhkax4yg
         HEI9+2HH873oGZm6CK0PGWURXhZMYJCMLuZfYyxbPVH/hzyVAkftuv4OTte3skqf6NXL
         CZBYq7GYM6ysbexaiQ0aYGMm1ty5R42V90wBY9Ns7j0iXvxuo78h+EHn6aqThBgjn1MD
         9fooam2LZMg+1DNE7doDEFS4CBLys3BO/2pQfGu3r+mI4RJ3udA433HzRE7bgGt38bMn
         pcd2X4p0D+UUXkvGsZuhN4PGQG3O1zjI/M14w6Yl7qRQp+/LOcBZtvSjnkB2/COpT48q
         zt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863012; x=1776467812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cd4+5YI3Ts2enNXoZMTCszEKCVLBE3ELOgKW1U5A4o=;
        b=YwwC+U5sQm+fLKiH+rwtw2sc0D1X4u0dhj1gZVuvVbfdxLeP90Wl8XNdhVO9T0AWK0
         nn5Bq2xl+4VuTuZ5LiL06qj7XsPnuX2O2As28Ipd4fW4QRT2lvQLeuQt23DRpLe8IHIU
         edjnpVfQ5P+PwWD5Lk6bjPti5LWLPuA3sJozYST0v1kdQ6i8BMxAIL9oS+VyPIgx4NhU
         3+uKuGAjeznKeQLzOIGMf65PjguKL38fGf2dE3SptbkNN1mRQEqmu0uGRlFEYojjLqnN
         Rk5I1eVo3JHhel+dN/aidN2gIWIh8gyp++Rk0Qb9D9NVuBV2qfvtUtn5nQXhcQCDC7br
         gOHg==
X-Forwarded-Encrypted: i=1; AJvYcCUrqL51PRAG4nRND2uV6TCapPxJpR6W8Ghmb14J8G5aRjdnZhCS4tSc45JZCKB3QXCBoYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLc9+zqEgByxmZwqV4hsfdgk/8YeKWMBGN01iP37D9x3gYAxfq
	H4037IpS7arFrqGIeOL0f/HObo8jx9CudNlzqDxek4a+25bg0axBcrUU78PX836p9B0=
X-Gm-Gg: AeBDievACiWtAxgaTWdiTQfGTMVHFnSmCodEsy0lfkuklwcLrvr6Kk373A6CNs2a+a9
	QCr9TgSIUSsOxT/N/zfStc8oaY9CJLT37qyt7lxJQyiDdupl2fQ98ZReLAUUCKBzRNwcRA86yQH
	fP1C1VzCW4k1pkVVlUmNA/U4s2AEeUg+j4YFECFZJ8GkaVw/bv0yc3UqYchqlT9Vct5Q6Yc6WJc
	BUqXT0cKpDYpC0ddb6HLPal3e1blYpCHk0wZxvkCs1Y36ddNWry6zE3awqENbNV+2b9CJWeZItt
	a2rO9jwWofdLTmYQ2WBrsSfN0H+jc3SsH/GsqIIoyJYh9qsQKlEMKdijilUQ+dHrrNmhmA8aQ5S
	gchttX33DWNdrQhM2io2/LLZV4yminb1zpIo+LC4ylZcjacIt/46wPQouDftLjYrPjYpua5y6W7
	C5a1luZoeqUNgu+zykMlFsdGFQA2m9jk76B8s3osylusSY7sI6IHS7UvXCVUm4sKHcl4psTA==
X-Received: by 2002:a05:620a:1a24:b0:8cd:b626:cdf1 with SMTP id af79cd13be357-8ddcfcb2c39mr749957785a.46.1775863011618;
        Fri, 10 Apr 2026 16:16:51 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb934dcd3sm342518785a.34.2026.04.10.16.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:16:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBL5m-0000000Gks1-1hx8;
	Fri, 10 Apr 2026 20:16:50 -0300
Date: Fri, 10 Apr 2026 20:16:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260410231650.GD3694781@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
 <adl2QX6gra99bkOV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adl2QX6gra99bkOV@google.com>

On Fri, Apr 10, 2026 at 11:02:52PM +0000, Samiullah Khawaja wrote:
> On Fri, Apr 10, 2026 at 11:16:52AM -0300, Jason Gunthorpe wrote:
> > On Fri, Mar 20, 2026 at 09:57:08PM +0000, Pranjal Shrivastava wrote:
> > > > +static int __restore_tables(struct pt_range *range, void *arg,
> > > > +			    unsigned int level, struct pt_table_p *table)
> > > > +{
> > > > +	struct pt_state pts = pt_init(range, level, table);
> > > > +	int ret;
> > > > +
> > > > +	for_each_pt_level_entry(&pts) {
> > > > +		if (pts.type == PT_ENTRY_TABLE) {
> > > > +			iommu_restore_page(virt_to_phys(pts.table_lower));
> > > > +			ret = pt_descend(&pts, arg, __restore_tables);
> > > > +			if (ret)
> > > > +				return ret;
> > > 
> > > If pt_descend() returns an error, we immediately return ret. However, we
> > > have already successfully called iommu_restore_page() on pts.table_lower
> > > and potentially many other tables earlier in the loop or higher up in
> > > the tree..
> > 
> > It doesn't return an error, it just propogates errors from the
> > callbacks which this one never errors. So this is just dead code.
> > 
> > > > +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> > > > +{
> > > > +	struct pt_iommu *iommu_table =
> > > > +		container_of(domain, struct pt_iommu, domain);
> > > > +	struct pt_common *common = common_from_iommu(iommu_table);
> > > > +	struct pt_range range = pt_all_range(common);
> > > > +
> > > > +	iommu_restore_page(ser->top_table);
> > > > +
> > > > +	/* Free new table */
> > > > +	iommu_free_pages(range.top_table);
> > > > +
> > > > +	/* Set the restored top table */
> > > > +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
> > > > +
> > > > +	/* Restore all pages*/
> > > > +	range = pt_all_range(common);
> > > > +	return pt_walk_range(&range, __restore_tables, NULL);
> > 
> > This should probably be doing something with the FEAT flags and
> > ias/oas too or do you imagine the calling driver has to deal with
> > that?
> 
> During boot the iommu_domain is recreated in driver and it sets up the
> FEAT flags and ias/oas properly. Then this generic callback is used to
> restore the page tables.
> 
> Currently the FEAT flags of a domain are not explicitly preserved, I
> will preserve them and error out here if there is a mismatch.

Hrm, that expands the ABI a bit though

If the only operation on the restored table is free then I suppose it
can be simplified quite a bit, you just need the minimal things that
the collect walker in free touches.

Is that the intention, free only?

If so then the restored iommu_domain should be some special free only
domain too.

Jason
