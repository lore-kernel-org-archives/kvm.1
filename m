Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16151406278
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073508; cv=none; b=fdP4Fxw7PGX85oV1/n+GROMoEjG/1gDDCsC4RjbLGoVQ8YQQZYRjCYuN9u7RBdzJ5PUInzn2artcHxCJv61ErqsdlSZAdxaf5pz+OUzhP98E6GDsbQAimoKxQSc7kK1iuKx4KOS/U/7EmTthIr+n4o8sA2w585frHIPn5JfDgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073508; c=relaxed/simple;
	bh=mox19TzrslAZs1BtaxxWeJ01fL8LSqdy5s10jatghS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EYVHCB4eQmpApCcvaVpX0/0gOw/6M+dcpI8Gd6cL7ANMK/Wh/60G7trqseZMUoBp8Wvvt+c4i8hFr4s8pTy03GvHWASWbBppiHVdbB2nywuzpC6zYhE9PlIywvPLFLabC7oN/0j7J059ev60Rxq6KDZok1rmY7jCz7hANVXizEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PF/2jcjN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PF/2jcjN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-367fd7b8825so14158360a91.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073504; x=1780678304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TD4h/NKvbeZX0uke90rA2Hq9F8m/UJMqfSOKDUlllno=;
        b=PF/2jcjNX6j2qfawaxYVMArg3OSt+0gMUMLyiOwZygm62z+pC83U5DeP/OS0YL6Nq9
         h8lGXLiM+MmylwD8mQQV/o3dMwS9k4fzpy70R3J8IvD8ximrksLN1Gk6j/fLhauIDAgR
         8Oueoy+yENSFEHEmf0Zrl0Y81LFBQX+dl+F4sETXGlaQyWf6qHpsyouY6doJHF13rQ58
         Dg99MyEc9fK4J3kzY82LxryWX/rXef8zfHULJ/Ti4mx4ecfpNKb9vuDJAyfCuSfwI6B2
         Wre621aB1Ed2pJtMkryu2v3S2fSjSWd8fs6mzcOSNDnYK0JCp0UaKInudrVBuXGrN03t
         Jrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073504; x=1780678304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD4h/NKvbeZX0uke90rA2Hq9F8m/UJMqfSOKDUlllno=;
        b=Gs5Yorpv4EPuCkcjHqFB4v9aKpu6/cjnmexHrsBYjbPvIICKqdkwy9TthHQ7Lj3Lz+
         NXHMiTLgv69QH5bjO7TP73irFjwoJgEJAo9zN6qCpOQXaykZVAiFK2Ez+kyVVxjHE2jx
         0ySmznEyY6MHlcycTg+7koiOMs00SiA+2JPDGqg6S+bTZDb7wMs9Yw8eYO3UPmuNkOqP
         iSjiT0CmM1ZZ5tgVn/WQ+x8TyT1IqNHteB5Umwq6xIdRRXr4wvT8zit+ImoCtokiouet
         Af89Pnj9e1OC4BBnPcdOgaiQE+/sg9Qh2QlalVApsqe7W/2fszfDYU24oYQ6h5aEe2jo
         TYcw==
X-Forwarded-Encrypted: i=1; AFNElJ9jB8bxZRVbsX3zIiwXdXpNxdVb2DTxqIG0a3bAQJdgOPK5RN+alLaMC4SoyBXfb1vykwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4K48miwelDncGDwLr6SUzd/E0TvspUioHrTZPV+tKl9s57QE1
	/JJYCwUb5jsGYriUnNVxry6qCfEX7BpbDG35q7yNu6JVX9M62b1fRn6nmCPMUZbSxizZmACtfn7
	xTuKmZw==
X-Received: from pgjn13.prod.google.com ([2002:a63:e04d:0:b0:c85:1092:c503])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c2:b0:368:78da:803
 with SMTP id 98e67ed59e1d1-36bbcaf76f7mr4327305a91.12.1780073503994; Fri, 29
 May 2026 09:51:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:12 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-19-seanjc@google.com>
Subject: [PATCH v2 18/20] KVM: x86/xen: Convert event injection to gpc's
 CLASS() APIs
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

Convert Xen event injection to the "map local" CLASS() APIs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 2c776e475a4f..3ebde7ba5558 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -628,24 +628,12 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	if (!evtchn_pending_sel)
 		return;
 
-	/*
-	 * Yes, this is an open-coded loop. But that's just what put_user()
-	 * does anyway. Page it in and retry the instruction. We're just a
-	 * little more honest about it.
-	 */
-	read_lock(&gpc->lock);
-	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-		read_unlock(&gpc->lock);
+	CLASS(gpc_map_local, vcpu_info_map)(gpc, sizeof(struct vcpu_info));
+	if (IS_ERR(vcpu_info_map))
+		return;
 
-		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info)))
-			return;
-
-		read_lock(&gpc->lock);
-	}
-
-	/* Now gpc->khva is a valid kernel address for the vcpu_info */
 	if (IS_ENABLED(CONFIG_64BIT) && v->kvm->arch.xen.long_mode) {
-		struct vcpu_info *vi = gpc->khva;
+		struct vcpu_info *vi = *vcpu_info_map;
 
 		asm volatile(LOCK_PREFIX "orq %0, %1\n"
 			     "notq %0\n"
@@ -657,7 +645,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	} else {
 		u32 evtchn_pending_sel32 = evtchn_pending_sel;
-		struct compat_vcpu_info *vi = gpc->khva;
+		struct compat_vcpu_info *vi = *vcpu_info_map;
 
 		asm volatile(LOCK_PREFIX "orl %0, %1\n"
 			     "notl %0\n"
@@ -669,8 +657,6 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-	read_unlock(&gpc->lock);
-
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
 	if (v->arch.xen.upcall_vector)
 		kvm_xen_inject_vcpu_vector(v);
-- 
2.54.0.823.g6e5bcc1fc9-goog

