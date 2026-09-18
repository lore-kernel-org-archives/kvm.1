Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BC50AC38
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739449; cv=none; b=JPm6Qk1YXoEGXbgkKOxxh6v3i2mcaoruop+d6HMrbv3CfqFjIo+GlgCYu2dfL01/ui3sbGkzclcS8JcSo6Doon+SRqbx+kApgonGU6cyRBNzgi1MBGXpaYqdel4BqLazj3jkZWMygAHVJsM69CWGFlCVz7u7J3canQaiY6N1op0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739449; c=relaxed/simple;
	bh=Tcp4fTVI0amjVPArGkLYPcjTd7iV6Y46W81dENOVLnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+kXCg30QhGugmF+XhpMhIZUvcUkuz2jzq13Zf0+5g0Vcuz8xJlJ27VlFJCAw3lBuonXqeZj8UqlJJobJDBaLDt1QErgXt/SV/5rDj+Sy09RsnnqnKgBGkDnw7zTTLvmpdbxWxspeu3zrz6cBaMH1JiJGPfesYOnBb7ZGK2AZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SF+mqfIG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SF+mqfIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVXB86C7ZXFdBtEEXIU4ekHGfWImSWkvjDcOJJv1cy4=;
	b=SF+mqfIGe2RNjH9MDs0CT5OwBwUoWFCByIxFo53SgQbm/hsrptIGmvCJaSgO09lIKofrwR
	WMF/DSxz5gpJIYiTPgUY2ijr+2jGbCgUJA+C8OjLJhg3oCOzAESNBVRJpSbcbHVs/jXPDO
	AE+MQIFpxl3qSaBoZSxlgcwQTpzWGdU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-hxzArmmHOwiX1wN4QfWyww-1; Fri,
 18 Sep 2026 09:50:42 -0400
X-MC-Unique: hxzArmmHOwiX1wN4QfWyww-1
X-Mimecast-MFC-AGG-ID: hxzArmmHOwiX1wN4QfWyww_1789739441
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0CFD19540E2;
	Fri, 18 Sep 2026 13:50:41 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03E23433;
	Fri, 18 Sep 2026 13:50:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 11/31] KVM: pass kvm == NULL case to kvm_arch_has_private_mem
Date: Fri, 18 Sep 2026 09:50:10 -0400
Message-ID: <20260918135030.171564-12-pbonzini@redhat.com>
In-Reply-To: <20260918135030.171564-1-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Allow the architecture-specific code to enable
CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES without exposing
KVM_MEMORY_ATTRIBUTE_PRIVATE.  This is mostly for consistency after
introducing memory protection attributes; non-x86 architectures
might want to add support for protection attributes without having
KVM_MEMORY_ATTRIBUTE_PRIVATE show up in KVM_CHECK_EXTENSION.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c08781bb0327..c619552740a8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1853,7 +1853,7 @@ enum kvm_intr_type {
 	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-#define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
+#define kvm_arch_has_private_mem(kvm) (!(kvm) || (kvm)->arch.has_private_mem)
 #endif
 
 #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3d574e16de45..9d1836382d19 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2422,7 +2422,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
-	if (!kvm || kvm_arch_has_private_mem(kvm))
+	if (kvm_arch_has_private_mem(kvm))
 		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
 
 	return 0;
-- 
2.52.0


