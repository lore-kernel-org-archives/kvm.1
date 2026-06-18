Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C324337BAB
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804634; cv=none; b=ewRC1TFDJrDqYfIGUnId9fe1Bd2N5bznq35u6z3rx2hDucYRsHxhImDuZKy9zmjxUMu2AiJ9Fqym2n9JO+iGnswxX8JUeuJ0AMhYp6GRifWHzi3JoRXMrantyUIWNCb+xngw0seQvub0F72L3MeU3OaHg3BKI3QvHiY9XSNd6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804634; c=relaxed/simple;
	bh=M0t9D3hGgjOl+QfFxAT0o7voSqkMnlLJZ5Qy5T/FmPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XaZ3wydSV4sfjb5OQIYxo+CiWgyIyXMA7g2BZQ6XP5ZUcfPYYGlU4exavbVa+MfyeplkF4L74RRjWzVuTSE3asnvqbLR3nAqjFN45RPnyS8xq4cvim8UJSk0afOiZNPwY9S0T8MrJSgr6AwhgG5woO1NV/jNoCn8Sb2B/tNHk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlL9LT8L; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlL9LT8L"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1dece2ecso12688175ad.1
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781804632; x=1782409432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5ORg+SVhYYJ0w5u+smp8MwTjHTHuHXu2DktmOBEIzpE=;
        b=hlL9LT8LQyo+vewymkFegbzqwr/dykIxtzSQD2fbdOoR0OhpC8p0+M/i3fXXHbtEcy
         ZVLY/FYUovu+ummCKGektwCNfp+jp3lfAJkS/XO1NbFkqYJse4gNu54ByUIL9X9gkVjx
         JKD+gIcG/8msYX3ekQhp1G6lJM4eM2pKjIjV2zL9543cwKPKa2iVkK/KXJEGZZbPxSOn
         P1iUH9McTkB5I9OgwDeNUN1FWxz99OcLL/8f7ICB1jpxouGDC8zfpsPv6ccQ1wqFOPuc
         LYwoXF9aWehdsTM+oqJmicnOSqNfH4b2DgpT0BezI2rPfVosQQNOgWE+g7TECfPIm0Qb
         MAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781804632; x=1782409432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ORg+SVhYYJ0w5u+smp8MwTjHTHuHXu2DktmOBEIzpE=;
        b=JkNUWm5BlkKtZmJdni+u5uKi/70n8TfB38zxgDCy4fmeAsm2BS9vJuhdc42veC0rgf
         rbKML4rMv29u+OninvgoyYYyAq9GrizSyDRhQgmDNP+byAK4VUldQDWjskJ7+3uteXFj
         OksiyjGHWRgJfxYffhrqAHO7LDwOZroyWOj0JdNoTKd2i4pQVk6HRLG1ITgSYdjGtQt6
         oTDOFqwtn35cTkmcLLG5TzgnHcIAwQlERZlor1AcJjWCoqAzvJXMIdOR3IICEaN0TE0h
         QJZziAgpwV9h7HJ2ZbQ+v1elGz3t2OfENZyLMYk8Sr+11VOKlGjDHVuDqAVINrpZUhLt
         uQzg==
X-Gm-Message-State: AOJu0YwOPHzEJd6TRTlYgbkHYLY63C4PSq0fVwLJ8IXW6EjN2KmZY881
	Cgh7XQF6VAjgDeCHSBfK4qHbewjuq9E5g4sddXaGxXedMfEpTDtydFatBE0GQ5/hhSp+9+PIKjC
	KK0wM2w==
X-Received: from plbjb7.prod.google.com ([2002:a17:903:2587:b0:2b0:c9c5:109b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228e:b0:2c1:737:bed9
 with SMTP id d9443c01a7336-2c719015708mr1699665ad.30.1781804632062; Thu, 18
 Jun 2026 10:43:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jun 2026 10:43:46 -0700
In-Reply-To: <20260618174347.1981064-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618174347.1981064-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618174347.1981064-2-seanjc@google.com>
Subject: [PATCH v3 1/2] KVM: VMX: Grab vmcs12 on CR8 interception update iff
 vCPU is in guest mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

When updating CR8 intercepts, get vmcs12 if and only if the vCPU is in
guest mode so that a future change can have update CR8 intercepts during
vCPU creation, without running afoul of get_vmcs12()'s lockdep assertion.

  ------------[ cut here ]------------
  debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || !refcount_read(&vcpu->kvm->users_count))
  WARNING: arch/x86/kvm/vmx/nested.h:61 at get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline], CPU#0: syz.2.19/5879
  WARNING: arch/x86/kvm/vmx/nested.h:61 at vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879, CPU#0: syz.2.19/5879
  Modules linked in:
  CPU: 0 UID: 0 PID: 5879 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
  RIP: 0010:get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline]
  RIP: 0010:vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879
  Call Trace:
   <TASK>
   apic_update_ppr arch/x86/kvm/lapic.c:984 [inline]
   kvm_lapic_reset+0x1c24/0x2980 arch/x86/kvm/lapic.c:3023
   kvm_vcpu_reset+0x44c/0x1bf0 arch/x86/kvm/x86.c:12986
   kvm_arch_vcpu_create+0x746/0x8b0 arch/x86/kvm/x86.c:12847
   kvm_vm_ioctl_create_vcpu+0x428/0x930 virt/kvm/kvm_main.c:4201
   kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5159
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:597 [inline]
   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

No functional change intended.

Reported-by: syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>
Closes: https://lore.kernel.org/all/6a2adf3b.3b0a2d4e.8c8d1.0012.GAE@google.com
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a1a5edb39a7e..125994ed3db5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6872,11 +6872,10 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 
 void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
-	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	int tpr_threshold;
 
 	if (is_guest_mode(vcpu) &&
-		nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
+	    nested_cpu_has(get_vmcs12(vcpu), CPU_BASED_TPR_SHADOW))
 		return;
 
 	guard(vmx_vmcs01)(vcpu);
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

