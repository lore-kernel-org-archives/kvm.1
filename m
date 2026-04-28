Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43BC441033
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380543; cv=none; b=g72AJAKteQwhG7Fzc9V+xvWXPUwLg1xPpUNsur8HpO633K3xao95j/25uDrijpE+bhSU6cjYMSaeowNJTgF8gGlZw4mzaztNRRMlxCbgNMg/rve64Lf+Xc2hkxzBk/wrxHsHZPmqVn8zcalX8NSWyPRzB+owFLupRYeIOLIX8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380543; c=relaxed/simple;
	bh=6uQsReytJShRtVwFuY+KaKU4UtffiV2XCyp37o5sVFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ird5YFufb0NmyvLgiYbwTO4xRXXI0ag1mOrU7/vm+eCtiGbxA3/odREhHGZapgz48+ixOlrNJKBlmVvEPMitmr6dHgic/vec3LJgJsSUQYKGvik6c9ImVqxsXxcb6jmXtCVZ2dWsZdFADo/oY9ITA7o+/S6JR0/2T/ogLDvHKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CP5msS+S; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CP5msS+S"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d65f4073bfso1539069585a.3
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777380538; x=1777985338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZDznJLnR5IBM+qy2CmcyjeNtRZUzmIeFEkRhR7jVHY=;
        b=CP5msS+SeFqC0P5r+J8LIGBHHs/4982bjoP4g4YSzw2DuC+chMk5eiGfZRpnxCAqnb
         D0U/QDSySnpuFyn5z9i1tlzxAmGyMtirfxtPxmtAH5Hev1QpLDYrcPDDawrAeJezbz3k
         asw8FdWzZQBsXqalnq3g/THCx/Od0M865lnJBoISvgLLsvV1y7V1p4CQBTMMwNSXl3Fn
         cMKPdtNkFLuM9Gt12QDivSj/vVRWmVXcp/PmKn7iD1Qh+Xp1PkLfjx7Ug9sD9E1lPTTf
         Z2iKkTzjnZL3XnEujwPdI7Cl9Am8Oz6/dePGOtsFWDkCx9K4r4NNsmpgiS2GC1RMajhV
         x2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380538; x=1777985338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZDznJLnR5IBM+qy2CmcyjeNtRZUzmIeFEkRhR7jVHY=;
        b=I2vONJyFQGnFP0p51Pt+eW1HSm2dh2HdZZkDo8nGCuqs8CosG24D4oH5fTi4+LgUGs
         lFpcIjxD+rGkLRnJNVjllwsLy4FuhlyvsfagGG6zxAcz6rKOjTHMyfqVfhba8DXBa7ru
         VnMBbRt0ewsM68NDqM7Su3WWELJPci3+H/TPw7D4TUssDIs1y2IpYHu1SL19lXqB1ToF
         wD8OVlWVhOwuZVagojA7SwhfN9zQruECgz2f/OywJGBrubwOaqfOruJauhFiXvceXf9O
         GFu5ldZhb9hKB+FKJbXR6JVcegAirPQpW4g7AtKo2NITWRHBv6TbVoM3EQoLvAx3AMg/
         0Gvw==
X-Forwarded-Encrypted: i=1; AFNElJ8k8rLhtYcJ5IiM70Nq6jc0ELuMKd/vGlWAnOr8WMj4iSs+1YcZQ72yurJDxwOJM2vHTOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/EKNlabjsHmSJ2U6CFzuruKnR1Oi6vGUmFmrGFJhNI29Qs/O
	26Rm0I4mDXtG5VDs97Q3fEFPY6CFA0NQ42rcntPPSFWVFA9njqTpzXfxcmjRfIwQb24=
X-Gm-Gg: AeBDietI2+GPKNuRpfpLFD4kVbJFvP24wkbBTIsdV4xtkydv+0be89Tj+wPY4Zit6aL
	MtOAhdC/KHFYQ4C9tHnhGkfODL9usH/CSxobjBXW9wlKhAQ65DanJaBfCnag2GrCDnpgXHI0XyY
	DKZ52nJHFyxkCCY0kibHcKeVHFABpcGQSicS3/Me0e5CbnEOMMqEEaqXtrmY86dZgemOjRb9Eu1
	7GXOZWbNsPatNbl85HTJxpTcLTuMXyYNmRPtu0dj8pOzrQDhFLX/7pMy5Cm822jcnC5JxQ8rB5j
	5mx8x+I5cOPRv0fhhoxoOQgDl7F9e9A453UyvMo9YqlA+9jPtP/vJ2qm506ZNT9fBFpuBOp+k/D
	QP7XwW5FiE4LL8ChB/JVqBVbfJWKTVgv90rVMSZk+LPjlKhbvUSV4OqNIBXd4uAk//my2NYNIDX
	Q9DgUHbCqkNXUR542aXCmb1XqOvlJCdL02NtlEPluRMnxjI35yyub69/b7HDok2fcEuD02e5wcY
	dbPgzfb06XszgRW
X-Received: by 2002:a05:620a:1a29:b0:8ed:2b66:9ec3 with SMTP id af79cd13be357-8f7d72475c8mr387065185a.16.1777380537766;
        Tue, 28 Apr 2026 05:48:57 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c7cd2c0dsm183064985a.26.2026.04.28.05.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:48:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHhry-0000000AVug-1I54;
	Tue, 28 Apr 2026 09:48:54 -0300
Date: Tue, 28 Apr 2026 09:48:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 4/4] iommufd/vdevice: add TSM guest request ioctl
Message-ID: <20260428124854.GA849557@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-5-aneesh.kumar@kernel.org>
 <20260427140539.GE740385@ziepe.ca>
 <yq5acxzj1dwu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5acxzj1dwu.fsf@kernel.org>

On Tue, Apr 28, 2026 at 05:43:05PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Mon, Apr 27, 2026 at 11:40:05AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> +/**
> >> + * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
> >> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
> >> + * @vdevice_id: vDevice ID the guest request is for
> >> + * @scope: Bus-specific scope classification for the guest request
> >> + * @req_len: Size in bytes of the input payload at @req_uptr
> >> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
> >> + * @__reserved: Must be 0
> >> + * @req_uptr: Userspace pointer to the guest-provided request payload
> >> + * @resp_uptr: Userspace pointer to the guest response buffer
> >> + *
> >> + * Forward a guest request to the TSM bound vDevice. This is intended for
> >> + * guest TSM/TDISP message transport where the host kernel only marshals
> >> + * bytes between userspace and the TSM implementation.
> >> + *
> >> + * The meaning and valid values of @scope are defined by the TSM backend for
> >> + * the device bus type.
> >
> > If you want to do this then you have to also provide a way to discover
> > what the TSM backend is so userspace can form the correct numbers.
> >
> 
> These guest-driven requests end up in the correct VMM backend, which
> should already be aware of the scope value to use. In the case of ARM
> CCA, the RHI calls include a device ID (vdev_id), which the VMM can use
> to determine the appropriate scope value.

That seems kind of indirect, we technically support multiple TSMs in
the kernel, how does it all get reconciled?

Passing overlapping numbers here without any way to tell them apart is
not a good uapi design.

Jason
