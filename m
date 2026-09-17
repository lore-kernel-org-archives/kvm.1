Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7838579813
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653778; cv=none; b=YWF1hWlPaWO1vfAmpryb/bjkr4zd4M1/CeDJM3DIm77QkmGNcRkNz47U9UQOhJk0dWe+I5LoIoEuF6lAs4CmF6sff0ruHJVTXvccqbfomcsuvKsVRNIASRwXigDfKHjg7uf1ihahr3wFNMazwz12UOgNhZTzR1UddL3u4/iFbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653778; c=relaxed/simple;
	bh=5WF8VcNkm/QhAqH+TgnbaHxVovZYWfwOqxhhljrRvjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu43u6G0SS2fuGo8AokClcrKURaLCFloBBcdLEMD/iJiYflHMDdmvtGFgnQ0d3yMQd0gQn15U+ZcL2PiMeEL8JbvOswyQmPNHcdpI9oGsGt2llpZmZuPB89w1Vnu4u0/PIq3X8Aavo93YITLP1fi7u2j6wohH9Vihqc1vO95D40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OVEWn/ds; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OVEWn/ds"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-980b6159d30so212595241.0
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789653775; x=1790258575; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5WF8VcNkm/QhAqH+TgnbaHxVovZYWfwOqxhhljrRvjc=;
        b=OVEWn/dsUGk0Myco3X13NbUxQ2N6DqBM+3t+cl0zpoHxP6xtU+yXBGIcmtWaZAW59F
         yPlozK/9GLNCzTZ16jyK8rZW54T0IkPSrvLHiFew2qITy1XBgR7SJxcgH6Iuin7S4TDl
         bSJnKhV8eIhYNUvNdY8qzrTjQU3NHE9fszm8w4B3e/REeJC6jZ7nG300iARqT04ZVJai
         UOYZzu3RZCp9zHqZHgyJioDFLuiqO255MyFWk1klwJHcB0FP3UDtSChNCxaTuMvm8oFV
         lnv5UYb5jN0zo+pl5fpPOG2xgvvKOvnZh3AfFvU9txO14Py8ReHD1/Yk/BGr+1H/fCiJ
         l0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653775; x=1790258575;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5WF8VcNkm/QhAqH+TgnbaHxVovZYWfwOqxhhljrRvjc=;
        b=okA+30JZKmTvnMmlR0Iissdco9Ck1mau5Gnli7apfE3Hb+T4SWM9O8fKSHZtNzhFZO
         lhmedSDzOiWGUzomyaH2D9gW7iJOORUXwj+pKckR6JVvsQfhe07RiNRp1b6f+SH9CU1v
         zPv/TXNQbgOkzU7wCkW4MK5k2lLk+CFQD06Lfkw7KsBs6bVcojKP0hxctHc5T2kTYGY4
         6e5kQ+r1dah6JNKl9bI/mytYHxnsMtirV+WfDL7UK9Xcz1gdGmmgrIgKK3uoecuoCdG0
         CHlwpzeMkq/JXu9aAYI0AXdN7UYnahUekmJ81y6AhoObqhppArIc+mIbhyIX0foId1D1
         Fyyw==
X-Forwarded-Encrypted: i=1; AKwUvBy0dx4dsNXOx/9lIbgvVKW7viK479h2QQ2Uh46A5J9KihMCSbiUCuTRvR9hP7zbmflbAHU=@vger.kernel.org
X-Gm-Message-State: AFuF++k+5N2+Ll79/U3Vgh8X2NIVvYZA6gCsppVVkW/PwX0l1H2iOVx8
	RR6PHI6dc3c5mHq2FDPbhUmppN5gqbfkB5VALVeAe6qluWhYln1MdfW6lDtGW1JPC+A=
X-Gm-Gg: AYBFou2HfoDR4x+zAntfiC5BSZ31vDi4MIxiehijzbUKZjhrCIX2DTg70rgZLcb8+VC
	ZfXPHjHP+AYAWZ/8GpkVXhZS1/YKJEryCna81Pt5mM1MXfkDQ83+yzhdE41SEzC44mEXny8NBsb
	l+DmUX8rLmxn8rPxy6gYlzCRcBD0Hk/FZG238wefGfG/VlOl6j1GzH2sM31oSzDIlU/9Kh13m9J
	aBxfHYT+AASOxrErq1Qp5QmnizAg2HzJo91v9ZBPf17/oD2LhQjEAF1Qour0hjw56jaAFpOw1eC
	6rwXNcFTrtoA2fZ7rGGiVFvHrNce44g57YbRNOVGFmGZ97mQuA1+JE3N7AE+LCsfIULHOAXFWM8
	6/aInqyHhi5QpgLHA8YJmoPaxztVgIu/j5ilIkfiOpvrnpL/s3cdtQ4h5PlzfoXvI2M5u2Fx8lA
	KFziT5GT1rILMI8FYHfL9bvePVZx3RKBwoK90MYPHFSSUUdOvnvhzJv7fLF9VhNOcm2aTZjpkOr
	UzG4A9oIPZk54WDO/tuJAB4tEGFC576lPXjcaUoWOuUYkheLm+UV/nu
X-Received: by 2002:a05:6102:a189:20b0:7a2:63d4:3d25 with SMTP id ada2fe7eead31-7a263d44d51mr364707137.32.1789653775451;
        Thu, 17 Sep 2026 07:02:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123bec59fasm50600486d6.39.2026.09.17.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:02:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7ChR-0000000Co7R-3O0W;
	Thu, 17 Sep 2026 11:02:53 -0300
Date: Thu, 17 Sep 2026 11:02:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260917140253.GG3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>

On Thu, Sep 17, 2026 at 03:56:12PM +0200, Thomas Hellström wrote:

> That is, a flag to tell the topology check that some transactions
> *will* take the host-bridge path due to IOVA being used, and that the
> computations including pci_p2pdma_distance() need to check whether that
> is possible (checking whitelist etc.) and return the corresponding
> THRU_HOST_BRIDGE mapping type. Translated transactions taking a short-
> cut using the bus-address would then be hidden from the driver.

I imagined it would work by the driver passing in what modes it
supports and Intel GPU would simply pass in ATS only.

Even something like mlx has variation, only some operations can opt
into ATS, many others are never-ATS.

Driver should not make statements like " *will* take the host-bridge
path" since it has no idea.

Jason
