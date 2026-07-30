Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538339E191
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455002; cv=none; b=tCw2VwvJyGbpACEHo1Xt8dyEI7KkOvOIKJGyzy1V1oaMSRPpdekqYYHhuXxR1kRmvKgFgGTaSn+pfhgj3NhB6M7Yee7k23vc7DoDOMmEcVruTbokY5nfjL9E/pYyOTyjy7JRE2lmBMma5BsXJbclFkys4J+t8qOZSFwCyv4PPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455002; c=relaxed/simple;
	bh=EtBv4ug8/GzoJNUW3Lwe7MHv5uNlqeWbx0nW+DTkR4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVOqNdCRj2o6UishmsaDqfWcwwaCGQA1IsdIIyYQLT0mIsXQieSZ6ShKru8exK2IBPW4H0Gme+DBydbvBI/TFTb6tvGk4zHwqtA+5DjSBrAPs2vDUxOyeHTK4RilAkl95RW1F8/hOqLMqzB/FHNo6L5Y75bIrj40JnLGOijs9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZY0MoCp/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZY0MoCp/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ccdf36f63dso58655ad.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785455000; x=1786059800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=45rkLKaqdLBM9DjpkbwhGyUvtKXILeitur9eOChkeqI=;
        b=ZY0MoCp/FbUwTdDgLNAVNIQ7MpDiDYZ5lMco63yU8nI5ewRwmx8xChNr3jzpTgiTnk
         0Vhd7UCPVhyyw0cglLA7VHJm9QVI/ZytPf2oVUzW8KZ6AdL9WmRSlTuCUSC2aPghPB+g
         9Zwg1oUv9zALj6KaH3/8WR5sjw5LYCpuS3i60Fl7t8DA9SGjSPBy7hiyq8rE2QC1dJEi
         drcG9rI1tctp1SHY63CTJhTZGRd23UtxnnP9XIV51aLpXFEHWsyUH7QUJLsNduvSSxfl
         jdqrQQnfuRsKHt8qUZvwsV8D/DtrJiUfItHM4HjVUb+CbLB8z5txXYk+kvOBauoa7tFp
         +oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455000; x=1786059800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45rkLKaqdLBM9DjpkbwhGyUvtKXILeitur9eOChkeqI=;
        b=EK6Ao+OQ9eRCOYb4bnyHcsugrEcdoIAvNUV5n/HN+7AqOEa/x8lXJD2TFn0dFNhBOK
         hrvYrb92XE3cYliHPIInRo+U3Y6lUAXE0GkJAcFt9fyEGLoNPaHXHWkJnUATPMmbH14S
         PQfCgiW5IQaDhz0q6YgTwb0Pn/MFF5uv1H8nYjsyNRGR8Ba68ISrX8/qs22zGKGk1+T3
         8EsKEZxL2WhavZ/1Eor8owrjjzIGQwwjWr/PY0LSi+cjAIGmAjAejtcmrnjiKYGhtHxH
         9ysc4CyaAP6aFKYGzKvaixkG2Dgfl/E7MYCw9RHLiuVqzVj0qZB2dzLFzfDk2ztt6y+9
         nb5w==
X-Forwarded-Encrypted: i=1; AHgh+Rp14OSnqdU3GBFK2dVz4piDZnT5hB1Q2J6BurT/k9oBW94eiKkq51ewUen3BgH8fpJ1cis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjfNRitp0Hpbi49DDOwqloNf/fWt+ZF82Oh1nZ587z0r9MbmFs
	TzeeEfug210lv03NHe3V4RL2A6QPLrz3dsVFvK97HwqWTvYjEDbWF42i/4/IWW4LTA==
X-Gm-Gg: AR+sD12ePWl8UnhaUz7Rq7nEOLRsGQ4RxKb06AnwcMixdEspAZD8dAC352/fnbbqABk
	vap4NcGztV09ADSJGHAG2poBCsVZlQXpoPDv/FAfRJ/o7f6DXE2mWnL8ysrO3PmrzNiTh5IiZD/
	SLvf/C/c8YFjgwnfghazbrmjULp+RdWe3YsYkr/1eDZEpgkRgjVAKB6MJzrSWO6nL7qPtiXvb12
	4WagKp/7/rTPZsJu2q80g3xH3N3HTudXT/RC7Yn/o+TKSEZl5aak5hlMa3GypoA1dB63VTHCQgF
	MuEYWolshjOtPvRFLhjonSySe7+i3KEjJchKCDZOcHUexehT5JnchZ8HK5riTeME+zyJ3ec+8+m
	opTqlkTa/9QLAUg8KnvRxghiO0HcZUFiBZHIvrE4B5Jyq7VyKcbV5SFD2PApi1kGvRHNQF7ZeaH
	eNtlM9RwHt26QSuYfbkPdenuLklNAyaDzrr7cVP/hpPTt59Z0lt7C2BE6+OSFNdA4uZoqCxj4q5
	iPMnY4hQIFKwOtw+SQ90W0=
X-Received: by 2002:a17:902:f647:b0:2c7:b1e7:501e with SMTP id d9443c01a7336-2d043d582c9mr2482505ad.3.1785454999087;
        Thu, 30 Jul 2026 16:43:19 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7271f010sm29587416c88.9.2026.07.30.16.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:43:18 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:43:10 +0000
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
Subject: Re: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <amvhjtQEjAZI0tJl@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-10-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-10-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:32PM +0100, Matt Evans wrote:
> Expand the VFIO DMABUF revocation state to three states:
> Not revoked, temporarily revoked, and permanently revoked.
> 
> The first two are for existing transient revocation, e.g. across a
> function reset, and the DMABUF is put into the last in response to a
> new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE.
> 
> VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE passes a DMABUF by fd and requests
> that the DMABUF is permanently revoked.  On success, it's guaranteed
> that the buffer can never be imported/attached/mmap()ed in future,
> that dynamic imports have been cleanly detached, and that all mappings
> have been made inaccessible/PTEs zapped.
> 
> This is useful for lifecycle management, to reclaim VFIO PCI BAR
> ranges previously delegated to a subordinate client process: by
> revoking, the driver process can ensure that the loaned resources are
> made inaccessible when the client is deemed "done".  The original
> DMABUF is defunct, and BAR resources can then be safely re-exported
> for use by new clients.
> 
> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
> function common to move and the new feature request path.  Note: this
> now only calls dma_buf_invalidate_mappings()/dma_resv_wait_timeout()
> on the revoke path, whereas vfio_pci_dma_buf_move() originally called
> them for both revoke and (unnecessarily) un-revoke.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
