Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197D476CC3
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763135; cv=none; b=h98Wu8GFgpuzwAiuj5wM+awaHRHVuc6oCl4ijCBTFy6vAabxqiv9MVXsB9jUX1qEV9S92J7CMux4dZ48Iuy3RySsSxNouRwww1Em3f8a7jvi93fGistpcfdma8NUeMJGPWBo67aBCl7C+SlxI/Mi1IbAfwuRVd8e8O53XOsiGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763135; c=relaxed/simple;
	bh=lKL1AghctyCGhVmrYRZl2IF+lI9RwXIRk4VVRCcz1F8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tUhsswwuO3UXCaILaENgHCJ9LX94Bpo/4IHGI/dyFpt+GqasFjppyJ5sgbGc3bMQFBW6QA4vOL1WP/Ss6Q5a2z9K0tvKIMCU+TdfgLtJnoX7FXMKDgXcp3Wr+Aq+f3KmVpQQBX9D/x3ecjbE/b+5xsRS9/tUmo4/EwtSgp1lc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpSqoV3V; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpSqoV3V"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f73d0f89so17410295ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787763118; x=1788367918; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kih6Ze+eAUyI9b/QVGz2Gk+Uahj8e0YRoP4YxZwC+sQ=;
        b=dpSqoV3Vw2dujGkjL4hoK2yFYxAzyLYpmodQH/zWzlhFH8nB6xZwQcvdagISuqCrV9
         7ea8/hjlhPbZQ0z4WU+IkT+x72i0MommvziCDu+JWq1Qqzs7g7gzHKRC1y7CeL5gLI11
         nXUNZ0rrz9CrJp9vxTmSmN/rRh4lRhQfHjtWfIJr8Y9kEQz6QVDAsZHpPHwPUQumAFG9
         ZT55FT4JPxgjgu17ec6Fv3SOoiBm0PeN4+nx09R0zS0yxNDNP7WYpQjj6DjBbq1bqn4u
         RPEMmChmiZcY6znaOd4yemm/5A/wd+1mCG+VHXoRHWKPrgNd6grg71syJB0pVPTKcW05
         kONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787763118; x=1788367918;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kih6Ze+eAUyI9b/QVGz2Gk+Uahj8e0YRoP4YxZwC+sQ=;
        b=Q+RQo8yMdl7GdfNtu6DHfoFgz5MRPauD2aQSPDHAytcp26K4wo2GNjWhXsWsq2WO0Z
         /noNxvJc98iQpaiBpzako3fL715ouQnSs7s+qvJxiDwt3ubgmrJlgtQMc1/ib4L9Fme5
         Hk0z2MKqmWx/vRu2V3Y0Pb2O7ZImHonG95lXU6HyMHlF3jdZatKmCAmPrBBfbfok4wMC
         6k2SaKvzhoa7sI8inYAC6pXhV2Zfpqy6+gwushiZar7WTMje1KtrhCMMiymbIce4AlBo
         mNpwsJpKPnKKQUJN+GP2eo+yViKzcN6rnZqjZoCSLIpCQbOgVA/KV5EaYaZWNPJSuTrA
         02sQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBdQ1/sdbAosnsxJX4AKfgbtmN3kwMcuxcCPgO7Vz8a0+fXrC9pCmhKGo6TUj7Mv5gRYY=@vger.kernel.org
X-Gm-Message-State: AFuF++kflQeHEQ1Cm56TvWbF6Noo9AIGyjOlz17einsPE2NyUGO+n8BH
	7CAUxZ5WgsKVnklaCMkmFd9ivmb7AjsFXDBnSbUoJCXD2ZJbAqySMabJlf7uMOaTVrdLZBNxY2f
	wRrOZAg==
X-Received: from plgf9.prod.google.com ([2002:a17:902:ce89:b0:2ca:5a0f:d0c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c3:b0:2b2:67ca:5ff9
 with SMTP id d9443c01a7336-2d707803e2bmr127600385ad.0.1787763117519; Wed, 26
 Aug 2026 09:51:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 09:51:53 -0700
In-Reply-To: <20260826165154.766699-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826165154.766699-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826165154.766699-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: guest_memfd: Gracefully handle xarray errors when
 binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
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

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Reported-by: Dennis Tighe <dtighe@google.com>
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260823135031.4F6DC1F000E9%40smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b596486d184c..1ef9e2916423 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -612,10 +612,14 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	struct inode *inode;
 	struct file *file;
 	int r = -EINVAL;
+	void *xar;
 
 	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
 
+	if (WARN_ON_ONCE(slot->flags & KVM_MEMSLOT_GMEM_ONLY))
+		return -EINVAL;
+
 	file = fget(fd);
 	if (!file)
 		return -EBADF;
@@ -654,7 +658,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+	xar = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
@@ -662,7 +666,12 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
+	r = xa_is_err(xar) ? xa_err(xar) : 0;
+	if (r) {
+		slot->gmem.file = NULL;
+		slot->gmem.pgoff = 0;
+		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
+	}
 err:
 	fput(file);
 	return r;
-- 
2.55.0.887.g758fc8c411-goog

