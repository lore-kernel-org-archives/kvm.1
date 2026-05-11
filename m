Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303437FF5E
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530891; cv=none; b=hI4C/2LEPAg6XRbE3BbX5agZkRaTE8oxGh473X63xnbhhYVK7zZnA2kmEkF+zS/rVVrFW/KESV62EU4noicKFRN4ev7PqZ6PvIRspWmtlbJwQshCdPJHluSqQpkQXiI+64Z48ymTFZx2cvDeVaZA90kqblgO+Qpjuk/EDhAY4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530891; c=relaxed/simple;
	bh=rCA9LdOkqF3iTNr8B3UsnH8Z1ETK6NiPONAJ9dtl9DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGI8Ifd5CbkjI4ToiXyjX3XTPZhgrW8aMehgylhvJMpEx8n//Qrt/Y07jzsMsybkUXlVrI/KywuCDuSKGwEfQgPkR6srl3iajPZllRLUmjTEabGrZfEF3g2ZNRaRYNtMOvGBxm1FDFefeY/+8vP/oQGv/TBZgbd7sQflLjr6t7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rM4bn5Px; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM4bn5Px"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132cccd3d77so71c88.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778530889; x=1779135689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JP+cdDjozehYE+Tdzt7VKCFaFUFZARCc2f/zXd4rdVE=;
        b=rM4bn5PxG50BiXTdCNOohSGWYjNU43tkB8yOeMLReKbJYqjHWhma0gVX8+N9FLUUn6
         kEarirxwwKwRuQWS4wafLQ2WfufDOOfCn1qF5a1gqysGwkcKmm4VzSli/H+VMsdvubY1
         4MHff4AktfnW+gAdgVYNfTa2/0iR/CgclYvPFpmNce3k/yycvmdvmppriZwzSK8Xlr1D
         M0YJqSOfH4Q/Z975A3e+YnZrN+LU87e4kfjnoyLhJV/cczS43/qcz3odeR/e1EqbxQTx
         515zwqrlT12auk0iNT6Tt3dVEkgZLcRZc29oq1KYu3E/RJYrMZmSCW43jmmIoKIj0pkT
         T61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778530889; x=1779135689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP+cdDjozehYE+Tdzt7VKCFaFUFZARCc2f/zXd4rdVE=;
        b=refr2Aick8PcoOzA0xPOWN1XgKgJuOM1Ld1pbgDWqjzGfchkYXPFjH+QYI+27GhshN
         B0UjDEcC8wxSixSdVT1f6Kbn7IuNh3U9lItQyPeVTrl2J5ptd6tzCbYJkG5ModS5/qYQ
         +KIgIWemXtgKQHaLB9cuDpeCWyA1e6LpgpFM4QRKL1yJf8JRA7ReUT9/yAS5S+U/SuY3
         m4WAYwWEoOcL9YlmuFxTtHyTbpVZQs555u3Fywod46d3HBCOs++6S1G03Rt26LRJ8iST
         wjGy1pXdm0dZORb06sNFAu44w3ue55FFWDEUtbGqt5fEft4lcLna3urdV6bgF7gx0fB/
         A/hQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OpKaD4ChWw9iRmJVDow+z+BMBNHRMXLTacapUwwni4bMJ+Xpug1G958+RwKfHXuUwZJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUbWV0uDJV3cO1tVkx7Cr0kn8kvsUv821iHGwJxx3uZRrKbyb
	Sv2YsrzSaU5I99Cgf6GGu/jLwE187A87w3yrbBQrFhsmBKWSJo1BKK7Szy7HOcUxzQ==
X-Gm-Gg: Acq92OHByCtGSIRMoZUIbVFMjtLgPOEwGlNIAWuK9G8VQbiygbhNyB1hkhTt8bOSi2m
	iVvLtMJ6zlbepkUNq4qUTT467nkPh3hSmHJZCYVgqWqArXWrt2aL90hj6lI9k1NRlCQeurS/KQS
	hLvvEqIL4hnjV+KZ4YUIPfjShC28kcqQuUd5LPyUYX97mQ2g3hVfTU/wyIf0OtfcECy4aaIpkGX
	VvD9bXkHs7HzAR/lYQ56eiy4Ji5qejwkzfAIMrgXmRnA4K+cIjbYG1Ea+Wp+Mdz9d9YE4+DL+YI
	1lkjVWrnx3PSVMJxBL6cR2Cg7W2zBbrGSCVgxnMsaZs98ZMCwlJW/vhDDPhs+nXIrQ2q/9uf8Pi
	slx6OsoSCRlcOgrJ4pQF/ifcdH5phe9avZ7lsBeafuuoTv9UNtHzJcsHoUHlq1ULn0284l1KDBQ
	Nd2IN7MKrLU6i8g/11u9FjDkE52Ftb4R86HGUT6AJ/WU6zyymMQylWcngWmwP9xLaxd3Rxiw==
X-Received: by 2002:a05:7022:e0f:b0:12c:8f55:cd0d with SMTP id a92af1059eb24-1333e1ade52mr95673c88.8.1778530888754;
        Mon, 11 May 2026 13:21:28 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865a1a4sm16012499c88.10.2026.05.11.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:21:28 -0700 (PDT)
Date: Mon, 11 May 2026 20:21:22 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Aex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	Alex Mastro <amastro@fb.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vfio: selftests: Add support of creating multiple
 iommus from iommufd
Message-ID: <agI2EFvBwKUHaHVi@google.com>
References: <20260505221518.619123-1-skhawaja@google.com>
 <20260505221518.619123-2-skhawaja@google.com>
 <af4or28EA6PGEd12@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <af4or28EA6PGEd12@google.com>

On Fri, May 08, 2026 at 06:17:19PM +0000, David Matlack wrote:
>On 2026-05-05 10:14 PM, Samiullah Khawaja wrote:
>> IOMMUFD allows creating multiple IOAS and HWPTs under one iommufd, Add
>> API to init a struct iommu using an already opened iommufd. The API
>> internally creates a new IOAS and also a new HWPT as an option based on
>> the flags passed to the function.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  .../vfio/lib/include/libvfio/iommu.h          |  5 ++
>>  .../lib/include/libvfio/vfio_pci_device.h     |  2 +
>>  tools/testing/selftests/vfio/lib/iommu.c      | 62 +++++++++++++++++--
>>  .../selftests/vfio/lib/vfio_pci_device.c      | 22 ++++++-
>>  4 files changed, 84 insertions(+), 7 deletions(-)
>>

[snip]
>>  int __iommu_map(struct iommu *iommu, struct dma_region *region);
>> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
>> index 2858885a89bb..1143ceb6a9b8 100644
>> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
>> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
>> @@ -19,6 +19,7 @@ struct vfio_pci_device {
>>  	const char *bdf;
>>  	int fd;
>>  	int group_fd;
>> +	u32 dev_id;
>
>Please introduce an initialize this field in its own patch and, in the
>commit message, explain why it is being added and  how it will be used.

Agreed. Will do in next revision.
>
>>
>>  	struct iommu *iommu;
>>
>> @@ -65,6 +66,7 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
>>  #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
>>  #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
>>
>> +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu);
>>  void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
>>  			 u32 vector, int count);
>>  void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
>> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
>> index 035dac069d60..644c049cf9f0 100644
>> --- a/tools/testing/selftests/vfio/lib/iommu.c
>> +++ b/tools/testing/selftests/vfio/lib/iommu.c
>> @@ -408,6 +408,18 @@ struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges)
>>  	return ranges;
>>  }
>>

[snip]
>> +struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id, u32 flags)
>> +{
>> +	struct iommu *iommu;
>> +
>> +	iommu = iommu_alloc("iommufd");
>
>Use MODE_IOMMUFD instead of string literal.

Agreed. Will update this.
>
>> +
>> +	iommu->iommufd = dup(iommufd);
>> +	VFIO_ASSERT_GT(iommu->iommufd, 0);
>> +
>> +	iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
>
>Please avoid duplicating this code. e.g. Something like this:

Agreed. Will update this.
>
>diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
>index 644c049cf9f0..4909cda5c840 100644
>--- a/tools/testing/selftests/vfio/lib/iommu.c
>+++ b/tools/testing/selftests/vfio/lib/iommu.c
>@@ -443,6 +443,19 @@ static struct iommu *iommu_alloc(const char *iommu_mode)
>        return iommu;
> }
>
>+static void iommufd_init(struct iommu *iommu, int iommufd)
>+{
>+       /*
>+        * Require device->iommufd to be >0 so that a simple non-0 check can be
>+        * used to check if iommufd is enabled. In practice open() will never
>+        * return 0 unless stdin is closed.
>+        */
>+       VFIO_ASSERT_GT(iommufd, 0);
>+
>+       iommu->iommufd = iommufd;
>+       iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
>+}
>+
> struct iommu *iommu_init(const char *iommu_mode)
> {
>        const char *container_path;
>@@ -459,15 +472,7 @@ struct iommu *iommu_init(const char *iommu_mode)
>                version = ioctl(iommu->container_fd, VFIO_GET_API_VERSION);
>                VFIO_ASSERT_EQ(version, VFIO_API_VERSION, "Unsupported version: %d\n", version);
>        } else {
>-               /*
>-                * Require device->iommufd to be >0 so that a simple non-0 check can be
>-                * used to check if iommufd is enabled. In practice open() will never
>-                * return 0 unless stdin is closed.
>-                */
>-               iommu->iommufd = open("/dev/iommu", O_RDWR);
>-               VFIO_ASSERT_GT(iommu->iommufd, 0);
>-
>-               iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
>+               iommufd_init(iommu, open("/dev/iommu", O_RDWR));
>        }
>
>        return iommu;
>@@ -478,11 +483,7 @@ struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id, u32 flags)
>        struct iommu *iommu;
>
>        iommu = iommu_alloc("iommufd");
>-
>-       iommu->iommufd = dup(iommufd);
>-       VFIO_ASSERT_GT(iommu->iommufd, 0);
>-
>-       iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
>+       iommufd_init(iommu, dup(iommufd));
>
>        if (flags & IOMMUFD_IOMMU_INIT_CREATE_PT)
>                iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
>
>> +
>> +	if (flags & IOMMUFD_IOMMU_INIT_CREATE_PT)
>> +		iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
>
>Does this need to be part of iommufd_iommu_init()? Maybe it would be
>better to expose a separate helper to allocate a HWPT for a given struct
>iommu *.

Hmm.. that is interesting.. I think we can have following immediate
possibilities when creating a struct iommu (there will be more down the
road, but can be handled in similar way):

- create using struct iommu with a new IOAS.
- create using struct iommu with existing IOAS but new HWPT.
- create using struct iommu with new IOAS and new HWPT.

I think I should probably add following flags:

IOMMUFD_IOMMU_INIT_CREATE_IOPT (IO Page Table) or _PT
IOMMUFD_IOMMU_INIT_CREATE_IOAS (IO address Space) or _AS

At least one of those should be required when creating new struct iommu
from an existing one. WDYT?
>
>This would enable use of HWPTs in iommus constructed by iommu_init() as
>well, which someone may want to do in the future.
>
>If you go this route, please introduce this in its own commit.

Both flags can be introduced in same commit or should be separate?
>
>> +
>> +	return iommu;
>> +}
>> +
>> +static void iommufd_cleanup(struct iommu *iommu)
>> +{
>> +	struct iommu_destroy args = {
>> +		.size = sizeof(args),
>> +	};
>> +
>> +	if (iommu->hwpt_id) {
>> +		args.id = iommu->hwpt_id;
>> +		ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
>> +	}
>> +
>> +	args.id = iommu->ioas_id;
>> +	ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
>
>
>Please create a helper function to do IOMMU_DESTROY ioctl. Then here you
>can just do:
>
>  if (iommu->hwpt_id)
>          iommufd_iommu_destroy(iommu, iommu->hwpt_id);
>
>  iommfd_iommu_destroy(iommu, iommu->ioas_id);

Looks great. Will do.
>
>> +
>> +	VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
>> +}
>> +
>>  void iommu_cleanup(struct iommu *iommu)
>>  {
>>  	if (iommu->iommufd)
>> -		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
>> +		iommufd_cleanup(iommu);
>>  	else
>>  		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
>>

[snip]
>> +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu)
>> +{
>> +	u32 pt_id = iommu->ioas_id;
>> +
>> +	/* Only iommufd supports changing struct iommu attachments */
>> +	VFIO_ASSERT_TRUE(iommu->iommufd);
>> +
>> +	if (iommu->hwpt_id)
>> +		pt_id = iommu->hwpt_id;
>
>nit: This can be folded into the variable declaration.
>
>  const u32 pt_id = iommu->hwpt_id ?: iommu->ioas_id;

Agreed
>
>> +
>> +	VFIO_ASSERT_NE(pt_id, 0);
>
>Why is this check needed?

I think it is redundant. I will remove it.
>
>> +	vfio_device_attach_iommufd_pt(device->fd, pt_id);
>> +	device->iommu = iommu;
>> +}
>
>Please introduce vfio_pci_device_attach_iommu() in its own patch.

Agreed. Will do.
>
>> +
>>  static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
>>  {
>>  	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
>> @@ -350,8 +366,8 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
>>  	VFIO_ASSERT_GE(device->fd, 0);
>>  	free((void *)cdev_path);
>>
>> -	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
>> -	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
>> +	device->dev_id = vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
>> +	vfio_pci_device_attach_iommu(device, device->iommu);
>>  }
>>
>>  struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
>> --
>> 2.54.0.545.g6539524ca2-goog
>>

Thanks,
Sami
