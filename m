Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4563F39E2
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473088; cv=none; b=CfyeYfXGXJhkSJw5o8x5wIq+vwT+CdLDQ4MAv83G0914TT7iOIcdik1VBHo0LnG9O2x+uWCjLtxsypss5N+QpmCSrFKbn06QUhe5Zliu79s+NwIcEihFszza4fnSfPE1Bpo8YzkZBiKZ+fAwmlrCXVDpHkeVzUK8JF/UoEdQL6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473088; c=relaxed/simple;
	bh=zvFrns79aj9c24kACaQvFLIPdfxn5F03fJA54sqo/Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDyMs6lmHvjf1gm7fTKYUnOCHe4YjBpTfESJP0VnxoDv7ysVwj+oONTqlSPGSFr7Z8NzFxJwJS5bJNZjT7RX0vFMPHYyq1LbjKXmBZLIzkfTPCE5okwScl8MX5CTElYiPClbKM9BtnBxE6SL9eD7J1sbQY5IVOR/yrSRL1Yqfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INMmKBW9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJ3bbWpN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INMmKBW9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJ3bbWpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NCgXQP8MBrTLQHgZqlchtRiyNKOElomA9/Al3COIg9o=;
	b=INMmKBW9VHqwKTiEoblSgyuJ1ZcWFhgfK60rYwQutD8j6piGMKULRhsly9KzRjRjQthXIx
	QlV0kRXm8S5zyHFa1NP0k/aHmMYJp6WMgeYMM7D+J2njIuezBksz6CGAI0pUO+noh/J6SN
	hP6asPIKwVSn+h4MwedtHzjkTsfpCIQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-pUek22HtMyGEw9TcyCBZWg-1; Fri, 26 Jun 2026 07:24:45 -0400
X-MC-Unique: pUek22HtMyGEw9TcyCBZWg-1
X-Mimecast-MFC-AGG-ID: pUek22HtMyGEw9TcyCBZWg_1782473084
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46f291e7cfcso452611f8f.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473084; x=1783077884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCgXQP8MBrTLQHgZqlchtRiyNKOElomA9/Al3COIg9o=;
        b=BJ3bbWpNPYHNecFDoVDkNZb0oP5cFtbzOzmqq9XpclEYt0DBTRtZ4FavOPgabxqlOH
         kaAMRT/X5CaMT0qhcWzSMULy55prMXMfT/iwY/HsEejY2wq2t971BD5Wnxfor+TaFO0/
         kRjzpJ0Bn0nTudztmeGg3ejqdhCcoY9L17si2kCsfxBKj5kYCcHYOuCehoVwoO00futl
         kmxU8yP1YuK7z/mErbDC0pYKm1XSIjP5ZLr37K6mo949pGGqvAihip2lJEpQUfu7GCkM
         UqPko8TUcma/wLJGghlp4jCza/mqu8XojrQ3082sX4H0OVYlVapHDRGbus1Ur/WuHek+
         ZwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473084; x=1783077884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCgXQP8MBrTLQHgZqlchtRiyNKOElomA9/Al3COIg9o=;
        b=mk7nMKkt73qTuOBbLg9pw/PO+GZ01HFgVY2QrQVuycA5qEr+fPEAJTUL9iTXpFn05a
         hZ2fd1gbORWt6nG2Kgl8IMR2zbpT/888D0EaOytlGgtjIZWTxTUnEmxeKqWHb9zVrJjQ
         2d8nXk0KEv1CzHQlSBDrkbqwPHthhonAjH73RqnRP4+gwEzd2pgr3MWn0g4IBD9l3tEJ
         AbRPBhHc9SEWxGCt2FlhoJYx8nf51t6PP/IBbhAU9QgY+PjRe2v/k28sPz4RGKK8jZOI
         hBfl0vlolDpoIc2xNJRkauOLCuYgaSWuCAFAtQuEqyG8Yx+zrpGgyNmPicaT6qo7z8vW
         4fdw==
X-Forwarded-Encrypted: i=1; AFNElJ/4lUcEMBamRqqIwaxVjWt4iN9SIhaI8NgjPcXlF7Bq8ToG0QF4VAIbqL4qaNNgPyuXFTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlGcC8Z71XX40jc98pVRmAdukFwsqq9izUrGg6Oqvojce03xMA
	gPIz+m8wBdVAdCW3aqZ6aUugRa/xxGeiUP5EfMQXHM9suEEDdvtq2q01J2ebxDL1NYwnZPCGzNl
	Gin6BnFtjGHBhcV9EDVJRDlcDMjky583jbDqDLM+wxx5uX0UPKFMHdQ==
X-Gm-Gg: AfdE7ckVIlXYZOcZRCoQJN+RT+4tk5MWhj+cQ1Z/MwNoX9Tm1RvHrhOPFmrvvwFFgs6
	ZAyeVdVBaXnv6aYRCMu6tdE+nahrG5rCj3WUJAMiLvlx7ZrSr4yFymEaFTcK/30Ye7V+orvdPPH
	A1Zu8YcNdWNVDv57odcRtpOza948/XLkt0F44ZHb2nlZASgNahf7nhI7K+qAfzjPL9C38eJCGzu
	8REZCfpVrFmfZtBJZRnJT/frxOKDJAuJapL+G9Ch0E79lhPK5gZ3xb/c/746t/f7FQ8L/3Iquy2
	nMsDMJvDuJU5T+NhuFhtU/V0Krzhf5VsLjQzNhf4aubwtNvWM0qJ78ccTuVEERkCWs3bgCGcVmX
	JswAIvfxXfaqmE82xcB/gAX30Mu0lK3gJr7+jef5a3pScF2WP56x3/su1QnPDDJ/fgpzei+Hf3+
	uoH+DDGWtZu/taU/oO
X-Received: by 2002:a05:600c:e548:20b0:490:b4e5:ce7e with SMTP id 5b1f17b1804b1-49266883322mr68135715e9.25.1782473083634;
        Fri, 26 Jun 2026 04:24:43 -0700 (PDT)
X-Received: by 2002:a05:600c:e548:20b0:490:b4e5:ce7e with SMTP id 5b1f17b1804b1-49266883322mr68135125e9.25.1782473083155;
        Fri, 26 Jun 2026 04:24:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279bc77sm23041510f8f.32.2026.06.26.04.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:24:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	James Houghton <jthoughton@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Alexander Graf <graf@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Filippo Sironi <sironi@amazon.de>,
	Ivan Orlov <iorlov@amazon.co.uk>
Subject: [PATCH 6.1.y] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:24:37 +0200
Message-ID: <20260626112437.1777775-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit ef057cbf825e03b63f6edf5980f96abf3c53089d upstream.

When recovering hugepages in the shadow MMU, verify that the base gfn of
the shadow page is actually contained within the target memslot, *before*
querying the max mapping level given the shadow page's gfn.  Failure to
pre-check the validity of the gfn can lead to an out-of-bounds access to
the slot's lpage_info (which typically manifests as a host #PF because the
lpage_info is vmalloc'd) if the guest creates a hugepage mapping (in its
PTEs) that extends "below" the bounds of a memslot.

When faulting in memory for a guest, and the size of the guest mapping is
greater than KVM's (current) max mapping, then KVM will create a "direct"
shadow page (direct in that there are no gPTEs to shadow, and so the target
gfn is a direct calculation given the base gfn of the shadow page).  The
hugepage recovery flow looks for such direct shadow pages, as forcing 4KiB
mappings when dirty logging generates the guest > host mapping size case.
When the 4KiB restriction is lifted, then KVM can replace the shadow page
with a hugepage.

But if KVM originally used a smaller mapping than the guest because the
range of memory covered by the guest hugepage exceeds the bounds of a
memslot, then KVM will link a direct shadow page with a gfn that is outside
the bounds of the memslot being used to fault in memory.  The rmap entry
added for the leaf mapping is correct and within bounds, but the gfn of the
leaf SPTE's parent shadow page will be out of bounds.

  BUG: unable to handle page fault for address: ffffc90000806ffc
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 100000067 P4D 100000067 PUD 1002a7067 PMD 10612f067 PTE 0
  Oops: Oops: 0000 [#1] SMP
  CPU: 13 UID: 1000 PID: 757 Comm: mmu_stress_test Not tainted 7.1.0-rc1-48ce1e26eace-x86_pir_to_irr_comments-vm #341 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:kvm_mmu_max_mapping_level+0x79/0x2b0 [kvm]
  Call Trace:
   <TASK>
   kvm_mmu_recover_huge_pages+0x21b/0x320 [kvm]
   kvm_set_memslot+0x1ee/0x590 [kvm]
   kvm_set_memory_region.part.0+0x3a1/0x4d0 [kvm]
   kvm_vm_ioctl+0x9bf/0x15d0 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb7/0xbb0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f21c0f1a9bf
   </TASK>

Don't bother pre-checking the bounds of the potential hugepage, i.e. don't
check that e.g. sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level + 1) is also
within the memslot, as the checks performed by kvm_mmu_max_mapping_level()
are a superset of the basic bounds checks.  I.e. pre-checking the full
range would be a dubious micro-optimization.

Fixes: 9eba50f8d7fc ("KVM: x86/mmu: Consult max mapping level when zapping collapsible SPTEs")
Cc: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Alexander Bulekov <bkov@amazon.com>
Cc: Fred Griffoul <fgriffo@amazon.co.uk>
Cc: Alexander Graf <graf@amazon.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Filippo Sironi <sironi@amazon.de>
Cc: Ivan Orlov <iorlov@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 18 ++++++++++++------
 include/linux/kvm_host.h |  7 ++++++-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a67d013fff4d..aab26f90c285 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6952,13 +6952,19 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		sp = sptep_to_sp(sptep);
 
 		/*
-		 * We cannot do huge page mapping for indirect shadow pages,
-		 * which are found on the last rmap (level = 1) when not using
-		 * tdp; such shadow pages are synced with the page table in
-		 * the guest, and the guest page table is using 4K page size
-		 * mapping if the indirect sp has level = 1.
+		 * Direct shadow page can be replaced by a hugepage if the host
+		 * mapping level allows it and the memslot maps all of the host
+		 * hugepage.  Note!  If the memslot maps only part of the
+		 * hugepage, sp->gfn may be below slot->base_gfn, and querying
+		 * the max mapping level would cause an out-of-bounds lpage_info
+		 * access.  So the gfn bounds check *must* be done first.
+		 *
+		 * Indirect shadow pages are created when the guest page tables
+		 * are using 4K pages.  Since the host mapping is always
+		 * constrained by the page size in the guest, indirect shadow
+		 * pages are never collapsible.
 		 */
-		if (sp->role.direct &&
+		if (sp->role.direct && is_gfn_in_memslot(slot, sp->gfn) &&
 		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
 							       PG_LEVEL_NUM)) {
 			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 04b81e2166d5..b4235e99f0a9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1745,6 +1745,11 @@ int kvm_request_irq_source_id(struct kvm *kvm);
 void kvm_free_irq_source_id(struct kvm *kvm, int irq_source_id);
 bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
 
+static inline bool is_gfn_in_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return gfn >= slot->base_gfn && gfn < slot->base_gfn + slot->npages;
+}
+
 /*
  * Returns a pointer to the memslot if it contains gfn.
  * Otherwise returns NULL.
@@ -1755,7 +1760,7 @@ try_get_memslot(struct kvm_memory_slot *slot, gfn_t gfn)
 	if (!slot)
 		return NULL;
 
-	if (gfn >= slot->base_gfn && gfn < slot->base_gfn + slot->npages)
+	if (is_gfn_in_memslot(slot, gfn))
 		return slot;
 	else
 		return NULL;
-- 
2.54.0

