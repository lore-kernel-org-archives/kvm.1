Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE673358AD
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472744; cv=none; b=U7Ar72HxwTmeHRYLW2lPESrOsmnua62iHU0t5TomHNGoJVmizMqCvVV6DfboqZSVkRkKThM1+LHpyErjx2BZQ8M+ANnSzDfRGiR+3LJ9TSuQYYMAGjzWtVRTR6o7bKc9UdQjAoHIQkTuz7Bx7oCgy+zvSW1aC6lJDR4Rz9tA7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472744; c=relaxed/simple;
	bh=mc3wyFkLdTJ6vlC+vxFo8HArEjVsFIe6IYt/TgRs0ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/gd2BWTJROoufylu8UCRXLy/3gF61KMuh4E7Zi1DFYMLp1QsprXrZrCcAWffw6c1Wc8rHzoLoMRP3YqDyMHwK6jS8MhaJPIDO5SWvJ3Jwy7RbgnvxScLPWYuqIW757AnFhkTgtzqOmN7o/Wa5/RvNFi+pRTDF1h5rTBQ4cTNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rl7oAMvm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rl7oAMvm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so28775ad.0
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774472743; x=1775077543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ONKcbBIVZipE0oxJX2YmrslP0dc4AILtZ8R0cwg82s=;
        b=rl7oAMvmW+b8HUKqjmiilQLyjRDt0micOx30m3WuRKV9Ik2h4/WT8kZb6kLAcndo+p
         T9tMSOSlGiqPl2CQe3E1zWwiq8ZIS4Pv8SoqNseqCT5lxC9PeKe+LbQ/H37/BE54M03S
         bk4awc673zPdOmPQz1RhpstNwO+h1lB8H+T50y1ZWV0Y0iniRyhFY/tKVzvgutBzC0ZI
         rVIZdleAYgl1Llg6Zn9Dm0az9+rrYBf76bhHquxSWVb9hBAQiNOGqbSfKxLTyJRZNHfS
         VP6DrNqVl9LvELp0h9bWGikZXoUduZqNaRU1zZwvKYlTZvAOCr4QwBrGLcMwnxnzVvjn
         +qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774472743; x=1775077543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ONKcbBIVZipE0oxJX2YmrslP0dc4AILtZ8R0cwg82s=;
        b=lfKQ8lzsUgRbbh92IP+tSSLR2V2GxnYsl45mNPMe4s+7MI6SEYwArTJslSEgfHDgsy
         h4i/4J2oB5KfXwr8zkEhdN4baT4NUj4UhvdjsO18x/hhwZ6T1VO8UOJHKbOr4M9BHuCW
         9EcF6Pnhr+oAUPuPsLg8PXtNq5UoXXaZPAM7uBO/4o/j1t8W8Hute4StWyN889ovXZy/
         mVx7C5NhvV0kxv7dkScgMamuekinLN+KaXw+Bons8harb/VtkfGPsOf4zQv1OLT5WCp7
         Hhrszi3szuf+2cgtzepaDoJ0jfAwJzzivMNk8fuXQDRRRNPf52pou0sTYBXKzH0yVWXB
         jEsw==
X-Forwarded-Encrypted: i=1; AJvYcCWkAYXkJtzD4NN7yFAVHyV5GC7nvxc9bvR6aUan1w/pcpCboXv+FA3jHUvv7U18hC3W200=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWv1SNNl20N5oW8xUTKlYxEnD/4UDVRg1e2ZQVvHzmYnQ6fhRa
	b1rqyH4gsmwVc8oxss6QtztmDBpT1DPQqcang0KNGbLVhOGuEjCGGN745ImoR4M8wA==
X-Gm-Gg: ATEYQzyFADyevLf440ZYzQq15fvAPUvFCwxCVLeXH6EeL/D9H0bQlbkFFUxdbEyD5jH
	590t1QuYVVPBZnLJPL5D3ZlfhC6eEckYUz+668qMLr+G0+k/JdS195x0zxY4HDzA1H7EuoYCZOP
	t/j+n1NsxvkOItnNy8nqbEhFmNT/MxkyfAgQr/IuaA2t59JkyIN3EyHPpLrUhavJ0Vjb/57cL7k
	RkhHno88Ryp9T/YHWR9mz994fJHMSDzWxt/cMrNFUzonyLqObr/w4RTp/+qE/h3dl51ljXH+qXb
	XPb/WJSxUSRaVtf33Pb02U4RXu8h/0tusW3ytzTRiW38ALY96vNXqEXvt/cwUf9ilxa7Z3vV+JK
	UMxMe2ATkg1bcz1gVKFlE+jHe7Wxe6Ln9aPw9B92ZJGjvB6MFPrepi+t1LqwvaYyB+YCEbbU6qi
	+viySSDXyDMUDNbB75V+IHJnWXBwvsobYQBWB408AYcZrLnnfVvP6/x9QZOI2M+k48o83W
X-Received: by 2002:a17:902:d48d:b0:2b0:7a9b:82f3 with SMTP id d9443c01a7336-2b0bf525ef0mr164585ad.8.1774472741940;
        Wed, 25 Mar 2026 14:05:41 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc783099sm9870465ad.18.2026.03.25.14.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:05:41 -0700 (PDT)
Date: Wed, 25 Mar 2026 21:05:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add test to verify iommufd
 preservation
Message-ID: <acROHN5KhJIef0Yd@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-15-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-15-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:48PM +0000, Samiullah Khawaja wrote:
> Test iommufd preservation by setting up an iommufd and vfio cdev and
> preserve it across live update. Test takes VFIO cdev path of a device
> bound to vfio-pci driver and binds it to an iommufd being preserved. It
> also preserves the vfio cdev so the iommufd state associated with it is
> also preserved.
> 
> The restore path is tested by restoring the preserved vfio cdev only.
> Test tries to finish the session without restoring iommufd and confirms
> that it fails.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  tools/testing/selftests/iommu/Makefile        |  12 +
>  .../selftests/iommu/iommufd_liveupdate.c      | 209 ++++++++++++++++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c
> 
> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> index 84abeb2f0949..263195af4d6a 100644
> --- a/tools/testing/selftests/iommu/Makefile
> +++ b/tools/testing/selftests/iommu/Makefile
> @@ -7,4 +7,16 @@ TEST_GEN_PROGS :=
>  TEST_GEN_PROGS += iommufd
>  TEST_GEN_PROGS += iommufd_fail_nth
>  
> +TEST_GEN_PROGS_EXTENDED += iommufd_liveupdate
> +
>  include ../lib.mk
> +include ../liveupdate/lib/libliveupdate.mk
> +
> +CFLAGS += -I$(top_srcdir)/tools/include
> +CFLAGS += -MD
> +CFLAGS += $(EXTRA_CFLAGS)
> +
> +$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -static -o $@
> +
> +EXTRA_CLEAN += $(LIBLIVEUPDATE_O)
> diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
> new file mode 100644
> index 000000000000..8b4ea9f2b7e9
> --- /dev/null
> +++ b/tools/testing/selftests/iommu/iommufd_liveupdate.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#include <fcntl.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +
> +#define __EXPORTED_HEADERS__
> +#include <linux/iommufd.h>
> +#include <linux/types.h>
> +#include <linux/vfio.h>
> +#include <linux/sizes.h>
> +#include <libliveupdate.h>
> +
> +#include "../kselftest.h"
> +
> +#define ksft_assert(condition) \
> +	do { if (!(condition)) \
> +	ksft_exit_fail_msg("Failed: %s at %s %d: %s\n", \
> +	#condition, __FILE__, __LINE__, strerror(errno)); } while (0)
> +
> +int setup_cdev(const char *vfio_cdev_path)
> +{
> +	int cdev_fd;
> +
> +	cdev_fd = open(vfio_cdev_path, O_RDWR);
> +	if (cdev_fd < 0)
> +		ksft_exit_skip("Failed to open VFIO cdev: %s\n", vfio_cdev_path);
> +
> +	return cdev_fd;
> +}
> +
> +int open_iommufd(void)
> +{
> +	int iommufd;
> +
> +	iommufd = open("/dev/iommu", O_RDWR);
> +	if (iommufd < 0)
> +		ksft_exit_skip("Failed to open /dev/iommu. IOMMUFD support not enabled.\n");
> +
> +	return iommufd;
> +}
> +
> +int setup_iommufd(int iommufd, int memfd, int cdev_fd, int hwpt_token)
> +{
> +	int ret;
> +
> +	struct vfio_device_bind_iommufd bind = {
> +		.argsz = sizeof(bind),
> +		.flags = 0,
> +	};
> +	struct iommu_ioas_alloc alloc_data = {
> +		.size = sizeof(alloc_data),
> +		.flags = 0,
> +	};
> +	struct iommu_hwpt_alloc hwpt_alloc = {
> +		.size = sizeof(hwpt_alloc),
> +		.flags = 0,
> +	};
> +	struct vfio_device_attach_iommufd_pt attach_data = {
> +		.argsz = sizeof(attach_data),
> +		.flags = 0,
> +	};
> +	struct iommu_hwpt_lu_set_preserve set_preserve = {
> +		.size = sizeof(set_preserve),
> +		.hwpt_token = hwpt_token,
> +	};
> +	struct iommu_ioas_map_file map_file = {
> +		.size = sizeof(map_file),
> +		.length = SZ_1M,
> +		.flags = IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE,
> +		.iova = SZ_4G,
> +		.fd = memfd,
> +		.start = 0,
> +	};
> +
> +	bind.iommufd = iommufd;
> +	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
> +	ksft_assert(!ret);
> +
> +	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
> +	ksft_assert(!ret);
> +
> +	hwpt_alloc.dev_id = bind.out_devid;
> +	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
> +	ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
> +	ksft_assert(!ret);
> +
> +	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
> +	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> +	ksft_assert(!ret);
> +
> +	map_file.ioas_id = alloc_data.out_ioas_id;
> +	ret = ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
> +	ksft_assert(!ret);
> +
> +	set_preserve.hwpt_id = attach_data.pt_id;
> +	ret = ioctl(iommufd, IOMMU_HWPT_LU_SET_PRESERVE, &set_preserve);
> +	ksft_assert(!ret);
> +
> +	return ret;
> +}
> +
> +static int create_sealed_memfd(size_t size)
> +{
> +	int fd, ret;
> +
> +	fd = memfd_create("buffer", MFD_ALLOW_SEALING);
> +	ksft_assert(fd > 0);
> +
> +	ret = ftruncate(fd, size);
> +	ksft_assert(!ret);
> +
> +	ret = fcntl(fd, F_ADD_SEALS,
> +		    F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL);
> +	ksft_assert(!ret);
> +
> +	return fd;
> +}
> +
> +int main(int argc, char *argv[])

The iommufd selftest directory heavily utilizes the standard kselftest
harness (TEST_F, EXPECT_EQ, ASSERT_EQ), by writing a raw main(), this 
patch circumvents the standard test reporting structure (like returning 1
on argc < 2 instead of ksft_exit_skip(), and returning 0 at the end
instead of ksft_exit_pass() etc.). We should rewrite this cleanly 
following the existing iommufd test infrastructure using TEST_F blocks.

> +{
> +	int iommufd, cdev_fd, memfd, luo, session, ret;
> +	const int token = 0x123456;
> +	const int cdev_token = 0x654321;
> +	const int hwpt_token = 0x789012;
> +	const int memfd_token = 0x890123;

Shouldn't these be u64? Defining them as signed int-s undermines that
contract?

> +
> +	if (argc < 2) {
> +		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
> +		return 1;
> +	}
> +
> +	luo = luo_open_device();
> +	ksft_assert(luo > 0);
> +
> +	session = luo_retrieve_session(luo, "iommufd-test");

[ ---- >8 ---- ]

Thanks,
Praan
