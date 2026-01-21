Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF740B6EF
	for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011396; cv=none; b=h1LlX26pRnGP0FmcEDGnNTxIwcondnRTjFZEksunUYMzqzmW5AAFP+Ik1ofaRuu1b7HihKmgincF8bqrFfkjcelSvzgseMnc2k1KPJpPVzb+WKHjItZg9cSk053w1AtKYB5Qrc9lRFybfV/6m9DZ/9N3fCAzLFIGUgghmPVLklQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011396; c=relaxed/simple;
	bh=WmOj1k/W+8wJRLPGCBJTRRoghXStyisti26Y9JQPCO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2ykKUgKWWhVB2+D7rtvip00hrQcyG7ncysIfPsHNWuUClNij7a6L1iKxmG49HOHqYWwth4ect198oADy80YtQPdYRwyImS8NZ3GsSjZKOKi0V6DyLhMJu/Rz/OhvLIWtfSCZlVmy++Hm6jxqk2TTfLrO32Labkc79IuMqSZXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Kd5NBcBe; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Kd5NBcBe"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a2b99d8c5so362536d6.1
        for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 08:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769011392; x=1769616192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTcZwFv0TOIi/+PikXqo456K3Zrkr8L5jZsufkB+rbI=;
        b=Kd5NBcBeT6j5j9mK3ZVCrUGMznJO1F6vCumvX3AFSdWMbepjxg6W4UuPqaLuauvVDr
         FcBvpjCirs1KaaLoDODVjhsGtfoP6AT3G9AfAF337zSc0/W4b7IR1wnBiB99ons8HIRG
         FuRAtCnO0n9FGCiFtWtS3irr/PF1snxWVL9Zbqm7ALFMsp8+96tTu+FLyMDTMdvoCByI
         YbdWvsvrbfrBmtEwnxSJTniBYwAV0M+j6HheEwDuKnOQKcLWYaVw35zUB4aVL7oqm1wN
         YcUxYlEdLbYNiMI5RLHYLJxBBj5JJmcVBaiO5JsmBk4qoxUSyDQkrJwEJeCdzEpnjo3p
         ci/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011392; x=1769616192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTcZwFv0TOIi/+PikXqo456K3Zrkr8L5jZsufkB+rbI=;
        b=cA4MFKyI5+fG2A+to6NCEHogzUPNt6xru2vPhQcxyihzv4NsWfuOG2XNE8CMVTyHqd
         A9BNgBTQN1c9QADFdM/2x7TwdQQpZXxT4aQ2sTN22WHt6F74ZLRcrPb/SzpnbS1ZamaA
         D05jDuHN0nxl6pqFJCHBx9JTUtqfaPMh/vLC65ruyg1Umy97UYO/HBW08EjD8vGXK0pV
         bTNBQUyeN6mYkeG6dCVeQlydEvpssL9JYEN4ovKgHY4iPVYZHaPi1hsThYJZMMlRYMmn
         WLGCnIDKZDLyaEYpMNfHIsUYD5qR0MRvuT50zgIHqxaNt5tIU6XkSubx3QWB/4mvjlF/
         0diQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwaDj0p8IhL/l7I1vnw97rr5wr+qncauPHIOyGm8PtXxqmjBkwrXEVr1qKuvFOHCLS2Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ezux0m2ZFCd3aVAt4efe1CJwPTeVVGkoXzE2fUaajvYaGPrN
	lzpkZLeoo5Jj7yNRSiQXgWum4mRABziYX4GqpLqDvHOESITkdgoinOOlieCY4Hw+ZW+nBGqFgaP
	KVTTO
X-Gm-Gg: AZuq6aL665xOCa3yHLKexb5JCA9beyYIE1M8fPeIDa7EQq8fxKFU9WKgTJattpVid9U
	lQPqrDya9iDorayt81Ysw43LcXydmYe/LTH+jC4YRot8/6AqVpV9UF/Ob+lEdUsDTbBoz3ECyei
	1aWvUmF+9smJ5+zAb4oEL3V01UbfKWZxqr+v8JWJga334v5PbZ5+MorZ4Zd6+5lfZbMOy5I8mIi
	C7WlCSF93V3ckRIUC6GgZDSm3+8sSQf5diwHF4zBd5Z21nxAqqrWtDXEKMW8ISVvvNUEexuPDlQ
	CYbQSQS+oyDdy7e/1HkkSsftS5sHYzowAxl6OyXwhlr1RScdrcJdLUf0OGuLZuIildY07V7+dLl
	ZFfk35hiKvDP9AYZzK8/tKTHEkOU7uMWPlOu1dgA/j4uU9oLo3TAAW+RUgzl49JQ8RoECNtgyyq
	r7Im1FBZL3UTw/ewfgppou/M8vWlo46vbRCHwwU78niuKPgAbdBblL8+rCdeOjiIYlAQI=
X-Received: by 2002:ad4:4ea1:0:b0:894:73b3:a5e3 with SMTP id 6a1803df08f44-89473b3a756mr29385326d6.11.1769011389720;
        Wed, 21 Jan 2026 08:03:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894655aea20sm35183896d6.3.2026.01.21.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:03:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viafj-00000006Est-3jER;
	Wed, 21 Jan 2026 12:03:07 -0400
Date: Wed, 21 Jan 2026 12:03:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH vfio-rc] vfio: Prevent from pinned DMABUF importers to
 attach to VFIO DMABUF
Message-ID: <20260121160307.GG961572@ziepe.ca>
References: <20260121-vfio-add-pin-v1-1-4e04916b17f1@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-vfio-add-pin-v1-1-4e04916b17f1@nvidia.com>

On Wed, Jan 21, 2026 at 05:45:02PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Some pinned importers, such as non-ODP RDMA ones, cannot invalidate their
> mappings and therefore must be prevented from attaching to this exporter.
> 
> Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> This is an outcome of this discussion about revoke functionality.
> https://lore.kernel.org/all/20260121134712.GZ961572@ziepe.ca
> 
> Thanks
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Alex this is quite important to pick up this cycle.

Thanks,
Jason
