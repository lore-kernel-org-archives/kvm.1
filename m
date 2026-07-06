Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC8414A00
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329666; cv=none; b=lUQXIrSPbwGF1Htfc2kQenjIIYgdmJ2eW7//tnLjXrIrbe7BpTmYPTsieFkDn6uAL3O4UXiaskpMKdAdF4x8XEIqAx3n5aVFoaFgWtGAtyBRg7XF8PwUWilTDy6ho1j7hxJ+asnMuzNyyrBDxE2zcE2AI+63zv/48s8Q+9Ij+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329666; c=relaxed/simple;
	bh=Yrz1Fq6b88EE+W89sFB/veSJ+k7HVMWjSjStIWtyYHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsmPYL4Q9qei1rFDeYc4EStmU5NTwcSwxd9sJVxPLbGvWy19zN9kSsAw4gczmozDajRb9ZBzJvbkmf5DNH0JqG2K8y4+IHhWx9KHIBJcy3p0eBr8i56rc3GwTdl1fCpq4W4bwJaeWOg4kWJ2hx4z7MKM1ZzprLV5lcNmy87Lk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdX31+M0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdX31+M0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/UZc0NPyToGXboMyOX1I0EMuMdZ493ROXRw7IM/VtY=;
	b=LdX31+M0lGjdFzwq2PoLPITti0kqdChK19JLlaEY9+X1uSJugLao8fHM7fnMfZn7S1J6yD
	y3tRFs4b8aTIpiHppcgHsRdmOos78jMIYDNMMR+Bml3u5M+zUrqjWk2kK1fgVIWgXVmX2/
	HK4UFc3qmcJYyvwYk7iMYJo7cOpPRXg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-GpKailxSPvmYMt6V6S5bew-1; Mon,
 06 Jul 2026 05:20:57 -0400
X-MC-Unique: GpKailxSPvmYMt6V6S5bew-1
X-Mimecast-MFC-AGG-ID: GpKailxSPvmYMt6V6S5bew_1783329655
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FECE1802678;
	Mon,  6 Jul 2026 09:20:55 +0000 (UTC)
Received: from work.fritz.box (unknown [10.44.49.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74E14300070A;
	Mon,  6 Jul 2026 09:20:53 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 2/4] KVM: x86: Document APIC base address constraint for in-kernel irqchip
Date: Mon,  6 Jul 2026 11:20:17 +0200
Message-ID: <20260706092021.3625908-4-twiederh@redhat.com>
In-Reply-To: <20260706092021.3625908-2-twiederh@redhat.com>
References: <20260706092021.3625908-2-twiederh@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When an in-kernel irqchip is enabled, vcpu creation installs a private
4 KiB memory slot at the default APIC base address (0xfee00000).  If a
user memory region overlaps this slot, vcpu creation fails with EEXIST.
The same error occurs when installing an overlapping user memory region
after vcpu creation.

This constraint is not documented anywhere.  Add a note to the
KVM_CREATE_IRQCHIP documentation.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 Documentation/virt/kvm/api.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index ec5bf99ff8b8..da8beb80699a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -863,6 +863,11 @@ KVM_CREATE_DEVICE, which also supports creating a GICv2.  Using
 KVM_CREATE_DEVICE is preferred over KVM_CREATE_IRQCHIP for GICv2.
 On s390, a dummy irq routing table is created.
 
+On x86, when an in-kernel irqchip is enabled, KVM reserves a private memory
+slot for the local APIC at the default APIC base address (0xfee00000).  User
+space must not map guest memory that covers this address and must leave a 4 KiB
+hole in the guest physical memory map at this address.
+
 Note that on s390 the KVM_CAP_S390_IRQCHIP vm capability needs to be enabled
 before KVM_CREATE_IRQCHIP can be used.
 
-- 
2.52.0

