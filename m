Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168802C326D
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588630; cv=none; b=S5NKcRsAXy/e9RioV27a0nr3vlNKiOCfQlok3TqaVOj7GhBT/Td7UhvFJPCiYHma2Nszrr1rLLcXxlWkNcH4bpJSitt9y5VAsOnINIBQ3L/nZpfRw6sjp6APDvUDEkPfkdbWw3fsoip7IWAK2dmP8KY8pIN2rLImHh3Qob+d9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588630; c=relaxed/simple;
	bh=B6vTGJX8XqLDMDvWuiFoUQVcggMrFFoKMMglULgm3aA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pf76Y0PmvfG+DN192Ge7Cm93DyUthGM3c1ikvQh71GQlsu+73W4gP8wA4AcOLGFu0hwtYFPe6LsgHglkrQr+wKG4tQ9ev2PvpqKkgjGQcIiwB0BbKpeZO/YgwzBu/qU7cqynxpfwcuOSGC2ZQXMWIX+tM84mYpe6+TUq/YYjlEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/pMcc4j; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/pMcc4j"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76fff22e60so1218579a12.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775588627; x=1776193427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AkHcLNs6zvk1R2rcUOxJyHrLMlv8O0GG57PC9/Sq+uM=;
        b=R/pMcc4j5iVNiWwGrQNsWStu/Chy5qLBFuPx8dBJgp/U/yyWp1QK0kFUeinh4KhPDR
         MtR6aDDgyNZfszAYa3Pq4u4FbVfI3rQVUxMh/u9E+W9SBmNZBBby94h7Yc/A6RcguebC
         WwpMAhbG1+G/8B2EZDdg4nbLbaJmxEeEvYaoye0EoFh4fsvv0+w70+nwPQeYYTgMJiwP
         q28dLvRetTwJXiJmviuMOVTmURLtyA0Laxu9gkQzYXScRLwZ8z4YZzOsOyuFiXwfbuiX
         ZJ2bOQIxebriVEX+6ykN/CMI1pzLr/EHgic7d0GYVojX5Yc3yUZY/GD4PjixxKsXoOSo
         vAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588627; x=1776193427;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkHcLNs6zvk1R2rcUOxJyHrLMlv8O0GG57PC9/Sq+uM=;
        b=ia79tP4P/VMMBubDstH5Eh51zmvOLU/CitFk9/ZXRxCWM/XV/jZyD2xL3cn9GFGFYN
         Gw470VMpsxokAUIiUdOzq88k3WzlYtz/i5dSx6L7edQ8f21xErs0B1ofsxRi5cCk1MRI
         +KiB3Th3o2ak82wx1yOVFQBxt8zPVZNedTgBmrR64kvP4QwutDscZxeqbzizY/ioJwJR
         c2H4icmWgRY5mabHxIxx6l8mWCwGbcnonxj/VIc/v1mAZ6fT0eDnNGJg7x9KbOftKdDB
         QNj3alfhQC8cAxzgTqonqHhobWRydV9vLz4UIWueTO9Pi8PUo/SDxVgp4L9Gj7dh3+Ln
         9ZpA==
X-Forwarded-Encrypted: i=1; AJvYcCXbeHdu+u9FtrmpkqO83Z+olrGeRZfxlQMv4INHQE7gSLNA7pDVraRSO/8j2INridWl7F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kNLOpiJFeVpjFrrTdM5YW2ydHoddAZb6XRiLz0oLTTdYIqIV
	ZxBm2ErrT8e53xvsHHoTAdInB+iPpdvsGY6VCr+E4HRp3LLM8Vj11PvazRn9E37oD74p/Ylvd95
	q6Ndrc+W/cq0PHg==
X-Received: from pfbem11.prod.google.com ([2002:a05:6a00:374b:b0:82c:d86b:4a7d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3306:b0:82a:805a:7cc with SMTP id d2e1a72fcca58-82d0da4fe00mr16318596b3a.4.1775588627185;
 Tue, 07 Apr 2026 12:03:47 -0700 (PDT)
Date: Tue,  7 Apr 2026 12:03:23 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407190343.325299-1-jmattson@google.com>
Subject: [PATCH v8 0/8] KVM: x86: nSVM: Improve PAT virtualization
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
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
v7: https://lore.kernel.org/kvm/20260327234023.2659476-1-jmattson@google.com/

  v7 -> v8:
* Indentation changes to conform to Sean's aesthetic [Sean]
* Updated comment in svm_pat_accesses_gpat() [Sean]
* Restored the common behavior for get/set IA32_PAT [Sean]
* Reordered declarations in svm_set_nested_state() for ASCII art [Sean]
* Dropped the selftest [Sean]

Jim Mattson (8):
  KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
  KVM: x86: nSVM: Clear VMCB_NPT clean bit when updating hPAT from guest
    mode
  KVM: x86: nSVM: Cache and validate vmcb12 g_pat
  KVM: x86: nSVM: Set vmcb02.g_pat correctly for nested NPT
  KVM: x86: nSVM: Redirect IA32_PAT accesses to either hPAT or gPAT
  KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
  KVM: Documentation: document KVM_{GET,SET}_NESTED_STATE for SVM
  KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE

 Documentation/virt/kvm/api.rst  | 26 ++++++++++++++
 arch/x86/include/asm/kvm_host.h |  3 +-
 arch/x86/include/uapi/asm/kvm.h |  2 ++
 arch/x86/kvm/svm/nested.c       | 64 ++++++++++++++++++++++++---------
 arch/x86/kvm/svm/svm.c          | 41 +++++++++++++++++----
 arch/x86/kvm/svm/svm.h          | 18 +++++++++-
 6 files changed, 130 insertions(+), 24 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

