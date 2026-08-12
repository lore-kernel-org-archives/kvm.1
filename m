Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DD40EB80
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572696; cv=none; b=hWfyq4YTW87T6Xub2ARZ2JJSx9e2XUXPWf1oPgQhfYJy/UuRxMzL6j28V33kneirLcdOi7IAmzexVN5rToHDgUjBwi8zad74DP4ePPpjVVYebnociqDpDnWnkU3YAO8BUbpqRR4/41dPu+q45x6RBJmhkdhaai1twxHehSjSy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572696; c=relaxed/simple;
	bh=W/W3zvPMNBs7G76j3kOF1p094KPwTL9rIaA3xKhxAak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2w/oMhAPd9GaaC97h/KEUokP1Se0A2otBtD/F6aH0YoNfFMmkzPUEaQBzmdYAd5mR67DbS0ydijpV3Tyok0y1LljoMmz2ubVQNigo7bornvFkBrs/7iQQRfGetY36BSwpwlrv/HxuFGwIDcXf8GxS5nPaPB54Pj4ffrKNxkR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1audKXP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1audKXP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso107139a12.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786572694; x=1787177494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=84UXfrTD07ipm4YJ6onVJzQAj8OjhirewXBuPuaWHiM=;
        b=b1audKXPkNEsbprP/21dt8eCxWRxsYxa/GOozXuN5qGs32HUmVAgah8nnSlQiA9qt4
         yemXEBo77/c9hmwW4V2CajXk8Vb3S6oF2DaLb3dluWA54Upnz7x/okW/fG5kSLn7tDrH
         waGV7QElPGtLnMahXnqgsB8s23KGB7cK3MWrFol+p4ofEAPxjBC34xpCgPslOisc+jTP
         nZEUIc+wZpuZoaVddHf3mJVlxf/vUPWLp8TWzub2px7FuZyhgI8GCTTdJhcFg7aesNV6
         kUrqvuIqYe7gHs0dz6G81gU3E+7P3Eg/+GzQ5mn0QXxEp1tYc1U1A6arKPXsv+tgfATt
         PqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786572694; x=1787177494;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=84UXfrTD07ipm4YJ6onVJzQAj8OjhirewXBuPuaWHiM=;
        b=DF8mqj39613vu7KC5EnHLIpRIOoi6FN7kr/KwahTZ6ovOa9tS62mvBBbRLqChr9gOU
         amAX4HIdSMbRpZxyG0MPL2gZYIoYqEK8IvvmIdWnK/20BASCPPtN8ZBvVMMbEMfSItww
         4xZRY4mKLYUBAdEYR004i0ZH9U6IjyCTVRhVSVTd7GqeMwRQneW8/0HR3E/txo9L0ihX
         f0Cf+vHDD79/4W7yGC1OBU83Ir7N+/I5FZHiRl+hDshcoRkySPnvW4W3AMprrrwT4l44
         zCqEwD+6W3WYshpqzDDJrD3Fvp095u227c4KDVS318ROJNRP2TxveimFlirDMrCht2ir
         6f0w==
X-Forwarded-Encrypted: i=1; AHgh+RqWneTvoe8wJL4QmB8WoqKkkAu7gx7Kn+Yi/RDWGg3SQOgWGTiM1678xBTGVmWv+R8DX0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZcFAon2KaegZ9rqg+LVcwH3hfnqItWQUGI2sD6Yl/bgCgY8v
	lIq8KYdUtAG+qw2eoUhsPj5O4YX/8+GTlqZkjIQozp8wnFIUlmC4ZW9qgFPElTF53g==
X-Gm-Gg: AR+sD10A/G3OBiGh5kjd2KtmluNu7HVcX1/HSOEBG3MrVwG2ltMPt81Um6TtuU6GjBM
	8tYHaqW8t0leQ9eBHOiEHGoCEEPXUJ4AyKJy/1js5wLOGzgye2kVar8A9vgRRnP3dxuKWeLlcth
	d6Ng2hjRekf6u4FaT0KIs7fPQ5ssdJLev1KQuXsw8HPBwkLwGfdneVbNJtk7I7c2h4stGPjrtyl
	t/yNroQlzFbvs7wXVeZyA6DwndkdFpcLeizW4ownGaHpoOoqG94GBM7ea/PXgVqy/Lj/EVu21nU
	VagoURV45OVukXCApeUU817nwKcoKWLOhW8NfVM3xyixA0Ul1mlnW7WdiNHv5ZTsharkszq9wHa
	aTm7iwNv+GeT7HMr25asd8ypJqGNFpJHK2wXJDl//xVEIOCpPPG6LqoKm1woF0BIEUd99AHXjjM
	X1i0+jDMJPcB6exK7XclVkcaE8883UJEYenO9zsb34xV+OdDUCjNMt53rah1ap1Pw/oDSsBIr4S
	uuZMT9UeMtT2GC9KxPYkpgVFVZZDw==
X-Received: by 2002:a05:6a00:3923:b0:835:6388:655d with SMTP id d2e1a72fcca58-84fc6ce7c17mr1032589b3a.14.1786572693710;
        Wed, 12 Aug 2026 15:11:33 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbef7109658sm202295a12.16.2026.08.12.15.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:11:33 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:11:30 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 06/10] vfio: selftests: Allow drivers to specify
 required region size
Message-ID: <anzvkibgzTae9eV9@google.com>
References: <0-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
 <6-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>

On 2026-08-12 11:59 AM, Jason Gunthorpe wrote:
> Add a region_size field to struct vfio_pci_driver_ops so drivers can
> declare how much DMA-mapped region they need. The mlx5 driver will need
> ~18MB for firmware pages. Existing drivers pass in the sizeof their state
> struct. Since drivers all use only their declared state we can use the
> value directly and remove the SZ_2M hard coding.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

...

> diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/testing/selftests/vfio/lib/iova_allocator.c
> index 4a660f636f4972..c8075575e9131d 100644
> --- a/tools/testing/selftests/vfio/lib/iova_allocator.c
> +++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
> @@ -13,8 +13,10 @@
>  
>  #include <linux/iommufd.h>
>  #include <linux/limits.h>
> +#include <linux/log2.h>
>  #include <linux/mman.h>
>  #include <linux/overflow.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <linux/vfio.h>
>  
> @@ -50,7 +52,8 @@ void iova_allocator_cleanup(struct iova_allocator *allocator)
>  iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
>  {
>  	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> -	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
> +	/* Adjust the size to the allocator requirements */
> +	size = max_t(u64, roundup_pow_of_two(size), getpagesize());

...

> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> index 5e65434d2318b2..52b9c2a2bbb9b6 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> @@ -32,6 +32,9 @@ void vfio_pci_driver_probe(struct vfio_pci_device *device)
>  			continue;
>  
>  		device->driver.ops = ops;
> +
> +		VFIO_ASSERT_NE(ops->region_size, 0);
> +		device->driver.region.size = ops->region_size;

I'm seeing failures with the IGB driver with this series. I think it's
coming from here. The region size needs to be page-aligned so that the
IOMMU map/unmap calls can work?

The size of struct igb is 0x20080 bytes which is not page-aligned. The
size of struct mlx5st_device is 0x200D000, which is page-aligned, so
that's probably why your Claude did not notice.

# #  RUN           vfio_pci_driver_test.iommufd.send_msi ...
# /usr/local/google/home/dmatlack/kernel/trees/review/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h:42:
# Assertion Failure
#
#   Expression: __iommu_map(iommu, region) == 0
#   Observed: 0xffffffffffffffea == 0
#   [errno: 22 - Invalid argument]
#
# # send_msi: Test failed
# #          FAIL  vfio_pci_driver_test.iommufd.send_msi
# not ok 33 vfio_pci_driver_test.iommufd.send_msi

Applying this on top fixes things and also avoids a potential overflow
when doing the roundup_pow_of_two() in the allocator.

diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/testing/selftests/vfio/lib/iova_allocator.c
index c8075575e913..66a160d4ff9d 100644
--- a/tools/testing/selftests/vfio/lib/iova_allocator.c
+++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
@@ -52,8 +52,11 @@ void iova_allocator_cleanup(struct iova_allocator *allocator)
 iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
 {
 	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
-	/* Adjust the size to the allocator requirements */
-	size = max_t(u64, roundup_pow_of_two(size), getpagesize());
+	VFIO_ASSERT_LT(size, rounddown_pow_of_two(SIZE_MAX),
+		       "Invalid size arg, too large (%lu)\n", size);
+
+	size = roundup_pow_of_two(size);

 	for (;;) {
 		struct iommu_iova_range *range;
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index 96a940ea59b5..b31abfe2c7ff 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -36,7 +36,8 @@ void vfio_pci_driver_probe(struct vfio_pci_device *device)
 		device->driver.ops = ops;

 		VFIO_ASSERT_NE(ops->region_size, 0);
-		device->driver.region.size = ops->region_size;
+		device->driver.region.size =
+			round_up(ops->region_size, getpagesize());
 	}
 }
