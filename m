Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E84A3F1F
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373228; cv=none; b=T9e9cfvSiEgTxtC0FGQ0xp9nrSNYWNoUphgQapBUoSbRekTDXPziZXcr7zJhDbhcU+VWKHChcwj1wCcgX/nkN+7g6My2pyVMfbpIL7mKCwJJYonoIK5wYxvMQpMN+bkkb5OL6fuTdEDXY0H2OZQMEJ7ua/obdec21AWPkAbdCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373228; c=relaxed/simple;
	bh=djMXOvbx8+jE/Zv26hYHX8VjpJu2WZt5sjmIhcDZ4Bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+KjcFIRtuEi1lNOa327CcbeSKjDvpbDjyny/9Muj826nQ9O5CybLzkSDDLM4+9ZypaoVusCqszJLB48dMjl6ZzhQmLf8afCf7C1LcafZegfTTLJxHPOepcT4Eg8KXbCENZpRLSsmQcLghu9iVolNCzrYZSx79A7PUvn70zcaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HaX1pMxi; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HaX1pMxi"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-855f662439aso2783448b3a.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788373226; x=1788978026; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i8M/XWb6OKKdr40v6XtMfNASOvXcHPC8vp7zr28IIVA=;
        b=HaX1pMxigI9wTuRowcmYdOrhmI7g+PSN7N8MX8WqHs+G4NCj5QU2qvP3wvHzrGshcM
         FSykprSxSzdWQ5BpxvetTOiVfkKK8IYpPMGwXXgRIl/HzK0MzPeCSgHB6yIi8IWfY0dN
         r4Y0DtAFPMIdEVpvRtm1UphHwNFEanHMs++DOWR8JJyW59S3UP9Li4hEDwEgK7OqMEll
         /1s/6dq9utW2ZHOlCgIk2nMI9HCq65ZqEpcnlClipDVD/bNpoRk6gM20EirxRk6QQAbl
         6DhWGWUWY/YhfcfA9xoWQLmw9Qw9trnzN906kra4w6hFd96XmBmCZW1wb8RL47cyPR8N
         eHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373226; x=1788978026;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i8M/XWb6OKKdr40v6XtMfNASOvXcHPC8vp7zr28IIVA=;
        b=h/V5DD1+0rMHXjiMZWoDeZ923zKgn130VDyk66Pj2Cdpht94txikBE4SnOjMsMihvr
         04EdTBVzx9LFnFParB9HU7nemawt3U1HQwrSium3bQRM9wt1mpyfYYWF8sB6TCDZJbR1
         QKvBMloXXErl9IRvMiwbBrvPR3HA3CETQX+IUoaJMP3TNOxzqstHa0YcKg04v0E0rewr
         aJ769ODLPd0tNhwmy7j2Ahhsy0JZ4Pv630Gz0JuwYAt1aQOOKXOWml6873wCy/83fW6S
         iR2jyTFOu++vMdk7C/Ess6JTp43W5ChTW8JdnRLDljPgUSNtQlRAQKP/ZiZRvGkJ9kb3
         RDxw==
X-Forwarded-Encrypted: i=1; AKwUvBwjbEHwsrgaTvBBS2CKrEaUd/9MF4FbKCt52kOfwewtEhCL9MyZT0iz+NR5mjkE7OB7xCM=@vger.kernel.org
X-Gm-Message-State: AFuF++mZbzw9MNnhx+nTNQ4Dnn1zrEqTquXKGt+R7CXKxrGbHeSzy3Lz
	tlIeEAiO7DfK4IERp36z1Fb8OUtV6CGHL953cGbUI/uo5Zw4uX7+yzUCdKUbwCQMC0Ic33VFczJ
	RGvKXtQ==
X-Received: from pfbkq17.prod.google.com ([2002:a05:6a00:4b11:b0:847:9be8:84d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f81:b0:857:726d:270d
 with SMTP id d2e1a72fcca58-85ed4c1b14amr10098967b3a.25.1788373225757; Wed, 02
 Sep 2026 11:20:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 11:20:19 -0700
In-Reply-To: <20260902182020.2615443-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902182020.2615443-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902182020.2615443-4-seanjc@google.com>
Subject: [PATCH v2 3/4] KVM: guest_memfd: Establish memslot<=>guest_memfd
 bindings *after* memslot is ready
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
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
 virt/kvm/kvm_main.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3c0dbe60a5b4..21c10cbbac66 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1887,7 +1887,8 @@ static void kvm_update_flags_memslot(struct kvm *kvm,
 static int kvm_set_memslot(struct kvm *kvm,
 			   struct kvm_memory_slot *old,
 			   struct kvm_memory_slot *new,
-			   enum kvm_mr_change change)
+			   enum kvm_mr_change change,
+			   unsigned int gmem_fd, uoff_t gmem_offset)
 {
 	struct kvm_memory_slot *invalid_slot;
 	int r;
@@ -1934,6 +1935,15 @@ static int kvm_set_memslot(struct kvm *kvm,
 	if (r)
 		goto err;
 
+	if (new && new->flags & KVM_MEM_GUEST_MEMFD) {
+		if (WARN_ON_ONCE(change != KVM_MR_CREATE))
+			goto err_bind;
+
+		r = kvm_gmem_bind(kvm, new, gmem_fd, gmem_offset);
+		if (r)
+			goto err_bind;
+	}
+
 	/*
 	 * For DELETE and MOVE, the working slot is now active as the INVALID
 	 * version of the old slot.  MOVE is particularly special as it reuses
@@ -1965,6 +1975,13 @@ static int kvm_set_memslot(struct kvm *kvm,
 
 	return 0;
 
+err_bind:
+	if (new) {
+		kvm_arch_free_memslot(kvm, new);
+
+		if (new->dirty_bitmap && (!old || !old->dirty_bitmap))
+			kvm_destroy_dirty_bitmap(new);
+	}
 err:
 	/*
 	 * For DELETE/MOVE, revert the above INVALID change.  No modifications
@@ -2059,7 +2076,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 		if (WARN_ON_ONCE(kvm->nr_memslot_pages < old->npages))
 			return -EIO;
 
-		return kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE);
+		return kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE, -1, 0);
 	}
 
 	base_gfn = (mem->guest_phys_addr >> PAGE_SHIFT);
@@ -2106,21 +2123,14 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
-	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
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
2.55.0.970.g62bdec98f9-goog

