Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2193803CC
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517960; cv=none; b=skZOFD+OVHPcYHACz8+5l4r+Ce3Lo91GNOaOLB45RZC9jMhzs7Xs5MAEeelPJObhm0niavGlN5E4GcsAo3CbrD9Egpq4MsLCuRIwfa3Htw3lvGYZpwZO5VYTjjZwofFuttzpx5SSP22Jv3EgS7wVeEPpB87aU3fcghMQt5hUIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517960; c=relaxed/simple;
	bh=S5h10yVlLg4hm4QfhjnsGPEF0EdYHi9GPMixAWGm46U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4VwJRLxjwJHnU5Oa9tSlfqSS4W706PWFD/gpPzLaulJVoc94up01eHHsJ3FkIo9asJJOhQMV72frLB8jR7j9nhLUxXwmX+hU1HKfwhsnC+fRBwR8GSbSqvC1r+fIeh+tsvNLXRogVILt+ljm88PMlAKdwYuCR6rX8iKEAD1WFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEon1BSx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEon1BSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783517958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itPDcsMF108vlvA8pNHNzQIyWhr1PaF6rs0r2BP78Kg=;
	b=NEon1BSxGjveHdZ7CRG637vlI/UyPN51yQcnGQoZhw2sJdePSyRnTof412OMeN8L1y1Hea
	EqfHUpFRetxlTaDbxFwQ8hFn0KNHUsHS3rxifw/2/ZXmtj7n8V3OtYIPzigx1pNUENGN25
	scmf9ao28ATPuBupNBdfABkvhXGOmw8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-zToPt1-oNhSaZ4ssrsWp2g-1; Wed,
 08 Jul 2026 09:39:15 -0400
X-MC-Unique: zToPt1-oNhSaZ4ssrsWp2g-1
X-Mimecast-MFC-AGG-ID: zToPt1-oNhSaZ4ssrsWp2g_1783517954
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34E581955F75;
	Wed,  8 Jul 2026 13:39:14 +0000 (UTC)
Received: from work.fritz.box (unknown [10.44.49.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE48C3000C1F;
	Wed,  8 Jul 2026 13:39:11 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 1/2] KVM: x86: Document that KVM_CREATE_IRQCHIP must precede vcpu creation
Date: Wed,  8 Jul 2026 15:38:54 +0200
Message-ID: <20260708133856.302151-2-twiederh@redhat.com>
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

The kernel rejects KVM_CREATE_IRQCHIP with -EINVAL if any vcpus have
already been created, but the API documentation does not mention this
constraint.  Add a note.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 Documentation/virt/kvm/api.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..270c3f0d668f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -856,7 +856,8 @@ Writes the floating point state to the vcpu.
 Creates an interrupt controller model in the kernel.
 On x86, creates a virtual ioapic, a virtual PIC (two PICs, nested), and sets up
 future vcpus to have a local APIC.  IRQ routing for GSIs 0-15 is set to both
-PIC and IOAPIC; GSI 16-23 only go to the IOAPIC.
+PIC and IOAPIC; GSI 16-23 only go to the IOAPIC.  This ioctl can only be
+called before creating any vcpus.
 On arm64, a GICv2 is created. Any other GIC versions require the usage of
 KVM_CREATE_DEVICE, which also supports creating a GICv2.  Using
 KVM_CREATE_DEVICE is preferred over KVM_CREATE_IRQCHIP for GICv2.
-- 
2.52.0

