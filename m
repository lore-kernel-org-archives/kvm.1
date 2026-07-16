Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF443551C
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225782; cv=none; b=qW3EwM3lNBJA+An1tNzZbKmzkwjzXlNH+NtTsKKTgP0pAFRmauGxqfcOiHiWRzHDXTftdiXokDz3p58+Hpg0cda9augU+Qvtz8VClwE2ufjh+jfZRb5sx3De2SFahKpvmFqzHBZyHCqad2sRKi+qTgtuBz0FCsW9Zt2IrGEwf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225782; c=relaxed/simple;
	bh=ymQ1dL8MxCQZw1HZ3sOtC6Cl0rDVVCH/oyQIhxYOd84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnKvQHy51U8eTVlsdVgfbZdegbw7XB4yH5/R5e/+Xxv9HWdB/pMoZOiYTkF15qFi2sRe+sdzTTCcQpb+ajROfzrCIc6jv+EYEDMY3XzEl9Py07eg1/uz0T7C4TuFBqaMo7IqLhTjSDRa9HeIy0xjGwW2e3mFxqAjT57KJyk/AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQWCw/wz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQWCw/wz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h40LU/DLcCjOqTvxof1lSNIVRlTqzpnwdFbpy6VN+1Y=;
	b=NQWCw/wzdjJQNif7/tDe0wS8yz1nBFukdI5oEnRt/AMtT3e7p4m074MwFQ52l832wpe9qN
	/ivHziC9TWCRlmVVeVDPfKecO7ZlTDvXnA0CB79sdlE/YWtHOl/cUGuKw/cWp/9LdeJ/Q5
	6/jlE3YWfXQ8BHzaav/2lWl8W5r9CGs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-e269NZb_Mlmuy1RwAhf36A-1; Thu,
 16 Jul 2026 14:15:04 -0400
X-MC-Unique: e269NZb_Mlmuy1RwAhf36A-1
X-Mimecast-MFC-AGG-ID: e269NZb_Mlmuy1RwAhf36A_1784225703
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A36718001F3;
	Thu, 16 Jul 2026 18:15:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95632195604E;
	Thu, 16 Jul 2026 18:15:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 08/24] KVM: pass kvm == NULL case to kvm_arch_has_private_mem
Date: Thu, 16 Jul 2026 14:14:40 -0400
Message-ID: <20260716181456.402786-9-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allow the architecture-specific code to enable CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
without exposing KVM_MEMORY_ATTRIBUTE_PRIVATE.  This is mostly for
consistency after introducing memory protection attributes; an
architecture like Arm might want to add support for
KVM_MEMORY_ATTRIBUTE_PRIVATE without having the protection
attributes show up in KVM_CHECK_EXTENSION.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d0c1d0ab03c2..5d329fbb8acb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2005,7 +2005,7 @@ enum kvm_intr_type {
 	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-#define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
+#define kvm_arch_has_private_mem(kvm) (!(kvm) || (kvm)->arch.has_private_mem)
 #endif
 
 #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4ecc3579d163..fa4473d7c920 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2421,7 +2421,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
-	if (!kvm || kvm_arch_has_private_mem(kvm))
+	if (kvm_arch_has_private_mem(kvm))
 		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
 
 	return 0;
-- 
2.52.0


