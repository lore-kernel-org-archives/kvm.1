Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109463E16BF
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839707; cv=none; b=jL05Ny/p4vOB5PemJUOEYsMDJefPN48AX6t7dc0hmhLHE/NbWLRUXrMOVQddkQK0HYgUDQ1OIZvZBtl7wX74Wpi6Ke5nuGsIVMa6nc2DbtKWXsyv+Bs2esjF42/Oj1E+sBZ5NL5XIsDgWLeEyx8nisChmyr65FzohGXdUg0jETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839707; c=relaxed/simple;
	bh=Eyvqc1odT+Kdz0scCVIgRbWUT2YDdREMS7madKUYbOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JXCl+asFPKVd+AZLtUJ0dj0pvbgYohkaAsk0DdWIV2HtTLGhWl1CwO/20kh7V8uzHOnv7s35+K9+2lUSQq+CWadN7msfm8SyqFQPKcgMugWx46CWF0VN+cYmuREj1TTHFF4M4s3WWWyKhSkpmdwZS4gvofd2388euEDd3iK9PJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1uzvlwd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1uzvlwd"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828cee4fcdso5263878a12.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839691; x=1780444491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzDUvdi0+bD6DdunDcZ2QC8sVsZ9aq07dF/ENuNkPMU=;
        b=u1uzvlwdjWkzLXH5eLCtlQtS77uks2fcBISUwn1S8IrHd+hVvBeGIS7XunkrevtQw6
         CCh5Zpg4tJaCrx7ih81pZDNh+jlpuAXyMmUO5v7elad98Pr94fGfOPoSJ7S7+IFUuCkb
         jgcH1tTHrxlg0L3nqeaEKTf5UwUR540kgdhT+824G/4lWv7SA/WYfEjIbFyuj7g0xwZv
         WgIphhtB5KHCyPSDwlXU1mhsZcfm82bnGoD7KPbiLAFiOq9cK5/es3HzsGAlvO2pWbo1
         iRPD9bTQZJP+7lB1RLj7mBBJYJ7jsz8tnNp1LWLMulB06S67oERYcxuLwg0IsBefDnMq
         rYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839691; x=1780444491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzDUvdi0+bD6DdunDcZ2QC8sVsZ9aq07dF/ENuNkPMU=;
        b=qO7jl8Hy98th5Zwnq2nHCPFBIUSje8TtA3pOqF0T8o25xuTG0zqTeFHjeT12RRcCuf
         B7QbpgJ1hsafG+akFoRNuqa7HTObmSrwGXw6T5uOMER4+/Gsir7QnA2k3WcwV0zih+WE
         5f36yFb2J12CRTN1FKg1mwmV2of7T/5IcrtUmGDP/JIMeZ014hIKMgMkzHe4AfGyRAS9
         QT9K/qL4y1gxhzByVUVEk8Mmpb8ajY4Ss7iQ0TLQtPxd+qyJe2NIs91yGLYzNT1S+iNw
         zL8f6ySNLnt/AyAKz1YFQDW2UM9QWcEIl3kb+3/99Hr8cfSUq0cEeJ+AG4P0jI+oikYV
         JK7w==
X-Forwarded-Encrypted: i=1; AFNElJ+hLmfznKp8xpE8GR8qDC9sHOT00B1MlQroSln6j06jyXyCrT55MuC2pIBMOhtSpLRrxyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRGojxHqNrqGDd8bmngbJbdNSlQrv9EO6SCrEim/8PBLN99ID
	b20ELCQcxmRlIU117EUoNWe1QRxkb+zrVb2UPajcCdHiPu70Gp1OQnzvSABnzaoWKMEAxW2j8F6
	WrEEQ2Vw0
X-Received: from pfbkm19.prod.google.com ([2002:a05:6a00:3c53:b0:83f:420:c568])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da4:b0:837:e9cc:d465
 with SMTP id d2e1a72fcca58-8415f19e22fmr18793866b3a.20.1779839690629; Tue, 26
 May 2026 16:54:50 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:14 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-8-jrhilke@google.com>
Subject: [PATCH v2 07/10] selftests/vfio: Add vfio_pci_irq_reenable() helper
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

From: Alex Williamson <alex.williamson@nvidia.com>

Selftest drivers that recover from a fault by issuing VFIO_DEVICE_RESET
need to re-arm device interrupts afterwards.  VFIO_DEVICE_RESET tears
down the kernel-side IRQ trigger so a subsequent VFIO_DEVICE_SET_IRQS
is required, but the user-side eventfds (and any fd cached in a test
fixture) are still valid and must be preserved.

vfio_pci_irq_enable() refuses to be called for vectors that already
have an eventfd (VFIO_ASSERT_LT), and vfio_pci_irq_disable() closes
all eventfds before resetting the trigger, so neither is suitable.

Add vfio_pci_irq_reenable(device, index, vector, count) which asserts
that the requested range has existing eventfds and re-issues
VFIO_DEVICE_SET_IRQS using them.  Signature mirrors vfio_pci_irq_enable().

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  2 ++
 .../selftests/vfio/lib/vfio_pci_device.c      | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..a362e2b2bfda 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -68,6 +68,8 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
+void vfio_pci_irq_reenable(struct vfio_pci_device *device, u32 index,
+			   u32 vector, int count);
 void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
 
 static inline void fcntl_set_nonblock(int fd)
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fc75e04ef010..7b8394d0ac50 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -106,6 +106,28 @@ void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index)
 	vfio_pci_irq_set(device, index, 0, 0, NULL);
 }
 
+/*
+ * Re-issue VFIO_DEVICE_SET_IRQS for an already-enabled vector range using
+ * the existing eventfds.  Intended for drivers that need to re-arm device
+ * interrupts after a VFIO_DEVICE_RESET, which tears down the kernel-side
+ * IRQ trigger but leaves user-side eventfds intact.  Recreating the
+ * eventfds would invalidate any test-fixture cache of the fd, so this
+ * helper deliberately preserves them.
+ */
+void vfio_pci_irq_reenable(struct vfio_pci_device *device, u32 index,
+			   u32 vector, int count)
+{
+	int i;
+
+	check_supported_irq_index(index);
+
+	for (i = vector; i < vector + count; i++)
+		VFIO_ASSERT_GE(device->msi_eventfds[i], 0,
+			       "vector %d eventfd not allocated\n", i);
+
+	vfio_pci_irq_set(device, index, vector, count, device->msi_eventfds + vector);
+}
+
 static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 			     struct vfio_irq_info *irq_info)
 {
-- 
2.54.0.794.g4f17f83d09-goog

