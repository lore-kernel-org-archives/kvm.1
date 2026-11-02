Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633847;
	b=oaTDUpu9o+WC89oF9b/bBrNuR+TVIxAIop8mJ6OH50DxQSrG77SDoAlUVqpiiuZWi3zy
	 aZWRMuT8jw7nvTebOyIWYxk1cyB0ZsumJOGU21I98PMlTRj0hspoX3UznBOaMGG5Vre1W
	 4/9DgwaP0Oxinmd9CmhrPbXWjT4Ry4MapEbCLgQbenI8bXVsijoukQRJltLjMcTiK2Qp2
	 DmcSB802/V1W+aIM34Cy/DOUTU7EdkSt4PvHkKGYWPojrYM14/A8QOH4sZLzY9i/oWGqQ
	 HqXQl1yUlcYMonkmfyBt3yOnW3uQDm8dQTJNZT2NRLo+hBWkvKsYpMWDt/aImdqOwog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DylHlhnLbbJiaHnChZ4MNuIpkseXw4m+y/UR6vnlJ4E=;
	b=1wjQzapsyXirFofo/oZgMsr6O4cqXTbnWFbHA3KBDxPp7P5qvxrO8zSe3bfDwiOaF5SP
	 iItjy/gPqvKh6bFZIWrH+yb9X45eZTlGO+osvnOx2Jbejf9XP0hEi+jDJx4bvbgn9hKmh
	 QGtsMZqduV5Y4CDZAKBP7HQ6Ol24WnPd5zBwS9rdDO5Hcc2wzfzuJ6tpIC6SDW5PIu3er
	 yUZ7YWbNM00O+Fs8MZaVYcUcPRWEIlzP13jOG6FSLhPTBLuH+ryVuuP6oGqHtt1Zbxag3
	 wRiyNQxvjot4j7eDU01kyPoLVrEBnH54tBMD/8g+HN8CrjMXvQGQzV4Q91v7QI56u0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oago6hGd;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ACA60ED0F8
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90ACA60ED0F8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oago6hGd
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e601800e58so51291705ad.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633847; x=1794238647; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DylHlhnLbbJiaHnChZ4MNuIpkseXw4m+y/UR6vnlJ4E=;
        b=oago6hGdnjOIx5XTp0DZvNjVaUlrg0LQPpSxm/w24oTR7rwajXMsDeQQaxrgek4CS8
         dK7sPyUqDY6qQa5HBxvpzF94rj4fS2ymulzBA7fzAX8JddIi0PlT5w1TkD1v8k7rsQ8K
         YRPI/hftBhx5fCNBwUk6j2t6zbqpXtGHvMc7SzpCr72TuD4osg+qAQBBwMWWG4aTwTd4
         lYkroHC6UZ3Jq0RV5KL9YRgSRB9w5Baetgng60iA2WxOibzKMepnYsoimADIXiR5BwTn
         AqT7GMsoalgT4Qhb05P1foMFxGVzHb4F0tERye7P/2YvELSWGJtL82AMbFo7MXfkPDas
         rdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633847; x=1794238647;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DylHlhnLbbJiaHnChZ4MNuIpkseXw4m+y/UR6vnlJ4E=;
        b=eQmUHlzpmWxn1HcdGTFEb3QCx3akDt+AQUE9faVEcDBwCihjKVoxVScNKl1fl4cnfj
         xn4v8v6z5jzflDDsvGRQRGDTpIo6Hkb1YHml6vrXA970dNTqmuAKt9DVTVdXepSEFGjW
         sOYKAafVIYqlsGbSwEzoGNXAZk3F4az2LugGkb3Jj/jiuAMV9lJ2kgvKHn5RyzqzD9SY
         PiDi+4+IWIP6OhDsne6TTJqfhkBRlE/8m1w28hZ4HHIa+n05/Km8fLyuLPLRFEYqiXG0
         pdx6G7Pb36wMcybAE41GbfM1Jhe3+0fIDMJ/lVwg9/ls0R9GV4+TtjK12eMmnbtHMD9a
         clJg==
X-Forwarded-Encrypted: i=1; AKwUvBzsbEvPorFSHq7D3zXhR/E/4G2heKxRywj1WQPqDrvsPKXVjX9n69ZlQUJtU+zpbSvIWl0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OZxN/wzme4mZfhpSTOXVsrkONd4OfKx2+2iuwj92QOxnvmtL/
	+gP4qaUJDo9uYDSktzzU7m8x/upNcofLGTpKidV9uqKgtjti6g/HEnvCNRwkyXEn5jqkN9eHdzc
	cb/nzNubqPg==
X-Received: from pjsa21.prod.google.com ([2002:a17:90a:be15:b0:3a8:cbf9:5e52])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b02:b0:3ac:929d:ba5c
 with SMTP id 98e67ed59e1d1-3ae89847b50mr8027654a91.45.1793633846630; Mon, 02
 Nov 2026 07:37:26 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:54 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-26-vipinsh@google.com>
Subject: [PATCH v6 25/27] vfio: selftests: Add vfio_pci_liveupdate_kexec_test
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Add a selftest to exercise preserving a vfio-pci device in noiommu mode
across a Live Update. For now the test is simple and verifies that the
device file can be preserved, retrieved, and bound to iommufd in the new
kernel. Subsequent commits extend this test to verify that the device
cannot be opened through VFIO during the Live Update and that DMA
continues across it.

This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
manually along with a kexec.

The kernel must be booted with vfio.enable_unsafe_noiommu_mode=1 and the
target device must be bound to vfio-pci in both kernels. In the new
kernel, the preserved device must be bound to vfio-pci without first
being bound to or unbound from any other driver. This can be done during
boot, e.g. with vfio-pci.ids=<vid>:<did> on the kernel command line, or
manually before running stage 2:

 $ echo vfio-pci > /sys/bus/pci/devices/0000:00:04.0/driver_override
 $ echo 0000:00:04.0 > /sys/bus/pci/drivers/vfio-pci/bind

To run this test manually:

 $ ./vfio_pci_liveupdate_kexec_test -s 1 0000:00:04.0

 $ kexec ...   # NOTE: Exact method will be distro-dependent

 $ ./vfio_pci_liveupdate_kexec_test -s 2 0000:00:04.0

Do not unbind the device from vfio-pci after kexec (e.g. by running
setup.sh on a device that is already bound to vfio-pci), as unbinding it
would reset it.

This test is considered passing if all commands exit with 0.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   4 +
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 102 ++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index ece2a3618f2b..7010a243a0b7 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -15,6 +15,10 @@ TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
 TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
+# This test must be run manually since it requires the user/automation to
+# perform a kexec during the test.
+TEST_GEN_PROGS_EXTENDED += vfio_pci_liveupdate_kexec_test
+
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
 TEST_FILES += scripts/run.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
new file mode 100644
index 000000000000..4919175c1173
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <fcntl.h>
+#include <libliveupdate.h>
+#include <libvfio.h>
+
+static const char *device_bdf;
+
+static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+static char device_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+
+enum {
+	STATE_TOKEN,
+	DEVICE_TOKEN,
+};
+
+static void check_noiommu(const char *bdf)
+{
+	const char *cdev_path = __vfio_pci_get_cdev_path(bdf, true);
+	int fd;
+
+	if (!cdev_path)
+		ksft_exit_skip("Device %s is not bound to vfio-pci in noiommu mode\n",
+			       bdf);
+
+	fd = open(cdev_path, O_RDWR);
+	if (fd < 0)
+		ksft_exit_skip("open(%s) failed: %s\n", cdev_path,
+			       strerror(errno));
+
+	close(fd);
+	free((void *)cdev_path);
+}
+
+static void before_kexec(int luo_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int ret;
+
+	check_noiommu(device_bdf);
+
+	iommu = iommu_init(MODE_IOMMUFD_NOIOMMU);
+	device = vfio_pci_device_init(device_bdf, iommu);
+
+	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
+
+	session_fd = luo_create_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static void after_kexec(int luo_fd, int state_session_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int device_fd;
+	int stage;
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	VFIO_ASSERT_EQ(stage, 2);
+
+	session_fd = luo_retrieve_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	device_fd = luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);
+	VFIO_ASSERT_GE(device_fd, 0);
+
+	iommu = iommu_init(MODE_IOMMUFD_NOIOMMU);
+
+	/*
+	 * This will invoke various ioctls on device_fd such as
+	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
+	 * that LUO actually handed us back a valid VFIO device
+	 * file and not something else.
+	 */
+	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
+
+	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
+
+	vfio_pci_device_cleanup(device);
+	iommu_cleanup(iommu);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	snprintf_assert(device_session, sizeof(device_session),
+			"vfio-lu-device-%s", device_bdf);
+	snprintf_assert(state_session, sizeof(state_session),
+			"vfio-lu-state-%s", device_bdf);
+
+	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
+}
-- 
2.56.0.317.g454f8302e1-goog

