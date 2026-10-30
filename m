Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395300;
	b=nn73MNfzp5ddp6KIwVDmtsRy5bs1iOLC4MmhY46fsLdgsitp1CkCv66SKFXJwKvC6Xg8
	 u9g7DMSt9QhQsQ8wL7nI6r1YNdbaRgcfWvRD9rpwvL96YWAYHvRc2Yzr8L9hVdSo/yhKB
	 RCAwFyuzySMFn0Yhj2vwiAZgsPYzsr29c9bJUDYaS0wwOMGJjrxFBQwi1B41cNXDigQsW
	 QiZPx8dp8cYhCNohJOhHvgHQIQ/OXgm5hp6OXq/vhcVX/tN6S4RKjzLk8J8Tsja9N0vzV
	 6m6u6lWuVo5CJNhxwL/v5JTqZWopNe1VN6SHeqA0HrDTQFUy0OQ9zBpwTCtGjB87OwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=ceuCOM2fbzBxVJGWrb7TFjcOc/THvEWLPHPqQKuhuMg=;
	b=LpjWV/1xck8aHrWeAuMU5MpYT5F+w+wydcXcXpw1/t8ZQUx9VrM9GByNyKzPYBMTb4+l
	 0I2bv1YA4Y5DngjeiTA5h/0XNuddqTTAuLAIVuRlxFWn+nFAccmy6XSA4JLWzwdbGc9uC
	 83b3VMwivakggi9nsxbciX1VCMunrFhW7azuynv4Z0WQAnbxXmfFDRqqSKp1IHStGBqCq
	 GkL7/oIo+m3SToOIvO81jyKDdiNqMaGEAqTVo2ygqNOlxkh8l02Y7LKOM7p7gQeOdsFIu
	 yDD0Wpz06lJ4D+14fW/+E9XMVBPaaIXZ0XKdzDHJss9kMhwPyHJmDxeANzo9u9SB7BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lR3Iiuua;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495D2606F772
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495D2606F772
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lR3Iiuua
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdaf2a74482so626547a12.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395300; x=1794000100; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ceuCOM2fbzBxVJGWrb7TFjcOc/THvEWLPHPqQKuhuMg=;
        b=lR3IiuuaXIEODbIlKRWg8hkHuedhyFO6qu4+KIiHJSHj+ZH+zF/jao/YxTzVDDqfaB
         O9c04trjcGzWn3w/N215j4/my/SCKXMesSvDz5myZ89F3vO+SWsTHHtG5DI4MBIl2O4D
         yduOOB5oqTMQOgmae/Qd8ZVadjxdfIVMT6dEllxxZUCWs90RRJmmHaI7br6oyFOAdj+i
         UFzZCZLyg9F88OlNNa7NTer0ERR+BJYEBFQKb8Xl4n0av50kW5vwJo8ypF2K1OgruvUB
         aiYQLKr4564E9KzkQONMju2bFdRdhyyAYWSHhp03z1OPo52oozx/kIBn+buZCj6ZnVgq
         gptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395300; x=1794000100;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ceuCOM2fbzBxVJGWrb7TFjcOc/THvEWLPHPqQKuhuMg=;
        b=2wCg9/N2QDTj6WCYskQ4+T2xGokEM3BZmIMKCsn00MmRO6blAFM9xca+bVkSkysb/r
         Kc33w296vGxNFkTqc5jXGReOVqpFo7qmOAhPqny0mIoTHV2S72XB4oV6wjUvsMFWNHCW
         sPSubGUthtxnAdhX1AfGCgE+TZnzclO/97Z7uWucyyanWOBDk7SryeT0NLj6SLMX1tNP
         zfOsVHcw51+U/+5q5UyzLNGUTMFNigmrHkdDuhn3+YXZx7qmvIBPyWujdjwwpBQDjJ4i
         2uH3LsNvos0ITBVKi5u0DwkZKa7cXUd6BBCOD0BkR0qgPCqJENkX870tLri+Dz7lf635
         qu8g==
X-Forwarded-Encrypted: i=1; AKwUvBxhxuo52HoyRSEf4Mcl7Z5WSDIjLgcRy4CrvGtJFQuMwWykzTlCYUuq/6bqaSirI77OckY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL02pogPiocm6cXCS5+nCKT4hJxu3nIi5NW+K/9nfpY/793OjxE
	tJEiMYAhUgU/9G82C70kZd435pqinzgp926DG/Pcm5tva9XfO3X527qO9HIuIxtstOop8OzHV4L
	juSt4Pw==
X-Received: from pjbgj14.prod.google.com ([2002:a17:90b:108e:b0:3a4:fb9f:4a65])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c07:b0:3ad:a17d:f46c
 with SMTP id 98e67ed59e1d1-3ae8982bcf3mr2740137a91.62.1793395299370; Fri, 30
 Oct 2026 14:21:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:09 -0700
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
Message-ID: <20261030212112.2598640-22-seanjc@google.com>
Subject: [PATCH v4 21/23] KVM: nVMX: Don't switch to vmcs01 when freeing a vCPU
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that neither free_nested() nor vmx_vcpu_free() relies on vmcs01 being
the active VMCS, don't bother switching to L1 and thus vmcs01 when freeing
nested state.

Temporarily keep the vcpu_{load,put}() pair even though the only reason the
vCPU needed to be loaded was to be able to do vmx_switch_vmcs(), as there
was at least one *known* side effect of doing vcpu_load() that KVM was
subtly relying on (taking the vCPU off the PI wakeup list).  I.e. defer
dropping the superfluous load+put to a separate patch so that there's a
dedicated bisection point if there are more lurking dependencies.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 553915015a75..4a8f57eb3277 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -393,19 +393,9 @@ static void nested_vmx_do_vmxoff(struct kvm_vcpu *vcpu)
 	free_nested(vcpu);
 }
 
-/*
- * Ensure that the current vmcs of the logical processor is the
- * vmcs01 of the vcpu before calling free_nested().
- */
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	vcpu_load(vcpu);
-	if (is_guest_mode(vcpu)) {
-		leave_guest_mode(vcpu);
-		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-	}
 	free_nested(vcpu);
 	vcpu_put(vcpu);
 }
-- 
2.56.0.385.gac671c819a-goog

