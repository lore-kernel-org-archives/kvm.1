Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8FD432E80
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225711; cv=none; b=NhUaX2cq3+Yr7NjxPRVLFfqAnHpXN7KaKlgUQoiKqHgFkyn8ypQe4lQ4jwOFx3CpJZA2kqly/SafJusY8+1OhQOl7ntHj/xFgXkMWyGsc+Yjp9n4hA8xls18zzkKG7AVZDMSPbzxQO/j2MYYH+2pNb1bKmaRu8RvURTzUMj0sXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225711; c=relaxed/simple;
	bh=4Dv48tDQIx40WR6Ur6ghchIGY+vgtRefoSNxFqnLb2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioPzwHq5TB8KJO+y5LkNb6UWOwxlfFsYEdaaGT1xH9SD2qVZG+nE9dWAw+e0RYRlu9dzxJl6RALjHZL19Rk8xYnfZqAtbxbQR3Wo3iQosX1/GFuFbzWNwyrSJhiePWm3dfuXChtDY8UPlUMMdY23bxF1L0FIdEbn46QjsNhRUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TL5m2nAS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TL5m2nAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yv9YPvkjkDF2qJ7dc9+Bs6eFu6QdBTMu8Ml4KSx/0K8=;
	b=TL5m2nASjZy0Q6itMc5Vz0DZFUT9k5jqLTCkwqTnjcjUlDJC3034UL492zZS01DjXEytDQ
	lULdIp5kzi5oE9ZpN9P4OsJmT9ULW9uKRyyjUcOqeY5kmZ8s3l3ZRPXTdIRE9qzeV8La6R
	PVO6tKESVSE/d1SpwbjeqbgtdcdnBuI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-HDruLpmEPVai2wWFknyzsA-1; Thu,
 16 Jul 2026 14:15:01 -0400
X-MC-Unique: HDruLpmEPVai2wWFknyzsA-1
X-Mimecast-MFC-AGG-ID: HDruLpmEPVai2wWFknyzsA_1784225700
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 938EF1955F7E;
	Thu, 16 Jul 2026 18:15:00 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20FD31955D86;
	Thu, 16 Jul 2026 18:15:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 04/24] KVM: x86/mmu: intersect writability from __kvm_faultin_pfn with fault->map_writable
Date: Thu, 16 Jul 2026 14:14:36 -0400
Message-ID: <20260716181456.402786-5-pbonzini@redhat.com>
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
index 6c13da942bfc..cf6a409b76ae 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4603,7 +4603,7 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 		return r;
 	}
 
-	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
+	fault->map_writable &= !(fault->slot->flags & KVM_MEM_READONLY);
 	fault->max_level = kvm_max_level_for_order(max_order);
 
 	return RET_PF_CONTINUE;
@@ -4613,13 +4613,14 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
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
@@ -4628,7 +4629,7 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	 * other failures are terminal, i.e. retrying won't help.
 	 */
 	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
-		return RET_PF_CONTINUE;
+		goto out_pf_continue;
 
 	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
 		trace_kvm_try_async_get_page(fault->addr, fault->gfn);
@@ -4649,8 +4650,10 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	foll |= FOLL_INTERRUPTIBLE;
 	foll &= ~FOLL_NOWAIT;
 	fault->pfn = __kvm_faultin_pfn(fault->slot, fault->gfn, foll,
-				       &fault->map_writable, &fault->refcounted_page);
+				       &writable, &fault->refcounted_page);
 
+out_pf_continue:
+	fault->map_writable &= writable;
 	return RET_PF_CONTINUE;
 }
 
@@ -4968,6 +4971,7 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.is_private = err & PFERR_PRIVATE_ACCESS,
 
 		.pfn = KVM_PFN_ERR_FAULT,
+		.map_writable = true,
 	};
 	int r;
 
-- 
2.52.0


