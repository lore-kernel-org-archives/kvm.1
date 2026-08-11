Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB662FE07D;
	Tue, 11 Aug 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454576; cv=none; b=LGhYMtUpOUL6uf0p8TGcwJAD/azUoSwyyKLTE31h40cPWsPn9VdjNI/H0+t49gVPj/7Utrf4bKIMHXFH+Djic3XDmF2pQR0vLtggn7eBiFY/cfhFL0fTq6EySEuYq2tCgtMyd41GWbpJ74Vj9xUJi5g0IF+jkP5b0lgLcefERrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454576; c=relaxed/simple;
	bh=t8lK9Snhc9yquoPRTRoV93Fn4Ux8130cQotiqUI7WSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/ob/AYqOGDDc2AY5c57TP/nj5wheKkNGSHfL98waHx/J2NTWVdZFL6USy7hP/5rL1UG48sWKiWfTGG4hzBcRetvIu8IyAIQKFykWUx1pYhfU+WFLLufcDBFGjS+10dSAn78ZnN2qdGrrTlVG1lpJOkhGE1I7/RCWplL0IhQB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TXUVYBPu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TXUVYBPu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=38VDlC3T9U7k5c8RZkKKjsBg4drLylSLp9dK+J84LzQ=; b=TXUVYBPuhtawpFgnGcR2yMasLr
	VSAED2oudrQ4i5pCQsu8QveShjkrlc9+KfZofbqxVR2YlUDScRQT8pi7BZsVnB0xZFbn+ZBRwsZKq
	orbVM/eNfEq9xYXq98l+P32mZOkAyTJGeYwlKMjXRAMeBbDgql4frml9QBAeE+IX6+UyKBZTQVL0g
	OfoVbYaXUNHgiyVCZ9GbDqzf+MmgyufviRLznnPkKGh4h24joZOGlIobHg1Zs9ggK3yPVHJRtkMze
	L2A15dM3pm9RKKF+pa4W4Q2rOO6yD7xbg3e82ctr5VH2UpOjVas0oKJX+rCMN5+s7ze3S/oBngMeG
	NwdEymXQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmRC-00000000TZ4-2wxa;
	Tue, 11 Aug 2026 13:22:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtmRC-00000000Qlu-23nS;
	Tue, 11 Aug 2026 14:22:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	stollmc@amazon.com,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] KVM: x86: Request the guest TLB flush from record_steal_time()
Date: Tue, 11 Aug 2026 13:49:55 +0100
Message-ID: <20260811132237.102400-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811132237.102400-1-dwmw2@infradead.org>
References: <20260811132237.102400-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

record_steal_time() performs a TLB flush on the guest's behalf when the
guest sets KVM_VCPU_FLUSH_TLB. With shadow paging, kvm_vcpu_flush_tlb_guest()
ends up in mmu_sync_children(), which can reschedule via
cond_resched_rwlock_write(). That is why the flush currently sits between
a user_access_end() and a fresh user_access_begin(): it cannot be done
while the guest page is mapped for access.

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
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/x86.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 75e5f894153f..d2e60d1146e0 100644
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
+		 * are serviced below; a subsequent change will have it request
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
2.55.0

