Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858826;
	b=IIzpBbHd0/2sqt1jnvmioAvIeVQ7yvqmce2MjA1kI6dPrK0nULmUCvd+6m1BRJbqclsc
	 SpVHjz9B80sejL1IUn1W3vzZ46zdqiMQMFXuketDPJBMLzo0H+Pzz4jk3l2lLrgrnLIAx
	 Z4VFVoCElKghEGRAQiG5upXqqL1kv4MM4YVV6rh8+qPwqC74tl+CWIFEEuIlZg2SOFsaj
	 MhmUvXNdwlFSDOP68Hev2evxUI7DnjOcGK5RPNVvVt8RQI2pWcDPbwNSwRsk4YmZGU1YQ
	 f8sGtOGTFX5a571IsN5FytqsilAw2zBTyTgcEwVcPdSl4EznqqMohQYadbrowlC4ibQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fBFp0Dqd4+rfz+AQXPTHj1LsbQffN11Ruos0UtGK1xw=;
	b=p3nd3i46+N+2E6yDCzf+aacS7PD4iYKONteN+iiEOTwpPCwr9oTzAwuCGtA8GD+g2yWb
	 GtK0cb1SI+6uCfNMeJKMteanGXmTqSSDp0woOVkYWLvjpgeUWQrOhEO3xWNsc88W77QqG
	 WE4Dqeb3sRZvKpgdP10KzfqDV7Yt0Wh3SKIiV32iWt+IZYGSiDnG9ptid0ZKaJYlLYAGt
	 wFH8yWabaXjil+RNIq+4R6VqQ9Xrqy/zL4aH8J736OD7V7im20sUYwBGtTIx7wrnV8ymD
	 dP6zSpPu5Fm8TfIabkW0tZlQUIM17jgyob1+C10ZOIqd+jLD2oCRlGqNp4NJEntDYkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZOoH6zoy;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78B606A326
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D78B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZOoH6zoy
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b027578a4so1658005f8f.3
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858824; x=1793463624; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fBFp0Dqd4+rfz+AQXPTHj1LsbQffN11Ruos0UtGK1xw=;
        b=ZOoH6zoyl/fz4M1RbS0KP27SPqoGpKAbBNvd0VZ1pwZU3Yi0BtI+zuRMgG2R7De6WT
         RUGYwQ6VdFUoG52TKhttLsUSV/IjZ+PEJF28Lb220wWRIF97Y7Lngr7PZO7cxwreSS69
         HK1p/RVdWZS56FTS79lwkshMro9FddDWXY9c65Sb4FuYis8gVqffSWyd06ndCpWxvs7A
         StG6eDcJ7vjCk6qYJB3fLALXAWM9VXhoGuJT53H5SNSUdP+LSQ1z3AE1M/+WLRh65Go9
         3B+eGOubzJ5qP3ZfVtT/5yoT/hZPp6axRkQyojOuq9C5kXLwNiVYBn0wiB+eXoKWjZuF
         pohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858824; x=1793463624;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fBFp0Dqd4+rfz+AQXPTHj1LsbQffN11Ruos0UtGK1xw=;
        b=NYEmXKaulDH/bThlClZo4IgioI5blbth8v89K80Kv3ztbxIPLHydQQUnp1PbozuiY3
         eRF/tPrBRhX2PNc7v1Q1xkT1CnTDVMZk8XYRICx71cC4ZXJzkkAdKyqUUDO6LXJNBg6h
         K1zBLrjYd3H13LltojvInq2b5afgZaenN2slvyowSoHRZqBnkYZQ1pTINj1hLW7eMi5n
         q5c4xf3MMtTrWmKbuLE8CSjNMJVnIeOpugGNc8mZmYT5ndUqDnK6bKraAwe1vPRlKLm3
         poPXJuSE5VpVUid9cpN1qS7avMm2V4xZqHOh+60Jw+gA70JSjuoJ8AYLg/3sZUv7iPaS
         vjjA==
X-Gm-Message-State: AFq9FYKKzmXIc9v6zJC2qeaav0T7AIqJRL06OwmFnjflKrj7kFR/HWSv
	N9MrdrdxycYF9le1CgxSS/g6jSM5uT8o/rL1M8AZ21V8ttBrUMoQIGV/w57nCIKhN4ctBYGUyui
	IQDsb3guwR1DS6PLMrXLGNvgdUiu4+Qun8TEjMwS0aBTawxQZ+hyETf+yWO0hX9hWgzraHP8FNY
	bNVHEfRweXb5KeXrHJdBnfTMNYVQNN/8iKb3SIrsc9nx0=
X-Received: from wmcq4.prod.google.com ([2002:a05:600c:c104:b0:4a1:dfb3:2e66])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8518:b0:4a1:a49e:a925 with SMTP id 5b1f17b1804b1-4a35acebf0bmr37415365e9.35.1792858823473;
 Sat, 24 Oct 2026 09:20:23 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:18:59 +0000
In-Reply-To: <20261024161902.2093581-1-smostafa@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261024161902.2093581-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261024161902.2093581-7-smostafa@google.com>
Subject: [PATCH kvmtool 6/9] vfio: Reserve guest address space for VFIO platform
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Assigned platform devices need guest physical addresses for their
MMIO regions.

Reserve an area called KVM_VFIO_MMIO_AREA.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arm64/include/kvm/kvm-arch.h   | 10 ++++++----
 mips/include/kvm/kvm-arch.h    |  2 ++
 powerpc/include/kvm/kvm-arch.h |  2 ++
 riscv/include/kvm/kvm-arch.h   |  3 +++
 x86/include/kvm/kvm-arch.h     |  2 ++
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arm64/include/kvm/kvm-arch.h b/arm64/include/kvm/kvm-arch.h
index e7dd526..cddb404 100644
--- a/arm64/include/kvm/kvm-arch.h
+++ b/arm64/include/kvm/kvm-arch.h
@@ -19,8 +19,8 @@
  * +-------+----+-------+-------+--------+-----+---------+---......
  * |  PCI  |////| plat  |       |        |     |         |
  * |  I/O  |////| MMIO: | Flash | virtio | GIC |   PCI   |  DRAM
- * | space |////| UART, |       |  MMIO  |     |  (AXI)  |
- * |       |////| RTC,  |       |        |     |         |
+ * | space |////| UART, |       |  /VFIO |     |  (AXI)  |
+ * |       |////| RTC,  |       |  MMIO  |     |         |
  * |       |////| PVTIME|       |        |     |         |
  * +-------+----+-------+-------+--------+-----+---------+---......
  */
@@ -47,8 +47,10 @@
 #define KVM_FLASH_MAX_SIZE	0x1000000
 
 #define KVM_VIRTIO_MMIO_AREA	(KVM_FLASH_MMIO_BASE + KVM_FLASH_MAX_SIZE)
-#define ARM_VIRTIO_MMIO_SIZE	(ARM_AXI_AREA - \
-				(KVM_VIRTIO_MMIO_AREA + ARM_GIC_SIZE))
+#define ARM_VIRTIO_MMIO_SIZE	SZ_128M
+
+#define KVM_VFIO_MMIO_AREA	(KVM_VIRTIO_MMIO_AREA + ARM_VIRTIO_MMIO_SIZE)
+#define KVM_VFIO_MMIO_SIZE	SZ_32M
 
 #define ARM_GIC_DIST_BASE	(ARM_AXI_AREA - ARM_GIC_DIST_SIZE)
 #define ARM_GIC_CPUI_BASE	(ARM_GIC_DIST_BASE - ARM_GIC_CPUI_SIZE)
diff --git a/mips/include/kvm/kvm-arch.h b/mips/include/kvm/kvm-arch.h
index f5b9044..d9a9a64 100644
--- a/mips/include/kvm/kvm-arch.h
+++ b/mips/include/kvm/kvm-arch.h
@@ -15,6 +15,8 @@
 #define KVM_PCI_CFG_AREA	KVM_MMIO_START
 #define KVM_PCI_MMIO_AREA	(KVM_MMIO_START + 0x1000000)
 #define KVM_VIRTIO_MMIO_AREA	(KVM_MMIO_START + 0x2000000)
+#define KVM_VFIO_MMIO_AREA	(KVM_MMIO_START + 0x3000000)
+#define KVM_VFIO_MMIO_SIZE	SZ_32M
 #define KVM_MMIO_SIZE		0x10000000
 
 /*
diff --git a/powerpc/include/kvm/kvm-arch.h b/powerpc/include/kvm/kvm-arch.h
index ff42c13..cebf73c 100644
--- a/powerpc/include/kvm/kvm-arch.h
+++ b/powerpc/include/kvm/kvm-arch.h
@@ -42,6 +42,8 @@
 #define KVM_PCI_CFG_AREA		0x1000000
 #define KVM_PCI_MMIO_AREA		0x2000000
 #define KVM_VIRTIO_MMIO_AREA		0x3000000
+#define KVM_VFIO_MMIO_AREA		0x4000000
+#define KVM_VFIO_MMIO_SIZE		SZ_32M
 
 #define KVM_IRQ_OFFSET			16
 
diff --git a/riscv/include/kvm/kvm-arch.h b/riscv/include/kvm/kvm-arch.h
index 460b90b..b347216 100644
--- a/riscv/include/kvm/kvm-arch.h
+++ b/riscv/include/kvm/kvm-arch.h
@@ -45,6 +45,9 @@
 #define KVM_PCI_CFG_AREA	RISCV_PCI
 #define KVM_PCI_MMIO_AREA	(KVM_PCI_CFG_AREA + RISCV_PCI_CFG_SIZE)
 #define KVM_VIRTIO_MMIO_AREA	(RISCV_RTC_MMIO_BASE + RISCV_RTC_MMIO_SIZE)
+#define KVM_VIRTIO_MMIO_SIZE	SZ_128M
+#define KVM_VFIO_MMIO_AREA	(KVM_VIRTIO_MMIO_AREA + KVM_VIRTIO_MMIO_SIZE)
+#define KVM_VFIO_MMIO_SIZE	SZ_32M
 
 #define KVM_IOEVENTFD_HAS_PIO	0
 
diff --git a/x86/include/kvm/kvm-arch.h b/x86/include/kvm/kvm-arch.h
index 73a957b..cc2defa 100644
--- a/x86/include/kvm/kvm-arch.h
+++ b/x86/include/kvm/kvm-arch.h
@@ -24,6 +24,8 @@
 #define KVM_PCI_CFG_AREA	(KVM_MMIO_START + 0x1000000)
 #define KVM_PCI_MMIO_AREA	(KVM_MMIO_START + 0x2000000)
 #define KVM_VIRTIO_MMIO_AREA	(KVM_MMIO_START + 0x3000000)
+#define KVM_VFIO_MMIO_AREA	(KVM_MMIO_START + 0x4000000)
+#define KVM_VFIO_MMIO_SIZE	SZ_32M
 
 #define KVM_IRQ_OFFSET		5
 
-- 
2.56.0.307.g5fe7bd680c-goog

