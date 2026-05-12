Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2D18FDBE
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625031; cv=none; b=T3fzuSy/xpczh1CFMZGDW0tnQhglqW8BSDG+hqOz+5uAfS4hDU3IwpycfMwSn9qnF8Lsjx7Z1IMLqLt5HEVR059pQdZqi1jteFT+1XLP3v6IwbbpR7rW1dhuuAUsvnR+k7IYiZhRo/TMeQtHBDWDveBgCuur+4TSRYoR2ALO5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625031; c=relaxed/simple;
	bh=OIEfn+/2+DaJyxRNqncYOzG1Bc1ehsDrVLl6kwMt7/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avL0oWX9BAE2Cp5t+MLkIBYChiEBLmxr4Dnl5THGS4CMTZ30UtjSluwFVUXMMX8BeagXaHYDQiWmsjBVUfXNyVhaTYBD7dwTmjJ4YcD3xCOLp59Gxh9hqN0k8sgrhJGTvB5sccPhn9J0Af7TKqvz7QwVjlhVRRjyQtw4SckLOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ik5o48IB; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ik5o48IB"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1336742714fso91c88.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625029; x=1779229829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fUE3ggTXLdFmMqzX5xEOlnUW7TclhTbhVIB3cc1f9SI=;
        b=ik5o48IB6msp5gT2s6/CkKGWg3qwtP2g3dN+eXf8+u5DVObH3dqJu3gtbBggU3uChN
         pEIcRMRX/30zIKqj07GL8iIjbjuza/+UvcKyGA2DO5DkgRT8gBbMj/nfOtDd3NtfB3GA
         v03eWpx0kOxG13qF+gNUfFIYu2wDGJpZIrAxBNFpmGUjNTz/6V5sc2WGllK8pyo7LS0H
         ERa+B7PnYInXOG3bI3zn49Y/dj2pOacyCWR1/eABthC5ITedPrvjQvIHd+zwUZduZI1j
         e6sInmY84QRhE9g5qDPXaihJHew7eNbadcUGcuifarJjK+Z3nyOZmOhGq+8Fgc8pAn01
         O/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625029; x=1779229829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUE3ggTXLdFmMqzX5xEOlnUW7TclhTbhVIB3cc1f9SI=;
        b=AgGJ25j0EhZxwCtrTOlFf3MNEV7RL5nuzbzUhyHGNqrSxPLAVYtx558a6dux8t4zRL
         Pw7Wx0AzPCv/k2HGmyG0SHE+1yEdEp3RzWQK5q4wFSbWPR6hmgtj6TS6BuMv7WXnvfBt
         gxHJOQcW2Iiros04FjOlQswIBgkmyCjwPgsiM21zhbbmanoquDa6UBwU/DLJwrjpQwPE
         uBzkZdV9kys4GyJ0Q2tfv6sH0I6+weozf01mBTz1x27wQhRTWYaAOpg0fIEoScYTgskO
         3XGp4JC2F1bJ7zuDWaPJlqHrCvTTEMBAwR8/oXQI0DuPPOHWcw96XBAXnfTt08ui59Q+
         J6qg==
X-Forwarded-Encrypted: i=1; AFNElJ+E7JNr0TF+61qhKDBJdXdWyfqRdy66gMupYoVzWYn1gI2GD/TTxIxMLhrmLcUv3WEhkUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFckqiPBz7QLRlui/TUFM5RHkme6PiL46qAKUmqQ1fUjLEBfvH
	VqprEoFVoVVuD81Gf7FAf4ZC70NbUk7+/zYutXuG4X1zb6O5//RyKAqiXuiAGF7ZvQ==
X-Gm-Gg: Acq92OGjEcxkB81ziMDRVqWjTxvXO4oYoCsNN8RiV2RZhpjCatxAlpTbpUrv2iBALGg
	FXpwd/cmJ6zNw63T18dYt75TiWcADsxc6Qo0LHZmVHJ/+WmozeE+BEBz1C8IiAgrsrvq4v7uqFS
	nf2KwfmJBQgaxQhhgzDU3mhYevMr50Bb5vflnmSlSf/xJCNuWwXcvTYn4yKhEJVYXnkQWdlyDGn
	37V3oTw+i5q6RvmA7EJUfmzflKtCXkPYde+we8zmNcAI6hnpcxzsl/unlN7TH+XV9++y63ZAie0
	AxadE7a+W/mkge1hu/e37Jkz/8avdoxTH1pkjFAAPtodf+OuXslflUdH5gis9HuG+beDD9m4o5q
	2gn4v0+WPAXBNW6lKDVGf/Kr/leM8ELRUB4zXUaHw/GaKbxqb1SqKiQ9rkjA8VnK3LFokSVH7c5
	//KR0U0qIFhn5BO6x5YeY4pR23InJLE8C5UGrvj9obxHOvRysz1N1/1G53VWhMlYH+W4bRmq+i
X-Received: by 2002:a05:7022:1003:b0:12c:6fd2:948d with SMTP id a92af1059eb24-1340bb51480mr107152c88.10.1778625028123;
        Tue, 12 May 2026 15:30:28 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm26473316eec.31.2026.05.12.15.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:30:27 -0700 (PDT)
Date: Tue, 12 May 2026 15:30:23 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] vfio: selftests: Add helpers to alloc/free
 vfio_pci_device
Message-ID: <20260512223013.GG3046123.vipinsh@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
 <20260505212838.1698034-8-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505212838.1698034-8-rananta@google.com>

On Tue, May 05, 2026 at 09:28:37PM +0000, Raghavendra Rao Ananta wrote:
> Add a helper, vfio_pci_device_alloc(), to allocate 'struct
> vfio_pci_device'. The subsequent test patch will utilize this
> to get the struct with very minimal initialization done.
> Internally, let vfio_pci_device_init() also make use of this
> function and later do the full initialization.
> 
> Symmetrically, add a free variant, vfio_pci_device_free(),
> to be used in a similar fashion.
> 
> No functional change intended.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: David Matlack <dmatlack@google.com>
> ---
>  .../vfio/lib/include/libvfio/vfio_pci_device.h |  2 ++
>  .../selftests/vfio/lib/vfio_pci_device.c       | 18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 4ebdc00e20fca..3eabead717bbd 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -38,6 +38,8 @@ struct vfio_pci_device {
>  #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
>  #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
>  
> +struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu);
> +void vfio_pci_device_free(struct vfio_pci_device *device);
>  struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
>  void vfio_pci_device_cleanup(struct vfio_pci_device *device);
>  
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 6b855fbcb4a22..94dc5fcecbeb6 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -421,7 +421,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
>  	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
>  }
>  
> -struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
> +struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
>  {
>  	struct vfio_pci_device *device;
>  
> @@ -432,6 +432,20 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
>  	device->iommu = iommu;
>  	device->bdf = bdf;
>  
> +	return device;
> +}
> +
> +void vfio_pci_device_free(struct vfio_pci_device *device)
> +{
> +	free(device);
> +}
> +
> +struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
> +{
> +	struct vfio_pci_device *device;
> +
> +	device = vfio_pci_device_alloc(bdf, iommu);
> +
>  	if (iommu->mode->container_path)
>  		vfio_pci_container_setup(device, bdf, NULL);
>  	else
> @@ -464,5 +478,5 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
>  	if (device->group_fd)
>  		VFIO_ASSERT_EQ(close(device->group_fd), 0);
>  
> -	free(device);
> +	vfio_pci_device_free(device);
>  }
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
Reviewed-by: Vipin Sharma <vipinsh@google.com> 
