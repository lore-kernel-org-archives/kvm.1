Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E933806CC
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517962; cv=none; b=cru8OMSnWIW59/r19coexrL0lQVtgF7FKedOvSrIQSwEPUbTYIrT5DxtZ7YawOKNHUsGTWCyjBWwZh1MNfrqVGT6fQwexHCTQuWddj4n6yildaVfm+16Pul1wV1QUuTpI6nTDB8Q0MXS33EQoNaiPim4cR89LuNv7WBCC8D0EoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517962; c=relaxed/simple;
	bh=m5c+ccLYXR5ymz8ROG8r7MEHITmLJNROuh0xkKUaH2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icAxH54bxF9+2IC+P4kaTtinqXExRAPNT2KHBUc+Ee2I238sL2LOuCBxBgTmDVkXeQYNy6Dgh1mKYHmUFtiuQDiptawZnMjo7WX4IKCtk/Tq1QYfc1GDx9LB+Y6Ff63dRGr3a3EgwFIJIePX+tJZ3NqOhSzvuw2ESb/eljHoNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9OVWZuw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9OVWZuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783517960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/k7wJHHf1drTOERq04oriQIq1stfFuLb0fCEeKENTU=;
	b=G9OVWZuwiECzOM2P5pE/xKQLouLQDKJsvaENIRA82hP+iBghLIuqbjfOQ2jzvyxu+XiJFM
	h1mZgvxEsvxe2Pa0paLqGgYyCpHyfPR1bdSwe77EAf/kOf5+0aQON5kA6soAz0XbTrkKRP
	D/oILGYjlg7rlfGPOPE2CZA3gGEUZVE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-xXdVoeY7NySIpfzcz9kKXw-1; Wed,
 08 Jul 2026 09:39:18 -0400
X-MC-Unique: xXdVoeY7NySIpfzcz9kKXw-1
X-Mimecast-MFC-AGG-ID: xXdVoeY7NySIpfzcz9kKXw_1783517957
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83D61195609D;
	Wed,  8 Jul 2026 13:39:17 +0000 (UTC)
Received: from work.fritz.box (unknown [10.44.49.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CEED3000C13;
	Wed,  8 Jul 2026 13:39:14 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 2/2] KVM: x86: Document APIC base address constraint for in-kernel irqchip
Date: Wed,  8 Jul 2026 15:38:55 +0200
Message-ID: <20260708133856.302151-3-twiederh@redhat.com>
In-Reply-To: <20260708133856.302151-1-twiederh@redhat.com>
References: <20260708133856.302151-1-twiederh@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When virtual APIC access acceleration is enabled (APICv on Intel, AVIC
on AMD), vcpu creation installs a private memory slot at the default
APIC base address (0xfee00000).  If a user memory region overlaps this
address, vcpu creation fails with EEXIST.  The same error occurs when
installing an overlapping user memory region after vcpu creation.

This also applies when using KVM_CAP_SPLIT_IRQCHIP.

This constraint is not documented anywhere.  Add a note to the
KVM_CREATE_IRQCHIP and KVM_CAP_SPLIT_IRQCHIP documentation.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 Documentation/virt/kvm/api.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 270c3f0d668f..8a6210b4cd56 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -863,6 +863,14 @@ KVM_CREATE_DEVICE, which also supports creating a GICv2.  Using
 KVM_CREATE_DEVICE is preferred over KVM_CREATE_IRQCHIP for GICv2.
 On s390, a dummy irq routing table is created.
 
+On x86, vcpu creation may install a private 4 KiB memory slot at the default
+APIC base address (0xfee00000).  User memory regions must not overlap this
+address; doing so will cause vcpu creation to fail with ``EEXIST``, or the
+memory region to be rejected if created after the vcpu.  This occurs when
+APIC access acceleration is enabled (APICv on Intel, AVIC on AMD), which is
+the default on supported hardware.  The same constraint applies when using
+``KVM_CAP_SPLIT_IRQCHIP``.
+
 Note that on s390 the KVM_CAP_S390_IRQCHIP vm capability needs to be enabled
 before KVM_CREATE_IRQCHIP can be used.
 
@@ -7921,6 +7929,10 @@ used in the IRQ routing table.  The first args[0] MSI routes are reserved
 for the IOAPIC pins.  Whenever the LAPIC receives an EOI for these routes,
 a KVM_EXIT_IOAPIC_EOI vmexit will be reported to userspace.
 
+As with ``KVM_CREATE_IRQCHIP``, vcpu creation may install a private memory
+slot at the APIC base address (0xfee00000) that must not overlap user memory
+regions.  See ``KVM_CREATE_IRQCHIP`` for details.
+
 Fails if VCPU has already been created, or if the irqchip is already in the
 kernel (i.e. KVM_CREATE_IRQCHIP has already been called).
 
-- 
2.52.0

