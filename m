Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88C400E1A
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570332; cv=none; b=Ry4+r+bllrcB6sL+MheEDwwpVGI6QOxzGD8r5JOxHYPZDnBrP03/Yb80ois4z05r0Nc+fZ4G+diGPhQ6oK6kMa4S/P9DXmk4SJBrzQAS1zEiN/o+ty8Bv/fd7p/1Wo1Ii0KL8jB5TYo+eDMaIFbMQbpZxvS7012PyY7hd33Ypjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570332; c=relaxed/simple;
	bh=rEj+MrH4Lp0YV7pHrXfPro581Yt4MojO4YZiz52yvn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mn1pS5t1lqlTL07oyaDgHOEvgc251PcvAcjZlHoG2vtNLjtfdakQncwt+KhX1hzeJWyBhvu6vNB8IQG+2YseyTRnU0BIcKYWNh79udcu7nGqbFRwL1HB037BnB1B960zJt0+OxhA/Wv0u05anRdL7H3z0WQkkgrfLJzB0VTo+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yl0Fzlhc; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yl0Fzlhc"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so162617a91.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570330; x=1787175130; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TeIYWn7gjY6tiQvzqA0pDdLaRhbsPjFnxMbQwbw7xaI=;
        b=Yl0FzlhcOzf1YyRf/Wd+KgEtduF0OtJ+SBF70pDOY72tPUv27Wqwwyuu3QyIzEs5K2
         gW8/peiaL8RiHWc2Fecz4bSILQBZOSTUmttAXiV38kzu8VojSWaGT05poX3bkiHS4H21
         JxsZ76nDg5FsYbcHFNWJQ/u3NssJf/UZAFeAKDXwPO6c3EahCYOCxoL/J/C3ScQrZxJQ
         2vIMvoMT7BLVgFM8fUUtSNlOXW6YXGwxImQmpj8c44CXpprHs9eKtX1dr8vb6BWD0q4h
         ppSwYXICRHUmZZldFt6kwR8ymFlHw1I5EilLKZujjHSxmGZD76O5dm8yGiLpLXV/iEMg
         7l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570330; x=1787175130;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TeIYWn7gjY6tiQvzqA0pDdLaRhbsPjFnxMbQwbw7xaI=;
        b=lLAkM1L64M2tQZ7ra+Gk8BMPaSJ8xehbCpLDV/bWTCkhHOJ23vZkiEBNw2YqN/yf9T
         f6OAZDoFfCz5beK0JiKxdsfT7i4BwH6/Z2oE5clFyp9Y4Dd6/yDv0+ch8Xiw7CZhR2O3
         mcdCpzYSjeISczT/IzHFq0yfcn2MllMO6lo+ghH0zOKvnOnybgxWbw5KZJk/aHgxzgN/
         erEqPS2ovrDZVSco2aHyf9ymk53Xc0r2WLaOTqgkW5z89ZzQsRYSz5Ta2dBeYIdqtJtw
         q93/YeXDPdS32XJeCXdAeLLclIRDR7EYSbfIq/1Gxx8G6D5t24G5MFGI6FPgEPfn4jL1
         Q/bw==
X-Gm-Message-State: AOJu0Yzm/Y5u+dtJss/C7OjcJICIJ9od89u7j1pXw9z3JygcpriIQlST
	cChTo4gOmp23GGO+xP/wa67MUBej2VkNvrakuC5b5nsYHE6dU+eub7fcON/Ssbx8ZzQ57Obybfk
	3B0clQQ==
X-Received: from pjpq3.prod.google.com ([2002:a17:90a:a003:b0:38e:c91c:3667])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2688:b0:392:e5b1:d833
 with SMTP id 98e67ed59e1d1-3931e25e5f9mr1448335a91.13.1786570330386; Wed, 12
 Aug 2026 14:32:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:31:57 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-3-seanjc@google.com>
Subject: [GIT PULL] KVM: guest_memfd and x86 CoCo changes for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix the SNP VMSA PUNCH_HOLE bug, and prepare guest_memfd for in-place
conversion.  Regarding in-place conversion, my goal is to get it applied very
soon after 7.3-rc1, and then get you a pull request by -rc3 or -rc4.  I think
we're past the functional issues phase and fully into bikeshedding, so fingers
crossed.

The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f370:

  Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-coco-7.3

for you to fetch changes up to 2abcdf03fda1380bcbe00417b9ce2b4afb30899b:

  KVM: guest_memfd: Make private exactly what can be mapped on page fault (2026-07-27 09:43:44 -0700)

----------------------------------------------------------------
KVM guest_memfd and x86 CoCo changes for 7.3

 - Forcefully invalidate SNP VMSA pages if their backing guest_memfd page is
   zapped/invalidated, e.g. due to a PUNCH_HOLE in response to a Page-State
   Change request.

 - Rework the so called "prepare" and "invalidate" guest_memfd hooks to prepare
   for in-place private<=>shared conversion, and clean up a few warts along the
   way.

----------------------------------------------------------------
Ackerley Tng (1):
      KVM: guest_memfd: Only "prepare" folios for private pages

Sean Christopherson (20):
      KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests
      KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
      KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
      KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if CONFIG_KVM_AMD_SEV=y
      KVM: x86: Serialize writes to disabled_quirks using kvm->lock
      KVM: x86: Ensure runtime reads of disabled_quirks are resolved once
      KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
      KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves
      KVM: x86/mmu: Use split "zap all fast" helpers when invalidating memslot
      KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped
      KVM: SEV: Mark vCPU has having guest-provided VMSA even if its invalid
      KVM: x86: Guard .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE=y
      KVM: guest_memfd: Pass the number of pages instead of the end pfn into .invalidate()
      KVM: guest_memfd: Rename invalidate() arch hook to reclaim() and isolate it
      KVM: x86: Rename kvm_x86_ops' gmem_invalidate() to gmem_make_shared()
      KVM: guest_memfd: Drop the redundant printk on arch gmem_prepare() failure
      KVM: guest_memfd: Add helpers to query SHARED vs. PRIVATE for a given page
      KVM: guest_memfd: Rename prepare() hook and Kconfig to make_private() / CONVERT
      KVM: guest_memfd: Explicitly pass number of pages to make_private() hook
      KVM: guest_memfd: Make private exactly what can be mapped on page fault

 arch/x86/include/asm/kvm-x86-ops.h |  12 ++-
 arch/x86/include/asm/kvm_host.h    |  15 ++-
 arch/x86/kvm/Kconfig               |   3 +-
 arch/x86/kvm/mmu/mmu.c             |  74 ++++++++------
 arch/x86/kvm/svm/sev.c             | 197 +++++++++++++++++++++++++------------
 arch/x86/kvm/svm/svm.c             |  10 +-
 arch/x86/kvm/svm/svm.h             |  19 ++--
 arch/x86/kvm/x86.c                 |  25 +++--
 arch/x86/kvm/x86.h                 |   2 +-
 include/linux/kvm_host.h           |  11 ++-
 virt/kvm/Kconfig                   |   6 +-
 virt/kvm/guest_memfd.c             |  72 ++++----------
 12 files changed, 269 insertions(+), 177 deletions(-)
