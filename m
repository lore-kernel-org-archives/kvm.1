Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AD397E89
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547402; cv=none; b=fXNL1DCETEnf90He+o+LrUDZVmhs6+NENsJstMHk+ZIl3ivQdtqOt9NG18o5Osmafoc4pXzo+CzR1H7MLbZDBVx/ufLlxuktbL1qrtwlbJeAENTds8TlpUyuTK2jtinP+6BwkLMYN6kQBUR8Dao/phPAmdVTnCCDPcsYq3VGqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547402; c=relaxed/simple;
	bh=l8QKpcWhgVaRPMp0Grt7jMkGaRRUNYzD8ApjjeDSTM8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SqsYcofst2bzzP/eYJXPFZgQZ7eTOmdwBk+mcJ77IE7umDcox+Dgs3ujQtydpbqh+8lfvwyIWGDR6gqHqXayyskn2CIohzV7qDp2wcpfnull8tIGRnEdpSbjYX2O/OyDs1Xg4nMV8+4Y0NoSHJ98in2P2RmFN/lEsS4Z1WmOHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3RD1w10; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3RD1w10"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7423ba5342so2534525a12.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547399; x=1775152199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uhMNHLLPw8xzN2gryz51qIO039+o2PRpATjMLrZic2c=;
        b=N3RD1w105kIvebt6Dd0AyNI/u4mi+f0qS7OCl8Hh/7MLV5GIecxhTCIL+z3XfAzZiy
         GcMupOajg9Cqe15ULxi7OBcb7INWx4/2MFQmfeinwHBOwVYdMPiy3C9rb12wYEAeTiYZ
         GeI5DrzviB8Kv1dAKt8+OjsjcbrxkR5CkToX1ce8QIsi7pZwPEKazcy7dQVEuWV8PWan
         71+ds7r+UhPXHiGkan9O/nI+29uvz4IakTw579T5bRMhO0gvmzWcNG59+8/wh4cQNimV
         qlKrBFxQNVeOu7nRaWffM9PIi1wz2NMKVD3/Vr3j80NuO6fsEA3C0NKy5tW+dnVMnFXv
         nJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547399; x=1775152199;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhMNHLLPw8xzN2gryz51qIO039+o2PRpATjMLrZic2c=;
        b=l2zV/WieeREjp3BY8y91MyTIbqcGu09GcT7FBfGG0fD9+FzxhFIYBFGluSYcX9j7UV
         w+hpzz4aicr44ZqGu80yOPCztxGVhECylB6KuonRQ00q1JDaWzcI1yg5vGAj2Y67/LU0
         BC0CucDJOeXXdIfbQo/OTpYVctoWt0zqQ8KqInZc9bslh4OBdrCobitb1Bsn21x2SV4G
         w1N2+/vfL7IGdsJhrttiRb3lgKY8ZqF9xXRiufHJqtEC6+n71umQIIdnnL8Rt7AFKw7Z
         RLbOOXTnxEpPIUvyksrEs+/QWgmzZfBtoEAd4xtPRpl9UdUCxtRO5mK1bx2XzpAKMN7W
         9e+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAKw6RunZx2ft5yA0y4XiboFJe0/+VyytFigFkG+XDOn2671dJkRjS5xI8G9tu4AVf3A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwO2E5+nfg6Qn2Pkyz4bF1NIDMOuLPgpCKl8sXteRNEzZ7nJq0
	x90YpvfRUjpzOyBiSqQDj3THhpuw8UdCPE8xJHJ+6yKNOWl9vVLJHax3JHzOWeaTV5gzcfpZPUC
	2Vi0jOu7BbCBInw==
X-Received: from pgww8.prod.google.com ([2002:a05:6a02:2c88:b0:c76:6c38:1009])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3948:b0:39c:250:2db8 with SMTP id adf61e73a8af0-39c4ab915b5mr8993052637.17.1774547399236;
 Thu, 26 Mar 2026 10:49:59 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:49:18 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174944.3820245-1-jmattson@google.com>
Subject: [PATCH v6 00/10] KVM: x86: nSVM: Improve PAT virtualization
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

  v5 -> v6:
  * Drop the patch to remove vmcb_is_dirty() [already accepted]
  * Introduce a new x86 quirk, KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
  * Drop forward and backward compatibility. Save/restore across
    a quirk change is now the responsibility of userspace
  * Document the kvm_svm_nested_state_hdr change
  * Update the selftest to use the new quirk

Jim Mattson (10):
  KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
  KVM: x86: nSVM: Clear VMCB_NPT clean bit when updating hPAT from guest
    mode
  KVM: x86: nSVM: Cache and validate vmcb12 g_pat
  KVM: x86: nSVM: Set vmcb02.g_pat correctly for nested NPT
  KVM: x86: nSVM: Redirect IA32_PAT accesses to either hPAT or gPAT
  KVM: x86: Remove common handling of MSR_IA32_CR_PAT
  KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
  KVM: Documentation: document KVM_{GET,SET}_NESTED_STATE for SVM
  KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
  KVM: selftests: nSVM: Add svm_nested_pat test

 Documentation/virt/kvm/api.rst                |  26 ++
 arch/x86/include/asm/kvm_host.h               |   3 +-
 arch/x86/include/uapi/asm/kvm.h               |   2 +
 arch/x86/kvm/svm/nested.c                     |  55 +++-
 arch/x86/kvm/svm/svm.c                        |  54 +++-
 arch/x86/kvm/svm/svm.h                        |  15 +-
 arch/x86/kvm/vmx/vmx.c                        |   9 +-
 arch/x86/kvm/x86.c                            |   9 -
 tools/arch/x86/include/uapi/asm/kvm.h         |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c   | 304 ++++++++++++++++++
 11 files changed, 443 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c

base-commit: 3d6cdcc8883b5726513d245eef0e91cabfc397f7
-- 
2.53.0.1018.g2bb0e51243-goog

