Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE8E3B5842
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533201; cv=none; b=PQK+aEjkm6m9kfHkf8qFNxGynwWdM6g8r2a7dw8JKOA3gl3DvpVKRL9pubw8cLtfQWfLh5eigFh78751cC9J+davnBjlUMmffH3URyIAS0SLm/9gKMirsABV4JWymfKrG0/OMcON1d92kWadWV2bPZzFrDCJirNI+6H0AAK0UtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533201; c=relaxed/simple;
	bh=L8TB5MngkKT+d7LkzD76You/wGImnIpc7sOqQQhGjWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dahPjBnj2lnhNnk20YPTFIoy2K+x0couRHa6NbKvq4jy0cfby7Gt/fkcsNG06+i4ay9AmY6A3FfWJuXLGW2dLwiYOGa42Cf06cn2oO2GC0wP23weeC0LLU5LSzjbUVPJ9oAN5MqMR06E7BcZ/WpkqQleKl0GXuUKJbMMahZUGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGeVj0zt; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGeVj0zt"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ee990e8597so8311141eec.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778533198; x=1779137998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNb1Mc2z2vf30mF3+31aIENCyqLZD7GKuMiZcpFYhWg=;
        b=lGeVj0ztZeNKkNtehsXvWWsSt3IRIB2w31NBxSme7UI3/RoBK3fRznBgf2YV98+x3u
         qWpMvhbJ5Vwn7ODBeSVCbFeanOl80KZN39+acyKF0hPXK5Z1T5dlVKgEuwGDwG3+rpvf
         0R4WZZeiaLlKvCDCEH7vdzhN2x/+IQHWVRswjxgbwyr33hnF+JkgCCNLZWQQB3LAw35L
         +gtLmxYCNiL5o3ItcRZ2U1ipw3IK/BfokDI3MKLi1mjnXXq5lPO+TGaD7xo8YPkz/H73
         IZeZr4PXy2wFZzh7RbNWIoppl9ipUWnz8qaCg2aLfd8gPyqpsVgkCWWhpPIocVLPEUi5
         hASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778533198; x=1779137998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNb1Mc2z2vf30mF3+31aIENCyqLZD7GKuMiZcpFYhWg=;
        b=FJ3kMqJwK4RJWTL0T3Fq3bfVtls2H7qHdmJIck6JWZWKcbYzzBh1UbdtvnZBnKGkP0
         9c8a/AQV/Y7xD6/OnerILo4qXOu3Fe+w+4D3BhwQc/it54oJPWD3JyNmu7uVQ+xYS+hQ
         4tHzBiZ3iQk8Ihks4NHVj1oqIOF+nTu48W0R3AHcB8ISMUVwVTm/VsaIJNoy5nzVJSGt
         S/bliLxodQ4rHoQukLsTt4F2RmlUelPfjgzr+J/TUE5pNUTKpGWob2vVPexJyiMFGLYP
         Jbxp/Gb6wogt5fS1ApWOZmIuvRHnx3ilOFMJjoizxMtxzc0ckK6paukY+2OjcSgGvHqx
         LbWw==
X-Forwarded-Encrypted: i=1; AFNElJ/vnTlk3Ir8lTE0DD//HEoCU1xx2W7qLtNihIUPhi3/ZeF0sZEvObCWp7V4JTPwRGQls+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GedQaascP/cKAN1MJgXf0YUhdqYEdoE9Pd2Geq8oVOBow3pg
	j/cInrQoXoDR6Dy1I7K3s+vAgBx/A5EkA7eKStSAd0xRCVN2d+jiqo79lHBN8F7wfN8qJ+L5Di/
	zSOklGg==
X-Gm-Gg: Acq92OFltzd/FeXKWjm2IpKUVGnfhn2YNMeirFS81I9xZ2aEhVKR5PLwfyJY38gCFxr
	2tqMMa8Khz3vsBQi468fU0ZdJtqLYFHAdZ4idTUGeEhey5mymcNyl1dThJWpE8tcR/pe5gdlLgA
	WdrCxJmczaSX9H7XJOm1NnslP5vwKSApkD135HYmLhJQpPSlv7MnzCApIZGAq/YMxCDHlQqTViG
	1KCoC5eGgHlgaf/66q96QdhV0ZzFxdqnvaZqkjattbpMpBkiW0wc5VG4Iw2/oUBzbURCC45wg8A
	fZZDbMjBdWaevfHH5H0svNoQiOIB0CqHqFcqcC/R+ubgPq2S1rJst7uwFb7qU9VyyqZhhIdhHSE
	RZQ+G1VZFjd7EyUDhB/Lz/HCG7gAsUF7XPv/yl3R0fGsmbrHJBE/QTPUMcoOLXmbDNOX1Ak1UGm
	42VC1RthAO8tLjw9b7tb2AxCRMR3mcoeNuUPNr4laqsW8LXX/fISPhZLdeM8TOpICbsnfVe/Xp
X-Received: by 2002:a05:7300:d003:b0:2f9:5c29:ffb6 with SMTP id 5a478bee46e88-2ffd57d062fmr141571eec.13.1778533197825;
        Mon, 11 May 2026 13:59:57 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c3b301sm18765580eec.23.2026.05.11.13.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:59:57 -0700 (PDT)
Date: Mon, 11 May 2026 20:59:53 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Aex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Alex Mastro <amastro@fb.com>,
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vfio: selftests: Add support of creating multiple
 iommus from iommufd
Message-ID: <agJDSaAmZYv_5byL@google.com>
References: <20260505221518.619123-1-skhawaja@google.com>
 <20260505221518.619123-2-skhawaja@google.com>
 <af4or28EA6PGEd12@google.com>
 <agI2EFvBwKUHaHVi@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agI2EFvBwKUHaHVi@google.com>

On 2026-05-11 08:21 PM, Samiullah Khawaja wrote:
> On Fri, May 08, 2026 at 06:17:19PM +0000, David Matlack wrote:
> > On 2026-05-05 10:14 PM, Samiullah Khawaja wrote:

> > @@ -478,11 +483,7 @@ struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id, u32 flags)
> >        struct iommu *iommu;
> > 
> >        iommu = iommu_alloc("iommufd");
> > -
> > -       iommu->iommufd = dup(iommufd);
> > -       VFIO_ASSERT_GT(iommu->iommufd, 0);
> > -
> > -       iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
> > +       iommufd_init(iommu, dup(iommufd));
> > 
> >        if (flags & IOMMUFD_IOMMU_INIT_CREATE_PT)
> >                iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
> > 
> > > +
> > > +	if (flags & IOMMUFD_IOMMU_INIT_CREATE_PT)
> > > +		iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
> > 
> > Does this need to be part of iommufd_iommu_init()? Maybe it would be
> > better to expose a separate helper to allocate a HWPT for a given struct
> > iommu *.
> 
> Hmm.. that is interesting.. I think we can have following immediate
> possibilities when creating a struct iommu (there will be more down the
> road, but can be handled in similar way):
> 
> - create using struct iommu with a new IOAS.
> - create using struct iommu with existing IOAS but new HWPT.
> - create using struct iommu with new IOAS and new HWPT.
> 
> I think I should probably add following flags:
> 
> IOMMUFD_IOMMU_INIT_CREATE_IOPT (IO Page Table) or _PT
> IOMMUFD_IOMMU_INIT_CREATE_IOAS (IO address Space) or _AS
> 
> At least one of those should be required when creating new struct iommu
> from an existing one. WDYT?

I don't love the idea of passing in flags to control the logic,
especially since not every combination of flags is valid. And also tests
would be required to pass in dev_id even if it's not needed (first
possibility in your list).

Maybe add explicit helpers for each case?

/*** static (private) helpers ***/

static u32 iommufd_hwpt_alloc(struct iommu *iommu, u32 dev_id)
{
	struct iommu_hwpt_alloc args = {
		.size = sizeof(args),
		.pt_id = iommu->ioas_id,
		.dev_id = dev_id,
	};

	VFIO_ASSERT_EQ(iommu->hwpt_id, 0);
	ioctl_assert(iommu->iommufd, IOMMU_HWPT_ALLOC, &args);

	iommu->hwpt_id = args.out_hwpt_id;
}

static struct iommu *iommufd_new(int iommufd, u32 ioas_id)
{
	struct iommu *new;

	new = iommu_alloc("iommufd");

	new->iommufd = dup(iommufd);
	VFIO_ASSERT_GT(new->iommufd, 0);

	new->ioas_id = ioas_id;

	return new;
}

/*** Public API for tests ***/

struct iommu *iommufd_new_ioas(struct iommu *cur)
{
	return iommufd_new(cur->iommufd, iommufd_ioas_alloc(cur->iommufd));
}

struct iommu *iommufd_new_hwpt(struct iommu *cur, u32 dev_id)
{
	struct iommu *new = iommufd_new(cur->iommufd, cur->ioas_id);

	iommufd_hwpt_alloc(new, dev_id);
	return new;
}

struct iommu *iommufd_new_ioas_hwpt(struct iommu *cur, u32 dev_id)
{
	struct iommu *new = iommufd_new_ioas(cur);

	iommufd_hwpt_alloc(new, dev_id);
	return new;
}
