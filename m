Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306010;
	b=CLSQV9cAjZh3N56sC+ckQK0SsxGn4IpUHcZ+dakXliDlsf/s5EuKXjx+6o/AKDFkiwcb
	 UlA4ySPn4P13n9wDzlitasPoFS3N1PtUcIvc/BvtIyxU9ys6RlO7lSw6Z5QuKdiznn8OK
	 7DaK0BNWKQW0sLNOdfMi6goqP+lzEStERPqlOJ7jg8s5dSEKUIilbEDimu8+52S1kyv+q
	 BS2wUTuGsbU/gekZRlQq361tMIA4SDEfDPru9la2imE8NtPHF4p6Xuv3HijUhQ4wCg8wB
	 6zMtdzvn7fcQj4MiNtF7HE4gEGlRMjTNG99UIFozC06nMbirmvdjl0kvzuFBNw96QQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=tDfMnHPOVxE98+9TE/nBvfLsdX5oZKXJTQxV9ofrPB8=;
	b=LvYRyL1iml9CIG8tPL4PaQn2H5np5fnuwLFLTTLYQNuf213Ftw5f45Fy0XjnXB/ZG/vg
	 157DXgmCnq4jjFan5F9f5zA6z/7+NCHaiprKj1LGIsR9q5J3JPCAFqP9oxGMqXCi2Ghjm
	 VcMtAfFcPpNZoxZZpKP8tVEkcpOFDqUy/+JtN/q03MEJRdMf4xIe6tnbfxZ2kug4pDYxG
	 3hUm6Cz8UXKZQV/TacvBldLOpds4oN4b5PqwZqZIr4ASx+S2bDzhz3axa+qaOrBhiAEGh
	 I0y7NKVGWxBw5pzuBbNgzeHuD6hwpAj/RWhWbmUBDH6nLUW7rPKCNDvwArX04PfPMNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jVFy5+f3;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75E606A334
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA75E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jVFy5+f3
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ada8bc8575so4430198a91.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793306009; x=1793910809; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDfMnHPOVxE98+9TE/nBvfLsdX5oZKXJTQxV9ofrPB8=;
        b=jVFy5+f39q99V15VIlErwgQ/W4JaK3puuVFnmWxDh5qTYdzYTJm/i5S26DvU74eokY
         dEBszj0wP7s60Ia5DwLR246rhtEnlUJLcrW89C+l/iTHE05Mgyua3tJU2eIIVEn7QGa2
         1tP7NcSxuZN+unp/iskwvxXQ1DN9j+EpgKQftNQ1WYbq/mOK4Q7833DHO/d3tcd2rg0y
         yHshEZmt8XPPm7p82kjx5mH6lZZMkBSmHaAzogxKryBwnvlU4dmXHUnd+h4jJyPAeX6i
         g1KvAV2uq3R4Ybl9rxrMFMQwuWvdlwGlpZPDprdmvJXJM0Tq5Na/aG/AruA+chpCVvcC
         oqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306009; x=1793910809;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDfMnHPOVxE98+9TE/nBvfLsdX5oZKXJTQxV9ofrPB8=;
        b=uv8+WsnZ6FD6ES9Ua+J5ghXtJ5nd4csce2S6rU93nC/VFUYZ+Y+R0xco/DgHa4MKUj
         66UzRWKy3X3JGuI5bCJPDZLZTMtmzbJT1/XmjH9VUaIHZqQO0axp/w9G+pqgy7H+qRc+
         LjJykFfYX6IIIU5NVBOOp0LuXLcL5M02FmdIgVdSTEue4Xjw7KhCnhNNszJFU1EdKqC8
         HfrNdh9qQm7u++5ihGawgaWUhJVm4DUwP5Vtqd9c7JJ9MJOTMNvf1sJnTtrd4SKDEbV/
         v7GdmyW9TIXZcMcikO5VBD7qrPvwnMJ4iNxUb36cyfbLmxVTi2bwl10SRDdmHL2NiYxY
         2Nbg==
X-Gm-Message-State: AFq9FYL5lr9pXpA6oqtaM87jlpwfpMz2Y3+ejQ6t/eoyZ+SrlFph465I
	uuDQo1+VPd7iFOBbLa+volJN2nDr9r/X94XbexevHWsaMne48whONfcXTDjDX7XLLOdYvndOSUz
	JepUC/EfdXZOlwcOr9O6FB5dqkIXOvvios4Dr90CBEBLYs4pRKA7QufNX80v1QxLsO5BDcW3Xg1
	94Xo1lVVS+ycKjxexDWT1qCg2ng+PTllKphq2hoGkU5Pw=
X-Received: from pjff12.prod.google.com ([2002:a17:90b:562c:b0:3a6:daac:15d1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3812:b0:3ad:183f:5e3a with SMTP id 98e67ed59e1d1-3ae89574cc8mr139687a91.4.1793306009170;
 Thu, 29 Oct 2026 13:33:29 -0700 (PDT)
Date: Thu, 29 Oct 2026 20:33:22 +0000
In-Reply-To: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029203324.1637772-4-dmatlack@google.com>
Subject: [PATCH 3/5] vfio: selftests: Add vfio_pci_find_capability()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a helper to find the config space offset of a capability in a
device's standard capability list, mirroring the kernel's
pci_find_capability(). Return 0 if the device does not have the
capability.

This will be used in a subsequent commit to locate the PM capability.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  7 ++++++
 .../selftests/vfio/lib/vfio_pci_device.c      | 25 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 007adc322c1e..1839e95cc792 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -79,6 +79,13 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
 #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
 
+/*
+ * Return the config space offset of the first capability with the given ID
+ * (PCI_CAP_ID_*) in the device's standard capability list, or 0 if the device
+ * does not have the capability.
+ */
+u8 vfio_pci_find_capability(struct vfio_pci_device *device, u8 cap_id);
+
 static inline void vfio_pci_cmd_set(struct vfio_pci_device *device, u16 bits)
 {
 	u16 cmd = vfio_pci_config_readw(device, PCI_COMMAND);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4063a0e2b3df..2afbc465d30c 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -260,6 +260,31 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 		       write ? "write to" : "read from", config);
 }
 
+/* Bound the capability list walk in case the list contains a loop. */
+#define PCI_FIND_CAP_TTL 48
+
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
2.56.0.317.g454f8302e1-goog

