Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950956;
	b=GO1gc2H2hphITeKmHL1BXvMKUQzUQQsInN8Hkwtwx322QJB0u+dc15VY16X8WoWs4ij+
	 8IRO+zU9rNq9aaXlmFfbFlYEv7IekFVcZ4nhl85LHb2RjKNW6Hr55MQjhEG8VMIdIO0v5
	 uREGuo3Af+UkbmGAe0WtR4grxR962+SGVfxxNfl1pKABLVi4jntACEAjNF+x4PeE9bLww
	 AIU5Nwq6Dm/DIDjYIYdTOKx4gA5iUzKO1FTfNz6LWA7iSbBq1E8QfGQiVLRQU3e93daog
	 6jPaNJ76zeapQ5/OrovO6MskWd9pWbsXLLarcUkWIGJW3/6VExuqwtqxA7xrEivKhXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5o4gzYP7Htxltuh2Ck0AAlKZq7is+of4oLM8E9yqYUA=;
	b=cP5Uo3WPli1fMYLzNvmizuYZBQ9sLvtL6iFjdIb8k0LKE4X43dQ8J3C/sEIJl+saoari
	 34tCPtWKkSbhSoxxksHcH9414ZjG+mM+RXm+vuvI5y0BERFT+u4/6MaDEFngQWwNusC1k
	 FxLABAVTnJFayfbbzIV30ye+bt499vs8oV8D2mUbQf2l1mk7D8cuJVoH5y473+X00sivq
	 6BygdcOsyWfN9yaaL74xDF5quCvtaprcpvFRHwrinqEfxW9mHjNuxBzlJMisy7EIvS+NS
	 +8bN3Lxis+8GZS6pv/Q4SrS746vH++0mb4/NiYyY3Bz9nwnr6po20Lx344gCyYe/zrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=apdQ1grJ;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECD606A333
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4ECD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=apdQ1grJ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2efdd509c6bso2870385ad.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794950955; x=1795555755; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5o4gzYP7Htxltuh2Ck0AAlKZq7is+of4oLM8E9yqYUA=;
        b=apdQ1grJAgineRYnft5rPGF8AzU89tO644+5yfKsxNC/tt2KEQWDLrKOhxfp6uQZiu
         yFQslZxGOu0tSMt5xHZfkPgZ67n5BQJv+l8BBEwePTAFAgY+m2Z+zTNfG4jBX7FefbiS
         kV90Ube6ub0llFi2nljcuXzN+83yGW6xa2zODjkfOONSrebaRpPyqYDsb6xTeiPpdWdi
         vKxAQ6H5N5R7EAN/ubLEO10da/6fMWPA8I4w0SEdqa5I0t23Ms7d984pMQXoE6fKCf3t
         kM9swiDprQe3P7NmaoHb5/dbgFv9fb2AbSIyb8I5eIfkZwqI+tjoNuAcIFeE9nayLYx5
         VmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950955; x=1795555755;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5o4gzYP7Htxltuh2Ck0AAlKZq7is+of4oLM8E9yqYUA=;
        b=HP1bKM2IaHToKM4Sjn86z95DqFtsTVq5ptg8hCLzuCYKyE80mQieIMDEnuzpjMHWRy
         NkzwOcrBT2qunyjLz2oZQTYDz0ZU+PoYsVJP0hYS+ix9vLA97bg6YWNkU935jAbgJmpP
         TjDHcMaUq/n6kGLCZJhHxZy2J5LzjHD4BitTdb2eAsXqhVMC7gKex9w5OqXhc638BHS3
         Ier4RvIjo6Xmp4oU1fSjF9mnqq4jSwtBE+2u5JnklHz7z2sjB3YWeDWyXI4ALH+R6MTQ
         juwRh/JS4UMwH6JanepDaFqAEBYLuP8jHlFjzbWXLlmfYyyBfBH7hy1PfUUJqnlxVJxv
         /VKA==
X-Forwarded-Encrypted: i=1; AL+hErEydELq4yQv6itaf5Cdiok9P4oX0Lf7Xjq3lorQnoCK42IMfW4ClpqXREfDeqEm/Lgu3fo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uzYy0of4sUdupQrOJDDiymmh9dKSR4qOHm5cRb9+sk1+wEEg0
	BNN9C+yffpawDf5RCY6NsjZ8Md02baCQbZgcZ95NYc5g8TUS1Y5noV788BYQy0rNeBW1ZcLS7hN
	e3R+/X8GJzTm8KUgokkKjXw==
X-Received: from pjbkl3.prod.google.com ([2002:a17:90b:4983:b0:3ab:1bc3:c7e6])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1dcd:b0:3ab:884b:65b7 with SMTP id 98e67ed59e1d1-3b3d0761a50mr608552a91.25.1794950954855;
 Tue, 17 Nov 2026 13:29:14 -0800 (PST)
Date: Tue, 17 Nov 2026 21:29:10 +0000
In-Reply-To: <20261117212913.3634487-1-jthoughton@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117212913.3634487-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261117212913.3634487-2-jthoughton@google.com>
Subject: [PATCH 1/4] KVM: Don't reset dirty ring entries that KVM hasn't pushed
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

When resetting a vCPU's dirty ring, stop if reset_index has caught up to
dirty_index instead of relying solely on the RESET flag of the next
entry. The ring is mapped writable into userspace, so userspace can set
KVM_DIRTY_GFN_F_RESET on entries that KVM never pushed, in which case
KVM advances reset_index past dirty_index. The u32 math in
kvm_dirty_ring_used() then underflows, and the next push hits the
WARN_ON_ONCE() in kvm_dirty_ring_push():

  WARNING: virt/kvm/dirty_ring.c:225 at kvm_dirty_ring_push+0x2b2/0x5e0
  Call Trace:
   make_spte+0x71a/0xc80
   kvm_tdp_mmu_map+0x140e/0x1f40
   kvm_tdp_page_fault+0x2f7/0x3a0
   kvm_mmu_page_fault+0x1f8/0xc00
   vcpu_run+0x4da1/0x7890
   kvm_arch_vcpu_ioctl_run+0xe83/0x18b0
   kvm_vcpu_ioctl+0xa61/0xfd0

Userspace that scribbles on its own dirty ring gets to keep the pieces,
but KVM shouldn't WARN, and keeping reset_index from passing dirty_index
is trivial.

To avoid skipping entries that were legitimately harvested while the
vCPU is running, bump dirty_index before publishing the DIRTY flag in
kvm_dirty_ring_push(), and check dirty_index after the load-acquire of
the RESET flag in kvm_dirty_ring_reset(). If KVM observes the RESET
flag for an entry, i.e. userspace observed the DIRTY flag, then KVM is
guaranteed to also observe the updated dirty_index.

Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking")
Reported-by: syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6afbad4d.f3cfa7c9.844a4.0002.GAE@google.com
Cc: stable@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 virt/kvm/dirty_ring.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 572b854edf74..8fab75dace76 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -140,6 +140,16 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
 		if (!kvm_dirty_gfn_harvested(entry))
 			break;
 
+		/*
+		 * Don't reset entries that KVM hasn't pushed, e.g. if userspace
+		 * set the RESET flag on an unused entry. Check the number of
+		 * used entries after checking the flag, so that dirty_index is
+		 * up-to-date for entries that were harvested (pairs with the
+		 * ordering in kvm_dirty_ring_push()).
+		 */
+		if (!kvm_dirty_ring_used(ring))
+			break;
+
 		next_slot = READ_ONCE(entry->slot);
 		next_offset = READ_ONCE(entry->offset);
 
@@ -229,12 +239,14 @@ void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 slot, u64 offset)
 	entry->slot = slot;
 	entry->offset = offset;
 	/*
-	 * Make sure the data is filled in before we publish this to
-	 * the userspace program.  There's no paired kernel-side reader.
+	 * Bump dirty_index before publishing the entry, so that
+	 * kvm_dirty_ring_reset() sees the new dirty_index if it sees the entry
+	 * as harvested, and make sure the data is filled in before publishing
+	 * the entry to userspace.
 	 */
+	WRITE_ONCE(ring->dirty_index, ring->dirty_index + 1);
 	smp_wmb();
 	kvm_dirty_gfn_set_dirtied(entry);
-	ring->dirty_index++;
 	trace_kvm_dirty_ring_push(ring, slot, offset);
 
 	if (kvm_dirty_ring_soft_full(ring))

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.56.1.708.g77570a6a1d-goog

