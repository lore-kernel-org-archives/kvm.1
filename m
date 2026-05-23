Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5232B119
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779543242; cv=none; b=h6H6iErEXrjEConhP8SuHVJmvg1+bVO7GFEhTuqYQuDW7gxp7Gt2qqOVU3NPYTPB1qekyKSZ+S82hz96wgIWaMkYFIern+ZDTUmMTVUzFwd3ssg2/lsMofDOo+VJzDqkchU2EY/9JcyOVRdXGdUVxVZjuzpBmu0898bK7VtOZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779543242; c=relaxed/simple;
	bh=5iCgyzuUNoEV0PAomPH6D8+BcG7Zu6jTnS9GnfIcS78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3nIZaV0W9FkDdS4Km34vT/eZ1beSP6x40PPZOJsHcrCbv0/Za4pwvOWqddxNuofx1YnXNJcSr71PhQKRIvIgk8TXvpA3NqCwJAEEYzt+OmYcs/3aSwd+oKaj7wZR/4cenr/uL0v+VIR3fyfJROMkOrO6e6jY/niAJ5PlDKepbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DpExUmpF; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DpExUmpF"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e97863425so89144301cf.0
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779543239; x=1780148039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScTPfMS4uBwckQ+rbDYkW0EYBsK6B7QnfP4yXtD8oFM=;
        b=DpExUmpFP8obfFBqfuCLP6S86VQxeKfKTnI84/eQWNTGC7rhtfVs36sVe8n/tNZvUc
         v1qVHFDO4yAoDKsMKUObbZEhnaxsdG5vpMy300Nu4T8gr4eog7rp1VBOd6ZFQKr03ZcB
         /ckYr/TgdWnMsPj7Qikt/ylG2I2aSN05CNR4Pl7sGShx9xpSsgIxgCq0qGribQ3KAT3B
         y9eSBAPiijYKUCOOqykVYClGG74tJVPdDE3aEbklrThWh1Zn9H8mzBvH3t+NRs4VQpnK
         QsuTsMEcaQW9qHd94kQTvGAdL7QP9qEn1GtrEq7vywGENJl+6ZgJxwFui/twhXIf8x/J
         tuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779543239; x=1780148039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScTPfMS4uBwckQ+rbDYkW0EYBsK6B7QnfP4yXtD8oFM=;
        b=oLwhaKBgTjyLHg91jOKEThlenjpqqf+IpHd+OmrTgM+3rENec3of6Z6HNui9x3bsVy
         fvJPbed7tMjzeBbgSDnSX0CbivA423UE3LE+IX9oD2QAIPM5RJPdL1cFygq1vHU9r17K
         sw08/yUNyTsyqc+y/b8Q6p3jjYlZz3ckslPDY9CPmVIutK/YI/PjoRIjKX7b6kXKqQg9
         3A0iSh5Z4Ga1kdrGpQkdVkrXEG+Jl+oruKftCG1HIENWzR985/SNkBZrYJ/bduzry+1o
         QFcmnLzc/WyDEK+H1lEfLPb/IMhSCKzpn9x7+cm+I88Fc86fDqzm/t3EsN89JBaQ3924
         epzg==
X-Forwarded-Encrypted: i=1; AFNElJ8YV7iyPs0iw8h2nIKTqMQsr6vAM6BfiF4pOskHrgWeKyuQnZcYS1ujxa+5oUrKP1kZZ0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vpIJOXEKzbPw5v9YDM8Hx5PbiqhLIsXGJanhZv5fmVG83r8a
	1AaTwDpEpwjuwBfcB1kjxzEAaopZBn6RYhLfVsywxjR5MiJIOhzBcH4f5AF/aoPb4tY=
X-Gm-Gg: Acq92OFOm4LzLskfIuasGP5UrWVcr8EMN247B5anjOZ+a1+zEvfdjLpe0FETSYjax1t
	B33TuY3Hp0wfhcNcNI6XBmu3pAkDFBoDMj/GPTSV2HnIiXLUfWaKDi1s6LlPxDmJd5KdnN83MRz
	uzv4Lvht3eMYPO5hGUYP6ZlKYAEWo6wHcQHhIWTjRXtHmnqNOnE33+x1QYRbBTVSuQvDx9spUip
	cKcmkTfcO+5SNm0fg9xobdVJ6WE90HTfIWxZuUaUp0hr3NMQs5ntCM49Y61TkXS7gA3jmEq9mTP
	wyyUps61PuPjXsPBPf3eDUJu/BnSqWQUHGgPFKKH3PNUw7v4gRS7PsiU43fIkpONaoQR+I8aCC/
	Q15pyE322Knzc5aU5/kgP/O/b3kXcGdECjW8eJUIaljrtuxvhGoDLrRHk4CPn1d62TYKU8BXWdw
	+QpA1cpDJdKU2ay5nB3yNXsVnlf2R4qdZigzFN1BOdVdGM3DxssG2CnjwVEqFL0HiwEne72Mouh
	nxQHGXjQYo0XU2A
X-Received: by 2002:a05:622a:588c:b0:516:e9ea:1c32 with SMTP id d75a77b69052e-516e9ea1f17mr7464221cf.9.1779543239413;
        Sat, 23 May 2026 06:33:59 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131524esm46180116d6.40.2026.05.23.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 06:33:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQmUH-00000006Hta-3suz;
	Sat, 23 May 2026 10:33:57 -0300
Date: Sat, 23 May 2026 10:33:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260523133357.GH7702@ziepe.ca>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-7-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:23PM +0000, Samiullah Khawaja wrote:
> @@ -266,12 +273,22 @@ struct pt_iommu_cfg {
>  	};                              \
>  	IOMMU_PROTOTYPES(fmt)
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
> +	, .preserve = &pt_iommu_##fmt##_preserve,	\
> +	.unpreserve = &pt_iommu_##fmt##_unpreserve,	\
> +	.restore = &pt_iommu_##fmt##_restore
> +#else
> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)
> +#endif

Don't do it like this at all, new iommupt unique ops should be routed
through struct pt_iommu_ops

See how map_range/unmap_range now work

Jason
