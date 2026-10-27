Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139141;
	b=bbW/Y6tge8jpGatzd6Ci0hIV8+Ldwh97UIbL79vtU8tuMJB6eBTv8UETnXv+GfDYm5Y6
	 t3TpvFNeVukG9aLy8K+mxH7VuSxHCgIlcBrKEJ1YL96NL5Qq+SNn8GL+EGxTFXMoiWgVl
	 LCjaAplI0CNxFm5IFRH1WuUneLcMZzkZhpZZW6wUlNzhBqQGzhaWdWNXaE2j3caUrlyO9
	 11CSbqlXUbP9XFRBZTuBR7YQ9f23StTrnwTLtME+h+Ns461Jqsonnrl9sOirEODkdBuKF
	 4PJh62AGI5a/NDOQg9+dRBuVITvToe1DHE2AHnjhb0bthG2VSSvLTTVYhfpNW16M17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=46E3EGLnWSLxFlTim02Ohjypmi0q8zDH6vLR5FUSx5Q=;
	b=Wwv8Xl2DvB2v/TNC3tPMvVdjSCzbQ7BroOMv/Wgv0vygqu2X/NPvjPTrarQhHcrraKJQ
	 kcee+N9yJazlJhpQM5q2edXVga5uMd+VBeaHReS9pLccAA1g8K7iitPQ/fZzvcGruqZrQ
	 4ob0UIvF3wCkUmxLXYwjicmAPrJW1S4K23/q5tQAU+KxXv30uUfT25jzN3UYE1jP+MruI
	 U0sH8XY78uXbKRA0j9c6w77WSCwSfFhVCUjlylrIDxITvEZsC4z+K1OThOyBKTCnyeXi/
	 BKf9PfiWXx3pEZaJcPrYTJ/DlFnAa1q38v6a1/8oIx+vCMCNRjALdbV6r2HupbWCvrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FEiUD6Nm;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86B606A33C
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F86B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FEiUD6Nm
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd65070d3feso174638a12.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139137; x=1793743937; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=46E3EGLnWSLxFlTim02Ohjypmi0q8zDH6vLR5FUSx5Q=;
        b=FEiUD6NmA4q7Lj9g0qrqngYzU8vV5soYbosUJyfiZMiWBd/dw+maunFfwuqyTSvW03
         nTkzlAmArJ09UypObCpx7NnIewwkl/iDuRIp5s6MKhUm+UbmgqANvqdL7P1s2PEUY2sg
         nBnOPxkB5EvpAprFdIsBAgrCLpmVhdoqk6oASVXHjd3vE3lXJLTd0BU9t+Wrv+dDX1ja
         7KoeKi/6tMbmP0PiaIp9+N2Dlz3XxneGfxFyp7qZy4RHDein73of4VYgbxF0RPJnjikX
         QhOCk/q3apHeK2iQ1RjrmTcErsw2YXZckmV1LqGKQHAM4qiVkCWs5xHBMW3PphB2OjOb
         OX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139137; x=1793743937;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46E3EGLnWSLxFlTim02Ohjypmi0q8zDH6vLR5FUSx5Q=;
        b=yermlN3cOk7g82N8y6dU7CTG6zK6csDtiZZwtxbuE6RCBh3Op3TGDrYfuCVeXOgPD2
         1babrphm6TJBOnqmBvCu3DfUgB6eIsi/RLDRyb/Vj4H0NxkZExep7xCch5ZHCPtMOdOh
         SnvyYsi5VDhfajH/lNqAgFs0WWOBSEC7ehiNIJN6KCK5E+C1hqz7SE0ChjcpBBuAtbj1
         IFv9kiGTHwMbLlPf1NazuCPmG+QTDqBhzTNegDkwpi3qmPtUYF7fhe1acVAXnZVYhHOv
         YzzFGRGO6kaELwxsnbmvWaWX/+gbSgepljZ1Hl62kDnrib7lR4N8c1tJ3HTlU7iG19j0
         xiUg==
X-Forwarded-Encrypted: i=1; AKwUvByJw2HVM3ywXRXBEpJUSEft815fxYCoTGBnWmYbbdEK2f0SKEp5V20tTdA8nwFMf75n598=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4Ni+6+3rBmC/oywKyMXGyC9j/TXHuqp90rfdQQBzxLZ89XIY9
	+70HCBYS9RIWrKOuyxVzLQ3bAt3TYPcl96MXN6cehNNa1gV5P3iQNC1mQ8MyhCSkiOZE7M07Zdm
	+uLnIYg==
X-Received: from pjbsv6.prod.google.com ([2002:a17:90b:5386:b0:3ab:334f:21ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c0c:b0:3a2:bb9f:f87d
 with SMTP id 98e67ed59e1d1-3ae580d22admr196697a91.21.1793139137381; Tue, 27
 Oct 2026 15:12:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:58 -0700
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
Message-ID: <20261027221209.1560865-6-seanjc@google.com>
Subject: [PATCH v3 05/15] KVM: Disallow setting memslots when the VM is being destroyed
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
index 218456372b11..e7c89861632a 100644
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
2.56.0.307.g5fe7bd680c-goog

