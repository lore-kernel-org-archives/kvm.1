Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B4426697
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440247; cv=none; b=rGaGnW7EpfobZamQjJ8atWsXpk6a4mN03PMQ3Dt91WgNE8tHaM6F087hYYznbrnrelFQ8+ujrtYCVgP8/lRoegLBLwiECoIbJBoCI8xfWIhCdIAo5Nq5+SxgcKo2Aj4uVxUvRLYLYI6UHWQMMP7vS/ysjgDJdAUObRN9y59g+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440247; c=relaxed/simple;
	bh=Jt98IkSBBfyqxJyzZRRW8T5e08wvwzrqIvwXYwH0ieg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E78ZXcEKtIChVij1JnAGBQNyrM1tLCmbCT7g8WNaxocbIJ2xlqD/zB68BzL1AETbHQnbOdRrWbsfdnDH7hkYZCgwh3bD6gJ4sHw9dMMdf5t93Ur9JLmMY1ikU3NGQYmxkNrmXgxQ0A2WqImLejdwzIIy36WJMnx8pwioYUOVMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smsyi8Ah; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smsyi8Ah"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cede6375caso23905ad.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785440246; x=1786045046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WsNFudBG08sj5R9fNK8ZstEhl3SLgUPJa9Y8Tw68yBE=;
        b=smsyi8AhwpTJKTXN0Yt40sWh6xjK5fBu08XF/WnHqS/jTp1cVOoIp+OivodKt9eObT
         WuQg9t/BfxLzG4U/eGAxdBY0AXgAUzqgqH0D2fShIxS0/r9iHs/rriyWCPB229EcLjPn
         Pc2Oto3x8G/NVo0epM1/r8cBC8YnhpuNQtvX17Febf/Jo9fsXBAnIZQOeEKLxBf8jECe
         PhuoKWzVc5vzY7ld5BLeXXZ3md/hdOR6NddIGZgNIg3nxds35ELfW74/SoAY//AHjEjA
         bRyKhdE+qdK5qDJnqnCWrfY1v7CAHfcPwspRNgyHt7QCEA3opx36Q/4MwersLFphh13n
         TLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440246; x=1786045046;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WsNFudBG08sj5R9fNK8ZstEhl3SLgUPJa9Y8Tw68yBE=;
        b=raNOf5wHekPEcJ4i31RHWEf/3Ep6pJqJB0LIZm9VPUYL+zUUL8Ryj161SAVpNmb38c
         abkhYxngdtbGnXKWBaulHNQELqPPEX6tKhOuzx/WrC1k+eq9M9DJDeCTEFQkaUHR2gpx
         vu+/UAghBBq+/nlGZYNw3D6bpszvyBpteGUXb60YBX4Jo/mOV9HKlwbm/8KofhpzkaZG
         e+PvBoZLy2BuVilQkMl1GBSX5GELFyhAcAqEKW9mq9oszSoNeBzcrBKtgArX//A9WgBy
         qMoKm5rBhC7Au+dQV0PTdM3sd+LXSLa/E7rqXnJaTiC0ClDVZQ6yV13YvnIhv2vyI4NH
         cUbg==
X-Forwarded-Encrypted: i=1; AHgh+RpYJU64W8lSdlIxLUaY7B8fUpUATfhgpjT5lmJqmYkuc5h4X8TvamWsab2U1k6ymUZy/kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNA0AAL1Uu4vUtbh5pwh7kMsHWqHsucM/JcGOPBVACoa1YI+0g
	nQ/fbJwIsf3Xf2uiCQ1RzMNFbSXNaVQAz45IlcEoYQCadz8rEXDu5ES9cYtLNYUtkQ==
X-Gm-Gg: AR+sD13IGtWAeLpBupSSj4XJNWw4DrgUM/DYfr+pcfO4RYmbaApDLa5qU01JMcz1Kjp
	E5dQntV759C3VcxvU7B8v0R6R8Tx4rbwvJsJ57SpteHcorno1pYxNvczViKhxlcm+hE2hSELENl
	YV1bkEZSWkCA8yfcrx5VNUurKZQtH5kj7crOkpkeyHg6mv2e6LQFrxidjcKRpFTHfuFiO0p9Ojk
	dGsAFHIS+aTspxW/1g4Tx3HD78vMlnTFbXdfbaWKK/RdB5mtnwneEIHYoRELasHrmkDk96+ozEc
	3cRJkCWRCKJ/e6Ia+KMAgGp4FHEfZIBGxjgohi4XaLdiT5FAeseAQmTgrmaO+Q0uvLtVdNsODV1
	rjft08Zmg1Ow6qVtorzdUphYa3jjGqEmCophxsDJW3+tYrB8vTfBf6bk1wSv1CEEWy8gEdeZDZg
	kj8fsQ6WVYIgL4f2tlbvmlrQOglg53bxzXpJqJaJKfrxYlETZ9c9oLmxkPRewMAtHOy4gb916pe
	pTk3naH+Uxlez51PcddFOA=
X-Received: by 2002:a17:902:c40d:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2d041586156mr1531825ad.13.1785440245065;
        Thu, 30 Jul 2026 12:37:25 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72745b1bsm22459117c88.14.2026.07.30.12.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:37:24 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:37:16 +0000
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
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <amun7H3esu-1OA49@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-3-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:25PM +0100, Matt Evans wrote:
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
> 
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
> 
> Some drivers (such as vfio-pci) depend on (1), without having a hard
> dependency on (2).
> 
> A future vfio-pci commit will rely on pcim_p2pdma_provider() always
> being present.  If that depended on CONFIG_PCI_P2PDMA, it would make
> vfio-pci only available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit
> systems), even when P2P is not needed.
> 
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE and refactor the
> basic provider functionality into a new p2pdma_core.c file.  This is
> available even if the CONFIG_PCI_P2PDMA feature is disabled (or
> unavailable due to !CONFIG_ZONE_DEVICE), satisfying (1).
> 
> Then, when the original CONFIG_PCI_P2PDMA is set, drivers have access
> to the additional P2P features of (2).  This still depends on
> CONFIG_ZONE_DEVICE.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
