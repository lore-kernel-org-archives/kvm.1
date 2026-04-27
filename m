Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A393D1711
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298743; cv=none; b=lN9l4ZKByGFtpiVr/qPkgruhll5PM7TRQCY5MfNidynnIhabj6cgZyGFxCJUQG/Nv+tiGIXRn3XOHeBExGRt+DD62ENAe+J8spF6VIQMammghZi+SuFH4oxMLPheH6MuTEZ3i5wYVF4s7B6s+aXgTKpGPy0IsrNUQPfN/RkBWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298743; c=relaxed/simple;
	bh=iGS050Vh31Rx6ADQYBwC5U1aYufsbvINEeiUPc1swZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJyY6/XdteZ+QSlROieKJ8yXefLm91WO+ST4nELf0iUn02D3O5qytAzp8PuC46VD34DvU7yO6ATtB+1hZdsbfbtvWlfsftwS97Xt6vhWSDpwQNPoO2lrIJ9zcj+PZbvHz0xE5O1OHpMgH5isuRUJT/5aEY0nuHfA45ZBfs8LZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FZj4YQ8n; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FZj4YQ8n"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d736211595so671445185a.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777298741; x=1777903541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGS050Vh31Rx6ADQYBwC5U1aYufsbvINEeiUPc1swZo=;
        b=FZj4YQ8nEy1EHgskPUz2LFFSRfYdc62Nvfn6izixWeYkTxE0DRvuABG0+v+JMkbFkI
         GJNnCyWhe3/VnozU5z/lmQFnC7nL7WTfrOGbG6+6ngbdbuRM4nFdSbvFvZyUfMk54xEf
         XoIyVyC6eYETNPHVdA7jiyxY0skxpyGxpMbVGyLYrk+dtKzs/zUAAopc0k5eLVKjfb8D
         u8Gi8W/e4PVVXx500x2P6eVBrDys3zkRfSiicuYqwaPet8PRvaPUUaMDjw7rA0DPXWHF
         5sOHDg75t8HNmbOOo+z29SkvrlKnpBK7lIbAOZCEIeLB7I7FKeXAynV9tQs7sgVokM42
         RYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298741; x=1777903541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGS050Vh31Rx6ADQYBwC5U1aYufsbvINEeiUPc1swZo=;
        b=CTjX94z+GKdeqfRP163EidDj8OwgT2rGAw5D3ui+/NTZYeEDdhv9GxiiX67+76lrv7
         sJlxSoYip6+efLXwC0qDneyLtTMbURGo3WfqOhQyOzNxRNzieCUWFD18KznvCR3p9csg
         PB72ZKKoCt6INLKJkK4EQsutr/1KS5wczPavzgWAcw/4Yqh46aPi4t9raEnoh0yovHNY
         rvjk0UQ4KngUDNJSQnJh+7pGt34vOhuzXgTBIsU0LiWHjPMl2Dj0Do86NrAg33hwL9u3
         mb3RgBO3KIF2AXuXQvKjKB22mKd3ai0uJZVPrzZ82tTqinLl7qm/AJrKt9Ddvrd4zqzu
         +oPg==
X-Forwarded-Encrypted: i=1; AFNElJ9TU9yUsOy5kWNuXJlj7+H6iu5MhDgsn1I3z//YnIPcc9DGMB8m1tvKrMpC5LF9n8FpkiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINNsaGuzxEzC7zPzXTyG0rMZPJs/HLO/M7wp4ds+zIb8ad7Wz
	PwyJ/odFtZlPwLvlVRsRN++MAYA2PTDpa+DrO1SeuP9JPOqrqE+/Z0VRLBUFCGls7Og=
X-Gm-Gg: AeBDieugJuPmZQp9eAkKisLjvf/M45MyItXXgAMoamZWrVcYf3SdU8E/WErZ9urR7N0
	4LNqpJZfzUZEv05+Y4zD4arLlbxDl7RQgR8hEKzU5pIyARJUuPBbKolqHxwN4clWsWIQCXCwks7
	TSfWnajtl2SmRU7rJ6MI1gwQQGUnXNzuStGu/NZNhG75MS8f3Tw61vIVgVG7B4dDs6EFACxh5JP
	pMCRtlCi4ygKQDQrK6RXmwVfDo0OyaMrS/KMPr9amOqwNz4uG2GL0/t1b8pRff7+zrqjg5zWQx+
	iDj4bdujsTupJlmahUMg8iNamyIRFiCbpdeumzh6H4UzB3QXvZ4a5YVBk5u0Y0vm2RHvTlmH3ht
	+M4+HeHQ89dWy2bRYob3OLzhiCD7HcNaQdInAJrXgFPfRwUcv+i+Q4+4jx+In/trJdmlpyjr5bJ
	YBvI5X4J0628aZi01yJlEQ4rADBEVqlOUjrQq7L6pzAtrVdo/NmIWJXno7RBBMTfjsIhfIBAYn9
	oZ1WK2MItpXJnAgLLqOC9RQt0M=
X-Received: by 2002:a05:6214:489:b0:8b1:f3e1:5e12 with SMTP id 6a1803df08f44-8b1f3e16020mr426493366d6.14.1777298740980;
        Mon, 27 Apr 2026 07:05:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac4260bsm260265136d6.4.2026.04.27.07.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:05:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHMah-00000003YNw-36NU;
	Mon, 27 Apr 2026 11:05:39 -0300
Date: Mon, 27 Apr 2026 11:05:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
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
Message-ID: <20260427140539.GE740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427061005.901854-5-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 11:40:05AM +0530, Aneesh Kumar K.V (Arm) wrote:
> +/**
> + * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
> + * @vdevice_id: vDevice ID the guest request is for
> + * @scope: Bus-specific scope classification for the guest request
> + * @req_len: Size in bytes of the input payload at @req_uptr
> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
> + * @__reserved: Must be 0
> + * @req_uptr: Userspace pointer to the guest-provided request payload
> + * @resp_uptr: Userspace pointer to the guest response buffer
> + *
> + * Forward a guest request to the TSM bound vDevice. This is intended for
> + * guest TSM/TDISP message transport where the host kernel only marshals
> + * bytes between userspace and the TSM implementation.
> + *
> + * The meaning and valid values of @scope are defined by the TSM backend for
> + * the device bus type.

If you want to do this then you have to also provide a way to discover
what the TSM backend is so userspace can form the correct numbers.

Also, since scope is now a uapi whatever in tsm is defining the values
must be moved to the uapi headers.

Probably this is not a good idea and iommufd should just have its own
enum with unique numbers for every bus and do the validation and
translation.

Jason
