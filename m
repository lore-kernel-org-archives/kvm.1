Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395288;
	b=mDFuvEMRDvzV+sDVEdn4D0zLkQkNHesuGUle7XH+7wEyXEqUyjOyMl9DnpTHzkGQDU23
	 Q1z3N0Vcvsw253m/ejpMKa75JrtB1Q4khIbXnmFnMSP8AoDyjdO/ySyFOKsu/a37qPXlu
	 d9V+TMiZaMjxH7BQSccvPKvAH7y1wnADw4NJsYK3HFygLtTURsbEeAhkcfwiVnQDNIJn7
	 SfiQIavaDKlOTRB+HoPyDWOi0x6UyhAwj+2iJorz5T0I15lbPfmJQf1N9WqLXApNdVVDe
	 2sIZMDYVbC0GwzGuQlcw4m88ufygWE0LEe85nOavNIE8x7tXQGAHOWPMfJc2INo/EpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=wBUcCVimSMxUE8k9Ea7hRloNc2vyINknzNzgi9oeUuA=;
	b=RWxxJf2sObkAZWJj1ngaG34w7jCHj4WnUvwWeyuViGfg/AIztZR778c7aPSRkagOpAjU
	 4W7YJCNCi1lV56Bl+8iNRL0X3wykAFrX/ng1jFBbXMEOjuLMkFcfo3yYIcx0wa20u+oWu
	 l3q19Bdpiw2vu/mqBFgl77tjLibP9LDUab27Eca1AgMiywyR6NQEUJqEMoGgHAIt7TYZU
	 7nXNIFvWeXEuQlvblC0FtQDtU/0tRQL5pdEz1XZfOHTuFxowuOwMT4/pm5uKAGfiDcGYL
	 IAfVRfAPh/Kg7R3bsXbMprLI6YIDL9nc8ZOry6cxHwg8+HweO2O76MycDY/I0s/uB4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hlJ954m+;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE86606A9BD
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAE86606A9BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hlJ954m+
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89f84753b43so840164b3a.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395287; x=1794000087; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wBUcCVimSMxUE8k9Ea7hRloNc2vyINknzNzgi9oeUuA=;
        b=hlJ954m+CulDKKSxDv8qZFZU5U4zEuyvNMWYfLRvO8IFKF3iRVW7Hf6e4/OMP9CyZF
         DMJ4iDSFM7XrIW8jQY3KTyRpKHR9Pt9npzs8WCfn1Yi9FeJ07DCtFlkvTopZly4CDOOd
         6nP1BLUK3WjJJCxtedIzubEnQLYlBTjGrFVwKPbpeLMLGOqIW6cQs/s+4ql6QO9jVVYf
         4PZLW814Na8+tJPuxlSMBvQWnFZN+CoTZLjGiVMP/lDz4AqdYr4LsOfIhy75Y1/kvAhw
         /zt9OKvsadD8QwsH4V0JuBMRTCfc/jdkiTto/PAZQCNoNX7mtFhLEx5SG0DlvnzFRKlP
         2qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395287; x=1794000087;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wBUcCVimSMxUE8k9Ea7hRloNc2vyINknzNzgi9oeUuA=;
        b=YobNsy4SGsmLMfzvGBuKILpjSfa+l8f1L4GO78C4ubkbQvSTCxfmAIs4J5NOy+FOZr
         jPUtZfz1n41EyZ9gJAn87ytuOYORmUAR1hnLry7cyg0QmJ788miC6vQejE5wP8y2J/7i
         ET5XkigpBSqrev4ACXhL90CSa8daGpE0g9CkVPsJzSlR37V0rfsE4AS2qf2CHZ3JR2rF
         KvrS7wkVGkqbsfVFSpvT+IXP11RLKomCT93L6msy17q+wC7UZ+3DZjG+d7p0M65RpwVj
         AfchIQMgztBA1QZF0Bi3bPK0HzLPYTqIcnwMIMx3OATN7ku+BbXc07sRcbaOl3ZU79Hk
         Roxw==
X-Forwarded-Encrypted: i=1; AKwUvBzUw0oFEEmC59WAVEBwZG19l7tDpjT01y9OeFEDwXuQFMQ23NEEsVoaLxM5/08xZE+Ckfw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxWxCZMTc0j+0N9pqHNb5/9tLMKUYjEMjQT2jK7/Masnk309OV
	trCyC4DgzLnsmCNUaJlL1UI/deESlBtEo6mjFMSVAM+PYg25s8XbNyHyi7hNrHdA8OVCrUR0FLQ
	+CmbfeA==
X-Received: from pffl17-n1.prod.google.com ([2002:a05:6a00:c351:10b0:89f:3d5c:8c07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1785:b0:880:f278:6b0b
 with SMTP id d2e1a72fcca58-8a9b9a5560dmr2884129b3a.4.1793395286997; Fri, 30
 Oct 2026 14:21:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:59 -0700
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
Message-ID: <20261030212112.2598640-12-seanjc@google.com>
Subject: [PATCH v4 11/23] KVM: Disallow setting memslots when the VM is being destroyed
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that KVM doesn't delete KVM-internal memslots as an unnecessary side
effect during VM destruction, WARN and reject any attempt to set memslots
after the VM's refcount has hit 0.  There's obviously no need to CREATE,
MOVE, or do a FLAGS_ONLY update when a VM is being destroyed, and there
should be no reason for arch code to manually DELETE a memslot: once KVM
KVM unregisters its mmu_notifier and does the final kvm_flush_shadow_all(),
there absolutely must not be any outstanding references to memslots.  I.e.
if arch code "needs" to manually DELETE a memslot, then it's already buggy.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dcd28b45ef30..fa548b12228f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2041,6 +2041,9 @@ static int kvm_set_memory_region(struct kvm *kvm,
 
 	lockdep_assert_held(&kvm->slots_lock);
 
+	if (WARN_ON_ONCE(!refcount_read(&kvm->users_count)))
+		return -EIO;
+
 	r = check_memory_region_flags(kvm, mem);
 	if (r)
 		return r;
-- 
2.56.0.385.gac671c819a-goog

