Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793570103;
	b=QNcMbvtMtfTGnsmZ0MvQH/yDal5b3X1w+a+3wRd4GZOR7AJWDUEVgtvU6n9G1pbJPjT1
	 qPEkPdJDN4bFYCyZJ7nI9x8BODt2IixK9XL1C+6u1vTVoplSDWd91yTMEgTfzFK/pd0ZJ
	 /YNEuOlFi2phz7BhN9qts/yU4bvml4yMaT0VGqfLKLMV8d3vMXFpcN2ye5IxCwSl+rqyW
	 E6K+50tb4HV95eqKM7+SlTaG5+AD9OvgTz3rNOgqYmxpsmEyx9al2qh61dD+a2YIsvuUi
	 z5UbmookJWKonlX2Yv/zyicmoqWFZ1Ptfct4iEBaGut5hbvbCCNpz1vs64Qu9Q+FpqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793570103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pH9FDk8PhOZqTZYMJF9VQ6qq2IvSDAE/glr1M5Bsspg=;
	b=gTYpbzJyPlDLCsQSQnczzue8tlQ8y2oKFk4ZHukop2/MZ6JySLMli+8HpeVjufzgJ5RV
	 TwM8DAZGrquFzymiVhnR7xpjS02IBjJgbNK+S/sdXHuPPTsjJY6fMAXjHlGNGe9H0ykYH
	 iEfPxfrx7Ci3OlVUIjbHbfzPAAjBVqKXfiXsyvS8IMkcPqTK6nEcrWHS0eUK9loUDCV8u
	 7uUIR25gcfQb2ciA++dByhyu1XLqMrZFBJn4fqWioWy1FRFbXxXe+s1uYX/QOvKs+HjeL
	 MrnvjLRYgLxj5Q1C9OVyfsFQoGi7LvFmoQA+AzGePsAmyzm+3l6L6UUMPP63gmw5/Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j+FXc7WF;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C82606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 21:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C82606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j+FXc7WF
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9f6a16afcso49865ad.1
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793570103; x=1794174903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pH9FDk8PhOZqTZYMJF9VQ6qq2IvSDAE/glr1M5Bsspg=;
        b=j+FXc7WF2tc/q+FDraof7I5PXE7mWvegDk35vKR6yJdBzaqZwXq1Y+RLxm+NggLFLk
         a001Bggd0PEjPnb0AZgNacCaj5N6ZIZZtj1uDWD5ckFDbVtYDkyibr4NmK/9I/gimj7z
         DCkKYWH7tlacnHknyNYYgRxnVPqDF0diR5avPgNkfZeWmyxCaDZo/cp/hpHQ6nwOZL+V
         PmiumL7AvZTRTQuUY0KxpFw/81M7ZumljMfAcLKENMWkVSRTCIMDZ7zEJZVhiHS7DWcm
         UN7ieMK1lBJA/6HpfDTNKCzD89Nad0Q+nkMTCjU3vN2rgZCPNcwbYQ0ueADhovAIdjco
         QTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793570103; x=1794174903;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pH9FDk8PhOZqTZYMJF9VQ6qq2IvSDAE/glr1M5Bsspg=;
        b=B2TU2TegfHGUVn2dJBQup78Vuki+5aiF6vN8D7JJ1R5NwCLql96HvScd9Po39SHyVI
         zL5PWDZ4OalohYNDqJcsK66Ep1p7CRLgyXHw45kaDfhQfQVjp3flm8EEQCGorT3lqy8N
         Nw3P06EsXcbXeFYCITpxyzTflneY1wun3GQds5x4zPe95Vneq4Ac2m7yBKdQGoG9a6Nz
         FY/eQAL+8l3yyqo+/CVDpGmeEVT9Wjok7d6gy68yuuRO43KR/B5iwMh+9naX4Z2slAdc
         ue7z1ztOAmEOPyE12oioSsFMe9M2DMapXMIdQ87rr1DBt53sC9BuOzHIlABhRNEpCfu4
         CKHQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2X8nqVREbEgi6mlt8AZFrna+xmFqbJdL9ZTYKTh2FR5l0SuPNGwMeetiOsVi2iOW0M3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FPl2E9r0GcTqRqCklbEyAAxXs+seV10iHP5j3sshv7TxCODQ1
	rxIdKw8Ay5fYuqmavLgtSxwRJYbbpdDxmiuMgi3fNCytz+I/a0Dy0Y0PRlLZIaQHgg==
X-Gm-Gg: AYBFou2EUwdPgNFV5wPSF0E7+vBU4A5xDQK1sR+yjzNfrRi+Z6Vbf74J6t6PxMODWoJ
	VaFnK7LtCDMkMsW5+QdZRUS1vrnNCjdnStLZ3KsEfh+44eiG/ySR9RhpyNHw5sRAPm235Hs6xmF
	RfQEatac0BC2vbr4fqcztyqaaZzwUtd4jFOGQDwzi4HtwApWpc9LP7PqzbMgZqQNC/c0K4GyjdY
	uLGEmXTRRV6BT+KO4q8rfFu63sLFD00MrLuhTAmuEXgZf+tz4wkh5YY0lyM8eqj94jmXdpqr/BN
	svHFCiUvtzqS6//xiy0dHn5vE2b3LGcinx6e7JPRBNkOpXjCJXf8qnatxwN5EMCAiOrWAd6V8qI
	59Bgbo685VHZoAa73LIv0kE6fPJwnhSb+1XGQgQkXf/5d4Yy7pcOm0hixv91TCkfq+wPotTxmcp
	LrkrN1ZvEiIy9raauJjYyB70tWLozXBLaKOoJPoeSg76d/fqQmdUBBQofegKWdmxsRFKBusEmrD
	eLwxv7cIEOFl4bB51f+s5odhmXsG26ZhTrvEe1EsGYZjOtWHmN1/giLh9C9JAIJTTR2DmHA2SnU
	BPN4zxwSiUPHCCGfrehIfYs0OdE1fUT0SqCGbkfyJvhra5AchWhKCzU3odYs9PhaNbvxdfNVp/j
	WhzeyYNxl1DpH+MmADoe/aqua09YS77+ZOaAc6cIXAg==
X-Received: by 2002:a17:902:e5cb:b0:2ea:1fa0:8068 with SMTP id d9443c01a7336-2eb1ecbd412mr17712775ad.16.1793570101892;
        Sun, 01 Nov 2026 13:55:01 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9bc6f7sm15137855a91.16.2026.11.01.13.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 13:55:00 -0800 (PST)
Date: Sun, 1 Nov 2026 21:54:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 17/18] vfio/pci: Preserve the iommufd state of the
 vfio cdev
Message-ID: <aubO8llyTiUc38u2@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-18-skhawaja@google.com>
 <2574cbc8-8c2b-4458-9fcd-b077190084a3@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2574cbc8-8c2b-4458-9fcd-b077190084a3@linux.intel.com>

On Sat, Oct 31, 2026 at 01:56:12PM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>If the vfio cdev is attached to an iommufd, preserve the state of the
>>attached iommufd also. Basically preserve the iommu specific state of
>>the device and also the attach iommu HW unit.
>>
>>Once the device and its iommufd attachment is preserved, it cannot be
>>detached or attached to another IOAS until it is unpreserved.
>>
>>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/vfio/device_cdev.c             | 10 +++++++++
>>  drivers/vfio/pci/vfio_pci_liveupdate.c | 28 ++++++++++++++++++++++++--
>>  2 files changed, 36 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>>index b818aab92f76..4eb7ffd489bd 100644
>>--- a/drivers/vfio/device_cdev.c
>>+++ b/drivers/vfio/device_cdev.c
>>@@ -284,6 +284,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>>  	}
>>  	mutex_lock(&device->dev_set->lock);
>>+	if (iommufd_device_is_preserved(device->iommufd_device)) {
>>+		ret = -EBUSY;
>>+		goto out_unlock;
>>+	}
>>+
>>  	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
>>  		ret = device->ops->pasid_attach_ioas(device,
>>  						     attach.pasid,
>>@@ -342,6 +347,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>>  	}
>>  	mutex_lock(&device->dev_set->lock);
>>+	if (iommufd_device_is_preserved(device->iommufd_device)) {
>>+		mutex_unlock(&device->dev_set->lock);
>>+		return -EBUSY;
>>+	}
>>+
>>  	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
>>  		device->ops->pasid_detach_ioas(device, detach.pasid);
>>  	else
>>diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
>>index f0ea37d98696..fb2141ee8942 100644
>>--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
>>+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
>>@@ -106,6 +106,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/file.h>
>>+#include <linux/iommufd.h>
>>  #include <linux/kexec_handover.h>
>>  #include <linux/kho/abi/vfio_pci.h>
>>  #include <linux/liveupdate.h>
>>@@ -114,6 +115,8 @@
>>  #include "vfio_pci_priv.h"
>>+MODULE_IMPORT_NS("IOMMUFD");
>>+
>>  static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
>>  					     struct file *file)
>>  {
>>@@ -154,15 +157,25 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	struct vfio_pci_core_device_ser *ser;
>>  	struct vfio_pci_core_device *vdev;
>>  	struct pci_dev *pdev;
>>-	int ret;
>>+	u64 iommufd_token;
>>+	int ret = 0;
>
>nit: no need to initialize ret.

I will fix this.
>
>>  	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>>  	pdev = vdev->pdev;
>>-	ret = pci_liveupdate_preserve(pdev);
>>+	mutex_lock(&device->dev_set->lock);
>>+	ret = iommufd_device_preserve(args->session,
>>+				      device->iommufd_device,
>>+				      &iommufd_token);
>>+	mutex_unlock(&device->dev_set->lock);
>>+
>>  	if (ret)
>>  		return ret;
>>+	ret = pci_liveupdate_preserve(pdev);
>>+	if (ret)
>>+		goto err_iommufd_unpreserve;
>>+
>>  	ser = kho_alloc_preserve(sizeof(*ser));
>>  	if (IS_ERR(ser)) {
>>  		ret = PTR_ERR(ser);
>>@@ -177,6 +190,12 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  err_unpreserve:
>>  	pci_liveupdate_unpreserve(pdev);
>>+
>>+err_iommufd_unpreserve:
>>+	mutex_lock(&device->dev_set->lock);
>>+	iommufd_device_unpreserve(args->session,
>>+				  device->iommufd_device);
>>+	mutex_unlock(&device->dev_set->lock);
>>  	return ret;
>>  }
>>@@ -184,6 +203,11 @@ static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>>  {
>>  	struct vfio_device *device = vfio_device_from_file(args->file);
>>+	mutex_lock(&device->dev_set->lock);
>>+	iommufd_device_unpreserve(args->session,
>>+				  device->iommufd_device);
>>+	mutex_unlock(&device->dev_set->lock);
>>+
>>  	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
>>  	kho_unpreserve_free(phys_to_virt(args->serialized_data));
>>  }
>
>Unpreservation isn't the exact reverse of preservation. Anything special
>here?

Nothing special. I will make it the exact reverse of preserve.

>
>Otherwise, this patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
