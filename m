Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207818;
	b=3qqTHCbBfszdPGBgJjuSyEtg+PbQ+Wcw6CBSnoOkSf3iq0bisPt/Crx1cyetvJWlP0i+
	 7NjbEQW3IBAWqYbu/jwC+3o6+myGgmCSNpRo1LGZd52UPO3fBBA81L0GThRwB+SsJaEeQ
	 0widurM7r5ktlDayWCiigvErpiTSZVq2j52zEa5vX7cYvOcRZpn2WQbezd+x9Pb00MUpa
	 aD56wvu8UsYfB1wsy1uXubjofbmz3trU7fQaCK0cJPF+YqcXJHWgrvTlQ2fP2/1t5FScV
	 T4BL3xBhu32AjoTOmv1IhYuWS+59N6oDqKlO6seSi5MVcRKp6kEZUU6Qfz0GY5jBbuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207818;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=Cir+mFJzA4Bj65dFGKcajxs4xlnVmewfcGaQZuCK4tM=;
	b=h8y5tJAClKDhlhYzKLoYpSQBdX9rntUvWuPVR10RP66lEdXEWIosil3sAF01mfAPrhSr
	 zyuahkpJgZKA/l0gdz0fWAo74qY8vDtlRTCnhs8hL44m6TV6LpXlEaJWNHODxQTXu7gIN
	 6L9QSLxphK4nw8LfW3unClwvsFQGy/fuv5Z62lHClvsQ9V9R27hcLzr5SsXUu9yl4Qp/J
	 NWQ7PkMcYGSbuMjNQuEXO2FfESYTO/hW1ORujQe/5eBgrZx5Y6IHfe/6FS0xQyogSFNF7
	 7PO6Vn86vIAvi4HZRaHwKDFE16QtbE42abz3JiHOwr3vycrODhcxU48exlLs83VhQYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TIbm83gz;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S10MriQv;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE928606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE928606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TIbm83gz;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S10MriQv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793207817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cir+mFJzA4Bj65dFGKcajxs4xlnVmewfcGaQZuCK4tM=;
	b=TIbm83gz3t2e8YnhHE2Ua7cRb22Qzsh6Zan0uJpqnYNQ/TjiTlmaVXqznIyEzfNR0DcHih
	eIFJFtY9tEpm+3mAVgPUFqEEdJ0O3KY8/m6uagURD7bqk5l6mVZj0IE0BM7/gMJblr5yHt
	4CC4y76k8HnwzNLD1dX8/C7CKp2m/l8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-976t3IePNTOeolPNkGrxFQ-1; Wed, 28 Oct 2026 13:16:55 -0400
X-MC-Unique: 976t3IePNTOeolPNkGrxFQ-1
X-Mimecast-MFC-AGG-ID: 976t3IePNTOeolPNkGrxFQ_1793207814
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so10989165e9.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793207814; x=1793812614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cir+mFJzA4Bj65dFGKcajxs4xlnVmewfcGaQZuCK4tM=;
        b=S10MriQvo737n7XdQd4O811Z5So9a4Ia4aeMNN0nBQnZGwC4rEmIM7ZzYpBtAwzvt4
         SnI+Rcu1l2ORID9GYjpZXWgb584gqJdu4qKyFnaPYYuCCBpexhEzRNQNd2IjYVpYJFAb
         lK0Y0XDLuveF9FwbYmQ7jb7pmVaOmPrDcJ13f55lUjpZYxOMcvt5AY+m4fpnDHQKuKRb
         IUsNRBMe+fH2lo3qvxk9itoW89HaXAA5w2pAzRSLdDq8l91Jg+IkLockETbyl8wNukEa
         uDQA9mbD1zIHFLHAEYCYnBK0zxeAA9uN/IP2YjY4emjhcAUfi9cJIyhS/jL6jmXxSNie
         3IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207814; x=1793812614;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cir+mFJzA4Bj65dFGKcajxs4xlnVmewfcGaQZuCK4tM=;
        b=J7rxCFkwhSkPQeKPfo04uOP8xF/ohIuIoie0G4ZwSFjLPCcsSTeIlM5HTbeC4wEMZe
         HmZAAGXvXTsIts5ugkDvIvv4otdJbmVG0Hi/kwENORCg2d+VBpcQ9M3As9QmoLZmN3YP
         hxpw5lvcws3sotOmNDNHSLMAj/GWWUil/74j+mUIqMqIi78s2XmHbSqr7cRXlFF1/C4U
         VNu5KxQbgDiguzw2DIHwe4iO5BnwRFYIpYnPGr+gwyvHbexEMupvVpYfVw4pD/yDZjPJ
         Vx19kchg7Q5Dcq9eHjyuQJCYgNcK0fiPgxxao+MpzsAURoWo9+2uTLQQuo8T/jZsbYZo
         KDQw==
X-Forwarded-Encrypted: i=1; AKwUvBwR2GG3K81eJVudr26L7jBBaEsXiES9qHMXYQPmqOVnP9Zc2TLjp9myoQRNxAfCujbSwHE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2psuCBNbfMrK8P+IX+L+p5a08Rc0bhIswhgCWquuhmGnAxTGg
	Rz75vLWf+XjVoDMGWF2j58005q5XZWCD+RWN/d5iCZtUStw8ETfddqgwY8san/UUhFypMp9T3uM
	3tWQubQk2IaGeX+cIcYHeLj8icL4jdgElZlVlaHWiiOZsonDoiUX/smp9fwFxxw==
X-Gm-Gg: AYBFou07jCszKqA3icuo+jJqE1w+ASacTJ8wQnUrF0GEXmaONlMmNXwZGrNE+gkhTl0
	m6Xczz5GxSB3LHZrlOJC0BjGwoxFd5/tismHwokSzBhrKiGgN8/NrTdlmhmgtPqp9aGaY57rJQ6
	6sUUv4M7etKlp0EaMxlKZqe8Bi5+oAOhH78wTzYRKg/NrOt1Xftpd/LwKIuULHO6oAPiWhX3UzF
	W7g/IODTwWyuk843xKSsghbfrqiiHTTEb5Irs3B2m13sinvAqGhsZ+szDhGN2NH5sNkWRNHUmAg
	kNYhoWIpda/znpm06gOIFNVTmmPAjgiCi/kQ970w7eFYlRFr8a3p4bhlrN8TP5yw4k5+AfSaeUf
	/RwIOuICs+Is/aa/0TRWAkGk/j+Pj+BjOv6CTl5FP
X-Received: by 2002:a05:600c:4e55:b0:4a2:1655:87e2 with SMTP id 5b1f17b1804b1-4a966f22108mr68349375e9.19.1793207814268;
        Wed, 28 Oct 2026 10:16:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:4a2:1655:87e2 with SMTP id 5b1f17b1804b1-4a966f22108mr68348525e9.19.1793207813685;
        Wed, 28 Oct 2026 10:16:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm29495209f8f.34.2026.10.28.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:16:53 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: [PULL 65/78] i386/kvm: Use x86_iommu_device_get() for per-device
 IOMMU lookup
Message-ID: <70c046b180c8f85c5199d691c51715dd42a65efb.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

From: Sairaj Kodilkar <sarunkod@amd.com>

Currently, kvm_arch_fixup_msi_route() unconditionally uses the default
system IOMMU for interrupt remapping when IOMMU is present. This
approach fails when an IOMMU is attached to a non-system bus and serves
only a subset of devices, because the kernel does not program IRT
(Interrupt Remapping Table) entries for devices outside the IOMMU's
scope.

This patch changes the behavior to perform per-device IOMMU lookup:
- For PCI devices: Use pci_device_get_x86_iommu() to find the specific
  IOMMU serving that device, if any
- For non-PCI devices (IOAPIC): Fall back to the default IOMMU
  only if interrupt remapping is enabled (ioapic_as != address_space_memory)

This ensures MSI route translation occurs only for devices actually
managed by an IOMMU, enabling proper interrupt remapping in configurations
where IOMMUs are attached to arbitrary buses.

NOTE: This patch assumes that only non-PCI device calling is IOAPIC and
checks ioapic_as to determine interrupt remapping.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261014053433.24564-6-sarunkod@amd.com>
---
 hw/intc/ioapic.c      |  3 ++-
 target/i386/kvm/kvm.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 1932b14642..e171cf8432 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -438,8 +438,9 @@ static void ioapic_machine_done_notify(Notifier *notifier, void *data)
 #ifdef ACCEL_GSI_IRQFD_POSSIBLE
     IOAPICCommonState *s = container_of(notifier, IOAPICCommonState,
                                         machine_done);
+    X86MachineState *x86ms = X86_MACHINE(qdev_get_machine());
 
-    if (accel_irqchip_is_split()) {
+    if (accel_irqchip_is_split() && x86ms->ioapic_as != &address_space_memory) {
         X86IOMMUState *iommu = x86_iommu_get_default();
         if (iommu) {
             /* Register this IOAPIC with IOMMU IEC notifier, so that
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index da922f72d7..072da8b9f1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6746,7 +6746,15 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-    X86IOMMUState *iommu = x86_iommu_get_default();
+    X86IOMMUState *iommu = NULL;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    X86MachineState *x86ms = X86_MACHINE(ms);
+
+    if (dev) {
+        iommu = x86_iommu_device_get(dev);
+    } else if (x86ms->ioapic_as != &address_space_memory) {
+        iommu = x86_iommu_get_default();
+    }
 
     if (iommu) {
         X86IOMMUClass *class = X86_IOMMU_DEVICE_GET_CLASS(iommu);
@@ -6848,6 +6856,7 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
 {
     static bool notify_list_inited = false;
     MSIRouteEntry *entry;
+    X86IOMMUState *iommu = NULL;
 
     if (!dev) {
         /* These are (possibly) IOAPIC routes only used for split
@@ -6867,13 +6876,13 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
     if (!notify_list_inited) {
         /* For the first time we do add route, add ourselves into
          * IOMMU's IEC notify list if needed. */
-        X86IOMMUState *iommu = x86_iommu_get_default();
+        iommu = x86_iommu_device_get(dev);
         if (iommu) {
             x86_iommu_iec_register_notifier(iommu,
                                             kvm_update_msi_routes_all,
                                             NULL);
+            notify_list_inited = true;
         }
-        notify_list_inited = true;
     }
     return 0;
 }
-- 
MST

