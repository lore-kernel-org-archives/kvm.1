Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20934DCCD
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125542; cv=none; b=OW2dm3ZvOhA+gU0bRbj2AYmNls6E7SVDo2iLvUMLz7mTHFTRjV5Xct4ulEouDbzE+1VezMqEYOI3E6zXpEus1rcKFxDHEGkQag9frPv41MpIoXWtZrkZRykkF/u0B1jHW/sL87Kffhp5ChrWWXEvx9eHcXXHyaWY9C8f0h21lxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125542; c=relaxed/simple;
	bh=Q3cV5SAH4cDTYH2vXZ3VzY3UQDOIWARtFNZRDfTMEpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjaoBDn/EMveGGA8Uq/Z8oUvTaycAukiZ0Q5Dbqn/YxpHb+1Jk/MNylxidna9S060FBWlcWyh/nwTQ+jzK+B/37gj2yySZVcHYVlpmncHYzmZ/TBLnpPj6uC1KDdKUeuveOOHgAbF5uvw+Wil2VmXCxPZSgXEzkltkdAaV8KpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHDseSSx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHDseSSx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso265ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779125540; x=1779730340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtXGNX27t5qmY2uaruNm0Z8Qvs9s1VMC3BIDapVx9XQ=;
        b=sHDseSSxk7zRMnVLTPGEonu+W5B8t89m3TG8oqIXbaj7cIGQC3aSlyBtQKekD997p5
         JO4SEvI8YBbs7Em5DmNnLIlwOZkSXgR659geHoA9DTttIKRf1DlPsoPaMzsJDeVxuCbd
         WwMyVa6uKAVGtPahfibMo0+s/0zdP28iYxugfQwMWKFq/WlLoarFY8nfq6V/geWN9tOE
         Y230zfRL7dqNz8v+8tjE9cb/sdc/OOZIO8n5bMgxcxxJLD6WsGeKM5RHo5fXNOtktxBI
         Tovytk9tLBE4eJ74c0/l/e7H3Fa8zTZLM9lHoabdf1PlC9taBBqMenq5lIprcpz2e+K1
         wgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125540; x=1779730340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtXGNX27t5qmY2uaruNm0Z8Qvs9s1VMC3BIDapVx9XQ=;
        b=eBkPWPDBaQmumHQWBXcKPIcfPKdiCoCmaU9EuiczpxxK8jL7hSpogpD1uORzkN/pKU
         6iIffA2qbRrjNPusWreGGzl8+uJGRz+8CQcWZia7/6EdmE8zzsXsdkRxnkw3e/oEDBQk
         6/jPfiMrE2uRFNMFI1iQ20LmCM1lcsvmg1y9SSZ3ZXmU2pcUT7lvwRqZ+QQQu/AFX5eS
         CNaqF53LdGcwjbDPALu/TRWRVHx/uBvJOuFSJScE/SHNjanOAouuFNSXHwt6lwvnEgHH
         3acCr/CIxD6uXt1UlP5Qr14OnzhvujoYaCJhI3Oe2Gq0l7RuCslLzZmcSl6GWfrHwcat
         E85g==
X-Forwarded-Encrypted: i=1; AFNElJ9LmUsA5bPuaMxeqtBn1bosZhuA3WjvACDeJT508o6kgtxSMMwROetu6rvCjplAsmDEXlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPoAAsq/cxEMioBxOdrtby4j401KYhg42CU8g1UqoKOgeteQHE
	VhyCMKxtEVycB9ZPMyY0Q+AWWX4fTYtWjp0dI8pzIbTTyCK5RC4WvHSSWMdDkv5BTTP5E3CGNbY
	RsxNj0Q==
X-Gm-Gg: Acq92OHmlVTVFg1Pl5Z3T7KZTqn+htq8hwAfwiqoBCXZo1KS0RXXVYzePcw/BehGamq
	yvdzDEH7xAXh+4G9l7JBg1YmyBJF8DtUZUIdEhh3JhKSH4a62cqVn/68vgfNAw3Rdm86CNvwytT
	tsGeAd0Q6eyWstR7maWcpySgg5ZwEkzLDs/JOzczHYc7W63nBKz+GTf+oKFFlG3zmdtR4XAkQZs
	11L3GpNd6xfh3+gKNuDcQym0uOlPtJb0fcCCTanl6pSVu85U7Org36LA9pM4UNCLlzO9LUC59Qe
	fdebnTxgPcu8SwprHz68GtNy1IO1A4jWoYKlZz9DWasHJ2xXWXm2vuyLcfgUeWgh3DS0qIjkl1v
	SrlVWnnRHsAYXUA+EooLCFfbYCqDyP4aR2KHpY9TtPzXDQtUzS2VMjKS2CM7ss7GAc0SA4czy2s
	zOLQ4v8ubhQHZOLO94LUUebtC0yDwhKbtroN+ap2XOmVfH3OxQ/XfEB7CRwf2ef3ovLONF
X-Received: by 2002:a17:903:32c5:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2bdb03a42c2mr3669485ad.4.1779125539725;
        Mon, 18 May 2026 10:32:19 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm159631115ad.14.2026.05.18.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:32:19 -0700 (PDT)
Date: Mon, 18 May 2026 17:32:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Matlack <dmatlack@google.com>,
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
Message-ID: <agtNGieEnxNPxXEe@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
 <agsHFbI_FQEXiZAA@google.com>
 <agtHykqDImuLL6nU@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtHykqDImuLL6nU@google.com>

On Mon, May 18, 2026 at 05:20:40PM +0000, Samiullah Khawaja wrote:
> On Mon, May 18, 2026 at 12:33:25PM +0000, Pranjal Shrivastava wrote:
> > On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
> > > On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
[snip]
> > > 
> > > > +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
> > > > +{
> > > > +	struct iommu_flb_obj *obj;
> > > > +	struct iommu_flb_ser *ser;
> > > > +
> > > > +	obj = kzalloc_obj(*obj, GFP_KERNEL);
> > > > +	if (!obj)
> > > > +		return -ENOMEM;
> > > 
> > > Should this be considered fatal for the same reason
> > > iommu_liveupdate_restore_array() is considered fatal? If anything in
> > > iommu_liveupdate_flb_retrieve() fails then the risk of corruption as
> > > described in iommu_liveupdate_restore_array() is possible.
> > > 
> > 
> > Righ... Nice catch. I suppose we should BUG_ON() this because
> > luo_flb_file_finish_one [1] returns void. Thus, if we return -ENOMEM
> > here all we get is a WARN_ON without panic.
> 
> The error is propagated by get_flb_incoming(). The finish path has a
> WARN. But that is fine because finish won't be called as can_finish()
> will fail if FLB retrieve fails and restore cannot be done.
> 
> I will add a comment about this here.

Ack. I was looking at the finish path as it doesn't propagate the error.
but it won't be called ig. I assumed that there should be no good 
situation at boot that would cause -ENOMEM. 

In case we're not panicking for an -ENOMEM and letting the user decide,
adding a comment would be great.

Thanks,
Praan
