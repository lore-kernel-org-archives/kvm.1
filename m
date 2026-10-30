Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395290;
	b=n9LxzVmlTRokaJ++6252yKfGC9ZMNLZvfbAceKiq2uvcbi5OZHDHRdao3yveODAi4KZv
	 2XtcELbDWzZ2Xvt1Wn9Ud8uh9vKkJWtjlxnOgWZkA3aksGyLPXtCdAZbsX9Vf+0ZR7H+y
	 MHi/97Rk4KMzyTQnc55SOw5LcnCKi5/hWavtOLMLJe/+fASaegDUwqk60EGRaCbk9OgG0
	 OyqUq/0VWijRYfJogFynvVND/h39PFo37URXYKRhi681EXgMEfpH1JA5Uj3BfXhayCQKb
	 CDc8re8RRMuIyNOvAEOTHxXfxtpIXE+f07MrFHUnekiIC1nWk0LWUjlbb54SevNvdSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=iFN1OdobNZOI9Kqr8g7DQiTe1TY1BZi1PiVwsL0/XKQ=;
	b=c5+Cp516I5BYrwWrVVR62QBYcIKIG3fMHLz5ooOINGjqDz8jRa1gUV4uIcwkB67JP4Ga
	 /p7V3k0kMENhYPCnJwXt5ugcQar1q090a47Nc5yi8bQZFE45pk130vC39n7OAAGxakda0
	 HcKTT6Qi0ICSx9bTL9E5wO/tmX0VMkZ/vzsW13pu/FjTq6eTZnZNlp7u2ircQKw72AhSp
	 a0isClxiyezYLUP9RbfJwKwWRI2RCebpCOtdO+33Bt+8wh2JKPUpg6/XYfJw+r7nOfzge
	 h/6lPKnCsMYpGIXlO4B9vb6ueAkJEuto0EN/E6ZaIWLRGsS/JC4owfILCwXAdqtu3rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jp7jpYEd;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51A606C33D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F51A606C33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jp7jpYEd
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea71803effso12553945ad.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395289; x=1794000089; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iFN1OdobNZOI9Kqr8g7DQiTe1TY1BZi1PiVwsL0/XKQ=;
        b=Jp7jpYEdDT79nweNwXIEayZNamkfQplMNHyoZon/zGYI42Kx3k2nzUy761WieypIp9
         sB17ZowmsECNFdGhrpN4ijT7Khw97hoLh822jw5Zo383kvZbca/LA+AIbWhz/oLI4XtG
         P6TS2vvSHVZReEOJn3SAveuzoGHrv7kOZ1dktyH0I/hZs5oSV7roSxMcc2QiAoNViVtV
         8HO+pKtAfrN7+hz2SSKtur6oitzImSUkR1bWK/5MYbbfT/vwPZHvgvV6mb9YQ5JlB+wN
         bM0UOYtXqnM9Sjmh/j4MS2bZkIbqh1vjMZL0CAyoAXn/Xla+Kf/8u609GwtlhQFp6M3g
         Od0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395289; x=1794000089;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iFN1OdobNZOI9Kqr8g7DQiTe1TY1BZi1PiVwsL0/XKQ=;
        b=1OtApr7TKRPDkr3Rgbru2UyAMo5BLedPH9oiCH3B2K2a7jM/B7/kU4VzfEUT45PCTQ
         oCYr4ZrEOLm7eOcZCh73rp1V4SfPI9VhCQth/EVP5cE4H2pEDfoX+03c4yne9aCXB9u5
         8ioBQd8NEwwklvzao1aBTDyrSkkoJb81M6GGX1oN55EMuklpYoFAZiSloyPHY61/SdGt
         tHeP16x9uE060ezBP5QiV95XRwbZ7JzZAdWvBeS/Xr9JlTeCA2MFF9FTOMEJpvHjAPkl
         tpNMj9VStqSYBj+UWq1Va9bX7ld59n84Fw4h3DbF70K8DMJ6aWX8jHhuhOAXLbxQ1Emy
         U3HA==
X-Forwarded-Encrypted: i=1; AKwUvByGWqTJPnOU+29Z6IQFoXtbj6paJ/slhcYbQ2II8cY1suZUtu/H482y9u99JIpQhgyaeGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRCubHeothX4ZDTORBmXzrfRf5D8SIJtjWtAIELdL8mcK6rZNI
	fX6rQWA/gj698jfEhCi78daQbLNLz5iCYMHOAkVcTsVh3mLBWzZzFZl2RhIHrai9Aw92d7Qyp1g
	QaJ1PMA==
X-Received: from plsr11.prod.google.com ([2002:a17:902:be0b:b0:2ea:d63d:f2c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3804:b0:2ea:fb8b:258d
 with SMTP id d9443c01a7336-2eb36401e95mr37934335ad.6.1793395289485; Fri, 30
 Oct 2026 14:21:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:01 -0700
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
Message-ID: <20261030212112.2598640-14-seanjc@google.com>
Subject: [PATCH v4 13/23] KVM: WARN if KVM attempts to do guest-related
 uaccess with "wrong" process
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that memslots are torn down before kvm_arch_destroy_vm(), i.e. now that
the massive, unaudited path that is known to have at least one rogue access
to guest memory should be short-circuited before attempting to access user
memory, WARN if KVM attempts to do a user access to guest memory with the
wrong address space.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index be27b4e8f12d..f3f59bdf7e18 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1355,7 +1355,7 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return current->mm == kvm->mm;
+	return !WARN_ON_ONCE(current->mm != kvm->mm);
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.385.gac671c819a-goog

