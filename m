Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573863F86FB
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073492; cv=none; b=sTxWidOhWP8CUxlUiEHZ4VHBRkHQTzuzL/CWMFgfzprwiqNr/UZCcp4MUP+p5KGn0dOCt0zJuqq4aL+n8uhyY4PdEuyH8U/14wOI0S8irq2yX6KfLcLstNcIbRgLzkeTEV72zGR4jWJMUOpzQjybDSJakDD25ZFCxVNBb+F3es4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073492; c=relaxed/simple;
	bh=oW/F801MDiaEkPjxmUiqZ3f0Bc8U/zEyrHl7/8D7RXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fDExPztAkRNf/gXmT+VAHGkN1Pm0q4gpRV7huKf7ONp1etw7rL8PsGlvHfkg6DfS3cm48ZEsbRL73ArOrBvoGPWrHfi13xfs2cS5u6Jg3hnX9D+dEVWHu21TGrCrAy65EUV0APjqt4LAQFgdIKOz6L/GhucZ7EoCXHyT94WvjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aE7LGYjv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aE7LGYjv"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf08c2a24bso23687335ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073487; x=1780678287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TJnjdAhlmJESU3BFxz6VsHnLTiXOcrzZ2ZxCcyybtBc=;
        b=aE7LGYjvSM0/EX0jjg1p+tTwrefxxf/NJ0FMgxNZH7DF0FSjN5JpMsJySNhk4IH6Wc
         i8zKMN4wvo2CwKFTHBfA4eGrmSroWXyVt1Zt0Th3c/6chcl9W4qWgJWjZh93GE5xXEtu
         UEx+GU4pCsIZTxSXHAW7NfQxGKzWyeD7zrsvUJQcqHjEIz1yUS3o0WFPxdzH3V9ovp8l
         iQ+Ops9xgc7I91rtZFAQ18dqZug+9n6CZ3GNv5B3nIfqmDrwD55aFRuHwGvwo28uXJ01
         jr2gv4FBhcriESBnV96J4KWJijRZNlj6u029Vb1sgkl3G3Q56v5UruMobk4wQTEgWqID
         ECuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073487; x=1780678287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJnjdAhlmJESU3BFxz6VsHnLTiXOcrzZ2ZxCcyybtBc=;
        b=Aeo2mfAIkVQ7X73g32yTJwI1E40WHy9yX8ZQ9zzEl9S+KqU+1tygsfnTaC2Sw3J09U
         bPNny+njhXTuWTgNA8jSeOwyjUdC2Hm+u6vfXz5WnUYQyTsX8Cgu29qNezEq7ZPcd7CZ
         fk7QlJc8928AhW0tpEiU9iDY0rc092ZqMOWcBuSpbTzpr3+nzT3HKWtxYvWwPYb2ecdQ
         bLP4BL2sWBn9xzIXomwFp0MyIwuESp8SdXvwAToaAothCORWqebE9AkODvRvOi0x1/K+
         ngxA0YHtAgy8gnpwRQL6XvX/SQEQzpTweNkTM/NH68DABqQAuAMMEzapsewyvhRCkLH2
         5AHA==
X-Forwarded-Encrypted: i=1; AFNElJ+8JuYLbtqEtq2dOTF09QbbDY34VM8QHQ3/6cJSOTQ3o7DURId1yBfub9aJb4Nn2LM7Q58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtgXYbYI3Lx8KCVbmebPSZql0tpxiGdVabaqQaYQ/KxnR8hB4
	1We82wyAdeWOrxHjkBlkGitJtO/dZ9q1fqBw2jIoMHCA+W889Eq2b+wJPboL6hzZMnfO3aEykym
	xEZ0Olw==
X-Received: from pgbcz14.prod.google.com ([2002:a05:6a02:230e:b0:c74:664d:4080])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf12:b0:2bc:cf06:6835
 with SMTP id d9443c01a7336-2bf36798747mr8362995ad.8.1780073487261; Fri, 29
 May 2026 09:51:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:50:58 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-5-seanjc@google.com>
Subject: [PATCH v2 04/20] KVM: x86: Remove unnecessary irqsave from kvm_setup_guest_pvclock()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

kvm_setup_guest_pvclock() is only called from kvm_guest_time_update()
which runs in process context (vcpu_enter_guest or ioctl). There is no
hardirq path that takes the GPC read lock for pvclock, so irqsave is
unnecessary.

Convert to plain read_lock()/read_unlock().

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e6f1dd84f22d..87e99756de0a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3265,18 +3265,17 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 {
 	struct pvclock_vcpu_time_info *guest_hv_clock;
 	struct pvclock_vcpu_time_info hv_clock;
-	unsigned long flags;
 
 	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
 
-	read_lock_irqsave(&gpc->lock, flags);
+	read_lock(&gpc->lock);
 	while (!kvm_gpc_check(gpc, offset + sizeof(*guest_hv_clock))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
 
 		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock)))
 			return;
 
-		read_lock_irqsave(&gpc->lock, flags);
+		read_lock(&gpc->lock);
 	}
 
 	guest_hv_clock = (void *)(gpc->khva + offset);
@@ -3301,7 +3300,7 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 	guest_hv_clock->version = ++hv_clock.version;
 
 	kvm_gpc_mark_dirty_in_slot(gpc);
-	read_unlock_irqrestore(&gpc->lock, flags);
+	read_unlock(&gpc->lock);
 
 	trace_kvm_pvclock_update(vcpu->vcpu_id, &hv_clock);
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

