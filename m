Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395284;
	b=K1fQBR3GHP8cmy3rDer8llcG/TJ+5IltCMaIy4/EBKV0Sx5Xd91sunm2MVUQeyYSVQen
	 GXKIEAfpePqeGWBj6JkZQs2II57xDLQqWtv1SOXr0/q0phr5b2VzyH0OAyAzsshXzFSJM
	 UBWlIvfyji8Fw3fZvP5nT0dK4S06yUwCWpI/o1F/h6d2FjaqMenVQufyzQG/nmc4CuSxU
	 bF9Yy8GgMDJqiNugc05FK6rHnqoGHNGgZvUpfi8a1eVOoiHU9bMTL138jlQxHNSF4CusS
	 /CxEyF8x9MQ3LG0n8EnWvOwKgyqSjpK9ZRVqj/LcfnycApvqez8M9nxSl5NpX4kDkGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=mm/jFK6aaegQ9pZQ54m0VqIEuYvDOfyBcHCegw/+L/s=;
	b=Z7SsXmDDMW0xogQ69mamuQr1HHYLhAv3TgT26ZRBSMnwxaulQFxmVnAxIBwMU7KrfZPr
	 gMOvYQdgt1y1P6aRZCNUpD44tCSqXz6T1OH+2TfzCfWBDA2eebUdtkCHud3dtCPr8SmB7
	 cOe4k8hUW6KRqMbfuXSBw9u6Fiwnuz8foMAnNOc5RJJ/iorMvLEmfv0mx0PYT9aEyMk83
	 i1FlCDY3lJbp7HN8tN/nBtFNmgdocMcF7ntY0XRi5B693ICw9/i37NYSvRRafOtsd52mA
	 uap+VaG3/PDgp//eZ0VT9pF/fU2ErI/gQMKgeHtxwod/dNLXAXpt14lVYWvCpSsWzAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l5dhk49t;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19060A6F66
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC19060A6F66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l5dhk49t
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac77c3ff6aso1486297a91.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395283; x=1794000083; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mm/jFK6aaegQ9pZQ54m0VqIEuYvDOfyBcHCegw/+L/s=;
        b=l5dhk49tz7IPRF9MgE7g5hlUj6Sr6EPjTNnlBYJDyQnb1HIuepAb1WI4EHVaDbheHz
         c0HD8mh0EuxU8KV9SOiPBVWWUh2Ty8DnYdCPZQARqpDnbgoV8WjZmPyyKAsq6sFJ5SwB
         AE3EbDq/C60SE5yu9jqQWI5QWOSJK4w5WCrPPfnprHbJaJDVSDGyp00vkVqdM8ohniJO
         asURtUfA2rb1y1IBnZCGidmSidHuS9Ct6MZu9yhf9i6ul/rNeu1W4shj/luoHHdslrVW
         o5pY3GAh+ZwplNAmwgCRngYgbNkaST3XSG8wRjj2Hexoir0J8d5VthCyXsPWjbH+I/NZ
         0Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395283; x=1794000083;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mm/jFK6aaegQ9pZQ54m0VqIEuYvDOfyBcHCegw/+L/s=;
        b=Pu4V+BwNhP4d4bNl3D9ORzv16t3vkQcWKPwg+N9AIi/CY3CQhY2DdauODfv6MGy7cd
         40dliYGo78w46zBLUC1fSqidQO3oa2QJl+wzKPGFJiuuL0lb4VEV6fHvx6uad5udpyBb
         rRQne3WfpkKjHJS7p4Ui/7Ji2Tl3B4qNI1/Y6VA3OJMm3LMuJCyvrhQmdl3eWlzuWYEi
         n+TSrFpPr8moB1IKzSGk2RfLndfx/6NllHLLigRKSZy3aAqsbHDupleV1JoH1/eJZwNl
         MG/p3ELwfdxto/+q4AeTWTbMP98QhDtUNOX9kfGCsyV2zwcG3b7h9S81IbdRJEL/MPXm
         p9Yw==
X-Forwarded-Encrypted: i=1; AKwUvBzzbrZBUotDsdUFr6mOTRdpJlGQrKg484tTorUvjFhNgtDcAColMU9ZAs+z44xNoqi/pAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLS5WGWbjclUY9gN/lE4ypuBYkzSQg/7k0dSozplHCkiN7+ye6Y
	4xra2AmWceA+zT1X4RhFVZysGLmbzVpyvmqG6PsC6gm30bTLokn3WNQt13XwQ2iYx7xDqhBoFm1
	MtPi0Aw==
X-Received: from pgo14.prod.google.com ([2002:a63:e4e:0:b0:cd6:aee6:763e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1cc5:b0:3a0:bbd8:5ba7
 with SMTP id 98e67ed59e1d1-3ae89879e16mr3031014a91.62.1793395283274; Fri, 30
 Oct 2026 14:21:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:56 -0700
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
Message-ID: <20261030212112.2598640-9-seanjc@google.com>
Subject: [PATCH v4 08/23] KVM: x86: Process all address spaces when deleting
 internal memslot
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Process all address spaces when deleting a KVM-internal memslot, i.e. try
to delete the SMM memslot (if SMM is enabled) even if there is no non-SMM
memslot.  This will allow retrying deletion when inhibiting the APIC access
page (the only scenario where KVM deletes memslots while the VM is alive).

Fixes: 9da0e4d5ac96 ("KVM: x86: work on all available address spaces")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 326f8a9a5d18..0b94f981a2e1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10011,6 +10011,9 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
 {
 	struct kvm_userspace_memory_region2 m;
 
+	if (!size && !id_to_memslot(__kvm_memslots(kvm, as_id), id))
+		return 0;
+
 	m.slot = id | (as_id << 16);
 	m.flags = 0;
 	m.guest_phys_addr = gpa;
@@ -10044,8 +10047,6 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
 void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
-	struct kvm_memslots *slots = kvm_memslots(kvm);
-	struct kvm_memory_slot *slot;
 	unsigned long hva;
 	int i, r;
 
@@ -10054,11 +10055,10 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
 		return ERR_PTR_USR(-EINVAL);
 
-	slot = id_to_memslot(slots, id);
+	if (size && id_to_memslot(kvm_memslots(kvm), id))
+		return ERR_PTR_USR(-EEXIST);
+
 	if (size) {
-		if (slot)
-			return ERR_PTR_USR(-EEXIST);
-
 		/*
 		 * MAP_SHARED to prevent internal slot pages from being moved
 		 * by fork()/COW.
@@ -10068,9 +10068,6 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		if (IS_ERR_VALUE(hva))
 			return (void __user *)hva;
 	} else {
-		if (!slot)
-			return NULL;
-
 		hva = 0;
 	}
 
-- 
2.56.0.385.gac671c819a-goog

