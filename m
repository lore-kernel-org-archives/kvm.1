Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635733;
	b=LhwhDYzmGI6FKhHJTaegCReKtuVXpYKoe2MJuseqJ/ssxCNOwSYTx0SMKgO0iztgyqFd
	 clPmKlpt1ESfkRI3lVWksKWc/ZjJfqQY2/iw7cIPPaPWUawt88cVVoQU2KRw+XvgdvPKk
	 HzlAdtCQWT9ICQLldQVq2a79WWzalqEMtsf0uiwjSteyTvghuI9qUsYDST1OOj3AkUUhm
	 30vPplcPFgOECJ/ryCXsWQ1oQLEQ/aLX9znNh8vUvwMabPVudDNFjpx2kOQGvvK4GSWmC
	 DeM4yn1Pk6YNsH40NLjRBDDHaKnOEfvIXb79xGYn11XyGoEu4ibKq3Rljqn51pOgk+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DBN7G3ke//fK5LgEVkVD2hWk0C91Efg59xeDWJWdH2g=;
	b=AxAe7rxk0kYAAeKZ4Z+3kdjamasNjRNrcNHqyYVyoq5ScARkiniYgaH9CA8vWN9+BcAz
	 ctLFP6WZgsTuzrkThONSdbiznKCo0HEhUIdzH/NQ5aoRbYm5IGBg8eqv9TJjdabYE3AJf
	 nWpIxjWKFiWoyjbgrKKoVieoqBji3megkZmgI4YWg0f2QgSlmx74uPbJWDD8RAU7pZF91
	 R1JZcojo7EjDurPxliLermX9z17pEQe4V/rLfL3LY9rvMWn+5T8hMeA2ySL4KnktD7qiU
	 s11+8fDx2L+uObP1ZC95QI2/FO5eFLuGu54IUuDrlmG6KwDQ9C7oKn/Go6Y1SFIr8Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VdZRYFr9;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CE606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875CE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VdZRYFr9
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so3588167a91.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792635732; x=1793240532; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DBN7G3ke//fK5LgEVkVD2hWk0C91Efg59xeDWJWdH2g=;
        b=VdZRYFr9MhiM6Os8Xus6euGZIniSOc74tpAN5iDcStpKM+lcfqBNa2gQI8n8fYC63r
         CPhg5CSlfsD89zjlBk+oa2kYHokKSsS0OVsXaFP1p4mEpLckMU2i9KrJ4nLlHXlFnNEK
         BlILv77Vl2CobLl5zLa64/I6O96F+BFczcVaXnsulvT9qzo9XdUyt+2TunAEFWvfP61L
         Y1kK7w7I6fp/FSZWN1TBYTaoTYYj7pCpWpzA2gNH/BPHRHQ/h71ILG2Cza1H8TxsGD07
         K8lH5KepMYcYb/4QHpOVSAbzptcJ6dnKiQD9oXxRhWCWKqKVBGSHf5V1pVC/RcfzcwtJ
         tolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635732; x=1793240532;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DBN7G3ke//fK5LgEVkVD2hWk0C91Efg59xeDWJWdH2g=;
        b=HwR2pItTVOzM5cLTUkS7lmCbPyn+xEnbg3Q/VMn865saLwS4URrh10lvSGIoQi0y4Q
         IUl7h318mQCO0MCFycq6IWgimf/3VQ8vtBlOqKMLtNpI3rrGukUECZ6OPhUwiL0NJYue
         iquX/QNEvaPXIUYndBOgdK26+hwJutlYSF//TPWhOIxHspmP/rBySHiFgZVv0sCSOKzK
         aGGa5uZezA3HDT95nOGDqojMMmZOIf+0+m4GdjlNwXaD9M50Ye3JcUIiGxNZjGmUdGhW
         aSMpxBAOiY0h7+fGcjRm37uWMdOMWH7zk+oZze+5zjheo2GqQzUYvDJzPJBSaX0qe4Kd
         mi2g==
X-Gm-Message-State: AFq9FYKmv5f78PWakw4E4JXBS1I9noFIu+x3d0kBnqvCuPG2YVqUhJrw
	t8iwzeK4KXfw27FVREvFaThKEOKjjTEL9QooYAzjUcBlFb7RM7ryBh/Au1JOiAWXrxuM2YyO/Pq
	R327suA==
X-Received: from pjbrm9.prod.google.com ([2002:a17:90b:3ec9:b0:3a7:e2d8:4f4c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50cb:b0:3ac:da41:ef7e
 with SMTP id 98e67ed59e1d1-3ad86f650acmr3239423a91.52.1792635731679; Wed, 21
 Oct 2026 19:22:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:22:09 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022022209.300964-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/mmu: WARN and flush TLBs if TDP MMU replaces present
 SPTE with MMIO SPTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

If KVM is buggy and manages to replace a shadow-present SPTE with an MMIO
SPTE in the TDP MMU, WARN but emit a TLB flush to prevent a potential use-
after-free.  It should be impossible for KVM to resolve a GFN to a memslot
and then later find no memslot, but due to flaws in KVM's handling of GFNs
that can be generated by the guest[*], KVM can/wrap truncate GFNs when
walking SPTEs and resolve two different GFNs to the same SPTE.

Note, this is NOT a fix for the GFN truncation issues, it is purely a
stopgap that also happens to be valuable long-term hardening.

Link: https://lore.kernel.org/all/20260219002241.2908563-1-seanjc@google.com [*]
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 44dad106fad1..2735cbb21293 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1151,6 +1151,7 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 		return RET_PF_RETRY;
 	else if (is_shadow_present_pte(iter->old_spte) &&
 		 (!is_last_spte(iter->old_spte, iter->level) ||
+		  WARN_ON_ONCE(!is_shadow_present_pte(new_spte)) ||
 		  WARN_ON_ONCE(leaf_spte_change_needs_tlb_flush(iter->old_spte, new_spte))))
 		kvm_flush_remote_tlbs_gfn(vcpu->kvm, iter->gfn, iter->level);
 

base-commit: 814607cd40df80d5727957adaa857e0feca43497
-- 
2.56.0.218.g1ec904b173-goog

