Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E62BEC4E
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036020; cv=none; b=TWlnjs55kaFhYsDHwndbDoncWVhiya8jAxG4Psbr0hYPBp6nB/bY10bViMIsxBDetufZ7uZojmDIGRIiE8DyfNSJgVFsA8o+rrL//UtYorrRvAPPUOYohfoVX8IOrzpRi2CdnE/omKWh1f7mMUefHxH5/2jQHWjDNs4zZ2T4Yu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036020; c=relaxed/simple;
	bh=/uWjI8Uu4H+jwIc5bzgv2pY2GKSfTMxj6nuLZ1zl2PU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I0Uxc41SX9Gt/A771RDKxQ3MlEnsoWld5JojF8IsoZDbPljsvzBkmLJAyJRk9BJtfzRMFWP53sCKJ4qfUXS8TPykyUooMY7Zl+4sKm81X/4CgYKjYdmnC5ybPz4udu1/rEhjGy0+wzXCJe9/QdWNZOnOo/ggDlFFw/Q9jfLJxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWMkc23e; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWMkc23e"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso3088680a12.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790036018; x=1790640818; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=turXne4uYV7wcVpOhFPdmOUyNfChurx8+MQeLApE3QQ=;
        b=SWMkc23eyqHUmYNn9xDXzBgGXhBVq3fwWxL3rbDt4pXFCPz+JhhBMdbxBd06misfcu
         W4Bg+QaqaZIqHQZeiEYe/39stwqxfV6CopyWWKtCZ41uFn3FS70eN4hdk6KVVbYPI1Wd
         MnzntsxBTAlmwwkI9p8SjKgWr0WJASEJL6a+4hkZekuN2gRFADoKv9Sz5ZwWWr/z4V+U
         PPWQUpd8BA7sHq9fs/BC1+gi4RdNbIPgFII6yHR2Fhy4XiZ5Ffzo3u8w5W3G8I4dyATd
         SbWePZsFf8Wzxda6JfBfck1OaVOFlmKvjp+ljHp97QQG/Q50NHrXa/IcAp8qlfk9qr4X
         g4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790036018; x=1790640818;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=turXne4uYV7wcVpOhFPdmOUyNfChurx8+MQeLApE3QQ=;
        b=QC9XuUDEw3F5Cohu0galBqTLcHrH0e1GzXPj6stSWztXlWKQIRDecl0MTkB8v4nBim
         1Wq32bu1tYQ+ZK9Mam94MtgyIyRXDLWUk7KgifBoKCODXyblMkdyw7tg7zzNz2ZVf1Tk
         9F7TPSxzeRUITAzkRR5p7Bdp1KfXXQx4JNC0hm+0Vf3fiZOMJPSv/e6CMkXBmxoQUTnS
         5wHgvTEEp6SKemmDSF3fOGP+bwBN2DHkRTAPbWLwIzyTQg2MXeDOv2/Umlp4wH93OSrC
         KXxC19q8xMiAb/iEpopu00iSyskzeBeAVU0wFMZx/UQBF5IUINrRmKB+Sn8ko1P1wJpw
         eFqg==
X-Forwarded-Encrypted: i=1; AKwUvBwVaIYT+rDNabIijwsKkLV4jYfZyMbDfz4NeyBUsPK4uSswu1eKyHf//Yqqt+iyr/uAsFY=@vger.kernel.org
X-Gm-Message-State: AFuF++lYh7Xl3h0yJJyOsobCVuxpVNftriPv5CLpQE9VxNHHsoD4CIpC
	62O8UfG+EqAF+kPPcycxYC+sExAK2/V+uKxW9UfMSaYYtZjWo/XFfZOECwSE+kMeK0F3CA/cYBa
	nXq2aYw==
X-Received: from pgvn10.prod.google.com ([2002:a65:63ca:0:b0:cc4:5907:21e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10f:b0:3dd:85a9:55a0
 with SMTP id adf61e73a8af0-3dd8c5ac31emr18020098637.34.1790036018118; Mon, 21
 Sep 2026 17:13:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 17:13:29 -0700
In-Reply-To: <20260922001332.1121266-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922001332.1121266-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922001332.1121266-4-seanjc@google.com>
Subject: [PATCH v5 3/6] KVM: Only bind memslot to guest_memfd instance for
 CREATE operations
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

For additional defense-in-depth, and to avoid having to handle impossible
unwind scenarios when binding to a memslot fails, bind a memslot to a gmem
instance only when for CREATE operations, i.e. don't attempt to establish a
binding for MOVE and FLAGS_ONLY operations.  And when FLAGS_ONLY operations
are eventually supported (this is currently all dead code), creating a new
binding would be incorrect; KVM instead needs to do a 1:1 replacement of
the existing binding, i.e. FLAGS_ONLY will need its own dedicated handling.

Update the relevant TODO to make a better guess as to what needs to be done
to support toggling dirty logging for guest_memfd memslots.

Because it's dead code, no functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 24cf96840827..ccfd5f5102a5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1752,10 +1752,10 @@ static void kvm_commit_memory_region(struct kvm *kvm,
 			kvm_destroy_dirty_bitmap(old);
 
 		/*
-		 * Unbind the guest_memfd instance as needed; the @new slot has
-		 * already created its own binding.  TODO: Drop the WARN when
-		 * dirty logging guest_memfd memslots is supported.  Until then,
-		 * flags-only changes on guest_memfd slots should be impossible.
+		 * TODO: Drop the WARN and do the unbind() call only for MOVE
+		 * when dirty logging guest_memfd memslots is supported.  Until
+		 * then, flags-only changes on guest_memfd slots should also be
+		 * impossible; unbind the old memslot for defense-in-depth.
 		 */
 		if (WARN_ON_ONCE(old->flags & KVM_MEM_GUEST_MEMFD))
 			kvm_gmem_unbind(old);
@@ -2116,7 +2116,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
-	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
+	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
 		r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
 		if (r)
 			goto out;
@@ -2129,7 +2129,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	return 0;
 
 out_unbind:
-	if (mem->flags & KVM_MEM_GUEST_MEMFD)
+	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD))
 		kvm_gmem_unbind(new);
 out:
 	kfree(new);
-- 
2.55.0.1082.g2b9226bbc0-goog

