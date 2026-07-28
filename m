Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99A224AFA
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199435; cv=none; b=oEF25KzS4NwFSYZPhJ+1FkvpOxuu46aAjTMrVnxP71LuWAOrj4f7+bWXupfMRwSsFB5ccAI1mU1XSs8Zwc34nFRV7VgcRPscE0POhiM6i8me9+6DjNkFWZjw/BFjeLIcfU2mi1UaKrYeeGCjWAkz1KCJEhAfRE0VY8rsINbEaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199435; c=relaxed/simple;
	bh=Do24KOSgHy/zD2Q1f6gGWrXDl3Dz3aVRlC2BD25fSE4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IpfehwhHO4ZRxK4AJgtL6UYiIyBeUtaiTjBWfIAmfUEDrQNnfsN2TOL3q1UQAvb1APUNHm5CB+1hUj31+me55dWn26eRQYhbACbEe5LYFNGbsUPv7xJjSBdOjNF5ovn9il8dIlRbCXGd9jQfu7GgfxfOgcj0d+y0qcLZQuZlhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSyndCUQ; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSyndCUQ"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccd1958e8fso45054615ad.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785199433; x=1785804233; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8NSeQojaPK9D5VUZ36qpU3WFDgkSN/KL2Zh1SU3UqOE=;
        b=iSyndCUQ+DyqhWQbABVZ2Ccgnn3NIgRELrn3AJ1bK/QvrB6Bf0Z78l1iNqxTLnnxjn
         DLGWzgDvTQdG9Hm/x7vFftYSS+acz39VKV+X8qqjjuHkKccWBf0Tl9Hg4v2bbobEo1Vs
         ZkkjAodjxQmYUjGTVAY/57TSYygNd6vVhLmHB0li2VnpKWOEhhKjdg94gmHILrhyHcS4
         LoUwLyzmf5ap8yEt60M9H3FdezMgVfSw+3aMpigosQPwXqYSsVf+9mCjXfsRU9PyRzZ6
         Ra2PpUaj2BX7AF3HyvUrlcOjNtke8lc8VjWLc05FuYuGOL+xtQwtN63+PDyM9PcSn7HD
         zJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199433; x=1785804233;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8NSeQojaPK9D5VUZ36qpU3WFDgkSN/KL2Zh1SU3UqOE=;
        b=OqHxQQ38s+MCB0KCmSIxAG9GWuiyIMaco1m/xis5ffx9bp/GfZUjpoLjgpMJapepXa
         sPpJo3riPmiRDB4RZl8hbzAIRRX+AG9vX7cZK9mo3W7g6X1yMwx+le+1n7wE2NpkT/k1
         EJ3ngUYzdOXBAplLeu0pt5eVt8bS+m1f7SOK0rTN5tj/aycoQWyZqy/YuzZkZ6vuehpO
         jOOyWD2PfhR3NyBD5+y6l2M+t3Mi+/ZrS4O6vmMwfLotewdBaHSwH3X1AcVgbsAGFfxj
         AzjFR3Q6ov830GFQHC+La4mhXL7ZexK9th9tfOjg1EGUVDEK7NHeIwKcMmaZhGsbDkv8
         Qb8A==
X-Gm-Message-State: AOJu0Yz+R5Eb2y9G66Au+upwiu01G1Z7wS59q0RyWXTCsQfvvLeQ+hga
	KX1caqXr4XtSHKLxKgd/G2WaJNZXYAs+NMseb7TFd5kT3puHoNZmPPamGrkWwQ1FWdU8VE3xvk3
	OtmSe4A==
X-Received: from plha15.prod.google.com ([2002:a17:902:eccf:b0:2bc:c295:bdd2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f709:b0:2b2:67ca:5ff9
 with SMTP id d9443c01a7336-2d015902adfmr2734955ad.0.1785199433058; Mon, 27
 Jul 2026 17:43:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:43:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728004351.887076-1-seanjc@google.com>
Subject: [PATCH v4 0/6] KVM: nVMX: Synthesize SHUTDOWN on RSM with bad state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

Synthesize SHUTDOWN if invalid guest state is detected a RSM, i.e. if SMRAM
is clobbered by L1 (or host userspace) while handling an SMI that occurred
while L2 was active.  This fixes yet another case of syzkaller tripping KVM's
sanity check that KVM doesn't cancel a pending nested VM-Enter.

Hao, can you provide your Signed-off-by for the selftest, assuming it looks
good to you?  Thanks!

v4:
 - Synthesize SHUTDOWN instead of trying to suppress the KVM_BUG_ON().
 - Add a selftest.

v3:
 - https://lore.kernel.org/all/al8M4gCwsWXS_jMs@192.168.1.215
 - Retain KVM_NESTED_RUN_PENDING_UNTRUSTED until after
   sync_vmcs02_to_vmcs12(), to avoid saving VMCS12 fields that are valid
   only after L2 has actually run.
 - Clear the untrusted pending state before restoring L1 state to avoid
   leaking nested_run_pending into L1 and blocking event injection.
 - Clarify the VMX pending-run BUG comment and update the changelog.
 - Tested with the syzkaller repro on the fixed kernel, no WARNING/KVM_BUG
   in the repro log

v2:
 - https://lore.kernel.org/all/al8M4gCwsWXS_jMs@192.168.1.215
 - Mark nested state restored by RSM from SMRAM as KVM_NESTED_RUN_PENDING_UNTRUSTED.
 - Keep the BUG check in __vmx_handle_exit(), but make it apply only to KVM_NESTED_RUN_PENDING.

v1: https://lore.kernel.org/all/al3Qbq-jUYE-_72N@192.168.1.215

Hao Zhang (1):
  KVM: selftests: Extend the invalid nVMX guest state test to cover RSM

Sean Christopherson (5):
  KVM: x86: Extract VMX's unhandleable emulation check to common x86
  KVM: nVMX: Synthesize SHUTDOWN on RSM if L2 requires emulation
  KVM: x86: Rework kvm_x86_ops.vcpu_pre_run() into
    .vcpu_needs_initialization()
  KVM: selftests: Use port 0x80 in invalid nVMX guest state test
  KVM: selftests: Refactor invalid nVMX state test to prepare for RSM
    testcase

 arch/x86/include/asm/kvm-x86-ops.h            |   3 +-
 arch/x86/include/asm/kvm_host.h               |   4 +-
 arch/x86/kvm/smm.c                            |   4 +
 arch/x86/kvm/svm/sev.c                        |   5 +
 arch/x86/kvm/svm/svm.c                        |  12 +-
 arch/x86/kvm/svm/svm.h                        |   1 +
 arch/x86/kvm/vmx/main.c                       |  21 +++-
 arch/x86/kvm/vmx/tdx.c                        |   9 +-
 arch/x86/kvm/vmx/vmx.c                        |  12 +-
 arch/x86/kvm/vmx/x86_ops.h                    |   4 +-
 arch/x86/kvm/x86.c                            |  10 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c  | 118 ++++++++++++++----
 12 files changed, 143 insertions(+), 60 deletions(-)


base-commit: 271255273d5ff348fe29d89fe4712b2f7f7907c3
-- 
2.55.0.229.g6434b31f56-goog

