Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAB3FE370
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073512; cv=none; b=DyRGHSeDdEtIhDHbveUQwgQ0nz1SnlJvVZzVvYPePYe3fAwz4zfj5QFGU2nO6qD+PSicY2FD7IpLzhFRPYHR/MzedA88YcvmdhGFjuvTUw/rXzb5mQky/g4McGRAZjCcm3nlcSe3DuchwoDarvXcTpBkJipKIezdQpvsp2fJ2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073512; c=relaxed/simple;
	bh=iJIJe1fMii+CIS5HHndViwT1rBLgSNUAciekKF3V8cY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F7SQav4ujRsjdnFH9NX+s7L1ZRhpIf7i9jVe20V58L97oj3OkBsmANdr8nPMuMiWSPH1mph6GrQD9vlzs0TV4vCBu/GVPqGdEfyUurHTqD+1vLlh/KnElskcgVelJB2974SmrJp10Md+O++0HVLfRPo1ZP2Q3Nzh1HAu9Ie1EnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nw7cKi6o; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nw7cKi6o"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf0b7425bbso34851865ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073505; x=1780678305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=K5pvfWIqzQDNhPL3FNzz/qK/cOT6WUwNj0yu/46Hxps=;
        b=Nw7cKi6orUrmKqtVR3RD7jOrZ8ror1TYmfGQWQad/RD2SDXVrLXO54MTMPzvqJt692
         LjdVFxabSA7v88E/FUPIYT5Bacc/ngitHFzeKGZDf9VaAi4jz2i/+DKSVFuRifM8G0UR
         rQcny8iybyOb/0CKpd15lxdaoP39+hQ0ye6OW3eRBGNouuYbxQHu3qZpe5+J4n25V+FW
         D9bLDU/GWCF29y9FwjVY0MJFixjpVnE8j9LQBh1toMmmQ5AJn45g1fz6ctAhsW+bI87P
         6JHnKZIGSN/tEdAmVqRJ96f1QOvzDfsr4j/bRHO1qf2qGoG8mU+HL2GsHqPFGg5+Ssw5
         R44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073505; x=1780678305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5pvfWIqzQDNhPL3FNzz/qK/cOT6WUwNj0yu/46Hxps=;
        b=CXcCzktuHUJpJWiTMpmfzDe0LlyFhsdM+wmnVEOotUg6xygltxIvsYVZFqiEQCPu2Z
         ONopr0w5Q7m0mYKl9fzVnBmL1mXCXhB8nobEX2ESAvdUHkHs5fE9Y1JZ889HCGEp4yQc
         LVij8UKjnsR+ZdAGwnyBnaSQoQGbVC8DEpJVjQveZDYdPl7hQ+4z/9+BATuPvoOzcDpE
         zL1TJLg/i2zW6WnQujtuNUEpqfRy/w85FYOf/P/ooGIIXgNZJRhpxw715B9vp60+YG9n
         ymchmFmZUvqazK9iy3lfP5jEMrU4OH8Nd+3GVLpxPdGxlntvyeIDKVJI2/1O3YqXatkp
         mqrA==
X-Forwarded-Encrypted: i=1; AFNElJ/k0nE/E4rW74aSxzrqux6vaaD3lWq6FvfLQxBhyjz5AIDmVOiSzpM76hET6/dVV1bxCVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb56elKs4PkH+HazoiIALEjPutHNfSfkT91ZP1LGuastfmuRPh
	apzfp3A3Dir4OYKIZ+ry6MXDeZVm3KikTMQ5hvEov+6aE+1jgOZgKjMeB9TATOdG5evCAQvRFpY
	1Zdy7pw==
X-Received: from plbks11.prod.google.com ([2002:a17:903:84b:b0:2bf:bf7:6205])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8d:b0:2bd:2de3:51a4
 with SMTP id d9443c01a7336-2bf3682502dmr7103865ad.27.1780073505343; Fri, 29
 May 2026 09:51:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:13 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-20-seanjc@google.com>
Subject: [PATCH v2 19/20] KVM: Add "extended" gpc CLASS() APIs for
 sometimes-atomic cases
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

Extend the CLASS() APIs for gpcs to allow choosing between the "normal" and
the "try" versions at runtime, depending on whether or not the caller is
running in atomic context.  Convert the "has interrupt" helper as the first
user, as it is called from IRQ context, but also needs to wait when called
from non-atomic context, i.e. can't tolerate false negatives in that case.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c       | 52 +++++++++++++---------------------------
 include/linux/kvm_host.h | 10 ++++++++
 2 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 3ebde7ba5558..a2e88a76e8d9 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -666,7 +666,6 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 {
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
 	bool atomic = in_atomic() || !task_is_running(current);
-	u8 rc = 0;
 
 	/*
 	 * If the global upcall vector (HVMIRQ_callback_vector) is set and
@@ -676,44 +675,25 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 	/* No need for compat handling here */
 	BUILD_BUG_ON(offsetof(struct vcpu_info, evtchn_upcall_pending) !=
 		     offsetof(struct compat_vcpu_info, evtchn_upcall_pending));
-	BUILD_BUG_ON(sizeof(rc) !=
-		     sizeof_field(struct vcpu_info, evtchn_upcall_pending));
-	BUILD_BUG_ON(sizeof(rc) !=
+	BUILD_BUG_ON(sizeof_field(struct vcpu_info, evtchn_upcall_pending) !=
 		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
 
-	if (atomic) {
-		if (!read_trylock(&gpc->lock))
-			return 1;
-	} else {
-		read_lock(&gpc->lock);
-	}
-	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-		read_unlock(&gpc->lock);
+	/*
+	 * This function gets called from kvm_vcpu_block() after setting the
+	 * task to TASK_INTERRUPTIBLE, to see if it needs to wake immediately
+	 * from a HLT. So we really mustn't sleep. If the page ended up absent
+	 * at that point, just return 1 in order to trigger an immediate wake,
+	 * and we'll end up getting called again from a context where we *can*
+	 * fault in the page and wait for it.
+	 *
+	 * For normal, non-atomic usage, nothing can be done if userspace has
+	 * screwed up the vcpu_info mapping. No interrupts for you.
+	 */
+	CLASS(gpc_map_local_ro_ex, info_map)(gpc, sizeof(struct vcpu_info), atomic);
+	if (IS_ERR(info_map))
+		return atomic ? 1 : 0;
 
-		/*
-		 * This function gets called from kvm_vcpu_block() after setting the
-		 * task to TASK_INTERRUPTIBLE, to see if it needs to wake immediately
-		 * from a HLT. So we really mustn't sleep. If the page ended up absent
-		 * at that point, just return 1 in order to trigger an immediate wake,
-		 * and we'll end up getting called again from a context where we *can*
-		 * fault in the page and wait for it.
-		 */
-		if (atomic)
-			return 1;
-
-		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info))) {
-			/*
-			 * If this failed, userspace has screwed up the
-			 * vcpu_info mapping. No interrupts for you.
-			 */
-			return 0;
-		}
-		read_lock(&gpc->lock);
-	}
-
-	rc = ((struct vcpu_info *)gpc->khva)->evtchn_upcall_pending;
-	read_unlock(&gpc->lock);
-	return rc;
+	return ((struct vcpu_info *)*info_map)->evtchn_upcall_pending;
 }
 
 int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d70fa91cda0c..0602d0ca731c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1573,6 +1573,16 @@ DEFINE_GPC_CLASS(_try,);
 DEFINE_GPC_CLASS(, _ro);
 DEFINE_GPC_CLASS(_try, _ro);
 
+#define DEFINE_GPC_CLASS_EX(ro)							\
+DEFINE_CLASS(gpc_map_local##ro##_ex, void **,					\
+	     if (!IS_ERR(_T)) gpc_map_local_unlock##ro(_T),			\
+	     atomic ? gpc_try_map_local_lock(gpc, len) :			\
+		      gpc_map_local_lock(gpc, len),				\
+	     struct gfn_to_pfn_cache *gpc, unsigned long len, bool atomic)
+
+DEFINE_GPC_CLASS_EX();
+DEFINE_GPC_CLASS_EX(_ro);
+
 void kvm_sigset_activate(struct kvm_vcpu *vcpu);
 void kvm_sigset_deactivate(struct kvm_vcpu *vcpu);
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

