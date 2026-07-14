Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83F42BE9F
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070624; cv=none; b=G3ZDso+/U19Kdw0qjH2+5hLh9h7QWR8SoOAU6ZMmmTvQAaTSqg7bQZABdhwU0Mx7FLF1zeJBSpQmoeIEuZ1LJwCb7NE1lRkcdtuRVEuf2ojndRNA3xojN1XoKviCW8qJ8RHC3xnfUEKLU5UC6r2XHwzLI4kUf9jfJxcmJVGSIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070624; c=relaxed/simple;
	bh=AXDYS3rVV/nNmwndYp3h/NC2q1mrxlOEREL9Q4aoMU0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=vCvUvg5sWvdRLNg7zWDJAxQVH0JsiBd05LTXlIVhtmXHxGlamR++GM8mKsOIKl0ZBKB3yBTZ3O25AU0blcetjCMN6eNEmtGhTZ3XfMQ58HOqwWZM08dnww/+VubejRIlMfZXdWXPI3PYyRzpGAoQn3hbb1gZhRm8jIX8sB6GWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XY+pDyiU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XY+pDyiU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cee1ec30f2so22034495ad.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784070617; x=1784675417; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vZlvJ9VSJNyVOtUpG/+wNqGmdqQiof1TsAOo30D1gc=;
        b=XY+pDyiU0WXF2NPwzyMd40IgyrUBFCP+C6oKeKxC1Euwl4yNF5NGGOM7vhobAkJSzu
         F6XpZjDlZ1D/mUa2NUyM58FwXXKFrxxjaS+HAu6to3J/+g3KVpmpBCJ8dv8WQuQ/ZoM5
         lwpEWSiRGmi0lTd5xaHUCbM+R/1mWtwCNLBfpVt6fAkNlaK9F8zCitU7tCgYBHSG+1SW
         lQxt+/k15sL60/9xnbBHaOTijT7+iqc3qvqItr/DV3R1cGkR8kBQB+cvu8kKyBilfPIc
         MoqyXo6KfK0JchO3LdU+TNaEwrgtq8GaThXACI9w97EqFmZVTvrCeS/POlSFjBNg+6Vr
         vgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070617; x=1784675417;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3vZlvJ9VSJNyVOtUpG/+wNqGmdqQiof1TsAOo30D1gc=;
        b=i5TBG0eIXsevZagDAcE2n8Bz1wDKBe0mG8iNsFwt2Tlrl3xYdJxWleFhmN/rZXr77n
         VFAJcMSNqGbl0bvn51K5hJmNor/fcDm1C1Lj+v0ZFL08Fwhbg8mxiHaRl0pCZyvnzju1
         eC+W6siJOzNunmeMhZM7mcKFZ3qbz06a3IN59wNBtdSXm+S4bpn0ZFwhTL5+eKwe+s/2
         lMgGbaCoYugZRyQa3UGIjF2nui4VGxjNUfL+5vQ4IMWM9ABQVCymUdPdWc/7J3Qb/30K
         0D2sjOXlY5OXN6z3BaHjduUYUA9F3qapH7LyH/bAmRfb7cIHesleGvmPzPQAfQ12UAmL
         IwBA==
X-Gm-Message-State: AOJu0Yyq1vWE4bNpi2q3nYAvvIhj2YN3DqUQLuzzHpzN7vfOXOK8tdaW
	QFg1jU+dftma6XMtSIhxLs3QoUh/jdZO2HtBE7CkXhB8ZJb/l2SiLO0AWNJe2YQ77Qtyr2F6nAt
	VF5Zvow==
X-Received: from plbje17.prod.google.com ([2002:a17:903:2651:b0:2cc:7505:b7b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c1:b0:2c7:f12d:5d37
 with SMTP id d9443c01a7336-2ce9ec11ca6mr150359205ad.17.1784070616760; Tue, 14
 Jul 2026 16:10:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 16:10:08 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714231015.3337831-1-seanjc@google.com>
Subject: [PATCH v5 0/7] KVM: guest_memfd: reclaim()/convert() cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

These are the cleanups from the SNP VMSA series.  I kept it as v5 to maintain
the paper trail.

Rework prepare()+invalidate() into convert()+reclaim(), and have the x86
backend use a single convert() flow for both (only SNP needs the hooks, and
for SNP, reclaim just means "make shared").  The goals are to eliminate the
misleading use of the term "invalidate", to drop a kvm_x86_ops callback, and to
prepare for in-place conversion, e.g. so that KVM ends up with something like:

	if (!to_private)
		kvm_gmem_make_shared(inode, start, end);

instead of a funky:

	if (!to_private)
		kvm_gmem_invalidate(inode, start, end);

v5
 - Drop the VMSA fixes (already applied).
 - Keep a dedicated reclaim() flow. [Fuad, Ackerley]
 - Pass a gfn, not a gpa, to convert() / reclaim(). [Ackerley]
 - Collect reviews. [Ackerley]
 - Align the gfn when folding __kvm_gmem_prepare_folio() into its caller. [Sashiko]
 
v4:
 - https://lore.kernel.org/all/20260709204948.1988414-1-seanjc@google.com

 - Collect reviews. [Mike, Ackerley]
 - Rework prepare()+invalidate() into a common convert() instead of simply
   renaming invalidate() to reclaim_memory(). [Ackerley]
 - Fix several (mostly benign) issues in the "prepare" flow.

v3:
 - https://lore.kernel.org/all/20260630222607.497895-1-seanjc@google.com
 - Ensure disabling quirks while the VM is live won't result in KVM skipping
   the back-half of "zap all fast". [Sashiko]
 - s/gmem_free_folio/gmem_reclaim_memory. [Ackerley]
 - Use {READ,WRITE}_ONCE() when accessing the guest's VMSA GPA outside of the
   per-vCPU mutex, and comment. [Sashiko]

v2:
 - https://lore.kernel.org/all/20260626231416.3943216-1-seanjc@google.com
 - Invalidate VMSAs if the memslot is DELETED or MOVED. [Sashiko]
 - Limit stable@ patches without a Fixes to 6.12+.

v1: https://lore.kernel.org/all/20260625222229.3367197-2-seanjc@google.com

Sean Christopherson (7):
  KVM: guest_memfd: Plumb the number of pages and max order into
    .invalidate()
  KVM: guest_memfd: Rename invalidate() arch hook to reclaim() and
    isolate it
  KVM: guest_memfd: Drop the redundant printk on arch gmem_prepare()
    failure
  KVM: guest_memfd: Fold __kvm_gmem_prepare_folio() into its sole caller
  KVM: guest_memfd: Explicitly pass number of pages to
    kvm_arch_gmem_prepare()
  KVM: x86: Combine .gmem_prepare()+.gmem_invalidate() into
    .gmem_convert()
  KVM: guest_memfd: Rework PREPARE config and hook into a more generic
    CONVERT

 arch/x86/include/asm/kvm-x86-ops.h |  5 ++--
 arch/x86/include/asm/kvm_host.h    |  6 ++--
 arch/x86/kvm/Kconfig               |  3 +-
 arch/x86/kvm/svm/sev.c             | 23 +++++++++++++--
 arch/x86/kvm/svm/svm.c             |  3 +-
 arch/x86/kvm/svm/svm.h             |  4 +--
 arch/x86/kvm/x86.c                 | 18 +++++++-----
 include/linux/kvm_host.h           | 10 +++++--
 virt/kvm/Kconfig                   |  6 +++-
 virt/kvm/guest_memfd.c             | 46 +++++++++++-------------------
 10 files changed, 70 insertions(+), 54 deletions(-)


base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
-- 
2.55.0.141.g00534a21ce-goog

