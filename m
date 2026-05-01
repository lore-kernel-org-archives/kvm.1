Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340042314D
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667750; cv=none; b=QF8Ri9rTke1EmGwxkKr1KmnrBa70YU+X2Qcb+g4DD5g7W//bnITziwV1teVEcp7liDX9AEfPXCK0IOyBHqSGeIN1sp61GUaPcRp3eYFJ91to4eH8N0nX9tteCugAtdstYG6O7UjgVAzQKpcaqjOH3nTuQ9WFyw/zGUK3tMyGZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667750; c=relaxed/simple;
	bh=02VpepIxKDwd6JSFwiFOibCa1QXJfBVYk/8UJWozIXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f2fbzW8pkEwd4X9bN6X68x/GvHhcUW1dpMnfL9UY0UUSnWrrMKeL+tCGXB9EP1o6XeFqRu5vJ6tOb1LvbWXy2C0PieTalZr8AvyPqbqmbNc5UCv51p64tX0Olf+YRdJIW4wmFslsmCQVa1k/Kb844YWhNuCpq+4CSdIhB5PzOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aFifwHHm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFifwHHm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f543bae3cso1181049b3a.1
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777667747; x=1778272547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BinFFV1dkoZUzfCSB4lA7tacHEnMisx6I/yLVxf53IU=;
        b=aFifwHHm3sJPJjoX5loWOyYF9BK6WBbfvEmQQJI5uSQLLGi/vn+YCXbtZml4z6VRDA
         w6Vqm7CZU4OKmt0t7JFpAIz3yllVFizpDvuh+yOqIiWKsazYzWuzOU3aScux6eb+/7id
         nxU6g7Odgi48IKhCZKuiq7519hsWSend8Q6PONbtSxI1kxiupCfy1s/EYbPOW4LhjA7X
         27JOFrzOEEj4cyFLucNTxQydr98e5St1RvQMG0heCC1HG4YaLuQDghhUErrvFZ2oS+B3
         10LqhCdUck/Xnx2j2hLDeg+N0f6yCF3bBUkh74oRN0XSrKd9eZg9QJY1dqk4kp5zQlXh
         W5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777667747; x=1778272547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BinFFV1dkoZUzfCSB4lA7tacHEnMisx6I/yLVxf53IU=;
        b=Gts2c/zVuMmT3myl7B6V2/SPjUjUCzDJXYFCyexTuKgW0o1tkDvW5bAPOfhEaYyNqb
         RsG0Eop6GHs54QMsPsq3F7mz52gUMzIPiq35YIUNBBnziShjgCLOvcCKxFx9ywWnZA/g
         d5XJecJ1iW0G5aRw0Y+0/JHIY4pMJXUgoC+vuPMaxh8uFVUehzIFZ3eFFqJ9FFXOmmIL
         966cjtMmSkjIW7hSaK/kamQbTWa+lGZc5/d0nh9ngoUdfKvQeGBWipVqdidXr9nN+V9T
         Lrco0mHBRoGDGUEUwU1dZ3Tr0m+7Ipp8fJ/rwS6PCldS6PDo0I9N+VWIzyFDc8Z9AesW
         FG0A==
X-Gm-Message-State: AOJu0YxJVsbZV222sPcJPgYBhRFJG+loe2mJmolv/umZK/vZEtR4z5Ve
	50MgW5i2VbD2Rd7ya+2NDzWH3elwsf/RAB2m2Zii7KpQZS8ld6FVSHZYuQVFU7X5O15TJS91GZU
	fzEH8DQ==
X-Received: from pfdd11.prod.google.com ([2002:a05:6a00:bc0b:b0:82f:61ed:8b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4292:b0:82a:76ab:3279
 with SMTP id d2e1a72fcca58-834ffed2e45mr7068807b3a.4.1777667746892; Fri, 01
 May 2026 13:35:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 May 2026 13:35:34 -0700
In-Reply-To: <20260501203537.2120074-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501203537.2120074-4-seanjc@google.com>
Subject: [PATCH v2 3/6] KVM: SEV: Explicitly validate the dst buffer for debug operations
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When encrypting/decrypting guest memory, explicitly check that the
destination is non-NULL and doesn't wrap instead of subtly relying on
sev_pin_memory() to perform the check.  This will allow adding and using
a more focused single-page pinning helper.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b9d7bd868e0b..9d2044fd910d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1357,9 +1357,11 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 	if (copy_from_user(&debug, u64_to_user_ptr(argp->data), sizeof(debug)))
 		return -EFAULT;
 
-	if (!debug.len || debug.src_uaddr + debug.len < debug.src_uaddr)
+	if (!debug.len || !debug.src_uaddr || !debug.dst_uaddr)
 		return -EINVAL;
-	if (!debug.dst_uaddr)
+
+	if (debug.src_uaddr + debug.len < debug.src_uaddr ||
+	    debug.dst_uaddr + debug.len < debug.dst_uaddr)
 		return -EINVAL;
 
 	vaddr = debug.src_uaddr;
-- 
2.54.0.545.g6539524ca2-goog

