Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291908;
	b=r7c6qSwpMmA37fjZecHhBqWel9Nm4yiCAepTq138EHBsN7jz9k4r4tYVT79/8/5p1F1+
	 umDd3gfxC9//EQu3o3L3YtH244tX7W8CpdGMaXs+ZuWJbPFqOjTcksHbkx4UJwxy5eRkG
	 pawAocv5CKVSUmwiBHazoUHmHJXPG0Xi5uzx7ugEmVAyvgnll+YBM+mCRPKncWEuR0zYT
	 +JHe3Ua6jzSVK17PcfhnXoerzF9N39+0/36Oq3R9K6d/BOzzkF0CL4+aEDQ14XOvAuJvg
	 PYK8U5UwoohkHrhZTC/PV0/MZV3dl4XRiMKFlgYtcGN/hGOvxJIK6rVSlIfhtAmzuxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291908;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=+Hcw6ChGcYDsBOLvV15AWtaOoAcXtAbBHg8paBG5N7A=;
	b=YEEKxVhNATSZvQVu1QCopYnaqLrSX6loWaT+IRAGMBb9eUeyCo7kei8QrstVayMT+329
	 kWhUdW/ZUoiygWJ3K1a2URZAClIzyA1ZcaL54UvFrw9JN5uev2zq0E+ri2l2Jo+72lfd0
	 iQRAT25HpVTOBgNBfiWlGAYqFUOvGyuqEnyro7UC64jiqZL20mvR8w8snur4re77MLHcg
	 B0cUMJFekufiLNiFlrvWsslSmY3iW5mhr8Kv2q3Vq5eVFqhgxtVPd5bEbpDg9rskLJKA3
	 GTnD1bLn1l+ajdyt0cf4JzwNnykqc68+V30RLFDrrU8a0uGxqm+tLZbbK3/71buPKzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qey1lgpy;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A94606A32C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A94606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qey1lgpy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793291907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Hcw6ChGcYDsBOLvV15AWtaOoAcXtAbBHg8paBG5N7A=;
	b=Qey1lgpycsUR4+80HHfjFaNieIQaZBbDmuYVxCS+Ek18cciOjDRGUZOkVc0cQzcY+vvaqq
	EQgGT6hOZnk/cIihzAjKdx6FZAT1thvIciljlLWfAUk1fWWHHXMRf7BuO1FNCP1Th6WUwa
	klnaBtxvYMlMa5lX360BuYSshx/NUHg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-IZUHoYpdON-BLUmfP8xBgg-1; Thu,
 29 Oct 2026 12:38:24 -0400
X-MC-Unique: IZUHoYpdON-BLUmfP8xBgg-1
X-Mimecast-MFC-AGG-ID: IZUHoYpdON-BLUmfP8xBgg_1793291901
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6867A1935311;
	Thu, 29 Oct 2026 16:38:21 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5426E1956088;
	Thu, 29 Oct 2026 16:38:16 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jgg@ziepe.ca,
	alex@shazbot.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	bhelgaas@google.com,
	jjohnson@kernel.org
Cc: johannes@sipsolutions.net,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	vkuznets@redhat.com,
	kevin.tian@intel.com,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v3 5/8] ath11k: use KVM MSI domain for VM passthrough
Date: Thu, 29 Oct 2026 17:37:10 +0100
Message-ID: <20261029163713.1366077-6-jtornosm@redhat.com>
In-Reply-To: <20261029163713.1366077-1-jtornosm@redhat.com>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The Qualcomm ath11k firmware programs MSI addresses directly into
device BAR registers for CE/SRNG ring interrupt delivery, bypassing
the standard PCI config MSI path managed by QEMU/VFIO. In a VM, the
firmware receives the guest virtual APIC address instead of the host
IRTE address, causing DMAR faults and non-functional interrupts.

When CONFIG_PCI_KVM_MSI_DOMAIN is enabled, use the KVM PCI MSI domain
synchronization functions to obtain the correct host physical MSI
address after MSI is enabled in power_up. The kvm_pci_msi_wait_ready()
function performs a KVM hypercall to retrieve the host MSI address,
and kvm_pci_msi_get_address() reads the cached values to update the
driver's internal MSI address/data used for ring configuration.

This placement (after msi_enable in power_up) ensures:
- Host MSI is enabled and stable (QEMU has completed setup)
- No MSI state transitions are in progress
- CE/SRNG rings have not been programmed yet
- The function runs on every power_up, including recovery

On baremetal, if CONFIG_PCI_KVM_MSI_DOMAIN is not enabled the code is
compiled out and the behavior is identical to the original. If
CONFIG_PCI_KVM_MSI_DOMAIN is enabled (e.g. distribution kernels), the
KVM MSI functions detect baremetal at runtime and return immediately,
preserving the original behavior with no side effects.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v3: new
v2: https://lore.kernel.org/all/20261011074514.515894-1-jtornosm@redhat.com/

 drivers/net/wireless/ath/ath11k/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 7e29ebaf9773..31889e5caa8d 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -7,6 +7,9 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
+#include <linux/pci-kvm-msi.h>
+#endif
 #include <linux/of.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
@@ -855,6 +858,13 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 
 	ath11k_pci_msi_enable(ab_pci);
 
+#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
+	if (kvm_pci_msi_wait_ready(ab_pci->pdev, 500) > 0)
+		kvm_pci_msi_get_address(ab_pci->pdev, &ab->pci.msi.addr_lo,
+					&ab->pci.msi.addr_hi,
+					&ab->pci.msi.ep_base_data);
+#endif
+
 	ret = ath11k_mhi_start(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to start mhi: %d\n", ret);
@@ -1350,6 +1360,9 @@ module_exit(ath11k_pci_exit);
 
 MODULE_DESCRIPTION("Driver support for Qualcomm Technologies PCIe 802.11ax WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
+#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
+MODULE_SOFTDEP("pre: pci-kvm-msi");
+#endif
 
 /* firmware files */
 MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/*");
-- 
2.56.0

