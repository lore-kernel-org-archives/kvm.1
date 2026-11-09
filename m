Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258518;
	b=yzBTPSsJ32a14KUz9ICHL0NokLTyAgxydAolCOX4Ezz1qT26fSrGBZ7Eo3q8dfKgzitA
	 jW0jf5NCHaCgLXLkJkHUIbxoEEIhkeO44ToMW6GPYzvAwqrsJkajbm3VQTUogliW5FoRm
	 F+ZQhH/lE8FFaU7RFrnkLDuJL4I4XWl3cu1pMN2uhU66SfnNHPLtwmBe5I0zif3L/BxZx
	 O/uM2PMfyyIgM9wU5P7KF3x1oVnziDw1nKGUqqTHv3nTPrCDv62PgyvjBoVuWF7ibPHwY
	 KY6ZocFJYdsV5RH+y27ig/SY4FO220o5DI5qE9pSuC7BAQZ+b/qMB3BS0HbGtGoGR3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Wc3v0zDLQNZsX59+/2NLOwIAwwWUHbHnHe4yzRQDYGo=;
	b=hPpQQ3fulDgDtB/LhW5u3qLPresy0SIffmQYf/zhI4IhogZValbqrzVHResHEjMWZAp9
	 0ttkyBHcmfDgEGLqc4xZaSv2YocFM9hZQe0V5n/PnEjku4AGL7U4bBB9QYdlc1rd29eJ1
	 TAjXufjFB2H4CAfo4dkArCQ/LoQIfu4MVgnLdei+oWhhqGsOZf1IFjTtCZjMCz6qH/oUb
	 QY30YUPY059wyKKTcn9NSpI/mFcZx/gFNpaKvMNXEU5569YpYLsS4cpMl89SsCvbrrZaU
	 BhOybUHDq5Q2AZg9fzAe0cKcjaGybuRQQYD6d707ke72JfrXM1XgoY7uv53AAj3oPDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kb9hTR1h;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EF60A260E
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 21:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA3EF60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kb9hTR1h
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b2d1eb484aso1764507b6e.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 13:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794258517; x=1794863317; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wc3v0zDLQNZsX59+/2NLOwIAwwWUHbHnHe4yzRQDYGo=;
        b=kb9hTR1h/1Y5dHpmJtZKnaeV7K+eOzoQedgl2bz9vXaxamcZj4hdumq66xPqaydxxl
         KFMRCUBi/jFkq0FhKSBRRS1YPvDWIzjGUSl/a5CzSkRlc29zEksCi9fUcIJ8wMPpbYTu
         ZkaBIXT/E1Jzg0KQP9a24RlcmEkgems3HzpYEmlJxq9ccwJwXVprTw5iA+RCEWkWsuMY
         730upIrR9oQRjyp9bvXvSauPS+AaAVaEOhw9/pC6hWhh/tZnAnE8fLq3aFgTWPlC5iPk
         k7cWXsWUYqK89PhBhT9+PeCPGRu7MJri+51T6++EOlyFkPtTn0760NvkfxaY72fS+qoV
         X3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258517; x=1794863317;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wc3v0zDLQNZsX59+/2NLOwIAwwWUHbHnHe4yzRQDYGo=;
        b=EqJT3kra43ZRQ2+xhg8xMPe0qebGPKJlLzLEV5lBwYBONUYwKCBhRCHuAuqnckyF/t
         vmlTXUgQffrsJsObLyiEARo6ovHbmXIko2n5zQ8rVoIVaKaTVKcBXR8zy0XS7fg3/lmF
         96TjA85jOA6O/o2YIRkt2TDcVpeeqial/NYPQ2+qU4R8Atr2DNn6qDVavXTi1Jp44vfw
         lsXgLLll6PQmeACQwSB2LAjc92fFF2olpZ4+TTmugfD+tpqfGmHlGbQxZa2VwbM4HQkm
         F9Btod2FdcKPbiTYj4MpSuLUMRlP3jETRBesBRtwF10x53qQYI+l3BQLzmHEL8TFGtnC
         EE3A==
X-Gm-Message-State: APuU4Z9wlxnS6rvRVPTiuaFtcwQu8y4313RSquOJDZDFQ1DlE4FwTG6f
	/KDLAkIBifP8c1Hi/X/3zvM7KunZFBpxuWMXOMAE6DMoBTR6lv+M+UdlC0JiT6oulH1hYt3Qky1
	VzYsFZOGqgZG1nFxqfzYu0c7XSnMYsQ1ByBWaE3qxM/bP3T9pYwfX7/cs7X8vGT8ZcntsPdQTrT
	0Plc0kDv2xcKgTeAR9U24Ou3paPIiZVN0w0LFCg2sF4V8=
X-Received: from iojj9.prod.google.com ([2002:a05:6602:8209:b0:9e3:4a8f:6258])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6711:b0:4ab:230c:5faa with SMTP id 5614622812f47-5683cc09d2emr526949b6e.18.1794258516355;
 Mon, 09 Nov 2026 13:08:36 -0800 (PST)
Date: Mon,  9 Nov 2026 21:08:29 +0000
In-Reply-To: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261109210833.1250548-2-dmatlack@google.com>
Subject: [PATCH v3 1/5] vfio: selftests: Automatically detect the IOMMU mode
 in iommu_init()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Pick the most preferred IOMMU mode that is available on the current
system when iommu_init() is passed a NULL mode, rather than always using
iommufd. Drop the global default_iommu_mode and convert its users to
pass NULL to iommu_init().

iommufd is an optional feature, and VFIO's iommufd support additionally
requires CONFIG_VFIO_DEVICE_CDEV. Hardcoding iommufd as the default
causes tests to fail with an unhelpful assert on otherwise functional
kernels that only support the legacy VFIO container:

  tools/testing/selftests/vfio/lib/iommu.c:448: Assertion Failure

  Expression: iommu->iommufd > 0
  Observed: 0xffffffffffffffff > 0
  [errno: 2 - No such file or directory]

Order iommu_modes[] by preference: iommufd, then the VFIO container,
then iommufd's VFIO container compatibility modes, with type1v2 ahead of
type1, i.e. prefer iommufd, the native VFIO container over iommufd's
emulation of it, and type1v2 over the older type1. Consider a mode
available if its container (or /dev/iommu) can be opened and supports
the mode's IOMMU type. Also require VFIO device cdevs for iommufd mode
and VFIO groups for container modes, since that is how the selftests
access devices in those modes. If no mode is available, fail with a
message suggesting that VFIO or IOMMUFD may not be loaded and enabled.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/aiIG2L_KdPwuxYA1@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  6 +-
 tools/testing/selftests/vfio/lib/iommu.c      | 83 ++++++++++++++++---
 .../selftests/vfio/vfio_pci_device_test.c     |  4 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  2 +-
 4 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..53e38130c334 100644
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
+ * Pass NULL for iommu_mode to use the most preferred IOMMU mode that is
+ * available on the current system.
+ */
 struct iommu *iommu_init(const char *iommu_mode);
 void iommu_cleanup(struct iommu *iommu);
 
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..ecdfbb62ac5e 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -20,14 +20,18 @@
 #include "../../../kselftest.h"
 #include <libvfio.h>
 
-const char *default_iommu_mode = MODE_IOMMUFD;
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
@@ -35,8 +39,8 @@ static const struct iommu_mode iommu_modes[] = {
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
@@ -45,16 +49,72 @@ static const struct iommu_mode iommu_modes[] = {
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
+static bool iommufd_probe(void)
+{
+	/* iommufd mode requires VFIO device cdevs (CONFIG_VFIO_DEVICE_CDEV). */
+	return !access("/dev/vfio/devices", F_OK) &&
+	       !access("/dev/iommu", R_OK | W_OK);
+}
+
+static bool vfio_container_probe(const struct iommu_mode *mode)
+{
+	bool available;
+	int fd;
+
+	/*
+	 * Container modes, including the iommufd_compat modes, access devices
+	 * through VFIO groups (CONFIG_VFIO_GROUP). Check for them explicitly,
+	 * since iommufd provides the compat container even without VFIO groups.
+	 */
+	if (access("/sys/class/vfio", F_OK))
+		return false;
+
+	fd = open(mode->container_path, O_RDWR);
+	if (fd < 0)
+		return false;
+
+	available = ioctl(fd, VFIO_CHECK_EXTENSION, mode->iommu_type) > 0;
+	close(fd);
+	return available;
+}
+
+static bool iommu_mode_probe(const struct iommu_mode *mode)
+{
+	if (mode->container_path)
+		return vfio_container_probe(mode);
+
+	return iommufd_probe();
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
@@ -425,7 +485,8 @@ struct iommu *iommu_init(const char *iommu_mode)
 
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
2.56.0.506.g506a7eabc5-goog

