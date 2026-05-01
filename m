Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216637A48A
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675384; cv=none; b=usYuItcy50d17tJuGEvFglQDEQy6UED552cJ2VmO0kFvyTk2yBcQPt+VmJP6pjd97b5570Z02D0X62w1xk3Pm0/tpZQ0SxZPLXah4XRfZhsBdPdGpGpKKYJBCbb05j7tPfPtqB9nKxw4bplmWEHYmoifjlITU6fQgPqkS/zsFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675384; c=relaxed/simple;
	bh=zxY+FJ/D1qGJPLj7LmqjRlqbTv0Us5t8F//4LBJztq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0oWRYXpywzusvo8yOCsF76yA457IJ+OVzGWxLM5SYP9QMDLUPF5lqgCbmdg3PQ/tDZ3sIeQWr0p+5StkYZIMCHmdmAEmz1gzkYxQ7JMRuq2sFMYIigyu/vHZSR6FBps5bCmft9a70ZEY2Yj/cpAs4fpzn6x0hweKMbr9QOoKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4Ln+7I/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4Ln+7I/"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-364c5317d67so2185442a91.2
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777675382; x=1778280182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zA7ZB+9cdr8jZzJkhetR/xMmU5JX5i8WCgvlAknX308=;
        b=m4Ln+7I/rTNlDZVJ2LF4fMLARnw3NNs5xfG76SQZSeMZzdYDd0DKOihUgvHOxY4rg1
         /tS4HRLRZxP7nbm5/HQv9NvsDrcpjzyBRA5AqX1DGiMGxSL+MNPMt1WDCyRHpy5XZmIg
         PLLLE8usZEu1QK4XjRKoFmsQDElNDmIFzR1YFTnW42XYD1Wzd+XSZIkd6qUEMCdCdXZN
         KcKa9tZb9/k3vPRJLlalRWbbPDlscuBOGezAP39aOR2Aj2h/clMw34GSy4CdRIN5Cfsf
         O18lkSQIB9PUdNCsY689uLrZcX0NUdFmIigcrqixxLsD+BGUcYyd6AjaNpjOK/H23TYu
         v00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777675382; x=1778280182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zA7ZB+9cdr8jZzJkhetR/xMmU5JX5i8WCgvlAknX308=;
        b=oyodu2YxTE/HyFgBzmXgve3qnETrdWgkdNtw50FWM4Q8as+Zb3lxnbwPO5rcY5aZwL
         PDQAlueUNtFCVvNdu9E7M9+Ng7szIwDy6lD73iMOXTdPoMrh7dCxQ6XYjb2vqCH5HmJd
         UJN5koYlZe2hO/9rxv2gNp1oIcQD2/wFIJ8EXFD9pJUzldxBuT78vjeteyf034SK3iOC
         KPnMixyDslcXYV7wM7BUfnyvRPZQwlYCz6UgyDATHNa5SgSNQsKjTNvYMKzKls10HSXF
         voOM0nR8RgsstSgmoFv+P4F0/fDofzzG9ks662M8B2l6qQ8wzUPsrOggiNiUuw6VaeWy
         bbYg==
X-Forwarded-Encrypted: i=1; AFNElJ883goGnmIK4cE761+FPGnjlFCyttPfD+g0lWEDfqAHJ8N553cS0VMtrT5VdOm0atWCJoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RRuyh3UcaR79KlBZOhHgIDNJB9d5AEhcH0BSInAocruCgn1O
	pzCRlCu7hB7GGkGQHgX3Qmbz36UKcUsPKkg6To70pDIk8vGNkbHh0Etwz4SX0TMIEQ==
X-Gm-Gg: AeBDies7oSt+3wFDgmpaVEYoY617Vo5kmB08lGf33umTkBPflVKx29Gdyf3EBbhEV4G
	B/8noZmxC6NIIHZNR18ti/qfzrW4KIUsCWsAogf9Ku1LQe7Lw0M9xDlIqKYYYDlNGlilYdlEfWC
	qodSuwWPz59yQinBgYo8SpLOaJbjqIcdGtV917I5F0GQyO+SjVuvI+Lpq0kHp2jXohGHh/+HKb1
	ve4SgnE1d+O0SefInXhX5IUGqEqpU2U+wcD/zpAa5CmuqmlKYjsp/6Omad9pfGhseO63ti33TYz
	8JITS2yMiXPnch9HYWi4YfqhhDfUqXxwgdoJylV2xDZTLOyWLnXC+YNpcuGL/8z5HcwZCbDynN9
	kdGh28B3LAGT9kZPAidHRfLG5P1qC4u2Pt0gbPgmKfPIZ4EuxZgkvZcoy1z5cu09tg3IIOX6VEe
	BcsVwbrXXXowC3/A3PpwwXHdYPzBn0BF+s6bHA2x8Anl1U1xaod9qqM0Aq3sYMLIAmzBeCSLE/8
	rmxqQ==
X-Received: by 2002:a17:90b:3852:b0:35e:30bc:96e2 with SMTP id 98e67ed59e1d1-3650cdd40cfmr981966a91.10.1777675381854;
        Fri, 01 May 2026 15:43:01 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f3fc1714sm1322177a91.2.2026.05.01.15.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:43:01 -0700 (PDT)
Date: Fri, 1 May 2026 22:42:57 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <afUscSeXKnNAJ0ZF@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-5-skhawaja@google.com>

On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
> Add IOMMU ops to preserve/unpreserve a device. These can be implemented

Can you make this comment more specific about what is being preserved?
Saying it preserves a device is vague and maybe even misleading. It's
more about  about preserving a device's attachment to a specific domain
correct?

> by the IOMMU drivers that support preservation of devices that have
> their IOMMU domains preserved. During device preservation the state of
> the associated IOMMU is also preserved as dependency.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index f71f14518248..765d042e22e3 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c

> +static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)

It is unforunate that struct iommu_device_ser has nothing to do with
struct iommu_device. The former represents an a PCI device, while the
latter represents an IOMMU.

> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index 6019cfc27428..279c7ab04f09 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h

>  int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>  void iommu_domain_unpreserve(struct iommu_domain *domain);
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 *preserved_state);
> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);

The naming scheme is inconsistent... Maybe it can be:

  iommu_preserve_domain()
  iommu_unpreserve_domain()
  iommu_preserve_device() or iommu_preserve_device_attachment()
  iommu_unpreserve_device() or iommu_unpreserve_device_attachment()

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3853a3946733..1c424b32c5fc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h

> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +#endif

Maybe we can make these names a little more specific:

  preserve_device_attachment()
  unpreserve_device_attachment()
  preserve_iommu()
  unpreserve_iommu()

?
