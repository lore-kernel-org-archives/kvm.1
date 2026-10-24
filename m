Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858821;
	b=Fjfw/gjOdvmFWoj2ILWTMeMF3MAlfoShNbCHYZUCHkw55LyG2IfLGcWpcU0O47Zxyd2/
	 HN0BYG+GTgZPOUqlxoM9CGCGSzIN1FQmoG6rgmena+wyNR68NIWhsbb+TazWr9+PfdrIw
	 b8IrfMu9ea+dwyJkgsTU8eLOrSf/OyWqKw+W0LrxA+QzrfdCMG1we9VFUiBPcTW+ghAKZ
	 dFYjqfklbpnhLdY45HYXYbHD27ArIFJhjAkmUYEciTB7VGf4tfjUkQJG+IVvwPCUZh1oo
	 0+3xY/MS2QxqZxpekhY4BvG4cfA9k+eAxonE++byUwS/kzp86OqJhat6ZAlZXYkCyMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8Pa/P+0Oi5t7tnCKsUkLMot5QPjYuZJeQ5U/L71HvaA=;
	b=HbbqlCeu/HXLXrcn30jkWG7rRdMSyxwWzdhZGbM675YX7KMdK3aZRtJ1xh1q1fEUDpP1
	 TZNMijr9ReLfZuTMv7zmC+mSFJiTsPjS5Qhmta9rXODjgn+3lTnUQ6ilGao50QHJPkAaF
	 NVQs+XrwXqGaQ0ntruW71B37uYVyx99Uvs+xm2ygAHz79fAnMXCMQ1in9UaP22HAtyMoK
	 xy6I0lc2v/hyDIAKSNt/Wo9j6wwxfO1h791mEgHYHDbVVnISY2c1jgW4j5cZrd6uumhkC
	 BHGjYkOIrvNqaMXLyUSfGoidN2U3ODYH9iobqZIqUtiif1OL26zRnni8Qx8gNH3Hh2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pBBD0oar;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA3606A335
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BEA3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pBBD0oar
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af4a0bd0fso923921f8f.2
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858819; x=1793463619; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Pa/P+0Oi5t7tnCKsUkLMot5QPjYuZJeQ5U/L71HvaA=;
        b=pBBD0oar4ekRTbUV/iuM3p1fhyLjAM+oF0n5qS4DDXrPB4ITJlpp8RILO7ppT7R3gk
         tXe/RET1VxIFmursCaARrKY+dJ9acA4PfsgByCEOOpgXn6w+dwUh4KE16cNxwn3dtB1t
         b9zwi1RU8OdgYIVAxhOptfXNg8dpXvcMXKpJqTFPXYNFQwyu8A/YQ79XN5M43dYQP9GY
         gJnSx6aYqs2IqShuWGpVC1azKznwe5dKgPKHIFbzPTavC8GzePepJYHPwz+EkWv9pvYf
         MCqJYNqFDDV1G4cirir1TQ8jRwV8kU+vmxiQvjBmsXQoM6x2rqQaRdQYDJGNXKdXF+6s
         N8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858819; x=1793463619;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Pa/P+0Oi5t7tnCKsUkLMot5QPjYuZJeQ5U/L71HvaA=;
        b=SI+sgnuf+svMGielYdFJVcPylGQyeZtYQcLviaOfxLoMU61RavWJWfTBwQmA1UsJ2m
         +CThYIVK5IcahYBZbSEVKZq23xqvwMtqTHZugN6hOG8JAyRSo+9EWG7h2rGUCIz9b5Vg
         5gZOwFQWXDQZbrGdySowma+11xJwAaotnYAhK2/+c4f0y73kEcjZPH6s4eC7Y09YGaFO
         n9fqMZtoQQdWo/J+D45tMD70kNhI8OixTjZVGP2eXbkRVXyPu2otpJeaLsUSuPlGYWOV
         GKBznF0YyDU1F1Z328SXdqYnCGNAFCHYu1hcriMl1rB72gr3X6tRmaOLtamJNaaHgqzX
         dhBA==
X-Gm-Message-State: AFq9FYLbtjhZekNN3mHJ04s9Pj2t4TY4duWBkp5CWuKu1NDUswI9pBLs
	/JHroIwqvx6ZGSdZhnsJz5sarHRwm8FhSlori5tAM2DIZoZu80HL1z5Z3zCJv4f1iP4Y7opy/WA
	bFKWSrndoBnu/IvCKf/SnI66vk/1XO/T5wbcIMNAy5u7Y5A5oyu3Dv03O4+Wo196QHHDenP6qm+
	/eX2vD//yFsrOqrCeUz7cnUHmHfbxNzotT28siG/QC/x4=
X-Received: from wrxk1.prod.google.com ([2002:a05:6000:41:b0:48e:1468:2506])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c8:b0:48d:dc6f:219a with SMTP id ffacd0b85a97d-48e3eb840f0mr4213261f8f.27.1792858818765;
 Sat, 24 Oct 2026 09:20:18 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:18:55 +0000
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
Message-ID: <20261024161902.2093581-3-smostafa@google.com>
Subject: [PATCH kvmtool 2/9] vfio: Factor out wired IRQ setup and teardown
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Factor the wired IRQ eventfd and KVM irqfd setup and teardown out of
vfio_pci_enable_intx() and vfio_pci_disable_intx() into
vfio_irq_enable() and vfio_irq_disable() in vfio/core.c, and move
union vfio_irq_eventfd to vfio.h so both PCI INTx and VFIO platform
devices can share them.

The is a mechanical code move, no functional change.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/kvm/vfio.h |  27 +++++++++--
 vfio/core.c        | 107 +++++++++++++++++++++++++++++++++++++++++++
 vfio/pci.c         | 110 +++------------------------------------------
 3 files changed, 137 insertions(+), 107 deletions(-)

diff --git a/include/kvm/vfio.h b/include/kvm/vfio.h
index ac7b622..9a5783e 100644
--- a/include/kvm/vfio.h
+++ b/include/kvm/vfio.h
@@ -6,6 +6,7 @@
 #include "kvm/pci.h"
 
 #include <linux/vfio.h>
+#include <string.h>
 
 #define vfio_dev_err(vdev, fmt, ...) \
 	pr_err("%s: " fmt, (vdev)->params->name, ##__VA_ARGS__)
@@ -70,13 +71,17 @@ struct vfio_pci_msi_common {
 #define VFIO_PCI_IRQ_MODE_MSI		(1 << 1)
 #define VFIO_PCI_IRQ_MODE_MSIX		(1 << 2)
 
+struct vfio_irq {
+	int				gsi;
+	int				trigger_fd;
+	int				unmask_fd;
+};
+
 struct vfio_pci_device {
 	struct pci_device_header	hdr;
 
 	unsigned long			irq_modes;
-	int				intx_fd;
-	int				unmask_fd;
-	unsigned int			intx_gsi;
+	struct vfio_irq			intx;
 	struct vfio_pci_msi_common	msi;
 	struct vfio_pci_msi_common	msix;
 	struct vfio_pci_msix_table	msix_table;
@@ -119,10 +124,26 @@ struct vfio_group {
 	struct list_head		list;
 };
 
+/* Wrapper around UAPI vfio_irq_set */
+union vfio_irq_eventfd {
+	struct vfio_irq_set	irq;
+	u8 buffer[sizeof(struct vfio_irq_set) + sizeof(int)];
+};
+
+static inline void set_vfio_irq_eventd_payload(union vfio_irq_eventfd *evfd,
+					       int fd)
+{
+	memcpy(&evfd->irq.data, &fd, sizeof(fd));
+}
+
 int vfio_device_parser(const struct option *opt, const char *arg, int unset);
 int vfio_map_region(struct kvm *kvm, struct vfio_device *vdev,
 		    struct vfio_region *region);
 void vfio_unmap_region(struct kvm *kvm, struct vfio_region *region);
+int vfio_irq_enable(struct kvm *kvm, struct vfio_device *vdev,
+		    unsigned int index, struct vfio_irq *irq);
+void vfio_irq_disable(struct kvm *kvm, struct vfio_device *vdev,
+		      unsigned int index, struct vfio_irq *irq);
 int vfio_pci_setup_device(struct kvm *kvm, struct vfio_device *device);
 void vfio_pci_teardown_device(struct kvm *kvm, struct vfio_device *vdev);
 
diff --git a/vfio/core.c b/vfio/core.c
index e0c56ab..24d3f2d 100644
--- a/vfio/core.c
+++ b/vfio/core.c
@@ -1,8 +1,10 @@
+#include "kvm/irq.h"
 #include "kvm/kvm.h"
 #include "kvm/vfio.h"
 #include "kvm/ioport.h"
 
 #include <linux/list.h>
+#include <sys/eventfd.h>
 #include <libgen.h>
 
 #define VFIO_DEV_DIR		"/dev/vfio"
@@ -282,6 +284,111 @@ void vfio_unmap_region(struct kvm *kvm, struct vfio_region *region)
 	}
 }
 
+void vfio_irq_disable(struct kvm *kvm, struct vfio_device *vdev,
+		      unsigned int index, struct vfio_irq *irq)
+{
+	int gsi = irq->gsi;
+	struct vfio_irq_set irq_set = {
+		.argsz	= sizeof(irq_set),
+		.flags	= VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_TRIGGER,
+		.index	= index,
+	};
+
+	if (irq->trigger_fd == -1)
+		return;
+
+	ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+	irq__del_irqfd(kvm, gsi, irq->trigger_fd);
+
+	close(irq->trigger_fd);
+	close(irq->unmask_fd);
+	irq->trigger_fd = -1;
+}
+
+int vfio_irq_enable(struct kvm *kvm, struct vfio_device *vdev,
+		    unsigned int index, struct vfio_irq *irq)
+{
+	int ret;
+	int trigger_fd, unmask_fd;
+	union vfio_irq_eventfd	trigger;
+	union vfio_irq_eventfd	unmask;
+	int gsi = irq->gsi;
+
+	if (irq->trigger_fd != -1)
+		return 0;
+
+	/*
+	 * PCI IRQ is level-triggered, so we use two eventfds. trigger_fd
+	 * signals an interrupt from host to guest, and unmask_fd signals the
+	 * deassertion of the line from guest to host.
+	 */
+	trigger_fd = eventfd(0, 0);
+	if (trigger_fd < 0) {
+		vfio_dev_err(vdev, "failed to create trigger eventfd");
+		return trigger_fd;
+	}
+
+	unmask_fd = eventfd(0, 0);
+	if (unmask_fd < 0) {
+		vfio_dev_err(vdev, "failed to create unmask eventfd");
+		close(trigger_fd);
+		return unmask_fd;
+	}
+
+	ret = irq__add_irqfd(kvm, gsi, trigger_fd, unmask_fd);
+	if (ret)
+		goto err_close;
+
+	trigger.irq = (struct vfio_irq_set) {
+		.argsz	= sizeof(trigger),
+		.flags	= VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
+		.index	= index,
+		.start	= 0,
+		.count	= 1,
+	};
+	set_vfio_irq_eventd_payload(&trigger, trigger_fd);
+
+	ret = ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &trigger);
+	if (ret < 0) {
+		vfio_dev_err(vdev, "failed to setup VFIO IRQ");
+		goto err_delete_line;
+	}
+
+	unmask.irq = (struct vfio_irq_set) {
+		.argsz	= sizeof(unmask),
+		.flags	= VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_UNMASK,
+		.index	= index,
+		.start	= 0,
+		.count	= 1,
+	};
+	set_vfio_irq_eventd_payload(&unmask, unmask_fd);
+
+	ret = ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &unmask);
+	if (ret < 0) {
+		vfio_dev_err(vdev, "failed to setup unmask IRQ");
+		goto err_remove_event;
+	}
+
+	irq->trigger_fd = trigger_fd;
+	irq->unmask_fd = unmask_fd;
+
+	return 0;
+
+err_remove_event:
+	/* Remove trigger event */
+	trigger.irq.flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_TRIGGER;
+	trigger.irq.count = 0;
+	ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &trigger);
+
+err_delete_line:
+	irq__del_irqfd(kvm, gsi, trigger_fd);
+
+err_close:
+	close(trigger_fd);
+	close(unmask_fd);
+	return ret;
+}
+
 static int vfio_configure_device(struct kvm *kvm, struct vfio_device *vdev)
 {
 	int ret;
diff --git a/vfio/pci.c b/vfio/pci.c
index 0bcd60e..fb98435 100644
--- a/vfio/pci.c
+++ b/vfio/pci.c
@@ -17,17 +17,6 @@
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12
 #endif
 
-/* Wrapper around UAPI vfio_irq_set */
-union vfio_irq_eventfd {
-	struct vfio_irq_set	irq;
-	u8 buffer[sizeof(struct vfio_irq_set) + sizeof(int)];
-};
-
-static void set_vfio_irq_eventd_payload(union vfio_irq_eventfd *evfd, int fd)
-{
-	memcpy(&evfd->irq.data, &fd, sizeof(fd));
-}
-
 /*
  * To support MSI and MSI-X with common code, track the host and guest states of
  * the MSI/MSI-X capability, and of individual vectors.
@@ -1213,108 +1202,21 @@ static int vfio_pci_init_msis(struct kvm *kvm, struct vfio_device *vdev,
 static void vfio_pci_disable_intx(struct kvm *kvm, struct vfio_device *vdev)
 {
 	struct vfio_pci_device *pdev = &vdev->pci;
-	int gsi = pdev->intx_gsi;
-	struct vfio_irq_set irq_set = {
-		.argsz	= sizeof(irq_set),
-		.flags	= VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_TRIGGER,
-		.index	= VFIO_PCI_INTX_IRQ_INDEX,
-	};
+	int gsi = pdev->intx.gsi;
 
-	if (pdev->intx_fd == -1)
+	if (pdev->intx.trigger_fd == -1)
 		return;
 
 	pr_debug("user requested MSI, disabling INTx %d", gsi);
 
-	ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
-	irq__del_irqfd(kvm, gsi, pdev->intx_fd);
-
-	close(pdev->intx_fd);
-	close(pdev->unmask_fd);
-	pdev->intx_fd = -1;
+	vfio_irq_disable(kvm, vdev, VFIO_PCI_INTX_IRQ_INDEX, &pdev->intx);
 }
 
 static int vfio_pci_enable_intx(struct kvm *kvm, struct vfio_device *vdev)
 {
-	int ret;
-	int trigger_fd, unmask_fd;
-	union vfio_irq_eventfd	trigger;
-	union vfio_irq_eventfd	unmask;
 	struct vfio_pci_device *pdev = &vdev->pci;
-	int gsi = pdev->intx_gsi;
 
-	if (pdev->intx_fd != -1)
-		return 0;
-
-	/*
-	 * PCI IRQ is level-triggered, so we use two eventfds. trigger_fd
-	 * signals an interrupt from host to guest, and unmask_fd signals the
-	 * deassertion of the line from guest to host.
-	 */
-	trigger_fd = eventfd(0, 0);
-	if (trigger_fd < 0) {
-		vfio_dev_err(vdev, "failed to create trigger eventfd");
-		return trigger_fd;
-	}
-
-	unmask_fd = eventfd(0, 0);
-	if (unmask_fd < 0) {
-		vfio_dev_err(vdev, "failed to create unmask eventfd");
-		close(trigger_fd);
-		return unmask_fd;
-	}
-
-	ret = irq__add_irqfd(kvm, gsi, trigger_fd, unmask_fd);
-	if (ret)
-		goto err_close;
-
-	trigger.irq = (struct vfio_irq_set) {
-		.argsz	= sizeof(trigger),
-		.flags	= VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
-		.index	= VFIO_PCI_INTX_IRQ_INDEX,
-		.start	= 0,
-		.count	= 1,
-	};
-	set_vfio_irq_eventd_payload(&trigger, trigger_fd);
-
-	ret = ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &trigger);
-	if (ret < 0) {
-		vfio_dev_err(vdev, "failed to setup VFIO IRQ");
-		goto err_delete_line;
-	}
-
-	unmask.irq = (struct vfio_irq_set) {
-		.argsz	= sizeof(unmask),
-		.flags	= VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_UNMASK,
-		.index	= VFIO_PCI_INTX_IRQ_INDEX,
-		.start	= 0,
-		.count	= 1,
-	};
-	set_vfio_irq_eventd_payload(&unmask, unmask_fd);
-
-	ret = ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &unmask);
-	if (ret < 0) {
-		vfio_dev_err(vdev, "failed to setup unmask IRQ");
-		goto err_remove_event;
-	}
-
-	pdev->intx_fd = trigger_fd;
-	pdev->unmask_fd = unmask_fd;
-
-	return 0;
-
-err_remove_event:
-	/* Remove trigger event */
-	trigger.irq.flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_TRIGGER;
-	trigger.irq.count = 0;
-	ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &trigger);
-
-err_delete_line:
-	irq__del_irqfd(kvm, gsi, trigger_fd);
-
-err_close:
-	close(trigger_fd);
-	close(unmask_fd);
-	return ret;
+	return vfio_irq_enable(kvm, vdev, VFIO_PCI_INTX_IRQ_INDEX, &pdev->intx);
 }
 
 static int vfio_pci_init_intx(struct kvm *kvm, struct vfio_device *vdev)
@@ -1345,9 +1247,9 @@ static int vfio_pci_init_intx(struct kvm *kvm, struct vfio_device *vdev)
 	}
 
 	/* Guest is going to ovewrite our irq_line... */
-	pdev->intx_gsi = pdev->hdr.irq_line - KVM_IRQ_OFFSET;
+	pdev->intx.gsi = pdev->hdr.irq_line - KVM_IRQ_OFFSET;
 
-	pdev->intx_fd = -1;
+	pdev->intx.trigger_fd = -1;
 
 	return 0;
 }
-- 
2.56.0.307.g5fe7bd680c-goog

