Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410E2222B2
	for <kvm@vger.kernel.org>; Fri, 30 Jan 2026 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732236; cv=none; b=DXzvVKzY/bEEnHUzq+Pr73x3tjTCo2ORyV6GaC3DvFtVuYqHBFQWXrToPNPNBmkL/YkQehtK6FD5hiJNi0Wcv9ZszDCkLSRUa1fZXYAj7wcnI78JmrhewwFbrA1ulqYcGc5GmQDfvS+yX4f3oe8qWnDFz9/ejodZi5Pc5pp52Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732236; c=relaxed/simple;
	bh=PgxWXxtJeqUdvgjP5KxrfenUWVrCXmnl/Ip3hY3gzr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHufKybpIwYfcUotPTv1PI+x+pRazx2R8J9Gj+dT91eg4okioE5LCf6PlLH5dzdoRSn+cE5Gj0K2/E2zQKiMgJM1Z/rWmHBW7iH0+sRyo1MYrP5/N68hFxRm7GcONLIBFLsRBYDdix4m4cVW7WoQQY6wkIqXogvGot+JxAnjlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KA7biT7z; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KA7biT7z"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c5349ba802so152791785a.1
        for <kvm@vger.kernel.org>; Thu, 29 Jan 2026 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769732232; x=1770337032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
        b=KA7biT7z2WPIJqn1yWtupwtFpuiVSND6sCJuDPiqtvlV/udtpzWhHBdHKHzdXfdrt9
         s5ff0uj0MnRJ2qUUQNgrd0lk2LV/u1TJUfKQTbzPIGnBZoQoPXVw92tOcr4jJ+o6LTsh
         pmrSmwNEYgAYmP11U4AzdudTpUbSJ/6lGl2fTB0tpVVeZ5pwjPdB10zBv03zrqTMm32F
         XRxwdujmIDrabfqlhXdKEogyduDcZ/LafEpZu5i5+k5xCZIZggCdPOPnVishQAaKjj5E
         KENQjSUQFCVdWDnSRyM99hu8FmY0ffQviK954nkYYxdhylaquDPwhk4OhuIA+A5fqMJJ
         rp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769732232; x=1770337032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
        b=W5vYDnjoS7OuVqNayK78S1VAaGFH4fTyCgduaf8GSK4AgqUt7weSqjnu7rHmunc8Xn
         DNjcqrbTZnzdbN0PPwUCe71oqiVbiwqgbNWMc9K8fLlREIFzQUlKcVYt3Qp8v0kPc+B7
         Sg8F3X6S8MrFPhtUewVU59aelaYWQGb5jpp5po5bzZNwaQ+bLvZKEvtK61I5udc4xv0T
         OwKC+O4kZ1ON5cpH2Gn6/g4fb1B00GsYc2qOqXFRH3JIxqBQVVjwPZMbcqqhLOpBORXR
         tzTTf5QhrzN+KJMTmvj0aN0ngk3mr8oMtI8Nf/j3mu7S9sP8GE6Yw+TwDTtkjrVFNM4m
         jE2w==
X-Forwarded-Encrypted: i=1; AJvYcCXcD2CJFrSdDVKmQi1VbBafi7+JdMPk2Dh5WL8e9Liv/6MPpMGYK4NqPv0nNRMf9P3PnLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycvI3E4jetPWITEa+n1Yjtbw5n3vYjVOd+G+qq6cO7xffqtCIz
	6zj3ijVdSXBul1ejt+rMrmkBR8wdt/lYT67MLQzDFMUodSfLFVAVRhU4bSgfsSxu5J0=
X-Gm-Gg: AZuq6aJVxkjRfnlLiqfHqGYY3dkEyXw2RZpv3hJPo8eWdHS5X5AjRssNljp1d2P0irL
	U8qsP0+OJHnXZJc8N5sI9VhNoEgUtlnL5IPLgUc/0/ajNeaGL4/QOoEE89CaCc3mxVodTKoPpuj
	Z7OFpHaa8kqVdFlB2O7hC7xEz2jan2YxVG5s+pwUt0em+mUBjHuylEyetEvIlcD/DocgXZEWGby
	GSMPtaceuAprpl1F3FxBIxyCBkcmyibzmuoS+YMGqZVcKmgIczKT+evFLmDuSsP9R9qWyi/8qYW
	7u183ITIvyZDjmco/aKWlH0jNwPwE4DwR+CXoG/QLfyxLz4j3IhrDsCCN6x3gsCA7PK6lyR46vS
	JcQgbLjB660unqO03PYP7Wmq+64IiPW1Aoydk9yeQmquDILe1BVV5yEecRI+KYmLGMIyRtDTNwO
	MQqE+Oqkq4uklvG+sO+XOMNOIjYPY0lPtKBeyyRmSc31yAbJ6Urnfkphj/dXe+nX3dPL46XOEvJ
	cuCUg==
X-Received: by 2002:ac8:5781:0:b0:4f3:5f7b:cc1d with SMTP id d75a77b69052e-505d21846b4mr19549181cf.34.1769732232444;
        Thu, 29 Jan 2026 16:17:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cc19d7sm45008611cf.35.2026.01.29.16.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 16:17:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlcCE-0000000AQZD-13C4;
	Thu, 29 Jan 2026 20:17:10 -0400
Date: Thu, 29 Jan 2026 20:17:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 8/8] iommufd: Add dma_buf_pin()
Message-ID: <20260130001710.GB2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>

On Sat, Jan 24, 2026 at 09:14:20PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IOMMUFD relies on a private protocol with VFIO, and this always operated
> in pinned mode.
> 
> Now that VFIO can support pinned importers update IOMMUFD to invoke the
> normal dma-buf flow to request pin.
> 
> This isn't enough to allow IOMMUFD to work with other exporters, it still
> needs a way to get the physical address list which is another series.
> 
> IOMMUFD supports the defined revoke semantics. It immediately stops and
> fences access to the memory inside it's invalidate_mappings() callback,
> and it currently doesn't use scatterlists so doesn't call map/unmap at
> all.
> 
> It is expected that a future revision can synchronously call unmap from
> the move_notify callback as well.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
