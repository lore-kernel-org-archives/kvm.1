Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0333D75C7
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300159; cv=none; b=iaHwFcoE/b87D14BSYAlk5lDO0ld5ukMCemvN1tFJrCXSyY2f3MX7WsFYg0qhEv7z2Tj3c0xUt88MnpOpSehPk6xFdpkyERaRtHmbBYF2QFma/0dFD9Cad3NXvh2KSt4sBhN2yz9X4yX+ZhqVCxcfRHa9g4LF0CXivadLLagc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300159; c=relaxed/simple;
	bh=gSR9ZF8mEMkIrcPGA22VrdnTF1lx5yIEAf4xXGH2nlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ify7jxThJ25PkslDVwRJxbQYiHobb+zWrodage+2m3qYVHghayvi7OngyN7PAPRHRl6I/B0z0i7KgkODdClgi4NFhs56Zu90k0h3M+14FXiRLH0B06RUBVOgLgwbhypxlnbT1pT8EYXVwJJZqVE2kA3YhixbBWmz5ZKaUUXla28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jlv/ydKo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jlv/ydKo"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso3405ad.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779300158; x=1779904958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKj2nsEFhwe3iqBMbsJt9SioFDYUGDCac39gv/hs+vE=;
        b=Jlv/ydKos+5C8eESq9DBs8tkE2stSoX5Yhg/En0j/ouRXkEPpPPe56b/CLg+eN8Zwl
         ZLy4w7smEfBmP2lnbDCEl0jp3m/hVai9G+HlbBY4Py9/yf7r/f8ROrZhwIeVHF3hYK4m
         5n1+7sN7LlGWiDSa2SukyP4L8h39KZjDzvIlGB3t3QnpHVfRFgepNfcwc0wfM+XwP2Ik
         JpQHJ40FMddVhIMMH+QZ1kMv29n6mLlifvXUn22KRCep1uEccdcWywPEvC7aSiff6MXN
         NwQJAvZ3mwKwDZZ7LwiYYfkhgxHY+b/iw+4h2Fjyldzbxs8DY1mYta3LS2jASKeAjh0Z
         7KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300158; x=1779904958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKj2nsEFhwe3iqBMbsJt9SioFDYUGDCac39gv/hs+vE=;
        b=Zn9lOW18BgF/O4jDx/ReDA82SCxEie5cmwkoefwSV+eQjN/snyZlpEdxYKo6mA0kni
         HY315F9ZhU8rlXuneDZn5+r5abSINKW/0HLhVoe6y2B4iF53pYj3mQxp1hF0j97phgNH
         JtL1j0lfWY9ijn9I3elrk1JHwnql2ikxYO408pJ2JIEfmyCJxJigj4IEil9h9BlbG+Do
         Rd2rkoEPHVSA/r7xiNu4+rDe8touo58WX/i2uWFCoLYHKYB2mJi/ulJasvDev9ww3/tP
         woyUFvY5ZcpECz0wwO41du+Tl9ljuLUTo4SJZm9ToOytT0Rgl+ikTayOcF7C/MZtOd7h
         ZP7g==
X-Forwarded-Encrypted: i=1; AFNElJ/tcdPwET3KxP5lKwsNCayzgujPL6wL914d947piCu2coYaxsZKMBCnxc+IFLb4HYoqPS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyusDkXnLs84bGpLW0cG0mvWawK7twfWq72sPfJNhxjig6mzMUx
	ope/pZRGeY+8w5IPgzuhplYy4G9fVSCD5Uq8wX+K+KvW0/N3dnN0n/eR67jkBLzhBg==
X-Gm-Gg: Acq92OFoaFDXbSbsGZfrGVaNER/JF1xGkghSKzbSDO9D3WOWpwGPk55BG6BHtCgOguz
	bjBIdw4uf/ahOULWFsI1APFqcJVfgdWZy1Rp6I8vNiWUhh9ICHEjk8uzwyKN1Y/V7qqT/GALRrU
	hgg2+VGF0tbxG4z5Mq2suu+WcXdpHVSxwtfuR77FclQLKHIbVU2TqnTy18EQ+uLl/t7o9quNTyC
	lY0YHK58ycfsZwfdp8EJVcE1xBHnu8p967JFN/hzA0iC90WnmyJsV4PIUCEyo2eOFEC16Xc1TNZ
	7aaoEPxdviBV2g4LwmO7HOZrXw2iFFp4N/c5tQeuG2SB+gHpCgTpfSS28EFZpTZu8+kNZeLJeam
	KUMlA1iC8rWA53YKSsztLvoczAmhiup4us3aQihS1YSCoLvmb+TuFXSKrw8h1A7YNq7BdzYtRWc
	h2qVrfJra8W3Z/Dp+bWeP6n2u0SPldQTfYOjeL1O7D18kOv25xoUeVeqihF7L/1byuAQsW
X-Received: by 2002:a17:902:e749:b0:2bd:6dad:7cca with SMTP id d9443c01a7336-2be9f4474a0mr220335ad.22.1779300157257;
        Wed, 20 May 2026 11:02:37 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb0ff0edsm20807015a12.20.2026.05.20.11.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:02:36 -0700 (PDT)
Date: Wed, 20 May 2026 18:02:27 +0000
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
Subject: Re: [PATCH v2 09/16] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <ag33M2nqVBWXdQHX@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-10-skhawaja@google.com>
 <agzaTPROvwVO-3lO@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agzaTPROvwVO-3lO@google.com>

On Tue, May 19, 2026 at 09:46:52PM +0000, Pranjal Shrivastava wrote:
> On Mon, Apr 27, 2026 at 05:56:26PM +0000, Samiullah Khawaja wrote:
> > During boot fetch the preserved state of IOMMU unit and if found then
> > restore the state.
> > 
> > - Reuse the root_table that was preserved in the previous kernel.
> > - Reclaim the domain ids of the preserved domains for each preserved
> >   devices so these are not acquired by another domain.
> > 
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >  drivers/iommu/intel/iommu.c      | 55 ++++++++++++++++++++++--------
> >  drivers/iommu/intel/iommu.h      |  7 ++++
> >  drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
> >  3 files changed, 105 insertions(+), 14 deletions(-)
> > 
> >  		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
> >  			iommu_disable_translation(iommu);
> > @@ -1648,7 +1661,7 @@ static int __init init_dmars(void)
> >  		 * we could share the same root & context tables
> >  		 * among all IOMMU's. Need to Split it later.
> >  		 */
> > -		ret = iommu_alloc_root_entry(iommu);
> > +		ret = iommu_alloc_root_entry(iommu, iommu_ser);
> >  		if (ret)
> >  			goto free_iommu;
> >  
> > @@ -1732,8 +1745,12 @@ static int __init init_dmars(void)
> >  
> >  free_iommu:
> >  	for_each_active_iommu(iommu, drhd) {
> > -		disable_dmar_iommu(iommu);
> > -		free_dmar_iommu(iommu);
> > +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> > +
> > +		if (!iommu_ser)
> > +			disable_dmar_iommu(iommu);
> > +
> > +		free_dmar_iommu(iommu, iommu_ser);
> >  	}
> >  
> 
> I'm wondering what happens if init_dmars fails for a preserved iommu?
> Since we have non NULL iommu_ser, we'll skip disable_dmar_iommu and skip
> free_context_table() inside free_dmar_iommu() as well. I'm concerned we
> might leak some resources in this case. If the failure happens after we
> set restored = 1, even a rmmod -> modprobe cycle won't help fix the leak
> 

Re-visiting this, I think we don't need to worry as skipping restore is
the intended behaviour.. we don't wanna attempt restore on things that
have already been restored. Please ignore this

Thanks,
Praan
