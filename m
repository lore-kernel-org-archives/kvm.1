Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679F3F7E7D
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151074; cv=none; b=nRaHmUPjjvx3u9dGwZ7HMjCGLJJQcLsmlu54vEV5vJ3qMCoGWtCkQ2q/Qxv5lwjFjPW7YihnSMIaGLfVt/fbEih+kMLm4XyUQYn6+j40tOPHB1mP98+cDxqLvuZ/ig7o3r8j3/MuG0oaozluWT7jwPCK3gBIs17HFT2Yzt2mREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151074; c=relaxed/simple;
	bh=wBT3SOqrN7GgpQlXXyPj9EpUQ0dPzwTBiblJ7id3wLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bFOW3mM2UKw0F5HyeS8kZtmvrXa5Pv8D6MOX/5pHCuWkkIqlxYgfBy7OgFxhd8lgT5ky1WP0kMHh40MNwmTuMqcIhqvsDqiY7naNubALX/PFcJlb2Js84XR+hRuO+wTrj/8SgTYw5j/02MFSATi5WajLsHuPSyji+aXRijxM4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4uc9WK/; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4uc9WK/"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-40efa542b8aso2039150fac.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151071; x=1775755871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BsAK2c6NlREYTGsIPFCjENwVQZJrHsunFqwEtFuFdLA=;
        b=A4uc9WK/hfDwcJqgEZ9FCWOYqXmweySETHoR//SbxO7DI2du9AHeVqE7GBFCgAiNNQ
         mLnoJSUngif0LOnGnM6qfG5qJSExoDmRhr+eMqMwHTSPIDymye0mExnL84tFTVrA45wT
         zNHuCMny9oQkmTAS7gFa8TfmLH+/TD380STCIPgqh17XbC+zz7a1MZytegUaA0JQevxe
         Gu1QKy5qQmI6X3WQDjqV3DHwH5E1eORar6/r+X6a6cFWziWxgKgLxVOhkvvdgq1oKMBL
         70ctCK019EAyS9x2To+EVeP+o5m+ytknAQgfI8TLasoYjIrWN4LWysfB3HoKEiMKzRAu
         1Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151071; x=1775755871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsAK2c6NlREYTGsIPFCjENwVQZJrHsunFqwEtFuFdLA=;
        b=Z1RxQZIWF30+cTKFQ3m7TmBxz5a5/aKk56NxlA15+7OS6sJEGubB0fbdc3wsejSP6g
         Z8248RgBeTPVU2rAdC7bfivJSOHiwBEb4WR41usol3y1IX6vhsTvG/odT7AXH8QSNowz
         KM19y/0AMd1ysjQZz+oXCxFxhb764xaHZ42SGK3F1o9Ta7CGeTlnzq9BEe0DwUsQWO7f
         fN+S/2nlyW5H2afQgT2SrA9zPH5hZ8fWFsG7tyLj8Ho34hqZP/0H4sCcEtrICfOrYThi
         GyRK46/M+nrRcCPHVsFOaJYIUhEf827bkTV+F4xwH0o6NIaO/AKRBR6mqbkLeibTzWtE
         2OVA==
X-Forwarded-Encrypted: i=1; AJvYcCXK7qAtCviecesbYYHt3Rufb3AWvmYNvoZVMk52d4frpVoAdzz43foYZnq+mliBgxvOWGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAx5LHKXiO4aywJvC4OziFjqrDT0z4HLKKZHccwIv1gjB0ctu
	ne+Ya3Y5/IxIBgOytFcwydALjlO8YEWl3Vvot5O+0vzqBhQAdBJIJksHqPwhdR1fqZxAu77qz+B
	WqQscv/Sc+w==
X-Received: from iluo15.prod.google.com ([2002:a05:6e02:188f:b0:4f8:9ea7:99d9])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:55d7:20b0:67e:15a6:e013
 with SMTP id 006d021491bc7-68220647265mr2757eaf.56.1775151071234; Thu, 02 Apr
 2026 10:31:11 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:30:59 +0000
In-Reply-To: <20260402173059.1018805-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402173059.1018805-9-rananta@google.com>
Subject: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest, vfio_pci_sriov_uapi_test.c, to validate the
SR-IOV UAPI, including the following cases, iterating over
all the IOMMU modes currently supported:
 - Setting correct/incorrect/NULL tokens during device init.
 - Close the PF device immediately after setting the token.
 - Change/override the PF's token after device init.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 230 ++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index f27ed18070f14..d0c8cea53eb54 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
new file mode 100644
index 0000000000000..3acc3d78e7422
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "lib/include/libvfio/assert.h"
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <linux/limits.h>
+
+#include <libvfio.h>
+
+#include "../kselftest_harness.h"
+
+#define UUID_1 "52ac9bff-3a88-4fbd-901a-0d767c3b6c97"
+#define UUID_2 "88594674-90a0-47a9-aea8-9d9b352ac08a"
+
+static const char *pf_bdf;
+static char *vf_bdf;
+
+static pid_t main_pid;
+
+static int container_setup(struct vfio_pci_device *device, const char *bdf,
+			   const char *vf_token)
+{
+	vfio_pci_group_setup(device, bdf);
+	vfio_container_set_iommu(device);
+	__vfio_pci_group_get_device_fd(device, bdf, vf_token);
+
+	/* The device fd will be -1 in case of mismatched tokens */
+	return (device->fd < 0);
+}
+
+static int iommufd_setup(struct vfio_pci_device *device, const char *bdf,
+			 const char *vf_token)
+{
+	vfio_pci_cdev_open(device, bdf);
+	return __vfio_device_bind_iommufd(device->fd,
+					  device->iommu->iommufd, vf_token);
+}
+
+static struct vfio_pci_device *device_init(const char *bdf, struct iommu *iommu,
+					   const char *vf_token, int *out_ret)
+{
+	struct vfio_pci_device *device = vfio_pci_device_alloc(bdf, iommu);
+
+	if (iommu->mode->container_path)
+		*out_ret = container_setup(device, bdf, vf_token);
+	else
+		*out_ret = iommufd_setup(device, bdf, vf_token);
+
+	return device;
+}
+
+static void device_cleanup(struct vfio_pci_device *device)
+{
+	if (device->fd > 0)
+		VFIO_ASSERT_EQ(close(device->fd), 0);
+
+	if (device->group_fd)
+		VFIO_ASSERT_EQ(close(device->group_fd), 0);
+
+	vfio_pci_device_free(device);
+}
+
+/* clang-format off */
+FIXTURE(vfio_pci_sriov_uapi_test) {};
+/* clang-format on */
+
+FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
+{
+}
+
+FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
+{
+}
+
+FIXTURE_VARIANT(vfio_pci_sriov_uapi_test) {
+	const char *iommu_mode;
+	char *vf_token;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _vf_token)		\
+FIXTURE_VARIANT_ADD(vfio_pci_sriov_uapi_test, _iommu_mode ## _ ## _name) {	\
+	.iommu_mode = #_iommu_mode,						\
+	.vf_token = (_vf_token),						\
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(same_uuid, UUID_1);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(diff_uuid, UUID_2);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(null_uuid, NULL);
+
+/*
+ * PF's token is always set with UUID_1 and VF's token is rotated with
+ * various tokens (including UUID_1 and NULL).
+ * This asserts if the VF device is successfully created for a match
+ * in the token or actually fails during a mismatch.
+ */
+#define ASSERT_VF_CREATION(_ret) do {					\
+	if (!variant->vf_token || strcmp(UUID_1, variant->vf_token)) {	\
+		ASSERT_NE((_ret), 0);					\
+	} else {							\
+		ASSERT_EQ((_ret), 0);					\
+	}								\
+} while (0)
+
+/*
+ * Validate if the UAPI handles correctly and incorrectly set token on the VF.
+ */
+TEST_F(vfio_pci_sriov_uapi_test, init_token_match)
+{
+	struct vfio_pci_device *pf;
+	struct vfio_pci_device *vf;
+	struct iommu *iommu;
+	int ret;
+
+	iommu = iommu_init(variant->iommu_mode);
+
+	pf = device_init(pf_bdf, iommu, UUID_1, &ret);
+	ASSERT_EQ(ret, 0);
+
+	vf = device_init(vf_bdf, iommu, variant->vf_token, &ret);
+	ASSERT_VF_CREATION(ret);
+
+	device_cleanup(vf);
+	device_cleanup(pf);
+	iommu_cleanup(iommu);
+}
+
+/*
+ * After setting a token on the PF, validate if the VF can still set the
+ * expected token.
+ */
+TEST_F(vfio_pci_sriov_uapi_test, pf_early_close)
+{
+	struct vfio_pci_device *pf;
+	struct vfio_pci_device *vf;
+	struct iommu *iommu;
+	int ret;
+
+	iommu = iommu_init(variant->iommu_mode);
+
+	pf = device_init(pf_bdf, iommu, UUID_1, &ret);
+	ASSERT_EQ(ret, 0);
+	device_cleanup(pf);
+
+	vf = device_init(vf_bdf, iommu, variant->vf_token, &ret);
+	ASSERT_VF_CREATION(ret);
+
+	device_cleanup(vf);
+	iommu_cleanup(iommu);
+}
+
+/*
+ * After PF device init, override the existing token and validate if the newly
+ * set token is the one that's active.
+ */
+TEST_F(vfio_pci_sriov_uapi_test, override_token)
+{
+	struct vfio_pci_device *pf;
+	struct vfio_pci_device *vf;
+	struct iommu *iommu;
+	int ret;
+
+	iommu = iommu_init(variant->iommu_mode);
+
+	pf = device_init(pf_bdf, iommu, UUID_2, &ret);
+	ASSERT_EQ(ret, 0);
+	vfio_device_set_vf_token(pf->fd, UUID_1);
+
+	vf = device_init(vf_bdf, iommu, variant->vf_token, &ret);
+	ASSERT_VF_CREATION(ret);
+
+	device_cleanup(vf);
+	device_cleanup(pf);
+	iommu_cleanup(iommu);
+}
+
+static void vf_teardown(void)
+{
+	/* Destroy the VF only when the main/parent process exits. */
+	if (getpid() != main_pid)
+		return;
+
+	free(vf_bdf);
+	sysfs_sriov_numvfs_set(pf_bdf, 0);
+}
+
+static void vf_setup(void)
+{
+	char *vf_driver;
+	int nr_vfs;
+
+	nr_vfs = sysfs_sriov_totalvfs_get(pf_bdf);
+	if (nr_vfs <= 0)
+		ksft_exit_skip("SR-IOV may not be supported by the PF: %s\n", pf_bdf);
+
+	nr_vfs = sysfs_sriov_numvfs_get(pf_bdf);
+	if (nr_vfs != 0)
+		ksft_exit_skip("SR-IOV already configured for the PF: %s\n", pf_bdf);
+
+	/* Create only one VF for testing */
+	sysfs_sriov_numvfs_set(pf_bdf, 1);
+
+	/*
+	 * Setup an exit handler to destroy the VF in case of failures
+	 * during further setup at the end of the test run.
+	 */
+	main_pid = getpid();
+	VFIO_ASSERT_EQ(atexit(vf_teardown), 0);
+
+	vf_bdf = sysfs_sriov_vf_bdf_get(pf_bdf, 0);
+
+	/*
+	 * The VF inherits the driver from the PF.
+	 * Ensure this is 'vfio-pci' before proceeding.
+	 */
+	vf_driver = sysfs_driver_get(vf_bdf);
+	VFIO_ASSERT_NE(vf_driver, NULL);
+	VFIO_ASSERT_EQ(strcmp(vf_driver, "vfio-pci"), 0);
+	free(vf_driver);
+
+	printf("Created 1 VF (%s) under the PF: %s\n", vf_bdf, pf_bdf);
+}
+
+int main(int argc, char *argv[])
+{
+	pf_bdf = vfio_selftests_get_bdf(&argc, argv);
+	vf_setup();
+
+	return test_harness_run(argc, argv);
+}
-- 
2.53.0.1213.gd9a14994de-goog

