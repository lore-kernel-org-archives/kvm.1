Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661277;
	b=M2xRLvg0K6pHfSfCyk7c8MsP0ins0FzKJHJtM3W/g7/tVYUqsMWcM36LqrAlQJAsWkaR
	 cHI/XotgQhFfFQMVxCSR9F3emvLQibFW7FOjadIBprjbZspLT65L5Cmt7Nmt2XD0WNM3p
	 HACouaP3WMDQkfMe1REYfDrpm1c4u7DhLOwRKKg3StmxGGoWT8ONlBFDtO4vDR/YqdKIK
	 bE6N1VebIWEfh5VozgqJmTdVELnUtxC0ToJ7yavGZp8v82bQ9CNvi/AX1nr5uHJ84YwxM
	 JTGR1SjTKz51d8gQn1JWCOdXuZghAv7Y9CyzJtUYtqpPZRke1zS0ClP938yiVhhw8hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661277;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=3+6FRavmCgIlofFAI66EfQeYrz6NFFwg0C655ZeGgZg=;
	b=2py19bb8GfNkorVLRWtB8pEbLGA5nSaQRAq0dID+Vc84uUT1NiPPATSbkA0ma/Od+aOQ
	 tBU22KUpzBTJg+dO1jE7NZ8exO6BIkTvYwnUQUEBHXx0gS0IbucYmb5JGX36zSNhYJ9uJ
	 hQ8JfXTv094iOTgpRBV6oyOSMwfkc5iiT7MQm2gJENK4uRuaL1ZnsYAo4YQITsLvrIHbv
	 7kWsVBOIglUuT4UNpxJkrxeY1jzs6U2XQfegVqHH3bomZxBkZue742fRAh5LkPkgvg0RK
	 VuqqH2SrjTSYhP4n6iiq0KTQcvkRkqKx2jdLzJkC7fL8SVkXPpoc9Jy3Q2pfRYcaeOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hn7fN3ZF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D10606A32F
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D10606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hn7fN3ZF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793661276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+6FRavmCgIlofFAI66EfQeYrz6NFFwg0C655ZeGgZg=;
	b=Hn7fN3ZFnveYkDZ1xChgx62vl38zWRlE4VxVxjYqO4OxZgNsZYy7OOV01hvwLsXXegkSE8
	Y6rvWSYcVpRV9xgeOFmE96Vhg9g57itgk9kyBCqEzDgxAoidj+15lgpIHWLUibpWcdhjQb
	W5x+JH6cMMiFgvTWKk/nYVTeZbhY8yU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480--GH3GszYOnG-6CATvZjN3Q-1; Mon,
 02 Nov 2026 18:14:32 -0500
X-MC-Unique: -GH3GszYOnG-6CATvZjN3Q-1
X-Mimecast-MFC-AGG-ID: -GH3GszYOnG-6CATvZjN3Q_1793661271
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80165180065E;
	Mon,  2 Nov 2026 23:14:31 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE6AF26C;
	Mon,  2 Nov 2026 23:14:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>
Subject: [PATCH 2/7] KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D update failure
Date: Mon,  2 Nov 2026 18:14:23 -0500
Message-ID: <20261102231428.13523-3-pbonzini@redhat.com>
In-Reply-To: <20261102231428.13523-1-pbonzini@redhat.com>
References: <20261102231428.13523-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Sean Christopherson <seanjc@google.com>

Conditionally reschedule when retrying a guest PTE walk because the CMPXCHG
to update A/D bits failed, e.g. because a different task/vCPU modified the
relevant gPTEs.  On kernels without involuntary preemption of some kind, a
misbehaving guest can "capture" a pCPU effectively indefinitely and trigger
soft lockups by continuously modifying its gPTEs such that the result of
the walk is remains valid.

Fixes: b3e4e63fd9ee ("KVM: MMU: Use cmpxchg for pte updates on walk_addr()")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20261022015903.282261-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8e350095508c..18f7eb633127 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -340,6 +340,13 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	gpa_t real_gpa;
 	gfn_t gfn;
 
+	/*
+	 * KVM might sleep/resched when retrying the walk if the updating A/D
+	 * fails because the gPTE changed between reading the gPTE and trying
+	 * the CMPXHG to set A/D bits.
+	 */
+	might_sleep();
+
 	trace_kvm_mmu_pagetable_walk(addr, access);
 retry_walk:
 	walker->level = w->cpu_role.base.level;
@@ -482,8 +489,10 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 							addr, write_fault);
 		if (unlikely(ret < 0))
 			goto error;
-		else if (ret)
+		else if (ret) {
+			cond_resched();
 			goto retry_walk;
+		}
 	}
 
 	return 1;
-- 
2.52.0


