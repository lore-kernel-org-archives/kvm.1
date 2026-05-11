Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C53CFF41
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543325; cv=none; b=nKKOyYSkJeic/N43QOelYxAxOzOWbQoW5KzNtWHTKBi2Fs1QZ3S0roWNCiGavVrJhigHB6o90d/Y6R2P+vh56uajDXEbnJvCob3yhYTz8ULYgRa+h5n7an9wDsEItGl3LwkyBY+cf16yI/pSwdxgCVXLet6fGrAWQ8qY67cB67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543325; c=relaxed/simple;
	bh=dUEtQv4m1bgdZfAKqo/nHhsJYCn9NG0HmQqPLRiSL/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sos0gUSlJ55Af5+LVDFMIi2KVVq//wK4ry2US62mKC40yxhZMIiSda62so81+HU4FKUm5veopakFqVis47ew8/cH7Mczl1W5/1ApmYp7IW9QBL6APBcXEH471od6rRFDC7jCMG2kJniWW3ZjwfiDuydyy8TvEK5dcNq128VWvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkx9oBQM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkx9oBQM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2babc42244aso91811905ad.3
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543322; x=1779148122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4gqIrYhtwiwQ5vr+LOFB75VLebAVjQ9EvxHYxdiZqo=;
        b=gkx9oBQMqa9+yB88wMg/S8LgSFCBHYQP5lUBp17/40OHZpQr3nnj2NRfewmyyMSv3/
         MlUPM5c+luLK7fcQqTQYqNDx/zi2xdACT8F9vm+d5oHIAENeAACjDzUR2Q2PRgC2HWM1
         R8ltKvgPGIzLTM05r/tCC3PTLiVVEzewIC+etLwew1Gq2R56qDxzbN0fMGiv4vZDFs21
         Hj0CK0keCWI6JMSidH6HZTvM6qy1jrGxM2xYOu6YfYxcovSQbUz92/7NN6dABS4kCvzZ
         F5RP/T5bJqZ3ctmjFZLu7vUxoFM2aw2fmsp25ins9ANmt0LQ8zugCAZ/kEJYXtazFNuH
         Y+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543322; x=1779148122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4gqIrYhtwiwQ5vr+LOFB75VLebAVjQ9EvxHYxdiZqo=;
        b=bCd0bTSgp7wC4Ll5mkUJ82ElpONXtfHMc2ZSxr9RPRaOmNNiibf/1eoJbtYq+/9huq
         nNcjJTnKRdPL5IK7zKOUCuLgly0CYKAeH5GbhymYHprSkPIE8eXbUKRKMu1c+WOub13R
         +3Ot90jAK9w+r87u6WlAfJUsU5HYY5qo3c4Etk75AjxoT5R3y7tSYxNIchufc3n0nJzB
         +3h2gxDrcpC1tYmREz0hFzaH65km4K9h0w9/FSXgMZQJYXCZST46tTbnFU0t+FTgYQUc
         5k5OQidkKXK3e4RXAJ3AejSEUaXbSTyLJwsrXlDt8PC1Fx+j+7Fyivcz6OiRpaucg1L7
         TN8Q==
X-Gm-Message-State: AOJu0YzwXk4ZIQod2qVMmFVCRpZdy+cZT0ahzI301gJLIMmTx/JIQKeU
	Jay0nsl/C4HQK2KQeU6EvzRl6ouqOXDUb5uXb4DbzCj0oemyD0f4qeSPvJveNisMFnh4IfFHxiR
	ZaW2gg4A3lpXWU07ffft91O7+kKKpw6/p//HFnegTOAST4iD/zM6uk7HqesF0awrY2W545b5wW3
	xVn4w8SVkgA+pzXOy2ESEbFJi0vAWm1pJeWN//jA==
X-Received: from plmk20.prod.google.com ([2002:a17:903:1814:b0:2ae:c50f:f4ec])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ed8b:b0:2b0:7531:b61e
 with SMTP id d9443c01a7336-2bd0135ec3bmr5062815ad.41.1778543321102; Mon, 11
 May 2026 16:48:41 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:58 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-13-vipinsh@google.com>
Subject: [PATCH v4 12/16] vfio: selftests: Add vfio_pci_liveupdate_kexec_test
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Add a selftest to exercise preserving a vfio-pci device across a Live
Update. For now the test is extremely simple and just verifies that the
device file can be preserved and retrieved. In the future this test will
be extended to verify more parts about device preservation as they are
implemented.

This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
manually along with a kexec.

To run this test manually:

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0

 $ kexec ...   # NOTE: Exact method will be distro-dependent

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0

The second call to setup.sh is necessary because preserved devices are
not bound to a driver after Live Update. Such devices must be manually
bound by userspace after Live Update via driver_override.

This test is considered passing if all commands exit with 0.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  4 +
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 89 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index ad081ec31fb2..17082a57aa9f 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -14,6 +14,10 @@ TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
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
index 000000000000..15b3e3af91d1
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
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
+static void before_kexec(int luo_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int ret;
+
+	iommu = iommu_init("iommufd");
+	device = vfio_pci_device_init(device_bdf, iommu);
+
+	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
+
+	session_fd = luo_create_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	printf("Preserving device in session\n");
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
+	printf("Finishing the session before retrieving the device (should fail)\n");
+	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
+
+	printf("Retrieving the device FD from LUO\n");
+	device_fd = luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);
+	VFIO_ASSERT_GE(device_fd, 0);
+
+	printf("Finishing the session before binding to iommufd (should fail)\n");
+	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
+
+	printf("Binding the device to an iommufd and setting it up\n");
+	iommu = iommu_init("iommufd");
+
+	/*
+	 * This will invoke various ioctls on device_fd such as
+	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
+	 * that LUO actually handed us back a valid VFIO device
+	 * file and not something else.
+	 */
+	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
+
+	printf("Finishing the session\n");
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
+	sprintf(device_session, "device-%s", device_bdf);
+	sprintf(state_session, "state-%s", device_bdf);
+
+	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
+}
-- 
2.54.0.563.g4f69b47b94-goog

