Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB71D5170
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654832; cv=none; b=E5srFuYtzUO6tMT/v0LdXKQJLAVChfHFo0jIp4LjJt4tNLZ0wQLrRetfYdC/yyFEveMvmeDbQQMbV3FHIQm0zHWTS8RIzmJYjO1WAQY3n87q8yfJ8u5Px6krib8e8BvWiyixn4YLQLnGMGQXjIp3Hy5xe0lI7M3/XbZ63JkHp/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654832; c=relaxed/simple;
	bh=4FR8NkwjT4N9Cl38asxnaaMOmXx8zBcfHSm8Jt++OCA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PgN0jqvH0vlr5Am36U7dKMDuXzXpz28WLr/69C6ARojXGPH9FuAuut7nioGN/r99vrbf+SX6b6hwAIuU04s+MWW/M6HxANmpwAh0l61bLZVOpTZjX+aFQq5udw4qXwLo29g/N8BYwT9WMMfEvtcZjmTV/Wcf/oSG62D/Q4gM2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dth4RtCG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dth4RtCG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35ba4bf54beso788198a91.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774654829; x=1775259629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oDu+7PRubEqgxgBdgHEhM+ua34473fu/ZlwKYYpVU28=;
        b=Dth4RtCGoxWwfxhPWh/oqSA8LiGeHud2rzlKCZ8ubXXV8C4gjIa+XI203Jxiv17ixD
         6XP19hjyKKW5pZ1XX77b1H4Q6HXm+B3TkDTOSDExwCJBxEBDK8RQmjuxDgkP8utCmZAW
         hAaF4qoZ0rHPjdP6HeDwGcHj9PspzDpZtwF9pxbIDFlh+ghPG+w4q6ga0k7nYSNuDsK4
         Xek2CaKPILICouqurbDU5ELIKssQa4MAeJG1kK6dn578oXTzSc69cvzzAXdir2lo9dc/
         5Jh3d+QaGr0ZFFQYKikr/Ps1gJ+XE6NUQ1unTmjpcMORZydqWMC8V/jqkxr7IZ9Kt/jZ
         w13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654829; x=1775259629;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDu+7PRubEqgxgBdgHEhM+ua34473fu/ZlwKYYpVU28=;
        b=nr68F7bXbW17RZM2N+Fy38TygM7umgLKL4tJ8nBFfh4N7ruErr1aBY2l33fUG2vf/0
         CBeD3A5OGx6fE67ZQAXiGdrGOPa1J+c4RD7CrEdY5vbPhV1OI3Cb5HJCfdPuVjTVdGZv
         OBSrZXRrCZRrcWuQ7IYCaO4uB6aTJWpOQoD2cBEIOsiJJUMMqIj4n7Mc2R0P/sTVLPx1
         TZLs7VcvI6I1iUvjcikR7Rab0N0ykHFknKfTj+fKleEsdcqSH4hEXZ2u1Vbe39k2DmO4
         db2LjP3WkUfgOgrDTTBXKeSSceg5NRJjTEGPMAalknWX37D0kZB1fiWDD8O/qo4JbWfx
         vPcw==
X-Forwarded-Encrypted: i=1; AJvYcCVAc5/xumRcK2PMbbkEW6OydpRLISAxNUcV12NZ/FH4lby58Zn+Ax8728AoNDMuynvhfRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyjb4VfdrtFndhZVvWiuQPz8SDB4/hZllwPNLkShelaUxWo+1p
	6OaOETN185rS+Jdb9o9TokyNK/7YWsm8pOox81hxJpvfpAQ7efbzPUEZ88brdXYl6madLy7mZ/h
	KIQ2CE6RSYN0RMw==
X-Received: from pjbfv14.prod.google.com ([2002:a17:90b:e8e:b0:35b:9a3b:1f36])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1642:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-35c2ffa8f44mr4438681a91.11.1774654828462;
 Fri, 27 Mar 2026 16:40:28 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:40:07 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327234023.2659476-1-jmattson@google.com>
Subject: [PATCH v7 0/9] KVM: x86: nSVM: Improve PAT virtualization
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, KVM's implementation of nested SVM treats the PAT MSR the same
way whether or not nested NPT is enabled: L1 and L2 share a single
PAT. However, the AMD APM specifies that when nested NPT is enabled, the host
(L1) and the guest (L2) should have independent PATs: hPAT for L1 and gPAT
for L2.

This patch series implements independent PATs for L1 and L2 when nested NPT
is enabled, but only when a new quirk, KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT,
is disabled. By default, the quirk is enabled, preserving KVM's legacy
behavior. When the quirk is disabled, KVM correctly virtualizes a separate
PAT register for L2, using the g_pat field in the VMCB.

Guest accesses to the IA32_PAT MSR are redirected to either hPAT or gPAT
depending on the current mode and whether nested NPT is enabled. All other
accesses, including userspace accesses via KVM_{GET,SET}_MSRS, continue to
reference hPAT. L2's gPAT is saved and restored via a new 'gpat' field in
kvm_svm_nested_state_hdr, which is within the existing padding of the header
to maintain ABI compatibility.

v1: https://lore.kernel.org/kvm/20260113003016.3511895-1-jmattson@google.com/
v2: https://lore.kernel.org/kvm/20260115232154.3021475-1-jmattson@google.com/
v3: https://lore.kernel.org/kvm/20260205214326.1029278-1-jmattson@google.com/
v4: https://lore.kernel.org/kvm/20260212155905.3448571-1-jmattson@google.com/
v5: https://lore.kernel.org/kvm/20260224005500.1471972-1-jmattson@google.com/
v6: https://lore.kernel.org/kvm/20260326174944.3820245-1-jmattson@google.com/

  v6 -> v7:
  * Drop the patch "KVM: x86: Remove common handling of MSR_IA32_CR_PAT,"
    because TDX still calls the common handler.
  * Instead, add a warning to the common PAT handling code if it is
    called by an SVM-capable vCPU
  * Add comments about userspace disabling the  quirk while a vCPU is
    running.
  * Cache the value of use_separate_l2_pat in KVM_SET_NESTED_STATE, in
    case the quirk is disabled concurrently with the execution of that
    function.

Jim Mattson (9):
  KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
  KVM: x86: nSVM: Clear VMCB_NPT clean bit when updating hPAT from guest
    mode
  KVM: x86: nSVM: Cache and validate vmcb12 g_pat
  KVM: x86: nSVM: Set vmcb02.g_pat correctly for nested NPT
  KVM: x86: nSVM: Redirect IA32_PAT accesses to either hPAT or gPAT
  KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
  KVM: Documentation: document KVM_{GET,SET}_NESTED_STATE for SVM
  KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
  KVM: selftests: nSVM: Add svm_nested_pat test

 Documentation/virt/kvm/api.rst                |  26 ++
 arch/x86/include/asm/kvm_host.h               |   3 +-
 arch/x86/include/uapi/asm/kvm.h               |   2 +
 arch/x86/kvm/svm/nested.c                     |  65 +++-
 arch/x86/kvm/svm/svm.c                        |  54 +++-
 arch/x86/kvm/svm/svm.h                        |  19 +-
 arch/x86/kvm/x86.c                            |   6 +
 tools/arch/x86/include/uapi/asm/kvm.h         |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c   | 304 ++++++++++++++++++
 10 files changed, 457 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c

base-commit: 3d6cdcc8883b5726513d245eef0e91cabfc397f7
-- 
2.53.0.1018.g2bb0e51243-goog
