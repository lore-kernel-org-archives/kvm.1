Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB13FF8B3
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073507; cv=none; b=A6aCUlBDu9gW85MC+tw6+B8vwYuhkF2MR8JC6F/QIvK3aSX1P7IBEnmkh9uMuTYlLWDv6obe/PaK2kDWdnlzpz7qoF1jOaMhkwXX6Yn5YtZaEZSVd4slHzsgfMMClDSGl2tfFXCxcQvwjDqXqI90R7lzFbNBESNLRZFWmTN7a+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073507; c=relaxed/simple;
	bh=0HhtByV5rsxXuTBsxvldTKAWnLNz94TzjlFuF8ru/xU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PLOqbI+BFd5WD0nI2gR5c9ApJOFz+U5Prj6BIFhZetyIdtwC1ZX7XWpzS30fF/dfINioP9ZhJXWVJ54IAXissyURePLVRra9wbuAW+Ei4UkbbMC3KLgLGfUgED7mjKOnBl+37K+bg/Aks8mztgMtvieyy3HQu01qOOBttp6pZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YeyDWed9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YeyDWed9"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c4772950so7580193a12.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073502; x=1780678302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ewXhP3520EhD386XfwBnuZGOAW/5b7EnRAjGjx/ciMY=;
        b=YeyDWed9Wuze4XVAE7zex6WcKqMWyW4rYNB+l6jzQMi/LvzoH7NjZ3P943KiVcY36Y
         ZCJosSaNlHmboDWryzvkD1d/jKVh7Uuyxmpf1F+klYe2V0AHWDQ4pQ1oL5/D9sGeSTYG
         aKiik4Zua5/4MHREiwqKThnRnAka2KNWDGUOx5Blh2pfE+6xcXcn8VTPRt0IfEEHzX9S
         V7NpX59+Mnd7wcQhisetOskN08CeABeQaeuBjCXkh/eamck71BqHjWjOuQwUI+lBc0O5
         AZ2+O9NoFpxNUoj+a6TrjX0+zJLQnnG282ryNmu8fMdpbWMu0PAd2QyRzk7trLu4Up8A
         OMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073502; x=1780678302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewXhP3520EhD386XfwBnuZGOAW/5b7EnRAjGjx/ciMY=;
        b=AekTmc2sxVjVwZerVdPQqEYS6Z8jRVWin0f7f3b7UR4xDnuBOQOolOk2mSn765TzMd
         XQ8RDJPdfy24BE/S/QWTLJMq6hphA67n6DMcwdboFUlvvuyzEJQh4HAQcRzx4cc4l1KG
         h4rnUC7oTX1vYr0K2YiJUN+fgTRyqX31SdMRAKCICR/W7RVohq7HIN35lSVdrrH0T35M
         F+OmyOWsW/8Sy4IlCog7cvVfi0FEIYlPbKRo1pY+61ZBPKxJqMlZZayFOSXE6Z8PxTIU
         hGQef+xPB8Pvtf4tMJMfNkO7D4jnt6IC17S/M6DbFjA2sp4PxqKInVbLrXbBFRKZ0Lve
         lpMA==
X-Forwarded-Encrypted: i=1; AFNElJ9pTAXc1qJ+MvuyraiEAL5V+g0BQjczZ+S0Q2tlp8qYVZVHNn1XgnrkFyH2zrLM3JQpjNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPSyT/28VcO7oURNUiSq2yIojySbxNMScgO4M6Xbum3kjxTW+D
	vG+FOroMnRksRzAMxPmWtLW5/7aq3fU6jQ6i/N7AgDi+duNXcIxfCwPX//pAUqfHMhFZ4XVu9QK
	SICULww==
X-Received: from pgka18.prod.google.com ([2002:a63:e852:0:b0:c85:7fac:dcbd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6492:b0:3ab:30d:c7a0
 with SMTP id adf61e73a8af0-3b40fd781abmr3906703637.32.1780073501523; Fri, 29
 May 2026 09:51:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:10 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-17-seanjc@google.com>
Subject: [PATCH v2 16/20] KVM: x86/xen: Convert xen_get_guest_pvclock() to
 gpc's CLASS() APIs
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

Convert the Xen pvclock reads to the "map local" CLASS() APIs, using a
read-only variants as KVM simply copying data from the pvclock.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 47750316f132..89daad3fe712 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -153,21 +153,11 @@ static int xen_get_guest_pvclock(struct kvm_vcpu *vcpu,
 				 struct gfn_to_pfn_cache *gpc,
 				 unsigned int offset)
 {
-	int r;
+	CLASS(gpc_map_local_ro, pvclock_map)(gpc, offset + sizeof(*hv_clock));
+	if (IS_ERR(pvclock_map))
+		return PTR_ERR(pvclock_map);
 
-	read_lock(&gpc->lock);
-	while (!kvm_gpc_check(gpc, offset + sizeof(*hv_clock))) {
-		read_unlock(&gpc->lock);
-
-		r = kvm_gpc_refresh(gpc, offset + sizeof(*hv_clock));
-		if (r)
-			return r;
-
-		read_lock(&gpc->lock);
-	}
-
-	memcpy(hv_clock, gpc->khva + offset, sizeof(*hv_clock));
-	read_unlock(&gpc->lock);
+	memcpy(hv_clock, *pvclock_map + offset, sizeof(*hv_clock));
 
 	/*
 	 * Sanity check TSC shift+multiplier to verify the guest's view of time
-- 
2.54.0.823.g6e5bcc1fc9-goog

