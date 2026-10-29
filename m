Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312233;
	b=X86+16yT1QSVHI7R6tgF9izWX/U2kag9jOAv5U3RRPmqp3TOPgXUBAItH9ULODV2NcQ4
	 KN5qftDS3MEnR3gLPWErJdy+YpLfpyvE4DabRb8vUuLo1oH+NONdAG02gE2i+1LDRE79Y
	 OQEcNoNeKAQeyvIW8hsRzqoTdtWPgMdp/tCEjOe0X18Vv/uOc2rSiYpwKSYCUfUhrNYjk
	 /Tfzd3yriOqJK67ZfNbEIOmX/Knmufml0Xw7cJutUC130qp3uzm751FAJ/vdeyj01hwFp
	 o6i9nS4yOpJJ8rqvqct+zEBvFtc9Hko6bmq9Z6P+mmtv7815Ul/ndwL+ErwJ46xrL/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ouJHbOPegYJyyV7wPPM8sllPHyXb/2gIj9mMute0iW4=;
	b=ZqNl8h3TjeF9ZBXd622CLsqekOznHdfpGHDZx272+Bp4wOqSc8RTgfpBu4pYxYsEDB2L
	 8X64Z07W6IVhXcKEz0KIHUs9tozdOK5o5LSU8JQyWogqxeKQc7n/eWggXdMZRDB+J8xpL
	 uJUlAqa8sSVwXwHOhV7NZTMRKna+h+rVeVF0zicf4u2dbvo6dNcEWxcouW5JAkv0474Rq
	 qH8ojDS/PJiA0JJ5bzwux8mY1/EQ85y1aG0sVxH5dKunDcsXraubyDCnzQLMDzZr1dfJN
	 Ksn+nnFzeKLcUCJ1NT/Ispo5feaED3xxotmqinXruhObp0UJuPdr+1N81dv+2liks3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9cXB0Sb;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D976606A327
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 22:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D976606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9cXB0Sb
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eb2437d752so1807845ad.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793312232; x=1793917032; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ouJHbOPegYJyyV7wPPM8sllPHyXb/2gIj9mMute0iW4=;
        b=Y9cXB0SbfSc8P13klT3t978msTdYuNkmjVPItWtarrBrJgHRgPtg6pV5DUSZlErNOw
         wlyA5alugU8nd+tlBTrgjDmqX86UYUJs6tCMrJHGbXeTRx2Is96zKBKTHl3fTJH/RDIR
         97oAuyz313QYdebqxcd2KG+OQJPMTjIOhWFtIYf/QQxtcRb7us61dMuYFLZP8dLJ57wA
         t7pF3K/KjkINbxbhxhFoU81qDiJMJTV+AFwb7q51ybeWpgPtcXos591VXCwXrNAbfI/W
         LFfB23hl6MYHK0ajcwKRuNOu2nIqM1cSVg1b3i6u+8W2Tm+uoUgGcE3rX5uGQUair3Xj
         Tnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312232; x=1793917032;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ouJHbOPegYJyyV7wPPM8sllPHyXb/2gIj9mMute0iW4=;
        b=yX9QDZSAbHI01sND5mPPdNzfFTp5p/QkUAYhTqLfzUSH+RwXcSHMz3NFue0JmDEG0u
         RbXv4uDlCibaF4CcgtIp7bvSKbLSKhr8veDVVgN8lyo6XQbfuA8EveC72G5R4oe6RyHU
         JinzIIp9QNeZYJ4RlJv5poJCtFvFKXbOCMIaHDrd2UzmaAnzMm0Sl/Q6znvD1jRofj/O
         GnSt1W+eOMH0CJjxJJt/rWpwsYR+aowLZ4f9dSORHoDUDZEA5jdugzZe2WEO50W/4UzJ
         vrIXQRE9/UBw6xuNCAGF5FkmpzDloANRaYoh2xgf4E3iUNzeUFpYvNZj3GxT/zROy3Wm
         EamQ==
X-Gm-Message-State: AFq9FYJvGH41VYe7uZ5TBTnTkiuF+Z/YYFwCntWAlcTjaYgcNfHGfxyE
	nag8nwhLIzVO390IyW9MjLimNs36uwoAXCt7oRQcJEAVQwmZ0rJOdF5ZB7hB+rLcwSZd2RAd76P
	uJfG5CaI5gUci2pJVdod+B6nKYrkLisKzbXDtTCtoKu8aopqNwBhm3uBl2MNhtPV8M11DRYaRD9
	S/Q1ZJhRuKtQrjBN5W0c9Lzt8idLxumfIivBJWt6EXgvE=
X-Received: from plgu14.prod.google.com ([2002:a17:902:e80e:b0:2e6:e1e:5217])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41d2:b0:2e9:53c2:760 with SMTP id d9443c01a7336-2eb364cc505mr6399365ad.30.1793312232190;
 Thu, 29 Oct 2026 15:17:12 -0700 (PDT)
Date: Thu, 29 Oct 2026 22:17:08 +0000
In-Reply-To: <20261029221710.1871112-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029221710.1871112-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029221710.1871112-2-dmatlack@google.com>
Subject: [PATCH 1/3] vfio: selftests: Automatically detect the IOMMU mode in iommu_init()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Automatically detect the IOMMU mode that is most likely to work on the
current system when iommu_init() is passed a NULL mode, rather than always
using iommufd. Drop the global default_iommu_mode and convert its users to
pass NULL to iommu_init().

iommufd is an optional feature, and VFIO's iommufd support additionally
requires CONFIG_VFIO_DEVICE_CDEV. Hardcoding iommufd as the default causes
tests to fail with an unhelpful assert on otherwise functional kernels
that only support the legacy VFIO container:

  tools/testing/selftests/vfio/lib/iommu.c:448: Assertion Failure

  Expression: iommu->iommufd > 0
  Observed: 0xffffffffffffffff > 0
  [errno: 2 - No such file or directory]

Order iommu_modes[] by preference and pick the first mode that is
available. Consider a mode available if its container (or /dev/iommu) can
be opened and, for container modes, if VFIO_CHECK_EXTENSION reports
support for the mode's IOMMU type. iommufd mode additionally requires VFIO
device cdevs. If no mode is available, fail with a message that explains
why.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/aiIG2L_KdPwuxYA1@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  6 +-
 tools/testing/selftests/vfio/lib/iommu.c      | 67 +++++++++++++++----
 .../selftests/vfio/vfio_pci_device_test.c     |  4 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  2 +-
 4 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..fb0a681ecc72 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -15,8 +15,6 @@ struct iommu_mode {
 	unsigned long iommu_type;
 };
 
-extern const char *default_iommu_mode;
-
 struct dma_region {
 	struct list_head link;
 	void *vaddr;
@@ -32,6 +30,10 @@ struct iommu {
 	struct list_head dma_regions;
 };
 
+/*
+ * Pass NULL for iommu_mode to automatically pick the mode most likely to work
+ * on the current system.
+ */
 struct iommu *iommu_init(const char *iommu_mode);
 void iommu_cleanup(struct iommu *iommu);
 
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..535e6c7cf260 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -20,14 +20,15 @@
 #include "../../../kselftest.h"
 #include <libvfio.h>
 
-const char *default_iommu_mode = MODE_IOMMUFD;
-
-/* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
+/*
+ * Ordered by preference, i.e. iommu_init(NULL) picks the first mode in this
+ * list that is available on the current system.
+ *
+ * Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES().
+ */
 static const struct iommu_mode iommu_modes[] = {
 	{
-		.name = MODE_VFIO_TYPE1_IOMMU,
-		.container_path = "/dev/vfio/vfio",
-		.iommu_type = VFIO_TYPE1_IOMMU,
+		.name = MODE_IOMMUFD,
 	},
 	{
 		.name = MODE_VFIO_TYPE1V2_IOMMU,
@@ -35,8 +36,8 @@ static const struct iommu_mode iommu_modes[] = {
 		.iommu_type = VFIO_TYPE1v2_IOMMU,
 	},
 	{
-		.name = MODE_IOMMUFD_COMPAT_TYPE1,
-		.container_path = "/dev/iommu",
+		.name = MODE_VFIO_TYPE1_IOMMU,
+		.container_path = "/dev/vfio/vfio",
 		.iommu_type = VFIO_TYPE1_IOMMU,
 	},
 	{
@@ -45,16 +46,56 @@ static const struct iommu_mode iommu_modes[] = {
 		.iommu_type = VFIO_TYPE1v2_IOMMU,
 	},
 	{
-		.name = MODE_IOMMUFD,
+		.name = MODE_IOMMUFD_COMPAT_TYPE1,
+		.container_path = "/dev/iommu",
+		.iommu_type = VFIO_TYPE1_IOMMU,
 	},
 };
 
-static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
+static bool iommu_mode_probe(const struct iommu_mode *mode)
+{
+	const char *path = mode->container_path ?: "/dev/iommu";
+	bool available;
+	int fd;
+
+	/* iommufd mode requires VFIO device cdevs (CONFIG_VFIO_DEVICE_CDEV). */
+	if (!mode->container_path && access("/dev/vfio/devices", F_OK))
+		return false;
+
+	fd = open(path, O_RDWR);
+	if (fd < 0)
+		return false;
+
+	available = !mode->container_path ||
+		    ioctl(fd, VFIO_CHECK_EXTENSION, mode->iommu_type) > 0;
+
+	close(fd);
+	return available;
+}
+
+/* Returns the most preferred IOMMU mode that is available, or NULL if none. */
+static const struct iommu_mode *iommu_mode_detect(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(iommu_modes); i++) {
+		if (iommu_mode_probe(&iommu_modes[i]))
+			return &iommu_modes[i];
+	}
+
+	return NULL;
+}
+
+/*
+ * Returns the IOMMU mode with the given name, or if iommu_mode is NULL, the
+ * most preferred IOMMU mode that is available (or NULL if none).
+ */
+static const struct iommu_mode *iommu_mode_lookup(const char *iommu_mode)
 {
 	int i;
 
 	if (!iommu_mode)
-		iommu_mode = default_iommu_mode;
+		return iommu_mode_detect();
 
 	for (i = 0; i < ARRAY_SIZE(iommu_modes); i++) {
 		if (strcmp(iommu_mode, iommu_modes[i].name))
@@ -425,7 +466,9 @@ struct iommu *iommu_init(const char *iommu_mode)
 
 	INIT_LIST_HEAD(&iommu->dma_regions);
 
-	iommu->mode = lookup_iommu_mode(iommu_mode);
+	iommu->mode = iommu_mode_lookup(iommu_mode);
+	VFIO_ASSERT_NOT_NULL(iommu->mode,
+			     "No IOMMU mode available. Is VFIO (or IOMMUFD) loaded and enabled?\n");
 
 	container_path = iommu->mode->container_path;
 	if (container_path) {
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 93c11fd5e081..59a7c1f71804 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -29,7 +29,7 @@ FIXTURE(vfio_pci_device_test) {
 
 FIXTURE_SETUP(vfio_pci_device_test)
 {
-	self->iommu = iommu_init(default_iommu_mode);
+	self->iommu = iommu_init(NULL);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 }
 
@@ -121,7 +121,7 @@ FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
 
 FIXTURE_SETUP(vfio_pci_irq_test)
 {
-	self->iommu = iommu_init(default_iommu_mode);
+	self->iommu = iommu_init(NULL);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 }
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 9538a3a436a6..f8f99ee6bb1a 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -255,7 +255,7 @@ static bool device_has_selftests_driver(const char *bdf)
 	struct iommu *iommu;
 	bool has_driver;
 
-	iommu = iommu_init(default_iommu_mode);
+	iommu = iommu_init(NULL);
 	device = vfio_pci_device_init(device_bdf, iommu);
 
 	has_driver = !!device->driver.ops;
-- 
2.56.0.317.g454f8302e1-goog

