Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06603E5574
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383209; cv=none; b=Okmay7X5U0+OwDiku3+bzGrxiXAztngSLTa6IQnG+M5QERfRYxUq9CMaMbr9XjMlfxPfHFQRJr36Df9+sXIkCSOHUpPToN5S4oZla6L2+cpY0ibEGhPjntLhrmsD5KD+qV5RMmPBiIJBfmcJRSwEWcLyFgj85Sq5JWNwAdAGVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383209; c=relaxed/simple;
	bh=1IqsjiAX0vwjSWriiKDOdVjW11E6rCLofzR5yUGyvCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdETRXCGHt5D8fmRZ89ppntozY3YraI32BKQ7f0G7aIQsVMVDij+vnRXqUVCwjjuXX9Lrvd9UnFKFqA84J0dGPZx1vHABwtm+ekW11Y2SGEeQR6S/fxK8WqoPzvwzjhFGGnyQ94wWLxL2g73+FYKZPIxAtyCe1OIxLHxbGRevRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Nxkxp094; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nxkxp094"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-956948531a1so3002774241.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383207; x=1777988007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OngaHwDgRXU8aplL5gx6iXCqNmM7ax8JTAiWS4ELs6M=;
        b=Nxkxp094YJGDwd1xJ4nWVewihgoog7LNbia1N51A3GzMSp39hjqWf8b5BoAfgaIO3Y
         85bGhN5TWXCQD58+yXVhVorrc4UsreRPqOljBRx3dLxwzeLVpW++lTGHFvDVQCdleOgt
         M7ECTTCPXb0V8GqYguAHK31EkegTixul5T2o0YVi9ICCVs5GcQbBrOaEBYvAhq7BIbEU
         ZYJL+zP/dr9jBvb8+pOI89fH476qMLJRaUSHhhYZBwCpDS8j0T1XxkMfBw4QR1BPpUQ7
         pD0nWwBsiZMLwiWPi2TjQEnioa8w6BMoyOBun2/9dTOyF7t5tDWYFWtUNL2C9iMjNepT
         18nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383207; x=1777988007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OngaHwDgRXU8aplL5gx6iXCqNmM7ax8JTAiWS4ELs6M=;
        b=DRtBMMCfuC1rkP3IWOpHppy49m7xY7s69aT5E598u1MNaUOwehgBOCBbnc8X17YYmO
         oWxXbchT4yxwAS2RRA2TSR7Xyz19/BFVLj4KG4HcP5R2jjFaNxaWTH1IgJV3EYBmJ3HC
         yp9tgAZ+6NoJvhpAxtocO0kGc0dZriPoCrMJlL/MkhOY084eeNLaaixqpJ7wg4xIf9jU
         kBOIQT2ezPuKZ3r3kwizWaAbwC97hygPiC+rUvfkcVKyIRAIy/DXKWrdTDT6TJGfi2o8
         7G8KNYhVlWeYCRqJpK1Yvt/Z8UzNIJpaLhhJ3JY+5cnIqgWmNOHXWQ4PoOtEdzNejUHx
         bo1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+RdlGA/F0NCz+QZgsOEe47aDUNRxDDeP/Kl9k4ACNBc5jGPeMRIlHTyZiozjhdQMws7Og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyb/o5PHIV6F8xYTIhQXyLKl8T7umtosM82CQu/dTNIK65oMSd
	lIsmX6Oh5pa5xtS+qcEHZq56bgYXQg5wxVI3bwB2lB/TqeXsIcI1AsQMEaQVraZVkf4=
X-Gm-Gg: AeBDieuOmnh7VLXehnDXU45AGNj2RizEu4owtUESmldP0QONj5OiMFEMxUemO07/45o
	zzAYBASk8OUQ71cUBnPasmk8irWFsNBZEx4I2k6ueZ3UV8ybYfOQVu1ZYm2JVqtOXf3+SQSt9UR
	v8eRfFK6A1kAXWZH/BIHkLWOUsDN3oJ8tHupnthppcQQl6kR2EGqqXyP4U2+0Aacq5a6hgLPxtD
	PfceZfqjWjcJjArv55ouf8/2YKY3uq8UH0kUPYWuMVTWmD1vgjGhnN9yy4FkdG1lxBBc1weI9sm
	/t8vrv+dLV06WQDQTpeyxLvxgnUiHV9TduEenMamu8vxuPmp1mj8DdkBpXgsZmH77rcVd44GwG4
	uxPrMK9O5O+b4DbvdEu54MsQB23G6JinG5YOFGZNVihfM4iCqzZksg3+YKaFrSAWyOENuDrS8Bj
	7nHINoeKy2qhTMwwQVF6c1e4GLDY4u4DAmu6RRPtoaBtWNEVRHun3XT4cRePpUuELA7VpJ6in//
	cAwDfrfomW3c8DM
X-Received: by 2002:a05:6102:f09:b0:607:4fe2:a647 with SMTP id ada2fe7eead31-6280afc7cc0mr1065240137.21.1777383206848;
        Tue, 28 Apr 2026 06:33:26 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e2842bbbsm19645216d6.11.2026.04.28.06.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:33:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHiZ2-0000000AhmN-3Msg;
	Tue, 28 Apr 2026 10:33:24 -0300
Date: Tue, 28 Apr 2026 10:33:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] iommu/riscv: report iommu capabilities
Message-ID: <20260428133324.GD849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-3-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-3-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:50PM +0800, fangyu.yu@linux.alibaba.com wrote:

> +static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +	case IOMMU_CAP_DEFERRED_FLUSH:

IOMMU_CAP_DEFERRED_FLUSH is not needed in v7.1

Jason
