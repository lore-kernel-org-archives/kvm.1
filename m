Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427104;
	b=EOx2JNxO0aBfl2R1+w6BwbrQOTAZ+Y4Bx7k1kaZuMsn4RDQoT68LOvgeKXSQ0tPIq+4/
	 eCx6NDZK/nAnYBczy8HFBwasjOAh9Qc75npB/kUAFhh7RTfUf4olDlNunTOHs1w5TFdPw
	 aDocCwo7WbS/RcmMjPtZD2T+Jm0nveLNcbDYfzzqVdgwciL7zatwSWfd0g4AAMbrdD30I
	 rUQsySy0we/3iruzCZf7VOcEa/cTtFsaMENCAWQPYu5PhphK8Wi/ar7udZ+PbtgElTkfE
	 lBuZldP9a8m1LY/KJ80B50waDS44LW+7WARyXfSrlPXE3lkvSETuCG02j8RNnamUsKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427104;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=g6FawsJvxh2CZfs6XHDXBqTm2/HFt6BbeFCm+R7pPk4=;
	b=2+oMdAhjD2Qfga2fk6hfCtxp5LDZhmuVz0Qae9c9TX2+0Zi/3XrDOmhXQFkm3YRcSl3/
	 HBBtc4q3njFL3vEoKxaAaW7mDcZ+ch/KAKKOBx8M5tjNVgazkjAoO676IllHyncrO11mb
	 EMhQjRH4FxCw9COYjGMSdyQGtAMSOkVjO0UGOhXqF6fQFj+65HnBevecy3p/PfTV3Gt6r
	 mEXVmnIFOFigVyXK6NWnr9WdSBGkfxMIOpHNkxz7lH1l4RED9ON+OlJ8OzY81zs11CB0O
	 t4gNpjqPFLWMLp62PbsDIM7iHByn2GgIhYTvYxKLR2oAkovroeJYb6cObtEoF3GPjVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b="RZqYeH/l";
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA4606A325;
	Mon, 19 Oct 2026 16:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74AA4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=RZqYeH/l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=g6FawsJvxh2CZfs6XHDXBqTm2/HFt6BbeFCm+R7pPk4=; b=RZqYeH/lqy4ybTTHcrfti2FGVM
	7KXxMCOtEFk29Heoi0F1F9rG9rGds1rFHPuSw3w3BmWOrnDfJTzxY3fhvT45nWtjG7PWnrMuu01VT
	AlzOMqmVZSjuvVqGyI3SXVUbLdP0dYjMkB3yJVC4g+MLH9V/FrWV24Y23tXnTNqJrBs7zIZZM8kgq
	DXe9fA8zcZPsDy2OFJIYhNkStCzIfmqZ/Md7fvTrnPUbFLMxUIi/7syQAsXqupgQEhjc40hyyGZJ3
	1bSC2ZqOCkC5eUij5PbnZldlo/DWJo5S5rtzS94Pe1AbO1gGRKPuMWD9F3YiZvVpyy7rqw0ssBD0a
	nfWbx3uQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAK-00000003qsl-1HKC;
	Mon, 19 Oct 2026 16:24:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009gX-0aRY;
	Mon, 19 Oct 2026 17:24:45 +0100
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
Subject: [PATCH v4 01/12] KVM: x86/xen: Don't block memslot updates while halted in SCHEDOP_poll
Date: Mon, 19 Oct 2026 17:24:32 +0100
Message-ID: <20261019162445.37219-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019162445.37219-1-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

kvm_xen_schedop_poll() halts the vCPU from within vcpu_run's exit
handling, without dropping the vCPU's kvm->srcu read section as
vcpu_block() is careful to do around every other halt. The poll wakes
only on delivery of a polled event channel, its poll timer, a signal,
or KVM_REQ_UNBLOCK — and a memslot update raises none of those. With a
zero timeout and a port which nobody is going to signal, the vCPU
sleeps at the guest's pleasure, holding the read section the whole
time.

A memslot update then hangs, unkillably, in kvm_swap_active_memslots()'s
synchronize_srcu() waiting for that reader to quiesce. Any guest with
SCHEDOP_poll available can thus park its VMM's memslot ioctls more or
less indefinitely.

Drop the srcu read section across the halt. A hypercall is only ever
processed from vcpu_run's exit handling, so the vCPU's own read lock
accounting is always the live section here, and nothing between the
unlock and the relock touches memslot-derived state: the pending-event
check which precedes it takes its own read section, and the timer
cleanup which follows does not need one.

Found by Sashiko review while testing the series which lets Xen
attribute ioctls wait out memslot updates — those waits joined the
same queue, with rather more visibility.

Fixes: 1a65105a5aba ("KVM: x86/xen: handle PV spinlocks slowpath")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6aa00f746cba..2a0477ad0c91 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1594,7 +1594,15 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 			mod_timer(&vcpu->arch.xen.poll_timer,
 				  jiffies + nsecs_to_jiffies(sched_poll.timeout));
 
+		/*
+		 * Drop the vCPU's kvm->srcu read section across the halt, as
+		 * vcpu_block() does: the halt is unbounded (with a zero
+		 * timeout, entirely at the guest's pleasure), and a memslot
+		 * update cannot complete until this read section quiesces.
+		 */
+		kvm_vcpu_srcu_read_unlock(vcpu);
 		kvm_vcpu_halt(vcpu);
+		kvm_vcpu_srcu_read_lock(vcpu);
 
 		if (sched_poll.timeout)
 			timer_delete(&vcpu->arch.xen.poll_timer);
-- 
2.43.0

