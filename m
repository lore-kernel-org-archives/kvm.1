Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533D35DA64
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483838; cv=none; b=JIy4aIo/MteCGPllNx/YP1VzFKmHfMCZyDxsID690RYxiYIulZnM6MymiPHJxQgCwgXSpGSJTN+HVh8f2fA2XFzSXAAvwdfGmTY29rMA3/qRt/kZEtTEOkKjRMXPOF8Y3lqwnYWHK40OAu7CLeInQ0FuvDfob6yS9qrOWMebDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483838; c=relaxed/simple;
	bh=sB5ja1hTvJ6hcTqcbO8S+itN3H8/xDjD8wQ5qsWLCg4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J/9P7iCw42nrmnDfoWvxZnq9p5qNriG1mn+uJop7IeIzLO4MgTJhVHzCWOKS3fSQMXJ5p2CWXLJ069bPXRMmUF2fIcVte3BQYYvDzIBpOiHigBOybXVCcBX56zRFt1BKpkaBZQ/CUcG8M7c+oS88snPWQcJfJRG2nvUAqc7cfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GenV9GMR; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GenV9GMR"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso846392a12.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788483835; x=1789088635; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g1/0D8PhzsqQbcuHEIiqrrUM/zjogKFZy1mLAKunYKo=;
        b=GenV9GMRARLeAtFpTGF62FizTDpF33NvTqrsOkzy17ig8BuYvl9nv6n3nLeD//s9JA
         nS58iOGE/GR306JrY9VnD26nWMV9+kLVCul4bbGuUivd3llFoZDOL7QYpZOCxmTn/22S
         URbAIr/fPd48Cpg0KtLAzwVPxSSL2ps7X22d0PJR0dPpHUzMORfUvbuh/Y++w4p+XDLF
         OBtuUxIoJ4Iy3aqeW72PqFkITn8v7nJsJW/QAbK2KB1jp65styzIhzvuV4QZqbQs+9OU
         QFmnui6TfzBIfsWAVXEKjhP9wcU4Bnz8tMmlu2RaTjerQ9ykoFlWX+3q7pt8Bh0UzX3L
         tjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483835; x=1789088635;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g1/0D8PhzsqQbcuHEIiqrrUM/zjogKFZy1mLAKunYKo=;
        b=JvIEElnd54oBtBXlDfpohj3dXAApOY1LoUg+0EVLFBXbAgdZrf8Ro6h0sKl/vA84eO
         FbOS+krgVjV5egNQLeo4Wayag+E7NAefycCYCFA4M4EdPvzp99RIXtBxdEDSjDm3yXE2
         gamBaFc1N2zLPfT7JpqEvfyElBCqtBuqhIbBt27Qh4RUaEASanz11VTdUTF9mWExE0IE
         BA6GM04Op/nfkQrpmh34rxQkkFvZsJImYU3oYW+ZbL4bTD98mmC0hT917pmExtrv6B2R
         mNoCpYDdMTlt6tLAISPRE7NGS7TFZl2m203MvLp5ho4Y9EKRwXVrKKn36nOje1fK9O/Y
         7C7A==
X-Gm-Message-State: AFuF++kdnpqnVQr+HZ2jTv/SjMqb+aBdqdch8fvTQWuqjh0T6Djn0qVd
	k05kBkCf/7tfC7t7cph+OliHCds3npAUCIotxlGtRr8oW/2huC+RnbdAKLUrMcG7H4wgVJ4FiFl
	q9UgAag==
X-Received: from pgbbm16.prod.google.com ([2002:a65:6e90:0:b0:c97:228f:37ae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cc8e:b0:3c4:36ef:3dc9
 with SMTP id adf61e73a8af0-3da39fef37emr3912160637.17.1788483835141; Thu, 03
 Sep 2026 18:03:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 18:03:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904010353.3175819-1-seanjc@google.com>
Subject: [PATCH v3 0/8] KVM: VMX: Harden against interpreting TDX vCPU as vcpu_vmx
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move and rename "all" (read: everything I could find) common helpers out of
vmx.c and/or replace their vmx_ prefix with vt_, and then poison to_vmx() for
all common .c files to harden KVM against misinterpreting a TDX vCPU as a VMX
vCPU, i.e. consuming to_vmx() on a TDX vCPU.  Spotted when working through
the bus lock series.

v3:
 - Collect tags. [Kai, Xiaoyao, Binbin]
 - Move the poisoning to patch 1. [Xiaoyao]
 - s/Disallowing/Disallow. [Binbin, Kai]
 - s/vmx_needs_pi_wakeup/vt_needs_pi_wakeup. [Xiaoyao]

v2:
 - https://lore.kernel.org/all/20260826171246.777729-1-seanjc@google.com
 - Complete my train of though in patch 1's changelog. [Binbin]
 - Rename vmx_handle_exit_irqoff() => vt_handle_exit_irqoff. [Binbin, Sashiko]
 - Collect a review. [Binbin]
 - Move and rename everything I could find, using a dummy "struct vcpu_vmx_tdx"
   to allow relocating common inline helpers from vmx.h to common.h.

v1: https://lore.kernel.org/all/20260814161129.2177118-1-seanjc@google.com

Sean Christopherson (8):
  KVM: VMX: Disallow using to_vmx() in common VT code
  KVM: VMX: Move the shared "IRQs off" exit handler(s) to common code
  KVM: VMX: Move the shared NMI handler/trampoline to common code
  KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"
  KVM: VMX: Rename EPT violation handler prefix from "vmx" to "vt"
  KVM: VMX: Use dummy pseudo-overlay struct for to_vt() and vt_to_vcpu()
  KVM: VMX: Move common VT getters/converters to common.h
  KVM: VMX: Rename common exit info getters prefixes from "vmx" to "vt"

 arch/x86/kvm/vmx/common.h      |  60 +++++++++++--
 arch/x86/kvm/vmx/main.c        |  92 ++++++++++++++++++-
 arch/x86/kvm/vmx/nested.c      |  36 ++++----
 arch/x86/kvm/vmx/posted_intr.c |  24 ++---
 arch/x86/kvm/vmx/posted_intr.h |   8 +-
 arch/x86/kvm/vmx/tdx.c         |  32 +++----
 arch/x86/kvm/vmx/vmx.c         | 155 ++++++++-------------------------
 arch/x86/kvm/vmx/vmx.h         |  37 --------
 arch/x86/kvm/vmx/x86_ops.h     |   1 -
 9 files changed, 229 insertions(+), 216 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.979.g7e5102b832-goog

