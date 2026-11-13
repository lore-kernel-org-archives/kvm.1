Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588004;
	b=1riRq7uQVo+1jbKxlkRmJTU9zIpGK8yshQCMUoo9q79oVgGBvtHjmHfNr6NFEajXn+7m
	 Z3sv0W/LpxUW33OJACnsu+V9xrkf3EzYGY/NGbKRkPxVsyqVupY3uvjsgVkkA6a3YbkXR
	 jHjCj46x6cgwqEukOALj17JJdJdWUk+IDSGyzND7ErIc7ky9jJtAlvUvRB+ZIzLYhEfoX
	 Wswf4LPn79EP4/qG2+iGV2DjIcVgPCrp7uorczIgUXw3yRyx+k5WHndlnsR3zT+0wk1LB
	 vxsB0Tl2W2/vR+m1LAECQ/BN6E0nPXB8hIg/uB/AKhyjb+fw7dLkBb8nKHqawsQz8fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TuZxlvr1d/lwL17oni3PHFgqYaIIh/QyBPbeAfUOfRQ=;
	b=McbXRmTRg4Wh2xuxXbVbPOW42X3WTImHb2YaMPsq0543AHHoqN+mDmfFsfqwSlQ3n2Ee
	 fBT5ehwYznIu/ohchiTYH/01Sg7/xI3jS4CtLP2ZtMgUresKyAmcENbGTD62CpC/zAOPK
	 RWPL9L/kbGUyeZeAy0PVHjre5YUIFqC+6RnZg56PKf4ex8jYiJsBjv2RD4LjziiaKI0oV
	 EO0jdRPTM5kVZnx+c/A2gkZFo0Y63IpIAUd/mWjat2Mct+yEvI7e/s/ghYX0muMyuqeOt
	 cr0C51qt92aPU1BYuf4s21JVajbgFkuwsmW050KYwPrlOs2EJTLcZmzLQDEHPHodBBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWoFi8DY;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1717606A33A
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1717606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWoFi8DY
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed05b3eaecso8525025ad.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588003; x=1795192803; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TuZxlvr1d/lwL17oni3PHFgqYaIIh/QyBPbeAfUOfRQ=;
        b=CWoFi8DY2WdbKaklbxd2Apgym/0rgCC36RqT3hFpKSdsGy4iCcm0vOC0gYUb29BMTq
         yImS8SSNMdZh80bN6bRDVFkk+S0jXN7lJFnRJ1q3hhbL9m5WzNZ352zjq5N6pgjIPGd5
         xBLjAsRwAM0M+b+Jazd0MTVykR7a5hmeJ5n8TSZj+1QatRhPxGi97rqpl7xYTU7PqiEv
         F7uF5v1ix/T81yb2wBan3vs+ld8iOgX+qKMOS5aKMJLQOzfYvRciTz40TvgQEuX3CZnO
         CT79FF/DrTDJxTTFdx5iYG11bDi84P52tfTvunpQpQdALd0jFOzspm7LLwLXMC/ol7dM
         3IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588003; x=1795192803;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TuZxlvr1d/lwL17oni3PHFgqYaIIh/QyBPbeAfUOfRQ=;
        b=fuAyAa5ThatTVneTjUwFv9Hr+b7/go/EDyuVHUQZ0gHyGMdtrvBwtDXtD+1zaq/YsH
         BpWtWvgL6BuSJJA9n2S88un2qzqEZeotDpCxM9G9WPirYmTcnxxjeZJsuDD+lzTpYC+g
         R4X2z98iy+HdUl/8qAh692FEdKSCsqKOrHavl0pgSPwL82D3qfa3jZyAWSHQzySjJbcx
         qgNYnJ1CvvqSMUw8P44/RtnzKPCDUstniBLTAb/zi/Wzpy5HFpberKpjUR+gHmaNmqTW
         C3txkLcIKE4KHAHZtjsiHa1VYtYa7b3znKYpuDk3hrw1Lw9qpu4KzjJSYuqnWTMpC2r/
         urnQ==
X-Forwarded-Encrypted: i=1; AL+hErGZIHbjth+Fc2GFsXupU9lLZDvT47F1sdWjVGyIaGvpM7oidEr/43pvT3NYFhvi3tuE1a8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8F2A2dnsaPtwEXPYJ3a28DBvYPnT7uBJ63w0o9X+iROs8xyB5g
	PFtblWL5trPdMYT9++cXqGUUdyWy+zj7yJ6TNeMZ9+51AbwC6JuqQEvaHvJbnPgPg423lyUhBsn
	oZ5uUiQ==
X-Received: from plri11.prod.google.com ([2002:a17:903:32cb:b0:2e9:4bf0:5f17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230b:b0:2df:90d4:7847
 with SMTP id d9443c01a7336-2ee0dee40a0mr27467255ad.35.1794588002900; Fri, 13
 Nov 2026 08:40:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Nov 2026 08:40:00 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164000.467175-1-seanjc@google.com>
Subject: [PATCH v3] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Naveen N Rao <naveen@kernel.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexandru Elisei <alexandru.elisei@arm.com>

Don't invalidate gmem-only memslots when responding to MMU notifier
invalidations, as the entire point of gmem-only memslots is so that KVM
doesn't need a VMA to install mappings into KVM's MMU.  Specifically,
page faults are resolved by going straight to guest_memfd, using the gfn
and the associated memslot's gmem.file.  I.e. whether or not userspace
happens to have valid mappings to the same gmem instance is irrelevant,
as are any invalidations for those mappings.

Note!  The exception is KVM's gfn_to_pfn_cache implementation which isn't
yet wired up to pull pfns directly from guest_memfd, i.e. still relies on
userspace mappings/VMAs and thus need to be invalidated, e.g. to ensure KVM
doesn't retain a kernel mapping+pointer to PRIVATE memory.  However, as of
commit da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence
for cache refresh"), GPC invalidation no longer relies on memslot lookups,
because GPCs also support HVA-based mappings.  I.e. KVM *must* be able to
detect and handle relevant MMU notifier invalidations even if there is *no*
memslot whatsoever.

In addition to the obvious performance benefits, avoiding unnecessary and
spurious SPTE zaps and TLB flushes will allow KVM to support features like
ARM's Statistical Profiling Extension (SPE)[1] and x86's Secure AVIC[2],
both of which rely on the pages *never* being unmapped from the stage-2
page tables.

Link: https://lore.kernel.org/all/20260903160623.315525-1-alexandru.elisei@arm.com [1]
Link: https://lore.kernel.org/all/cover.1783490022.git.naveen@kernel.org [2]
Cc: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
[sean: rewrite changelog to capture the new gpc behavior]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v3: v1, but with a different changelog.

v2: https://lore.kernel.org/all/20260714160411.302386-1-alexandru.elisei@arm.com

v1: https://lore.kernel.org/all/20260615155244.183044-1-alexandru.elisei@arm.com

 virt/kvm/kvm_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..599dea22afb8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
 			unsigned long hva_start, hva_end;
 
 			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
+
+			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
+				continue;
+
 			hva_start = max_t(unsigned long, range->start, slot->userspace_addr);
 			hva_end = min_t(unsigned long, range->end,
 					slot->userspace_addr + (slot->npages << PAGE_SHIFT));

base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.56.1.703.gf848ed807c-goog

