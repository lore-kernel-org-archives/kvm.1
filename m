Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCB4503E9
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519225; cv=none; b=AJH4k+S/J7TZ2AafKITUjt2UjpfPxrRRsy3KtqY5MxG1nZ6aowe7Es3Z72y1M772gNrhwmdDXdlSACaEGr3/nW+dg5/41h3BH9YttdttJ8uNPA8gWSFdQfeitSykO34DlgyDgHAPa5XSlO7FBXbfLk2HiFAnh9hYvrw/ddfvJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519225; c=relaxed/simple;
	bh=fo7z9S8SOo9dnAFtQsFui/smGCWz23XnnYavOZf0pZw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UHPvF6BOPRn6JazDsmbisZ7TFWVx7LwRIg7o6lhnIKpwNjAFfEy2dFUpCC4YsPknGjoDiEx0Us/UtCe16agqI7s7PVKWpGORBZWuhWz+r8rU3wpX1t+REQHXx5bwbKUeCy6F9TwDB7/PSvt/I2XNbd0h+s50/BJbKskeOIalhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlFuBI6R; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlFuBI6R"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a3514f912so2174123b3a.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519222; x=1786124022; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGasoY6Uw4p9N2MLpVzeR0l5PfoW7Gijd6iKw2iOUBU=;
        b=JlFuBI6RtHq3Sqm96QzL6faWSGg+zyf/uXlm1iq7+DD/mcU4wdGWt+2Jm5noJyFakS
         13V5XV5qMuDPdR6jT0wUenMjVh/RNlZsbAPkeJXIG8JqmoYfzwK3dT67r0SUqJjb7DYY
         5OqGAtzdR+RfpPCNc2Fap9mZ2Ayk8PuZdTJe7qRUMJAGMjV9PvrcSz0Dq0wh8KA465mj
         UhN58ndX3zvE1IkbXZdlNRoV+NWBU2utFc7z1xkakN4FvLoCL21bFRvtnB6x96lAMR/f
         gkDp8iYYotuEcz4CHj448+hswRzESxRJ7/8Uvwgy1qBTx2naXUNRfJUmmhq7tjseVLQM
         jafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519222; x=1786124022;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jGasoY6Uw4p9N2MLpVzeR0l5PfoW7Gijd6iKw2iOUBU=;
        b=Ry3S5STCuI/EwAlUN9ndtGb30A4ydGTydKrl/w1Dqd+pmLCSVS9UkrJ52SiCUYydEL
         E9jVgzkpjMMEfEJ/nybRtJLwPQqzeVTstc4NDLrBd7ftrlYaKfgkrPxdYMkiZazuMTug
         Va+FQJozfMVXzs/H3DqCQw5AIJwa2GNE9l68135Y1x4jO6QupC5hx3d/vnc4GvY5K41/
         aUyfgEAvdF3p/VgKfle9y4tLR9ujNTSqIYPG4+pYnoBAdw1Erfgm3E90ZDYBYmFDc0Td
         M+lpVp4PDGuebQsPgevJHH6j7nfiGyP/hlPuzalNyhiQFLrsuifAZCbBMVhBbZ2QW5T0
         Tkkw==
X-Gm-Message-State: AOJu0Yx2BqTIW4LpUUtYtQsUL1F21lWn1dPN8zA79EbC1Lis6sBsGCG3
	kP6/vzAVLcwoNfFiA/uqt5/ZMlg/t7RyqB1XHhQK/K1F/ilatRWCpOKBKowsmlxFfwJGRVEKMbA
	v0mQkWA==
X-Received: from pgkb3.prod.google.com ([2002:a63:eb43:0:b0:c85:a528:228f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b43:b0:843:468d:7804
 with SMTP id d2e1a72fcca58-84ee4809403mr466113b3a.34.1785519222150; Fri, 31
 Jul 2026 10:33:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:33:34 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173340.2644656-1-seanjc@google.com>
Subject: [PATCH v5 0/6] KVM: nVMX: Synthesize SHUTDOWN on RSM with bad state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>
Content-Type: text/plain; charset="UTF-8"

Synthesize SHUTDOWN if invalid guest state is detected a RSM, i.e. if SMRAM
is clobbered by L1 (or host userspace) while handling an SMI that occurred
while L2 was active.  This fixes yet another case of syzkaller tripping KVM's
sanity check that KVM doesn't cancel a pending nested VM-Enter.

v5:
 - Fix goofs in patch 1. [Sashiko]
 - Print out correct target L1 vs. L2. [Sashiko]

v4:
 - https://lore.kernel.org/all/20260728004351.887076-1-seanjc@google.com
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


base-commit: 3c7d7f908d574277a845423ec32250a8d8df44c8
-- 
2.55.0.508.g3f0d502094-goog

