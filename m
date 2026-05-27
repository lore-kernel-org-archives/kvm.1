Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D421D5146
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841754; cv=none; b=NSJns0feJmk/9llvrCwfN3/IfHt0QRoB7rO8U1QGvegvmxI1DSV8w0DC7brJ9PVUmRu//tzmXk9qHpwnLROp2RrkDByUYXix5f7jnHZWvcg3tgGD/1Ez0z0t/Sk9dYLusVf57RL80LQySM/07JzXy5yLvuXJNmkSKRAYq0Qu48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841754; c=relaxed/simple;
	bh=nmBeMInh0ObdNImV5eL8bwbUaMkUzs8t935trzE/Tcw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y8TuPjdCihmfdU+XY02um6FstHejKKOeG6DIz/wPjnhTeefkIWsqgcMnAirpcqd5lPzbVrm6OeRj/2RzbKGd4dwhJjo5cMVKt9WS/m5Yy0Y3aeOw+8KO6Zmhm6+6KlFcqj8f3vusSSSnoG6aLjAe9tE3WjQc4hOua2jEB/dIN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJNf+4jL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJNf+4jL"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4654f9bb6so122472315ad.2
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 17:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779841752; x=1780446552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnSo0Vb3RWSmtdekGZkRS/aQyhq6Ia1+g0nzxqruj6Y=;
        b=HJNf+4jLqhsD9wM11jtlkNTdhxELiJ1i/UJhyF4A9udZ0XoXfxXI7bIu4L08iZqjYC
         EgMwc3Q79GoLC5phhYiIxOMpvl7E8TYP3+j885Jck87dmeTctpjB8J8vnRtKSkfjDPxg
         k0fmodRBSGaEJRWxhxmUPSrwmuCKUIuBCXqutXIdEpLWoRckvqsJO2bZUYapBaFib7l1
         2XBy0imEAXpcghPWJYIetAlGezkAr6rAw43kiIQX1fwwcbk4TussecKTcO4npDVKlq6L
         yGYYCNr+LMg281jk9aOW8w4C0I8zewmrRg9T5lEFeacqz4k5qsnjjLM8V9Kl4B66DXIU
         Iuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779841752; x=1780446552;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnSo0Vb3RWSmtdekGZkRS/aQyhq6Ia1+g0nzxqruj6Y=;
        b=Otv69cDjwiYIzizoaFEDztyjRrsa9LETkFA4Fv7JlQcFfD2TIMy+Vwk0BYGJLimMjT
         wtZdRdR7wPeqkP9JQWTd7QG2/o/wlGKwS7hRPojzBLExhgi+JQVVlmQrU6vKZvzOeyxz
         S7DtrVozvwo1vNuKVGqUTchaF1ttQD1k+XMAVPeyMhWGYU/zqVQdKTEXv9C+pYeFUpaq
         k7oAgHOV8hsXRfjthiwVHkqmQnHHi79rSvWgKGerbOEC3ed3s4HAVoCCfpUEZBehCYVg
         VfGIRh6pFWoAp89mPCoPoYA/MSXZY049EYAWvKZ905uIdXShM3dKTihVGkAo3hZM78DT
         c24w==
X-Gm-Message-State: AOJu0YxOrnz25vI7Ek7TEa/7GzxjLLtPMKPfgqLs6XoSFc7Xs1A/IWRC
	MkMRXjXJkrSkTYXQtL/lA0qI234rSAote1NZm6+V4bnqsR3jolE8lOeNxGo0Ok5MKavHJ5fWhc5
	iQ/xA/Q==
X-Received: from plqu12.prod.google.com ([2002:a17:902:a60c:b0:2bc:ffa3:fee1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c950:b0:2b2:d09c:c07c
 with SMTP id d9443c01a7336-2beb0848f5bmr231485575ad.36.1779841752310; Tue, 26
 May 2026 17:29:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 26 May 2026 17:29:10 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527002910.3931382-1-seanjc@google.com>
Subject: [PATCH] KVM: Delete guest-triggerable (in theory) BUG_ON() in
 ioeventfd datamatch
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop a BUG_ON() that has been reachable since it was first added, way back
in 2009.

For a given store, KVM tracks the entire value in the destination operand,
x86_emulate_ctxt.dst. If the destination is memory, and the target splits
multiple pages and/or is emulated MMIO, then KVM handles each fragment
independently.  E.g. on a page split starting at page offset 0xffc, KVM
writes 4 bytes to the first page, then the remaining bytes to the second
page, using ctxt->dst as the source for both (with appropriate offsets).

If the destination splits a page *and* hits emulated MMIO on the second
page, then KVM will complete the write to the first page, then emulate the
MMIO access to the second page.  If there is a datamatch-enabled ioeventfd
at offset 0 of the second page, then KVM will process the remainder of the
store as a potential ioeventfd signal.

Putting it all together, if the guest emits a store that splits a page
starting at page offset N, and the second page has a datamatch-enabled
ioeventfd at offset 0, then KVM will check for datamatch using
&dst.valptr[N] as the source.  Due to dst (and thus dst.valptr) being
32-byte aligned, if N is not aligned to @len, the BUG_ON() fires.

E.g. with a 16-byte store at page offset 0xffc, to an ioeventfd of len 8,
all initial checks in ioeventfd_in_range() will succeed, and the BUG_ON()
fires due to @val being 4-byte aligned, but not 8-byte aligned.

  ------------[ cut here ]------------
  kernel BUG at arch/x86/kvm/../../../virt/kvm/eventfd.c:783!
  Oops: invalid opcode: 0000 [#1] SMP
  CPU: 0 UID: 1000 PID: 615 Comm: repro Not tainted 7.1.0-rc2-ff238429d1ea #365 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:ioeventfd_write+0x6c/0x70 [kvm]
  Call Trace:
   <TASK>
   __kvm_io_bus_write+0x85/0xb0 [kvm]
   kvm_io_bus_write+0x53/0x80 [kvm]
   vcpu_mmio_write+0x66/0xf0 [kvm]
   emulator_read_write_onepage+0x12a/0x540 [kvm]
   emulator_read_write+0x109/0x2b0 [kvm]
   x86_emulate_insn+0x4f8/0xfb0 [kvm]
   x86_emulate_instruction+0x181/0x790 [kvm]
   kvm_mmu_page_fault+0x313/0x630 [kvm]
   vmx_handle_exit+0x18a/0x590 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc81/0x1c90 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x970 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb7/0x890
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f19c931a9bf
   </TASK>
  Modules linked in: kvm_intel kvm irqbypass
  ---[ end trace 0000000000000000 ]---

Simply delete the BUG_ON(), as KVM x86 doesn't perform alignment checks on
"normal" memory accesses at CPL0, i.e. the BUG_ON() doesn't actually guard
against any badness (presumably it was a sanity check).

Fixes: d34e6b175e61 ("KVM: add ioeventfd support")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/eventfd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 0e8b8a2c5b79..d631a86103bb 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -779,9 +779,6 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
 		return true;
 
 	/* otherwise, we have to actually compare the data */
-
-	BUG_ON(!IS_ALIGNED((unsigned long)val, len));
-
 	switch (len) {
 	case 1:
 		_val = *(u8 *)val;

base-commit: 66939c1603bd5579e63278f9dc72cba5b79da9b5
-- 
2.54.0.823.g6e5bcc1fc9-goog

