Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA437268A
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678519; cv=none; b=biYTLxyN7Ov4kXOYAsleONiQFJR1wrP1N73UieLQJ71ce8dSaK3hTja31YOqOoSe8OUWH35+0dlDtEUdB9PYwBuhEbax9TFkO1ZVwZcOWLPRkG2avHsApEK1sLZIfSRO35kS1yVh29W1HvF4uLrLN1twH5aUrVpwVhFpZO7+lEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678519; c=relaxed/simple;
	bh=xUmQlTlcXO0pkAWEHxqHsgGNX6M/I17T0dQe/2xgkpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tikDbQ65nK3Wh5cJkqf/AeM6f4o39lXV2i7EfqlFLKMbo7PBLGH4kzQNxBIcQHB8IQnY0BITgnW0h37Nmw/ZLHaRVv8tRg/EFSRvObAgovEu9L501jzpqacEJfglZ289Bi2cP291AvoJfJAcTMte5VOJYZMLUa1tq8cf4BGqkJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svV84213; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svV84213"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b052562254so175ad.0
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773678517; x=1774283317; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bdY0MHpBaQytGDjrwl6No73PmmhiNXL6flXFjxFT7cE=;
        b=svV842139aNRJxBp7JcxWBFf26kZOefs+oWMPmMW7QCpAnxEj8tYI7T/JafedbK1a5
         iF8LdZcm5+aDZzWLBY1UlkUKKmY7bq0vlPHGUZhrzz2XOwAN+/Rqpf0tGjmBaMFxAksM
         HdTVrrOlcZYFS70C77xwTLNQcTHoOKGV1joRhfr5KKN4hOgVePrvvbO7KxL6obJbMdjn
         LXRVskE064B3usbZnSg1ZOlAUJbgdLZpzBVQs/cUfGZ8kh0F5ieYROuHG71od7xyxPLl
         WXaDs4WJbyNHYLDKbWEJoY/bjHpTb5WCjA2mIsSwI6Uee422weVV88bvX263YVFfKqtC
         /sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678517; x=1774283317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdY0MHpBaQytGDjrwl6No73PmmhiNXL6flXFjxFT7cE=;
        b=h5bkmtRP9Ef2n9GEda6f045qxQGJjOxnbUCpqtaQiQLDnpp/IuV3R2fKl1k8Kx6jfZ
         TzXUqpKzhyFi5H+LqeYHh0zXacZqelCu4LsxMYagOcLDGqvU1EQ3fWT1kwEWYQVa15sT
         eJOV4o2BDWPgTHGLK/CrVZjTVO7yLbwKoOlWjYFzmcVoOsdnCRReWjr1C24izf0hOhax
         7sTJJQb5sefuGEK7jd2IZvGR5Yv0jjJJ/ghQ8j9EHkEIMxy3yVDSI0ph7QTB58biWpU9
         vfG7sAp8zM3JRTlVVduluEj4GFgIsztP5HAPufiDWi82267M/j8ryvbC8dSIex3Oyrol
         xsMg==
X-Forwarded-Encrypted: i=1; AJvYcCUNWWEvBGBFOtlXl3AvS+tZZc6vT56I3/m2id0txakSTiURVGiZvIgeJTFbIonSGBI3+vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY42wm4S6xcXAAADkha2LN4NQypCzKqtrdAyDaUDD7MxG90ZsH
	yGX77aU+E2XV7c2h69Pez4HqIyDWrk27CoVAFEUFFwIPhO9tnkCseoyepPZOiKUV1w==
X-Gm-Gg: ATEYQzzh2bmA5Hg79dOb8ZZduLPsouUZAjlmMDjmj/n2rv6rdpkzF0O1mQiAxyq+Ver
	8ggo7g2DlFRxb3OPLt1eLi/uMRCWM84S92OEkDXURpMnF2M3bmCIQ104remaDxwfehSAIazjZ5o
	MRbNCLRcMwD00xnNrZhJ+Jy07554Okdvj4OSNiexU2i2UeuKq2L2L9z+Tl5QTZW+MJZyzWE2qkb
	kS9sUJzM9eraPc7JrA9+7+74u6vQgiLrUbkFQOeAAYPaHtfGe00Lw7ezfObdoWcVXu83zFMPh/b
	5vanJAJVKIcGiUXA9Ba40ODNuESroGR8c9fqT4XroMAshhsNEH6aoZ/LH5S0I5NePEG8VIPCtYE
	fI+JWsura8u4lBxxCPpisX2t30N4IlMs8smwoD0Paq748Aezjei5Fsbyu1Va745PPUfQpF+f+dV
	AX0lHQu9Jsu1ciEqvkS7z8MMEpziJtCulPr+8pBZnsKG+BlysxtQYQFqfNJtfGgKX4lZgK
X-Received: by 2002:a17:902:d48b:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2b042d512d2mr5465485ad.11.1773678516811;
        Mon, 16 Mar 2026 09:28:36 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada5c760sm115860a91.5.2026.03.16.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:28:36 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:28:32 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260316162518.GB1767448.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com>
 <20260313083918.00005731@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313083918.00005731@linux.microsoft.com>

On Fri, Mar 13, 2026 at 08:39:18AM -0700, Jacob Pan wrote:
> Hi David,
> 
> > +config VFIO_PCI_LIVEUPDATE
> > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > +       depends on LIVEUPDATE && VFIO_PCI
> > +       help
> > +         Support for preserving devices bound to vfio-pci across a
> > Live
> > +         Update. The eventual goal is that preserved devices can run
> > +         uninterrupted during a Live Update, including DMA to
> > preserved
> > +         memory buffers and P2P. However there are many steps still
> > needed to
> > +         achieve this, including:
> > +
> > +          - Preservation of iommufd files
> > +          - Preservation of IOMMU driver state
> In the interim, what do you think about moving forward with noiommu
> mode without preserving IOMMU driver state? I’ve tested your
> vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works as
> expected.
> 

Just curious, are you using qemu VM without iommu device for noiommu
work or do you have actual system without iommu hardware for testing?
