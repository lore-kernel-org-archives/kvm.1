Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D499414DE2
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329662; cv=none; b=oVPYb2ifsl/MJXlJcn7nc/MvjeYp/GTpiVWc15jDo1xh1Zb8dbKiUG+z8gvXlk0vNHEdhWiF5OqN0ZDY3Wd2o5LnZt9uNReNuj4DhbU+tBwyPsIlhY4b5+ZEp65M7SpWW9Uetyb60gc6Z2nC6B8/mwcvDWX4YcD+MVFXEBPRDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329662; c=relaxed/simple;
	bh=SQH7RsdEnyNfeS7eCNOEXp6G0v6D4JYiJ63zj8DGjCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gedklcZUsYO/Of5mHeMKqJH0v0fUCr2Iw8V9e4vHqlNguLhDbTmq0hjkKIzIS7NvBjiwFSvdvtv4Yuffjke90KQ9ZTxv7b0uH0coKh/f85PVurBy46RbpX8fnmUGBiJ8xsCQBw8LsqFgMVHufu82mil0AvbdBVWPYcKhhUg4GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGb7We/B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGb7We/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQxyf8gFubuHQRk62vioXACqbVSli2rzreFz2EP145g=;
	b=TGb7We/Blz/KKx+w21uuI66IVR0rRQcJhE2SwDn1UrzyYq9zY2rBlQYhMMzIhZ1StM8H2H
	3qCtJzt1gWSYvYp7xjDvVJcd8h6yhn75FECtdJcQXMXmRdWl084gykIPsJR4paMKMjAl3C
	0aYkOzgVm0AEHYILW7zbLED2pzsCsg4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-UeKAIWzAN0y0LEMF522luw-1; Mon,
 06 Jul 2026 05:20:54 -0400
X-MC-Unique: UeKAIWzAN0y0LEMF522luw-1
X-Mimecast-MFC-AGG-ID: UeKAIWzAN0y0LEMF522luw_1783329652
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A37841955F11;
	Mon,  6 Jul 2026 09:20:52 +0000 (UTC)
Received: from work.fritz.box (unknown [10.44.49.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79E91300070A;
	Mon,  6 Jul 2026 09:20:50 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 1/4] KVM: x86: Document that KVM_CREATE_IRQCHIP must precede vcpu creation
Date: Mon,  6 Jul 2026 11:20:16 +0200
Message-ID: <20260706092021.3625908-3-twiederh@redhat.com>
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

The kernel rejects KVM_CREATE_IRQCHIP with -EINVAL if any vcpus have
already been created, but the API documentation does not mention this
requirement.  Add a note.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 Documentation/virt/kvm/api.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..ec5bf99ff8b8 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -856,7 +856,8 @@ Writes the floating point state to the vcpu.
 Creates an interrupt controller model in the kernel.
 On x86, creates a virtual ioapic, a virtual PIC (two PICs, nested), and sets up
 future vcpus to have a local APIC.  IRQ routing for GSIs 0-15 is set to both
-PIC and IOAPIC; GSI 16-23 only go to the IOAPIC.
+PIC and IOAPIC; GSI 16-23 only go to the IOAPIC.  This ioctl must be called
+before creating any vcpus.
 On arm64, a GICv2 is created. Any other GIC versions require the usage of
 KVM_CREATE_DEVICE, which also supports creating a GICv2.  Using
 KVM_CREATE_DEVICE is preferred over KVM_CREATE_IRQCHIP for GICv2.
-- 
2.52.0

