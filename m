Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8853F7897
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932081; cv=none; b=bT81MLnXdM8ZkFkp4WnxOhT411H72Qqp4a0xulvvL8mRUlLVkHQfBkykrE+On3iEIkCDIo2TKdjtwjbkpxE0uwLUHI2ASs8/cr2ccsxAaDO4yjA561Ju7rOnMtPPJThiEXmSj7BF4boAR1wamxHZeiPuqDmkms0Dn6o214Ya0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932081; c=relaxed/simple;
	bh=jD+5YzYt/ja2jVYAJmHM+1HKagzMUvVMpUGxMkd3Wgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+luSsbYwanxNxV2hAAqC0mLD4iaqHgWDk+fOMMh3G/BMs0gQSjOgbV3Z6SLlJtN4Gvd5XtjXlg/x22QnS/eymlGhcLlo5Wdereegkiq6as4hZffC+PoxNeFibhJ2gh5TWa/f9+pi6t+ioAP1LBsRtKZl88x1HHrikTEiPQfOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 27BC920294A;
	Mon,  8 Jun 2026 17:21:16 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org,
	marcel.apfelbaum@gmail.com,
	zhao1.liu@intel.com,
	berrange@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com,
	mtosatti@redhat.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [RFC PATCH 09/10] MSI: Inject into correct plane
Date: Mon,  8 Jun 2026 17:21:08 +0200
Message-ID: <20260608152109.356783-10-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Inject MSI and MSI-X IRQs into the correct device plane.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/kvm/kvm-all.c  | 2 +-
 hw/i386/kvm/apic.c   | 6 +++++-
 hw/pci/msi.c         | 3 +++
 hw/pci/msix.c        | 3 +++
 include/hw/pci/msi.h | 1 +
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c5fe6d189e62..31d80f7ac48b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2407,7 +2407,7 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg)
     msi.flags = 0;
     memset(msi.pad, 0, sizeof(msi.pad));
 
-    return kvm_vm_ioctl(s, KVM_SIGNAL_MSI, &msi);
+    return kvm_vm_plane_ioctl(s, msg.plane_id, KVM_SIGNAL_MSI, &msi);
 }
 
 int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 82355f04631a..4dd946d6f26b 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -210,7 +210,11 @@ static uint64_t kvm_apic_mem_read(void *opaque, hwaddr addr,
 static void kvm_apic_mem_write(void *opaque, hwaddr addr,
                                uint64_t data, unsigned size)
 {
-    MSIMessage msg = { .address = addr, .data = data };
+    MSIMessage msg = {
+	    .address = addr,
+	    .data = data,
+	    .plane_id = qdev_default_plane(),
+    };
 
     kvm_send_msi(&msg);
 }
diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index b9f5b45920b6..d0373131dd06 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -142,6 +142,7 @@ static MSIMessage msi_prepare_message(PCIDevice *dev, unsigned int vector)
     uint16_t flags = pci_get_word(dev->config + msi_flags_off(dev));
     bool msi64bit = flags & PCI_MSI_FLAGS_64BIT;
     unsigned int nr_vectors = msi_nr_vectors(flags);
+    DeviceState *dev_state= DEVICE(dev);
     MSIMessage msg;
 
     assert(vector < nr_vectors);
@@ -159,6 +160,8 @@ static MSIMessage msi_prepare_message(PCIDevice *dev, unsigned int vector)
         msg.data |= vector;
     }
 
+    msg.plane_id =  dev_state->plane;
+
     return msg;
 }
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 1b23eaf10079..1773f8eccae8 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -37,10 +37,13 @@
 static MSIMessage msix_prepare_message(PCIDevice *dev, unsigned vector)
 {
     uint8_t *table_entry = dev->msix_table + vector * PCI_MSIX_ENTRY_SIZE;
+    DeviceState *dev_state= DEVICE(dev);
     MSIMessage msg;
 
     msg.address = pci_get_quad(table_entry + PCI_MSIX_ENTRY_LOWER_ADDR);
     msg.data = pci_get_long(table_entry + PCI_MSIX_ENTRY_DATA);
+    msg.plane_id = dev_state->plane;
+
     return msg;
 }
 
diff --git a/include/hw/pci/msi.h b/include/hw/pci/msi.h
index abcfd1392521..6bedf97b6f03 100644
--- a/include/hw/pci/msi.h
+++ b/include/hw/pci/msi.h
@@ -26,6 +26,7 @@
 struct MSIMessage {
     uint64_t address;
     uint32_t data;
+    uint8_t plane_id;
 };
 
 extern bool msi_nonbroken;
-- 
2.53.0

