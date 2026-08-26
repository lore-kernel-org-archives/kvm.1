Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55153450409
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764386; cv=none; b=QIplHDbhvRD2XDB8yHkBh9F2Kq3kCF6tptu/+tjtorxgKq2KWB7dPPE6CW+T2657OcxKMa3nDH6u6LCidIjvqpioT3u8d4D5f77aJKTVpAYWd8lY8f+VC5Zv7Kcf6ZgRUZ9YX2l9k14pUD1rSPW++2lu0VacKwGqZ+iZ2vshbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764386; c=relaxed/simple;
	bh=q6FCE71hqOdUh5ccpzRzeUldvCJyHXHPMQ9uptiqErI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MxsrgyMqUai2KCSDIi9zgo/q9EHgzBItShX3hnNLFl3wEzSE3mkKCQShXuShViSEZi25/UMMce+aYUlvWLEnVJLVkJ85sokHTGHShY6pCxBb1xW7+UK8xPn0EXrGEMfeb+SWqYWduuAKSkoYtECH/lq/K89eJV1PRgsn0WZyyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kM0NPocJ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kM0NPocJ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so1301932a12.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787764369; x=1788369169; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BXkEMVsh2+8xb0uflNe1dR/nClI4LJ04DIhwi5akXZo=;
        b=kM0NPocJ1cvFHYU3RsTe/oi7vgx+FeZ1a4Omkxc49j6sB/0NSCDOT56SqY6SQ4AJwT
         0JcQw/0q+f/ixwdWS57ZOwnaIxc4cmhZY8f//G30U3slVWxwKLXv3++lkswUZvcLDZzd
         CZTLyMhuQNJfN2MSaonqDWkMkb4Tni8zCiCaouBMuM2650JhpUMIoamnqL/kCA5uwT2y
         7mnEof/yo4eoRwTZU71i8Sl3c9gzvSuEpbbfbo3wH3J3kSu0sbHFGVpR1FBFmCZHcQi9
         xnW0/RKrx3mBElHn2pU3USLjj+W54dQaWL2Q5OPwHHFDl67IxRvqNfjgwgJxjvMLm3e4
         tH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764369; x=1788369169;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BXkEMVsh2+8xb0uflNe1dR/nClI4LJ04DIhwi5akXZo=;
        b=RLPgTVp5NuZ2M7FTPg5pWPLwpvx/VjLzE/oSE8qeF2JKPSuF407GusHGvt42A1RbWx
         Nwt/ot7rL7HocU0PxPjNgST1gZ4TEqTjCnOJ7wFGxRyfjV6BdJayImMgj94BTuanNT+V
         IyFiI6Bb8Bn39mz82YavIgc/mLAa7wSz4pb0NpETSV3fLonyvN1H287uPM1eBiwuPELj
         k4PV/8N9hFOWLbdaA6IipGZRUByWAdxLutmI1x3AtUVuZrwxTAbd91ai/9IDh7jjmHZR
         Gkc2rEclpodbr29IkpHzIymbbF+pt/rdawPzsF0cyED+xXZOyd6P38lkL6jy99VY/JNC
         DaFg==
X-Gm-Message-State: AFuF++mOe0f/K6K/v+kqZXyh3OF2xxbncyJJMgtorZeRqZGLysy7xmcm
	B7txrVqeGWRdmmb0SnQpy+I/PMg7/r3+M4ikSO8EvhI6NhYz+IJx/dWkkZhrJ2WhSSwUYGVDSRQ
	mPjJ8WA==
X-Received: from pgcga15.prod.google.com ([2002:a05:6a02:668f:b0:c8b:2b50:846b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:4047:b0:3d0:cc29:ff64
 with SMTP id adf61e73a8af0-3d0cc2a0565mr4203700637.15.1787764368706; Wed, 26
 Aug 2026 10:12:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 10:12:38 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826171246.777729-1-seanjc@google.com>
Subject: [PATCH v2 0/8] KVM: VMX: Harden against interpreting TDX vCPU as vcpu_vmx
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move and rename "all" (read: everything I could find) common helpers out of
vmx.c and/or replace their vmx_ prefix with vt_, and then poison to_vmx() for
all common .c files to harden KVM against misinterpreting a TDX vCPU as a VMX
vCPU, i.e. consuming to_vmx() on a TDX vCPU.  Spotted when working through
the bus lock series.

As with v1, the TDX changes are compile-tested only.

v2:
 - Complete my train of though in patch 1's changelog. [Binbin]
 - Rename vmx_handle_exit_irqoff() => vt_handle_exit_irqoff. [Binbin, Sashiko]
 - Collect a review. [Binbin]
 - Move and rename everything I could find, using a dummy "struct vcpu_vmx_tdx"
   to allow relocating common inline helpers from vmx.h to common.h.

v1: https://lore.kernel.org/all/20260814161129.2177118-1-seanjc@google.com

Sean Christopherson (8):
  KVM: VMX: Move the shared "IRQs off" exit handler(s) to common code
  KVM: VMX: Move the shared NMI handler/trampoline to common code
  KVM: VMX: Disallowing using to_vmx() in common VT code
  KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"
  KVM: VMX: Rename EPT violation handler prefix from "vmx" to "vt"
  KVM: VMX: Use dummy pseudo-overlay struct for to_vt() and vt_to_vcpu()
  KVM: VMX: Move common VT getters/converters to common.h
  KVM: VMX: Rename common exit info getters prefixes from "vmx" to "vt"

 arch/x86/kvm/vmx/common.h      |  60 +++++++++++--
 arch/x86/kvm/vmx/main.c        |  92 ++++++++++++++++++-
 arch/x86/kvm/vmx/nested.c      |  36 ++++----
 arch/x86/kvm/vmx/posted_intr.c |  20 +++--
 arch/x86/kvm/vmx/posted_intr.h |   8 +-
 arch/x86/kvm/vmx/tdx.c         |  32 +++----
 arch/x86/kvm/vmx/vmx.c         | 155 ++++++++-------------------------
 arch/x86/kvm/vmx/vmx.h         |  37 --------
 arch/x86/kvm/vmx/x86_ops.h     |   1 -
 9 files changed, 227 insertions(+), 214 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.887.g758fc8c411-goog

