Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE84949EB
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016535; cv=none; b=vF6kQRX+vAXa94h1LHBbs5NUJp9IWTls5r3awHoi+P1X08ykP3q08QR0o2H89rwjyuiS9GewY1h4MIV3yJ5/p2SYKu9s4e8/mmnkZEFGzJJpVQVKQRdJ/37y9a568OiahtiluUpKDMm9wtIA5PsTL7yqoPABJk7Xzl0Vve0UyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016535; c=relaxed/simple;
	bh=maXaugutjtZYAm4sRDneiyDXHzDeaLzoh6JDTFiH1Rk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jKhAltqW4drLCTsdCt2COiumqu1Nj0qFiRExgxONrZy0ufsYPblhKJlTLGMIcnu6dL3zUx7tiRT0XfP4MaW6QVjlaFk643tgzSE+G0ts4RbZc7mLAkkeec4HjPWrdbK1wHd0oIqv35KHfvobqtf4dzC+ct+cPyST7vFhHdoJpWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIigyocl; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIigyocl"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-47e80ab61a5so1586078b6e.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016528; x=1778621328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aeeuaD10nbSlLro29O11/wH4Kr2qjMV+qBca2WcLDA4=;
        b=AIigyoclSA+yfhClYZxPBPQ2/FfKzdpi5YrTCgi8I94K6DntpohR4RKp21Yovc5q5A
         oS0+3jVJxuC6UN55/FJNX9DjHLvJtETnt1Bx7/sTzZQ8T5Dxg7SthBd4rUuqKxoBpmiO
         78StDBUTr4VGFMTWLE0QpejAsLs/R33qZVOCGQZYvdp9MzLYepJkx91SJv3PbzOtb2D5
         2209uDwa8ME/6vATcA1n3lk20ALuuvOqQ3d4MwBIBeVpe8EaR6fSmmM64dGlewdnmjwh
         inqBfJL6OQvGn+9vb8jscgHTqp+kTXE3dhIpApK2O8j8VZ8mHaiufvJJ+ujCX0xme0rZ
         94Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016528; x=1778621328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeeuaD10nbSlLro29O11/wH4Kr2qjMV+qBca2WcLDA4=;
        b=qQsOI8dRL00koHvu9r6TIGe1TRd7iqcck+cu4EVk/39tdRBJWVq/9HSwBUoh0JxFBV
         0WxCGXhi1EKVFZQjk01zQJy5uCvlLFVA9jg8dmTpP0MT34ZBOmXCWcg8qNbL4EgiAVYp
         vMXC03IHWK0DleHZBFoTfO4MkkDDs28iuoQa7xdYJL8y0HhBQ4SpMJ/8ijamoIPEmrwU
         EjfSGbE1WIXmO9Y/h14iRn7mhfc6b/7oUyVUiinTFb11Dsy31TeOnyzDddTBCAdo9qXH
         qs+OwklXXJho0s/U1OTw5m8RCuLgj6Blmij+sir1ZaxJcFMoLeyaTO+kIJcEIrhHh2mB
         d6fw==
X-Forwarded-Encrypted: i=1; AFNElJ8v0gHutJY88ABiTRwLto+g3i8oWvz+3H7d+y/HECoazE98k4f80DkUtDNr7IE+7Zn0pGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsU09VELnxVYQN1dXnLVprRQ0vzMHFHV2rgS4wnzNN79R96QdY
	9MCcubPq3idNh81stQqSLbi9aNgniHMJ7fAEhsMhEfnqYuxB1z6MnnvkrkG1qeKBe8OGORSEvB0
	NGuiTmGnapA==
X-Received: from ilpy1.prod.google.com ([2002:a92:c741:0:b0:4fb:4c9c:2186])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:607:b0:694:a30f:a6d6
 with SMTP id 006d021491bc7-69998ceebfamr405274eaf.25.1778016527917; Tue, 05
 May 2026 14:28:47 -0700 (PDT)
Date: Tue,  5 May 2026 21:28:38 +0000
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505212838.1698034-1-rananta@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505212838.1698034-9-rananta@google.com>
Subject: [PATCH v8 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
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
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 217 ++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 4437f04660089..d77ff5368e72f 100644
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
index 0000000000000..19d657d00b753
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
@@ -0,0 +1,217 @@
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
+static int device_init(const char *bdf, struct iommu *iommu,
+		       const char *vf_token, struct vfio_pci_device **out_dev)
+{
+	struct vfio_pci_device *device = vfio_pci_device_alloc(bdf, iommu);
+	int ret;
+
+	if (iommu->mode->container_path)
+		ret = container_setup(device, bdf, vf_token);
+	else
+		ret = iommufd_setup(device, bdf, vf_token);
+
+	*out_dev = device;
+	return ret;
+}
+
+static void device_cleanup(struct vfio_pci_device *device)
+{
+	if (!device)
+		return;
+
+	if (device->fd > 0)
+		VFIO_ASSERT_EQ(close(device->fd), 0);
+
+	if (device->group_fd)
+		VFIO_ASSERT_EQ(close(device->group_fd), 0);
+
+	vfio_pci_device_free(device);
+}
+
+FIXTURE(vfio_pci_sriov_uapi_test) {
+	struct vfio_pci_device *pf;
+	struct vfio_pci_device *vf;
+	struct iommu *iommu;
+	char *pf_token;
+};
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
+FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
+{
+	self->iommu = iommu_init(variant->iommu_mode);
+
+	self->pf_token = UUID_1;
+	ASSERT_EQ(device_init(pf_bdf, self->iommu, self->pf_token, &self->pf), 0);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
+{
+	device_cleanup(self->vf);
+	device_cleanup(self->pf);
+	iommu_cleanup(self->iommu);
+}
+
+/*
+ * This asserts if the VF device is successfully created if its token matches
+ * with the token used to create/override the PF or fails during a mismatch.
+ */
+#define ASSERT_COND_VF_CREATION(_ret) do {					\
+	if (!variant->vf_token || strcmp(self->pf_token, variant->vf_token)) {	\
+		ASSERT_NE((_ret), 0);						\
+	} else {								\
+		ASSERT_EQ((_ret), 0);						\
+	}									\
+} while (0)
+
+/*
+ * Validate if the UAPI handles correctly and incorrectly set token on the VF.
+ */
+TEST_F(vfio_pci_sriov_uapi_test, init_token_match)
+{
+	int ret;
+
+	ret = device_init(vf_bdf, self->iommu, variant->vf_token, &self->vf);
+	ASSERT_COND_VF_CREATION(ret);
+}
+
+/*
+ * After closing the PF, validate if the VF access still needs the right token.
+ */
+TEST_F(vfio_pci_sriov_uapi_test, pf_early_close)
+{
+	int ret;
+
+	device_cleanup(self->pf);
+
+	/* Clean the 'pf' to avoid calling device_cleanup() again. */
+	self->pf = NULL;
+
+	ret = device_init(vf_bdf, self->iommu, variant->vf_token, &self->vf);
+	ASSERT_COND_VF_CREATION(ret);
+}
+
+/*
+ * After PF device init, override the existing token and validate if the newly
+ * set token is the one that's active.
+ */
+TEST_F(vfio_pci_sriov_uapi_test, override_token)
+{
+	int ret;
+
+	self->pf_token = UUID_2;
+	vfio_device_set_vf_token(self->pf->fd, self->pf_token);
+
+	ret = device_init(vf_bdf, self->iommu, variant->vf_token, &self->vf);
+	ASSERT_COND_VF_CREATION(ret);
+}
+
+static void vf_teardown(void)
+{
+	/*
+	 * The child processes, created by TEST_F()s, inherits this atexit()
+	 * handler. Hence, check and destroy the VF only when the main/parent
+	 * process exits.
+	 */
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
2.54.0.545.g6539524ca2-goog

