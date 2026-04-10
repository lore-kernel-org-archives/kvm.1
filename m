Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07276399010
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865535; cv=none; b=arVu3Xeii/KwSHd9Qz5PYeXciRFgvuUoEqioQVp0I39ooLO+T48MNQ+STBPjYh6ZyNH9+R3QcxiRjiKIiNwQKY5J0e8TPyFbJu+mp2cl2TZG9ODIHkcW001oU5gBDGYsoRwfh2VAfCggpbRpHTy3k+Q3k1ccv1pXwygVWOzsoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865535; c=relaxed/simple;
	bh=ZUwRgoFmWNBFtx8dDggkvelicrkVSbCb2lcdTK9KKiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qwx/YDM6nJbTApHBNvefj1UWIzk6skkXWmc2KiAkiO+0ZGn+3A3nQE2zDP7HGf0OsSWHKn8zZVb1YJ7iOtciv/hqClTCavf9ZN+UDbMsenYHsyImbNqMek7bPRRy97/IW16eEvIGiWbWNfmHA+wRqZvFeFADkVpu+RpZQuQPd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tL5EIxzo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tL5EIxzo"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c79281bd14cso475433a12.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865532; x=1776470332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICyultdb977ZiEIpqh/ujxzZYvaC8ohmSfOnlbVLO98=;
        b=tL5EIxzowIWfhQxsDhX35bxlterZvvnzmkg5K6Fd9LG5ma4b0uRmdZp7oP1BZwFW8w
         cdD/dwrKueVXEqpNA5yH+gY9JQwW9hnTTJswaW4L+FScC7279zp9V3CA5Sf1alADkOcL
         359RrcI9lkM3s9qamIsn0aAmxRSvpfmcnSprne0sc1m9FwSMpKAXvXZfXKqNlz/yu0bT
         ZZg7uehkNkcrGQ7IcRvBRzlniczVAoofoTkyksCPPAELwZ7HYISvm830nnGWKI98CFpO
         KEDB0kFt26NnNR/F32kUu+UA2P9fPnn6xCXEIeEz/p0TVzF7h12MAFJspKttg9OJPJp0
         PxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865532; x=1776470332;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ICyultdb977ZiEIpqh/ujxzZYvaC8ohmSfOnlbVLO98=;
        b=jaypQG4JHoK4VCJtzD4ossYIl0qY4hZhMuWZ0YkAFtZN2nZoWorpKIv9QD73BoQ/KR
         tQZV3q1AemJvx+z55WOyNPe7vRA6zeMxu5UlCLTRcdTCININod0MTGyEyjvAw1mTSD/5
         RkIbHmmfDj6mMLdIQI9DXOji94O6JV6KpIvUf79hdq+K9Qfvf/4O9ODjh8nLNbfATeYK
         5o9BBeg57nxgR5ra0MHFqPv1QjLlLlwf77PvfuHyoPmxu8ffAX/w9JlgZzeGeIigqCzZ
         hEriOUfjlAtSVYpZYlD+2jJU8nDwsqEes+0IiDBySP14r6T2WblgPDfbgbE4rcwQizBx
         Ky/A==
X-Gm-Message-State: AOJu0Yz98nFpcJGbICyYESo6EfR1Cg1RQgiUZw32yH/MSCUmV1KdvwOS
	m9l7uJi2l74TjeG4waxT2Vn1OVwUvP3oFUYBq2nHEKmLIo65nE52p94l+nF3TDjMRVwKHP68QD0
	68DIxJQ==
X-Received: from pfbfb3.prod.google.com ([2002:a05:6a00:2d83:b0:82c:dc99:788c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f0b:b0:827:37ef:7322
 with SMTP id d2e1a72fcca58-82f0c132253mr5651025b3a.2.1775865532032; Fri, 10
 Apr 2026 16:58:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:27 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-9-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SVM+SEV changes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is the full set of SVM+SEV changes.  The end goal of the SEV changes, =
after
fixing a few fatal bugs, is to add a lockdep assertion to ensure that kvm->=
lock
is held when checking if the VM is an SEV+ guest.  This is at least the sec=
ond
fatal bug we've had due to SEV+ state being unwound on failure, and lack of
formal-ish rules makes it hard to reason about the safety of any related co=
de,
e.g. when reviewing new code.

This has a superficial (I can't even figure out why git treats it as a conf=
lict,
I think it's both deleting white space or something?) syntactic conflict wi=
th the
"vmxon" PULL request; just take this one.

There's a syntactic conflict with the "nested" PULL request (this is what I
see when merging the "nested" one first):

@@@ -870,8 -881,8 +886,8 @@@ void svm_enable_lbrv(struct kvm_vcpu *v
 =20
  static void __svm_disable_lbrv(struct kvm_vcpu *vcpu)
  {
-       KVM_BUG_ON(sev_es_guest(vcpu->kvm), vcpu->kvm);
+       KVM_BUG_ON(is_sev_es_guest(vcpu), vcpu->kvm);
 -      to_svm(vcpu)->vmcb->control.virt_ext &=3D ~LBR_CTL_ENABLE_MASK;
 +      to_svm(vcpu)->vmcb->control.misc_ctl2 &=3D ~SVM_MISC2_ENABLE_V_LBR;
  }

and a semantic conflict with kvm/master due to the CR8 interception fix:

diff --cc arch/x86/kvm/svm/avic.c
index 2885c5993ebc,7056c4891f93..adf211860949
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@@ -226,9 -237,6 +237,9 @@@ static void avic_deactivate_vmcb(struc
        vmcb->control.int_ctl &=3D ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
        vmcb->control.avic_physical_id &=3D ~AVIC_PHYSICAL_MAX_INDEX_MASK;
 =20
-       if (!sev_es_guest(svm->vcpu.kvm))
++      if (!is_sev_es_guest(&svm->vcpu))
 +              svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
 +
        /*
         * If running nested and the guest uses its own MSR bitmap, there
         * is no need to update L0's msr bitmap


The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808=
:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-7.1

for you to fetch changes up to bc0932cf9b9917e826871db947398aa2b62789b2:

  KVM: SEV: Goto an existing error label if charging misc_cg for an ASID fa=
ils (2026-04-09 12:00:24 -0700)

----------------------------------------------------------------
KVM SVM changes for 7.1

 - Fix and optimize IRQ window inhibit handling for AVIC (the tracking need=
s to
   be per-vCPU, e.g. so that KVM doesn't prematurely re-enable AVIC if mult=
iple
   vCPUs have to-be-injected IRQs).

 - Fix an undefined behavior warning where a crafty userspace can read the
   "avic" module param before it's fully initialized.

 - Fix a (likely benign) bug in the "OS-visible workarounds" handling, wher=
e
   KVM could clobber state when enabling virtualization on multiple CPUs in
   parallel, and clean up and optimize the code.

 - Drop a WARN in KVM_MEMORY_ENCRYPT_REG_REGION where KVM complains about a
   "too large" size based purely on user input, and clean up and harden the
   related pinning code.

 - Disallow synchronizing a VMSA of an already-launched/encrypted vCPU, as
   doing so for an SNP guest will trigger an RMP violation #PF and crash th=
e
   host.

 - Protect all of sev_mem_enc_register_region() with kvm->lock to ensure
   sev_guest() is stable for the entire of the function.

 - Lock all vCPUs when synchronizing VMSAs for SNP guests to ensure the VMS=
A
   page isn't actively being used.

 - Overhaul KVM's APIs for detecting SEV+ guests so that VM-scoped queries =
are
   required to hold kvm->lock (KVM has had multiple bugs due "is SEV?" chec=
ks
   becoming stale), enforced by lockdep.  Add and use vCPU-scoped APIs when
   possible/appropriate, as all checks that originate from a vCPU are
   guaranteed to be stable.

 - Convert a pile of kvm->lock SEV code to guard().

----------------------------------------------------------------
Carlos L=C3=B3pez (5):
      KVM: SEV: use mutex guard in snp_launch_update()
      KVM: SEV: use mutex guard in sev_mem_enc_ioctl()
      KVM: SEV: use mutex guard in sev_mem_enc_unregister_region()
      KVM: SEV: use mutex guard in snp_handle_guest_req()
      KVM: SVM: Move lock-protected allocation of SEV ASID into a separate =
helper

Gal Pressman (1):
      KVM: SVM: Fix UBSAN warning when reading avic parameter

Li RongQing (1):
      KVM: SVM: Mark module parameters as __ro_after_init for security and =
performance

Sean Christopherson (30):
      KVM: SVM: Fix clearing IRQ window inhibit with nested guests
      KVM: SVM: Fix IRQ window inhibit handling across multiple vCPUs
      KVM: SVM: Optimize IRQ window inhibit handling
      KVM: Isolate apicv_update_lock and apicv_nr_irq_window_req in a cache=
line
      KVM: SVM: Serialize updates to global OS-Visible Workarounds variable=
s
      KVM: SVM: Skip OSVW MSR reads if KVM is treating all errata as presen=
t
      KVM: SVM: Extract OS-visible workarounds setup to helper function
      KVM: SVM: Skip OSVW variable updates if current CPU's errata are a su=
bset
      KVM: SVM: Skip OSVW MSR reads if current CPU doesn't support the feat=
ure
      KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
      KVM: SEV: Drop useless sanity checks in sev_mem_enc_register_region()
      KVM: SEV: Disallow pinning more pages than exist in the system
      KVM: SEV: Use PFN_DOWN() to simplify "number of pages" math when pinn=
ing memory
      KVM: SEV: Use kvzalloc_objs() when pinning userpages
      KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in SEV-ES mi=
grate test
      KVM: SEV: Reject attempts to sync VMSA of an already-launched/encrypt=
ed vCPU
      KVM: SEV: Protect *all* of sev_mem_enc_register_region() with kvm->lo=
ck
      KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively being created
      KVM: SEV: Lock all vCPUs when synchronzing VMSAs for SNP launch finis=
h
      KVM: SEV: Lock all vCPUs for the duration of SEV-ES VMSA synchronizat=
ion
      KVM: SEV: Provide vCPU-scoped accessors for detecting SEV+ guests
      KVM: SEV: Add quad-underscore version of VM-scoped APIs to detect SEV=
+ guests
      KVM: SEV: Document the SEV-ES check when querying SMM support as "saf=
e"
      KVM: SEV: Move standard VM-scoped helpers to detect SEV+ guests to se=
v.c
      KVM: SEV: Move SEV-specific VM initialization to sev.c
      KVM: SEV: WARN on unhandled VM type when initializing VM
      KVM: SEV: Hide "struct kvm_sev_info" behind CONFIG_KVM_AMD_SEV=3Dy
      KVM: SEV: Document that checking for SEV+ guests when reclaiming memo=
ry is "safe"
      KVM: SEV: Assert that kvm->lock is held when querying SEV+ support
      KVM: SEV: Goto an existing error label if charging misc_cg for an ASI=
D fails

 arch/x86/include/asm/kvm_host.h                    |  29 +-
 arch/x86/kvm/svm/avic.c                            |  17 +-
 arch/x86/kvm/svm/sev.c                             | 374 ++++++++++++-----=
----
 arch/x86/kvm/svm/svm.c                             | 270 ++++++++-------
 arch/x86/kvm/svm/svm.h                             |  37 +-
 arch/x86/kvm/x86.c                                 |  45 ++-
 include/linux/kvm_host.h                           |   7 +
 .../testing/selftests/kvm/x86/sev_migrate_tests.c  |   2 -
 8 files changed, 487 insertions(+), 294 deletions(-)
