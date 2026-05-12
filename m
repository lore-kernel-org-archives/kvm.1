Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178139BFF5
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625011; cv=none; b=fo1qagplf3eSOyFy5JqMYbxiNVbRn75nKrbk3cz/KstVOciGMDYfM1ga2Gpq85lURA19z7qx+gNr7tvq9SWgJ/bHbHzH8urYj/A3I9+KZQ7s2TvegbLRvHbxQDsHFzzbwFkPJpnRqMvhory12k7pYzJbzEBXCI7Y9DccIT71au8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625011; c=relaxed/simple;
	bh=9fCxDbNGPMjazYoHh2fF3TMbwLt9qQAsxr7wJlhJFGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHUxF6ZnQmW2nD64RUMfm8lxt8me04AiyWxd+CYXrjbcnQhrIrRJ+gE2Bm2Uf27QfFOaUfb4CpnrjcZTQQd5s4VlCPQoyyZjSFU0h3/ZMUzeL5RVozDNf6am8Qlb3K8b8epxRWvCqhnPKQAg+pUbzsnr6kjfbHOU8xbaoEu2olE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apW9kwNd; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apW9kwNd"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1336742714fso89c88.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625009; x=1779229809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98LH8MpkenMLw9RbTdSKnCnNUBIJhTECrud/IwJ6wS4=;
        b=apW9kwNdlRUTP3HN4Fn0rhpRkmmtrpi16hGmS05LzpFdVPt2ktrvltFA/JUNh6lR5b
         GNPxuyFjtvltBeaoYKFE5zBFMxu+PCaxWwNH836lSUrIiZCpCi84hRDY8s/wVZ97xXHu
         GZBcFqcg4TGcoBvfg8GJVvWLMBmx1xUjlLHEdJ5Wyd8yUU7Rt8nZWtHKgOW8PMVQz64f
         H4kF0XeJZnsjDSgqa45C+c++o0fOJjwxs7KB18OV+zpqbTlvJaSVoKli21scrzSGigDj
         7dzBJQR4ouMCuJXOGEv9fFGfh1msW/ORtHoXjG/28ump+hgfxBFPj4BXwTXCbhHXZZh5
         Azdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625009; x=1779229809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98LH8MpkenMLw9RbTdSKnCnNUBIJhTECrud/IwJ6wS4=;
        b=el0nrLA3ZND1sByegRuFzVCDEpjodwbLDfJy3ZpWM+vZ+laLjHpwvfyLi0PHSWBNFt
         SapHXHW8zXn5D9mW2xPcdWBWHJ0F4ydViMyE7KoMHF+GIaUpbPqc5yegLM1TcQJGjLd5
         y5ae1fK8oQBQKKa4qbl4WSsIhWwhF5IpxcHzKTGci9Wo1WDaJk7MZGN8Dj5VsC/u8KKk
         rXHKAb0H5Ka/m9glR/uvmxKCop8OLDXq06PgMsC/3kqh/Jat/aXm/q+v9LVAROBVtYKm
         h9TqN0XnbUdWnQGehdOLQ7AULKgF8suPKytWLPjZOG2AWS7VEi2fx1e57JlfTZ54fG3h
         ZEIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8d7GNZTi5x03XPi1xTdKsTuNDUyof0mr4MaxqVtBhkTxi4XH1NPQysRFOpwqLVKH55F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysshtpK5+ltUO/CPzH084wVzT5EdxHfdF3KmRtTyeCWRZwo/pw
	m58U/y1Tjp+n3sy4imnsmFusdc3ju+X92PbLYqfluUlmq00i2Riz1NpK3SrRg+inVA==
X-Gm-Gg: Acq92OEoVK8lKEKm1uAsWMOYCU5B+nS9+rWKtlBRH5x8x5AUnN8ekKeWYDmJN9nsAct
	CUfIhAhu/1jFfWho6p6Cnnp24G2cqCLOP8ElFxfgk5ni8LBuSGhkH4uWaNvIAzvRZ86YM3pyKwj
	41iCCTVTxvAzvjR/kLX1NGldcqnLD9q7mTc/sswKxvE3KvpBAeZU1u3T+vWoP71C9Lj1tIKPSAN
	6bpoUC+uVI9MoUnc1lzEl2TB52Q1iaAbT8A9QuF5qAzS7qtrJbi2GDBkjlKQpK4l38ZZ6wtD9I0
	Pmo2hPjTs0m2JJUE6lGVltzQpxnrFt/RBuz3vcleXByv20EZr9PeXiZz74d/oXqtgQgRqPplXDG
	HAP9YVmYHu8So/RzyScoedv/uP1RqnHPvMLObwHfyQIxttP0Thflqg2JW7sYx/tuEepP9WFdd/X
	wcB75Y5NnzNB3a+4DJU1c05Ukg2OEnYFxtEWuIv0ooaatJ6kX45uA2NxTWf7ZvAKuO6sSbleMr
X-Received: by 2002:a05:7022:68a8:b0:12d:b5bb:20d7 with SMTP id a92af1059eb24-13489ca3426mr39332c88.7.1778625008568;
        Tue, 12 May 2026 15:30:08 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885b820sm19413854eec.20.2026.05.12.15.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:30:07 -0700 (PDT)
Date: Tue, 12 May 2026 15:30:03 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/8] vfio: selftests: Add helper to set/override a
 vf_token
Message-ID: <20260512222948.GF3046123.vipinsh@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
 <20260505212838.1698034-7-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505212838.1698034-7-rananta@google.com>

On Tue, May 05, 2026 at 09:28:36PM +0000, Raghavendra Rao Ananta wrote:
> Add a helper function, vfio_device_set_vf_token(), to set or override a
> vf_token. Not only at init, but a vf_token can also be set via the
> VFIO_DEVICE_FEATURE ioctl, by setting the
> VFIO_DEVICE_FEATURE_PCI_VF_TOKEN flag. Hence, add an API to utilize this
> functionality from the test code. The subsequent commit will use this to
> test the functionality of this method to set the vf_token.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: David Matlack <dmatlack@google.com>
> ---
>  .../lib/include/libvfio/vfio_pci_device.h     |  2 ++
>  .../selftests/vfio/lib/vfio_pci_device.c      | 34 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 898de032fed5a..4ebdc00e20fca 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -129,4 +129,6 @@ void vfio_container_set_iommu(struct vfio_pci_device *device);
>  void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf);
>  int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token);
>  
> +void vfio_device_set_vf_token(int fd, const char *vf_token);
> +
>  #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 53e01cdb2b4e5..6b855fbcb4a22 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -115,6 +115,40 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
>  	ioctl_assert(device->fd, VFIO_DEVICE_GET_IRQ_INFO, irq_info);
>  }
>  
> +static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
> +				     size_t data_size)
> +{
> +	u8 buffer[sizeof(struct vfio_device_feature) + data_size] = {};
> +	struct vfio_device_feature *feature = (void *)buffer;
> +
> +	memcpy(feature->data, data, data_size);
> +
> +	feature->argsz = sizeof(buffer);
> +	feature->flags = flags;
> +
> +	return ioctl(fd, VFIO_DEVICE_FEATURE, feature);
> +}
> +
> +static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data_size)
> +{
> +	u32 flags = VFIO_DEVICE_FEATURE_SET | feature;
> +	int ret;
> +
> +	ret = vfio_device_feature_ioctl(fd, flags, data, data_size);
> +	VFIO_ASSERT_EQ(ret, 0, "Failed to set feature %u\n", feature);
> +}
> +
> +void vfio_device_set_vf_token(int fd, const char *vf_token)
> +{
> +	uuid_t token_uuid = {0};
> +
> +	VFIO_ASSERT_NOT_NULL(vf_token, "vf_token is NULL");
> +	VFIO_ASSERT_EQ(uuid_parse(vf_token, token_uuid), 0);
> +
> +	vfio_device_feature_set(fd, VFIO_DEVICE_FEATURE_PCI_VF_TOKEN,
> +				token_uuid, sizeof(uuid_t));
> +}
> +
>  static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
>  				struct vfio_region_info *info)
>  {
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
Reviewed-by: Vipin Sharma <vipinsh@google.com> 

