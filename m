Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF614D719
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781403; cv=none; b=iDWHO8HRPwmHC7Hpa7HTHgzJGfyhE8hYrCQVIyVPgx5IJmJkS0uN9eETEGHK98y3ounZ1UmnmUElVZwkSj283Zh1Xd7W3DANugS8cZwc3nFBIK7y3l66j3vaApZ/gvHi3XbfKvc1dAIzaVoJqt+v4u8ZmoUzCan+2HjjT0MCNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781403; c=relaxed/simple;
	bh=X6DzbCuOaFwTTskyaHV4XXzuegXjEYxk2EYaNcAZZuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0tt6jRbPSaB575qj9oo9GwBBelEv2r2L0D7jRIKm7s3JEh7EZzjavaBI0Zs+NxzM/yApkHP2TmEmQvBpGTuxgpRYK2Rj5gO0IEhsYJx4oTRdFzsZ5rWLcG1ghC70dIrkdcsxIyiP4vc41/hVbaWiefdiAfbP3dSvaEBW2efz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdmOJ3mE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdmOJ3mE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so27035ad.0
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773781401; x=1774386201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsZAeIDJS5lxqfyPMoioJYSBuFBQGFp/OuiwRZmjHkE=;
        b=jdmOJ3mE8FtWsylJ5ZATC90RdOkvaI/c5gNbgW5lS3YwIQDbMG+Yjd3fu9kpWJC5zk
         pip0q+9dsXmp3pECkup3bBO4vtQgv27trgfOeSVCzEjFScWkWjQ0cDakDCceoIYvfhP7
         uJlLOpKSJtZgHOLYWR21OOUkdkFW8LuzyTS5ZP7JJXY98sdvJHkgjd/6AXMZpzdXnJun
         yQ7FO5yedz/1UwvLg77aYh7K+HuXUDA6w1Oug0q/GvR+byFfqvH2yfKF8gtATFWmuC5v
         Z4IPpD9Ci6RMYqgNkYvUiMzSy7C2BMSsbxsOUqfTsdxrKIpkGK6hWBNpjUhtk3tYvohX
         8b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773781401; x=1774386201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsZAeIDJS5lxqfyPMoioJYSBuFBQGFp/OuiwRZmjHkE=;
        b=LoqrqfjoRFf0H6sFnGwx8tXW++UCiguUH/48cuAea+rV+Frx4oCEI00C2FpK0bW6kW
         IG6Km3971XV01pLA++TnrvLBymVzhnMmVKKsXdEPbdqF+tW+5I9YKALikWKzFRw1qeLe
         ypbELFOIbI9tn5BzJgT1TVkLlET5SKcSZbJ6prLk7ixB3oC55PyN+Pu4BlYcQGjBiSbp
         4H4cBxT2NtZFqFNRChmCiq2nRgmqmZ3BL6ZPp+eL3mVn1EiOtXjTU+f961ltYmlJkdUW
         7XKaIvmOwQxrvNBDXqIt4WGjinjAWe1gOaaG1HcHSCFJXGjk15cz2Bmve5LbtQB2RkhM
         N0dA==
X-Forwarded-Encrypted: i=1; AJvYcCWlwX3ntHbYYd3tED5nRHveERrjkG42Zl+MMvn4EfCJ4givplvPHA7/CYpvIKTpSMeCrjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUeALJu2OavIFOCokpBfXfnwuEil4KncJYRdYXDOFcJh4VAVX
	qOGfFF5RWAgZ/GsEWPlXNQ5cpAE1JculZO8TPKzSankY19vnmZSUNRYBaGqOU88Hew==
X-Gm-Gg: ATEYQzzlXu7jIW8NQQnzsFmKtxp4Si2FI0Lo0QOBlhlcuOoi1D/uE/gzWGOkd3Mc6T+
	Tk74t3dD9bax90xv56Qh+sB9zu+yv6KONORfQy5MHYqjV3pEo8FukPsYFUwELtOL1NlZvqP6GVY
	VBSK+/1h7NlPjWfd3xVR1IYtKmemvgQPmoHHZmlvayByTFFUPZ07SV+0nI/5txb+OuL2UglpzLi
	QSkTE+XQmiwuY3vFjXfU5JvcdzTGoq8ppg2fWUBO5gGbbG8eVgoIkktHS4XHyWV1bMGDyzAnY/i
	DKVVLNsxp3s90yDC1QkPnMdZnWw3QJpyK+aZtfUK2fynlVhEkjXrb5OOW3PYvYb+pPH7hC84PSz
	pGYhO44myYJQsSEZdOFCHBToGBa4QscSN5DTMt3D/G+TaqKL/29GDw9L72ofdYcKkzNPaLehpaq
	w8RY1Y8KUqS5AinIV5hUaRlh8lggbVnWB2GpRxZLbNgRrmMs8rSyRm75N89A==
X-Received: by 2002:a17:902:e947:b0:2b0:5cc5:9405 with SMTP id d9443c01a7336-2b06f7ba317mr353015ad.1.1773781401248;
        Tue, 17 Mar 2026 14:03:21 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bba04c12asm145181a91.1.2026.03.17.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:03:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:03:16 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <20260317210209.GC2582517.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <abNH7LAj9thuGOoG@google.com>
 <abROLLfSUK8pXM5J@google.com>
 <abm09vCaAMtiQPVs@google.com>
 <abm1esL1dzN7NTC7@google.com>
 <abm4ShqPTxIujDlt@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abm4ShqPTxIujDlt@google.com>

On Tue, Mar 17, 2026 at 08:23:38PM +0000, Pranjal Shrivastava wrote:
> On Tue, Mar 17, 2026 at 08:13:47PM +0000, Samiullah Khawaja wrote:
> > On Tue, Mar 17, 2026 at 08:09:26PM +0000, Pranjal Shrivastava wrote:
> > > On Fri, Mar 13, 2026 at 06:42:05PM +0000, Samiullah Khawaja wrote:
> > > > On Thu, Mar 12, 2026 at 11:10:36PM +0000, Pranjal Shrivastava wrote:
> > > > > On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
> > > > > > +EXPORT_SYMBOL(iommu_get_preserved_data);
> > > > > > +
> > > 
> > > Also, I don't see these helpers being used anywhere in this series yet?
> > > Should we add them with the phase-2 series? When we actually "Restore"
> > > the domain?
> > 
> > Phase 1 does restore the iommu and domains during boot. But the
> > iommufd/hwpt state is not restored or re-associated with the restored
> > domains.
> > 
> > These helpers are used to fetch the preserved state during boot.
> > 
> > Thanks,
> > Sami
> 
> I see these are used in PATCH 8, should we introduce these helpers in
> PATCH 8 where we actually use them? As we introduce iommu_restore_domain
> in PATCH 8?
> 
> Thanks,
> Praan
> 

Please trim your responses.
