Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF5416D04
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681592; cv=none; b=BTdgQ+1IZ8KnyoTDiPHlqjbdFkLj+P7BhlncoLwnsNIQTRM2d9PkpOEtVuh/W2WM378UqdtrkkRQuOMNwz7NoDgyryDebbK/hlLvBQ3cCRt0KLrTd4uqq4iIcOAf8hIoarxtRZXXRY6IepnGJXlU/HFNeS1zBh+v7BPfPNGLsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681592; c=relaxed/simple;
	bh=8zuQHH+SQ3YapRGKVrkDRoM6/szKXPSMm+qil33kwII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C3fq1IazdfaC8Y7geXFz9dDxswwSMRp0zMYdTHp4flgkjOCXHpplObbEw0m8oR1LaG7VU7JbY56zCJlnbba+mpXT8bLcz9Ywvo4pEcupQx5dTE+M0L6aqeXgp/UPBFgI9LhoDKHdl4e2dApXAkc0F2Kz/bQZ+1XBSRzFszjEsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RapmEAdr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RapmEAdr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf243973c2so15654735ad.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780681575; x=1781286375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uZPieUENRjAFBSsrN9Q0ajHABgZwgeB6IKaETF6cS9M=;
        b=RapmEAdr+hUtIVKbX5ri1sttvlEHEt8/QluNoIxE3yCCZVgsfNX9MRy/5BY/ozj6Si
         Od/EhrQ0ciiUhg5ZdFQRxHvALXXmqhyDfcCJOxQQhLjkV/jfRNW2osvRX8ZIcbEiWAOI
         4nLwxqFINLwpCKQ/X6za2NUkymBMWMBw9E6VPFp9fG2NC5rsEMZKpXNJy7cdHzZWmMEE
         odera3pSb6OVWPZyEUz2dOx+oZ0u9fGRxfIRCe5cYUwbGTSgk6WQ9oBNWoptu6IAMNGV
         7rgDCkxBrc/La9y22lZMzWCixcfHlU2Hzp17ElZtaORA981dwcilCT/WHj2O4Y7Dtvdh
         KAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681575; x=1781286375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZPieUENRjAFBSsrN9Q0ajHABgZwgeB6IKaETF6cS9M=;
        b=A0jJU8gdyLiZVueuFv0qOblMXA6EQ9EFADchAKRmjuzwQwCHAPr+6FPCOfUDjyY8m6
         N15rSZ8eUzgucPMRa/ZpS5kzdingWhZtOkPHxsLKg3rbMEGadam/HkBcn4GPJMgmWvTC
         cnLq6dolhWB4RcZjvnI/gWGNBEXRLT5rlRMAAdhWgob5MKd2XoIwHFyFr7oBJfU4fRA6
         3wJHqH4dvZQK+1kxfwkYqLaHgo47E8lrEKGn7eo0YkEwObJK1ipu9N1b27dcr6e/kpLm
         7q1aiDN9Ium2hVY/dwR9Bsq3V0xom1pgr3zQFt3Qt0xDYLeK1hurEvWBAUh9jJ7NlC0B
         JCGA==
X-Gm-Message-State: AOJu0YwesMWchzlPzKUF0HMhWdVA73Qb59fqPCx/eJgURCbOI4VDJL75
	Dcmo2VhwiAfuMVLqEstDujEW65TZpDHojB8oU4T1KTXCrw/CVseaf71CqYvtEDQaJeK9+LnBmHG
	l+ros0w==
X-Received: from plcx3.prod.google.com ([2002:a17:903:c3:b0:2b4:6553:4533])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2d0:b0:2c0:bcff:e18c
 with SMTP id d9443c01a7336-2c1e833c99dmr52147205ad.37.1780681574693; Fri, 05
 Jun 2026 10:46:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Jun 2026 10:46:10 -0700
In-Reply-To: <20260605174611.2222504-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605174611.2222504-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605174611.2222504-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86/mmu: Recursively zap orphaned nested TDP shadow
 pages on emulated writes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Recursively zap orphaned nested TDP shadow pages when emulating a guest
write to a shadowed page table, regardless of whether or not the associated
(parent) shadow page will be zapped, e.g. due to detected write-flooding.

This plugs a hole where KVM fails to reclaim defunct, unsync shadow pages
for select L1 hypervisor patterns.  Commit 2de4085cccea ("KVM: x86/MMU:
Recursively zap nested TDP SPs when zapping last/only parent") modified KVM
to recursively zap synchronized shadow pages (KVM already recursively zaps
unsync children) when a child is orphaned.  But the fix effectively only
applied the logic to kvm_mmu_page_unlink_children(), i.e. only performs the
recursive zap when KVM is already zapping a parent SP and processing its
children.

If L1 zaps SPTEs bottom-up (4KiB => 2MiB => ...), as KVM's TDP MMU does
with CONFIG_KVM_PROVE_MMU=n since commit 8ca983631f3c ("KVM: x86/mmu: Zap
invalidated TDP MMU roots at 4KiB granularity"), then KVM (as L0) will leak
upwards of 4 shadow pages per GiB of L2 guest memory.  Over hundreds or
thousands of L2 boots, if the VM is "lucky" enough to escape write-flooding
detection, i.e. not trigger reclaim of the orphaned shadow pages by dumb
luck, then it's possible to end up with tens or even hundreds of thousands
of unsync shadow pages and associated rmap entries.

Polluting the hash table and rmap entries with a horde of stale entries
can eventually degrade L2 guest boot time by an order of magnitude,
especially if there is any antagonistic activity in the host, i.e. anything
that will contend for mmu_lock and/or needs to walk rmaps.

With "top"-down zapping, where "top" is 1GiB or above, then L0 KVM is
effectively limited to leaking 4 shadow pages per 256 GiB of memory, as
KVM's write flooding detection will kick in on the third write to an L1
TDP PUD, and thus recursively zap the entire 256 GiB range of the parent
PGD.  I.e. even though L1 KVM still recursively zaps 2MiB => 4KiB SPTEs
when zapping each 1GiB SPTE, KVM only gets through two of the 1GiB SPTEs
before dropping everything.  E.g. hacking tracing into L0 KVM's
kvm_mmu_track_write(), the top-down zapping of L1's TDP MMU for an L2 with
16GiB of memory leads to:

  gpa = 107407000, old = 800000010741bd07, new = 8000000000000000, level = 3, flood = 0
  gpa = 10741b000, old = 8000000112fb2d07, new = 80000000000001a0, level = 2, flood = 0
  gpa = 10741b008, old = 800000012509cd07, new = 80000000000001a0, level = 2, flood = 1
  gpa = 10741b010, old = 80000001114b9d07, new = 80000000000001a0, level = 2, flood = 2
  gpa = 107407008, old = 8000000112fb5d07, new = 8000000000000000, level = 3, flood = 1
  gpa = 112fb5298, old = 8000000106f43d07, new = 80000000000001a0, level = 2, flood = 0
  gpa = 112fb52a0, old = 8000000106f4dd07, new = 80000000000001a0, level = 2, flood = 1
  gpa = 112fb5ea0, old = 8000000120490d07, new = 80000000000001a0, level = 2, flood = 2
  gpa = 107407010, old = 8000000106df2d07, new = 8000000000000000, level = 3, flood = 2
  gpa = 107410000, old = 8000000107408d07, new = 8000000000000000, level = 5, flood = 0
  gpa = 107408000, old = 8000000107407d07, new = 80000000000001a0, level = 4, flood = 0

Contrast that with a bottom-up zap, which effectively allows all 2MiB SPTEs
in L1 to leak their children.

  gpa = 167939000, old = 800000011c8f4d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 167939020, old = 8000000104407d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 167939028, old = 800000011ed20d07, new = 8000000000000000, level = 2, flood = 2
  gpa = 118c70bb0, old = 8000000167ab9d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 118c70bb8, old = 8000000163913d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 118c70de8, old = 800000011cc9dd07, new = 8000000000000000, level = 2, flood = 2
  gpa = 160be7fb0, old = 800000011d322d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 160be7fb8, old = 8000000126b1bd07, new = 8000000000000000, level = 2, flood = 2
  gpa = 1634ab000, old = 800000010e984d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 1634ab008, old = 800000016879fd07, new = 8000000000000000, level = 2, flood = 1
  gpa = 1634ab010, old = 800000016879ed07, new = 8000000000000000, level = 2, flood = 2
  gpa = 11e3f1e48, old = 8000000168a33d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 11e3f1e50, old = 80000001664dcd07, new = 8000000000000000, level = 2, flood = 1
  gpa = 1167eacb8, old = 8000000166544d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 1167eacc0, old = 800000015c16bd07, new = 8000000000000000, level = 2, flood = 1
  gpa = 1689e89b8, old = 800000015f296d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 1689e89c0, old = 8000000167ca8d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 107b35eb8, old = 8000000161e71d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 107b35ec0, old = 8000000118cf3d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 118cf2d48, old = 8000000118cf1d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 118cf2d50, old = 8000000118cf0d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 118dcb770, old = 8000000118dcad07, new = 8000000000000000, level = 2, flood = 0
  gpa = 118dcb778, old = 8000000118dc9d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 118dc87e8, old = 8000000126997d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 118dc87f0, old = 8000000126996d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 126995148, old = 8000000126994d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 126995150, old = 8000000103477d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 1034764c8, old = 8000000103475d07, new = 8000000000000000, level = 2, flood = 0
  gpa = 1034764d0, old = 8000000103474d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 10ea4b788, old = 800000010ea4ad07, new = 8000000000000000, level = 2, flood = 0
  gpa = 10ea4b790, old = 800000010ea49d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 10ea48928, old = 800000011a5bfd07, new = 8000000000000000, level = 2, flood = 0
  gpa = 10ea48930, old = 800000011a5bed07, new = 8000000000000000, level = 2, flood = 1
  gpa = 11a5bd0d8, old = 800000011a5bcd07, new = 8000000000000000, level = 2, flood = 0
  gpa = 11a5bd0e0, old = 800000011d323d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 122ce2b40, old = 800000011fe0bd07, new = 8000000000000000, level = 2, flood = 0
  gpa = 122ce2b48, old = 800000010e985d07, new = 8000000000000000, level = 2, flood = 1
  gpa = 122ce2b50, old = 8000000161c9dd07, new = 8000000000000000, level = 2, flood = 2
  gpa = 16864c000, old = 8000000167939d07, new = 8000000000000000, level = 3, flood = 0
  gpa = 16864c008, old = 8000000118c70d07, new = 8000000000000000, level = 3, flood = 1
  gpa = 16864c010, old = 80000001688a6d07, new = 8000000000000000, level = 3, flood = 2
  gpa = 11c8f7000, old = 80000001608a7d07, new = 8000000000000000, level = 5, flood = 0
  gpa = 1608a7000, old = 800000016864cd07, new = 80000000000001a0, level = 4, flood = 0

Note, in the shadow MMU, "level" describes the level a shadow page "points"
at, not the level of its associated SPTE. I.e.  when write-flooding of 1GiB
PUD entries is detected, KVM recursively zaps shadow pages covering 256GiB
worth of memory.  And as shown above, KVM's write-flooding detection
operates at all levels, so a single PMD (in L1) can effectively only leak
two unsync children (4KiB shadow pages) before it gets recursively zapped.
As a result, for the top-down zap, L0 KVM will leak at most 4 unsync shadow
pages per 256GiB of L2 memory.

The top-down zap also makes it more likely that L1 will self-heal (to some
extent), as any shadow pages that are "rediscovered" by future runs of L2
can get reclaimed by a recursive zap, whereas bottom-up zapping orphans
shadow pages over and over.

Note, in theory, there is some risk of over-zapping, e.g. due to zapping a
a large branch of the paging tree that L1 is only temporarily removing.  In
practice, the usage patterns of hypervisors are highly unlikely to trigger
false positives.  E.g. temporarily changing paging protections is typically
done at the leaf, not on a non-leaf entry.  And if the L1 hypervisor is
updating large swaths of PTEs, e.g. to (temporarily?) remove chunks of
memory from L2, then L0 KVM's write-flooding detection will kick in, and
the children would be zapped anyways.

Fixes: 2de4085cccea ("KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only parent")
Cc: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Cc: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b8f2edf2cfeb..9368a71336fe 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6376,7 +6376,7 @@ void kvm_mmu_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 
 		while (npte--) {
 			entry = *spte;
-			mmu_page_zap_pte(vcpu->kvm, sp, spte, NULL);
+			mmu_page_zap_pte(vcpu->kvm, sp, spte, &invalid_list);
 			if (gentry && sp->role.level != PG_LEVEL_4K)
 				++vcpu->kvm->stat.mmu_pde_zapped;
 			if (is_shadow_present_pte(entry))
-- 
2.54.0.1032.g2f8565e1d1-goog

