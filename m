Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECED3B0AFB
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625086; cv=none; b=s2iaLmt0UwWSoblcem8852ixKWDabHY92ahrUxdwt4C22/2pESRWh0r7whQrhbYC8crcd9RnQbjoK8Tc5MWBNDUGoLSNLgnuV6Gc3izyPmUSMT0qlPF2i8FLlV7ILLjQzT9Q969S+plY7sRcmEgyPfVAa2yQTusjZzsHCv86jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625086; c=relaxed/simple;
	bh=bfDSfyqgEvLspJbDjT4dhmrURUIe2neskGE4m8erw/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZIZVq9k6U24vcSTGWDlUSE9n08YtNSbbqLFjgPGZ+SQg3+fioBqbBe7W4Pij2vEt/XvMBSWGA5JDgX+WTJvHQy76T4VN8LfqmgJobvHrJZysjVJFTJwLF3Mv6G16pPos3wjNOHP1NwoDoPcr6glnQ8mxe9ntl7d2jjF/tRXIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nuptocnc; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nuptocnc"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-133362c30cfso20c88.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625084; x=1779229884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvvtwopQ36OBRmWU0ucgY1/gXw3CS1LfZrtN+jxXHYE=;
        b=NuptocncuJp42MgpwD4fsSM4YutJvINIVXKfYE2aTLm5/Rh603t4LJxqjhM8aFqwlW
         TjvvvKNP3x/P8i8hdi5U58sYkh8MTNaG3W3VSRRFRA7zCdU8/3AnhUCDa4b1+gBROsL0
         jVJa899NFfLnQ4gTwt41vcszNPOB2lV2PmednTUWY33jiP1egr7nWiqLALsH5ZMAsZ15
         ylWvLIU0A0LU6EHQZEqjgl9zSMyUjKaUPgpqlu4V5ERWNTlvc9gdtN7gZ+x4xvSTa1H5
         Z3DrXJq3as5sWg5DFJnMrI0tF/aZXdoFhPj9hCwseZkmnm+TPLrAPNkFsl7EyntQtjVH
         zMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625084; x=1779229884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvvtwopQ36OBRmWU0ucgY1/gXw3CS1LfZrtN+jxXHYE=;
        b=ZZQWreOXeVqbS34DH5mw6NEb56PQfJqkpACXVRrkFvczaC5BywTMdNEW92PX8q0U3W
         NBqDYBzVi2WfXBQM6zdKR1NVxGarFzOwylaz6Oh5n0+PO3GuHeCRtySlFokjDRLAqfQY
         5sz343H+D8JSj7soHDnp1DmeesTkiVg/rZ105Q3BIMUyqp6HppQJ93qUcjELqtWwOIdo
         uQWMQo3+/ElQZwfzVQxOojObyPr3DANjOayUIRwW49EwshdfghSKQ14WUljIxBPbxZUt
         00VyLT4+rbFe5/yzMksf4PThMu2jIi67BDS4F4VbDpuUFVcgkib59FcjmcS+VLl5VygW
         u83w==
X-Forwarded-Encrypted: i=1; AFNElJ8Z7xeeGxFCwjrk3zEa9LFask5R4keZ2UPbDicZ2wViHup5LEUah2lW988rMH9VI7ssJDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+x/TIqsalRdDO6Nflf4dSrPGv/gUXUCB9Bex6fDc4DtU0kud
	xrd/Bg+JE3JLnzbvGqmlXs4gFvHzCfLgIcQyh8Ksbov/MVCMXonuaHGmnGbPfILkVA==
X-Gm-Gg: Acq92OHSuypLS+6U35BSD9866SkF/KLN9EbwAoypqlxt4R7EB8GYSRIhzq0OT7N1yMH
	Fu0pJ5dNBX3epJAU7pzQJlEWEc81K8TufaG9bonpHYBcchEKkUFLoaJGFWxALSSaPVH9cgO8xBG
	AiMzhsvldVdBKAtjonl98nbH0aK2CG5Ig6jgK5/awapoBEGSqxqqtj/yjPTcH81340FDvtJW2/h
	kdiE8O1T7n07avqyutfrPVLQfu3DcSEyy7rlgq1J9XIE4uSYBV3kAWZaFcGW5WCpW/ASEIBLMRI
	6e5Jf7GBSYLaDfkL6P+9VS4aq25Sm/g2O2qPIVLI6uyk5259JszjSS1qgqJzD23EbY9158N4WBB
	5N2D7nCyt9f8/uCePaDTcPb7UBWRbnhLQncbvCU+NIVEome5eE4RgXLQghpq0fov9Io1tlwM1A/
	A1QfVUt4ouyEWe6S9c6bJKlxDfrM4iyE6QKlsxxX0/ypp/LZolVUQr3nqeLSllUYZry2RLoVHr
X-Received: by 2002:a05:7022:43a9:b0:12a:77e6:68d9 with SMTP id a92af1059eb24-1340bb4c890mr98184c88.16.1778625083338;
        Tue, 12 May 2026 15:31:23 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb034sm19844208eec.5.2026.05.12.15.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:31:22 -0700 (PDT)
Date: Tue, 12 May 2026 15:31:18 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
Message-ID: <20260512223106.GH3046123.vipinsh@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
 <20260505212838.1698034-9-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505212838.1698034-9-rananta@google.com>

On Tue, May 05, 2026 at 09:28:38PM +0000, Raghavendra Rao Ananta wrote:
> Add a selftest, vfio_pci_sriov_uapi_test.c, to validate the
> SR-IOV UAPI, including the following cases, iterating over
> all the IOMMU modes currently supported:
>  - Setting correct/incorrect/NULL tokens during device init.
>  - Close the PF device immediately after setting the token.
>  - Change/override the PF's token after device init.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  tools/testing/selftests/vfio/Makefile         |   1 +
>  .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 217 ++++++++++++++++++
>  2 files changed, 218 insertions(+)
>  create mode 100644 tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 4437f04660089..d77ff5368e72f 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -12,6 +12,7 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
>  TEST_GEN_PROGS += vfio_pci_device_test
>  TEST_GEN_PROGS += vfio_pci_device_init_perf_test
>  TEST_GEN_PROGS += vfio_pci_driver_test
> +TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
>  
>  TEST_FILES += scripts/cleanup.sh
>  TEST_FILES += scripts/lib.sh
> diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> new file mode 100644
> index 0000000000000..19d657d00b753
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "lib/include/libvfio/assert.h"
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <sys/ioctl.h>
> +#include <linux/limits.h>
> +
> +#include <libvfio.h>
> +
> +#include "../kselftest_harness.h"
> +
> +#define UUID_1 "52ac9bff-3a88-4fbd-901a-0d767c3b6c97"
> +#define UUID_2 "88594674-90a0-47a9-aea8-9d9b352ac08a"
> +
> +static const char *pf_bdf;
> +static char *vf_bdf;
> +
> +static pid_t main_pid;
> +
> +static int container_setup(struct vfio_pci_device *device, const char *bdf,
> +			   const char *vf_token)
> +{
> +	vfio_pci_group_setup(device, bdf);
> +	vfio_container_set_iommu(device);
> +	__vfio_pci_group_get_device_fd(device, bdf, vf_token);
> +
> +	/* The device fd will be -1 in case of mismatched tokens */
> +	return (device->fd < 0);
> +}
> +
> +static int iommufd_setup(struct vfio_pci_device *device, const char *bdf,
> +			 const char *vf_token)
> +{
> +	vfio_pci_cdev_open(device, bdf);
> +	return __vfio_device_bind_iommufd(device->fd,
> +					  device->iommu->iommufd, vf_token);
> +}
> +
> +static int device_init(const char *bdf, struct iommu *iommu,
> +		       const char *vf_token, struct vfio_pci_device **out_dev)
> +{
> +	struct vfio_pci_device *device = vfio_pci_device_alloc(bdf, iommu);
> +	int ret;
> +
> +	if (iommu->mode->container_path)
> +		ret = container_setup(device, bdf, vf_token);
> +	else
> +		ret = iommufd_setup(device, bdf, vf_token);
> +
> +	*out_dev = device;
> +	return ret;
> +}
> +
> +static void device_cleanup(struct vfio_pci_device *device)
> +{
> +	if (!device)
> +		return;
> +
> +	if (device->fd > 0)
> +		VFIO_ASSERT_EQ(close(device->fd), 0);
> +
> +	if (device->group_fd)
> +		VFIO_ASSERT_EQ(close(device->group_fd), 0);
> +
> +	vfio_pci_device_free(device);
> +}
> +
> +FIXTURE(vfio_pci_sriov_uapi_test) {
> +	struct vfio_pci_device *pf;
> +	struct vfio_pci_device *vf;
> +	struct iommu *iommu;
> +	char *pf_token;
> +};
> +
> +FIXTURE_VARIANT(vfio_pci_sriov_uapi_test) {
> +	const char *iommu_mode;
> +	char *vf_token;
> +};
> +
> +#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _vf_token)		\
> +FIXTURE_VARIANT_ADD(vfio_pci_sriov_uapi_test, _iommu_mode ## _ ## _name) {	\
> +	.iommu_mode = #_iommu_mode,						\
> +	.vf_token = (_vf_token),						\
> +}
> +
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(same_uuid, UUID_1);
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(diff_uuid, UUID_2);
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(null_uuid, NULL);
> +
> +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> +{
> +	self->iommu = iommu_init(variant->iommu_mode);
> +
> +	self->pf_token = UUID_1;
> +	ASSERT_EQ(device_init(pf_bdf, self->iommu, self->pf_token, &self->pf), 0);
> +}
> +
> +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> +{
> +	device_cleanup(self->vf);
> +	device_cleanup(self->pf);
> +	iommu_cleanup(self->iommu);
> +}
> +
> +/*
> + * This asserts if the VF device is successfully created if its token matches
> + * with the token used to create/override the PF or fails during a mismatch.
> + */
> +#define ASSERT_COND_VF_CREATION(_ret) do {					\
> +	if (!variant->vf_token || strcmp(self->pf_token, variant->vf_token)) {	\
> +		ASSERT_NE((_ret), 0);						\
> +	} else {								\
> +		ASSERT_EQ((_ret), 0);						\
> +	}									\
> +} while (0)
> +
> +/*
> + * Validate if the UAPI handles correctly and incorrectly set token on the VF.
> + */
> +TEST_F(vfio_pci_sriov_uapi_test, init_token_match)
> +{
> +	int ret;
> +
> +	ret = device_init(vf_bdf, self->iommu, variant->vf_token, &self->vf);
> +	ASSERT_COND_VF_CREATION(ret);
> +}
> +
> +/*
> + * After closing the PF, validate if the VF access still needs the right token.
> + */
> +TEST_F(vfio_pci_sriov_uapi_test, pf_early_close)
> +{
> +	int ret;
> +
> +	device_cleanup(self->pf);
> +
> +	/* Clean the 'pf' to avoid calling device_cleanup() again. */
> +	self->pf = NULL;
> +
> +	ret = device_init(vf_bdf, self->iommu, variant->vf_token, &self->vf);
> +	ASSERT_COND_VF_CREATION(ret);
> +}
> +
> +/*
> + * After PF device init, override the existing token and validate if the newly
> + * set token is the one that's active.
> + */
> +TEST_F(vfio_pci_sriov_uapi_test, override_token)
> +{
> +	int ret;
> +
> +	self->pf_token = UUID_2;
> +	vfio_device_set_vf_token(self->pf->fd, self->pf_token);
> +
> +	ret = device_init(vf_bdf, self->iommu, variant->vf_token, &self->vf);
> +	ASSERT_COND_VF_CREATION(ret);
> +}
> +
> +static void vf_teardown(void)
> +{
> +	/*
> +	 * The child processes, created by TEST_F()s, inherits this atexit()
> +	 * handler. Hence, check and destroy the VF only when the main/parent
> +	 * process exits.
> +	 */
> +	if (getpid() != main_pid)
> +		return;
> +
> +	free(vf_bdf);
> +	sysfs_sriov_numvfs_set(pf_bdf, 0);
> +}
> +
> +static void vf_setup(void)
> +{
> +	char *vf_driver;
> +	int nr_vfs;
> +
> +	nr_vfs = sysfs_sriov_totalvfs_get(pf_bdf);
> +	if (nr_vfs <= 0)
> +		ksft_exit_skip("SR-IOV may not be supported by the PF: %s\n", pf_bdf);
> +
> +	nr_vfs = sysfs_sriov_numvfs_get(pf_bdf);
> +	if (nr_vfs != 0)
> +		ksft_exit_skip("SR-IOV already configured for the PF: %s\n", pf_bdf);
> +
> +	/* Create only one VF for testing */
> +	sysfs_sriov_numvfs_set(pf_bdf, 1);
> +
> +	/*
> +	 * Setup an exit handler to destroy the VF in case of failures
> +	 * during further setup at the end of the test run.
> +	 */
> +	main_pid = getpid();
> +	VFIO_ASSERT_EQ(atexit(vf_teardown), 0);
> +
> +	vf_bdf = sysfs_sriov_vf_bdf_get(pf_bdf, 0);
> +
> +	/*
> +	 * The VF inherits the driver from the PF.
> +	 * Ensure this is 'vfio-pci' before proceeding.
> +	 */
> +	vf_driver = sysfs_driver_get(vf_bdf);
> +	VFIO_ASSERT_NE(vf_driver, NULL);
> +	VFIO_ASSERT_EQ(strcmp(vf_driver, "vfio-pci"), 0);
> +	free(vf_driver);
> +
> +	printf("Created 1 VF (%s) under the PF: %s\n", vf_bdf, pf_bdf);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	pf_bdf = vfio_selftests_get_bdf(&argc, argv);
> +	vf_setup();
> +
> +	return test_harness_run(argc, argv);
> +}
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
Reviewed-by: Vipin Sharma <vipinsh@google.com> 

