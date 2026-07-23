Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4A3EF0DC
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840902; cv=none; b=HELXriS1UqGiXqEQYshXF9Tzdd542BanJq/tRnUxhslC9CiOu62ZFc/09ANLvJB0fVI+cvGhYF7nHgstZRexqaw9SWMemvfvp0t8If3LM3UlBUr23zMQ84uoCM5Xid0IYXcA9xALcPdK3SmDOERfx9a1OL2XcECLAU/5rvhn89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840902; c=relaxed/simple;
	bh=1/gvq+OLekmRwsEGzr3vC5u0db5zRvtFjM+5W0IssTw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cEoG4JamkI7V6dXXzJUBDXqTG12IPQ9h2SVNYWpmFjUUnp5x7GQ6LVT/GeldG+6NfPG31PVxN4NzAeaOmNwehu3Eq5rSFz+pwNqW/UUnqTSdwlKCUxoxSendg0m5WxfPYppzU7Kaipy6pljyygvCvjyT7SSLGBnVfwtM2uL31jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t20ZRoWW; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t20ZRoWW"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso1144501a91.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840892; x=1785445692; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vGZcB8o0pRvIKvfmoxU3/u8bc4tgPgdDY2N6HG7Pmws=;
        b=t20ZRoWWHwU1dYP4XaBjj4ANvk/dqx02zru+LHFQx+8KJSdUIaj2M7EmeU0NPXs+BQ
         t4sJlCzaQXv5N+o1Xqc/yhsGORI0++GgEVQHU8gVCkNL+QTPR711OTBP5B1kmryIYhei
         3e/+H9eTXSNKabjbPrT9KGlCeu1wHYc0oUAIRcT03x/I+i353nSQ+octjETjQ0Ogc98u
         mpcMtHsExpTAp4ago5R2q/LbIWhdfOqBW5Ddjcd4n1zep4qh4miDFeBJuORNeOqyLuXU
         LN817jDbZEeW2QbZHUDRfABy+vFyKDVahIgXycb/MBlWDBrsqkbu6j9X2BgBhFsVLzTw
         wuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840892; x=1785445692;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vGZcB8o0pRvIKvfmoxU3/u8bc4tgPgdDY2N6HG7Pmws=;
        b=ddIFcv02ed4jTU0ESeqqVY+M9kjE9T5o3+BEPSc6KjRdEYv/2xYYVv7tWIrHZTTUl/
         cOBrzKeM5Zpi39ChFj2drxMin4vanc/JRXIfQWNGycgEtcoCJa32JqV28c7K+TLVw7FP
         QhRUlvb88dk9bHDc3I2JwDrl3c2B3mBH5v0apLuLPKR1jSmXSDgICtEpHzYsUfieYr7W
         Z3sioGF5xrTI+DlhMDKgS+HuyLgnyJB83jl2+u2mpt2UjLTI/eSz89VQRlnKczgnpotk
         fDc41h9jt6lSnamymHJb8QiyD9VBhPbr/Q3YK2LKLwR4ox7X2UbNTaZaISKq4IiSEwdz
         9nhw==
X-Gm-Message-State: AOJu0YzNKkmJupQTiwqfJki8Nst3OU0cIJdNaKc8Hzp7VAj+ckE+t9Jd
	a90H8riAeQhtVBggk7hKtdUT8ar5MM3yNNs8/7KZzaGa+PSqi3m8tET0ula8pEy7zUq9VBKS95z
	tZALnOg==
X-Received: from pjqv24.prod.google.com ([2002:a17:90a:af18:b0:38e:bbd1:f3c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582e:b0:37f:9ce1:735e
 with SMTP id 98e67ed59e1d1-38ec65d29b4mr4727148a91.31.1784840892296; Thu, 23
 Jul 2026 14:08:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:02 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-1-seanjc@google.com>
Subject: [PATCH v6 0/9] KVM: guest_memfd: RECLAIM+CONVERT cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

These are the cleanups from the SNP VMSA series.  Well, that's how they started
out, now it's full into prep work for in-place conversion.  Oh well.

Rework prepare()+invalidate() into make_private()+reclaim(), with direct line
of sight to adding make_shared() for in-place conversion.  Have the x86 backend
use make_{private,shared} (no reclaim()) for SNP, as reclaim in SNP-land just
means "make shared".

The goals are to eliminate the misleading use of the term "invalidate", drop
the "prepare" terminology (which gets especially confusing with in-place
conversion), and in general to prepare for the future.  E.g. so that KVM ends
up with something like:

	if (!to_private)
		kvm_gmem_make_shared(inode, start, end);

instead of a funky:

	if (!to_private)
		kvm_gmem_invalidate(inode, start, end);

and

#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
	if (kvm_gmem_is_private_mem(file_inode(file), index))
		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
					       (kvm_pfn_t)1 << *max_order);
#endif

instead of the current bare:

	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);

We'll still need changes for things like TDX hugepage support, and obviously to
add kvm_arch_gmem_make_shared() for in-place conversion, but I think/hope this
sets the stage for SNP, TDX, and pKVM to build on the arch hooks without
needing to make non-trivial changes to the core semantics.

v6:
 - Provide separate make_{private,shared}() hooks instead of a single convert(),
   because forcing a single API just meant multiplexing on the front-end, and
   de-multiplexing on the back-end, along with weird sanity checks to enforce
   different requires for private vs. shared. [Ackerley]
 - Kill off per-folio preparation entirely. [Sashiko, because Sashiko kept
   finding bugs in my attemps to refactor the code, so I went scorched earth].
 - Pull in "Only "prepare" folios for private pages" from the in-place series
   to make it easier to kill of per-folio preparation.
 - Collect some reviews (dropped many since things got reworked, at lot).

v5
 - https://lore.kernel.org/all/20260714231015.3337831-1-seanjc@google.com
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

Ackerley Tng (1):
  KVM: guest_memfd: Only "prepare" folios for private pages

Sean Christopherson (8):
  KVM: guest_memfd: Pass the number of pages instead of the end pfn into
    .invalidate()
  KVM: guest_memfd: Rename invalidate() arch hook to reclaim() and
    isolate it
  KVM: x86: Rename kvm_x86_ops' gmem_invalidate() to gmem_make_shared()
  KVM: guest_memfd: Drop the redundant printk on arch gmem_prepare()
    failure
  KVM: guest_memfd: Add helpers to query SHARED vs. PRIVATE for a given
    page
  KVM: guest_memfd: Rename prepare() hook and Kconfig to make_private()
    / CONVERT
  KVM: guest_memfd: Explicitly pass number of pages to make_private()
    hook
  KVM: guest_memfd: Make private exactly what can be mapped on page
    fault

 arch/x86/include/asm/kvm-x86-ops.h |  8 ++--
 arch/x86/include/asm/kvm_host.h    |  9 ++--
 arch/x86/kvm/Kconfig               |  3 +-
 arch/x86/kvm/svm/sev.c             | 35 +++++++--------
 arch/x86/kvm/svm/svm.c             |  4 +-
 arch/x86/kvm/svm/svm.h             |  4 +-
 arch/x86/kvm/x86.c                 | 18 +++++---
 include/linux/kvm_host.h           | 10 +++--
 virt/kvm/Kconfig                   |  6 ++-
 virt/kvm/guest_memfd.c             | 68 +++++++-----------------------
 10 files changed, 71 insertions(+), 94 deletions(-)


base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
-- 
2.55.0.229.g6434b31f56-goog

