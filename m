Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139157;
	b=wStJtUjlVn0iw9BpgyN3yo0k2nKXhjeUTuvFxP2kqBh7Bah6pHCW5MrLKioEeUARBvCb
	 ak3khtgFma6aQm1dB9bSsS3K/FqUn0zR7jLKTGOlN6Jcqh3FVMOF+CaPW3R9kT/UpYTO9
	 KQH76Q2i7zsNSwjkgo/cgRj5ThY8kis5/vNDMZw4fZzXpd32hvD7VFg0VLATM7KGovWK1
	 6heUDnF28ScGKS0YCLmrgUAt3AFW/Xf2kMZ75jrzJDHy0fGFbkgusAL/tl1fS5NsGzKzz
	 q9+OCni+jiLz5a9wsAoRJOHhyn0erATcfav0tAiTBiN/gQbJvxw9i/4DHFvFa5lIrEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=h43t1HfpFYnqrCz4owPlG1Jkgt4xdvVHI5bkdA4UEfg=;
	b=5TWyp2MvWUiATDbTxDzzFM18UJJrgGgV1fN6skTdETMiqqHma1FN/iuo0tzAok9R5r1U
	 CTlRoaFZGfX13Rmtjq6i9qnx16JOTFolgdLK184mSDEL9tZy7D0ahZEobBi9891HBsohU
	 knSBqQpygw5aht4Xt7CC6wlkOvS9jdDryu1Sa6CPlMnzZbT+XYBHZt427K0PAQh+x09YS
	 zyE5727t7CjGQmaVcWPtdoZdRcxVFghXaMqPJXMPd4YRACSBvMCPNZsl8KVEIn7MTx/VQ
	 43gQCNbU87SOFTPTpl0MyOmNh893F5N49cqAB9Y9+7ypyYHtzgfvFfaG/x9WNbn6VTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BEke+Vh4;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99A60A383A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A99A60A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BEke+Vh4
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd67466211bso218273a12.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139143; x=1793743943; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h43t1HfpFYnqrCz4owPlG1Jkgt4xdvVHI5bkdA4UEfg=;
        b=BEke+Vh4N3RjrReBMj5eRa+hIuswUKEehrHzZ4J6reI77JRP9sUF9TMj7kK30WtFV5
         OGux7Ia743PSnRfBulWb6QUM03Kc4wdzRD80Pb8uLxALD5yF87X/ro8ZY0MHjQTx0K2F
         md7g5qCGns95pv0P/PjMMAYx2lPwkaaSnq5eostK48etP4SqALnAbgGqxKPgjrxPetuA
         1gnLQNt5Cvoosrc1998q3sDtLRFBI6UlRTan80l4LsGBFpWpfDN4CKRMk2w+TH3D2i5S
         EgvIpLco/4FevCYAfTIG+ZZeqNiF6QazTfpTMel5nazlaE8huDRPaovgqqEKxgzezTfN
         RLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139143; x=1793743943;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h43t1HfpFYnqrCz4owPlG1Jkgt4xdvVHI5bkdA4UEfg=;
        b=2eM/w05JFhSviWZzkMGkkr5kn6EvuYeZ44fbCLuC2m+E2Za2ef2u1qvrtPxuH06wNR
         yotbGss/c14A0lhGMEfeGN5hqoiUhdpm77TBv/NejG9MhnIZY813S/PTfoq0IsDBkQBc
         qf72whjY3QqyLHaJ3/6X0zR/4evHx2fFanJYQWt4rF5pY/7/dkkxMH7kcV5GLrbxhBC7
         YxQrrkjzX6n/11DhUmiPwMg0pZj+POawyLQgqCLPyqMTW57xB++6tgoAsH+3GiV92HSd
         nbCSBlXfdI7p8QECUjwuV11Z93eez1NcsJUgFTCsvMX1gFsJ9uRCarHi1W/hD7kIaQfY
         X6fw==
X-Forwarded-Encrypted: i=1; AKwUvBxePZMnjU+EzXDFP46kUOV/1t3tqE+ZRlT3c3LgFIZwm3sEAVrG/1ioccJDtvtzj/Uv42A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKERP5Y/8fWZKYKYnzY5OVETHrecpmhItk3ZMakj/R0tDMeiXv8
	dq5q7mgm1ziP7Ew384oxQ88w9wmi5ira3Rmi7Z5Vqqyn79P3OrXQ1YtzJBRO+w/D0+J992ESXxP
	SDMXEng==
X-Received: from pjbfh5.prod.google.com ([2002:a17:90b:345:b0:3a8:645b:da8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0b:b0:3ab:9c73:12e
 with SMTP id 98e67ed59e1d1-3ae57e07896mr285693a91.6.1793139143314; Tue, 27
 Oct 2026 15:12:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:02 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-10-seanjc@google.com>
Subject: [PATCH v3 09/15] KVM: Pre-check uaccesses in KVM's APIs to read/write
 guest memory
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a check on whether or not doing a user access is ok in KVM's APIs for
accessing guest memory, *before* doing memslot lookup/validation, so that
buggy KVM accesses to guest memory more likely to fail noisily.  Because
KVM installs dummy/empty memslots early in VM destruction, bugs in the VM
teardown path will fail on the memslot checks without getting to the WARNs
buried in kvm_copy_{to,from}_user() and friends.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1058b864d427..d8b914b76f90 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3298,6 +3298,11 @@ static int next_segment(unsigned long len, int offset)
 		return len;
 }
 
+static bool kvm_is_guest_access_ok(struct kvm *kvm, int offset, int len, int size)
+{
+	return kvm_can_do_uaccess(kvm) && !WARN_ON_ONCE(offset + len > size);
+}
+
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
 static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 				 gfn_t gfn, void *data, int offset, int len)
@@ -3305,7 +3310,7 @@ static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3381,7 +3386,7 @@ static int __kvm_read_guest_atomic(struct kvm *kvm, struct kvm_memory_slot *slot
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3414,7 +3419,7 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot(memslot, gfn);
@@ -3544,7 +3549,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
-	if (WARN_ON_ONCE(len + offset > ghc->len))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
 		return -EINVAL;
 
 	if (slots->generation != ghc->generation) {
@@ -3582,7 +3587,7 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
-	if (WARN_ON_ONCE(len + offset > ghc->len))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
 		return -EINVAL;
 
 	if (slots->generation != ghc->generation) {
-- 
2.56.0.307.g5fe7bd680c-goog

