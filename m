Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B93C3442
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719364; cv=none; b=IgZiqgusl0NEX7jxwbouL8NQgrDE0G5V9dUode8iZmH4kzAI8AB/v4y6mM0IrT+Z9G55Wrm8Fh1BOstMhzKTbVAo7V4G9ruGa6QAv4cHA/1X4799ALOVasZzPS/cqwMsqd1Ib6qCY7N8zbnsLKeGiTWvJwVrvRQUgS1fVlp1UBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719364; c=relaxed/simple;
	bh=rgk9M4pgE1QviE0CqliLyO+0jWnMkZ/1sJnfXb4SX+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i33LGfllLNfH9cLP1PbP/DTaVBEJyxC3P1zUayvvEdlyIUz2Pq8WAsVFVovx5MhP0zUBS+k4UfpriGO2AZm/85wLYFn7zI6+p0ykHUuqa5sjIYEInoOL9CiJh+2mTGxD/OYttzMneihMC0yX4yzPUBYYXpTWphCSL+rveXMzvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7yC1WLR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7yC1WLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujSswSFjYRCTMYkmmhaCZWF4ecoRPMD1qhDcHmUI9W0=;
	b=R7yC1WLRRS3jQHFssz1UHCG4bV5AHKlBg8k/6R3OpMIuaAxhDB4WpYL5HgbVRijAeYlDYv
	jM4n0WYddfT0PnM1+Lw3hU8Bw0Zmf6OppdORLIQybLKIkrQ1Y7EyuUzHHpEUUHqeq9ewNo
	K0K1ke534XZbJnvB5gT/7iPrSAgFzIE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-BgJo-VkcP6CXQjxsZPrajw-1; Fri,
 18 Sep 2026 04:15:51 -0400
X-MC-Unique: BgJo-VkcP6CXQjxsZPrajw-1
X-Mimecast-MFC-AGG-ID: BgJo-VkcP6CXQjxsZPrajw_1789719350
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7062918000A3;
	Fri, 18 Sep 2026 08:15:50 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B38291800370;
	Fri, 18 Sep 2026 08:15:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 07/28] KVM: x86/mmu: intersect writability from __kvm_faultin_pfn with fault->map_writable
Date: Fri, 18 Sep 2026 04:15:22 -0400
Message-ID: <20260918081543.139871-8-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

fault->map_writable is currently a pure output of __kvm_faultin_pfn(),
which is the only thing that restricts it.  This will no longer hold once
memory protections derived from memory attributes are applied: those
compute their own access permissions that combine with those from
__kvm_faultin_pfn().

Applying them *before* faulting in the pfn lets a fault that violates
the attributes exit to userspace without the cost of gup and/or an
async #PF; but it means that permissions will then be restricted in two
independent steps, first by memory attributes and then by __kvm_faultin_pfn().
Switch fault->map_writable to that model by letting kvm_mmu_faultin_pfn()
only clear bits rather than assign them.

No functional change intended: nothing writes fault->map_writable between
the initializer and __kvm_mmu_faultin_pfn() yet, so the AND is equivalent
to the assignment it replaces.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..5996468b7120 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4634,7 +4634,7 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 		return r;
 	}
 
-	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
+	fault->map_writable &= !(fault->slot->flags & KVM_MEM_READONLY);
 	fault->max_level = kvm_max_level_for_order(max_order);
 
 	return RET_PF_CONTINUE;
@@ -4644,13 +4644,14 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 				 struct kvm_page_fault *fault)
 {
 	unsigned int foll = fault->write ? FOLL_WRITE : 0;
+	bool writable;
 
 	if (fault->is_private || kvm_memslot_is_gmem_only(fault->slot))
 		return kvm_mmu_faultin_pfn_gmem(vcpu, fault);
 
 	foll |= FOLL_NOWAIT;
 	fault->pfn = __kvm_faultin_pfn(fault->slot, fault->gfn, foll,
-				       &fault->map_writable, &fault->refcounted_page);
+				       &writable, &fault->refcounted_page);
 
 	/*
 	 * If resolving the page failed because I/O is needed to fault-in the
@@ -4659,7 +4660,7 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	 * other failures are terminal, i.e. retrying won't help.
 	 */
 	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
-		return RET_PF_CONTINUE;
+		goto out_pf_continue;
 
 	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
 		trace_kvm_try_async_get_page(fault->addr, fault->gfn);
@@ -4680,8 +4681,10 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	foll |= FOLL_INTERRUPTIBLE;
 	foll &= ~FOLL_NOWAIT;
 	fault->pfn = __kvm_faultin_pfn(fault->slot, fault->gfn, foll,
-				       &fault->map_writable, &fault->refcounted_page);
+				       &writable, &fault->refcounted_page);
 
+out_pf_continue:
+	fault->map_writable &= writable;
 	return RET_PF_CONTINUE;
 }
 
@@ -5000,6 +5003,7 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.is_private = err & PFERR_PRIVATE_ACCESS,
 
 		.pfn = KVM_PFN_ERR_FAULT,
+		.map_writable = true,
 	};
 	int r;
 
-- 
2.52.0


