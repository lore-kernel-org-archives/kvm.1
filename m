Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4C498927
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024784; cv=none; b=AOI4oIsD/56UliAsR7vBAfmA+jRH603LLdHMkQ1GlXcO9zfpW1T2KYCB1KhapAkwDh3WBGHpyByWE21PYAXrCloRpPIBLom1qzPpECViIZBBpZp9e8pNiIi0ZG+jXSbY8CR3pYdQ6HbKgBH3/f96UMGUb7hRK+kUjhy8LXIgTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024784; c=relaxed/simple;
	bh=+OgMs5FTH885W5hqbW9mZemd9t74Q3YKNRON5By5iS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t6CnX9SJIFfNmRGc2kxH+BtRbRm7s5IDz44LOF1VAOu/+2gG+nkZquHnRSLEdnuJa03SFaTEqSTeLCJJlayJbHSHbu3EDdblnI1hAkJuhw+fisxyDhbqyD7PRt+iMx8dA2tjoHWNcdoBQZzpkbWfU2GaobxQng3MMDC8S0lT9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4OA6sjE; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4OA6sjE"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dc92350888so61135565ad.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790024782; x=1790629582; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TG/mu75XYT0SNXMXtTJlKEYyCMKeyuwB8Y7qCUcxVbg=;
        b=n4OA6sjEZF92BAlbp9JU2aCPRd4P9PDwQMeHV01g7L0eFn0MCo7YpRfMgRtslmhoxU
         Ul4bjRW/BUlrEijbHnc7/XAFNUy83bv1zMemZ5PV0m8q1NYbWvAqSntntJC+qun9y5G7
         9gDfZpi+c3ImGUjcB8wbmXMIvqkgb1OrItXukDiybgepHCybZZNvi4L2SQLmE/97FWE6
         zeS0AZ8QukRIz9CqHikAraNkPu3H3K8KnEDQiQxQKCm+/xdD1rVXBw7U1lbFjNB0M67u
         dpdSLQDyy4clOKG5qtPAMpu+wPWWkyEKWin5aF8DRg0wDyikps2UHpKw6Wlnlydy7KIv
         VR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024782; x=1790629582;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TG/mu75XYT0SNXMXtTJlKEYyCMKeyuwB8Y7qCUcxVbg=;
        b=UwxdXXTboy8Eorpn6R5lj9Qlatx/kiCK9uxQRcRuFjIZJibtSvnGIU+C3YdY6HX89e
         cWcthid3KzdbQamv3V32hmUnZHRvmQ8+xvugMWDRLSkR0xBf6qm4uEZ+/7rVh3xr9OAi
         ImIQ2g5R3lp+108412Wu3+R0fo6rxN3T5vVK9c87F+vUAK5TVDaHpaAIL6BXpZdF9M/G
         Suk4ej5lY2UPbcpWZhWRrM9SveH8UtqSzpQf55rViDFuuuI0exK41PwuYZF7aiarhB3N
         xWGGu5G5mnKILb6TgAFR1JZcGnSHyawTTeQD9kdoO8bCfwVUKHbR2iBdzuQGpMvA2amy
         93Mg==
X-Forwarded-Encrypted: i=1; AKwUvByRg1XmQg1jJrZdGLGXDN6/BgOZjf/Z9rnFE7d3QZ8PaNGte4AJtkECvAWtFcbJDYblwrE=@vger.kernel.org
X-Gm-Message-State: AFuF++mgNNlx1wOzWcVim6DhsPffYcDh0pmZ7h/CZxMhITPivq9+dlEh
	ygRe4SrxgmNfE4gGIKXRneG1q8a9FfULF/z2faZ6v84uqgrPVQ6Zdu+fC7mfbi2gPY66mCHJrYJ
	Zkz9GcQ==
X-Received: from ploc3.prod.google.com ([2002:a17:902:8483:b0:2dd:fc2:99fe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b28:b0:2dd:c100:a5e7
 with SMTP id d9443c01a7336-2ddc100a6e5mr106367345ad.59.1790024780575; Mon, 21
 Sep 2026 14:06:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:06:12 -0700
In-Reply-To: <20260921210616.1024168-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921210616.1024168-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921210616.1024168-2-seanjc@google.com>
Subject: [PATCH v4 1/5] KVM: guest_memfd: Gracefully handle xarray errors when
 binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

If inserting a memslot into a guest_memfd's bindings xarray fails,
propagate the error back to the caller, i.e. fail memslot creation as well.
Signalling success and continuing on with memslot creation results in
use-after-free, as the guest_memfd instance will remain reachable via the
memslot after the file is freed (kvm_gmem_release() won't nullify the file
pointer due to lack of a valid binding).

Opportunistically WARN and reject binding if KVM_MEMSLOT_GMEM_ONLY is
already set, partly to guard against goofs elsewhere, but mostly so that
KVM doesn't need to worry about clobbering flags when unwinding on failure.

Regarding the unwind, the slot must be fully prepared before inserting it
into the bindings, at which point the slot becomes reachable.  I.e. waiting
to update the slot in order to avoid the ugly unwind isn't an option.  And
as part of the unwind, explicitly nullify the relevant bindings, as xarray
can store a subset of entries when populating a range.

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Reported-by: Dennis Tighe <dtighe@google.com>
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260823135031.4F6DC1F000E9%40smtp.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 63943aa253d4..c094611f7c7a 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -654,6 +654,9 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
 
+	if (WARN_ON_ONCE(slot->flags & KVM_MEMSLOT_GMEM_ONLY))
+		return -EINVAL;
+
 	file = fget(fd);
 	if (!file)
 		return -EBADF;
@@ -692,7 +695,13 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
+	if (r) {
+		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
+		slot->gmem.file = NULL;
+		slot->gmem.pgoff = 0;
+		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
+	}
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
@@ -700,7 +709,6 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
 err:
 	fput(file);
 	return r;
-- 
2.55.0.1082.g2b9226bbc0-goog

