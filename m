Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B83672BB
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624802; cv=none; b=ssX+5yZxxQ95OmezUdHs1pX+ZsB21BNbxZFNX4v7fi7a1DDe1W6CSBysQtpQl4sswKfzb5Fw6C+qG8BKoAjUuLfzorEJ7ASn0n2PmRfH2heubhnfugaEtbwBcGOjUjWowTttGPnyN9MMEwJNGmmPG6vYI45gGsttYxUMEjopc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624802; c=relaxed/simple;
	bh=Ju91f7WHD/nsEzZojIDx2RzCC5dKzksus8nxqAwcjUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSLknRsMcBhE+I8QpqQAnP7Ifh4CdIJDbFdnyybHPBbdCQT75fuKtmOWtGJzY1w992CqqmJZdB+62OhM48SoS1rDBV4KrXM55Nn4iVh61tsvTUqJHxPPum3lvwaq6oc9MwOzRzdskzky6P5JRMF2ll2QzixeUIT/AGdHzW/ej7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/+47mOB; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/+47mOB"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-133362c30cfso24c88.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778624800; x=1779229600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qP7udJjtqmkmefw+9/F5MXBjelGnly7sw5/SZPr4Vl4=;
        b=J/+47mOBCg5BvTL5LMMSVWVjKntTxgpNOM+c/PhX8DpA2NETQhTAdcUfPbkw5hGfaA
         dkQ1LwnTusun8Njie+anW5mxgIyC9Rt3mU4xdvfzel3JoLYUnJGE3dXkJQAe5krPGe9G
         01L3W9MU9n3ZlbH+WkSEz3fjCldIv+TC6vlfBkLWYZ1Q7YxA56BFCCz5gLaVYQCTY7M1
         PIh9EW6z/lqWyorK1J2m7OfjtEil7ByJhAk45JPme6Bxd9N//pRolU8WScpSHowwyrag
         UCrQLcsPHYsDRVpeFhzmlzuo/CcN2G2pkx0WP7D4wtNf0PBGFWx/iev91u0w11wsaw4z
         MEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624800; x=1779229600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qP7udJjtqmkmefw+9/F5MXBjelGnly7sw5/SZPr4Vl4=;
        b=HEL9Ex3GJfFI1LFVUmA8wGvQKodIxT/q27pIdhY+mdZY8wNSCK8tq5jwcm46tOT5jV
         eYpQiAp6eQ3Vn3xe1+s+/3k/5hs57HSVUNmoOUKR4mu8ATkxy6yEN1zqkcxO3UDqn7cO
         bwKkiEYX+/wJ78f5FXmBffjQSyg71FkPYIpZ2JBNnimM1yO8QRWREIDo/ChVvTw40BTq
         Ew+4w0GjdcZU37KklECyTbqkhe9plZRMFYOjrGiSbfTo7Ok1nxb7iJwcr8vvrfojMVBb
         4v1Sk9gtGx3tluC05Wgn4qbJ4zknaMRTNdThnwPfMp1UpsAzMZx7cqy2W4ZAbD/9VEgk
         YkYw==
X-Forwarded-Encrypted: i=1; AFNElJ+Mz1oZia4LNPfOHc0Mp+/9r5oZ82/+dwvxhqsJXa9HWHM5a08z1X52YP82UMxq6eObJj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZZIBs5YRO3cjdrFcT6TKfl+EGnzFdhN14yjqr0e6+nsvQgsQ
	yCGe5hC+V2UyNVujnoJwDyR0gI4WnbnHZIFwOGruBLGmIgrlNt1s2uM5Uzd9nyZ3Nw==
X-Gm-Gg: Acq92OED2MKVLYDajEA5yY4dKmbcD7NoHzngaMLmSonkFX+pCP6WdzydcpQ4cc4/yiC
	Qa4USdbJQ+jrJtki/4avutv22QfOajN6GMYchBRodNrwIIF+bsVrgGgoNgx7G4fXq2xFNQygyf9
	P2BM3a3fF6FbqG+GFFG6+fdHkFlZPb804CtEX0BmhUMhjoMe0j5WhysQU1is9OugBkfRglOfRm4
	ZEg5IEEhIyCU8+TgVBQofRsBrJfJ3pwNrTVp3JeLHCqJaYk8r6dMC7Mas70PrVTMSgt8H8SWJdz
	uCv2kNRSaTyo/8HyDZhc8MFSwVq/BnZM4uNXVOseuXcb174EqyWvsnICrRyW6VClRux7mbv2cd3
	wzk7T3K5iqbbVrzFJr5mYHHZ19PQZuYSByq9wZNdCW1dkbtWIr5+RjaNEF9slL17l1xVd2Hg72M
	mIWa60bjVXw5hcxqW5bJWw0sDWARetE7UGGvcCHfp1ZyiOAKZmwaIljN3jU/ifMhtjbMC6g8fjK
	f2d11KF
X-Received: by 2002:a05:7022:1e10:b0:133:52da:cb5f with SMTP id a92af1059eb24-13489cafa5bmr42635c88.21.1778624799256;
        Tue, 12 May 2026 15:26:39 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1329fc4bf3fsm17363892c88.5.2026.05.12.15.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:26:38 -0700 (PDT)
Date: Tue, 12 May 2026 15:26:35 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/8] vfio: selftests: Introduce snprintf_assert()
Message-ID: <20260512222600.GB3046123.vipinsh@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
 <20260505212838.1698034-3-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505212838.1698034-3-rananta@google.com>

On Tue, May 05, 2026 at 09:28:32PM +0000, Raghavendra Rao Ananta wrote:
> Introduce snprintf_assert() to protect the users of snprintf() to fail
> if the requested operation was truncated due to buffer limits. VFIO
> tests and libraries, including a new sysfs library that will be introduced
> by an upcoming patch, rely quite heavily on snprintf()s to build PCI
> sysfs paths. Having a protection against this will be helpful to prevent
> false test failures.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: David Matlack <dmatlack@google.com>
> ---
>  .../vfio/lib/include/libvfio/assert.h         |  5 +++++
>  .../selftests/vfio/lib/vfio_pci_device.c      |  8 +++----
>  .../selftests/vfio/vfio_dma_mapping_test.c    |  6 +++---
>  .../selftests/vfio/vfio_pci_device_test.c     | 21 ++++++++++---------
>  4 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> index f4ebd122d9b6f..77b68c7129a64 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> @@ -51,4 +51,9 @@
>  	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
>  } while (0)
>  
> +#define snprintf_assert(_s, _size, _fmt, ...) do {                      \
> +	int __ret = snprintf(_s, _size, _fmt, ##__VA_ARGS__);           \
> +	VFIO_ASSERT_LT(__ret, _size);                                   \
> +} while (0)
> +
>  #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H */
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index fc75e04ef010c..efbf9ab63cea7 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -211,7 +211,7 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
>  	unsigned int group;
>  	int ret;
>  
> -	snprintf(sysfs_path, PATH_MAX, "%s/%s/iommu_group", PCI_SYSFS_PATH, bdf);
> +	snprintf_assert(sysfs_path, PATH_MAX, "%s/%s/iommu_group", PCI_SYSFS_PATH, bdf);
>  
>  	ret = readlink(sysfs_path, dev_iommu_group_path, sizeof(dev_iommu_group_path));
>  	VFIO_ASSERT_NE(ret, -1, "Failed to get the IOMMU group for device: %s\n", bdf);
> @@ -231,7 +231,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
>  	int group;
>  
>  	group = vfio_pci_get_group_from_dev(bdf);
> -	snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
> +	snprintf_assert(group_path, sizeof(group_path), "/dev/vfio/%d", group);
>  
>  	device->group_fd = open(group_path, O_RDWR);
>  	VFIO_ASSERT_GE(device->group_fd, 0, "open(%s) failed\n", group_path);
> @@ -302,7 +302,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
>  	cdev_path = calloc(PATH_MAX, 1);
>  	VFIO_ASSERT_NOT_NULL(cdev_path);
>  
> -	snprintf(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
> +	snprintf_assert(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
>  
>  	dir = opendir(dir_path);
>  	VFIO_ASSERT_NOT_NULL(dir, "Failed to open directory %s\n", dir_path);
> @@ -312,7 +312,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
>  		if (strncmp("vfio", entry->d_name, 4))
>  			continue;
>  
> -		snprintf(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
> +		snprintf_assert(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
>  		break;
>  	}
>  
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> index abb170bdcef7e..7d0de8c79de13 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> @@ -44,9 +44,9 @@ static int intel_iommu_mapping_get(const char *bdf, u64 iova,
>  	FILE *file;
>  	char *rest;
>  
> -	snprintf(iommu_mapping_path, sizeof(iommu_mapping_path),
> -		 "/sys/kernel/debug/iommu/intel/%s/domain_translation_struct",
> -		 bdf);
> +	snprintf_assert(iommu_mapping_path, sizeof(iommu_mapping_path),
> +			"/sys/kernel/debug/iommu/intel/%s/domain_translation_struct",
> +			bdf);
>  
>  	printf("Searching for IOVA 0x%lx in %s\n", iova, iommu_mapping_path);
>  
> diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> index 7c0fe8ce3a61f..93c11fd5e0818 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> @@ -39,16 +39,17 @@ FIXTURE_TEARDOWN(vfio_pci_device_test)
>  	iommu_cleanup(self->iommu);
>  }
>  
> -#define read_pci_id_from_sysfs(_file) ({							\
> -	char __sysfs_path[PATH_MAX];								\
> -	char __buf[32];										\
> -	int __fd;										\
> -												\
> -	snprintf(__sysfs_path, PATH_MAX, "/sys/bus/pci/devices/%s/%s", device_bdf, _file);	\
> -	ASSERT_GT((__fd = open(__sysfs_path, O_RDONLY)), 0);					\
> -	ASSERT_GT(read(__fd, __buf, ARRAY_SIZE(__buf)), 0);					\
> -	ASSERT_EQ(0, close(__fd));								\
> -	(u16)strtoul(__buf, NULL, 0);								\
> +#define read_pci_id_from_sysfs(_file) ({					\
> +	char __sysfs_path[PATH_MAX];						\
> +	char __buf[32];								\
> +	int __fd;								\
> +										\
> +	snprintf_assert(__sysfs_path, PATH_MAX, "/sys/bus/pci/devices/%s/%s",	\
> +			device_bdf, _file);					\
> +	ASSERT_GT((__fd = open(__sysfs_path, O_RDONLY)), 0);			\
> +	ASSERT_GT(read(__fd, __buf, ARRAY_SIZE(__buf)), 0);			\
> +	ASSERT_EQ(0, close(__fd));						\
> +	(u16)strtoul(__buf, NULL, 0);						\
>  })
>  
>  TEST_F(vfio_pci_device_test, config_space_read_write)
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
Reviewed-by: Vipin Sharma <vipinsh@google.com> 
