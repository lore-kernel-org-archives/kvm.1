Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF662E7179
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635949; cv=none; b=GgBd7C/0KlNpG3eRlZCgpW31JJ9uDt69isZnJ2wZF8JAjV8D0R7f3tv+3p2VOMIfEQO617mFWYcedD0fXQ8U4akb89ioJiaMa0umjHebOO7l4emh3iKic97PFjQgjV291UcQW/IkP3aeqDWk4NSkjrXAexv5Iy9/KEqGdn7a+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635949; c=relaxed/simple;
	bh=RWVmFisaS6LiuDHXSgQqXsngdZmse320ywugve3sHxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUMSLgYPsgiClSA7U7Bv3IPiFDD4kyCOl5M1plDsalRrborMvFqqgKlWLcVrV19Z4uMZHxX6wAEtGAvQU5rmT3oBry49Po0Yz5rF7iNOQv+AQAnkj51saak8nIS7OA65sAuy4ogPrVjtARLketvc/YARnY7qNf3oyPuhQpYRNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=voeDBYa5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="voeDBYa5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0b260d309so9585ad.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774635942; x=1775240742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IAaImzyEb+9YvYUSNCoqJngO2GIkPdWgkxBmH6DOqY=;
        b=voeDBYa5usI5UfBMXw5BDMV64xqwv032gsN04Sp+3I8j80iY3yRjuT4mKbda1Zju9j
         j5TWrT5OeRAfNQ3hsnEIIuq9ymDZJ8VCofA0F9PurxqLWNyUdAor36wWgEIH2/1BPQ/j
         qizbabg6WmpBZoyOcZtOsCxi1taB5amlaBSec39xa0XgDF30tpBk/NOGRlVsRtfrPGYk
         AQTXzkVc4/x1U9taMGUuuPouF6MPPwJ7d92HUIJy4aQO7wplVd4R2SvPj1s4F5Ua450U
         Hs+4FifcjrYogf2cgnPljUhch6ZwpgqcqwLKMOCteeUR/Ntb+JrUZf9iR6Nzh40E6TAe
         e8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774635942; x=1775240742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IAaImzyEb+9YvYUSNCoqJngO2GIkPdWgkxBmH6DOqY=;
        b=q4knxlHF6idjrkOOJ3zuI5fz4yUs/CV2kpgtoOj3Ch55JNfDSR0Wa6pNZMdrFB4Arb
         KgOSSOEm5/A1vC/LKduh4X6+n3kLYLmPQfUA+hzMygg9XJeDrHljaDze6/Hv6khWl257
         7lZDMW/d+Mxag8p8EPFQFVCjHPVAfXluBrf+dwkjyoBOZiRaLq6wf9tw4eo5nq1C73AA
         hkDzDCg8xSmYTKxI0OLn5sDYhxaCExLObgwmqvSulm6yUcHr0DyAHHMqZv0/3FCtjlkj
         XsBaX3OVcGp3k+tZTKqA7bUfal/4bBNA40ZelHpW0pCN99+ZjVkPJMTrRVZm6Y0rOiE7
         kELQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUp7+MHu6mBvXCrelMpFUlf0yS0TBHXjmkRs4QoKBFSW27JnaOAHDYr3vH92Umfg6kd0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyCnqaZJqTZLd00XgZGzd2qeRCMzWGAMVLZDvFzGpVVO8mmuFY
	K1Q1REsmLEUP7uogC1DGKwah6xpi1lNMgJVSBf5OZ9YRgKxNNmqHkk7ThZTLp0vxQw==
X-Gm-Gg: ATEYQzz1G50iE1Iqik++WC8zw44ksq1kjvXEWzPF0XIG9T8emPcPCEQx0TiIsc+iHGy
	KT0AXyLCeVKoMGMKkYPPNQbj6YaCrL8/XKo0o13Jvob9VTNNQtxo0Ei1+LTkpEA2ad81Xqy9jRR
	6VDlAO/PKmfj1x//pquACIgxqmO5bpebQKo2f1enhSgrPuwjO3LNjfK9T/rH4Q2ipeeId08XpGm
	1SpRYkcQstienSvdh9CsyOtcghdqvhQc6aL3KlPc58juOHwd90JravCcVqtaB9cmwD4o2aPsdVI
	BdZo8HMvGUwAl88JD1hJw3gTiOiTV6o3EMYq2xg+EtQhqaFthfr4QAYyiSPCEc4eIy0O9c4RNuO
	p/JjMbxUFRRYhccSeLxiPJtxeJjetEL2HyIev3fUnmgPqCpYpGxfbVYdG3lG5Kyt0V/nhnVo3Tw
	7O6OYWeqCtDWdVac9XjoeOh3f18dDsLZjHk7XoEvPKcZxIUuzSnfJM05fqtKFfmsZqVwsVKua7
X-Received: by 2002:a17:903:2311:b0:2b0:5628:b975 with SMTP id d9443c01a7336-2b241e154ebmr320085ad.3.1774635941549;
        Fri, 27 Mar 2026 11:25:41 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76737f1e75sm5303243a12.3.2026.03.27.11.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:25:40 -0700 (PDT)
Date: Fri, 27 Mar 2026 18:25:36 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add test to verify iommufd
 preservation
Message-ID: <acbLdqSEjDNc5kWy@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-15-skhawaja@google.com>
 <acROHN5KhJIef0Yd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acROHN5KhJIef0Yd@google.com>

On Wed, Mar 25, 2026 at 09:05:32PM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:48PM +0000, Samiullah Khawaja wrote:
>> Test iommufd preservation by setting up an iommufd and vfio cdev and
>> preserve it across live update. Test takes VFIO cdev path of a device
>> bound to vfio-pci driver and binds it to an iommufd being preserved. It
>> also preserves the vfio cdev so the iommufd state associated with it is
>> also preserved.
>>
>> The restore path is tested by restoring the preserved vfio cdev only.
>> Test tries to finish the session without restoring iommufd and confirms
>> that it fails.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> ---
>>  tools/testing/selftests/iommu/Makefile        |  12 +
>>  .../selftests/iommu/iommufd_liveupdate.c      | 209 ++++++++++++++++++
>>  2 files changed, 221 insertions(+)
>>  create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c
>>
>> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
>> index 84abeb2f0949..263195af4d6a 100644
>> --- a/tools/testing/selftests/iommu/Makefile
>> +++ b/tools/testing/selftests/iommu/Makefile
>> @@ -7,4 +7,16 @@ TEST_GEN_PROGS :=
>>  TEST_GEN_PROGS += iommufd
>>  TEST_GEN_PROGS += iommufd_fail_nth
>>
>> +TEST_GEN_PROGS_EXTENDED += iommufd_liveupdate
>> +
>>  include ../lib.mk
>> +include ../liveupdate/lib/libliveupdate.mk
>> +
>> +CFLAGS += -I$(top_srcdir)/tools/include
>> +CFLAGS += -MD
>> +CFLAGS += $(EXTRA_CFLAGS)
>> +
>> +$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
>> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -static -o $@
>> +
>> +EXTRA_CLEAN += $(LIBLIVEUPDATE_O)
>> diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
>> new file mode 100644
>> index 000000000000..8b4ea9f2b7e9
>> --- /dev/null
>> +++ b/tools/testing/selftests/iommu/iommufd_liveupdate.c
>> @@ -0,0 +1,209 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (c) 2025, Google LLC.
>> + * Samiullah Khawaja <skhawaja@google.com>
>> + */
>> +
>> +#include <fcntl.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/mman.h>
>> +#include <stdbool.h>
>> +#include <unistd.h>
>> +
>> +#define __EXPORTED_HEADERS__
>> +#include <linux/iommufd.h>
>> +#include <linux/types.h>
>> +#include <linux/vfio.h>
>> +#include <linux/sizes.h>
>> +#include <libliveupdate.h>
>> +
>> +#include "../kselftest.h"
>> +
>> +#define ksft_assert(condition) \
>> +	do { if (!(condition)) \
>> +	ksft_exit_fail_msg("Failed: %s at %s %d: %s\n", \
>> +	#condition, __FILE__, __LINE__, strerror(errno)); } while (0)
>> +
>> +int setup_cdev(const char *vfio_cdev_path)
>> +{
>> +	int cdev_fd;
>> +
>> +	cdev_fd = open(vfio_cdev_path, O_RDWR);
>> +	if (cdev_fd < 0)
>> +		ksft_exit_skip("Failed to open VFIO cdev: %s\n", vfio_cdev_path);
>> +
>> +	return cdev_fd;
>> +}
>> +
>> +int open_iommufd(void)
>> +{
>> +	int iommufd;
>> +
>> +	iommufd = open("/dev/iommu", O_RDWR);
>> +	if (iommufd < 0)
>> +		ksft_exit_skip("Failed to open /dev/iommu. IOMMUFD support not enabled.\n");
>> +
>> +	return iommufd;
>> +}
>> +
>> +int setup_iommufd(int iommufd, int memfd, int cdev_fd, int hwpt_token)
>> +{
>> +	int ret;
>> +
>> +	struct vfio_device_bind_iommufd bind = {
>> +		.argsz = sizeof(bind),
>> +		.flags = 0,
>> +	};
>> +	struct iommu_ioas_alloc alloc_data = {
>> +		.size = sizeof(alloc_data),
>> +		.flags = 0,
>> +	};
>> +	struct iommu_hwpt_alloc hwpt_alloc = {
>> +		.size = sizeof(hwpt_alloc),
>> +		.flags = 0,
>> +	};
>> +	struct vfio_device_attach_iommufd_pt attach_data = {
>> +		.argsz = sizeof(attach_data),
>> +		.flags = 0,
>> +	};
>> +	struct iommu_hwpt_lu_set_preserve set_preserve = {
>> +		.size = sizeof(set_preserve),
>> +		.hwpt_token = hwpt_token,
>> +	};
>> +	struct iommu_ioas_map_file map_file = {
>> +		.size = sizeof(map_file),
>> +		.length = SZ_1M,
>> +		.flags = IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE,
>> +		.iova = SZ_4G,
>> +		.fd = memfd,
>> +		.start = 0,
>> +	};
>> +
>> +	bind.iommufd = iommufd;
>> +	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
>> +	ksft_assert(!ret);
>> +
>> +	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
>> +	ksft_assert(!ret);
>> +
>> +	hwpt_alloc.dev_id = bind.out_devid;
>> +	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
>> +	ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
>> +	ksft_assert(!ret);
>> +
>> +	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
>> +	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
>> +	ksft_assert(!ret);
>> +
>> +	map_file.ioas_id = alloc_data.out_ioas_id;
>> +	ret = ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
>> +	ksft_assert(!ret);
>> +
>> +	set_preserve.hwpt_id = attach_data.pt_id;
>> +	ret = ioctl(iommufd, IOMMU_HWPT_LU_SET_PRESERVE, &set_preserve);
>> +	ksft_assert(!ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int create_sealed_memfd(size_t size)
>> +{
>> +	int fd, ret;
>> +
>> +	fd = memfd_create("buffer", MFD_ALLOW_SEALING);
>> +	ksft_assert(fd > 0);
>> +
>> +	ret = ftruncate(fd, size);
>> +	ksft_assert(!ret);
>> +
>> +	ret = fcntl(fd, F_ADD_SEALS,
>> +		    F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL);
>> +	ksft_assert(!ret);
>> +
>> +	return fd;
>> +}
>> +
>> +int main(int argc, char *argv[])
>
>The iommufd selftest directory heavily utilizes the standard kselftest
>harness (TEST_F, EXPECT_EQ, ASSERT_EQ), by writing a raw main(), this
>patch circumvents the standard test reporting structure (like returning 1
>on argc < 2 instead of ksft_exit_skip(), and returning 0 at the end
>instead of ksft_exit_pass() etc.). We should rewrite this cleanly
>following the existing iommufd test infrastructure using TEST_F blocks.

Agreed. Will do.
>
>> +{
>> +	int iommufd, cdev_fd, memfd, luo, session, ret;
>> +	const int token = 0x123456;
>> +	const int cdev_token = 0x654321;
>> +	const int hwpt_token = 0x789012;
>> +	const int memfd_token = 0x890123;
>
>Shouldn't these be u64? Defining them as signed int-s undermines that
>contract?

Agreed. Will update.
>
>> +
>> +	if (argc < 2) {
>> +		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
>> +		return 1;
>> +	}
>> +
>> +	luo = luo_open_device();
>> +	ksft_assert(luo > 0);
>> +
>> +	session = luo_retrieve_session(luo, "iommufd-test");
>
>[ ---- >8 ---- ]
>
>Thanks,
>Praan

Thanks,
Sami
