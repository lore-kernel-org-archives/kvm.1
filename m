Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046527;
	b=o8g46jPJl6azTj3AQB+HDlZutF8qpzMTpzcD/i1lpH1nIfpEOqI5k3LTvnfreiCpJ8ce
	 JjvCOY1K2pgNNFVQcRjmgWM5Y1FzWWx0624h+rFsuA6tVc1/wmzuee+khK568RJI7xHzF
	 6tcEcr6oSNeXWS+Ybzp07LxS4e3n2/iDGEptzRjugyQ5jYug7BUQBG45Lvh7fPtSpcwV+
	 Yx793K1YnX9cgtM6QH1Lhz56GEercV+ru9uekp7EC3bxUZURA4Q2HPIn3q2y+fZoRMMy4
	 etbvCzBxbOHzjRW0ETszd/7ksqOTpI7DKhtBQFDvbSdI0QUD4bZA3ge7H25EJOpoajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HPFw4rbLyAAw0EodXoO87GmwMVo+rA3zhzGO26T6THI=;
	b=A96waYYLoUUJXJ1dkL+Xtv2UGbUiyPmeKBT5+fkhb85Q1CYSJJtIJpWS7kJpMiT87oEw
	 dAyaV8Vvj7k6uxbTcFOkLUoad0VwWgJqrKk2pGi7W81bAEUlHBu0qXFA8/ZNTODpaA36r
	 sl6MESIR7y/zaMgz0EGz1GX4Y96NuzoEwy3iv/5GZlWe372CEEDe6ZGD4SY/qZ3LpNKtd
	 H3jQ//GD7MYb/IHstvxncvIKsa6mPNSD4VMXXkGRWUve9PWyA80ZOCHQg9gvftyhXBzkG
	 dLRbPp0kdifkCW6EaFLH1t+1Y0MqxJlGOJ2IAtFP0Li9X65jwpZKPQYfU2vkWNoQaUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BiepogfD;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2160A5BE5
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54C2160A5BE5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BiepogfD
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4cc89e86e9eso1694654b6e.3
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046526; x=1795651326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HPFw4rbLyAAw0EodXoO87GmwMVo+rA3zhzGO26T6THI=;
        b=BiepogfDCoyJSnNNxOFQ3GVuPvwSSkEtR5JE47DUJAFBDLSoemWcscI0twJF1A0Xqf
         p0cJL9ezvcvgfrc0rR79qbTjJlsB0t5xUGrMCaWTzFprqtOT6HjQ2doboKJeHHdIXh1P
         st7UMk5yopQXRNBlFMmxRNFdusjlh/DnwCu+X7FEw4SyBDc95qzQ2EiZTTLphuMqWc3l
         86XWAblJ8O3ro4nvDaFFP1cNd7Lx+tu0LeS6tdSA572STVHGsURQDHEW+lj2C0FyckxL
         IooOmyGRcrRgEuFpvWos3leSp25riYlEGZAELshd3xc859zsJlSr1Z5GUa+zzsLG3dFe
         3LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046526; x=1795651326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HPFw4rbLyAAw0EodXoO87GmwMVo+rA3zhzGO26T6THI=;
        b=VRS9bd2hoKejXTdJ2O85Wy70sDTk1BsICZ4Q+yOym7OQATupMDGp4qC2dgnTTWfZON
         CSDz97CeAKLycX2+ckQyIx81y/xq2UCPtcN+Z1pVvuIHa9RGcn4YbFSInChYUHE757Ck
         TymNy09Xj+gKOIlsaSFwHV5xr8gHr7GdzUyxkKrgcZu3SVQECXCMB4TyNAJ/QY2Mk74d
         m1dpmWzPXiAAcyvXeVLFanA2sqiis5T8iQ4BB9IE6dN8zEONFIOPKV28LDuPrhROdv14
         u1hAMULGyi0pVsGmxJewXmkCO8qbvB3GaAiZuI0I2VFvTvuTmVaCXbDgDxk4nSOMVMTf
         E46w==
X-Gm-Message-State: APuU4Z+MH1+CCttWJiESNVeU4WQWeYjf/63HU1LpE28D1YZX+o9t781f
	X7dr8CVqv90wWKKtGVVyodmpfXvqJ/ZDY5eIAQVGVs1k7nwt5tKWG+W8rIPuUy5trLP1HUpeKJw
	X8nenTHorINKGrRPOZ3LoaX+rgEtjFxHoYoHFGsBc01PK2MIbKcNdeoHaiOS01sIy6VNUnzdJqw
	CPysb7kryFWYxgCorBJd3aSqAd9SMKUZeHwZ22FEUQN2M=
X-Received: from ioai18.prod.google.com ([2002:a05:6602:72d2:b0:9c7:d55f:a8af])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f07:b0:564:3fe1:2f95 with SMTP id 5614622812f47-57741c1af9bmr5343225b6e.56.1795046525841;
 Wed, 18 Nov 2026 16:02:05 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:50 +0000
In-Reply-To: <20261119000151.442543-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119000151.442543-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119000151.442543-9-dmatlack@google.com>
Subject: [PATCH v2 8/8] vfio: selftests: Add test for device power state transitions
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add vfio_pci_power_state_test to exercise VFIO's handling of device
power state changes initiated by userspace through the PM capability in
config space.

The test covers:

 - Closing a device in D3hot and then reopening it, which must leave
   the device in D0.
 - Enabling SR-IOV while the PF is in D3hot, which must return the PF to
   D0 and prevent it from leaving D0 while VFs are enabled.
 - Racing a close of the device while it is in D3hot against enabling
   SR-IOV, both of which transition the device back to D0.

The SR-IOV tests are skipped if the device does not support SR-IOV,
already has VFs enabled, or SR-IOV cannot be configured on it (e.g.
vfio-pci with vfio_pci.enable_sriov=N). If an SR-IOV test case fails,
any VFs it left enabled are disabled so they don't affect later test
cases.

Fail the test if /sys/kernel/warn_count changes between fixture setup
and teardown, since bugs such as the close vs. SR-IOV enable race show
up only as kernel warnings. When that happens, print the warnings
logged to /dev/kmsg during the test so that the failure can be debugged
from the test log.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/vfio_pci_power_state_test.c          | 256 ++++++++++++++++++
 2 files changed, 257 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_power_state_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..e2b152528560 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_GEN_PROGS += vfio_pci_power_state_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
 
 TEST_FILES += scripts/cleanup.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_power_state_test.c b/tools/testing/selftests/vfio/vfio_pci_power_state_test.c
new file mode 100644
index 000000000000..5b185c174036
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_power_state_test.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <pthread.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <linux/pci_regs.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+/* PCI_PM_CTRL_STATE_MASK values */
+#define D0	0
+#define D3HOT	3
+
+static const char *device_bdf;
+
+static u16 power_state_get(struct vfio_pci_device *device, u8 pm_cap)
+{
+	return vfio_pci_config_readw(device, pm_cap + PCI_PM_CTRL) &
+	       PCI_PM_CTRL_STATE_MASK;
+}
+
+static void power_state_set(struct vfio_pci_device *device, u8 pm_cap,
+			    u16 state)
+{
+	u16 pmcsr = vfio_pci_config_readw(device, pm_cap + PCI_PM_CTRL);
+
+	pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
+	pmcsr |= state;
+
+	vfio_pci_config_writew(device, pm_cap + PCI_PM_CTRL, pmcsr);
+}
+
+/*
+ * Set by test cases that enable VFs, so that disable_vfs() can disable any VFs
+ * left enabled if the test case fails. Only set in the child process that runs
+ * the test case.
+ */
+static bool test_enabled_vfs;
+
+/*
+ * Disable VFs left enabled by a failed test case, so they don't affect later
+ * test cases. Called from fixture teardown, which runs when an ASSERT fails,
+ * and from an atexit() handler, which runs when a library helper exits the
+ * test process early (e.g. on a VFIO_ASSERT() failure).
+ */
+static void disable_vfs(void)
+{
+	if (test_enabled_vfs && sysfs_sriov_numvfs_get(device_bdf) > 0)
+		__sysfs_sriov_numvfs_set(device_bdf, 0);
+}
+
+/*
+ * Check whether the test can enable VFs on the device, briefly enabling one VF
+ * to find out. Returns the reason to skip the test, or NULL if it can run.
+ */
+static const char *sriov_skip_reason(void)
+{
+	int ret;
+
+	if (sysfs_sriov_totalvfs_get(device_bdf) <= 0)
+		return "Device does not support SR-IOV";
+
+	if (sysfs_sriov_numvfs_get(device_bdf) != 0)
+		return "SR-IOV is already enabled on the device";
+
+	/* From here on, any VFs on the device were enabled by this test. */
+	test_enabled_vfs = true;
+
+	/* -ENOENT means SR-IOV cannot be configured on the device. */
+	ret = __sysfs_sriov_numvfs_set(device_bdf, 1);
+	if (ret == -ENOENT)
+		return "Cannot enable SR-IOV on the device (vfio-pci requires enable_sriov=1)";
+
+	VFIO_ASSERT_EQ(ret, 0);
+	sysfs_sriov_numvfs_set(device_bdf, 0);
+	return NULL;
+}
+
+FIXTURE(vfio_pci_power_state_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+	u8 pm_cap;
+	int warn_count;
+	int kmsg_fd;
+};
+
+FIXTURE_SETUP(vfio_pci_power_state_test)
+{
+	/*
+	 * Snapshot the kernel's warning count so that teardown can check that
+	 * the test did not trigger any kernel warnings, which are otherwise
+	 * invisible to the test. Open /dev/kmsg first so that any warning
+	 * counted after the snapshot can be printed if the check fails.
+	 */
+	self->kmsg_fd = kmsg_open();
+	self->warn_count = sysfs_kernel_warn_count_get();
+
+	self->iommu = iommu_init(default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+
+	self->pm_cap = vfio_pci_find_capability(self->device, PCI_CAP_ID_PM);
+	if (!self->pm_cap)
+		SKIP(return, "Device does not have a PM capability\n");
+
+	ASSERT_EQ(power_state_get(self->device, self->pm_cap), D0);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_power_state_test)
+{
+	disable_vfs();
+
+	if (self->device)
+		vfio_pci_device_cleanup(self->device);
+
+	iommu_cleanup(self->iommu);
+
+	if (self->warn_count >= 0) {
+		int warn_count = sysfs_kernel_warn_count_get();
+
+		if (warn_count != self->warn_count && self->kmsg_fd >= 0)
+			kmsg_print_warnings(self->kmsg_fd);
+
+		EXPECT_EQ(warn_count, self->warn_count);
+	}
+
+	if (self->kmsg_fd >= 0)
+		close(self->kmsg_fd);
+}
+
+/*
+ * Put the device into D3hot via config space, close it, and then reopen it.
+ * Closing the device while it is in D3hot must not trigger any kernel warnings
+ * (checked during fixture teardown), and the device must be in D0 when it is
+ * reopened.
+ *
+ * Note that this does not verify that VFIO returns the device to D0 during
+ * close, since that is not reliably observable from userspace: the device may
+ * runtime suspend after it is closed, and opening it also transitions it to
+ * D0.
+ */
+TEST_F(vfio_pci_power_state_test, reopen_after_close_in_d3hot)
+{
+	power_state_set(self->device, self->pm_cap, D3HOT);
+	ASSERT_EQ(power_state_get(self->device, self->pm_cap), D3HOT);
+
+	vfio_pci_device_cleanup(self->device);
+
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	ASSERT_EQ(power_state_get(self->device, self->pm_cap), D0);
+}
+
+/*
+ * Put the device into D3hot via config space and then enable SR-IOV. VFIO
+ * must return the PF to D0 before enabling VFs, and must not allow the PF to
+ * leave D0 while VFs are enabled.
+ */
+TEST_F(vfio_pci_power_state_test, sriov_enable_in_d3hot)
+{
+	const char *skip_reason = sriov_skip_reason();
+
+	if (skip_reason)
+		SKIP(return, "%s", skip_reason);
+
+	power_state_set(self->device, self->pm_cap, D3HOT);
+	ASSERT_EQ(power_state_get(self->device, self->pm_cap), D3HOT);
+
+	sysfs_sriov_numvfs_set(device_bdf, 1);
+	EXPECT_EQ(power_state_get(self->device, self->pm_cap), D0);
+
+	power_state_set(self->device, self->pm_cap, D3HOT);
+	EXPECT_EQ(power_state_get(self->device, self->pm_cap), D0);
+
+	sysfs_sriov_numvfs_set(device_bdf, 0);
+
+	power_state_set(self->device, self->pm_cap, D3HOT);
+	EXPECT_EQ(power_state_get(self->device, self->pm_cap), D3HOT);
+
+	power_state_set(self->device, self->pm_cap, D0);
+	EXPECT_EQ(power_state_get(self->device, self->pm_cap), D0);
+}
+
+struct sriov_enable_args {
+	pthread_barrier_t barrier;
+	int delay_us;
+};
+
+static void *sriov_enable_thread(void *arg)
+{
+	struct sriov_enable_args *args = arg;
+
+	pthread_barrier_wait(&args->barrier);
+	usleep(args->delay_us);
+	sysfs_sriov_numvfs_set(device_bdf, 1);
+	return NULL;
+}
+
+/*
+ * Race closing the device while it is in D3hot against enabling SR-IOV. Both
+ * paths transition the device back to D0, which must be serialized by VFIO,
+ * e.g. to avoid restoring the PF's BARs after VFs have been enabled or
+ * double-freeing the saved PM state.
+ *
+ * The D3hot->D0 transition during close includes a delay (10ms by default)
+ * before the device's state is restored. Use a barrier to start closing the
+ * device and enabling SR-IOV at the same time, and then delay enabling SR-IOV
+ * by a few milliseconds so that it lands inside that window. Vary the delay
+ * across iterations to account for differences in timing across systems and
+ * kernel configs.
+ */
+TEST_F(vfio_pci_power_state_test, close_in_d3hot_races_sriov_enable)
+{
+	struct sriov_enable_args args;
+	pthread_t thread;
+	const char *skip_reason;
+	int i;
+
+	skip_reason = sriov_skip_reason();
+	if (skip_reason)
+		SKIP(return, "%s", skip_reason);
+
+	ASSERT_EQ(pthread_barrier_init(&args.barrier, NULL, 2), 0);
+
+	/*
+	 * Keep the number of iterations low since each one enables and
+	 * disables SR-IOV, which can take over a second.
+	 */
+	for (i = 0; i < 10; i++) {
+		args.delay_us = 2000 + i * 500;
+
+		power_state_set(self->device, self->pm_cap, D3HOT);
+		ASSERT_EQ(power_state_get(self->device, self->pm_cap), D3HOT);
+
+		ASSERT_EQ(pthread_create(&thread, NULL, sriov_enable_thread, &args), 0);
+		pthread_barrier_wait(&args.barrier);
+		vfio_pci_device_cleanup(self->device);
+		self->device = NULL;
+		ASSERT_EQ(pthread_join(thread, NULL), 0);
+
+		sysfs_sriov_numvfs_set(device_bdf, 0);
+
+		self->device = vfio_pci_device_init(device_bdf, self->iommu);
+		ASSERT_EQ(power_state_get(self->device, self->pm_cap), D0);
+	}
+
+	ASSERT_EQ(pthread_barrier_destroy(&args.barrier), 0);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	VFIO_ASSERT_EQ(atexit(disable_vfs), 0);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.56.1.708.g77570a6a1d-goog

