Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858823;
	b=duCB44LSApMFESywe5xC4BtqMAk7gOJ+W/iocIdcDGRD5NTonBpmHQ8CmM3OmsXFeZ5y
	 O+swIUi+oZFP8gKnCuAw0tcOQf2zbnbTI3ZfouoP00rC/eh82zRsiKATj9Im00wdOSERr
	 1bK4+/FSEXHGiJphZ07wg91+to3GmXGyweKYrrxP2mGnMm20gT3aFb6V5rtMmV5WhVXZX
	 gAmUgUiwk4TqID0nERx0LhJJg47pphNUvfbLEIA5rRYVJ5z+Oz9DYaa87DVphc76z1ZEw
	 vLi5ec3Vq8QsxzRyRRiYMXrXtjdd6aztKuHDHCqWGQECMRlJ9jWqJ9OHyJWVfu9Omyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=O2tMFFP5cdIjSqXYrvLhwaCDEdhX+ecKCxDK247guW4=;
	b=gjCb/mpz2Li6Z4GWLBpcJncUaboUQlsfltyfk2lJ6zuM7dCn8V0SyY4+HiDsanY8iPYi
	 yzupk/kfu8PvGMIACRblwOlvnJ4WIxGEBJZpqzzbyuTgs7ukajp0rHmIZNmEWxGP5BR22
	 l/Ad7CfAVWGlFpm7vmJneDV45ARnYiTqa11E0sdp0f7Akp2VgLJiJ27g1aH0C1+2FK53N
	 x9GSaV+pYfPWifTbqgCgVPeQhWz2APZlwT4hSx93Idl/TRCR8waOGXg71nl0EQBelyLus
	 fDxW+D2JDeErgnGp+pncnZqPN4kjKXhklN5is/I0H3xvUy9OfEn/tCA5Mdhe0/q5zZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bgDiTPa8;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA1606A31D
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2AA1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bgDiTPa8
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a16dc2323cso15049885e9.3
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858821; x=1793463621; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2tMFFP5cdIjSqXYrvLhwaCDEdhX+ecKCxDK247guW4=;
        b=bgDiTPa8K1XXaTlZ32bAOK1q7SqubvM++tOPaFmqZwBj57wvKv6zguo3QRj2LEDHNU
         CiR+uQrK01DCU8OVnDrGggF4xS0RwDzAH8CuanGg+u+Xej8PHJRz1JM9XSiQL6tVJREN
         4MKb1P+Jvui2x3zKtABUP1AQpPdjxTiDqhyelyiJp1CuJcmi6L2d97rJRsM1VbtIWeWS
         QRH54jNkwoNfs1G3n7+sZGi/34sXmxAaXRC8NJ271FVAkIh383dp3MjYzbc66yvJ2fa9
         bENpC/jMpFScrP4NJPDvdv/mwAlQg+tAl7TFufHTdhYMKJvcLeN1M27wb4ZsyfNgiCXU
         oIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858821; x=1793463621;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2tMFFP5cdIjSqXYrvLhwaCDEdhX+ecKCxDK247guW4=;
        b=KvjM4HGzA9AW9qldwG497LBfxE3LF7Wy8RsL9L4pfYwbfEZFj+UhEH8H2apMiYzZLH
         GVPF9mSN2Q0bDqDrvdc8gQJHzvcnq17GA9qwdhnu+Zxok5BTQXmy7n3oThvAy898mVGM
         qQ+8A+4J+Ee+lzln7B/MWpH4O7subKB2BtGmyFN4tT+CwIQbJPvQLoC/uw2LTdmoKUyz
         MbcQLm94tHagu+DbaFwkEoR8ZR6Mu1ICcV0B5yAQ9JiziSOBLGEp2re4Ss7pVzY+7XBN
         aRDvftytowng7PoEBa5yXTI9CF3EZVQDqS+mgZdJqkO/oN5Ytj45K2TwAmMzQVMBLvAR
         bFbg==
X-Gm-Message-State: AFq9FYLiVXPKyiWkNapFO0o3Qvpx69aGZeA+qKPKNWXn2cZyCHqD9TrM
	ySOwU9jjXjduPs6nyxt248nAIK6kXxN838aDAt0K9jL7diuP8dDigKj1Bwu0javfKuAK7/qJ5XE
	pKKmk29bZGT5awLvx4lgFfb1OL75WC/+HMJe48zdwvn3WzFeGI+HfOzMM1kzt3zEPcyYnRttHKM
	ihoYITK16dynBZutmgHngZFR/+lzEFrlA4zKEvulnQkMI=
X-Received: from wmco10.prod.google.com ([2002:a05:600c:a30a:b0:4a1:e3ce:e2eb])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4688:b0:4a3:12fb:1ee7 with SMTP id 5b1f17b1804b1-4a35acaf93bmr33877405e9.25.1792858821039;
 Sat, 24 Oct 2026 09:20:21 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:18:57 +0000
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
Message-ID: <20261024161902.2093581-5-smostafa@google.com>
Subject: [PATCH kvmtool 4/9] fdt: Allow fdt_irq_fn to generate multiple interrupts
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

fdt_irq_fn currently accepts a single interrupt line and trigger type,
which is sufficient for emulated MMIO devices with one interrupt.
Assigned platform devices can expose multiple interrupts that must be
written into a single "interrupts" property.

Update fdt_irq_fn and its arm64 and riscv implementations to accept an
array of interrupt lines and trigger types, and convert existing callers
to use the fdt_irq_fn typedef.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arm64/fdt.c                  | 36 ++++++++++++++++++++++++++----------
 hw/cfi_flash.c               |  4 +---
 hw/rtc.c                     |  4 +---
 hw/serial.c                  |  3 ++-
 include/kvm/fdt.h            |  4 +++-
 riscv/fdt.c                  |  2 +-
 riscv/include/kvm/kvm-arch.h |  4 +++-
 riscv/irq.c                  | 27 +++++++++++++++++++--------
 virtio/mmio.c                | 10 ++++------
 9 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/arm64/fdt.c b/arm64/fdt.c
index 3cbd36e..e2c37ad 100644
--- a/arm64/fdt.c
+++ b/arm64/fdt.c
@@ -60,15 +60,29 @@ static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
 	_FDT(fdt_end_node(fdt));
 }
 
-static void generate_irq_prop(void *fdt, u8 irq, enum irq_type irq_type)
+static void generate_irq_prop(void *fdt, const u8 *irqs,
+			      const enum irq_type *irq_types,
+			      unsigned int num_irqs)
 {
-	u32 irq_prop[] = {
-		cpu_to_fdt32(GIC_FDT_IRQ_TYPE_SPI),
-		cpu_to_fdt32(irq - GIC_SPI_IRQ_BASE),
-		cpu_to_fdt32(irq_type)
-	};
+	unsigned int i;
+	u32 *irq_prop;
 
-	_FDT(fdt_property(fdt, "interrupts", irq_prop, sizeof(irq_prop)));
+	if (!num_irqs)
+		return;
+
+	irq_prop = calloc(num_irqs, 3 * sizeof(*irq_prop));
+	if (!irq_prop)
+		die("Failed to allocate the interrupts property");
+
+	for (i = 0; i < num_irqs; i++) {
+		irq_prop[3 * i] = cpu_to_fdt32(GIC_FDT_IRQ_TYPE_SPI);
+		irq_prop[3 * i + 1] = cpu_to_fdt32(irqs[i] - GIC_SPI_IRQ_BASE);
+		irq_prop[3 * i + 2] = cpu_to_fdt32(irq_types[i]);
+	}
+
+	_FDT(fdt_property(fdt, "interrupts", irq_prop,
+			  3 * sizeof(*irq_prop) * num_irqs));
+	free(irq_prop);
 }
 
 static bool emit_dma_regions;
@@ -78,9 +92,11 @@ void generate_dma_region_prop(void *fdt)
 		_FDT(fdt_property_cell(fdt, "memory-region", PHANDLE_DMA));
 }
 
-static void generate_aux_props(void *fdt, u8 irq, enum irq_type irq_type)
+static void generate_aux_props(void *fdt, const u8 *irqs,
+			       const enum irq_type *irq_types,
+			       unsigned int num_irqs)
 {
-	generate_irq_prop(fdt, irq, irq_type);
+	generate_irq_prop(fdt, irqs, irq_types, num_irqs);
 	generate_dma_region_prop(fdt);
 }
 
@@ -125,7 +141,7 @@ static int setup_fdt(struct kvm *kvm)
 	void *fdt_dest		= guest_flat_to_host(kvm,
 						     kvm->arch.dtb_guest_start);
 	void (*generate_mmio_fdt_nodes)(void *, struct device_header *,
-					void (*)(void *, u8, enum irq_type));
+					fdt_irq_fn);
 	void (*generate_cpu_peripheral_fdt_nodes)(void *, struct kvm *)
 					= kvm->cpus[0]->generate_fdt_nodes;
 
diff --git a/hw/cfi_flash.c b/hw/cfi_flash.c
index 4413955..5641af6 100644
--- a/hw/cfi_flash.c
+++ b/hw/cfi_flash.c
@@ -518,9 +518,7 @@ static void cfi_flash_mmio(struct kvm_cpu *vcpu,
 #ifdef CONFIG_HAS_LIBFDT
 static void generate_cfi_flash_fdt_node(void *fdt,
 					struct device_header *dev_hdr,
-					void (*generate_irq_prop)(void *fdt,
-								  u8 irq,
-								enum irq_type))
+					fdt_irq_fn generate_irq_prop)
 {
 	struct cfi_flash_device *sfdev;
 	u64 reg_prop[2];
diff --git a/hw/rtc.c b/hw/rtc.c
index e3523a1..fc6533a 100644
--- a/hw/rtc.c
+++ b/hw/rtc.c
@@ -136,9 +136,7 @@ static void cmos_ram_io(struct kvm_cpu *vcpu, u64 addr, u8 *data,
 #ifdef CONFIG_HAS_LIBFDT
 static void generate_rtc_fdt_node(void *fdt,
 				  struct device_header *dev_hdr,
-				  void (*generate_irq_prop)(void *fdt,
-							    u8 irq,
-							    enum irq_type))
+				  fdt_irq_fn generate_irq_prop)
 {
 	u64 reg_prop[2] = { cpu_to_fdt64(RTC_BASE_ADDRESS), cpu_to_fdt64(2) };
 
diff --git a/hw/serial.c b/hw/serial.c
index 68e6186..8e26837 100644
--- a/hw/serial.c
+++ b/hw/serial.c
@@ -434,6 +434,7 @@ void serial8250_generate_fdt_node(void *fdt, struct device_header *dev_hdr,
 		cpu_to_fdt64(addr),
 		cpu_to_fdt64(8),
 	};
+	enum irq_type irq_type = IRQ_TYPE_LEVEL_HIGH;
 
 	snprintf(dev_name, DEVICE_NAME_MAX_LEN, "U6_16550A@%llx", addr);
 
@@ -446,7 +447,7 @@ void serial8250_generate_fdt_node(void *fdt, struct device_header *dev_hdr,
 	_FDT(fdt_begin_node(fdt, dev_name));
 	_FDT(fdt_property_string(fdt, "compatible", "ns16550a"));
 	_FDT(fdt_property(fdt, "reg", reg_prop, sizeof(reg_prop)));
-	irq_fn(fdt, dev->irq, IRQ_TYPE_LEVEL_HIGH);
+	irq_fn(fdt, &dev->irq, &irq_type, 1);
 	_FDT(fdt_property_cell(fdt, "clock-frequency", 1843200));
 	_FDT(fdt_end_node(fdt));
 }
diff --git a/include/kvm/fdt.h b/include/kvm/fdt.h
index 060c37b..e84c5c1 100644
--- a/include/kvm/fdt.h
+++ b/include/kvm/fdt.h
@@ -25,7 +25,9 @@ enum irq_type {
 	IRQ_TYPE_LEVEL_MASK	= (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH),
 };
 
-typedef void (*fdt_irq_fn)(void *fdt, u8 irq, enum irq_type irq_type);
+typedef void (*fdt_irq_fn)(void *fdt, const u8 *irqs,
+			   const enum irq_type *irq_types,
+			   unsigned int num_irqs);
 
 extern char *fdt_stdout_path;
 
diff --git a/riscv/fdt.c b/riscv/fdt.c
index 1eb45fc..b571724 100644
--- a/riscv/fdt.c
+++ b/riscv/fdt.c
@@ -351,7 +351,7 @@ static int setup_fdt(struct kvm *kvm)
 	void *fdt_dest		= guest_flat_to_host(kvm,
 						     kvm->arch.dtb_guest_start);
 	void (*generate_mmio_fdt_nodes)(void *, struct device_header *,
-					void (*)(void *, u8, enum irq_type));
+					fdt_irq_fn);
 
 	/* Create new tree without a reserve map */
 	_FDT(fdt_create(fdt, FDT_MAX_SIZE));
diff --git a/riscv/include/kvm/kvm-arch.h b/riscv/include/kvm/kvm-arch.h
index 1bb2d32..460b90b 100644
--- a/riscv/include/kvm/kvm-arch.h
+++ b/riscv/include/kvm/kvm-arch.h
@@ -117,7 +117,9 @@ void riscv__del_irqfd(struct kvm *kvm, unsigned int gsi, int trigger_fd);
 
 int riscv__setup_irqfd_lines(struct kvm *kvm);
 
-void riscv__generate_irq_prop(void *fdt, u8 irq, enum irq_type irq_type);
+void riscv__generate_irq_prop(void *fdt, const u8 *irqs,
+			      const enum irq_type *irq_types,
+			      unsigned int num_irqs);
 
 void riscv__irqchip_create(struct kvm *kvm);
 
diff --git a/riscv/irq.c b/riscv/irq.c
index 62dbaa8..2c35f25 100644
--- a/riscv/irq.c
+++ b/riscv/irq.c
@@ -119,18 +119,29 @@ int riscv__setup_irqfd_lines(struct kvm *kvm)
 	return 0;
 }
 
-void riscv__generate_irq_prop(void *fdt, u8 irq, enum irq_type irq_type)
+void riscv__generate_irq_prop(void *fdt, const u8 *irqs,
+			      const enum irq_type *irq_types,
+			      unsigned int num_irqs)
 {
-	u32 prop[2], size;
+	unsigned int i, cells = riscv_irqchip_line_sensing ? 2 : 1;
+	u32 *prop;
 
-	prop[0] = cpu_to_fdt32(irq);
-	size = sizeof(u32);
-	if (riscv_irqchip_line_sensing) {
-		prop[1] = cpu_to_fdt32(irq_type);
-		size += sizeof(u32);
+	if (!num_irqs)
+		return;
+
+	prop = calloc(num_irqs, cells * sizeof(*prop));
+	if (!prop)
+		die("Failed to allocate the interrupts property");
+
+	for (i = 0; i < num_irqs; i++) {
+		prop[cells * i] = cpu_to_fdt32(irqs[i]);
+		if (riscv_irqchip_line_sensing)
+			prop[cells * i + 1] = cpu_to_fdt32(irq_types[i]);
 	}
 
-	_FDT(fdt_property(fdt, "interrupts", prop, size));
+	_FDT(fdt_property(fdt, "interrupts", prop,
+			  cells * sizeof(*prop) * num_irqs));
+	free(prop);
 }
 
 static void (*riscv__irqchip_create_funcs[])(struct kvm *kvm) = {
diff --git a/virtio/mmio.c b/virtio/mmio.c
index fae73b5..0c66724 100644
--- a/virtio/mmio.c
+++ b/virtio/mmio.c
@@ -113,9 +113,7 @@ int virtio_mmio_signal_config(struct kvm *kvm, struct virtio_device *vdev)
 static
 void generate_virtio_mmio_fdt_node(void *fdt,
 				   struct device_header *dev_hdr,
-				   void (*generate_irq_prop)(void *fdt,
-							     u8 irq,
-							     enum irq_type))
+				   fdt_irq_fn generate_irq_prop)
 {
 	char dev_name[DEVICE_NAME_MAX_LEN];
 	struct virtio_mmio *vmmio = container_of(dev_hdr,
@@ -126,6 +124,7 @@ void generate_virtio_mmio_fdt_node(void *fdt,
 		cpu_to_fdt64(addr),
 		cpu_to_fdt64(VIRTIO_MMIO_IO_SIZE),
 	};
+	enum irq_type irq_type = IRQ_TYPE_EDGE_RISING;
 
 	snprintf(dev_name, DEVICE_NAME_MAX_LEN, "virtio@%llx", addr);
 
@@ -133,14 +132,13 @@ void generate_virtio_mmio_fdt_node(void *fdt,
 	_FDT(fdt_property_string(fdt, "compatible", "virtio,mmio"));
 	_FDT(fdt_property(fdt, "reg", reg_prop, sizeof(reg_prop)));
 	_FDT(fdt_property(fdt, "dma-coherent", NULL, 0));
-	generate_irq_prop(fdt, vmmio->irq, IRQ_TYPE_EDGE_RISING);
+	generate_irq_prop(fdt, &vmmio->irq, &irq_type, 1);
 	_FDT(fdt_end_node(fdt));
 }
 #else
 static void generate_virtio_mmio_fdt_node(void *fdt,
 					  struct device_header *dev_hdr,
-					  void (*generate_irq_prop)(void *fdt,
-								    u8 irq))
+					  fdt_irq_fn generate_irq_prop)
 {
 	die("Unable to generate device tree nodes without libfdt\n");
 }
-- 
2.56.0.307.g5fe7bd680c-goog

