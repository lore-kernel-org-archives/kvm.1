Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395279;
	b=BaF6BBhacGkWcrXdf+E56uC16bsCxq9384l4zQDd2mJtcjLJTFH1YY0GKvoEyy0EJ4O8
	 QarjfmHPaCS/x5Oi2HVPD1hbfFgrMo1w4C4C22NMsidj/uDgn/iNIUQDXf8fdE58NFX1M
	 gPA8xnKNeqptY3ukVdUrvSCLwiA9WeY1HkFmKYowvPxqsXAWM0Jyb9OdqNWiHJPhhn+NE
	 6QdGiE9jc32yk5Tg0wF6t/NCvx/kqlqMBlI22T5WP9uTFU84B/u2d5P+o89GrrIsO5Yr6
	 s7SoYJlkwz9ptxDZ2mBrRUqhD5F5O/J3g4sijIS8NxUSFb/p42IJB6RWN8lKWELRbZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=MEhWTFe6jtxX2Dal10Wapygbfs7VfCvFh36BKYtVScI=;
	b=s+WjgrAezHOEzal2KUW6bpHx0MLRxnBvRcSJDxsqYA/NPxoflonwk/tv+8cDM1BrNdvJ
	 tQpV4Y4Cx78OyIL1jbCYvA0bo1XgL2LCNhNqn1k/Dv7ia5PUawba9VKrirI/bCv4vjdH1
	 o9nVldrgVgQxjblROm8+XOdKsSb1DSOPrFxQwPSP8zefn7vKWQ1SwFNlZfIZ8oy9nw8WH
	 hAkzG7UUfVEv90XfN5OzOutO3tE2kHbZOz7ZAMZah8fUVolmTahkr52AqIiB/dAt8nYRd
	 BoafmpLYLIevqkk+68PHQXdQHnvsZWsKKLJCxXPz1JaUDm8pDD59792AaJA0jyuCZRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="L9/I4MRO";
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1540B60A3833
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1540B60A3833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L9/I4MRO
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd67466211bso605894a12.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395278; x=1794000078; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MEhWTFe6jtxX2Dal10Wapygbfs7VfCvFh36BKYtVScI=;
        b=L9/I4MROpIUaWaVHMpI4y9WQFiUA/81ULVBw6yuBd7Fyu3T7XxSq8PdTk47iMRW6Qa
         50Pv7uuRm/3e7vtQnJvjf3OeMhCYAqhEenMyN/aKGJO+oKLWAxWud/n7n9VgZ6pk2Ylv
         4jVO3AxuEA39T4cxKWG9fS3EYmrSP6tBA+JRC3+1UulY959Ja5AebvO5Yqu+ip3Amuk/
         w7oJ6GUD6/ki+gpXqVpccOWf4XmKD16mVBSuNxl8YVJy/UI5PTfC75+PHiz4B7/D2DTe
         gMhOBccFyWL/5qNnG0n8WIQUZVxqV/v19M2L9QzggSp45iqgjxHjr/tjhUKaqY78n6hK
         IPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395278; x=1794000078;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEhWTFe6jtxX2Dal10Wapygbfs7VfCvFh36BKYtVScI=;
        b=w05ka0X+tFw5FHNvZJmuKWcO8y6wcvISrHGjOeWzMUievyxzzdPwMYvyKq4DxnYc56
         +FSJlcWQN9MTCCNpmMpCUwbZfcvi7DRTOxi0pTCQ2Ib+V5pkk3UZ0TvRhkjpMmEjhm6s
         +EVpSA2nO+rnRU4CuRop5+ZmqIaNVOct3zUwh6vXbc50OWX7nAWjWWA/7tdvNg/3PAqV
         3y38w20+gP5ZSEUyevjQfB0funryXZSj5unXWIy36F84L+4MLpNen1kjVQJBZqsWooFT
         B/hYCAbC3hB/+8P+IG53eDVRvc21GhqQGHgYj9r64o+8z763RvIZPqOznaQR8FTQO75R
         NXnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpEsBhLSAW704BOqzdIESrXGt5SPpAO/Ut9pJS4o8TJphH9VO2XbC0BSGP/9Z0TaGXz8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+WlHHPL5sLDB2FfEfUVbVd0C5WLmG1K0CQWuyK+7cMPUj6qsW
	HTd99/x7hQ5m8yHK9WHWldz7XA2YGmQjRxJWeMUEjYoF1VmjpqTbDp9hBZpC5stlBGmGSLHARA8
	5oAH72w==
X-Received: from pgbd28-n2.prod.google.com ([2002:a05:6a02:64dc:20b0:cd6:1088:b8f3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e8e:b0:3e1:c08f:c41a
 with SMTP id adf61e73a8af0-3e928daac3fmr3216721637.49.1793395278183; Fri, 30
 Oct 2026 14:21:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:52 -0700
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
Message-ID: <20261030212112.2598640-5-seanjc@google.com>
Subject: [PATCH v4 04/23] KVM: x86: Drop dead check on an existing memslot not
 having any pages
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Drop the should-be-impossible check on an existing memslot not having any
pages.  Ever since commit 0577d1abe704 ("KVM: Terminate memslot walks via
used_slots"), KVM returns NULL if there is no memslot.  Before that, KVM
pre-allocated all possible memslots and relied on npages==0 to denote "no
valid memslot".  The check on npages was deliberately left behind to aid
debug, but that was over six years ago.

Side topic, there is no need to check for KVM_MEMSLOT_INVALID as it
should be impossible to see an invalid slot while holding slots_lock, and
more importantly, invalid slots preserve their original size, i.e. the
npages check has nothing to do with to-be-deleted/moved memslots.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..cb8b60da5b11 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10043,7 +10043,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 
 	slot = id_to_memslot(slots, id);
 	if (size) {
-		if (slot && slot->npages)
+		if (slot)
 			return ERR_PTR_USR(-EEXIST);
 
 		/*
@@ -10055,7 +10055,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		if (IS_ERR_VALUE(hva))
 			return (void __user *)hva;
 	} else {
-		if (!slot || !slot->npages)
+		if (!slot)
 			return NULL;
 
 		old_npages = slot->npages;
-- 
2.56.0.385.gac671c819a-goog

