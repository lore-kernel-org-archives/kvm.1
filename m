Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7034BA2E
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774049689; cv=none; b=CPjhoayuuwcV99PAjMTMx2667gpj5hGqRrNr4bMlu/dwaWznpjk0lVKvJb6fqn8UbVSn0iBEdzBP18Z95TN0WQATXsh5Sjp+hwiqtkW+UhjWbubqQaURqy1Fu3IUFrP3Dynavp7NH/4So1mwMvyNirQnJtfxwmNJ1XjIUfWP06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774049689; c=relaxed/simple;
	bh=eGjR1Vr7sZJkjuTItiI4aUSbYLNlDKVsWSLdbGJh5Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ6/HXyV12946sfkMRUa/aEWlTejeCdcGtIHJ3zSPX5vlxqs7F9E7Bj730iWym/ojB87RehLlx/ktpWdfdd0RUIKa4iIAFm3qlj6Ntgi6fAixwC1OI0iyRz3L01Q28mXlnOd8YVxgF7fquR9vfOkB8Pt7cQPcEINYIjcrueBUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhkIg+vS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhkIg+vS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so36465ad.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 16:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774049688; x=1774654488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3DUb8XK/BNGAY47qp0W+ue0rjJS+iXyrE96peyM214=;
        b=BhkIg+vSZjpHBFYSnvYiVj8bDFbHuBW3dUhVcDrAxcLzAJXpNZCRaBji0gpqB9idgb
         a1eZuVYDM1jRxj9MiT1DeSqS5zgXkZTEO2vcqGhKHLpaHQxdKvFu5DT6cJaKBYA1Hboc
         WBbUP3fYHFQigdio180f9XflFYYBJdg2dh+z29L0b2zEL7rthlPFrG1S+5D5Mco0DK88
         hY1Vl0XHqWWIa4/qbzfxnyCmQfVuNFfxUmSO1QBHH1uhWXfUk70jy9eBbGZWWmQlKtyL
         HB9P+fiCzmmAIatkumbqbLKYER3D7B1Sj6uv7U+Nr8l7rflSL74kzsVE/QQKR8ZutsJ1
         jmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774049688; x=1774654488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3DUb8XK/BNGAY47qp0W+ue0rjJS+iXyrE96peyM214=;
        b=rCzFNUG9epERyLUaHUl9GR/4YlrVQEg7lBDY7TbJB0eIANWoO1HMmv3u1/VEGB5as9
         demIuNb6lnDyhEvT+70LL82XFyGebwvCNXeQaswLGScU0AMp+022FncrKPN4uGivFe5x
         TjKKChy4Ffw8lymAozJj6GtxqMMuB1T4z/n72h4JwaaRc/eyZOCHIVVbzjZkr465EgjY
         2YYrNpaPPugcF3FhvrCYk4DfrXU4UFVQbl0YvL6eETCLM5zDCEMcGQifUW+HGPfl0IWA
         qUqQELCI05YXUXJKnV8kqeN1gwpWQ7wKsgkrN+Di0o4fJiu73gK9rJGRxKoXKK5AL4EL
         evNw==
X-Forwarded-Encrypted: i=1; AJvYcCXy0SvaoJ/odrtV+6RbXKoYdcemgzteexC7EWl7v8y//svpI2ET9S7uS5gFHQUYgEZ3uMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6lXRmzGmT4vb0Pphi9gw3z7s841f+sj5gYw4uktfQ2sjOV2Z
	99nwgd7nuDsBUll/o5PTwR8q3OIVKXY07Inaw6J2xKMgx59mHfKu4pl2KP1OT4UVWg==
X-Gm-Gg: ATEYQzwnIJUpDcPf3rcokJ9eC7nWmtAVTUA3wgTeq0rpKLoJygeBmxvyRQe3Uu6jsMR
	hbnOnTWjVCppZR3Y6elzWGYxuzsRokuWTkP3F6qN/tgQQbHECbpBJOIszb5qX9pGwR9fksV/3bP
	dPOLCW3tPd4LLBThMv9O7F8L8arS8CHkkp8FQXzEJ6a5kXKdXQ7J4ENloJ7Ed2xIoNDN58AvO6s
	RHilGWAgW/NRF23U4LMuXthO1l0XAVc7zTVhe8Gp1ELgl2ouV/ve+zzZZzpPNx2bIQulfUF8d25
	ptYvNPOpIsT/rhRJ8f4aSnkw2hzJfif7Pf+0Tbvesc7FlLKZecIR3BMkPa7JWjOanfcqlz1xyCF
	201zVH3E21nOf5DlQozrCFgtPVEpHscqfji30BUEOnc5W+DLcS5AeuAT849DgX0Mg56MwP0g8j3
	en6wowSx4/vM3zjjvAjmFBCKeyRfPz69dcfvbH9Bu74ZV7zu/CdDYOOtwLlR3ij9/M/680Dk4=
X-Received: by 2002:a17:902:e84c:b0:2ae:4453:3674 with SMTP id d9443c01a7336-2b08b29f391mr1276665ad.4.1774049687124;
        Fri, 20 Mar 2026 16:34:47 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443ccbe4sm2570680a12.22.2026.03.20.16.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:34:46 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:34:41 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH 10/14] iommufd-lu: Implement ioctl to let userspace mark
 an HWPT to be preserved
Message-ID: <20260320232634.GC659132.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
 <20260319231331.GB3983821.vipinsh@google.com>
 <abyU3g-ta6Gg6kEx@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abyU3g-ta6Gg6kEx@google.com>

On Fri, Mar 20, 2026 at 12:40:44AM +0000, Samiullah Khawaja wrote:
> On Thu, Mar 19, 2026 at 04:35:32PM -0700, Vipin Sharma wrote:
> > On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
> > > From: YiFei Zhu <zhuyifei@google.com>
> > > @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
> > >  	bool auto_domain : 1;
> > >  	bool enforce_cache_coherency : 1;
> > >  	bool nest_parent : 1;
> > > +#ifdef CONFIG_IOMMU_LIVEUPDATE
> > > +	bool lu_preserve : 1;
> > > +	u32 lu_token;
> > 
> > Should we use full name i.e. liveupdate here and other places in this
> > series?
> 
> I think using full name liveupdate would be too long in other places in
> this series. And also there are other examples of "luo" being used as a
> short form. Please see:
> 
> https://lore.kernel.org/all/20251125165850.3389713-15-pasha.tatashin@soleen.com/

That patch is using "luo" short, which I think is also wrong in saying
memfd_luo, as there is nothing related to orchestrator (O of LUO) in
that patch. It is saving memfd state for liveupdate. But that ship has
sailed.

In the current patch, I don't think it will be too long, and it also
easier to read code without someone to know what "lu" is. We have worked
on it so we know what "lu" stands for and kind of accepted it but I
agree what Greg k-h was also suggesting.

https://lore.kernel.org/all/2025093023-frantic-sediment-9849@gregkh/
 - "You have more letters, please use them.  "lu" is too short."

Not a hard no from me, just a suggestion.
