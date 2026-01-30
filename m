Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C17311C31
	for <kvm@vger.kernel.org>; Fri, 30 Jan 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781681; cv=none; b=f3zmlqkWxpDl4WEt6ON4D0pXq+FO+Xz76/4HXwnJBY/lJi0RT7HozmqXH0jmySAwm5ieJPg6Fd2pYf5QSek+yDGPnLvJwIirY3426H6vUda+FbXBfpytBQbvD7POngYc1Rll7AlBPYkxK1TX61At2i1rOPGtGFTRoPl6Q7dBIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781681; c=relaxed/simple;
	bh=B2BjUDXErJP5w+VRNup6GLKty66RY3PW3GzWxgahGUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmN9hKa3HdrWRdB9Lm5gvCyJ0hQCdp/kJM88R/7F2ws1n6xFd9cMTV5lya2t0Ux563MCq7ycxLRWpLPrG00vKu4AScWZbJ6fjuZQbA2eoKi2YebQOQWq9wDVUMk0GgI2EB37sE4UHJ7myNNTrYQd1HvRORSc9to2jtiQD9olx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RPXkfxnK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RPXkfxnK"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c533228383so134623185a.3
        for <kvm@vger.kernel.org>; Fri, 30 Jan 2026 06:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769781679; x=1770386479; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RZzJd1rUXnKgbbFoik2J/HwA+Mcwjh2UI/kxMGq+fms=;
        b=RPXkfxnKERVpanY6KK8kMqA92D1aCsm0leVXLFCXjOhb2U3nX2ibmil5e1rKJjRbmZ
         f9DLF2ispAd3BC5/e/B7PIP41q9T7cXh+rFnMjLhQTQVOAwPscRHX0yuVltxMo+SX0va
         xizd3lnopuOyDgwqxrfBFFPETq8K7uDdD1AiHlNN/WTPGOisvesviEelnt4KuWRuvyRg
         C1fgBVRD7H2M7lHZPygk3VfxwbCekxUo86H7EPdB+A5bCR3cOm6bbT7bRiRKk5cUFTZ8
         6U8v+ce+eW1niOc5yZS8lVBKLeRT4st0EvTSZ8FDC2mKySNBjdyDwdy1kxq6nDeMR7Sh
         lduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781679; x=1770386479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZzJd1rUXnKgbbFoik2J/HwA+Mcwjh2UI/kxMGq+fms=;
        b=Acv25L750TSgUYvhKqGffFCn/4ZflGjYmpVsF239HcNBkD8HPzfnoeJUmRm44/txRO
         lQPW/U0Gy/9AJ3tLa6sDHYY9E7Ds7jv3bmVS+AraqkXn6AQ2jBUwC50Qhb5uqmxUfOA7
         QC1wi+lZZ9j61WbQtuezN5Cfsh9/ySihD6witW2Pv1He554VfRUaY/I/PxdGgPpi2fpe
         YGdpvz/wbQa6IAQIwkSen4HBDROnBaPF8zf04FhzSzsU7gwfG7FiVRpgbLiZnc7nOyk0
         UBk7FUPECcgJ6ZknjyEoMkMg9/uVVB/wVAJl80hTSAI6PMQo1I1A7zK9OK6CK4AYhm2F
         3ONA==
X-Forwarded-Encrypted: i=1; AJvYcCXk/6seBIzhPb75l4xQ6XfnEqmbd3DoBAOLujrdG4g7iFQ3WdvIMT+gBQKaZOQwNxLm9AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF59eefNsjr1/o+mskeXrYPIENQlmmcIXFmKPzOzEXS8hwHsu7
	We5q6i2+L349Unoxuvo5bwFXNYWYmEyPYDE6zHV7jDidIZ4rPrM0vUp+srm3ocrIS2c=
X-Gm-Gg: AZuq6aIi7Zlq7qhUGSHC9y/TNIVUIiq3/DBQLmW2+A4TCg+zLEfJepshA1bfSGA99Ie
	JYpS4yN9NmPN/QJuCoVTUaOhF84h4kiK69TZYO9LTpiZ7WLHVcUqVDtz/Z2DgrX0ySbKNfL8dyr
	20LX8buDfPePzQFe+aeLY3faLs4gm7RmyZ4rQYpZ/jkP1qQYVR3b4tmAzCbShpZCcII64ZisdT1
	FkH149ni706WRoECqHqNPOuAJUqQ9EFGqXghr3kCPWpRCNh0DlBWdTvasbH8bfgwdtBywdJWksI
	kJXOwdP+8W32xVmL7JrnPG2uXT8gJ26iTvehBUwmsPKJg/JQzQAA5Ed+hCDzYKeWsTLXUpVJ3xY
	rHgEn/oPeishshulToI9pRpj93+EWPuTjlR/k6edL0yJrA2jKNII27UtbQB0ZZcM8xtjV/sv0YI
	ShwtdRgVgbGbOykXExr3Jz8PZajHz2yPIqmKsAev12k35zmCVsoeEqdnEUYNy6x9yJ9h4truArW
	JogpQ==
X-Received: by 2002:a05:620a:290f:b0:8c3:650d:577e with SMTP id af79cd13be357-8c9eb224827mr368793585a.4.1769781649371;
        Fri, 30 Jan 2026 06:00:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b95e4esm700915485a.15.2026.01.30.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:00:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlp3H-0000000Annc-1AWG;
	Fri, 30 Jan 2026 10:00:47 -0400
Date: Fri, 30 Jan 2026 10:00:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <20260130140047.GD2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
 <b4cf1379-d68b-45da-866b-c461d6feb51b@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4cf1379-d68b-45da-866b-c461d6feb51b@amd.com>

On Fri, Jan 30, 2026 at 09:43:22AM +0100, Christian König wrote:
> On 1/24/26 20:14, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Some exporters need a flow to synchronously revoke access to the DMA-buf
> > by importers. Once revoke is completed the importer is not permitted to
> > touch the memory otherwise they may get IOMMU faults, AERs, or worse.
> 
> That approach is seriously not going to fly.
> 
> You can use the invalidate_mappings approach to trigger the importer
> to give back the mapping, but when the mapping is really given back
> is still completely on the importer side.

Yes, and that is what this is all doing, there is the wait for the
importer's unmap to happen in the sequence.

> In other words you can't do the shot down revoke semantics you are
> trying to establish here.

All this is doing is saying if dma_buf_attach_revocable() == true then
the importer will call unmap within bounded time after
dma_buf_invalidate_mappings().

That's it. If the importing driver doesn't want to do that then it
should make dma_buf_attach_revocable()=false.

VFIO/etc only want to interwork with importers that can do this.

Jason
