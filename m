Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E73921DC
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719369; cv=none; b=QkS6JuPWQT3tti/FTxfnkxqd9nDV6vNrfRazVux31Y9kIBhoHWkhR5BhlBgBkCfMl8M+Nt3ui3g1fXqftf9NCNddVKHmgjPzk015Qt7Y5oKBYbDt5P1CwcjRDNLUgTAVg0Z07l8GONo8gV7QuuV0dFmm1oLJjOypgb+3QF7mdhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719369; c=relaxed/simple;
	bh=KFbaMqbiLFRP87KR2IT5l978ib4/M2BclxnGHkZsbZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlCC+pDOOpIiTwzuqB28u7/hlELcOVBfTXfNMX/8mpX7QX0eKuix5qEPRw4kQKCUIBL7tkb26NtJ02wryFCbMGKAGlM5YdJUIMgaQs/Ji5oQjlYdkX3CIntFsI0+eByUkNLQ293qJNmo452BYZjPbv3kee3lY6PJGRn7MUnRMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIBa5Agc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIBa5Agc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZw+s9+hNkGrvJFNAo5F/Jik+U9iZGIw5s6mYsPaxqg=;
	b=cIBa5AgcQpCfj5F0H9uZpg3S0WYl2oiWihPiQgKX/0+rYdpAMqvO20pBaM7liqI5v/O6N+
	54wAy449StjFASfrb/S0ecuWjgfk2Tyxde3PeNvi8RZyNSI4Lup5lioYAAW2GFXSCcGZI1
	rmLLAPtN7Lb1lwy+ZDqmPPmiMVhNm6s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-kIxNs8okMZKEfFLXOTofQA-1; Fri,
 18 Sep 2026 04:15:55 -0400
X-MC-Unique: kIxNs8okMZKEfFLXOTofQA-1
X-Mimecast-MFC-AGG-ID: kIxNs8okMZKEfFLXOTofQA_1789719354
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 649A519560B3;
	Fri, 18 Sep 2026 08:15:54 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA0B730001A2;
	Fri, 18 Sep 2026 08:15:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 11/28] KVM: adjust for presence of more than one attribute
Date: Fri, 18 Sep 2026 04:15:26 -0400
Message-ID: <20260918081543.139871-12-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Remove or adjust code that assumed that the only valid attribute was
KVM_MEMORY_ATTRIBUTE_PRIVATE, in preparation for the introduction of RWX
memory attributes.

In particular, the optimization in kvm_range_has_memory_attributes
simply is not valid if attrs == 0 but some of the attributes are being
ignored.  The WARNs in arch/x86/kvm/mmu/mmu.c are just a duplicate of
checking kvm_supported_mem_attributes() during the ioctl, so drop it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 9 +--------
 virt/kvm/kvm_main.c    | 6 ++++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ba462c671f7d..77d9c62d2a07 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8140,9 +8140,6 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 	 * Zapping SPTEs in this case ensures KVM will reassess whether or not
 	 * a hugepage can be used for affected ranges.
 	 */
-	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
-		return false;
-
 	if (WARN_ON_ONCE(range->end <= range->start))
 		return false;
 
@@ -8218,11 +8215,7 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 	 * can't map memory PRIVATE.  KVM mustn't create a SHARED hugepage over
 	 * a range that has PRIVATE GFNs, and conversely converting a range to
 	 * SHARED may now allow hugepages.
-	 */
-	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
-		return false;
-
-	/*
+	 *
 	 * The sequence matters here: upper levels consume the result of lower
 	 * level's scanning.
 	 */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9d1836382d19..85fdd33c51ab 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2436,10 +2436,12 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs)
 {
 	XA_STATE(xas, &kvm->mem_attr_array, start);
+	unsigned long supported_attrs;
 	unsigned long index;
 	void *entry;
 
-	mask &= kvm_supported_mem_attributes(kvm);
+	supported_attrs = kvm_supported_mem_attributes(kvm);
+	mask &= supported_attrs;
 	if (attrs & ~mask)
 		return false;
 
@@ -2447,7 +2449,7 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
 
 	guard(rcu)();
-	if (!attrs)
+	if (!attrs && mask == supported_attrs)
 		return !xas_find(&xas, end - 1);
 
 	for (index = start; index < end; index++) {
-- 
2.52.0


