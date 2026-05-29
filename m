Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C583FE370
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073501; cv=none; b=Y+xzs7Hq93s6M3TP4mRlf07ZWVmo1q/fs2jH3TEh8Q9tQHc2H0ZxpiwXRqV4H82hHt5npRtuk27eD9z1vFkFEuw4D5r8V7afz1Bcer7piG2ulqhisshQ9pXO8xr+bZHQjxBrQ/GvhqSOQicEQJd5Be8EuQ+7PiphfiXd4qLEGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073501; c=relaxed/simple;
	bh=Po2rTZ6jokeiPCNXljM27Dn/+9t8hD9odLXpV/XvtJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ecYn0sAGijxRyUv2FXFlK4WGRkRgvn8xhcIWRi6xeBepMwmasoaopYGQgWfHhNChC0bF+YzJfMi0BrB0iWLOkxVhtq95szbHmEsvGF+ZR+N3e6uoJODzzkaDWNvNIDyXz325Mv+AyGksV9Xd1jDgTDn2dVxtceVTr2VcbfDWRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LexjU8cz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LexjU8cz"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b99eb06178so68099905ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073497; x=1780678297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=d6AdMaZgWz2WUUzV0Lty2KxxxU18TOhDWUp2QLry3VI=;
        b=LexjU8czifiWQY7nrGRSb22ddREo7elUCSYuWWnwGM4jwkHnCk3M4/U1uccr6HPI/n
         apZ9auctrNAbg5W6SWHoyapsY7FKqmaxdrgzKp+TRItWi1lmeN4CnL8aHpjlTTcrzLDF
         DLeUPdFJU2S/op29e9lbahOauWja9ATTQr3xRByMc+bWOwkdrDPWB6gq6bZsjMs12Fq7
         pC+U78gekdgmKBOpEqMDdrB2tJ32ytmPqxw7Jz3VHaQ5KxeSSXHcKJZK8mF4hVIAdAiQ
         4gNLf71Q67W+9XbmHLMoE44awm8BsKgVcWNg7NNVQaccTdkQLCYAaGCKpXT4aawO6E+N
         +E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073497; x=1780678297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6AdMaZgWz2WUUzV0Lty2KxxxU18TOhDWUp2QLry3VI=;
        b=SBbbOwcl082isprkGmUChhdejHu4EdoadnD3mhWqxcbpn44hYo5dd0gUBh/rOtVPcE
         E0FeCJv3DOmN6woqpYQP1FuK/QRSXmKStjy/vo1/C9CWtxE9efmX8UrEqcomT1T4amPn
         P7jlTQFcNGa3Ee5FbaORLAym82zyUNwl/XxnqBEJODTKsNF4ZH7Pt5s+wS1NmeC9MAn5
         HRSoWri7UL6lTyl4iuaNSWQ4yt+CbqOwcsxQvIiqiQocXKq5j1YZtOrX0sWvEsWY/9/r
         tJTcItJ4lzWhyUrHhlItnzUX8KB71Na1BZegj+b/PX7HHCGe3yYbw8xw7aXibS5r5TLG
         14Mg==
X-Forwarded-Encrypted: i=1; AFNElJ92uOTLt+aNc/3JpdZeL0ktgaHBiYn8yzFnhHY+2iUTwlXh9mfNPGasrBb4d3sHRTL4UW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGhxg5YA/5ke5CTg2mNSoqTq3MN6yKFxCwcKQWLtZtcPvHTkh
	K2zUfJwW1HgrkmuernaL4kRfsUSaycgIGWwIIMgq6X5tdgemi2ZTTgclS6mxIT5YdUldswulG7y
	hvL4xCQ==
X-Received: from plae3.prod.google.com ([2002:a17:902:e0c3:b0:2b0:46bd:4fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48b:b0:2bf:2114:ecbe
 with SMTP id d9443c01a7336-2bf36809f57mr7505715ad.23.1780073497347; Fri, 29
 May 2026 09:51:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:07 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-14-seanjc@google.com>
Subject: [PATCH v2 13/20] KVM: x86/xen: Don't bother waiting on gpc->lock in SCHEDOP_poll
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

Use trylock instead of waiting on the gpc->lock when locking and checking
the shared info page for SCHEDOP_poll, as odds are very good that if the
lock is contended, then the check will fail.  This will allow using the new
CLASS() APIs for local gpc mappings, without having to add a version that
waits on the lock, but doesn't refresh on failure.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 065b4c92f7ed..d9b09809e243 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1438,7 +1438,9 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 
 	guard(srcu)(&kvm->srcu);
 
-	read_lock(&gpc->lock);
+	if (!read_trylock(&gpc->lock))
+		return ret;
+
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

