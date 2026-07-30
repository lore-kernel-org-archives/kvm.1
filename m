Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90249382395
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429970; cv=none; b=pGIQVA8YDhSVUFGpPzCfFPso4tVIUO15LuQZ6DMiLW2PJNMk8bkJAOWhRzSYmZ736i23Kjrf38jS7drBZApohhMZDMlqtZ4dbYbfFBP1X4XU3A8ngtq4bFuJdNV/ovJ/UjeA3tYTlKVyaCQVXbr0VBa/iQinT++EpHtVOnpHn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429970; c=relaxed/simple;
	bh=ZAs3k0ZvOc1D0wh9G3ZY7S0nZrMDuIeSI7fMUiNw0MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEsWpBg6gDs6AzHiI7iRmwvhVmT4KcRrs1UJzLm8QXMUUmHbOFF5GTXPxOL2YaA/lwoxteH5I9Oj001DQHpoETcwEKut6Nh9LqXufjPyrLJ5BrfcPlsMINmVJUV5QtlqC0KlptUg8xaVK+OMFG1pBeHCp1roaXrOitUPWdVDPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHNHpkjU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHNHpkjU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cab97c86bdso145705ad.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785429969; x=1786034769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NX0JpvyzsEoK6j+vmZOEXvLrdaZX+FAFLPxJGdbTFoM=;
        b=VHNHpkjUYAWJTdMZxJVTie/KgINuJhvjdC9CiaMMyM4tQ0erUo2LcRwxFG0W5cZYSp
         MT6iQOSIeMxPIWY9HPmOHTSoQs9WDqZjUWXXgDk51FdYl4mijDYpTY3fA6sQukPQWPzB
         BhE/HfukIVNUHPCvZTX1qElePKssMtJcwlHIAqVPrcnVBjoQlFL/Pi+WZNYZ+4FyQJVf
         Z1EbKFjNKu3UKhlVrjMTfL/vQyMVswai0c/upzzn1ULt72xG3TnRY/iCFJbcjTIzfM9b
         E3tC9mEioxIrJneX6O3pMmA/9B00v4cvmdmO7cMLamxCrOaWzDHe4UFPrP5qWaujS3nj
         VEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429969; x=1786034769;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NX0JpvyzsEoK6j+vmZOEXvLrdaZX+FAFLPxJGdbTFoM=;
        b=V8+KrYOHioZ+oED33jQyepEEFLdG/k8/hkzcTidso5QgGNDVUnn4GXoLBPdBWwzwXX
         NQhwJKn5Af3GmzcPB3AQvYeYFlE+LmUQeYC3BYmh3aZcdQRJn5W4PgLnUrmdjG9GRaS2
         6LiQjalrIij6JoeQ1tumMJg3nOLhQ61tUr4iOK6CD91H3RXvbpMneDzeLB8AnEN7N8zE
         qRDLcWrMd/Y9ghkGBgAehIGBDtIVZpIEyBhJWjirxzKhUUAU7ztFGrgIcp5EXR52cdue
         HG+ZhRItk3bX5PH2NP87Cq06SCaeEFvEFWCR0r9gzwwf83WeV+0C3VQc59pmqOfsykXt
         v5IA==
X-Forwarded-Encrypted: i=1; AHgh+RqquxwFNsSoYJAebcVGhz6enF4ExRL/YJhLZDnbxX1BoTqMRRkWAJuYni0pP5pb0ysKVIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qtiKS/K2uvEF+in42S7KRscfZEU9NyGiQgC6LEGh2Pialvq2
	T1CVBQIoCHef+ml86QB57vR+7YRRUN7C4vKQqOrWwq5LuDPR800ONyFzBTzuIe7jbQ==
X-Gm-Gg: AR+sD13TboDjuZRAQMi/rBEClRi5HYiXyorxODbvzusy4WMbGKf+7EZuW8nGIG0m7Rp
	fBm2aA1AdtE1UnaATy6/AGI6sQSjjMMxjCVMUxol36KOc6RvKMLaQSm1xBYYUowZWWjnLm6nhWa
	QanRPO19E8argp6a+h4eh5ws8xG0ag1C2x7nW/TnW1c6AY0B4TIDJAi82RRo/fivi33zvE/7aA0
	NAZLoDj+DkwoyXzKib9AVjVOB06Tt2EXI9he+1quWk/JhjXRsy9DRxtr6RXdRBj7ps1Xr4elJiV
	CKN0QAax1p0yloE9Rfao/p5Cg5tdI5WItyqzkYP7sOsHD0ZEiiKG6jpfAhTH9zMCJEd4qusiju6
	vx5T8AFsDWMR85R5dsFrgMHkdUUFOENmDDUT9bzTdyEpRhfOjUI/uCXPuNgZ8x4FW2EAe14IFHe
	NGK0ST8tEOCPz1+9F81BOOJUQQMcTrH9knIcH2O4pXpe7GoZbK0b+46/JfUIRdYYhWvpYDMp6dq
	by/5hM/bInOEneGz74h5Hk=
X-Received: by 2002:a17:902:ce90:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2d040c826f8mr102235ad.8.1785429968232;
        Thu, 30 Jul 2026 09:46:08 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02fa474sm3347122b3a.30.2026.07.30.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:46:07 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:45:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Message-ID: <amt_x6-9lplDLdHZ@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-2-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-2-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:24PM +0100, Matt Evans wrote:
> Preparing for a refactor in a subsequent patch, split the pool-related
> release code into a new pci_p2pdma_release_pool() function.
> 
> This allows future compile-time selection of a null implementation for
> pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
> P2P-related files.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
