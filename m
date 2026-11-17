Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878118;
	b=OK7hPFDHmNTN6uBRKk6JKdFMcISp0sfemtk8otvY1mMxGoQrPEpXkxGc5J/20BOMwwYb
	 T2WgbfXvGt1QoigS/oHbWKKw1iIC3Le02eRP7KvMnQu+EwKU9ys2rsusqwu2bO6/65usB
	 UZXmQeOHrT39B8eUPRQ5nq6Xg9PlzoACiybBPTbliJqGROtFS1bMkfGoraqLOVQn3kn+L
	 td78Tdc+lT7z5C1qsWnZDw09Y0rQ8Wp77hlPwZtmY1+pgPLjCg5jseko9vmyYQNjTYskr
	 0/jWg2yG6OP+XTL2sA+voJv7COn3EYelcWu7ZsU8RBZM6hN+qc+QT066mIIj2CIP7Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=M3B5P4sZFtbCUwrSNj8EvE49+AO98mNvAKcPlzlXqp8=;
	b=f6zW8dB6wrggFnME5qOadfXziwdecQFe5hAyZvDeG5Tem1Lh+2/YrblQNAA8Se6fJrcm
	 Gj/rBpGDWRT3giawhjlm4quY2AWtXwmJbN/57M7hqgxEbkjo3zOuaNu8j8TkGf/ChC7MC
	 CVX/8uC/kFCc6hKBt26bcEBztX/41xz714LllB40OOdSiImhpzdHRWXTvt8v+rqTySGzr
	 CspNbst8HvYfZAC8nYsmDWskJ7ojp46hwl+mgi0jf5+NQk7oy8HLCm9kqMveVbvthr5Ar
	 xsZ0LXNpED7V0kGjSBdVWGsztKg3ik5tPXJPdGQ8R905lk+X8ZPj1yT7ubmHAaMgg+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="cvCC/9jC";
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7F606A884
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 01:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17B7F606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cvCC/9jC
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eaf3f829b3so34550395ad.3
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 17:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794878117; x=1795482917; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M3B5P4sZFtbCUwrSNj8EvE49+AO98mNvAKcPlzlXqp8=;
        b=cvCC/9jCaynhH6kEKuae0WRC3u9hi6zpTZTAcnWq65QzPbP5sWukmddq3WtjogMkia
         /ec0biQ4CnZvdPkpBOjxc9bG/GhjRUuSZjfixXkMNePXRdws8x0sI9UBdlEVImlCUNyP
         7CLbCGimxRFtQd7nE4V2svBrclo7pYifaaYkcn5/vOLexNcstmqE4PYcO0qMoYTcgIEY
         5iVSLjFoAXdRuuhARDS4XwX7YmBnmGHjLlO0i89Orop773/gJLqnerY6NBq5IvLJCuAb
         7sMYaRGx1glkdN8JwZLkKxmq9g7Gao6FOq0h3Ykkat4xEVADDd4VyuWmrPz4bcGkp8TW
         rBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794878117; x=1795482917;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M3B5P4sZFtbCUwrSNj8EvE49+AO98mNvAKcPlzlXqp8=;
        b=xDQ71yXtRMcEaYNQF9NXursBi1yzU8uG3sgLk59D0XdheuGFXYDh1/yhvw7Gc8YtiN
         aWrTJhxR4L2O5YrX2cGNZM2lPtErw+b/ChxwaZobJhOe9Qu/FFfq/JtLLJ/GsatIZlkK
         8IYA6FPA8VngP/L7Onb3ADxmpSw9zjX62YLilu23u/qFogwTuxFPk6DXvB2nnTUTcjiH
         qvjP5KGYLuLLUZt63PRrdFznb8reCPTmEtL4yQXTMBfvrs78QApQFIkFtHlf5WlzdfIS
         EwECTWgGiAP2eYR+kEQpy439q0FacwJBAMXk9+0Awkz+p93Ca8GEFYN38vzU50KHeWY0
         CLcg==
X-Forwarded-Encrypted: i=1; AL+hErEG3H1DOEiFA38dn9E2/Z3Mk90mBOHsJah42T8e0qdU5AATovUFGBD4kzazlfIUGzWbZk8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5K0+7x9KtUoHvrKBcOTY9kj8uefAguAuvusb8kkm/hZdJ/pj/
	7j/iJHPjZPBUklUqTq/N1OBrzE1ud+wd3+/h1/M9RNeGH5uXbr5Hbklb+wEwdi2yusOG3SBPc4q
	Prijndg==
X-Received: from pluq7.prod.google.com ([2002:a17:903:4b47:b0:2e8:5201:ef23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fdaf:b0:2ed:391c:1de1
 with SMTP id d9443c01a7336-2ee0d6654bfmr113200505ad.1.1794878117248; Mon, 16
 Nov 2026 17:15:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 16 Nov 2026 17:15:13 -0800
In-Reply-To: <20261117011513.39419-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117011513.39419-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117011513.39419-3-seanjc@google.com>
Subject: [PATCH v4 2/2] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
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
 virt/kvm/kvm_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9938b753948c..f0d95e8c37f4 100644
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
-- 
2.56.1.703.gf848ed807c-goog

