Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427099;
	b=qTxDF4fKSPiulai9ZhzS4JYA6WRBEnplOdm8VFBXz8yNnkjtBxDVlHI6GnmQeMFLa3Xn
	 ZNiNFIysuhSshYEeq0njN3DLdRGn9n8DRLICZeuJUIVK057LEj3M3AX3LK09XvO88ggIW
	 8rQpjTKeihj4O54Gbmkgk2Xg+NHFwl8TS/IO4YYlV6pjl2dOR69cqwq7MzZcSJ8aC/1BS
	 WUyuxE0lgG8FdsLItYsRAc/xJlrMwAAbCxTih56rOhVb0Z+BB8/ReBO0DSm17lw6dlgo/
	 luFHyM3P/fj6MmITkpfaoywt1Y4Dj71EOnt1bQ85eGC/TktGKxEka1toZwOHsHdmUYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427099;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=cFcjSX1F1kgoXLz+gVxRBvZE16O8bRWdEkwbe+t5w/8=;
	b=nUO/Ymndx6UZdqXIcaRjk7Cg/I7gbgyFfkjmzmA4CadO6t2ARiEbuJupS0OJs+7l36jj
	 tm3WGMYcaAA4KyN1e/XI4q4tDlz37R/wEIYUP8fzK8ljGUG3cAy5rwkdZrDF/xLfYbSkD
	 EitqUK4Q8CbfjrqhCnigi+HrGTqAO1q2EkJEQEyx5Fp5BAIR7J9OD4o9O3Cr1t0lTKNut
	 sSeUf42ad7L/2sXR8gQC08X4Vo2ZtwtgPe3rKF8FDJlsqDdw4S3EtehXSVxCRLF0rCtb/
	 RvvccEFraUpSUwBICutjwoSc95/ZVBUYHnXFty2N19MD3J2Y8GEcEhlD+0Hx1xyJidg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC0606A326;
	Mon, 19 Oct 2026 16:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74AC0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=cFcjSX1F1kgoXLz+gVxRBvZE16O8bRWdEkwbe+t5w/8=; b=XLuE1yYy9yjBFmLdj+GA1C+fFF
	xsIvO/uhY3KXnrgvo0PXA8TnG25Z2/7afQnDTBFByZr8dh8tVDAz0sN4mIr0YJh6LG3g61Egi6kEN
	NI93085TwcojVANhO5TBpZC+GSPwyNBuB10RvDmK3ZSh4rGOG3DIucBfoq0KKzJcM34yn0Px/UiPX
	LC4B/ifxOmV9HHn0B8zSTnfAaiaxy6tA0+mWPB3MSNsdT8p2WLvXsQuTLVu3zcW/gwqhD12mQBD79
	1xJMpH7LO3uCfFumkXXvIUb/wkm7R9dGEGSO36e2PT0ORygQ6wCPmxVnMjMb5LOs8ZxNwjX41jQx+
	LwshNjvQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAK-00000003qso-1HsD;
	Mon, 19 Oct 2026 16:24:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009h7-3EHy;
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
Subject: [PATCH v4 10/12] KVM: x86: Request the guest TLB flush from record_steal_time()
Date: Mon, 19 Oct 2026 17:24:41 +0100
Message-ID: <20261019162445.37219-11-dwmw2@infradead.org>
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

