Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0531A572
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482635; cv=none; b=WHXqzaRDF+rQxISFYFvhJuhyUyKKnYTwgE/BU2maouarrKTszooT9cEx8zJduHArgvmOfDtgp7JtCQPv2AB7nD8DmdDyZGFFy8rnW3uPvb7kT55i4zdFgCbzBQmJx8CZhiZNi/8VVjNU+n+6tQhNEJGqHZgGgtu1hwuJ5KVKLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482635; c=relaxed/simple;
	bh=KqmZnMW17GKDTxrpUxX/v6jIjCcXy4jjn0p1/v764G8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+bA+uzSIbCQ3Z70PzQwVp+kiF0IbZevPj+K7xa/TAwSWGv18LOI6FIin/xxbnhiP+Qj3zlZrrI+/jpUkPZfkLc+lc9Px9Om+sEroWAlM3Qaa0CZxlYULvZSELuhEIlxUPwmpFyK9xrGYm+5gtG7g/mUzcJmSDbXqZRq06IUC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzbYebzR; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzbYebzR"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485d853b08so616438b3a.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788482628; x=1789087428; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wyxdAUXsugT5mSZpd8+DhZJsNmxQcD4LPrqDMHJbC/U=;
        b=qzbYebzRM0X7N8Ox2Q7DIldnIX8WwijE4/Q4YlZRIh240T3yKZ3/swFjSLwBkudlKG
         fEx8p8HUfNlSqUYcin2TB/k+AbaKEEzR6+FuwO6U0s2j2dJhRPXQXX5+ybEGvvnDHzYq
         HpCiYz2jEhpNnJXKKUsl1i2/QgOpGolI86NJsTa65mIyJla4yXjoPABerQLmlhl3Jurv
         xy5CVYOcfFUoi+mXDo9bIEw2IfbxKBNkCaTsWNthWNkyFxvuYPbSGTq8dChAO+sSNzC9
         NEKIGQId7kHPbIfPT6U2Hnen3H4enCGoTxKUZuxypxZULQNNBY4+DXe89guENEjP7nA/
         KRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482628; x=1789087428;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wyxdAUXsugT5mSZpd8+DhZJsNmxQcD4LPrqDMHJbC/U=;
        b=GRep7Z+/4tTek1PRKz90gTIhOJGkxNYEjfvndon3VvXZbjpW8u3Im88uwpBFSzgEg+
         cNvu0KTSM1ky55ZlMZcVuH97WwaLZO8H5TmPalMDvqAOqEkS6vQxTmwASEIGCFTETeTk
         FTVIRnkHuhD+iEsWBd2BWUxItGremQaGMXnvsp3YLwQfpXKKaBXiZSjjjb5EAZY6UMWg
         KBhhxolnSfwLXbbx4hjBOVcb+HCr2aD921conpzHnvg+eJ3CURnmpofX/o0T/LmYv0pt
         gAgBhDSuBVl9ByfETix9fO1HFMT9hLPLAgN7GTK/4rPRKRoFVXZwUfWJcc0JOvEjyiij
         YNEw==
X-Forwarded-Encrypted: i=1; AKwUvByFwVeXyLDDCuF2leg43NMEQhNg3VL1KQb9fFCQ71n1aCKCOZDExDdFpjMSxCSvEIT1Rb8=@vger.kernel.org
X-Gm-Message-State: AFuF++kl6Jl0h2Fuq6xc30wHp2PmYDhKQ+vUUyetmqWqi75lhl+v/gwy
	UlScujsiUH32ZfJvaWx7BeajRqODRP/hLDdQHB1mBmiQF25U8S6iet0tuP82YFupZJoaMMdlPsp
	PayafhA==
X-Received: from pfbfo2.prod.google.com ([2002:a05:6a00:6002:b0:848:569f:3464])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f81:b0:837:e9cc:d474
 with SMTP id d2e1a72fcca58-86167aa9520mr3211481b3a.2.1788482627624; Thu, 03
 Sep 2026 17:43:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:43:41 -0700
In-Reply-To: <20260904004342.3162959-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904004342.3162959-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904004342.3162959-4-seanjc@google.com>
Subject: [PATCH v3 3/4] KVM: guest_memfd: Establish memslot<=>guest_memfd
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
2.55.0.979.g7e5102b832-goog

