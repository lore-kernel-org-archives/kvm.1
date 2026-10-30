Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395274;
	b=2/aJYKwFyZNBGzwkpYdKbVoSLxLcf13zL7FfDxnG6f197tcFftNB1i/yA2sy8ggxSxfn
	 0eIO5hvkKEzPJb2uGtCDjyRxhZenu4sO/MG8GP76iUqx0LG46LetFvxelT321XhkqsIkY
	 l7QISq8gWrMaLF0M4e0moto8pwAfwtjjztYEmT4xjeI5KjGifsj+2QBtoA5MKnp/LX+YJ
	 PZIxksEb2dQ9iteFc99HyQA0F6EEnjEdlCuJRZRhpP/YMoDX5q26IOobyB1VUVhJI+MTH
	 FKEHBaNwzw8qKHSsV9ha4MVGIh6NyYbVR1iONj6uPMqNLdeyT1c+xd41WLHPMu0K5Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=9Z3EYYcj7DPzn99/aDJihGAHrZCLthA2ifb7uE3O3Dg=;
	b=T/5IeEfkzp6krJQ7DWOL7dI/BG5hNKlmxwfhBh+Pje9JrEWgPUK6UQFcfR7SOAUcnUpm
	 /rwYmgprylUCw79EfIEWjfU1L21uiNDi6vI7oKl7wmii1TfKNGcOOEeWkW/cmwUKCiXM1
	 4BIUahWHrrXVRB2HQ9AfX751LjNaf1/0QfKtiSUNm/hKWIiSoyjgZoAt6NwLpMb7siUbs
	 OBUBGIOfbMaID8tlNkZaPtHKVUkw+qqXjy+i2lfWVNJx5pZnxjb16WxNrGqmK1eCA3GYR
	 YrQIzbPJhSyjN3eOgzEELeH1n5BlBpKBn2jH4YGx+5SJ/66Kd6ufodVrEQxJUi5pxpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I4mab3zr;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD0F606A323
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD0F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I4mab3zr
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae1d132d52so1024093a91.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395273; x=1794000073; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Z3EYYcj7DPzn99/aDJihGAHrZCLthA2ifb7uE3O3Dg=;
        b=I4mab3zrHcOd69wM7yzO4vi7/U4RddxMGljpEnMIIULDDtdo0fpzga+wwoc2IpLpk8
         89sfrydWnW2BVJAdC7sjUtTv37FJuhUk9iv+MrsU1Ya0QAucSgPv+Zky+z/+EA99qoB0
         6+mXS2O/Fm1fKbULOC6YeWEwyhptGIyGbmQDrUT6+xbQUckS25Kv80tFyss9M/FS95A4
         5o7psAc5ozyF2YQUlp4OraxHiYxlp/dzJvClyg2I7gMNbyUHxP5rWUyNpretpWCdJAuK
         Kzr6iKnB0tjExVW79waiOEIV/WpRlf8b61oOHsD+4CS+uBgH1FRe29ghzkB4CALeQ6YT
         YxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395273; x=1794000073;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9Z3EYYcj7DPzn99/aDJihGAHrZCLthA2ifb7uE3O3Dg=;
        b=HqmZvxGaojOSGZnwlSZECPX4mHZDNQTsL1ucmB0XBtxRlxg/SJXe23xScePmG4JOJs
         YdDzPY4qMjOU6CrxHOlOFeVHAsRyAtELvmFmU7aRoyxfGFV1XRQ232glys08xpm47C1E
         xjRmGguA4bnyaeHaRpIDbddqzb9+EDdm0WQ/paozh9eT/HlBcCsLpyXkukyETeDXwS/w
         ku8qCR8ue+0Bf0u601zUoZHLeNFjrAsPUZiO51SyeqGhOYVxCzVZJYg6Z69yM+kBlq/N
         awAmeUttctoTCPGiNXEokK+5k9qeJ6iVDvucXm8cg+a7SASp5YsuKrOWZt+oEd6ARGut
         ItcA==
X-Forwarded-Encrypted: i=1; AKwUvByYADww3rZkooVsfm69VWsjYJS2Ha8nszCVGh/wNBtwDg/TC4TBzfirkTCEUJPSabB9hnQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1TYOv2o5j4gWVQRambGfEBX0plh8vNVbnonBdOyPZFGXXhQST
	Zq6pvL7MwE8An1zKnxiowg5cnZAlQzeODyksxdcSwMmaQWubY/So5LkdCnB+iXf9o17k9ihh5va
	eOWlFDw==
X-Received: from plgx6.prod.google.com ([2002:a17:902:ec86:b0:2eb:4a7:306e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57cb:b0:3a8:c0cd:57f9
 with SMTP id 98e67ed59e1d1-3ae89744ca2mr2979645a91.25.1793395273224; Fri, 30
 Oct 2026 14:21:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:48 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-1-seanjc@google.com>
Subject: [PATCH v4 00/23] KVM: Fix+harden against bad uaccess using dying VM
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Stupid SMM.  Patches 1-3 need to go to 7.4, everything else can and should wait.

Fix a class of bugs (limited to nested VMX, as far as we know) where KVM can
corrupt an unrelated process' memory if KVM (attempts to) write to guest memory
during VM destruction.  Because current->mm usually isn't kvm->mm when a VM is
dying, e.g. because the associated kvm->mm process has already exited, writing
to what KVM thinks is guest memory will corrupt the current address space if
the associated userspace address happens to be writable in the victim.

Patch 1 is a blanket fix for the uaccess paths.  AFAIK, x86's nVMX is the only
path in KVM that screws up, but auditing kvm_arch_destroy_vm() proved to be
infeasible for a human (I didn't throw AI at it, yet...), and I can't think of
any downsides to going straight to a broader fix.

Patch 2 fixes the underlyihng nVMX bug where KVM absuses the architectural
nested VM-Exit flow when tearing down a vCPU, which has a truly absurd number
of problems.

Patch 3 fixes what I assume is a blatant PPC bug.  KVM PPC completely ignores
kvm_arch_flush_shadow_all(), i.e. AFAICT, doesn't tear down its page tables
when the owning process exits.  I don't have much confidence in the "fix", in
part because it seems impossible that such a blatant bug could have gone
unnoticed, but also because I went with a very naive approach of invoking
kvm_arch_flush_shadow_memslot() for each memslot.  The changelog is pretty
sparse, because I didn't know how to describe the issue byeond "this is
completely broken".

Patches 4-(I lost track and stopped caring) implement more agressive hardening
to nuke the memslots before calling kvm_arch_destroy_vm(), e.g. to guard
against writing to guest memory during kvm_arch_destroy_vm() without going
through uaccess.  The big pain in the ass is x86's SMM, or more specifically
x86's internal memslots colliding with SMM, where each internal memslot is
actual *two* internal memslots.  KVM currently uses a single VMA for both,
which means KVM can't automatically unmap the VMA when the memslot is freed
without relying on arbitrary ordering.  And there are several other bugs in
the related code.

Setting dummy memslots feels a little hacky, but kvm_arch_flush_shadow_all()
should have purged everything that effectively caches memslots, so it seems
like the right approach?

Patches after that add more hardening to detect KVM bugs (though the
uaccess+memslot changes earlier in the series should render any bugs benign).

The remaining patches double down on open coding nVMX's vCPU teardown by
tearing down the vCPU "as-is", instead of forcing a switch to L1 and then
doing teardown.  The forced switch is quite heinous, as it requires KVM to
*load* the vCPU when it's dying due to architectural constraints for active
VMCSes.  Not only is that gross, it was also papering over a bug (hopefully
just the one) where KVM was relying on the vCPU load for nested VMX to take
vCPUs off the posted interrupts wakeup list.

v4:
 - Fix the SMM+internal memslots issues. [Sashiko]
 - Massage the vt_vcpu_pi_remove_from_wakeup_list() WARN so that it isn't
   triggered if creating a vCPU fails. [Sashiko]
 - Use "unsigned long" instead of "int" for kvm_is_guest_access_ok() params.
   [James]
 - Collect reviews. [James]

v3:
 - Give up, and open code nVMX teardown. [Sashiko, syzbot, Chris]
 - Drop the nVMX hacks that were trying to fudge around the mass of nVMX
   teardown issues.
 - Free the VMA only for the non-SMM internal memslot. [Sashiko]
 - Use @len, not hardcoded PAGE_SIZE, in kvm_is_guest_access_ok(). [Sashiko]
 - Rip out the awful vCPU load code from nested_vmx_free_vcpu().
 - Collect James' reviews.

v2: https://lore.kernel.org/all/20261001202234.3794060-1-seanjc@google.com

v1: https://lore.kernel.org/all/20260908132838.2116068-1-jmattson@google.com

Sean Christopherson (23):
  KVM: Reject user accesses to guest memory if current->mm != kvm->mm
  KVM: nVMX: Don't force a full nested VM-Exit when destroying a vCPU
  KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
  KVM: x86: Drop dead check on an existing memslot not having any pages
  KVM: WARN and error out if memslot update encounters existing slot
    with no pages
  KVM: x86: Unmap VMAs for KVM-internal memslots when the memslot is
    freed
  KVM: x86: Delete non-SMM internal memslot if creating SMM memslot
    fails
  KVM: x86: Process all address spaces when deleting internal memslot
  KVM: x86: Re-queue APICv update request if inhibiting APIC access page
    fails
  KVM: x86: Map a separate VMA for each address space for internal
    memslots
  KVM: Disallow setting memslots when the VM is being destroyed
  KVM: Destroy memslots immediately after mmu_notifiers are unregistered
  KVM: WARN if KVM attempts to do guest-related uaccess with "wrong"
    process
  KVM: WARN and reject guest-based uaccess if VM is dying
  KVM: Pre-check uaccesses in KVM's APIs to read/write guest memory
  KVM: VMX: Explicility free vmcs01, not the current VMCS, in vCPU free
    paths
  KVM: nVMX: Don't explicitly VMCLEAR+free() vmcs01's shadow VMCS when
    freeing vCPU
  KVM: nVMX: Cancel the nested VMX Preemption Timer's hrtimer in
    free_nested()
  KVM: Add lockdep-only APIs to query and assert that a vCPU is
    unreachable
  KVM: VMX: Explicitly remove dying vCPUs from the PI wakeup list
  KVM: nVMX: Don't switch to vmcs01 when freeing a vCPU
  KVM: nVMX: Don't load+put the vCPU when freeing nested state for a
    dying vCPU
  KVM: x86: Rename __x86_set_memory_region() =>
    x86_set_internal_memslot()

 arch/powerpc/include/asm/kvm_host.h |   1 -
 arch/powerpc/kvm/powerpc.c          |  11 +++
 arch/x86/kvm/lapic.c                |  42 ++++++-----
 arch/x86/kvm/vmx/nested.c           |  69 ++++++++---------
 arch/x86/kvm/vmx/posted_intr.c      |  68 ++++++++++-------
 arch/x86/kvm/vmx/posted_intr.h      |   1 +
 arch/x86/kvm/vmx/sgx.c              |   2 +-
 arch/x86/kvm/vmx/vmx.c              |  31 ++++----
 arch/x86/kvm/x86.c                  | 110 +++++++++++++++-------------
 arch/x86/kvm/x86.h                  |   4 +-
 include/linux/kvm_host.h            |  45 +++++++++++-
 virt/kvm/kvm_main.c                 |  94 +++++++++++++++---------
 12 files changed, 298 insertions(+), 180 deletions(-)


base-commit: 7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
-- 
2.56.0.385.gac671c819a-goog

