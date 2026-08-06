Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF24CA291
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043991; cv=none; b=QbpY0YIRDzZS+/NF+BvBcOKRAvukk0Be5ALC7DyQjxBJt6YWlYcQUw9PZTDb14NK5Rqh16DltAb9Y0puQw5XyQHRLdbkfAh22jZkx8Cn+AvTPJ8o6U25gfngHrW1oj5lBJliuOL9Ih9tNVY5kIDWAz1Nt+KFZhB7RbCPrmT4U8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043991; c=relaxed/simple;
	bh=cYtQg2vj/ZSHq3uIkkBxbWvJhN8tLiaKh7/diaKbv2c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Id21DC2szWMiAKrLGWd2ljsJ6xcAB8EfKH8edisyfLjOrCNBuU7Mhty0nM/3sWUrvH6N5UOXgQwArAWH0wcw3v5EjYkU9Lbkak8mj5js9tTZiLb+pyJATTIT4b2We2+yRrhyNKNlUfijPk/hblQtUE11ZJomsqOxrrWURKwtn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nu5DVgnr; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nu5DVgnr"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8486ffba174so5678374b3a.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786043987; x=1786648787; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7w0Q8W/kNI7T8UNYVfIFE+WLMuLMMSdtgl2pAuiQ8s=;
        b=Nu5DVgnrOnyLw1p3r8P/99RlbIZL8kPUPKjpmwUeBzGD7VOsCAMLAO6MybgbuikIU4
         nYHHw5CwppylnAwZwxBSUmFk5eibJmA8Ye/w7gqNz4NA8SCEgClnjYvJFKYSLGsiIA5h
         n2PvOmz1lW5iBs7QDDTsjm6zOabdHbEUQ8dJOOCqGHygb3aBMpBny3F4F1zLTf+6VB0X
         RmjAYi2IXzXhcIF2/b+edGrlh7i/oWJBNM/dgukn/n2y3/vpSEb5hSfs4arI6nE7pyZV
         MIxk3ETtktgqzc2DTXXSapoEA27Ljh3mG8VUpN0d2BaUhbT0J6cWrmEIE+N9YoJ67Q4N
         iavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043987; x=1786648787;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r7w0Q8W/kNI7T8UNYVfIFE+WLMuLMMSdtgl2pAuiQ8s=;
        b=g850UsSAN8qGSvzYENQVfd3O95BSpVeY9yy+GOTwg164MLCdT/HFOoOz5N+3HNWx+k
         3FABAc6PKctckY+uArC86mAP+5ogofrWx3a+sVHp0VAOOYjiwBbOCnX0rTlljyn/VOO2
         Dg1BLylAarP4mTKRaH81Wz32gU3fVH0Ah77HO+CrJW3yt8oI8cxlwHbnWWXMpSDTFNpf
         EuGNiH8SNQepw/OosEasNSHvm7Rao3+KyJ3wz6VlSzRocG7jrz9ENDaaPycpE8mDF/0n
         36GMgCc1UKBYwEnM+MgD601m1ef7nkuPExjEebedQtPfC36UutrARZVS+q7ijaU9X+A/
         xCtg==
X-Gm-Message-State: AOJu0YyYmc6yu4zI6IqVER0Tl3h8aUH0lnDnFqp9lGi6Nse4dj1uWAGk
	XyuDFe35H6v8W72YtNhMsz2Vd58500bGHcjBEnVWj28hOY71A/nGn63OPUhHacc08ay9hweijlj
	AD9+SZg==
X-Received: from pfks7.prod.google.com ([2002:a05:6a00:1947:b0:84e:2400:dc7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e8b:b0:845:363e:12d9
 with SMTP id d2e1a72fcca58-84f2dfc8f0dmr20048498b3a.3.1786043986994; Thu, 06
 Aug 2026 12:19:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 12:19:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806191945.4192732-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/mmu: Bug the VM if KVM attempts to unsync an
 upper-level shadow page
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinu Kim <kimjw04271234@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Bug the VM and skip marking a shadow page unsync if KVM attempts to unsync
an upper-level shadow page, as marking an upper-level SP unsync is all but
guaranteed to be far worse than terminating the VM.  E.g. sync_spte()
(rightly) assumes SPTEs in the SP are leaf SPTEs and so calls drop_spte()
instead of drop_parent_pte(), which can effectively crash the host via
when running with CONFIG_BUG_ON_DATA_CORRUPTION=y due to there not being an
rmap entry for the SPTE.

Simply not marking the SP unsync, i.e. letting the VM continue on, is
equally dangerous for the guest as it means KVM's shadow MMU is using stale
information, e.g. could unintentionally corrupt the guest.

Cc: Jinu Kim <kimjw04271234@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6c13da942bfc..d9ad158ff7a2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2990,6 +2990,9 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
 		if (prefetch)
 			return -EEXIST;
 
+		if (KVM_BUG_ON(sp->role.level != PG_LEVEL_4K, kvm))
+			continue;
+
 		/*
 		 * TDP MMU page faults require an additional spinlock as they
 		 * run with mmu_lock held for read, not write, and the unsync
@@ -3013,7 +3016,6 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
 				continue;
 		}
 
-		WARN_ON_ONCE(sp->role.level != PG_LEVEL_4K);
 		kvm_unsync_page(kvm, sp);
 	}
 	if (locked)

base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.679.g6767b8d81c-goog

