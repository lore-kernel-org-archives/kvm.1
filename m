Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665330;
	b=BrSw8Lj8CZ4e9WXO4rx6keZS/IfEj3xeWf27vC/pdN3Pi695RDPtX2R77h7XWX6OmauN
	 KSYtR37bJmzcpNcxVetfsTh17/prLleb2X9RSk25RBiUcfbATWc9H2Bvekw6TDmockMuY
	 xyYnmYCufy9ErIX9WmSuvIBAm/VZmlw4EZjXGHWuKXONPf9d143HFywpvdsxw3ih3xi4M
	 SEB9osSLXzWwFVVP6WeSs3MkBbICNU+X3RCI4m3EX1dTFRmw5KLD5b77hqD0ysYz9ndIe
	 ox/DzXdjP4fdsyZ9ZdmtUiXgM3i+fb0aIdm9ePpuYHHzYEiek1XJiHnaN4j6D5Ssdaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pIASfKPjIb2LduUxIK7s8yVTxHYx7T5trSnbPflAmMA=;
	b=RGkpJZxNHgw6pqXCFBlLTNNayjXvDIrrwqdDO8nxdH9yOkNXVvsuvJ7JPuATsbd33ud7
	 75JTeaMk/A4UBdqdr93u0y86F/PR0lOPvSufR4tKOrPg/5utpaF5U6ZPUqhiGM8mI0A1E
	 YBd+b74iUoqalA9YuOFshPymAzHAPWhyGhckhpQzgZlFiqDo0G+Jh4AXcnCPBFpfHdbQD
	 uZuaSDJOXdc035X7tPnqFdRwn3CJkmdoP/THtSjmecOYZZcCv+B9Uzo5lujrE5coJUaSb
	 otRVwpQc3pnDbQhCCnwap6gz56UAdSeQwkXlQPJKd1xoqzYGA+iSc5w3ZV/si4zV3Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AhKOcnHD;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E0606A32E
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C88E0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AhKOcnHD
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaf8ea208bso33361855ad.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793665329; x=1794270129; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pIASfKPjIb2LduUxIK7s8yVTxHYx7T5trSnbPflAmMA=;
        b=AhKOcnHDkDJ0QsDxLGOwhe2LH85eB4f2vHVSC/dnSUQgX+UBPgtSRzmKqXKXVlgOIc
         NVlI10bJdzwCbCSw3p2e4O0Euzzz/Bog+5hcZcyVChuICx49EI6UaCuLQV2BefXxaj8I
         3GnK4+cEF6baJYpH6SqPSk9Vtc9osKi3g/bbg7HcBSLvwOb16Y6U4XpOH5n8YJ4Qk9mB
         7kKqotOGiXkT7WIJK6R0c2V6gpbe0lNAdDvXPxo0Y2eMkAayrF+BHA50zo7yRIuOrvkD
         HC3xKGNVPYKwc0NC8fDYpZzXPPb5Tm8L4j2TMh4XvYcinDm2b8ZtMMf5T/+WHi3ZSTMe
         RbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793665329; x=1794270129;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIASfKPjIb2LduUxIK7s8yVTxHYx7T5trSnbPflAmMA=;
        b=Dx+o0q2unEOgioSh7buFuihC9tQGVR7rUeCAPTJNYflFfwMiIvTWkpHR9fOR64ANZd
         To1T3q0D4e55Y2PotV4ASwRNAoBRH+AYaNRi/Dctj3srCnAaT/sGgwAaL+Ii2d7NnhxM
         85FRYkDcxlwzGZnWTX74FO7NbOsg4SUeP4dR/HQyfrq8PN16NpPFmun8FCww9PrvZ9+T
         2NclzPiExsHeVM0K7aDQGdc0y0wCS4O3CPVPhg4fcpE8OjQtb165mnhokRvRu+z6gsAr
         UuGkagT3+GjuLwOjnbyZmY3TWkYAJkx/sp36cIdfwv7mekJhVflFKkWM9FZqNGohU74n
         u1/g==
X-Gm-Message-State: APuU4Z/4rVhsPTrE5v0SVxaLgLkY26a1lCT/h0dPefj/IoOVTR5aDHtM
	tKONR0naaNGG3//fCSqjf0l4VwHjjjAxVpQPyu2NXTTD8OQh0qYjXFz0TS8fNSQXtvDPcuehBZs
	TQ7XvYMpmrcIu6MoOisPNFZbq3ob3d8ITJ02Y8rPBtxAoGh/fc8fjwWULPIJ+uuFqsYJzJft2Dc
	FUHdJeVuOFa2InZyNRuhX8Z+LQzbh7rW2R7u4ywOWFZTI=
X-Received: from plhq17.prod.google.com ([2002:a17:903:11d1:b0:2e9:64c:38da])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:98c:b0:2e9:660a:7946 with SMTP id d9443c01a7336-2eb3644726bmr100250055ad.28.1793665328971;
 Mon, 02 Nov 2026 16:22:08 -0800 (PST)
Date: Tue,  3 Nov 2026 00:22:01 +0000
In-Reply-To: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103002205.3348519-2-dmatlack@google.com>
Subject: [PATCH v2 1/5] vfio: selftests: Automatically detect the IOMMU mode
 in iommu_init()
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
 tools/testing/selftests/vfio/lib/iommu.c      | 68 ++++++++++++++++---
 .../selftests/vfio/vfio_pci_device_test.c     |  4 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  2 +-
 4 files changed, 64 insertions(+), 16 deletions(-)

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
index b6f3c5c84e01..0393536370e7 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -20,14 +20,19 @@
 #include "../../../kselftest.h"
 #include <libvfio.h>
 
-const char *default_iommu_mode = MODE_IOMMUFD;
+/* Message to print when no IOMMU mode is available on the current system. */
+#define NO_IOMMU_MODE_AVAILABLE_MSG \
+	"No IOMMU mode is available. Is VFIO (or IOMMUFD) loaded and enabled?"
 
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
@@ -35,8 +40,8 @@ static const struct iommu_mode iommu_modes[] = {
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
@@ -45,16 +50,56 @@ static const struct iommu_mode iommu_modes[] = {
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
@@ -425,7 +470,8 @@ struct iommu *iommu_init(const char *iommu_mode)
 
 	INIT_LIST_HEAD(&iommu->dma_regions);
 
-	iommu->mode = lookup_iommu_mode(iommu_mode);
+	iommu->mode = iommu_mode_lookup(iommu_mode);
+	VFIO_ASSERT_NOT_NULL(iommu->mode, NO_IOMMU_MODE_AVAILABLE_MSG);
 
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
2.56.0.385.gac671c819a-goog

