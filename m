Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163A35C1AD
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963339; cv=none; b=pyCtONaBgtZC488M7T89YnojdJUAicyjpl67Gn9Uq5cQwME3/CicTE/BtI4eil4sShL0bOe3BVzmefEUiRVNmt+1ThsxV3ZsTvfIhQ3Yh7LhauszervOAm9NkqbJHQZXEaZ1oWpFwKdn4mfaixI2E479KIZhMX4UtDwzmG/YEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963339; c=relaxed/simple;
	bh=UanQDetlCjF/6zxJJeIw+AMEstzQ4BQpkXRP4oloNs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEygis06QwWkHda0sZBwW9XUGRanrk3J8x2tVYJoUpVKvevjNK82OjJXh8ev2EPqEl5YDMYS+MV2spYWo9zlM5eFmEkeWNRsdg+2pGVYuIETSJrpc3toeI7Xvmr62gM1W0mDeG8G9OVDVi9Xsdlvbr1RMo08jigyb1bVHUdKTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtS+JnTJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtS+JnTJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aeab6ff148so20715ad.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773963338; x=1774568138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QYZkwutITM3hY/BTKkAjdxJTuUr3dbbtbIB0hAX8jE=;
        b=BtS+JnTJu7dMFjgb0XmaqiRBy56iDqYrI6PlMNrDgpVHoMtlrH2aMKhcWQy92Z4ewi
         n5puP9+InkLigbVY1yOBCf1lYx2vbAP4oob3ieygn1WID7vdRAM/QiUbGWtXGD46+dw0
         qguHZpFQqLjbpadSPaYm3cVAy2vyib1WImuqRs47GHKkAklMeQXau9mJB2Doaa/ZVT6y
         l+UR96sDp/MdA6+tCC75u54BIBroKg3qZS9tbckaK1tl19Ke4twCYu9BBYpN9IA2H3xK
         ojLG7eFQC4zXd6sw1M6R1o5RwxJoui+G89kHLEqXBf8lHZkd3zRSamIWtFgWO8XiKwdE
         8Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963338; x=1774568138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QYZkwutITM3hY/BTKkAjdxJTuUr3dbbtbIB0hAX8jE=;
        b=a3rPlvl348n+Xy0lgnULULQ7SF5cBYa5Nt4KjG9m7VIPyRlWXX5ApKZ2dyZ200oKab
         0Ba83pi6M9zjWhzHEI/7ue9sioHKDMjls7YKfxd1vkXKVMWfuAc9iFAU77dQAHCP7ve9
         DpjnIlUtUZR5+pG78S2++DHdEjUkXJ+zLOpX/BZb1/2XLPNYqLdc0c+ZEd6kqU1h8sSX
         nN8i3jLDBSqh4IRkLrr4EnzsO4ncv5F+QrBSxSSGTktkDDpb378XY0yLHTZ9UMMlCk1o
         T1Vaaebsdye1twWBCr6U3TlZe6krwgephALywSsQEehiNNvpCn6yAced8Z/axADYxVO8
         ma8A==
X-Forwarded-Encrypted: i=1; AJvYcCXJtHNkL+OqRhS9c2l/FbP2Taq9x/juxoAsUwXkeHbekDKZcVO6mNnQs/jdCwUlrO4Cqok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6zddVep4d8p1BxxuPC3PTxRlh3ET0unulZBQD6fO0IH3O6by
	P0e2pPABPNQIlwTSgf2QnlyKonpVu5XdUldlsvCJuz2wEEFOjxz5C8bampeMglY1zg==
X-Gm-Gg: ATEYQzyaXo2oUQNhNFlEURYQXx//bp02k0kfo45E9xjrNZ864zJqJvFGgKjrMnGzWgJ
	Ha3zAUjyp2sNcJLwUUpMpeUBZEWqMqWlR9MyPQeuTgBRobAM+GlpjvUiDSLvrgJOXR9BhDiFoZ+
	3cMC53mX6qzC1CotxgzbhmqitFH3fP2RfDcFWMnc4XyPPns2ujWfVW0hnEb7OhwPbgVz7QQg2Dy
	oHFTsmAQUePg1Ys2iuqKk8RK80gF/JEvnmzktEoWBODfTHxnpDZ0GOYXLL6xdEEYlfMYeTxC+qk
	2+FPBiuM6RDwnEox6FrpBRHmsH7OsVLAhHeroxl5cEzQBXsz6YW+TgeGGIjEwQNDfxZTr1eb7Fk
	PfPnag6gjkbCk7tKVaugqvhuU6XfwtYyg4AzXCkT8rcLG18PJmQUwY1DCRK7GWqug9IWiYvDhzl
	QrshXQuDlGAl0y1ji4ukOXUdAK/yB+905PTBSm+n2TsobYSWGH8IFgMszNP1sh
X-Received: by 2002:a17:902:e805:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b08285639amr1447705ad.2.1773963337286;
        Thu, 19 Mar 2026 16:35:37 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff6789sm3845458a91.1.2026.03.19.16.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 16:35:36 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:35:32 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH 10/14] iommufd-lu: Implement ioctl to let userspace mark
 an HWPT to be preserved
Message-ID: <20260319231331.GB3983821.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-11-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
>  	bool auto_domain : 1;
>  	bool enforce_cache_coherency : 1;
>  	bool nest_parent : 1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	bool lu_preserve : 1;
> +	u32 lu_token;

Should we use full name i.e. liveupdate here and other places in this
series?

> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 5cc4b08c25f5..e1a9b3051f65 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -493,6 +493,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  		 __reserved),
>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>  		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_HWPT_LU_SET_PRESERVE, iommufd_hwpt_lu_set_preserve,
> +		 struct iommu_hwpt_lu_set_preserve, hwpt_token),

Shouldn't struct iommu_hwpt_lu_set_preserve{} be added to union ucmd_buffer{}
above in this file?

