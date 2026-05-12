Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77F39F172
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624921; cv=none; b=NV7q0CdJn5VLL8RsOCZ9gigFw6IwQNia4591EjykCTbXQTrpekR+5IemaGfm1/y3vnHvqMKC6Ao/cTm3engSJsfZtt3lSLuWpZqEuDt/ReBjjZRMbR24bHRRdKoI5avGhVtCB+/KaUJz/bNTljZ+x3O/uGQeJKPLXcolyd2DlIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624921; c=relaxed/simple;
	bh=DIT1f18jMzI6XET/qotoDfh+G7tDnhiyBaRxacdZKp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwiyfaIxKZCeYtTTNHogQc9xPsBXP1AJnDNc93SaIvmWhByoXr5fNB3Gw9JHykCcQlQQBvgfbv8zgUTzb7zU5ilcjdtcQaC3v5ilhXH0JkA8Ud9sNrIWPooMTGKbqvkHDNP5KcVpiQpabX//bvaPlmy5nHRq/SP0JPn8ROOk9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfPUqm2I; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfPUqm2I"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c8d0945b3so45c88.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778624919; x=1779229719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrfNow/Uk56mFckDFYyg6V8kaVY7pRviC5/mKVc1168=;
        b=XfPUqm2ITX/N560TqM5qtD18CMAfLgvYhtJh2QjNyVGMCzSTU7sU+NmVU7lIaoY1NW
         VA5aTHXY7LjGNbMUeroAMsJl/SiJUNOiuCXJfp/Du/AldjeUL+smJmnJJW5vVJZEyXtR
         59lJmo1kKvUUgqsVguEboOSTkmFeEyWHRiXAGmNPdtPeJqsQ6suWIvqXWPI6dKMLgsEw
         IGcEOAlPaAoTASTEO3jjteTbtV2DNikOKaxvA0qL+A079whrwx1JdNBi4qvA5XHoSul0
         5HBbvn3O/zf84iqZRQ2VhkoB9+uXYgL0K6cxT/oQhJwnT8EB4G8tn5nD7oK2mWLMlWQY
         vNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624919; x=1779229719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrfNow/Uk56mFckDFYyg6V8kaVY7pRviC5/mKVc1168=;
        b=ekj5t+XxebNxrwnYqTP/800sovaTjxaJjnxzeDQj4ArOS4YakAFq2eT6xk99ntezxz
         6qaZkm76799dFoy4oE9/tQRTGKWth5X3pc9flLfp0BBjv8hIWFGsfg9G/eQFl3GSr72r
         paw9G2riAtAP/C3VRpXXB96kRXGXB+IMCRtp7Tkq3f3JOx/VZLXfJCCx9m5t4VIGzHIg
         qxtFh7ki8n9FGhfbHf7XHJjS8+mLwjb0T121akn4J9Eb3C86NZRKar57AiN69PhCexhu
         JW22EsoWt0WnnALn3EVXVulI0Woac2qyVDiH+OaZS78yClbVE4nn38NstCIPcuhU253w
         o7Kw==
X-Forwarded-Encrypted: i=1; AFNElJ+tIFk7IOUgpogYr65DD/+pPIaJGPFkve9IWZ30DAc3ebED/h1AKYIykWxS/bFnCq43CuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdGqbK9N9gEJt+6QWLAiNm3eKoxjXgewmaDNlYywBGktFBTKF
	/MvhNkyBEz4c6bOh8rNV7c3l3li58pv2kVF00M2DmZ2u0ySkawrGG+VZx1+vFbq96g==
X-Gm-Gg: Acq92OEVUsIM6T9vPe/Y2Jpj72k/wM952CBvGayYO0vH0fLhDj1Ke1u/CwHvOPiuxCm
	mVmEIWFki/SNy4mVthBKIxWjq5YHJRG1EV8aqi5IkcA3NlyiLF8fAZrORHSl1rZFxDpDNS12vl1
	UIEvtmsT5fGdfCciSQy2XLcBb7/sfF9PhHbpqqxjw//qVQkC7O/yc9lHBqFS66etQKm2B6enYJs
	UT+DsRkhFPKQca/gyLQ5q+Pl98FgePykygmPk4iSF+Vhaoy5k1oZlJeS1IhbIgqz0yCSshf29Qn
	bPuBAxV1ANBT0qV7QIxJX1pqLwXllv8iyHuIlOiwSagJrn1pxCbLUANGK3wzhLOVfvH3IXHVtag
	TfNlrF4dXOavzwYjP6UjSbeIb9hQKPBPENVqMV8z42qRS7c7awnyidZnqVCKZ3W/TQqA6QpEmix
	ox3kN3L3C5n9+34sjkVaRwcJGn9uNO3OaG4Lz+gaQNFAw5jpyzKmyAFLW6L0aXrQECuU8X+A==
X-Received: by 2002:a05:7022:f9e:b0:133:12f0:c144 with SMTP id a92af1059eb24-133fb2d63d2mr131045c88.0.1778624918570;
        Tue, 12 May 2026 15:28:38 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f885edb83fsm19472286eec.7.2026.05.12.15.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:28:37 -0700 (PDT)
Date: Tue, 12 May 2026 15:28:33 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/8] vfio: selftests: Introduce a sysfs lib
Message-ID: <20260512222817.GC3046123.vipinsh@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
 <20260505212838.1698034-4-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505212838.1698034-4-rananta@google.com>

On Tue, May 05, 2026 at 09:28:33PM +0000, Raghavendra Rao Ananta wrote:
> Introduce a sysfs library to handle the common reads/writes to the
> PCI sysfs files, for example, getting the total number of VFs supported
> by the device via /sys/bus/pci/devices/$BDF/sriov_totalvfs. The library
> will be used in the upcoming test patch to configure the VFs for a given
> PF device.
> 
> Since readlink() is quite commonly used in the lib, introduce and use
> readlink_safe() to take care of potential buffer overrun errors and to
> safely terminate the buffer with '\0'.
> 
> Opportunistically, move vfio_pci_get_group_from_dev() to this library as
> it falls under the same bucket. Rename it to sysfs_iommu_group_get() to
> align with other function names.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/vfio/lib/include/libvfio.h      |   1 +
>  .../vfio/lib/include/libvfio/sysfs.h          |  12 ++
>  tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
>  tools/testing/selftests/vfio/lib/sysfs.c      | 150 ++++++++++++++++++
>  .../selftests/vfio/lib/vfio_pci_device.c      |  22 +--
>  5 files changed, 165 insertions(+), 21 deletions(-)
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
>  create mode 100644 tools/testing/selftests/vfio/lib/sysfs.c
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
> index 1b6da54cc2cb7..07862b470777b 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
> @@ -5,6 +5,7 @@
>  #include <libvfio/assert.h>
>  #include <libvfio/iommu.h>
>  #include <libvfio/iova_allocator.h>
> +#include <libvfio/sysfs.h>
>  #include <libvfio/vfio_pci_device.h>
>  #include <libvfio/vfio_pci_driver.h>
>  
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
> new file mode 100644
> index 0000000000000..c9ab1ea8f5a9c
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H
> +#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H
> +
> +int sysfs_sriov_totalvfs_get(const char *bdf);
> +int sysfs_sriov_numvfs_get(const char *bdf);
> +void sysfs_sriov_numvfs_set(const char *bdf, int numvfs);
> +char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i);
> +int sysfs_iommu_group_get(const char *bdf);
> +char *sysfs_driver_get(const char *bdf);
> +
> +#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H */
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index 9f47bceed16f4..b7857319c3f1f 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -6,6 +6,7 @@ LIBVFIO_SRCDIR := $(selfdir)/vfio/lib
>  LIBVFIO_C := iommu.c
>  LIBVFIO_C += iova_allocator.c
>  LIBVFIO_C += libvfio.c
> +LIBVFIO_C += sysfs.c
>  LIBVFIO_C += vfio_pci_device.c
>  LIBVFIO_C += vfio_pci_driver.c
>  
> diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
> new file mode 100644
> index 0000000000000..11415448b2e29
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/sysfs.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/limits.h>
> +
> +#include <libvfio.h>
> +
> +#define readlink_safe(_path, _buf) ({					\
> +	int __ret;							\
> +									\
> +	_Static_assert(!__builtin_types_compatible_p(			\
> +		__typeof__(_buf), char *),				\
> +	    "readlink_safe: _buf must be an array, not a pointer");	\
> +									\
> +	__ret = readlink(_path, _buf, sizeof(_buf) - 1);		\
> +	if (__ret != -1)						\
> +		_buf[__ret] = 0;					\
> +	__ret;								\
> +})
> +
> +static void readlink_base(const char *path, const char *data_fmt, void *out_data)
> +{
> +	char rl_path[PATH_MAX];
> +	int ret;
> +
> +	ret = readlink_safe(path, rl_path);
> +	VFIO_ASSERT_NE(ret, -1);
> +
> +	ret = sscanf(basename(rl_path), data_fmt, out_data);
> +	VFIO_ASSERT_EQ(ret, 1);
> +}
> +
> +static int sysfs_val_get_int(const char *component, const char *name,
> +			     const char *file)
> +{
> +	char path[PATH_MAX];
> +	char buf[32];
> +	int ret;
> +	int fd;
> +
> +	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/%s/%s/%s", component, name, file);
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return fd;
> +
> +	VFIO_ASSERT_GT(read(fd, buf, ARRAY_SIZE(buf)), 0);
> +	VFIO_ASSERT_EQ(close(fd), 0);
> +
> +	errno = 0;
> +	ret = strtol(buf, NULL, 0);
> +	VFIO_ASSERT_EQ(errno, 0, "sysfs path \"%s\" is not an integer: \"%s\"\n", path, buf);
> +
> +	return ret;
> +}
> +
> +static void sysfs_val_set(const char *component, const char *name,
> +			  const char *file, const char *val)
> +{
> +	char path[PATH_MAX];
> +	int fd;
> +
> +	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/%s/%s/%s", component, name, file);
> +	VFIO_ASSERT_GT(fd = open(path, O_WRONLY), 0);
> +
> +	VFIO_ASSERT_EQ(write(fd, val, strlen(val)), strlen(val));
> +	VFIO_ASSERT_EQ(close(fd), 0);
> +}
> +
> +static int sysfs_device_val_get(const char *bdf, const char *file)
> +{
> +	return sysfs_val_get_int("devices", bdf, file);
> +}
> +
> +static void sysfs_device_val_set(const char *bdf, const char *file, const char *val)
> +{
> +	sysfs_val_set("devices", bdf, file, val);
> +}
> +
> +static void sysfs_device_val_set_int(const char *bdf, const char *file, int val)
> +{
> +	char val_str[32];
> +
> +	snprintf_assert(val_str, sizeof(val_str), "%d", val);
> +	sysfs_device_val_set(bdf, file, val_str);
> +}
> +
> +int sysfs_sriov_totalvfs_get(const char *bdf)
> +{
> +	return sysfs_device_val_get(bdf, "sriov_totalvfs");
> +}
> +
> +int sysfs_sriov_numvfs_get(const char *bdf)
> +{
> +	return sysfs_device_val_get(bdf, "sriov_numvfs");
> +}
> +
> +void sysfs_sriov_numvfs_set(const char *bdf, int numvfs)
> +{
> +	sysfs_device_val_set_int(bdf, "sriov_numvfs", numvfs);
> +}
> +
> +char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i)
> +{
> +	char path[PATH_MAX];
> +	char *out_vf_bdf;
> +
> +	/* Fit "0000:00:00.0" */
> +	out_vf_bdf = calloc(16, sizeof(char));
> +	VFIO_ASSERT_NOT_NULL(out_vf_bdf);
> +
> +	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/virtfn%d", pf_bdf, i);
> +	readlink_base(path, "%s", out_vf_bdf);
> +
> +	return out_vf_bdf;
> +}
> +
> +int sysfs_iommu_group_get(const char *bdf)
> +{
> +	char path[PATH_MAX];
> +	int group;
> +
> +	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/iommu_group", bdf);
> +	readlink_base(path, "%d", &group);
> +
> +	return group;
> +}
> +
> +char *sysfs_driver_get(const char *bdf)
> +{
> +	char driver_path[PATH_MAX];
> +	char path[PATH_MAX];
> +	char *out_driver;
> +	int ret;
> +
> +	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/driver", bdf);
> +	ret = readlink_safe(path, driver_path);
> +	if (ret == -1) {
> +		if (errno == ENOENT)
> +			return NULL;
> +
> +		VFIO_FAIL("Failed to read %s\n", path);
> +	}
> +
> +	out_driver = strdup(basename(driver_path));
> +	VFIO_ASSERT_NOT_NULL(out_driver);
> +
> +	return out_driver;
> +}
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index efbf9ab63cea7..80e8e5bebd7ca 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -25,8 +25,6 @@
>  #include "kselftest.h"
>  #include <libvfio.h>
>  
> -#define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
> -
>  static void vfio_pci_irq_set(struct vfio_pci_device *device,
>  			     u32 index, u32 vector, u32 count, int *fds)
>  {
> @@ -204,24 +202,6 @@ void vfio_pci_device_reset(struct vfio_pci_device *device)
>  	ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
>  }
>  
> -static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
> -{
> -	char dev_iommu_group_path[PATH_MAX] = {0};
> -	char sysfs_path[PATH_MAX] = {0};
> -	unsigned int group;
> -	int ret;
> -
> -	snprintf_assert(sysfs_path, PATH_MAX, "%s/%s/iommu_group", PCI_SYSFS_PATH, bdf);
> -
> -	ret = readlink(sysfs_path, dev_iommu_group_path, sizeof(dev_iommu_group_path));
> -	VFIO_ASSERT_NE(ret, -1, "Failed to get the IOMMU group for device: %s\n", bdf);
> -
> -	ret = sscanf(basename(dev_iommu_group_path), "%u", &group);
> -	VFIO_ASSERT_EQ(ret, 1, "Failed to get the IOMMU group for device: %s\n", bdf);
> -
> -	return group;
> -}
> -
>  static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
>  {
>  	struct vfio_group_status group_status = {
> @@ -230,7 +210,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
>  	char group_path[32];
>  	int group;
>  
> -	group = vfio_pci_get_group_from_dev(bdf);
> +	group = sysfs_iommu_group_get(bdf);
>  	snprintf_assert(group_path, sizeof(group_path), "/dev/vfio/%d", group);
>  
>  	device->group_fd = open(group_path, O_RDWR);
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
Reviewed-by: Vipin Sharma <vipinsh@google.com> 

