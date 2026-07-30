Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137B4749FD
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453620; cv=none; b=NNCDCm5No46/OlHmIj7UBKjfMAw6Qs1ZSdXqqRPu5KhCp3ehJuH8N7qzpoXF8MhTkyZsfWZB3sYFOrJG+GTB2GmhWJhnVFKm7hpRA6pKckJLoIgiU+E59/hEq7kpawpEt/rbWBG3Sth7Sraf8pbdCnsYxHcJmgjPkeZYCzvej1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453620; c=relaxed/simple;
	bh=D1HG6b77iifw3DUMszzZ7R8qVj01yGi3PV2UPXRdquM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTKJhrF8KJLGkAC6pk74rgITveY5fx62e/VHsqQPeucYmauAWvWizdI0cYkfYLYLRRIpAruKc2zTKcELpeFzh6W1qNeHF2ELB/EwOYw22lz/2TTQS1hn6kbih8vydbWacFbZD2zmqvuOliax4c7EmK/uPN/gM8llVAu+ilC2iV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJmG/Hjr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJmG/Hjr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccdf36f63dso57085ad.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785453617; x=1786058417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i8nq0/Hmm93fF2JW2THyDFZojbW5xmKXoinFZToOHmQ=;
        b=EJmG/Hjr+YdbZnwRfiRY1eYlZTOV2eeL3RN70Cfe37RhydlKsY4jDKXOu5lN2oG6IU
         bQ4k8Q6L9PNwpwpMlbXVd0lOkfgBCvkxJWGUy79dQDNRks8IqS2hnBPVpESe4wqDsU9E
         ovBfcHDSazjA/FoAfbUialeirbvZmMyKt/LE9TxLXX5FcrawobnODpL7zKyB3fOujiwf
         yCX5+KuwiDvjW0F2ZliHFDvPh0j8Zd4UZBFtw/wHztJzjMcDI59mvAZNTyWLcNBUq8R7
         dSF8qCRCKU4kvHQaew/7BUzKZ6bL6i5ZtMRahhx+M795j0pHgn4q330wbzJaJ8ewFNut
         R56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785453617; x=1786058417;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8nq0/Hmm93fF2JW2THyDFZojbW5xmKXoinFZToOHmQ=;
        b=K+8zlsM3PuXMJitiIfJAvKv2DLfAuNguKmw0fQ4xDrQN/iAssbzoqwm1od+alPWIfK
         xl6gH/dTpS7/RzzhGkSy4oSxeVuv6IabrqqdZupfZCMAslAXP40SEwF5mUufIAzFCeff
         KKNuInB+e2nai2z+y1F0rEVJO0jkgVOe/OJ4W0qJ0vcheHD837RZLi0sDR/p68VB8AoA
         9rPSsPnOGNEvtGqTYswsK6PQDfoUxoVEGBHgVmH65TeQ8zncITfZaQbM4gZbccV+mrch
         LVJ58rwzLJBisduEoGI6ZcXlANyPZVOfPJZ30tAmGTQT8uRrwle7H6uVupCmiit3ip1s
         zDUg==
X-Forwarded-Encrypted: i=1; AHgh+Rpe7Kq9vu914qYsvVtTbL1h2bTGPy4f18lzjGq5omiN2SP3/DfOIUtTxGYbC2tcGbBJlIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9JRQoBCaxrCAYfK/0b4lfb0aIZq3VGRvDyshbWxx2n3VRnsPQ
	b6xDWbmseAEvh5252cChe6Gom3lF2Lw6x2XBXp4MVhOua6x3z0zGRmXb6eAB0iKrXA==
X-Gm-Gg: AR+sD135xZSadOMhq+C+MPCqktd1koRntSX0zHxFnyrrE9DkXHjhgd2CQ+8y8SfidMX
	v8+ELGeKYFsSFtX1qorttxOH73Eb8XFuHcWai67qMPlRl62KvvTH0GbnRPO6osnP14Q2poWfoCk
	TTJWaon4bRFJPCgZVBP6tJf6Nd2JXmXdYM9ELwdsWXjt8j6gC/C4kXgMM7toqyr69x/0hLTrkR4
	ewEvTbOaPgJtC2kIAqToBMOK6glp4RuTbNFysJKFnETaPLFlY7hvnKujot/bz7eC+sS5q9GsJrV
	F/LEF9uYnAeYZVCquldIuyk39QZBT/Ia+/t2s2tfS8skvzrE1KFhfRjTi1I2GIctlVptsWs9Jgq
	IoB+17ZEptPFXKkdjAmEc45vT7E68aZo1uJhL8NQiWiXMeTv4LwLIb4q77PdzikxClO9pbAMmHO
	w5wSIlR/nJLrs0o1YOuyY4HVWgpSYKmLfo9N2wlZ2q9Q2rqN24B0QctKEH1zHBBJJTemeJTP5Gu
	0Fq9vNkH/Sed0W8J8wcFBE=
X-Received: by 2002:a17:903:2a88:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2d043c66fc3mr2363495ad.1.1785453616883;
        Thu, 30 Jul 2026 16:20:16 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7265be48sm24706277c88.8.2026.07.30.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:20:16 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:20:08 +0000
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
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <amvcKL8FR60OoTDW@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-8-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-8-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:30PM +0100, Matt Evans wrote:
> Previously, vfio_pci_zap_bars() (and the wrapper
> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
> calls to vfio_pci_dma_buf_move().
> 
> This commit replaces them with a unified new function,
> vfio_pci_revoke_bars() containing both the vfio_pci_dma_buf_move() and
> the unmap_mapping_range(), making it harder for callers to omit one.
> It adds a wrapper, vfio_pci_lock_revoke_bars(), which takes the write
> memory_lock before zapping, and adds a new vfio_pci_unrevoke_bars()
> for the re-enable path.
> 
> As of "vfio/pci: Convert BAR mmap() to use a DMABUF", the zap via
> unmap_mapping_range() is no longer performed for vfio-pci since the
> DMABUFs used for BAR mappings already zap PTEs when the
> vfio_pci_dma_buf_move() occurs.
> 
> However, it must be assumed that VFIO drivers which override the .mmap
> op could create mappings _not_ backed by DMABUFs.  So, the zap is
> still performed on revoke if .mmap is overridden, using a new
> zap_bars_on_revoke flag.  A driver can explicitly opt out; the flag is
> cleared by the hisi_acc_vfio_pci driver, since its .mmap just wraps
> vfio_pci_core_mmap() and so still uses DMABUFs.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks
Praan
