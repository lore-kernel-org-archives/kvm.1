Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046523;
	b=R5YXVa/F+jKi12ZvkrmaENEcSwpcr4A5rdpNjA8xWj8rv8iWkhtcBbODfe7CJsc0UrKk
	 75pSgAu+nMbDlF9gc6vJr2RzQ1mOJ64jQ1Y2KN73h0jit0kbTA4zqBijRTmBPGWG7Lb4x
	 aCnM4FVX8kgLR5VtFTZgDfq5tVkhtypucw1wDOUuTWh5XEOMTU7hNUITZLt2Xgukhg0Ur
	 XI4DiGxat/aMSXVgd06XxKVYSMvFidfkIKOOuzojT2ec+wxIBsoCEqAx4SDxPwPjKQgM/
	 aJUPcK2fVbgXLGJOfJq2FfRdEcsuQtySk8jJ3+I9YJZMIq0kPpGMxoVYM5MhHTvsmyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BaZtfO6CzQ2Po4SKGuw9DGSmsKL7DH0DuthkzlazpWg=;
	b=oYXNYSJdnpfNAnmW5M9uVoCGJ3W54hCCVrOQ0dse0nwa01SykemPwheB4+7YJH6cCiYw
	 A7CDrgQKoLhGv91MBcZFjbPwsJjdz3kZZAGO/T5+4Rx6U6LbUVdjYNu8Jk7OItUczb0Lm
	 3TIoue5M/SpYMKlvqHMFLnpX0wHd9ZwxIbyPt35lJ+YwutYAz4doh+eaaqet5hnCjSV2i
	 0WijwVxdf65fomJuW2NutlMq4alAxW0BWDELTrJfaThJ+2+3+dotpIdsg4YOO1VjQQpV/
	 DpOuB/P3OLFHT4wW+7+VOW600ZSleRLZ/ftXKoI9I/p5mfQjYvdZDulRifac/mFtVmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ILkEpLVY;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873760A263E
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6873760A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ILkEpLVY
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-547ae874949so2097861b6e.2
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046522; x=1795651322; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BaZtfO6CzQ2Po4SKGuw9DGSmsKL7DH0DuthkzlazpWg=;
        b=ILkEpLVYaR5654XS38OGNXQBMXlCiUBeg+hdSKAlh5IrtH+TjD5Uxyw5tgeT2hkX/O
         Vs689Quc9TYn6zD0aPfle/MmwMJ92UF0r74KU66ocFQFpvTLer3NtsjGg9SBNjI/9o1U
         kMb7ED7/+pjUBED/9iZ8vJWL3nebQNVku9+xJ4Ji7ywch0aq8Bg72HCcXiF+1+VjZniQ
         l/wxGtAO4xmcdRhuN84JNBvUTTZlbc6iKiLiztHrM8d8usjMUo0YVvUGBP1RC29gMexg
         4VuoFg793aEGWgTBIkxGaEaoY5aH1yCYhwKJPMeHw7c5aRAO+8LszV7ZcUEbKreMtmd9
         Jn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046522; x=1795651322;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BaZtfO6CzQ2Po4SKGuw9DGSmsKL7DH0DuthkzlazpWg=;
        b=pK4GzoI44ySKkUHDYtrxNbDST/yYcXGHKlxKVB+w8zwcUJpRuUWLNrpi+Y0HAJ30P/
         cRZtAlhSGTxhP8/69pSYcrMbqWoaBbsWAhISte0VxcmDC3e/IXjdgcCpI2W7TcoQlZ6F
         K0ZGgp9XUi7A4dSXU4mzTwzGYjXu2u3qy4JyIy/h1cpekmzVehY4qHXHyN38h/ho6kWS
         a9k83RRFUlhNZeVtD42YUFMiddM7I39C6rADvCVr8PLdDzV40fidZ6+wSonfR5yCLtcv
         YEnyqowbQmtOLC2eWdnp/4i2enXJZ/+7yMHfLvou6P04ofoVQm693nKlbz2gd4s2yoGM
         +Cxw==
X-Gm-Message-State: APuU4Z95th4CoOX8YoToZhXEPE2ir+pjtat5h63D77ouR20yQV5Rb7rn
	IAG5ghQfUtcnI2e3p4szv3UGBgbEEmyUM2meIwEIZNHLJdwBXzgvBLSkgO7GnI31GLl/EXiOq8v
	6Ebs1rqTbqPDhcD/aiApU9GzwKE6MSxVtUWvZdU1YaGDP5x7M1B99nV8pszMLBZ5DvJvBG4es96
	qYY+vX02rnD3pqHqsZ7p2OL+C2lQv4xpUJVd2b+FX5RS4=
X-Received: from iobp14-n1.prod.google.com ([2002:a05:6602:868e:10b0:9e3:4b87:936d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1925:b0:55c:888:30ff with SMTP id 5614622812f47-5774240c0a2mr5233137b6e.45.1795046521984;
 Wed, 18 Nov 2026 16:02:01 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:47 +0000
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
Message-ID: <20261119000151.442543-6-dmatlack@google.com>
Subject: [PATCH v2 5/8] vfio: selftests: Add vfio_pci_find_capability()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add vfio_pci_find_capability(), which walks a device's standard
capability list like the kernel's pci_find_capability().

This will be used in a subsequent commit to locate the PM capability.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  2 ++
 .../selftests/vfio/lib/vfio_pci_device.c      | 36 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 007adc322c1e..0fc03bb79448 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -79,6 +79,8 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
 #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
 
+u8 vfio_pci_find_capability(struct vfio_pci_device *device, u8 cap_id);
+
 static inline void vfio_pci_cmd_set(struct vfio_pci_device *device, u16 bits)
 {
 	u16 cmd = vfio_pci_config_readw(device, PCI_COMMAND);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4063a0e2b3df..ee3f76e2b874 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -260,6 +260,42 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 		       write ? "write to" : "read from", config);
 }
 
+/* Bound the capability list walk in case the list contains a loop. */
+#define PCI_FIND_CAP_TTL 48
+
+/**
+ * vfio_pci_find_capability() - Find a capability in a device's config space
+ * @device: Device to search.
+ * @cap_id: Capability ID to find (PCI_CAP_ID_*).
+ *
+ * Walk the device's standard capability list, like the kernel's
+ * pci_find_capability().
+ *
+ * Return: The config space offset of the first capability with ID @cap_id, or
+ * 0 if the device does not have the capability.
+ */
+u8 vfio_pci_find_capability(struct vfio_pci_device *device, u8 cap_id)
+{
+	int ttl = PCI_FIND_CAP_TTL;
+	u8 pos;
+
+	if (!(vfio_pci_config_readw(device, PCI_STATUS) & PCI_STATUS_CAP_LIST))
+		return 0;
+
+	pos = vfio_pci_config_readb(device, PCI_CAPABILITY_LIST);
+
+	while (pos >= PCI_STD_HEADER_SIZEOF && ttl--) {
+		pos &= ~3;
+
+		if (vfio_pci_config_readb(device, pos + PCI_CAP_LIST_ID) == cap_id)
+			return pos;
+
+		pos = vfio_pci_config_readb(device, pos + PCI_CAP_LIST_NEXT);
+	}
+
+	return 0;
+}
+
 int __vfio_pci_device_reset(struct vfio_pci_device *device)
 {
 	if (ioctl(device->fd, VFIO_DEVICE_RESET, NULL))
-- 
2.56.1.708.g77570a6a1d-goog

