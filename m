Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99840DFD5
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589264; cv=none; b=YoM2ce6JjINZC/oMCY1ENRYGKX1fQg7KZsqGbIRFKCjzjD3ieSYg0ycLG4E42Uarmi20Z13MF6UpR2QowreR9uPQ70jrmDbL8WZr2fIEHHEDipaylowyfL2kPrtNZ1GnwEKVbkleCJFcPQLq8RrUdNsCNvN5S4egf7xK2cHjJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589264; c=relaxed/simple;
	bh=eXCfBQxr6XhjYxfqbjf/SUCSUo3mXtSy/N0Lk0E51Qg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDr9SFju75c8SVTdTtTjAazorYw95IE8iADPl1TfUQYWdVHGpZNxhUbdVB4A0GWP7wyOdW4okuPQ3lTAF7BKvaDltpRYCRS5HGLnS91YN1LIOIB1R64s9owa/uCRRq1blhkTomp0o4F8rgskUFkEtWgW9oPB+/tjSUkqOuVed/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWAlFM3V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWAlFM3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780589259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGk2tAGALcIvdpvz46eMxrvPgOoXQWtxWoYDrjMwGww=;
	b=XWAlFM3VrIK67FkGX9m8RqehwmtHCsImNcPXGKGxPSop+yNzmxdIihST7d45eNRHQT7NFx
	Wbnifr+7JRkKIJpURaP4vgDs8GBtZuRUflRzz4/7yK/RdEklvxA6nFZ3OEE85Uyp3WYw4W
	7BNUddNIBJ2CFmfqvdaUr6e4A57WvWM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-YfYeqdplNuWMLuzUvGHnBQ-1; Thu,
 04 Jun 2026 12:07:36 -0400
X-MC-Unique: YfYeqdplNuWMLuzUvGHnBQ-1
X-Mimecast-MFC-AGG-ID: YfYeqdplNuWMLuzUvGHnBQ_1780589255
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A75071800366;
	Thu,  4 Jun 2026 16:07:35 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BAF4180049F;
	Thu,  4 Jun 2026 16:07:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 2/3] KVM: MMU: unconditionally clear MMIO cache on root rebuild
Date: Thu,  4 Jun 2026 12:07:32 -0400
Message-ID: <20260604160733.12555-3-pbonzini@redhat.com>
In-Reply-To: <20260604160733.12555-1-pbonzini@redhat.com>
References: <20260604160733.12555-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Upon changing CR3, the MMIO cache becomes invalid because the
GVA->GPA mapping has changed.  However, kvm_load_new_pgd() calls
vcpu_clear_mmio_info() call only if the fast switch succeeded.
The early-return path instead leaves the root invalid; the next entry
then calls kvm_mmu_reload() and from there kvm_mmu_load().

kvm_mmu_load() calls kvm_mmu_sync_roots(), which clears the MMIO
cache, but one combination that falls through is root_role.direct==1,
i.e. CR0.PG=0, for which kvm_mmu_sync_roots() bails before reaching the
call to vcpu_clear_mmio_info().

That combination is barely reachable: a valid direct root is pretty much
always a fast-switch success because it does not check the PGD for a
match.  The early return for a direct root thus requires the current root
to already be invalid, and kvm_mmu_unload() itself clears the MMIO cache.

That said, doing an independent clear in the style of kvm_mmu_new_pgd()
is more obviously correct and basically free, so harden it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f8aa7eda661e..6689c9f8ae16 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6138,6 +6138,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 	if (r)
 		goto out;
 
+	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 	kvm_mmu_sync_roots(vcpu);
 
 	kvm_mmu_load_pgd(vcpu);
-- 
2.52.0


