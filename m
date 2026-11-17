Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950956;
	b=UCnUuuvXkGZeZb65F82ESQs9vOFJA4RGdkrYWklcsboj7M6NdWaFTgecH68L3m84GQpt
	 k4G9BvMe2c7QwePhsOFtYzmC+dlE5eMVJvT0nkko4MwBSO8yubl7zRur6gVo38TS5tySa
	 /GJnIXHjmUf4ysZAleeSPRvvn8ymzBaQUZBtVbTrzjq3hI0R0ppvsI8/eQoarKE0xgwoS
	 gnEe+C+aLkDkPLQu++2FIwwA8f5kTZ7orLK1w6Q/qzgwU6mxY9gwHi9/WBxvY+WCRVAJ8
	 XOj29uEFvxBvJHbU580/Ei97kto2D6eMH+tKcpXLxkOJQWDcUgslMC8MLDrX/jH2CBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hTDVIba/W9W2yqeaBqk+u2F6+BZLE6k3DrmbJxOrlQ0=;
	b=YDO7f5oTZOrXppI+OECMCR9UIrgujqDNAn2sjkE6ID4X9CSXWxV84Pnv/Fkxvu9imZdD
	 l4kmWuLAcRBeqFEXiH5hFSnHb6raAPZagKRjOKBaw25x0YfcTsFohbbq3fG1sbUywHzJd
	 zxDgGKxiY3we/64h7nEdsduIlhk0CaMLv7YvtOgC2nCONITM/IXvQSHLZSp0mZnTIh/Qi
	 Q5sKOa4XE+kHx0bY/ybOMjtAjUAnvutoWD+mwwAjsNb6XLswM7I9XbiWvmxOw9DBHYXlP
	 9gmzdUHP5sHVmHj8Q+TQiQKWi4YPcxwiJNOFJubjNiI50nnCOwBtGidYDngkrMbInzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vy6AYHoW;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FC606A88B
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B4FC606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vy6AYHoW
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b3a73a82a1so170792a91.2
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794950956; x=1795555756; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hTDVIba/W9W2yqeaBqk+u2F6+BZLE6k3DrmbJxOrlQ0=;
        b=Vy6AYHoW8OSRtrJpzKzm92WDNcLprEMLKT7IHCulePdpqoqOlW502siXtPHVWZVuOl
         VeoIC4q9Y4hEulVNH9nLfml9XdKCaPE/F5pVmaGJnbVhANQ78tB9YEjOn4fsS7IQdzJX
         0CmEDII4VRKcsD84BkYuJLLJNJCZMh1Kdjhohbd4cF70yrlZDYURu1gxT2OMA9BHS9PY
         vPIT534RqoGoxqTwZ4/eyRdGKeKSi3IgyFjj/PeROghC9QSVyhlfP3rJUAQ6/mWP4EEW
         G6WgvaaXgvkMckdFzSrM86fTdsvV63yn/Tp6A0DbPHNtYcQDwv+RtaiFuk2xSfp2LcX2
         x0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950956; x=1795555756;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hTDVIba/W9W2yqeaBqk+u2F6+BZLE6k3DrmbJxOrlQ0=;
        b=JjEfS+Y9bwbn67gBSSm+KK4umrgZiEtuhI8kLQhhGJ05C60XBs5aFk5It3H+nB+suk
         yowg4WhqVA/bxQKDreO5Px2NWtMsXzeTCHDQ7oqKh4HYorgYNkSAkYIfCXisD/65d6AZ
         MPPLUjvKrysrTtB1Wu97WoWO9/Lyl1ZzacPh8aIQj16kprmNvqAt4G0/rpOgz0bH3MnL
         2Cvj79f7X4HSEGhftyLrcdlgnJi+O8UiTK4S8EVDyZMiuSPEZ2wqIa2x8b5/XJ1/qiG6
         Y2bJD9PEs62LGKeZgw7eX0VJWwFq4F0RKeAUM5Da5L4ajuLu7VJQHE9CMVm+HiHf10aN
         NEtQ==
X-Forwarded-Encrypted: i=1; AL+hErGx4Gk/wfNK7bOPxGqdgCPWjx08AOJKSgoPyp1GRzi/bGYK8QNJgrGisgGnkp214g6leFo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AD3TXvpM7qKk4k7tVJml2oXOVTt1equrDZOJyrrLBx7FivQfO
	u08fkc8lRRBsj6HLvcykDESW9zh3SGlKg0fngweLn0KD6nKD9kwUilir1hjnDZlbXFTAjOlMFhl
	NC0AVY99FNkFvrGzbgw7Pdg==
X-Received: from pjbgy20.prod.google.com ([2002:a17:90a:df54:b0:3ae:c401:753])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2784:b0:3b0:968f:fdef with SMTP id 98e67ed59e1d1-3b3d07d5277mr558897a91.49.1794950955763;
 Tue, 17 Nov 2026 13:29:15 -0800 (PST)
Date: Tue, 17 Nov 2026 21:29:11 +0000
In-Reply-To: <20261117212913.3634487-1-jthoughton@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117212913.3634487-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261117212913.3634487-3-jthoughton@google.com>
Subject: [PATCH 2/4] KVM: Use smp_store_release() to mark dirty ring entries
 as dirtied
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Publish dirty ring entries to userspace with smp_store_release() in
kvm_dirty_gfn_set_dirtied(), instead of an smp_wmb() in
kvm_dirty_ring_push() followed by a plain store in the helper.

Setting the DIRTY flag is the first half of a handshake with userspace:
userspace load-acquires the DIRTY flag, harvests the entry, and
store-releases the RESET flag, which KVM then load-acquires in
kvm_dirty_gfn_harvested(). Commit 8929bc965964 ("KVM: Use acquire/release
semantics when accessing dirty ring GFN state") converted KVM's side of
the RESET flag to acquire/release, but left the DIRTY side split between
a barrier in the caller and a plain store in the helper. As a result, the
helper doesn't convey that its store must be ordered, and the store isn't
marked even though userspace can access the flags concurrently.

Now that kvm_dirty_ring_reset() relies on this handshake to observe an
up-to-date dirty_index, make the ordering explicit and self-contained in
the helper, so that all three flag accessors use matching acquire/release
semantics.

No functional change intended.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 virt/kvm/dirty_ring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 8fab75dace76..d0693ef6e479 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -95,7 +95,7 @@ static inline void kvm_dirty_gfn_set_invalid(struct kvm_dirty_gfn *gfn)
 
 static inline void kvm_dirty_gfn_set_dirtied(struct kvm_dirty_gfn *gfn)
 {
-	gfn->flags = KVM_DIRTY_GFN_F_DIRTY;
+	smp_store_release(&gfn->flags, KVM_DIRTY_GFN_F_DIRTY);
 }
 
 static inline bool kvm_dirty_gfn_harvested(struct kvm_dirty_gfn *gfn)
@@ -245,7 +245,6 @@ void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 slot, u64 offset)
 	 * the entry to userspace.
 	 */
 	WRITE_ONCE(ring->dirty_index, ring->dirty_index + 1);
-	smp_wmb();
 	kvm_dirty_gfn_set_dirtied(entry);
 	trace_kvm_dirty_ring_push(ring, slot, offset);
 
-- 
2.56.1.708.g77570a6a1d-goog

