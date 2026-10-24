Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858822;
	b=SC97aQT4bYFhS6eh9XeuyZK/xhLg8HprJRvgnrx+l+kqnb88wzi6dHgtt1Zp2YFOUNHr
	 M5lE9/T1p4Vtdd4us8/Di+nBv4W82gONerGZpKaH3w7VYFvUxsohoPhAEef4s2srJTGee
	 EHj08LZX9N6HXrbEnw5PQoVqQ8eDueM3dT+PyLhn7OZG79rgMqwd+M1YauS6p+EOMjOSg
	 58+kqJ1sU4NWKG3x5FVCnAnVsBK8TzY59LFbg0uComSuGy/Vb/ZvkYyKOotBDT9nSB4fn
	 gLfa2szH/rDmrg+lZCpqw4BRwc6FZt0ppVPkjqQOr2SiRA3b3s7Qv+xkKewvys0WfrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eb4S56OYX2mFo1+yUuN+pY0Ca4WoVJGjTa2wH44Sh5U=;
	b=p2E5lzH0HATiqoxYV2q6GFH2B6t63fIA+Ls70kcr0NKZZzv6QnfVI8XRbJcX1eq5CSMo
	 7Lt41Jt/VpNT99Rgq0iRIj+Zz5GxswW7//b+6SsH3OgN3JauQlbNYXLp0GRfhKbNewOBn
	 ss1/s+IUU50YqiaAz2467rjoKgpN2FEzlw00BPhbW+tMVzOQxBwAzUvfpVFu2XFcx17Ce
	 lUTFHKGBxPUPqQnGzUDCOjFJ7qqe9+SpPNC9D2ZUwaJZXi5TkCkJYoSIITwkQXTh8PaX2
	 iVQ9bhAPTOynQZsB4whDC6rt252d8IRY4W1alqnTOgCdtNKx3zvmp6iujjX+EpZAPDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XWaCYEIR;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CC3606A32D
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9CC3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XWaCYEIR
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so13631535e9.2
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858820; x=1793463620; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eb4S56OYX2mFo1+yUuN+pY0Ca4WoVJGjTa2wH44Sh5U=;
        b=XWaCYEIRmmcfMiGRxsv7UvAWhBJkPxP8Ppga6U0wda2Oo8bLOQaAcprumI4rl/V3WT
         IDGIHub8BtNcPctkgGLohaWXkeHssnuav/TKFUPt2abMBdIZTNrJXJZcJ8dunz94pgGE
         rf7V45IPDKvwnE8R++RJ1BmrOt8Sl0GWlWDCQxlMqj5fX42Uc3tuPC9x2umidceIXThJ
         YLm0yYFz75yisCGSDSFKLJ+rzhDXSQm+Z/WDr0AkbTcFI1pPjI13TquPdHkIbTu9r4Yc
         nTNV8VHGv1y4q1pxYZkgBteX8P6BCh81sX095dMnBdIEri30FIeO216OrP+eo3/kKtWO
         J7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858820; x=1793463620;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eb4S56OYX2mFo1+yUuN+pY0Ca4WoVJGjTa2wH44Sh5U=;
        b=JTxVklc5sDhD/32eleEJMJYEiPC0ngnS92dMb8cSCLvxrTnvhiHErIWiaJqZz0EQKY
         u5GlfVBjMQacHC8Ei91jgNepj8FfXYYBmG6GKXeTi/htUBdDoyi896vxpqIgeknlppOl
         BPc0R0HytNOUv5KTYKieyM8JN9tUy7+5W1QPK41JlPTRtOZ2HTUnIRld2bqAmScK4VhW
         MLQ3bJ4A1rHuYx1Jb0qmfAVg1gVbm/ajwo2YESwGUxYOYshT5B7ouAU/TR7xevT/M6Jb
         /8IDsuRjY4uh4daBaOG3k4OZRkfi8jgO3rbE9GWy05NMWFTotNdgGrAMNqcWLF4CLcmE
         htGQ==
X-Gm-Message-State: AFq9FYISa7oRZkCCo7eh5BeEWzWiML5wpPOpGSr1QRGZsODW8q9/SuyT
	unYaGuyd+C8HsiadliPWtqdpc5p2+FQ1/Y8Q0g5UYqekni6CZvwKu5bfCLJUfwl9EeFQDw/bd1m
	wDm3g2HX2hpbMMHtXEu4KmwLKhfW2Gpk9p7UVpLZLsfxOGB40c4NI3B/MD+LFmHWwof8sUGL5k8
	5unHOjwYgFAVYmxTYd2DHVYbIGST3YTydnzCtiVhsHaMk=
X-Received: from wmbd16.prod.google.com ([2002:a05:600c:58d0:b0:4a1:f37f:7f0b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b11:b0:4a1:dade:f049 with SMTP id 5b1f17b1804b1-4a35acbd3b3mr38671225e9.15.1792858819897;
 Sat, 24 Oct 2026 09:20:19 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:18:56 +0000
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
Message-ID: <20261024161902.2093581-4-smostafa@google.com>
Subject: [PATCH kvmtool 3/9] vfio: Support edge-triggered wired IRQs
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

PCI INTx is are level-triggered and automasked, but platform
device interrupts can also be edge-triggered.

Pass an automasked boolean to vfio_irq_enable() and only create and
register unmask_fd when the interrupt is automasked.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/kvm/vfio.h |  2 +-
 vfio/core.c        | 51 ++++++++++++++++++++++++++--------------------
 vfio/pci.c         |  3 ++-
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/kvm/vfio.h b/include/kvm/vfio.h
index 9a5783e..0b2b105 100644
--- a/include/kvm/vfio.h
+++ b/include/kvm/vfio.h
@@ -141,7 +141,7 @@ int vfio_map_region(struct kvm *kvm, struct vfio_device *vdev,
 		    struct vfio_region *region);
 void vfio_unmap_region(struct kvm *kvm, struct vfio_region *region);
 int vfio_irq_enable(struct kvm *kvm, struct vfio_device *vdev,
-		    unsigned int index, struct vfio_irq *irq);
+		    unsigned int index, bool automasked, struct vfio_irq *irq);
 void vfio_irq_disable(struct kvm *kvm, struct vfio_device *vdev,
 		      unsigned int index, struct vfio_irq *irq);
 int vfio_pci_setup_device(struct kvm *kvm, struct vfio_device *device);
diff --git a/vfio/core.c b/vfio/core.c
index 24d3f2d..aa124d2 100644
--- a/vfio/core.c
+++ b/vfio/core.c
@@ -301,15 +301,16 @@ void vfio_irq_disable(struct kvm *kvm, struct vfio_device *vdev,
 	irq__del_irqfd(kvm, gsi, irq->trigger_fd);
 
 	close(irq->trigger_fd);
-	close(irq->unmask_fd);
+	if (irq->unmask_fd >= 0)
+		close(irq->unmask_fd);
 	irq->trigger_fd = -1;
 }
 
 int vfio_irq_enable(struct kvm *kvm, struct vfio_device *vdev,
-		    unsigned int index, struct vfio_irq *irq)
+		    unsigned int index, bool automasked, struct vfio_irq *irq)
 {
 	int ret;
-	int trigger_fd, unmask_fd;
+	int trigger_fd, unmask_fd = -1;
 	union vfio_irq_eventfd	trigger;
 	union vfio_irq_eventfd	unmask;
 	int gsi = irq->gsi;
@@ -318,7 +319,7 @@ int vfio_irq_enable(struct kvm *kvm, struct vfio_device *vdev,
 		return 0;
 
 	/*
-	 * PCI IRQ is level-triggered, so we use two eventfds. trigger_fd
+	 * Level-triggered IRQ is automasked, so we use two eventfds. trigger_fd
 	 * signals an interrupt from host to guest, and unmask_fd signals the
 	 * deassertion of the line from guest to host.
 	 */
@@ -328,11 +329,13 @@ int vfio_irq_enable(struct kvm *kvm, struct vfio_device *vdev,
 		return trigger_fd;
 	}
 
-	unmask_fd = eventfd(0, 0);
-	if (unmask_fd < 0) {
-		vfio_dev_err(vdev, "failed to create unmask eventfd");
-		close(trigger_fd);
-		return unmask_fd;
+	if (automasked) {
+		unmask_fd = eventfd(0, 0);
+		if (unmask_fd < 0) {
+			vfio_dev_err(vdev, "failed to create unmask eventfd");
+			close(trigger_fd);
+			return unmask_fd;
+		}
 	}
 
 	ret = irq__add_irqfd(kvm, gsi, trigger_fd, unmask_fd);
@@ -354,19 +357,22 @@ int vfio_irq_enable(struct kvm *kvm, struct vfio_device *vdev,
 		goto err_delete_line;
 	}
 
-	unmask.irq = (struct vfio_irq_set) {
-		.argsz	= sizeof(unmask),
-		.flags	= VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_UNMASK,
-		.index	= index,
-		.start	= 0,
-		.count	= 1,
-	};
-	set_vfio_irq_eventd_payload(&unmask, unmask_fd);
+	if (unmask_fd >= 0) {
+		unmask.irq = (struct vfio_irq_set) {
+			.argsz	= sizeof(unmask),
+			.flags	= VFIO_IRQ_SET_DATA_EVENTFD |
+				  VFIO_IRQ_SET_ACTION_UNMASK,
+			.index	= index,
+			.start	= 0,
+			.count	= 1,
+		};
+		set_vfio_irq_eventd_payload(&unmask, unmask_fd);
 
-	ret = ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &unmask);
-	if (ret < 0) {
-		vfio_dev_err(vdev, "failed to setup unmask IRQ");
-		goto err_remove_event;
+		ret = ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, &unmask);
+		if (ret < 0) {
+			vfio_dev_err(vdev, "failed to setup unmask IRQ");
+			goto err_remove_event;
+		}
 	}
 
 	irq->trigger_fd = trigger_fd;
@@ -385,7 +391,8 @@ err_delete_line:
 
 err_close:
 	close(trigger_fd);
-	close(unmask_fd);
+	if (unmask_fd >= 0)
+		close(unmask_fd);
 	return ret;
 }
 
diff --git a/vfio/pci.c b/vfio/pci.c
index fb98435..9bf2f9e 100644
--- a/vfio/pci.c
+++ b/vfio/pci.c
@@ -1216,7 +1216,8 @@ static int vfio_pci_enable_intx(struct kvm *kvm, struct vfio_device *vdev)
 {
 	struct vfio_pci_device *pdev = &vdev->pci;
 
-	return vfio_irq_enable(kvm, vdev, VFIO_PCI_INTX_IRQ_INDEX, &pdev->intx);
+	return vfio_irq_enable(kvm, vdev, VFIO_PCI_INTX_IRQ_INDEX, true,
+			       &pdev->intx);
 }
 
 static int vfio_pci_init_intx(struct kvm *kvm, struct vfio_device *vdev)
-- 
2.56.0.307.g5fe7bd680c-goog

