Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6C4B203E;
	Wed, 14 Oct 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015516; cv=none; b=ku8JXpT8T7u1t7g55WJ5gFAmUqVBjuf1kFFPCSodc2ka44Q0BbEv3kK0qyO4ytU1TlEGJUCgTViBIvIEHNcPKD6HAVeYSW9L6Ne2AxBpXJk0KyziLVmkwA6llhANpHrhDMQb8n1Vj83qzBmPws8KzZJgNjFFTxrLIorLxevRJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015516; c=relaxed/simple;
	bh=jWEUlnvBG6BR3Fn5XvPTfHgt/B+EEBNZ7YcT5wUtMx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYoVNsF9yq3QN8AXu2040C1LZ3Hpw3oRFZ29bJxuRWtimj9QrMLqU5VdXq51wAF1P4q9ddigPPgRIO8VxrCbMLRM2LwUFB9hrm+qcTqnog6xj6+7PcN67ryEZQLF4pkPDZcVhy//kt6qW+l9Y3/+zbbX0E1wYHaf2jLBQqVnhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OK/dFv9v; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OK/dFv9v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=cFcjSX1F1kgoXLz+gVxRBvZE16O8bRWdEkwbe+t5w/8=; b=OK/dFv9vjoctaACE10W5ePqHQ5
	cb11KgvTHISa22+UWaiuSlmnMA4/9lCpq6W1R1kBQkbr+6x6pQJkZxWIoD6UBYnDxe1Xsu45z7z3+
	Ra3ACe5X7Jf8qUaALFdMLH/YY6XJL9BcYc4ZuXJm2FPGV2R1feKG7XuiaM5ITS/tyxgkz40UUpOxZ
	iII3qz0Gs8457QZHh0p7qcQUAEwioB0ZiMyOe6WLnQ7jeypbhv7oekw7gAmWQOHkP1StOfrzQMoqt
	riIu+U9/hVUcjC+Pw8QIdlwIXmL++sRbGjXQCs0cUIIEquXhSu0aQpGz9B1iaSbtFXn/4D2yFaRAq
	xIwjGQmA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75y-0000000HFAI-454P;
	Wed, 14 Oct 2026 22:05:11 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75w-00000002Ay4-3G2M;
	Wed, 14 Oct 2026 23:05:08 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 10/11] KVM: x86: Request the guest TLB flush from record_steal_time()
Date: Wed, 14 Oct 2026 23:05:06 +0100
Message-ID: <20261014220508.518772-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220508.518772-1-dwmw2@infradead.org>
References: <20261014220508.518772-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

record_steal_time() performs a TLB flush on the guest's behalf when the
guest sets KVM_VCPU_FLUSH_TLB. With shadow paging,
kvm_vcpu_flush_tlb_guest() ends up in mmu_sync_children(), which can
reschedule via cond_resched_rwlock_write(). That is why the flush
currently sits between a user_access_end() and a fresh
user_access_begin(): it cannot be done while the guest page is mapped
for access.

Raise KVM_REQ_TLB_FLUSH_GUEST instead of flushing inline, and move the
processing of KVM_REQ_STEAL_UPDATE ahead of where the TLB flush requests
are serviced in vcpu_enter_guest() so that the flush still happens before
the vCPU enters the guest. There is no requirement for it to complete any
earlier than that.

kvm_make_request() on the vCPU which is running is nothing more than a
barrier and a set_bit(), so unlike the flush itself it can be done from
any context — which lets the surrounding access be simplified later.

Note that the xchg() must stay where it is: it atomically consumes any
KVM_VCPU_FLUSH_TLB which the guest has set, as required by commit
b043138246a4 ("x86/KVM: Make sure KVM_VCPU_FLUSH_TLB flag is not missed").

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260530061932.7849D1F00893@smtp.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/x86.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eadcaeee651a..20119d07b477 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2106,8 +2106,22 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 
 		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
 				       st_preempted & KVM_VCPU_FLUSH_TLB);
+		/*
+		 * Request the flush instead of performing it inline. With
+		 * shadow paging kvm_vcpu_flush_tlb_guest() can reschedule (via
+		 * mmu_sync_children()), which is why the user access above has
+		 * to be closed before it. Requesting the flush is just a bit
+		 * set on the running vCPU, and the request is serviced before
+		 * the vCPU enters the guest; nothing requires the flush to
+		 * have completed any earlier than that.
+		 *
+		 * Note the xchg above must remain as-is: it atomically
+		 * consumes any KVM_VCPU_FLUSH_TLB the guest set, as required
+		 * by commit b043138246a4 ("x86/KVM: Make sure
+		 * KVM_VCPU_FLUSH_TLB flag is not missed").
+		 */
 		if (st_preempted & KVM_VCPU_FLUSH_TLB)
-			kvm_vcpu_flush_tlb_guest(vcpu);
+			kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 
 		if (!user_access_begin(st, sizeof(*st)))
 			goto dirty;
@@ -8089,6 +8103,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			if (unlikely(r))
 				goto out;
 		}
+		/*
+		 * Process the steal time update before the TLB flush requests
+		 * are serviced below; record_steal_time() requests
+		 * KVM_REQ_TLB_FLUSH_GUEST on the guest's behalf rather than
+		 * performing the flush itself.
+		 */
+		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
+			record_steal_time(vcpu);
 		if (kvm_check_request(KVM_REQ_MMU_SYNC, vcpu))
 			kvm_mmu_sync_roots(vcpu);
 		if (kvm_check_request(KVM_REQ_LOAD_MMU_PGD, vcpu))
@@ -8138,8 +8160,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			r = 1;
 			goto out;
 		}
-		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
-			record_steal_time(vcpu);
 		if (kvm_check_request(KVM_REQ_PMU, vcpu))
 			kvm_pmu_handle_event(vcpu);
 		if (kvm_check_request(KVM_REQ_PMI, vcpu))
-- 
2.43.0

