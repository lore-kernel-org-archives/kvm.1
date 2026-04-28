Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB142B739
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383585; cv=none; b=K2pALKji8/XMSXT4/dWC4mfCKZaDmRT/fd85loRx2HBpV7rwT+nbKA7V1ULiZniPlVy0jaQJH/MPxEEvLhOjtuiiCUdVVbIxQIq4OAKEcD2Yaaugrvzj8lGIHQYsK+VtEZJfFVML4pFxZkqYajEcZqKlllxLf7stS4L8GTm3uy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383585; c=relaxed/simple;
	bh=L8HDnTm3t5UfCzUjApcE3hEgz7xnRCJCpMcVAmSZC+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCF29nP4T3mZmQIp7QoRBRtAS0tPIaEi1tYTUbhy/Hh3zCrg3DIg1kWwD0tqsekACswZnaKl7tTKqhKErvr+dTufwKoM6jSJrlycqHDx5Hhp82kesB6RE2plmbOu8gz8EM8l+39RH42e+y17XRrnfeeNHc7rCuE6abSDKMCO9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pAZFWgeG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pAZFWgeG"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acae26e564so136505756d6.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383583; x=1777988383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cP40XfCNqjUZHKaFHTD5m2R9L06qogZbeISGyPC9spA=;
        b=pAZFWgeGWQ/+C6euQyFeFUuLB0itNBdRLpwj7/FsV1ooH9l/NOFAwpUqI1gViVF2df
         3jNEoeJ3JKOndYvruK7FzAWdazLrRDLCcAfybScyqT+R5AexokLZ0XMM5woGEJvktf2O
         2y3oX1XhiUrWhaiysB1pYaV1U/bc8rOA55eu+zNaReGMQhSTZxsZN2seek2/G1HSOR+L
         hgr6NXkK4ydHp43/84bVIbhHdmzQtfoHGmyqAnMq1rgrzMHLC+zFIiQ8mF/ewn6MX+Tp
         Ev7fQ51RI/y/1RUxLtN6zbOyJ8sl7SyN+6GoDblgis1RACqGWqK5ns1H3nDVCxvNG6Iy
         1KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383583; x=1777988383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP40XfCNqjUZHKaFHTD5m2R9L06qogZbeISGyPC9spA=;
        b=UajqFm6KLAZWYg/OSBf0v8yAFIFy0VQSUvwmZvSvFtjTK1odXaZ08MNVp+x2tDTBpu
         d0qBarpIN0s/HIDrIATR+VWhzEPA8MGLaNA8qLpDCMJ95JAB2eUS3zvMhzcIsHJucLD5
         Pa4+AIGSp/gb29fvCxHOhXZ/Ip7se7MFHhIxHIGfVSzKVZWO58YG3PGGA4QJ5e9DxkSG
         W4tROjaLUC8rdGDz8/LYEbXdY5/QjSMUG1cDcbi92oiCw0VM80DdZkGAsUJw7ZMJQdqn
         7oy0SVAjxR299QZAK0zfVpjdgutGP1QjxEpdV2Aaj5m1M43uzy0wFBlUcOja3h4hWZkI
         hLRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DHC7I8fXuRQm8CDYpOqaXDx0XLofxOY7uNVfe/G8x5GQSUr1Rex97cQj87mlYqMnU/po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4+tcG9PSDVckNPuZjZDyH+6NXpCt0oq+RJwuX2b26h7F/bQW
	S3iYH86aty6hSdOp0F2QG+OlzAEl6ZMkSMf1QIfe7N+CIJKX/tXRz6ZnRNCi1yiE/EQ=
X-Gm-Gg: AeBDiesR971u0UDWAJdxCBEIdAsbVCYYOxSBxnL7150OBND7aK+un7EgKRTJfMB5unp
	LqG+oJ7HEQkhu3uKUvLl7kA55Fwo0h0m+z73yQOFXZ64v/Veq+USNZ3a0Lo+AjYmfi4/MEft1z5
	TCvcdthlAyDB2eNLV5+xW/qHmsW00UQdOOCr0AgstufCPXBtXPnzUBQi+P8EAjiCnGUU9XGgcWB
	dHaK8kIJ+6aV/2Bpl2XqH37nKgVJWe5QJkPZ6MDIxZgQHioak4uXD0Pj+xLx39zvTF8y6tsCq0S
	UB2/fi8ERTLr39jdXVv9X44eT3jxAIAPfPfjovY1CWrcN1RlYUiD24U+mTo79ikExzIslom4lJx
	XJm572Sjw46BU+olYMkJ1W8QP6zmzFkrizTmAnHCW+g0VFb0gwuQX4D/38WEmiqeuGj8RGcZ1dA
	cMDRhPxzFt66ZQo8x1GuP+TefSifKveUKBc9Px3EcZjdML/MiC+sYunL7+8ugK34UkdDRHLXtrr
	2HyuPWRpF7J5sCw
X-Received: by 2002:ad4:594d:0:b0:8ae:7146:603d with SMTP id 6a1803df08f44-8b3e2ffa2b5mr47731266d6.13.1777383583207;
        Tue, 28 Apr 2026 06:39:43 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e281bd11sm20759256d6.8.2026.04.28.06.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:39:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHif8-0000000AjUG-0wGD;
	Tue, 28 Apr 2026 10:39:42 -0300
Date: Tue, 28 Apr 2026 10:39:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Zong Li <zong.li@sifive.com>
Subject: Re: [RFC PATCH 11/11] iommu/riscv: support nested iommu for getting
 iommu hardware information
Message-ID: <20260428133942.GI849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-12-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-12-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:59PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Zong Li <zong.li@sifive.com>
> 
> This patch implements .hw_info operation and the related data
> structures for passing the IOMMU hardware capabilities for iommufd.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c  | 19 +++++++++++++++++++
>  include/uapi/linux/iommufd.h | 18 ++++++++++++++++++
>  2 files changed, 37 insertions(+)

This has nothing to do with dirty tracking. It should go with a series
introducing viommu.

Jason
