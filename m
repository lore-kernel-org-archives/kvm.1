Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181662;
	b=WX1G0308zMl9iB8YJhduRlFbex+A7+2M/EFuwsFQXiVLyPFkaXeUZTogFGpCNqnuWlGK
	 7C/KnLlLAaja4PVT5aZDXDhJG+YVPt/gpTaHHE5lqD8GgEdxFwZO+yBdLkRidcaq9Vztc
	 YsZ87JKrbCnEOGlyz8yD9JGQFNda7VZRtCgxIE4LsO7ZGvSLxa8lgYdF5c5W3MnHUxkIO
	 kPK3/f6ncgukDctxvP2U/25ffP64K1Xa6DCqcv1vYWbQnuzNnDBq2hxdkiJC+ebsXG+CI
	 cSEulh1eNzEw3zzhojsGjU/5wVHOT0I95W/VhRwg1I/PVrETDgMwZNYHut0JQu4sP/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181662;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=zA6NzYJgjQLA40YOpIFdm9mYKUOMSfZ7Wlt9Ruo4O3M=;
	b=L+baiCXdKkmljr0ltP5Nc8PMkL+1Z7aYnw6b/Ac/lbGuUjnu2EilzTK8tEf1Mx60OAtf
	 7el73RUjYJGxgVY9QvY5TamZa17XUFk7h+n4R5MARYhoCpjF1hBl1TsLqXExkRol63kh+
	 i8OlBh8OoU0J2KBKlkmcL0tnkpLYAYhYKJEz0IrEXzlZAyF230sPXZnHT1ECSaGxwKIaX
	 ciRWfg9SLo2XE4SuVJxBhKw8CXFBY9npBv/g8EyFAppidMN7s9q1V2XqnDbserlgmpgkz
	 fHkA81P/GRFVJNqMKAvHLIDzP6M7LFFoaGa1Y1zLxTFK1fzOvZrTDdmS7EEiR3J5KvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iHDIIYut;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEF606A335
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 13:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5DEF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iHDIIYut
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795181660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zA6NzYJgjQLA40YOpIFdm9mYKUOMSfZ7Wlt9Ruo4O3M=;
	b=iHDIIYut01eICYmgH3DtHyCUGPfkJd9xMBSEa80zZS4CzsfVoyFHXOaREcu0KcXDff/IHt
	Xfsrs5BHvqYXd32KD6VIaa2XlbDR9fC7Aeg71k6Hmzm/CbEsY9ELIFKedIJsXSxwHZpFSl
	/K/G3EVft17xAmQWkgtASFkD7U3rI+A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-xjiZjUFhMKu9MFfS94h-Jw-1; Fri,
 20 Nov 2026 13:34:17 +0000
X-MC-Unique: xjiZjUFhMKu9MFfS94h-Jw-1
X-Mimecast-MFC-AGG-ID: xjiZjUFhMKu9MFfS94h-Jw_1795181656
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E10A18002CC;
	Fri, 20 Nov 2026 13:34:16 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DBAB1956062;
	Fri, 20 Nov 2026 13:34:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: PPC: remove unnecessary #ifdef
Date: Fri, 20 Nov 2026 14:34:13 +0100
Message-ID: <20261120133413.475489-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

booke.o is only built as part of kvm-e500-objs (which is conditional
on $(CONFIG_KVM_E500V2)) or kvm-e500mc-objs (likewise conditional
on $(CONFIG_KVM_E500MC)).  Thus, the #ifdef in kvmppc_core_check_requests
is always true.  Remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/powerpc/kvm/booke.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index fd7f24a68b31..ba762ac1fb56 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -738,10 +738,8 @@ int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
 
 	if (kvm_check_request(KVM_REQ_PENDING_TIMER, vcpu))
 		update_timer_ints(vcpu);
-#if defined(CONFIG_KVM_E500V2) || defined(CONFIG_KVM_E500MC)
 	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
 		kvmppc_core_flush_tlb(vcpu);
-#endif
 
 	if (kvm_check_request(KVM_REQ_WATCHDOG, vcpu)) {
 		vcpu->run->exit_reason = KVM_EXIT_WATCHDOG;
-- 
2.56.0

