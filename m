Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAF26738C
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721223; cv=none; b=Z7+8UAJmwmtiAPXywVcfR/LbCBKn13xL36docNmwKDWGE2k9LJjGLOZxWYg3IF7R5SE+t8Q7fur3Krn6u4lDxKrO//zsZIrjCxR+cFWofw5Z16qVon9vaEyuJP9rTVSSfnYwPAPWFs2HEwCfApwr97Y47SV2pHOGa9U2oIo1Vr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721223; c=relaxed/simple;
	bh=YW5RyQU5o9OBhh9jhOLqy2BLQ4mW4jnepu221Af6evA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fZr1rS6aHRZlMAIGX/XqSfn8s1vPhOcf3d6TzsJ3SzX+A7g1tjp43xjiXIPEM2DR6sn7xyksc1i3os13ikCF/SJ7iFYY+akFX4tsjgn4N+OZSVI2VGslFcnsEuKS9jSywTFjO1bSjko7lcIyW5D849xiu2S5ieqL3Ax4/noIlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OjRD1ytD; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjRD1ytD"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848474825ffso1959906b3a.0
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783721216; x=1784326016; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cm9aCzqOXkPalEf3rO5p1tnL2oSXVIGbLiKDcdTayQI=;
        b=OjRD1ytDyWB6MDC5JYD7/xRA7iSLeyXkLBI2DSnWmgi7g13TLml8ZJKiM2XZYobtY2
         1kZo8WhvHn1zSMJLUIecsY+NWUn70ER/1TJzc7bxzF3R3almcqZdtHxSmMFxqD45H2wc
         xQPt0pocZPwhCT/m/SSEdpM7BAmf+Y0ekN6ipbSXueih3unXrl1jRr6IG0jjgjPlRpM4
         zC3O2/N2wt3bxqiyEn+4O3ED/j1stFNC989WmdiifixQ1DOQwyTNB1Z/F/90aOxkER55
         YHpSDp48iSNo8XF5V9bOIRVsjUfLnLKapVwu8KgUKXhZYHA4aqxKb9Sme9dgaTVNmt/p
         5ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721216; x=1784326016;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cm9aCzqOXkPalEf3rO5p1tnL2oSXVIGbLiKDcdTayQI=;
        b=l1yUNeAlVCxDJmUgqPOd+CvHX3b2P0z8hAhe3Y06eZ2IjkLh3NhlwjOM0Os0JiciTy
         6/4it9e7jsuBwxywtq7bmXqdtCfkubrTTQ804xIMs8RlKnyqmWyJz4CP5I2F4E1n4nZp
         M9U+3SMGKv4G+4VPlUcBZKhIlN3QSuvh3cUCIYGSw12ROnxLWPR2JIOkTsLyMyC0S82d
         hjohbE2Ov1oT3mfEFixPbOmecIBooFF8txtmic1zzMYqpimTNPW/ftBCcQFDBPAdWn0V
         2zCFEszW68YxGH1VnmuSgZ5k0NMSZaQYaM7ZjeeN34TxrKGWGZlxWXgsgr/QqhmbiWxT
         mi+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqfq5mOFZNiExy1AZHv/TNS2iuHl8rZiQ4IfFo5Q6S3PkowUXEoMostMdjBsS0xaLlDq5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNu/VrnHB2BlCLywepce74ZqPyXLXvpHrxR3//dU8MieDjmXC8
	vDa/1LXYHNi4VTC22TJp72NclKe2WcuksQqJShdUD9W8cqIdGOVCxSfQFGKUhOnx3/nZ/buz6SQ
	paigfjkyq
X-Received: from pfev14-n2.prod.google.com ([2002:a05:6a00:c20e:20b0:848:7f21:167c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2290:b0:845:cad1:d691
 with SMTP id d2e1a72fcca58-848703454d6mr4801069b3a.5.1783721215357; Fri, 10
 Jul 2026 15:06:55 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:06:51 +0000
In-Reply-To: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783721208; l=4367;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=DNJx8mJSNM15h+y28JiieS7tQ/YHFwGsaY13DBSJOYU=; b=gRFh46xEOPMrtazvQX+KBJ5CH/Grz5VuxsjQrCoiR/sC59vgO0S2z23AhGF+bXRoHPtCjXaJb
 NcPaDg4Mh7GCcMQv3CaaZMp0evKWXBMP0u183D4YNfIfC9vPvgk8VZF
X-Mailer: b4 0.14.3
Message-ID: <20260710-igb_v3_b4-v4-7-56e7e2576cc1@google.com>
Subject: [PATCH v4 7/9] vfio: selftests: Add helpers to re-enable interrupts
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

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

Add vfio_pci_msi{,x}_reenable() wrappers around vfio_pci_irq_reenable()
for additional ease of use and readability.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h     | 14 ++++++++++++++
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..2e67afc0d580 100644
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
@@ -92,6 +94,12 @@ static inline void vfio_pci_msi_disable(struct vfio_pci_device *device)
 	vfio_pci_irq_disable(device, VFIO_PCI_MSI_IRQ_INDEX);
 }
 
+static inline void vfio_pci_msi_reenable(struct vfio_pci_device *device,
+					 u32 vector, int count)
+{
+	vfio_pci_irq_reenable(device, VFIO_PCI_MSI_IRQ_INDEX, vector, count);
+}
+
 static inline void vfio_pci_msix_enable(struct vfio_pci_device *device,
 					u32 vector, int count)
 {
@@ -103,6 +111,12 @@ static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
 	vfio_pci_irq_disable(device, VFIO_PCI_MSIX_IRQ_INDEX);
 }
 
+static inline void vfio_pci_msix_reenable(struct vfio_pci_device *device,
+					  u32 vector, int count)
+{
+	vfio_pci_irq_reenable(device, VFIO_PCI_MSIX_IRQ_INDEX, vector, count);
+}
+
 static inline int __to_iova(struct vfio_pci_device *device, void *vaddr, iova_t *iova)
 {
 	return __iommu_hva2iova(device->iommu, vaddr, iova);
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
2.55.0.795.g602f6c329a-goog

