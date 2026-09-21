Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808B51475F
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024787; cv=none; b=TsljrmM5cQzIq6Xg3gnNzdfoeShUujYFHJJC+SAPQsXrulmc4NqgYjuenMiGNYxpf/BKxpPi2XF5209L760atwcy13mcZ5eE/CFz8c5SdAdD2Kba9SqDKt1aWOiNjCxvM5GxwMRTpLG50uC3MAe1NyZwXaacT7KowIOiGwtj8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024787; c=relaxed/simple;
	bh=a/Ta7ugmnfE2olxYhVTUQxbez2+HQ62mFKA5+uOWAR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tKYZUiU9yduKuslefXU7MNT0tuWKpadf8clYTdUAyHK29gRvo026z+p3j2RL1Jzv/lk7dUGMFPF3BsgfhigsCxWeGWtVAe8RWx8B5sXKAcduc5ny49Yfkkd/CONkQ0zyu0//BwyBZiS0Epp8bgKsL/OfGVjmkEu4k7v9p3lBf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OaViMNEa; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OaViMNEa"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d94f086fedso49973305ad.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790024785; x=1790629585; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e5qHde0DG0iGDJnHfYl3SHserU3q1V+JrrCFiXRle6c=;
        b=OaViMNEaC5skwUOwyqd3bDKWSZ+QRJ38McApbcbvck912eWXdoBGysYXzxUs3aHJtm
         A21BF4tlL1Fs/7/pHRyT0YpvmGoSK3S7qrsxe70seeEs+LF6N0QXCXoaeNB0xBL6xMjN
         +HRHDBikrroKmRJPbJvbW1RmLFHrasDWfDCb8BaUp7IoYSS62ayW/aqv4aB2FPBlqDwz
         cxRBgjIc+oiPoqs/Gmgop48UY8Z6OIvMNG+pgddBvsu21klCJdBWiDJW/Z/EhxATEB1t
         F2YC7Dx1scU/z+eGNf101jBcY/qgxhcqPuRzhYY+fmQfsF/85hLivnqwMQITnqv8bK3u
         bTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024785; x=1790629585;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5qHde0DG0iGDJnHfYl3SHserU3q1V+JrrCFiXRle6c=;
        b=HlVhBU++sryo4QqYjYVkAfTvtO3VW0myHuMe7n/YzQhzbrVS0n1CybaoZaHTdFsrgg
         b2TmR0uMFDzIjdbBh6yx/lPqDkNdv04pXK+KRf+mCych4+PU8J7pJYYd1tR7RM1acU7Y
         7UP+AGn08XDlHfro1GLTR0Tnf3SqBau+qhMuL1koGUbmipiMk5lxLDvDdbH5BM2URPNK
         Eq2vLTtxpvATiJAneN0xBy2gY7MLkryLcEQMxLe3eVeird7hYlE2Pf32zpXDGzy8VbFW
         Kr3axvTfy2O8Im2QM7MeSKl89APfeangszdrjxazyF61lZ/n1Rr+OuQg9wTBLdcFxPug
         CDOA==
X-Forwarded-Encrypted: i=1; AKwUvBy0Y0V1Lx3FdUo9yJlHONElWxs3uez83HIpaoiOVAPwGwsSslx256hNCks4w6UFDDJba9U=@vger.kernel.org
X-Gm-Message-State: AFuF++mNOaFGCsjS8H2hT9Berf9qxJKrX0301OqcbMlHxD8HdGVd+Q5c
	LSvAhIUspjYFC0QunAGlwljVDTlDtapclmPAx2ApChWD3NWgE83U6TXAd95+yTVOJo/r3ixnyPu
	fhDf1Mw==
X-Received: from plrp17.prod.google.com ([2002:a17:902:b091:b0:2db:1a39:c145])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a90:b0:2dd:3d1a:6958
 with SMTP id d9443c01a7336-2ddb1ab3a86mr181174905ad.6.1790024784833; Mon, 21
 Sep 2026 14:06:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:06:14 -0700
In-Reply-To: <20260921210616.1024168-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921210616.1024168-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921210616.1024168-4-seanjc@google.com>
Subject: [PATCH v4 3/5] KVM: Only bind memslot to guest_memfd instance for
 CREATE operations
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
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
 virt/kvm/kvm_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 24cf96840827..b417b1f7095f 100644
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
-- 
2.55.0.1082.g2b9226bbc0-goog

