Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6429339392
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840908; cv=none; b=U0CHbhCd+vpw56Rk3KrPquzxSXJJ7SnBlJzyWjn1b/oz4cSgu5opPG9OQenYX5/JYYS1ZiYPCDd+XAozJEG+KAMEdjQr5irXsPmz/sLdQpye1282PKEFncJSv43WMntzQV1Rc9BiAx6vEbjSBRUM14LSxokgnKAlYNOH10QHxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840908; c=relaxed/simple;
	bh=eA93fv/mpTDCRlrJZcN1uZi/U70iOhyh+rAp/vvrO8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHhurKquIk06M6kqnQASBJZp9+uOXdnDRdbEAzkEkUUD5mvWlkDQ5GzZ+aig5wHnZrwF72lE3+tIAqdpI0zV741Gqtun8ZbGIqjOlXWTdLXyJ1v2oU2VQL6RWpDs8yyQxP8eI3OKhFYi4/PwGh+2Zrmpo51KH9xtXC7JyoZ/+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFn1FEu/; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFn1FEu/"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8484b9fb055so2474201b3a.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840898; x=1785445698; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C50SurZZSt8mA6DGLyY21O4lr+i0ojUTfN7EWK5ap7M=;
        b=OFn1FEu/sSn2OrngPDiPb2ecCJVSHnArFL8aGe3Hl0jQ6pRLGNWW/TVuP5ECWDY0tD
         sK5yIChh6fBjy9yHi4VdStitGnlX40HOna7Dx8lCYG3gVYADfqTq4UQFzbtwBdxlorng
         V1UDS/SjFA8EHsPZZqllKg7v+6v3tIbul6F7gB77iOhixh4jfMQaq8nb6WPZCi+GyTQ/
         CBYA9PuOryt8UgZGYsdiXypJbce6e26iMDvdF6YMLjrH5OTzILyLdA8cbaK25lk5MeJE
         kkkuK8rikZDVu2ysV953t5YsLkgCS55R461XT0TpeGKu2+zaWWll+arXuhKXQQiTF5IY
         iEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840898; x=1785445698;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C50SurZZSt8mA6DGLyY21O4lr+i0ojUTfN7EWK5ap7M=;
        b=RcAhJyGF5OeYsQP5hT66lBxsGviCmoBqnqMTFe5NawtvVrGkeLxUfM1PpIybwc5DnA
         laMLbnaTA4XuJZMoGnkSBxAP+w/UW4wIYbkE4fLGrHBOuXZhwbCsJTVOxq6z/JV7vod3
         MmvvkW8A5LeKmVgIPkQgXcS+72HK0VGT0MIjYDSGEgVnzJzRHtyjETcMg4ZwcMMELJzI
         gAPJjoN0o653TOsSUKtNitDC3y1IOfBs2WAsXDJXYyIjaXC4BbnV/uxdrkjUrMOgUB5f
         DpyNYaxWN8mjvWfYMYZUkLTG2GkACMpXjMRDuUQH5mmTxezP2gKpnqRceZ8zByMNjfiq
         SI+w==
X-Gm-Message-State: AOJu0YzqT8kasHay/gFAmUO1vJC2hMBqYSfuTDlsgTbt5QifegZyKgrA
	I4VEAsMCOsGvhpJWst1WVyARCum2ox2K5NFcJSe9OY8sEtW8mKL3ISjOC1kSx501ZA44fP8gKgq
	uwwAa6w==
X-Received: from pgii15.prod.google.com ([2002:a63:220f:0:b0:ca1:3a05:d935])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:928f:b0:848:2f77:e2e0
 with SMTP id d2e1a72fcca58-84e2c262b43mr5494478b3a.73.1784840897838; Thu, 23
 Jul 2026 14:08:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:07 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-6-seanjc@google.com>
Subject: [PATCH v6 5/9] KVM: guest_memfd: Add helpers to query SHARED vs.
 PRIVATE for a given page
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Add helpers to check if a given page in a guest_memfd instance is PRIVATE
versus SHARED, and use the "is shared" helper instead of an open-coded
equivalent in the user pagefault handler.  In addition to the immediate
usage, providing an "is private" helper will allow cleaning up the so
called prepare() code, and eventually will be heavily used once in-place
conversion support comes along.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2effff582f50..e9d61410e5fb 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -60,6 +60,16 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
 
+static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
+{
+	return !(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED);
+}
+
+static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
+{
+	return !kvm_gmem_is_private_mem(inode, index);
+}
+
 static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				    pgoff_t index, struct folio *folio)
 {
@@ -397,7 +407,7 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
 		return VM_FAULT_SIGBUS;
 
-	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
+	if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff))
 		return VM_FAULT_SIGBUS;
 
 	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
-- 
2.55.0.229.g6434b31f56-goog

