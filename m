Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006639F172
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624959; cv=none; b=DDPFb1/CtVJSrSppnimPttlVnOKpJPqmd63zWkyIKsn6lTFlbhQxgNE+4lvKre2k+Gbfu3oinQFQTQT5Dp5X9Wc7B8BiR4CA7NMIRGDa0BmIJ3lvXViUIFSwUnclcRZMIoCP1KKHPk85BnNfVbHjmYWVBNRARgPtVKgSoggUOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624959; c=relaxed/simple;
	bh=Tk/BEsaB4tvg+WRMa3WAV4+wLDsjzcE4qj/3sQpIq/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o77iI+atn2l7IZC+AVhWtDUZJHirga/N87Z+PaKxa5dpaTt++kUk8HcHo/ancaHsMYeivsTM4oT/dQrsMaNP96lO9MxaNX9FXXTze6aygBjKAN8Lmm+I6WppAbJNJA51DbQzklEHCx/qe0RbLa+Aw6PV59/rxXNnvd+w5D/mwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqUksupi; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqUksupi"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1336742714fso88c88.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778624957; x=1779229757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sm9Cgj4EYg3TdfeOc7Z2RiQVnGubE/7zAFiD4zyqIc=;
        b=UqUksupikey4zYNREMNbV7pkFfeU72pBwR7QmyNb8xewgYOGKi86jRP8XnH5kzUZ7W
         GmQmTLpRpD8FL8nFC9Qg/xjS6GDFzF0CoD4RHL7Qz2lRGBrI+wtvDqqAkrZ3uUqk8dlg
         mKrfDKwOx/qF/qJ7dhOp3OTlR32YS1OGTi+erQ1jA/G+JqGsR/vspKENn3lT22PZrPkX
         eGOpA5W1ZBgBJLKKYbhPZdkyspzhHQApeFkDLCJ3yNCtmZMPjM8Lat++0G2Ceo2LOxEe
         PscNBpmc+pC2jva3fLoNWiBJ9L25z/c5ZJwXuIFa1c79vtWPlcsrTUCf5NbZuoRM4cPZ
         oaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624957; x=1779229757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sm9Cgj4EYg3TdfeOc7Z2RiQVnGubE/7zAFiD4zyqIc=;
        b=SLgOaSrVLNBQk7hTV3pyvuoCSc4GWdwGCWHGM9UmV4k/u62s0gJYfjFWNLvct/AGF2
         zCK0dGjpeJJ6tV6dw21FbPQIqgt+UsVMvpUz/CvD1L1wZ3OuKWlFQszEPndMlmZtkxwa
         HUVVX/5PVKBOCVaN5OxzZb2ednjjspXWoYOZrsXGTOTG0jqmddPj+am31vSp9OHtRqno
         a1x8FIEVTXis3rh6RXzCnTz+kFvtJY5ZBL21XlZfQDZhLPWB/Mjpcj67eAntKzbuWmSy
         aFXfa9j3Ae4oxP4VdNr79hAJNJvKO/2fMTCW3+aTHdu9Ye2fkEm/VAiSXG83b8Q9oC6n
         bKCA==
X-Forwarded-Encrypted: i=1; AFNElJ81PI6C6BR6O75tcvM4ZYlo85vNiIe8pMewvHY++tm36WXPUreitHAUng3vIRZ50IoRR04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMNpDHzbwmm5oa/XVR2GiEuxDIoUYVVgVZvJKzI31KD7zeckc
	SAVVmn9ERvYZ74JjjJCf6kznBBr7gP4hzqHJRAyWPnJnYjSdpS1xCAfFHG5mrth56g==
X-Gm-Gg: Acq92OGIV2qUQvCIuH9yUxhSRKW0opcQhDR9pHBM/U4mFLTblFm1yt5AdwTRGjHJLsD
	LqOA5XF9fXbhWmT17cg4KIm1eAxpaz33P53OMK+1xemaNaOy3lUAmzKJ+qtx61jnZXeUqCC2xO6
	BK+QGcLnjX8R13+tQnBZDfYIv/hdDO19G/pgotckIQ4sKOPeC71kVlz8DFrcCbTRplpt3Q0E8fF
	BjidVnTM1EpmCGO7q/zTdW3cYjw09dRSHcoZpWqpJTBWJQu+gsf4+jSK5GexF52t4FI2ZSuWTVD
	Nx4owY+AW2fZa7X2ifrFL0VtWycZL0N2N+OOXlfwWSlWW5y32inSExhWiiO1rk6siXzSn6C0VFk
	L+/M/AS2Gy6KR1KvYfrnyo4SUD2M2Mcqrqr9pZssByVesp0WSWywkA3u9vaV0mYDTO/I8cNwUPN
	aflO3Kq8UEqfYg5zcQbSQBCqf4Vn6CdgnV4i4R5PQEE0MXKyufPNzlJE0xVxVUg06YT3U5V8Ku
X-Received: by 2002:a05:7022:68a8:b0:12d:b5bb:20d7 with SMTP id a92af1059eb24-13489ca3426mr39200c88.7.1778624956703;
        Tue, 12 May 2026 15:29:16 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafc2sm24861224eec.4.2026.05.12.15.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:29:15 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:12 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/8] vfio: selftests: Extend container/iommufd setup
 for passing vf_token
Message-ID: <20260512222843.GD3046123.vipinsh@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
 <20260505212838.1698034-5-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505212838.1698034-5-rananta@google.com>

On Tue, May 05, 2026 at 09:28:34PM +0000, Raghavendra Rao Ananta wrote:
> A UUID is normally set as a vf_token to correspond the VFs with the
> PFs, if they are both bound by the vfio-pci driver. This is true for
> iommufd-based approach and container-based approach. The token can be
> set either during device creation (VFIO_GROUP_GET_DEVICE_FD) in
> container-based approach or during iommu bind (VFIO_DEVICE_BIND_IOMMUFD)
> in the iommu-fd case. Hence extend the functions,
> vfio_pci_iommufd_setup() and vfio_pci_container_setup(), to accept
> vf_token as an (optional) argument and handle the necessary setup.
> 
> No functional changes are expected.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: David Matlack <dmatlack@google.com>
> ---
>  tools/testing/selftests/vfio/Makefile         |  2 +
>  .../selftests/vfio/lib/vfio_pci_device.c      | 46 +++++++++++++++----
>  2 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index e26917ee169c5..4437f04660089 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -28,6 +28,8 @@ CFLAGS += $(EXTRA_CFLAGS)
>  
>  LDFLAGS += -pthread
>  
> +LDLIBS += -luuid
> +
>  $(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
>  
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 80e8e5bebd7ca..e59b6689f4576 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -22,6 +22,8 @@
>  #include <linux/types.h>
>  #include <linux/vfio.h>
>  
> +#include <uuid/uuid.h>
> +
>  #include "kselftest.h"
>  #include <libvfio.h>
>  
> @@ -222,7 +224,27 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
>  	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->iommu->container_fd);
>  }
>  
> -static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
> +static void vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
> +					 const char *bdf, const char *vf_token)
> +{
> +	char arg[64];
> +
> +	/*
> +	 * If a vf_token exists, argument to VFIO_GROUP_GET_DEVICE_FD
> +	 * will be in the form of the following example:
> +	 * "0000:04:10.0 vf_token=bd8d9d2b-5a5f-4f5a-a211-f591514ba1f3"
> +	 */
> +	if (vf_token)
> +		snprintf_assert(arg, ARRAY_SIZE(arg), "%s vf_token=%s", bdf, vf_token);
> +	else
> +		snprintf_assert(arg, ARRAY_SIZE(arg), "%s", bdf);
> +
> +	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, arg);
> +	VFIO_ASSERT_GE(device->fd, 0);
> +}
> +
> +static void vfio_pci_container_setup(struct vfio_pci_device *device,
> +				     const char *bdf, const char *vf_token)
>  {
>  	struct iommu *iommu = device->iommu;
>  	unsigned long iommu_type = iommu->mode->iommu_type;
> @@ -240,8 +262,7 @@ static void vfio_pci_container_setup(struct vfio_pci_device *device, const char
>  	 */
>  	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
>  
> -	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
> -	VFIO_ASSERT_GE(device->fd, 0);
> +	vfio_pci_group_get_device_fd(device, bdf, vf_token);
>  }
>  
>  static void vfio_pci_device_setup(struct vfio_pci_device *device)
> @@ -302,12 +323,20 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
>  	return cdev_path;
>  }
>  
> -static void vfio_device_bind_iommufd(int device_fd, int iommufd)
> +static void vfio_device_bind_iommufd(int device_fd, int iommufd,
> +				     const char *vf_token)
>  {
>  	struct vfio_device_bind_iommufd args = {
>  		.argsz = sizeof(args),
>  		.iommufd = iommufd,
>  	};
> +	uuid_t token_uuid;
> +
> +	if (vf_token) {
> +		VFIO_ASSERT_EQ(uuid_parse(vf_token, token_uuid), 0);
> +		args.flags |= VFIO_DEVICE_BIND_FLAG_TOKEN;
> +		args.token_uuid_ptr = (u64)token_uuid;
> +	}
>  
>  	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
>  }
> @@ -322,7 +351,8 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
>  	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
>  }
>  
> -static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
> +static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
> +				   const char *bdf, const char *vf_token)
>  {
>  	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
>  
> @@ -330,7 +360,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
>  	VFIO_ASSERT_GE(device->fd, 0);
>  	free((void *)cdev_path);
>  
> -	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
> +	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
>  	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
>  }
>  
> @@ -346,9 +376,9 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
>  	device->bdf = bdf;
>  
>  	if (iommu->mode->container_path)
> -		vfio_pci_container_setup(device, bdf);
> +		vfio_pci_container_setup(device, bdf, NULL);
>  	else
> -		vfio_pci_iommufd_setup(device, bdf);
> +		vfio_pci_iommufd_setup(device, bdf, NULL);
>  
>  	vfio_pci_device_setup(device);
>  	vfio_pci_driver_probe(device);
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
Reviewed-by: Vipin Sharma <vipinsh@google.com>

