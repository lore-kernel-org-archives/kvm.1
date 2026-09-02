Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADA44A3EF
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373225; cv=none; b=lXuDEfusLiYEfCk7JeBdNMTIvN1vBXWPKd3wl7//naoEJgfMayvsNrOQSB98Uvp+C2eD4T8OZ3RpTCIWS6Zvd+2AfrYIL5krUVP+OaHkFK577UYeBsdBw0LO4r6pSHzAmZTqwwUH3Uon0SDPqRcASMeCl96Fp0miMOrr0AvoCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373225; c=relaxed/simple;
	bh=4nM44dji28w11w5Jz6G8Fn8/bMsweabqa4o1j27fvSI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E+6QfughsEQWrqfqGR4UKsgQ59atPe1NRiogW/yY0cW5URF/IXax+kskf3jiCE0BHX5eQ+R6AM1AIvI2NrNuL59ZFPEaksK8ZSSfsG6VFiH5ZP6QBEPvE1nxZFzHzF0pa+qefiaOJKCth+WmB46794NjH+Zg9CRenTSpfKQsJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRLkLrhg; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRLkLrhg"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8485d853b08so2184948b3a.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788373223; x=1788978023; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ti7lJbGj6xN91aSen76gggEVAHK8aMIWKvWm2Rqm9Hw=;
        b=hRLkLrhglCKQLv3hOGl4+ipbDsqfaX/CEDWYiZ0EXyPdNSnxtfSJKs8tTyxBkhGver
         S4Hja+eTvNTr8Z/dQzj+g9nSQb0Jpw6Pi15pLtzpcaRtsnSJrUcPDvAuZVcCI8WZGPGJ
         AjTRDchhEn9JOj1jpvlWeaRSRyFJknkK7oSw75hARvVZ8sR4lEVfZLD51SpxPZxeZgXI
         nbPV1ZiQOXx7Sx05HsBc4yDOO/kGg+LQKTDLU5nqMkRJsYknAUqUCMSp0PkYMpY8IARl
         U8cyU7C4UA6RiBHU7AIovuWjaXNeERjewrdGe4ZKKzF+L+oDsMX5hapHIj+nKwQNEaeJ
         w5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373223; x=1788978023;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ti7lJbGj6xN91aSen76gggEVAHK8aMIWKvWm2Rqm9Hw=;
        b=hufclOgBoy0I2X0V7Y/kAd1RPjoSpBxTNJXDQ8AQqdmrfIW8wSMdcYM3B0ZtxUI5RP
         9A1iCY0htOhUqfuxx7ugJLJaC1/kEScZ0+JoaZTCSId7DdFztKhmwDbqchoIQqCLeTTz
         1N2o0tIIjie1K4JLV7wY/wKS2LvSfe2Sju17QoZmvco9+pHcqaaIZH6+mZ2Itb8wvBTq
         mOcIRR4CTo4G8Semtyqfej75sZg/hARybCkixFnWIFa1q1hPvzWGlQvhdsrtqInkXVXZ
         eldIg5P9A3jeUv0fSC1m9nfPj8twAbEvJRn9Znp3diNGSWaXCKWUC4KIkkb2sYO8w8D8
         m5QQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjlEqgcm4X6Iy7K5TsA3/adjXPyC5Vxc8WbsH42xw/QShwow3GJlmYF72kCTAVJLnMOnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n2G5vCnS7vUyt8HPmcCpObH2BSJkY4NjHUM999Tq4I8IxZ2W2p
	nKAJnQOsTL+RRg/OWkDA8qzp0EVXGS42Gx+zfhhZE58/cdGUcVrbF6RgcmrPP/DlKZ6qeHYlcy7
	s9pFSxg==
X-Received: from pfwp50.prod.google.com ([2002:a05:6a00:26f2:b0:848:2e0e:62e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4298:b0:857:3b70:209
 with SMTP id d2e1a72fcca58-85ed1d08cb0mr11287585b3a.1.1788373223333; Wed, 02
 Sep 2026 11:20:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 11:20:17 -0700
In-Reply-To: <20260902182020.2615443-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902182020.2615443-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902182020.2615443-2-seanjc@google.com>
Subject: [PATCH v2 1/4] KVM: guest_memfd: Gracefully handle xarray errors when
 binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
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
 virt/kvm/guest_memfd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b596486d184c..2c8d8735de5f 100644
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
@@ -662,7 +666,13 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
+	r = xa_is_err(xar) ? xa_err(xar) : 0;
+	if (r) {
+		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
+		slot->gmem.file = NULL;
+		slot->gmem.pgoff = 0;
+		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
+	}
 err:
 	fput(file);
 	return r;
-- 
2.55.0.970.g62bdec98f9-goog

