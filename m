Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291932;
	b=0G8sdH/1RfKC3Jwcpv8dkGBAtXJibP4L8wlEvfJH+V+NI2UzwzXxQXMfeoxCq4NyAahz
	 rAQSpwtswRCii92ERdyAaH650QrhTjrN+lD19XNR1mx4cg+ds6SwKzPdtS7TTVDxCvQen
	 X8EdzSMRrNjU35KgehcGFIKvUt5Gpzu2mnLpyprPttNHTJ1MpSLxnvmT44eYaK8UcD4Fd
	 FCXR+Xl6HaQh4jI7NCFOuu+xtCfatK+ojY4PE0hlcXO/a8sVM2fJU+fxSZnzO52A71odK
	 rv4sQlWhHh2vwuyecSoG+joIYu6OIz9ttBtHBK7wfhs5HbiT9mi4Lb14lUScYSr2VzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291932;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=4UgMdOKrtB64nXpcXBIKe/cthT0pJUT9b78xEaySiIs=;
	b=LPrqhC3kcJW8gq2CL5neVTCX0xEJMUzque62LI1BjXz73I1ALK+0dzyNVuttQPQ6CtVF
	 sOTRFd1jjjWXP+fu4CIdvcPXAfPEXPrvs8tCid1YGsiCh55NhhPZfe6RTzlxtobtXXjH+
	 c4xQyBpVkDB/u03RC0k5hahtbkDs+4wDbg8cryooTbKpA241s5uqwr3HZ7uvhM1oDV2Fb
	 AFWNV/SZvnogMQ395AQVY9FYcF8n+QJs3Hj2CVmr3Ow1Kd+jzocHNKYAFz/qR8go8qpDx
	 ulkX9AxzdNwO8wzck7AHRsQTW3SZp8QBhMVzq03guOy/bSGBfwouEr9h0V24Idb9Mkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GkT7oq4S;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD3606A32A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0DD3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GkT7oq4S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793291931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UgMdOKrtB64nXpcXBIKe/cthT0pJUT9b78xEaySiIs=;
	b=GkT7oq4S9+SzKjsVAVUAmgaPS6OlOnOIQyVxUTVNQMWGKaPErwH5WgPm6R+yxNlHfsICpV
	dj1NDYxTxjwMcJOrVfgWuKTwFrLACj7orZIKvlXr9w8w/8F3HzzYgycKgLvA+MSo+dkSYE
	buoHXIpFHgJUfirePz/zIexgYhjlwe4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-3zgHXh3SP9WTJ94dViTHCQ-1; Thu,
 29 Oct 2026 12:38:43 -0400
X-MC-Unique: 3zgHXh3SP9WTJ94dViTHCQ-1
X-Mimecast-MFC-AGG-ID: 3zgHXh3SP9WTJ94dViTHCQ_1793291921
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 613891809C8F;
	Thu, 29 Oct 2026 16:38:41 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30FD81955F0A;
	Thu, 29 Oct 2026 16:38:37 +0000 (UTC)
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
Subject: [PATCH v3 7/8] ath12k: use KVM MSI domain for VM passthrough
Date: Thu, 29 Oct 2026 17:37:12 +0100
Message-ID: <20261029163713.1366077-8-jtornosm@redhat.com>
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

The Qualcomm ath12k firmware programs MSI addresses directly into
device BAR registers for CE/SRNG ring interrupt delivery, bypassing
the standard PCI config MSI path managed by QEMU/VFIO. In a VM, the
firmware receives the guest virtual APIC address instead of the host
IRTE address, causing DMAR faults and non-functional interrupts.

When CONFIG_PCI_KVM_MSI_DOMAIN is enabled, use the KVM PCI MSI domain
synchronization functions:

1. In power_up, after msi_enable, call kvm_pci_msi_wait_ready() to
   retrieve and cache the host physical MSI address via KVM hypercall.

2. In ath12k_pci_get_msi_address(), call kvm_pci_msi_get_address() to
   return the cached host MSI address instead of reading from PCI
   config (which contains the guest virtual address in a VM).

Unlike ath11k which caches MSI address once during power_up, ath12k
reads MSI address on-the-fly via get_msi_address() each time rings
are configured. The kvm_pci_msi_get_address() function provides the
cached host values from a previous successful wait_ready call.

On baremetal, if CONFIG_PCI_KVM_MSI_DOMAIN is not enabled the code is
compiled out and the behavior is identical to the original. If
CONFIG_PCI_KVM_MSI_DOMAIN is enabled (e.g. distribution kernels), the
KVM MSI functions detect baremetal at runtime and return immediately,
preserving the original behavior with no side effects.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v3: new
v2: https://lore.kernel.org/all/20261011074514.515894-1-jtornosm@redhat.com/

 drivers/net/wireless/ath/ath12k/pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index f7879fb48d32..dbd960f88d38 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -8,6 +8,9 @@
 #include <linux/interrupt.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
+#include <linux/pci-kvm-msi.h>
+#endif
 #include <linux/time.h>
 #include <linux/vmalloc.h>
 
@@ -1082,6 +1085,11 @@ void ath12k_pci_get_msi_address(struct ath12k_base *ab, u32 *msi_addr_lo,
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
 
+#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
+	if (kvm_pci_msi_get_address(pci_dev, msi_addr_lo, msi_addr_hi, NULL))
+		return;
+#endif
+
 	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
 			      msi_addr_lo);
 
@@ -1485,6 +1493,10 @@ int ath12k_pci_power_up(struct ath12k_base *ab)
 
 	ath12k_pci_msi_enable(ab_pci);
 
+#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
+	kvm_pci_msi_wait_ready(ab_pci->pdev, 500);
+#endif
+
 	if (ath12k_fw_feature_supported(ab, ATH12K_FW_FEATURE_MULTI_QRTR_ID))
 		ath12k_pci_update_qrtr_node_id(ab);
 
@@ -1886,3 +1898,6 @@ EXPORT_SYMBOL(ath12k_pci_unregister_driver);
 /* firmware files */
 MODULE_FIRMWARE(ATH12K_FW_DIR "/QCN9274/hw2.0/*");
 MODULE_FIRMWARE(ATH12K_FW_DIR "/WCN7850/hw2.0/*");
+#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
+MODULE_SOFTDEP("pre: pci-kvm-msi");
+#endif
-- 
2.56.0

