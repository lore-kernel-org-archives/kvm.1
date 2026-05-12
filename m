Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31F3A16A1
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624988; cv=none; b=snzAzje3NTmJ0p+/K3+GMvcF8mimcPHvWv3QMFztvRqcg36FzOR1soLEQeK+as2Cmye07eyUe9nIXGBxdxWbBUZSx38XKurAngJOnU1y9S5a/gay+LIBvCAdo0GC/hK1BHylHYHcz+VCjnIC7RNBUPKP1ErWOkPACMzV90LNsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624988; c=relaxed/simple;
	bh=Q3BSnpQjjo24GYH+K8YZfJrIUBzm8VwHg2FJ+gC1p5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB1Hhkdndlgjm+W+Ol8wQL+krEyEhjoYkoInM/rKnpn0zzmltbMh3odUJlj2OJCCjUBHUXwKS7Pfgf9EC9CXnPztTwsQGCA4dSC3qNtokIvrRtfj3t2maI/ck4uh6FKora8zyjREQyQYLqTv3QaQTAdavHvFgzIjPdx90o3kGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CenvxCx0; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CenvxCx0"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-132cccd3d77so85c88.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778624985; x=1779229785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A91sQDiDjkh+GXesefXA7O5mW+fBVnqghfkdmyiPV8o=;
        b=CenvxCx0f5E+U6TVQ59MB/p5cQ8/hbYvTYuKV2Z/5T0sBD8aIh7KcQw6WGoFzdw5LB
         fudnrc//vqiJ6lxZHBRAKFNcXI2aUNoabPtFqk1iL5b+0Fr7h2bCKR22Hy6b8Ioklp86
         WFqEbiVgoFmhZpGEYJr1GWs6hDHUl/ProE5iTn6dzK5pTUXsquAGoXydEGLSwvYUkjoS
         jTGHnA8ylAJ5NvOp2xaPbj3MDOz3TsBGfPWxMhHJq5+1zA4bc4mTHXUKnAgckWKLNo3B
         L+iI3mWgm1FYEzrr9T5Bfmh6TLqzFjjwIG3br/4Tl3vHat3Bx8RfddJKjtwUc58E5sY4
         gMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624985; x=1779229785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A91sQDiDjkh+GXesefXA7O5mW+fBVnqghfkdmyiPV8o=;
        b=EjWUETg1VkXC5OpQT+854+OXGCZ7cRopBuEY4+1Wlo0v5DpW6wqTwXIABDoUQLkpL0
         Fubl2HoVY+RuVTsyEi0TqaVAf9U/j99Ejr8anDPRMGV9rOzd8n2w7KkJ1KBTP0eFu0+z
         Wp7MllzQmfxexE676Hx/MOJHV0oQEI14oPnSn6LiV96x37p6vtTIc43HWBYr/K/f7zNK
         DpyiFik4U4ID7OUj4gtkH3x26m2i4b2+AFJJsY7N6kOWda/6JhbwP3FXEwzzqQ9+G7o7
         aNfnsii/gb5DOAISufVbYylge8HKESGYeuvVRgb9C3AMXfehiooeZlh77qK8Tyl29NzL
         epRQ==
X-Forwarded-Encrypted: i=1; AFNElJ95i3osajWHiWN+3oPOi4VoDPaGUCy4FmcDb9WbnSv5DbrN94d6wj40T78Jar4wCV15u0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKr5AdLRnCo54AlTZO02esVs4Uw7LiW9LNyJxisGirTa1/4Yqw
	H3NifHlxJkETMTy0pMxa4XbPlmCmUuTPjfEVdoFZFlSLbGeBk8wn1oTlirRmStfDQQ==
X-Gm-Gg: Acq92OHZgf2JJx40bJ2hdCGqmc8qGC3KycI1sYgz64HoF252HeDUpMFRKcOoKtzfZeB
	Thu4U2+j3v+YPrLV6POnhdgfkZL5TF89pBXFfyDHP/x1OSpNyrJmcFJ81o/QpjHGqrWBPG2D5nD
	+GPsoTBiVTPkLnvnlme67pKmp3zKWSMh5KpOiMkiXI6dEc7Kd15a8G7Rk1taT9iUya6GbXhXKMG
	q6UBQX2NpUicPQ76oLWCoPePLi959Cb879J/bhHw8TEuAfgTuGO9dW7jKB1nPIb1ZBDOyLj7elO
	hrknHRHGnqThCMnPKAazLXKuMLnRE42ajFMC5rES/liacuYkrdlls/xvymU1O/GUXzQoqW481xu
	yvbBkFSdDXgbcKvanBrpB5xQ8vhwO866W/OoWmA1TmujGo/YaIp4eiLaX+087LnI8lWx9eCKN0O
	SuvR4LQ7YiIRIcAsEnHPYGYykY0rNVwK+jR5WoJ6c/VMd3R0os406/+ZPc93UAZrunj06dU0oq6
	nP6Cfqc
X-Received: by 2002:a05:7022:613:b0:12c:912f:7d1e with SMTP id a92af1059eb24-13489ba2ee7mr46570c88.7.1778624984910;
        Tue, 12 May 2026 15:29:44 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210d40sm25341631c88.4.2026.05.12.15.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:29:44 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:40 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/8] vfio: selftests: Expose more vfio_pci_device
 functions
Message-ID: <20260512222919.GE3046123.vipinsh@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
 <20260505212838.1698034-6-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505212838.1698034-6-rananta@google.com>

On Tue, May 05, 2026 at 09:28:35PM +0000, Raghavendra Rao Ananta wrote:
> Refactor and make the functions called under device initialization
> public. A later patch adds a test that calls these functions to validate
> the UAPI of SR-IOV devices. Opportunistically, to test the success
> and failure cases of the UAPI, split the functions dealing with
> VFIO_GROUP_GET_DEVICE_FD and VFIO_DEVICE_BIND_IOMMUFD into a core
> function and another one that asserts the ioctl. The former will be
> used for testing the SR-IOV UAPI, hence only export these.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: David Matlack <dmatlack@google.com>
> ---
>  .../lib/include/libvfio/vfio_pci_device.h     |  7 +++
>  .../selftests/vfio/lib/vfio_pci_device.c      | 47 ++++++++++++++-----
>  2 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 2858885a89bbb..898de032fed5a 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -122,4 +122,11 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
>  
>  const char *vfio_pci_get_cdev_path(const char *bdf);
>  
> +void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf);
> +void __vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
> +				    const char *bdf, const char *vf_token);
> +void vfio_container_set_iommu(struct vfio_pci_device *device);
> +void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf);
> +int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token);
> +
>  #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index e59b6689f4576..53e01cdb2b4e5 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -204,7 +204,7 @@ void vfio_pci_device_reset(struct vfio_pci_device *device)
>  	ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
>  }
>  
> -static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
> +void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
>  {
>  	struct vfio_group_status group_status = {
>  		.argsz = sizeof(group_status),
> @@ -224,8 +224,8 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
>  	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->iommu->container_fd);
>  }
>  
> -static void vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
> -					 const char *bdf, const char *vf_token)
> +void __vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
> +				    const char *bdf, const char *vf_token)
>  {
>  	char arg[64];
>  
> @@ -240,18 +240,21 @@ static void vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
>  		snprintf_assert(arg, ARRAY_SIZE(arg), "%s", bdf);
>  
>  	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, arg);
> +}
> +
> +static void vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
> +					 const char *bdf, const char *vf_token)
> +{
> +	__vfio_pci_group_get_device_fd(device, bdf, vf_token);
>  	VFIO_ASSERT_GE(device->fd, 0);
>  }
>  
> -static void vfio_pci_container_setup(struct vfio_pci_device *device,
> -				     const char *bdf, const char *vf_token)
> +void vfio_container_set_iommu(struct vfio_pci_device *device)
>  {
>  	struct iommu *iommu = device->iommu;
>  	unsigned long iommu_type = iommu->mode->iommu_type;
>  	int ret;
>  
> -	vfio_pci_group_setup(device, bdf);
> -
>  	ret = ioctl(iommu->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
>  	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
>  
> @@ -261,7 +264,13 @@ static void vfio_pci_container_setup(struct vfio_pci_device *device,
>  	 * because the IOMMU type is already set.
>  	 */
>  	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
> +}
>  
> +static void vfio_pci_container_setup(struct vfio_pci_device *device,
> +				     const char *bdf, const char *vf_token)
> +{
> +	vfio_pci_group_setup(device, bdf);
> +	vfio_container_set_iommu(device);
>  	vfio_pci_group_get_device_fd(device, bdf, vf_token);
>  }
>  
> @@ -323,8 +332,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
>  	return cdev_path;
>  }
>  
> -static void vfio_device_bind_iommufd(int device_fd, int iommufd,
> -				     const char *vf_token)
> +int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
>  {
>  	struct vfio_device_bind_iommufd args = {
>  		.argsz = sizeof(args),
> @@ -338,7 +346,18 @@ static void vfio_device_bind_iommufd(int device_fd, int iommufd,
>  		args.token_uuid_ptr = (u64)token_uuid;
>  	}
>  
> -	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
> +	if (ioctl(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args))
> +		return -errno;
> +
> +	return 0;
> +}
> +
> +static void vfio_device_bind_iommufd(int device_fd, int iommufd,
> +				     const char *vf_token)
> +{
> +	int ret = __vfio_device_bind_iommufd(device_fd, iommufd, vf_token);
> +
> +	VFIO_ASSERT_EQ(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
>  }
>  
>  static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
> @@ -351,15 +370,19 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
>  	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
>  }
>  
> -static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
> -				   const char *bdf, const char *vf_token)
> +void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf)
>  {
>  	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
>  
>  	device->fd = open(cdev_path, O_RDWR);
>  	VFIO_ASSERT_GE(device->fd, 0);
>  	free((void *)cdev_path);
> +}
>  
> +static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
> +				   const char *bdf, const char *vf_token)
> +{
> +	vfio_pci_cdev_open(device, bdf);
>  	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
>  	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
>  }
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
Reviewed-by: Vipin Sharma <vipinsh@google.com> 

