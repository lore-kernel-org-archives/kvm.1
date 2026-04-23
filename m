Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBF17555
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980432; cv=none; b=tuV4RQU0f4TUTNk4x2JEUJ+NqpALe069Ygf9aHrKsP7EwLzywNV9R+AsXOt7GLLG1dbUy+yV3EmdWTb0jvwUaqbHcE5RgQKeW/+cb2eRcdDVEswZeYwWEown9wte2Ke3xW8ZzhdUQE0HYOqRN2HtFQEFaIRUX6TPvbt7r70VXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980432; c=relaxed/simple;
	bh=CbPwkH8GGpVhvquOXvmjt1B4zlAW22+V1IEsQz0Q8Qk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=umVRgnv8M7lN+6UckhVsiknoVeH9ZCDll6gzmZpnMiirmeE/iVWrfrw+SZFEqZaKai05X7PzvlUPaT7h3lKnXrC9VJLs79BqprsdH8WIaMh8x1g8GiNqLrhb2WFqSVaOjBa2MPWwpr3wc3I0eSRti6xXJj+roEoYl792z07sDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkN9LbaB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkN9LbaB"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so9796446b3a.2
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776980431; x=1777585231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Idm038EH6nKJVMjStePrzmNY1P6l5m6C6WmOOw+gdn8=;
        b=CkN9LbaBPNcgerMhQZ6O2otaVKA4WWiREx+f618DlQzLL/LiqI+twAWyWHzkXr99AM
         /aUChb+DCcv6neFduGT0c9dpGoyvzzGMZRf2qebOQefwPmPnjB242BtKzAjQCx98eqj+
         Xn1gP0UL7fs1Rlb38o8K/6R74KyY2udkSh8BcLfS65vQk6E9TZy7pyMwsVRoVEdUEI9S
         WkXKHBYukgtGJ0IziFbkjN4Tqx2LOAa7bnls4jhWRlAdhYFEuojiqoeVwv7YGvXcnq6S
         t6vOdanoNU7YGoV6R+0T42q8V21z0b8vfq+zgW/T3E0C+iTqCgsfp3yQeBZa5DIobfqG
         yUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776980431; x=1777585231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Idm038EH6nKJVMjStePrzmNY1P6l5m6C6WmOOw+gdn8=;
        b=p1SYxpjQJIeNZZBkHG4nxqMAJVcLN+03XU+bH12qwd9w9IYTRHpj9t+O/yXkt1HTWB
         nIZ+B47H/EEGBB+Q4nU0EehXTY/ShCB0skgcdgzYF4Q3NXWdFB34OK5HGFPg6TFj8OHH
         A2f45PjHNxuhKs+v1QQoDOhsllp8iQMyzj94QDIl0v5c4GRQz2LJ2e3KfWn0IrE5wkoN
         woQjOZfr47wdp3J1oC47YvoPVadkP4miuWw/L905nAipxZhj3mi1oRUTdlp0pC2iwn4F
         Yjb1+yS2a4VNbMDn+SneIsVIrV+yNznWVUekoU69uX3lq4SclJRQRkv9WvczxClsuqIL
         yFFA==
X-Gm-Message-State: AOJu0YyiOzHI06nvdbQ+nluamtdstCuMM+jzrq8J4pkkMM2VZqNtSv5T
	NpyaJHVL4vSeGE6ybyBJU9QIBe3EbYmrBEhGGJgAweIfGnWAfHtYKSHswy4vbNphBdcQmw422oL
	Pz3lXWg==
X-Received: from pfbde11.prod.google.com ([2002:a05:6a00:468b:b0:82f:3ec7:cdd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6702:b0:82d:2086:de2a
 with SMTP id d2e1a72fcca58-82f8c8e8ad6mr19051710b3a.35.1776980430742; Thu, 23
 Apr 2026 14:40:30 -0700 (PDT)
Date: Thu, 23 Apr 2026 14:40:29 -0700
In-Reply-To: <69ea8687.a00a0220.9259.002c.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423140833.439512-1-seanjc@google.com> <69ea8687.a00a0220.9259.002c.GAE@google.com>
Message-ID: <aeqRzanSaa9P_EPg@google.com>
Subject: Re: [syzbot ci] Re: KVM: x86/hyperv: Fix racy usage of vcpu->arch.hyperv
From: Sean Christopherson <seanjc@google.com>
To: syzbot ci <syzbot+ciae116ac2b0afefad@syzkaller.appspotmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 23, 2026, syzbot ci wrote:
> syzbot ci has tested the following series
> ***
> 
> WARNING in kvm_hv_vcpu_uninit
> 
> tree:      linux-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> base:      85f871f6ba46f20d7fbc0b016b4db648c33220dd
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/4f8c36c7-e865-4f65-bb81-e22962e8a1e0/config
> syz repro: https://ci.syzbot.org/findings/60fac5d8-1296-4ec7-a8e3-40f561d007e9/syz_repro
> 
> ------------[ cut here ]------------
> debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || !refcount_read(&vcpu->kvm->users_count))
> WARNING: arch/x86/kvm/hyperv.h:79 at to_hv_vcpu arch/x86/kvm/hyperv.h:78 [inline], CPU#1: syz.2.19/5974
> WARNING: arch/x86/kvm/hyperv.h:79 at kvm_hv_vcpu_uninit+0x163/0x1b0 arch/x86/kvm/hyperv.c:906, CPU#1: syz.2.19/5974
> Modules linked in:
> CPU: 1 UID: 0 PID: 5974 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:to_hv_vcpu arch/x86/kvm/hyperv.h:78 [inline]
> RIP: 0010:kvm_hv_vcpu_uninit+0x163/0x1b0 arch/x86/kvm/hyperv.c:906
> Call Trace:
>  <TASK>
>  kvm_arch_vcpu_destroy+0x1a9/0x380 arch/x86/kvm/x86.c:12963
>  kvm_vm_ioctl_create_vcpu+0x69a/0x930 virt/kvm/kvm_main.c:4269
>  kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5168
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Argh, what a pain.  It's effectively the same issue that I fudged around in
kvm_hv_set_cpuid(): KVM queries HyperV state during vCPU creation, before taking
vcpu->mutex makes any sense.

One thought I had was to initialize vcpu_idx to -1, so that to_hv_vcpu() could
detect that the vCPU isn't yet visible to others.  Arguably that would be also
nice-to-have as it would harden against consuming vcpu->vcpu_idx before it's
fully initialized.  As-is, goofs would result in KVM thinking its vCPU0.

diff --git virt/kvm/kvm_main.c virt/kvm/kvm_main.c
index 7fcb92c69dc8..35e92cfb2a45 100644
--- virt/kvm/kvm_main.c
+++ virt/kvm/kvm_main.c
@@ -4198,6 +4198,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
                goto vcpu_decrement;
        }
 
+       vcpu->vcpu_idx = -1;
+
        BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
        page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
        if (!page) {
