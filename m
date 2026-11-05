Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897152;
	b=rC9LxllzPi8i4SAhJqgjjWxQl3Srvi/dxXNFcN3RmpYvsfi0/iw6dB+WtM61AxLG5gtV
	 809D2SOT0vkFT2GaoC4AOD7DUxcSTAG2xE60836osW8qgPpfu9rKJO82sSqhJVX8pNvUv
	 NvGHpYBPO5RuHTn9Bhxj968mKlE5NxEtAWePKyitt8jaLlHM6aceLj98vShgBbdsBv/TJ
	 o47OlkrzNvESmX/9JJGd/nxPMBilmGvd7Qe4oJ9kpsR7kLxK4kAUZB0jbe36OFkqanfEK
	 FVDFzCQSPtcR7ePaNh9tvqKgyOAYkNnola7CR6hSGuHPIGw2TJDnVbbHAJElPieeeiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897152;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=/JZjrrQHueL4KzoOi+LM7Mo3djldPKioe/7B1wL57cE=;
	b=aewd3+cGpe00XFCQQxDU/Jn956D9lEmcUO3qquMKppoiohmq4GxL577ZChrQBmw1D1cU
	 TNOsdySxWBR8xJBz9+/7s8OaVf2vZ4lBjTVcNpEs02XrwdWIFFahH2izStV0xvEw+9vKs
	 em8se5C6LX6IszY/YVvFHfGngVC3VjrFDVLQ8aN4zHjTnUOaxh71seoAL9golR8/oFsHY
	 mpNQGKpaseS1VW9Wddn1dT9fXRAZqS7+YsGMT3Yj2RR/gl6S7owNgvsSdWcEMwsQxUZHL
	 cIwig304c9JV53aK10wtqAcF8kgNp0GQ+OqDAzP8U4xbWx3oHD/zfaDzhZ3bceN1H8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dA7Ih+Go;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5E606A33D
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 16:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA5E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dA7Ih+Go
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793897150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JZjrrQHueL4KzoOi+LM7Mo3djldPKioe/7B1wL57cE=;
	b=dA7Ih+GoOGjZv5uWayEeidHqzzx/QRPu6RkwbFMv4vejAvW5+fA1JOvwtl6CVFV7h5aJo4
	WG9gRDl7qXXhuccFfLysXvd/0cU9jxxJDo2mn+4651/hPOcC9ltq5lkmWuLOveKH/isAr3
	5Vvc2/T7qu2Y8/TtDKeQq8rhfTYsnOs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-EwkDLrSPN6-q0apJetQ4Hw-1; Thu,
 05 Nov 2026 11:45:44 -0500
X-MC-Unique: EwkDLrSPN6-q0apJetQ4Hw-1
X-Mimecast-MFC-AGG-ID: EwkDLrSPN6-q0apJetQ4Hw_1793897143
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01F171955D9B;
	Thu,  5 Nov 2026 16:45:43 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 438A3195608B;
	Thu,  5 Nov 2026 16:45:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Harry Yoo <harry@kernel.org>
Subject: [PATCH 3/5] x86: KVM: remove the dummy allocation case from async page fault handling
Date: Thu,  5 Nov 2026 17:45:29 +0100
Message-ID: <20261105164531.313849-4-pbonzini@redhat.com>
In-Reply-To: <20261105164531.313849-1-pbonzini@redhat.com>
References: <20261105164531.313849-1-pbonzini@redhat.com>
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

The page ready notification for asynchronous page faults is delivered as
an interrupt to the same vCPU that received the not-present exception.
As long as interrupts are not enabled before the page fault is registered
in the sleepers' hash table, the page ready notification must happen
after a prior registration.

This is now the case indeed, so the dummy allocation case is dead and
can be dropped.

Note however that a write of the apf-enable MSR that goes from enabled
to enabled might trigger *both* a broadcast notification interrupt
and, later, individual interrupts for pending asynchronous page faults.
While Linux will never do such a write, the host might do a KVM_SET_MSRS
call that would result in the broadcast notification, so do not complain
too loudly if the wait does not find a token and only do a pr_once().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_para.h |  1 -
 arch/x86/kernel/kvm.c           | 66 ++++++++-------------------------
 2 files changed, 15 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 1e28c89b1405..b986edb1a225 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -123,7 +123,6 @@ struct kvm_task_sleep_node {
 	struct swait_queue_head wq;
 	u32 token;
 	int cpu;
-	bool dummy;
 };
 
 #ifdef CONFIG_KVM_GUEST
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index d3a0e0d7bb84..ad0b6a4ad097 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -111,26 +111,11 @@ bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
 	raw_spin_lock(&b->lock);
 	e = _find_apf_task(b, token);
 	if (e) {
-		struct kvm_task_sleep_node *dummy = NULL;
-
-		/*
-		 * The entry can either be a 'dummy' entry (which is put on the
-		 * list when wake-up happens ahead of APF handling completion)
-		 * or a token from another task which should not be touched.
-		 */
-		if (e->dummy) {
-			hlist_del(&e->link);
-			dummy = e;
-		}
-
 		raw_spin_unlock(&b->lock);
-		kfree(dummy);
 		return false;
 	}
-
 	n->token = token;
 	n->cpu = smp_processor_id();
-	n->dummy = false;
 	init_swait_queue_head(&n->wq);
 	hlist_add_head(&n->link, &b->list);
 	raw_spin_unlock(&b->lock);
@@ -200,53 +185,32 @@ static void kvm_async_pf_task_wake(u32 token)
 {
 	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
 	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
-	struct kvm_task_sleep_node *n, *dummy = NULL;
+	struct kvm_task_sleep_node *n;
 
 	if (token == ~0) {
 		apf_task_wake_all();
 		return;
 	}
 
-again:
 	raw_spin_lock(&b->lock);
 	n = _find_apf_task(b, token);
-	if (!n) {
-		/*
-		 * Async #PF not yet handled, add a dummy entry for the token.
-		 * Allocating the token must be down outside of the raw lock
-		 * as the allocator is preemptible on PREEMPT_RT kernels.
-		 */
-		if (!dummy) {
-			raw_spin_unlock(&b->lock);
-			dummy = kzalloc_obj(*dummy, GFP_ATOMIC);
 
-			/*
-			 * Continue looping on allocation failure, eventually
-			 * the async #PF will be handled and allocating a new
-			 * node will be unnecessary.
-			 */
-			if (!dummy)
-				cpu_relax();
-
-			/*
-			 * Recheck for async #PF completion before enqueueing
-			 * the dummy token to avoid duplicate list entries.
-			 */
-			goto again;
-		}
-		dummy->token = token;
-		dummy->cpu = smp_processor_id();
-		dummy->dummy = true;
-		init_swait_queue_head(&dummy->wq);
-		hlist_add_head(&dummy->link, &b->list);
-		dummy = NULL;
-	} else {
+	/*
+	 * A broadcast wakeup, which can happen for example if the VMM calls
+	 * KVM_SET_MSRS, might still leave the individual wakeups queued.
+	 * In that case _find_apf_task() will not find the token when the
+	 * individual wakeup comes, so just ignore the case where n is NULL.
+	 * Nevertheless it *should* not happen, so print a message for the
+	 * user in case something bad actually happens later.
+	 */
+	if (n)
 		apf_task_wake_one(n);
-	}
-	raw_spin_unlock(&b->lock);
+	else
+		pr_info_once("Async page fault waiter not found. This is probably triggered "
+			     "by the host and harmless. However, if a userspace task hangs, "
+			     "please include this message in your bug report.\n");
 
-	/* A dummy token might be allocated and ultimately not used.  */
-	kfree(dummy);
+	raw_spin_unlock(&b->lock);
 }
 
 noinstr u32 kvm_read_and_reset_apf_flags(void)
-- 
2.56.0


