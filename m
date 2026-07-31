Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDF430781
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520723; cv=none; b=qgWSnIoFH6tulZph42kaOOagqODOObMIxzoI4HjrRzp3b1QeRq5E1iuIyxqS2uCjxmYBtIjvcVF2FZBCzZkoGpgxMFjivBIrtQXVIUioL79oHXloyd/nPD8aYBr3drI/BT8zpRLitEmGZ93SDdWlh9hCT7KyOz88imSZ7axReM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520723; c=relaxed/simple;
	bh=pQ0teTd7XDWNbpvsOw580l+rfVUj4fBL0/VVxc3yCKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DW2xXz7uOsEGK2zQMlXni+UHZCIISHmHVHqGl1RHKEADvXTs7XQ4idzvs6oNXuTlK8sORcASRxfQB9gb8Xicf94OLKil9Ia+b8q6kCW5cD6YcByR2lickVqg5i7w7AxuboFiL5zTZSIhdpBtE6GGz3UsTBxoaDu1IdLQxrCFE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c20kOij3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=icj+N84N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c20kOij3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="icj+N84N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785520720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2qKhJTG2JAuuEqxKzD1FHAMu/w1RQ6BoELHLT6tOYQg=;
	b=c20kOij3CtV9TgWZ2QIqaetC4oRR7gid6soIxujLfvrTOPcPmBk6NqNSnc3/pqC6s7xSqo
	CejnZQhUHKceur0K6QGQmJZ0rSyCIpTgqXUpgiE/+gZzSAt0GXFps/4zhrYpf0gs/sFNoT
	92hQt3wNycyRcOA6bUZUIyMfxyuJ6ME=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-KHoxbTSXMp6V8fVzSCnr7w-1; Fri, 31 Jul 2026 13:58:38 -0400
X-MC-Unique: KHoxbTSXMp6V8fVzSCnr7w-1
X-Mimecast-MFC-AGG-ID: KHoxbTSXMp6V8fVzSCnr7w_1785520717
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15f0aea084so111477266b.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785520717; x=1786125517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2qKhJTG2JAuuEqxKzD1FHAMu/w1RQ6BoELHLT6tOYQg=;
        b=icj+N84N44o+lVhMiejxyugpInwSpI9bzOA9JrN2EiLJ29MI/5fXGjhhB19LnPAgCG
         oDgBIAydzmFGp1twxxZh3N2Rvv7ckBl6u5VNgZRj1Xxw1SA1vsODAQ6RDSMqlJKGwlxA
         jFSI4HPbDL+sq6/GKX051KBAYl1s4/ZXHoDgk/KsAUzRtfxpcDszqhrdrfrSUZK+Q/A2
         ixdhNLCBgcqg55j6C0HYdoIlmMXgrToDc0whK81kylTKSjKFM/i7j2S+EUfGEcyREiUw
         1YpRgxNfF9y2Rz4R7vf7EgSbekgRir4nNU0zguI7QwjrjcEXx8NEO7oK2pIpF7LTwQdE
         MgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520717; x=1786125517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qKhJTG2JAuuEqxKzD1FHAMu/w1RQ6BoELHLT6tOYQg=;
        b=fI0BVy29IAq4Hqhy90aZ2EpKtPvZjE1D4eIJahlFj/Q79ZQtWuS1GMWo1mmJOorpFR
         Hob5QlSeozhMLTo1H+yxzuWasePEjoY5QrtHhdIblrY9TLfQuWfE82gdvTtA3B/zjxkg
         ISBVwlKsx1lMy3Pt22EBpQYNQetUEgugN9AMx2WoLmHlY5i1kGZ+Y65xHOGcrmPM+/9P
         DxW6XF8wJXNGRz13IHn9Ltafu3SdYSr0fZPEr1ar68pIz4Q000PSZ5VABNWetptC5kdO
         idzVPJMdzKichraCh0l2QCMIuSHdTh4yqlH01UBfkRtaCm25udu9CelkSaHMWJO+e9eB
         7noQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5xTbAro9BSu/B0+6gAl1AcFxFHQvj3dSR8UtNmU90q/ZK0AXkFxudHKCEIwDxUyU/dEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5OEHEu0d/nj7DnTz81zozVSre7qkl5yljh32jR/DdgMHuDkkZ
	hB8ReEW2NqOOR/d+Ylci51JqHx10Z6ZiVxNoTudlkmZyXib+iiDkcSTjwVqM5iy1wDB11YQhD3j
	67LK0e+XtXO5QbeyGH2oTbZsmr7PmnXJALbAKBS3ckx2tSZfKyJqShB8y+8RMow==
X-Gm-Gg: AR+sD10r4bPXEo77QFw0md6dNVTfFNikPCSboWGCKLWAn9GuP2S3txjBZkKPdoaSrEp
	fzKlf7ABpRUDewIMm7IDU7KZObkU0ZZEUPrHCbzNQPIi81+NP/T5ZXSivj7Kq0RRnEw9Nrf3j/8
	Gxv9lnMjFnUGTID8Hw07ZshbvbGFBSoqNLUxAHtvAaEg4h5RBLG88DJLeNGsywW0BrOixySTdYg
	aNyUS8SdivdEI61kuobZ/nXLXXNoX4o0F5Dukx6zSEsOVnujKKPV4PvGEVd48U/5QqYQNd2OGvz
	oMjGWK7Vu9Pd6Sq9dLmZ9EXg9+mbPaYrVr8mV5AVWWGOO2/BIkJQU/YUsreYoNUEG3gthj/NZ7U
	dSGA9oZGdrgnKG80HAZD1xk3NmmmC7XyJFJ3gdCmaJjM+CdV7XdyRvwXM/+iR+jwrWnkL5VzUrI
	aIQk0=
X-Received: by 2002:a17:907:961a:b0:c16:8aed:cec3 with SMTP id a640c23a62f3a-c1fe8315915mr41041966b.58.1785520716974;
        Fri, 31 Jul 2026 10:58:36 -0700 (PDT)
X-Received: by 2002:a17:907:961a:b0:c16:8aed:cec3 with SMTP id a640c23a62f3a-c1fe8315915mr41039966b.58.1785520716265;
        Fri, 31 Jul 2026 10:58:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4454321sm215703566b.31.2026.07.31.10.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 10:58:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH] kvm: apply VM_READ/VM_WRITE checks to all VMA types
Date: Fri, 31 Jul 2026 19:58:34 +0200
Message-ID: <20260731175834.1121005-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VM_READ and VM_WRITE flags are checked only at the very end of
hva_to_pfn().  For both the hva_to_pfn_remapped() case and for regular
mappings, this adds unnecessary cases and inconsistent error behavior.

For hva_to_pfn_remapped(), the code is relying on fixup_user_fault() to
detect this situation.  This is fragile because hva_to_pfn_remapped()
returns different error codes for a !VM_WRITE VMA depending on whether
the PTE happens to be mapped:

* if the PTE is present, follow_pfnmap_start() sets args.writable to
  false and KVM_PFN_ERR_RO_FAULT is returned;

* if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
  -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
  up returning KVM_PFN_ERR_FAULT.

With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.  Likewise,
a PROT_NONE pfnmap VMA would be mapped into the guest if the PTE was
pte_present()[1] when the guest attempted to read it; with the patch
instead KVM uniformly returns KVM_PFN_ERR_FAULT.  Doing the check early
avoids these special cases and also sidesteps the issue pointed out at
https://sashiko.dev/#/patchset/20260731160514.1101989-1-pbonzini%40redhat.com.

For regular mappings a PROT_READ VMA, if placed in a writable memslot,
would return KVM_PFN_ERR_FAULT instead of KVM_PFN_ERR_RO_FAULT when
the guest writes to it.  This would cause a -EFAULT exit to userspace,
instead of triggering emulation as the VM_IO|VM_PFNMAP arm would do;
however it should be considered part of the KVM API because mmu_stress_test
relies on it.

Still, even with this snag about the returned pfn error code, pull the
vm_flags checks in front so that they are done for all VMAs and the
above inconsistency goes away for the VM_IO|VM_PFNMAP case.

[1] on x86, for example, such a page would have _PAGE_PRESENT clear
  but _PAGE_PROTNONE set

Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..eaf8ee0725d4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2925,17 +2925,6 @@ static int hva_to_pfn_slow(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
 	return npages;
 }
 
-static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
-{
-	if (unlikely(!(vma->vm_flags & VM_READ)))
-		return false;
-
-	if (write_fault && (unlikely(!(vma->vm_flags & VM_WRITE))))
-		return false;
-
-	return true;
-}
-
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
@@ -3008,20 +2997,29 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 retry:
 	vma = vma_lookup(current->mm, kfp->hva);
 
-	if (vma == NULL)
+	/*
+	 * GUP failed.  It could be an inaccessible mapping, a pfnmap one,
+	 * or the page might be absent.
+	 */
+
+	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ))) {
 		pfn = KVM_PFN_ERR_FAULT;
-	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
+	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE))) {
+		/*
+		 * Exit to userspace for PROT_READ mappings in a writable
+		 * memslot, as this is part of the API.
+		 */
+		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP)
+			? KVM_PFN_ERR_RO_FAULT : KVM_PFN_ERR_FAULT;
+	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
 		r = hva_to_pfn_remapped(vma, kfp, &pfn);
 		if (r == -EAGAIN)
 			goto retry;
 		if (r < 0)
 			pfn = KVM_PFN_ERR_FAULT;
 	} else {
-		if ((kfp->flags & FOLL_NOWAIT) &&
-		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
-			pfn = KVM_PFN_ERR_NEEDS_IO;
-		else
-			pfn = KVM_PFN_ERR_FAULT;
+		pfn = kfp->flags & FOLL_NOWAIT
+			? KVM_PFN_ERR_NEEDS_IO : KVM_PFN_ERR_FAULT;
 	}
 	mmap_read_unlock(current->mm);
 	return pfn;
-- 
2.55.0

