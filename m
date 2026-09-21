Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449845158AE
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024788; cv=none; b=eEyVj8UBG9xEhH61Ht6U5UtN2WP1etEwiPxqgzIQLTpaTedowKNWRucP0dGjRLD3jAoMQ9zaMJXhnHlojCVIro7Kr87sm3reGHk97kKvRuMisiy7Wx+YllOYL+mX5dNSsb+q+5k4t/bnhiEO1oVZa4YHGZpgUu1Nd16DPcvpX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024788; c=relaxed/simple;
	bh=CYYAcKPHXAFH7Y5AjQtLjJCtZzeCM4DuK/S80/6HmOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XW+CIt+HKYS43fxSiqwvdNsZKbIxL20jH/yBxl58arhl8LptfZWgC5FW2AmIUxf91gCHotu34d4YnDgqLSlji3hoQd3Cqo6H7XeM73pZy2du5QLWYJzv3T3QiEy7nSUZnPUCbC6ebDlo8tKU47UFdTC0OTvcUQbJS8pBL1oplM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzczRNMM; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzczRNMM"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so6113947a91.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790024786; x=1790629586; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iDR9vXlRAx9NrdlF8eqo04imbFcW8giz4Pk14RgnJc8=;
        b=mzczRNMMbk9K/5uLf+Ns26Bl3tRaOL77nBC3U4an74Zwt7fNwMpuLJwRlkDwTvTO4A
         yAPCrDVcTbnuo/3hl5KQhKshEiZ6qpvsUIKDC2bG16d7F2o1KUmSYu/luylJ2LuddS7D
         CZPuypsIThKk2RvImYLX+LjkB8CC8uyP0SujsHlp4DgcJ7cXtnVxLUI3OGz0FNuTuyML
         oFNpkiDn7Kqfxkk1/CdRLC+zeeL9JOwlol4y8YhoHS5zKE41e4J45AHeOX2Cdi3RZXcm
         jCUOqfIKH2HDLhUuqU0WfPIVfRHQvTvPs25okGg83UiPOyGpehHIHWm+DPEQeUhktD3F
         H/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024786; x=1790629586;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iDR9vXlRAx9NrdlF8eqo04imbFcW8giz4Pk14RgnJc8=;
        b=RvcJrbqzBvzJX8QeggTUlmo1HCwmYBVp52cR8UKzlRLjPyje5Xow3/aLMVZNyNjQka
         ej47TzM4RjX/TKmv9A0CqiR0DoOhRfR+RkzpRPbX2RgkERYLaovd0V4Eqt4Y9EqW8WVS
         DdOP5RZifOsdVjyMbZbbFvqjXp3Td8f280iaov8M+M+vGQChfQJo/OXzu1jhSXTEwYbd
         +4DgnA10/xmmmbljE4lY7F1w9vPKMfj++PhJG/YB7jhMBI4L9k2mghDK4oklJot7V3+v
         eN5Gj2YO+q2N68dj3PPK5m3iO9Hlip3NGMxbjv/U7n1aMWleBU6KqWglIKGGUFKd7Fib
         VCmg==
X-Forwarded-Encrypted: i=1; AKwUvBzHu3kmO3clDSunZgYf99X/QDdHNf7nrdHWwo8gSEsmg2pdwPYss4gvLgpuv/jxQ02ApyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lvjZ844g6Bbp3F19FG6H72N1C8j9H180RmEoMEhgi83Jcj0qO4
	ke9axg9zVflaaUTKaqZzYDOnVkIq9lPH94ZirYeHB5d+/HzjfxWF6EOBBb2jR71Z4KnYRPNh23z
	VHwBtYQ==
X-Received: from pjbft16.prod.google.com ([2002:a17:90b:f90:b0:3a0:4eb1:9d4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5824:b0:39e:6a7f:1dc8
 with SMTP id 98e67ed59e1d1-39e6a7f21femr11148963a91.36.1790024786217; Mon, 21
 Sep 2026 14:06:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:06:15 -0700
In-Reply-To: <20260921210616.1024168-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921210616.1024168-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921210616.1024168-5-seanjc@google.com>
Subject: [PATCH v4 4/5] KVM: guest_memfd: Establish memslot<=>guest_memfd
 bindings *after* memslot is ready
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Wait to bind a memslot to a guest_memfd instance until *after* the memslot
is fully prepared, as creating the binding in guest_memfd will effectively
expose the memslot to readers.  As pointed out by Sashiko, binding the
memslot before it's ready to be exposed to the rest of the world can break
various memslot assumption and rules.  E.g. x86 could observe a NULL rmap
pointer if a PUNCH_HOLE hit the guest_memfd after the binding was created,
but before KVM made it through kvm_prepare_memory_region().

Begrudgingly resort to passing in the guest_memfd fd+offset pair to
kvm_set_memslot(), as creating the binding really does need to happen in
the middle of setting the new memslot.  Alternatively, to preserve the
aesthetically pleasing function prototype, "struct kvm_memory_slot" could
be expanded to track the fd and the file, but that would create the
possibility for TOCTOU bugs on the fd vs. file, and would add zero value
beyond making kvm_set_memslot() look pretty.

Fixes:a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Cc: stable@vger.kernel.org
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260826170551.BEF801F000E9@smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b417b1f7095f..cc79a33a7d39 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1897,7 +1897,8 @@ static void kvm_update_flags_memslot(struct kvm *kvm,
 static int kvm_set_memslot(struct kvm *kvm,
 			   struct kvm_memory_slot *old,
 			   struct kvm_memory_slot *new,
-			   enum kvm_mr_change change)
+			   enum kvm_mr_change change,
+			   unsigned int gmem_fd, uoff_t gmem_offset)
 {
 	struct kvm_memory_slot *invalid_slot;
 	int r;
@@ -1944,6 +1945,15 @@ static int kvm_set_memslot(struct kvm *kvm,
 	if (r)
 		goto err;
 
+	if (change == KVM_MR_CREATE && (new->flags & KVM_MEM_GUEST_MEMFD)) {
+		r = kvm_gmem_bind(kvm, new, gmem_fd, gmem_offset);
+		if (r) {
+			kvm_arch_free_memslot(kvm, new);
+			kvm_destroy_dirty_bitmap(new);
+			goto err;
+		}
+	}
+
 	/*
 	 * For DELETE and MOVE, the working slot is now active as the INVALID
 	 * version of the old slot.  MOVE is particularly special as it reuses
@@ -2069,7 +2079,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 		if (WARN_ON_ONCE(kvm->nr_memslot_pages < old->npages))
 			return -EIO;
 
-		return kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE);
+		return kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE, -1, 0);
 	}
 
 	base_gfn = (mem->guest_phys_addr >> PAGE_SHIFT);
@@ -2116,21 +2126,14 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
-	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
-		r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
-		if (r)
-			goto out;
-	}
 
-	r = kvm_set_memslot(kvm, old, new, change);
+	r = kvm_set_memslot(kvm, old, new, change,
+			    mem->guest_memfd, mem->guest_memfd_offset);
 	if (r)
-		goto out_unbind;
+		goto out;
 
 	return 0;
 
-out_unbind:
-	if (mem->flags & KVM_MEM_GUEST_MEMFD)
-		kvm_gmem_unbind(new);
 out:
 	kfree(new);
 	return r;
-- 
2.55.0.1082.g2b9226bbc0-goog

