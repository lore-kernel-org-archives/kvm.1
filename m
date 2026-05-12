Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC23B1ECC
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598742; cv=none; b=uS2vLZ30rdK2oodkJsEXqS0OJGLRM2Ao7Ad4QDyRSTqbWFE3kcZVZ4PCLzceRlYunZ2bKq/aobhlJdpYVcZSpEU/ue+YPWqo0QcilaDwovMxldmBg965y+sCXeV1VOjA+IYJiWIcXSb488ktiZIztoViorFLNfaEissZhpN6k14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598742; c=relaxed/simple;
	bh=jMSK8dzwc4SayPadFvopl7Cutk1+Oj8G3x7GLFF5VWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1EYPdje8OUoKFZiE51Jnphkzdm/xuc6GHK24IrnfFTGrKeyNaXaqGAJkh8WfyYUtVjtkY6wbQKvbOeqG6cVzFT6EemBhAzKJ048UrzBj/2iwUDQ3cYD1z9axqY7LzY50FoZPThRF+xRqNPsGuG+OvUhZDRca+Zgs7X2YJEm950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MEoygFRF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MEoygFRF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d65f4073bfso775424085a.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778598739; x=1779203539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5QZGcD1HP6wx7LkGFPePizbOfmssvqTnXeHIaO3M7c=;
        b=MEoygFRFsmf9SqPzdgAPAIGIcJsdCrpALhBgbNvqOan3jgtDPBlivRUlrf92N2QeNB
         R12ZHfBudAuBPrHeglIcwQQn/hGXbEPFS2QP+IeA5BOwKXuAY2CAK+z0XRAa4GB6hL9H
         ZVwSA2ZZm61/rwv/3AJ51QxrwjM//XazqOPTWMkLMpCM7zOIy+IRd9EGkgsxphvnxAI/
         cMwkuuxNY5I+uBlLWyTuMW04oLwEMxs/kU5l33l9yjvlWiZfkLJmJOvzvq1xbcA+/5VV
         v6meFpe467ypNe9tYcaUzBUX+laL+89yw2A8S4LDOm2IGzunSpJymwAnizX77EOp6zl/
         KbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598739; x=1779203539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5QZGcD1HP6wx7LkGFPePizbOfmssvqTnXeHIaO3M7c=;
        b=XKnvY/CRXYUx6aDNAP1e3NbrDSH5IHIdv2+mlJdt1Cnra0jFqxTc+ITOajzvCXJD7q
         yuduJWkqhYRSUSGxc4Md799nLgEhhmedOp5F3TrCQdbDHnEGudWlt8IFcz0UrVBRsj1c
         +4Cye1yG4K8pTIjO5gTMeKgz4i3CqoEslN2QUq9V0kRfmDGtirgHTLfTnBy1iohcfAga
         WIGR0ifWytIKXT1XuL2j08QiQ7mR7CINz3/nZeib+aa//tExJO+zc/bXiEw70mb31ZEt
         XJTMq6+ZNI8LzrYg9x75gywq87RuKpRuoIH4Pe+P2aXUD21BUEXoeQp7ua+fOgb2MyMP
         E0QQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rt36zZI3gJTKWa7LABtTcdgANdicevvNyaq8ofpbbKLjAfgrCSa0rIyJgdEveDw99jpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5NTTOB7d/Fuxucabdz1ask1FeNxT9+RW1NOVGUCEG4Uin5l6
	bGD/9WV6Q3bGawoDaY2r+k0TNGeNUlQAcekMZEBXf6UoixxE9Vk88ojRvQgP7+qSL2o=
X-Gm-Gg: Acq92OH2NMUF5Ilnxy5xqUjFLZVKLf5dJ4WEqnEiCwAUloA4oJBf6ANwAj1sw/9NAit
	bXZHtAq0XnByNd9BuKIPsepQj4dlFI0QkYImfetBXi8ObwMAUJrF6H5J4Cy0xdIdbt93ZH8mZXP
	1Yu5VBNmscCTgY4As0yk+E8cV5XtMAN1jNK3v5uNvp/mb5KpXY2yySI9xBhp/a4UYaGpkgP5wPw
	obWxFPsU1vwTQlfMqHEHaj+1HjLzcyPYYIPp83Bhfa8iLzpZHr2iwlG2qSvsaER4dBk9+g7wEJv
	2ujTrc87zECwFkD0By8ylHnnccIiw8ba6YciCAi1MUgz4v8AQWl7eS0g11qdrgmgmvm4VjbtFFL
	wK00jXDCVEqcx8sTtSOUJrS5YACgc6xJXT8W6H1HAFS//3g0aaiVQ+Qmye8tEAM+BRsR5RVOr+T
	N8z54cfUS/7qzxTplA8u//uXKDYPUutzdnSCtHLX0Aid5Oo3E1AJYfpgb2QV6kTGQ6XbQmVK7Nl
	3jwsg==
X-Received: by 2002:a05:620a:29cf:b0:8ef:ba6:1a42 with SMTP id af79cd13be357-90cfd34cbb9mr453281585a.29.1778598738983;
        Tue, 12 May 2026 08:12:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9286171sm1410125485a.12.2026.05.12.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:12:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMomP-00000000AVF-3i1q;
	Tue, 12 May 2026 12:12:17 -0300
Date: Tue, 12 May 2026 12:12:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	kevin.tian@intel.com, nutty.liu@hotmail.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommupt: Fixup build warning by using BIT_ULL() for
 RISCVPT_NC/IO
Message-ID: <20260512151217.GF7702@ziepe.ca>
References: <20260512144330.91113-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512144330.91113-1-fangyu.yu@linux.alibaba.com>

On Tue, May 12, 2026 at 10:43:30PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Fix build warning on 32-bit configurations by using BIT_ULL() for
> RISCVPT_NC and RISCVPT_IO.
> 
> Fixes: 6c21eb174c6c ("iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605121350.wZxB51k0-lkp@intel.com/
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/generic_pt/fmt/riscv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
