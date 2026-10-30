Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395281;
	b=ai92ErJD1SxXIlsjK7x0w9zhCBlWQ6vuqzHfW77NjoOkF9bXN4Vy3LqIL//eIGBjgTrK
	 1kp6vdYluQ3xBhZ+lWKFXtC9ArgWvcYFXEFbdluzsERo+FsxzxkS1NKr1NbOQ4zsOHsPb
	 4kYc8a9ndLZbokanAPG9bfPRe+ERAtAWjLF8BVKMKiKdVzDPOjQirhiOr83cXc0bvpP92
	 o6+zsa3Ebcjp54xqB0120FR35RIB9BSUV0b+G+9jpufwuT+3M9N3OgN2NzbjMoHGgMgRv
	 B1SlTUwyGv/KGNWIac+UyxTtGW6Zj7P4sdAuaymgcfIvWfGlumvhMaxwiSvgGedzMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=aAKXgeyyRU3oc6qV+7Ii8MEYj0RDQoBh44JQ3GvzeWs=;
	b=sCxzC00jqSPjiQV11AVM3MMLUPZMbhNFUpogOR6mbgmtZvdHnkYnJuRqzpsbVtdXURSy
	 zWHIYWlXvElCvidfNqQDLvmmNSf+grOs3pC7YV485R40XZ3L1Qs7AlhFmcst+5BSINQX2
	 lvORRAHFwVCIS91k9+rwrQqzcspdCva88zHalWdrMgcs4TlrzQkpF0ZdxmAewSHSo0GQ2
	 hkdv66hZPXDf1pWcQrizByw05VxbvqUSfIwUZwAXUaocjaQE5RuofRSL/JGn5eZPsXGT3
	 rHHdlcIb3pjVbcI6r0u9zJ37aCf3/vFre1xNbql04uznZC/bRYOzLGz8UHyXxQXB45g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fBtP01UU;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B660A5BC6
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 484B660A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fBtP01UU
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea0fe07201so7364215ad.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395280; x=1794000080; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aAKXgeyyRU3oc6qV+7Ii8MEYj0RDQoBh44JQ3GvzeWs=;
        b=fBtP01UULHuAuhMYQT20WHZFHCmA4OUsIVhmpCwu/ynYLrC3cJqUL9o/GEdsEm3bcd
         uAJm9iHYzTj9u93B3m5CAC+vK+MGRtBtf3Pln8yTpoQxzeIziSdARnNeCKLWc+I6U4hl
         liyM2a6Yfck4ScNBXZtxMAbdBj5uwC7tUUjIjVO0sgK5YMyhr+doQopkucTL0dxbUyn+
         emdREsdYGG/4+0Gp4/X7QeP7RXjhvmzHAm6h3zl0xp0cfZyUfKz0jCoEMkBhxQKAlK+q
         tIL/6Qj2GI37BWimB1xEQoDmr5sIOhIsGkC4sNy+DQ8K+SpBLzYwTFTGXfsjuOEoNQ6o
         zK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395280; x=1794000080;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aAKXgeyyRU3oc6qV+7Ii8MEYj0RDQoBh44JQ3GvzeWs=;
        b=ZcxAX6fLIdlaCQF7td/gbnW0xYrEuMSE0bZ6zADV+buXwew9Xi6zLGF1vkMMTy/epQ
         4r6rHG1COeIdejoYS1B4M1Mvrul5ALkMW2Hy27UpxRuWHivocJcP+MVtRQxpb1dDF0Gm
         a700CzlKh1y9xSiupeBmGjQdnwxfXdnhmRexzxdYUTLdhgsCj05Vt/7cK9tSPzEgILKs
         JSXVNi71yYZOVPvXcMWHHzlB8004GwQIoMmVtNhRfOgXczUVXjXTuGabohKk7ClJYIfX
         pZS1+iGTLVX1RbtQe8lp8GF7U1vhDclMxPZEstO5+9WmSvoXrmdElh2twpJNh8m4iQ04
         Dx5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwf55y5VtJs91v5Vtng1196qQt3p1EOL+k+t9ptdaGUSZ1gc67RXLwfPGwINMZxR5nwyco=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjeDFxmW3w+F1bJhpkgb1sSkm4eK3TMJa5ixN64NT+aUwHPx6Q
	eyQKxmnDNNMivjk1SOZ+4q6YCgS5znuwkp5zGD/OVZNpzYcjx1oC+NuS+06TPtaX29PKtWke+ei
	LmRsXZg==
X-Received: from pjbfa4.prod.google.com ([2002:a17:90a:f0c4:b0:3ad:99d8:e894])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac1:b0:3a8:211b:6c6f
 with SMTP id 98e67ed59e1d1-3ae898662b7mr3039027a91.67.1793395279439; Fri, 30
 Oct 2026 14:21:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:53 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-6-seanjc@google.com>
Subject: [PATCH v4 05/23] KVM: WARN and error out if memslot update encounters
 existing slot with no pages
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

WARN and return -EIO if an existing memslot with npages=0 is encountered
when updating memslots, as KVM returns NULL if there is no memslot since
commit 0577d1abe704 ("KVM: Terminate memslot walks via used_slots".  Before
that, KVM pre-allocated all possible memslots and relied on npages==0 to
denote "no valid memslot".  The check on npages was deliberately left
behind to aid debug, but that was over six years ago.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 218456372b11..dcd28b45ef30 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2086,9 +2086,11 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	 * and/or destroyed by kvm_set_memslot().
 	 */
 	old = id_to_memslot(slots, id);
+	if (WARN_ON_ONCE(old && !old->npages))
+		return -EIO;
 
 	if (!mem->memory_size) {
-		if (!old || !old->npages)
+		if (!old)
 			return -EINVAL;
 
 		if (WARN_ON_ONCE(kvm->nr_memslot_pages < old->npages))
@@ -2100,7 +2102,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	base_gfn = (mem->guest_phys_addr >> PAGE_SHIFT);
 	npages = (mem->memory_size >> PAGE_SHIFT);
 
-	if (!old || !old->npages) {
+	if (!old) {
 		change = KVM_MR_CREATE;
 
 		/*
-- 
2.56.0.385.gac671c819a-goog

