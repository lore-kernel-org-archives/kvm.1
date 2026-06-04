Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227847DFBC
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583168; cv=none; b=Z3UYWrVj1h9aDk7D8Ha/c+o2VsHntNVMcYYbAN48/AQRYyWIg3v8mF/8OTHzFOVPlPDcHVmKGL7klw5BJz+xgOXQX+qHbPLkJEt6x1jqc4eur0WIErWdU5j9RzmsHxTKXkQWxqnHJnuLYJKnU0IcssxFm0+sQ6hRezih0bcBw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583168; c=relaxed/simple;
	bh=RpbeXNzXxaadmZyS/Fy/cu0dWgb+zuhOaJLik03FN/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHRwYv/3HBeeasABmGk1yKAM5ptab4OPM3dn0qtk9hExCajMiBOTY8SFpaYzQuRzKAzcUK80d8yujIXx0EKWD43yrZdCOHKJPmyO0Hq9MtXgivgWRHjTs8sgqMcVCIUApMRFfvk2RDi+Bus2H7H/7uIjJhKaoiQ5kn6tWPJ31+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G9eJbb9j; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G9eJbb9j"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8cceaacd07bso7252486d6.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780583166; x=1781187966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=clkIHT02uZl46rCjOXn4DL3sKNX9XCKfChcmoui9JdM=;
        b=G9eJbb9j/eC1Tgq00ZgL0IBkvqoDh0bchFQu3FJ0++gYRD+SymJpykHRrQR/BXR8y7
         CuMWmdggusryjISG7hJ9f01IRflTSQMgkuGYOYtL/AqVmJoQb87du/YatXxnKK+h5rAy
         VNuC6sbrssE8sAlQWw09nb5qkfF4bTps3y2pHGi74WhGS+JM0W9pU1p319++VCZ5vsxv
         NoOQcFwYNv6Eoh4m5MUhi+c8PlbLPAmX1v8rA0XntySSeGkQNL2LDgXF/pXtvuzlOkQ2
         ysf7dEhmHtwFW4LvxH3XkjQRzTFKHdVbTkF8osh0a5VfuUuqAZ0sSzGPlyPRdSZcLn3h
         7s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583166; x=1781187966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clkIHT02uZl46rCjOXn4DL3sKNX9XCKfChcmoui9JdM=;
        b=OvWvNN71ENXGliEq9OOuRuyL1TITD6RDhcKXty0s1EPnpbrofjw5YCrBKhYNf9iyPj
         f2idguM3S0F9q6WlQRkEzbIexNEhpgeMyzAiaaS16q54VTKdL3CfWlayyTLCTEY37xM3
         vExQNvu0p82p30h4Sr5L/CNHcxK7p6EHZokGK+L/M3ozpFYvTBa59nWNwEb8LLD+CZBn
         p7tNWjTCJlXElDoBHTaLMGDxLvjcnRmMtZ0nIjkWdS724aYaibitcZ9ensfSXGlqXWF9
         V8K1my1jowLMIHWQ4vkmhcLNTa15DEX2bHkQVVExDwkqSBpEjAgZi8HYJXZS0RGIGPHT
         icqw==
X-Forwarded-Encrypted: i=1; AFNElJ+h2H1aGgYxU8ovVcitCPpgQUcKf3ReJ88dtz6hRSiuhXRoasbqs9OOZ8kU8hkieped+jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7GWSG+vporTw3D0R/jKkBEomxpbbapDwrZnu2C1l/E2MQQaE5
	fVf/X+HI482lXklMFhuo4YNaY+5KEFB+ppypIfHOym/65A/VgHNSYgv1+LKZoJywvz1z2lUBiDx
	ioDcs
X-Gm-Gg: Acq92OG1RpnhWbRPy36/bcFnzbujD2H4VHAvXMpiDLHYeo6B/CWnTJ9ohFxKY+iypVs
	+mMR7VHcRHi0UT+2ou8tM5YJgHBlbt7wUPJCRDzJuzVkJHnFllNHH4RnB+ctwFgsEiLsm0KzpGo
	wF6jNvEj31E/4t1Vg+am5OLo9kloXoUBgX68hc1gAXCpS3fuyFqcbHu6oigZG5fIKDsrzu/BLIH
	+3RyFTvUO4VIA06YsKMICBhRID1GJGVkwrbnEHU1N+WvDFXGzQWE+DV5ro0fWdhqHwpeptRnzDI
	ALmSI9yEtloGHXOgf5fD/5THqCic2F9ZMESCDqzGbwusJPfV3463/Y2wTE3kAbKN/3/3S0A0BwY
	qNnP/yE6diwRtpDDZz7UvGK8ovJ2HLfHM3UGJ5WwQCoS1Mpa09QhEuZBRp+MAgDGMC1Ds/irCHC
	+dT98az3ds31nMCgFFHB5XvpHwYNp30w+EvQqnMbu6HPQy+84uPUdYONxQ6LHskgw353xmF1KPJ
	oRlp0qOYo3kvCuz
X-Received: by 2002:ac8:7dc6:0:b0:50d:7aa1:f405 with SMTP id d75a77b69052e-517785ada2amr113397751cf.9.1780583165966;
        Thu, 04 Jun 2026 07:26:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51790d965e8sm4420111cf.16.2026.06.04.07.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:26:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV91J-00000008IF6-09MR;
	Thu, 04 Jun 2026 11:26:05 -0300
Date: Thu, 4 Jun 2026 11:26:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 24/32] iommufd: use iova_to_phys_length for efficient
 unmap
Message-ID: <20260604142605.GY2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-25-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603151804.1963871-25-guanghuifeng@linux.alibaba.com>

On Wed, Jun 03, 2026 at 11:17:56PM +0800, Guanghui Feng wrote:
> Use iommu_iova_to_phys_length() to get PTE page size in
> +		for (i = 0; i < npages; i++) {
> +			if (!batch_add_pfn(batch, PHYS_PFN(phys) + i))
> +				return;

batch_add_pfn_num()

Be mindful that the num is purposfully a u32 so that will need some
attention.

Jason
