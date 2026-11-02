Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641539;
	b=O6rSSupkpirh8ocLTtZnPYeiNINYT3gxgyDBOEhH9yBqGGNccVbw732s9oK8oHnp58bo
	 JP1aaBYHb8teig/CZiCb1XIVnaa1WbBwceHEE8X56cnn4yXuNcFp6y9Ac5FZLFqceO1+Q
	 QWdbpr01SoXWHkCW8M8GFNQdXxRkqiXyQ69Bzzu5qDjCfe3jZUtFAm+oklf/FNN+nDzPY
	 Da3oLG4ql4267KEuWG3MKiB1kRSrQsPcdPHWuL4y3aNngLNehqNCPB80YxMPOML2frsN1
	 XcU4sJ3JpvRgX04cDfncsQA/qjzpxmIPBgFnlfPB1A16/MhOA6UdmdEQa+7G9uskp1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641539;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=ZRv5nzeO3KV+yI6X0QTSiqjcnuY3qk8Teo2EwEQCsYg=;
	b=jpT3msusF6gcNSk3MRGDD9RUVXpn8fbfezX6ZKfeqh3VCYL5WQfAafTdthoBxcLRbQor
	 n1R/EpVVilcvhmS57BhJLXbQ+3Z0HUnwzs6ZH7jzzBmQWvJ8v3OSFwBjQtIo9Gdx3BTsd
	 x7n3QG3LYDwwYEfMuQ8KX5a1mt/ra4q/RSW/q+wkcXOE9CYy+bICye9mEF5vbjYd5HT1M
	 P3GejGdEA/0L4F75d6EpRGgkW2/kthfMIl4CkAxmRSPBbx8wWnlMig4PCWxQobIJQ+Vtp
	 PNSFpl3DbKbEo5hTdejjEHrrdxUmKw93oDpp9KUzPlPuIy3yDiknGyUgyKh4MNjssdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D3607485D
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 739D3607485D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRv5nzeO3KV+yI6X0QTSiqjcnuY3qk8Teo2EwEQCsYg=;
	b=OXdxNtcBlvsKzdCHFF/cqeWlmB2HaIMkezUn6roP3Ukm1h+sUgCf7UEKbdh+1PthID4MM8
	p+sjgGYChhmymMxkEIkDuiC1wIfmGbrWNa2zAUrIv7lbLQsxzmzOJKXr6KG9GLQzHN30SD
	jFGyvYzddkUoWl5sF2lVq/phGnfgeUQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-wIQH-W5RP1-AQ3cRsMkyUg-1; Mon,
 02 Nov 2026 12:45:30 -0500
X-MC-Unique: wIQH-W5RP1-AQ3cRsMkyUg-1
X-Mimecast-MFC-AGG-ID: wIQH-W5RP1-AQ3cRsMkyUg_1793641529
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47D181955E85;
	Mon,  2 Nov 2026 17:45:29 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9D431800347;
	Mon,  2 Nov 2026 17:45:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 40/45] KVM: let kvm_arch_post_set_memory_attributes drop mmu_lock
Date: Mon,  2 Nov 2026 12:45:07 -0500
Message-ID: <20261102174512.8903-24-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Ensure that mmu_invalidate_in_progress is not cleared until
kvm_arch_post_set_memory_attributes() returns.

kvm_arch_post_set_memory_attributes() runs with the MMU lock taken
exclusively, so a concurrent page fault would be blocked anyway, and
delaying the clearing makes it possible to use cond_resched() within
kvm_arch_post_set_memory_attributes().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-28-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 326bb8e144b7..2d5d45e4ee71 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2630,7 +2630,7 @@ static bool kvm_range_memory_attributes_need_sync(struct kvm *kvm,
 	return kvm_range_has_any_vm_memory_attributes(kvm, start, end, mask);
 }
 
-static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
+static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
 						 struct kvm_mmu_notifier_range *range)
 {
 	struct kvm_gfn_range gfn_range;
@@ -2680,6 +2680,8 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 
 	if (found_memslot)
 		KVM_MMU_UNLOCK(kvm);
+
+	return found_memslot;
 }
 
 static bool kvm_pre_set_vm_memory_attributes(struct kvm *kvm,
@@ -2717,10 +2719,11 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		.end = end,
 		.arg.attributes = attributes,
 		.handler = kvm_arch_post_set_vm_memory_attributes,
-		.on_lock = kvm_mmu_invalidate_end,
+		.on_lock = (void *)kvm_null_fn,
 		.may_block = true,
 	};
 	bool sync = false;
+	bool found_memslot;
 	unsigned long i;
 	void *entry;
 	int r = 0;
@@ -2752,7 +2755,7 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		cond_resched();
 	}
 
-	kvm_handle_gfn_range(kvm, &pre_set_range);
+	found_memslot = kvm_handle_gfn_range(kvm, &pre_set_range);
 
 	for (i = start; i < end; i++) {
 		r = xa_err(xa_store(&kvm->mem_attrs.array, i, entry,
@@ -2765,7 +2768,12 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	smp_store_release(&kvm->mem_attrs.generation,
 			  kvm->mem_attrs.generation + 1);
 
-	kvm_handle_gfn_range(kvm, &post_set_range);
+	if (found_memslot) {
+		kvm_handle_gfn_range(kvm, &post_set_range);
+		KVM_MMU_LOCK(kvm);
+		kvm_mmu_invalidate_end(kvm);
+		KVM_MMU_UNLOCK(kvm);
+	}
 
 out_unlock:
 	mutex_unlock(&kvm->slots_lock);
-- 
2.52.0


