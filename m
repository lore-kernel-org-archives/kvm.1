Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC23EEAEA
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533702; cv=none; b=VyrjxJ3OPbCwUm183ZmYJ/PvCmtgS/6fo/XaERUL6k1PuOxgYYsVI/5QqteyqhiLufZ4c+WimvAA10aoQwI7wJe8hmdRkgkR8WUdX1BKVQx41fysAy7uXgbVfIGJ7Ux3pXtW6EiRXzB3JWco9pj9NeCc3uslthgv2TCrRDASp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533702; c=relaxed/simple;
	bh=YCvn3MuvcZqxFkBqbGxbtqUHvt+AHBWc7vD8uqkOoT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nf1PuOwZH+LwN9t+MZowyqg7fY+SWrpA+AmwyLXz0EMqjGZQ7SFCmGANh1VdhbdqDLitfuuI3ntZk3grUdJ2y2vlQM7ykdEIpem+m6Q6XtehsdSnrgu0zqa0z4XG2AVHren2aBjb59y1w6Hm8Jt81lBsRgUOyj5lFWkJBykHw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEykmC3o; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEykmC3o"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2ed88c8so3368427a12.3
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781533700; x=1782138500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrpWKke6dqJc8K8vGlvhm4qwRCykfjr0R61az/1r5wc=;
        b=eEykmC3oy7aAbQo+up/CTwZgTs5hj7KM3AS27ZVzPsF6zjBTmnUg2Ebj4kydLGzOJD
         FcvYPY+mprQG6AA7MS3B3HCGkIeIlDWuZ+3OAO32vj33wT7HRZQvOYwe//137e2HFooA
         lDjqfSMXe0dT/flRMwhuIti0TBQAWHpvYouPnyiasqHiJEU3rrETRLlP2MgTFfdGEFih
         CrwKi/vaMPnCpoo2lv6JmRF2D2U3THbr6jDGFceULtW/dF/77QKcmLS/KXwPUhUx9fuK
         ZH9ugm1BkC/+Osdr406ipjL/9LOvpavFCZwSHTBlzlxk967wqbFgzDZcWLXAl3B2G059
         c7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533700; x=1782138500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrpWKke6dqJc8K8vGlvhm4qwRCykfjr0R61az/1r5wc=;
        b=f4DpNjKKIxQvj8WOOqIZX010qcBfyWhfK9OfRwgia+TD3VQiZjXy549C8aXFSMMvOV
         akTal2XhdO0emBGydsPyDIzhD7x3xQ+fcAB7WFykkym3vyfiH/25c3xa9A76pTM5aLvL
         UUado8s53Rx/tvtCYN3a+1oNklqsPxxkJoudJ5a+/OyiNVdSZPXhb29zWEH4xBLTkL7c
         594Y5irqpT1Z3h40nkFk22ArI94CuGrCiVRJm1OZ214xvs/P8BuxK0Oyaqvr+0LBeKIO
         S+75PesaMsbbwrRGdJdNeUsSiQIDQlUZiNfzu5IHmwiFh4amW83KoKmlbZYUs30VMU5r
         X5Gg==
X-Gm-Message-State: AOJu0YyY1g5gsKt0UeH8cgtesVWKJ/aOp4J4crqZABClhbczTJSzRTd7
	7jj/AjsYW7PCsPjSQupW8nI4PQpf1DP5V3WVh7IkNG7jKBbA6+24aQabo+QgGh9yevhy643DlYU
	fSwzklg==
X-Received: from pglv29.prod.google.com ([2002:a63:151d:0:b0:c79:8d3a:7901])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2285:b0:3b3:f46:1eea
 with SMTP id adf61e73a8af0-3b783c755d9mr16660238637.7.1781533700178; Mon, 15
 Jun 2026 07:28:20 -0700 (PDT)
Date: Mon, 15 Jun 2026 07:28:19 -0700
In-Reply-To: <6a2dbfcc.8812e0fc.3c3fa4.000a.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-1-seanjc@google.com> <6a2dbfcc.8812e0fc.3c3fa4.000a.GAE@google.com>
Message-ID: <ajAMA_cWeZon3SYs@google.com>
Subject: Re: [syzbot ci] Re: KVM: x86/hyperv: Fix racy usage of vcpu->arch.hyperv
From: Sean Christopherson <seanjc@google.com>
To: syzbot ci <syzbot+ciaa819f991480b300@syzkaller.appspotmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzbot@syzkaller.appspotmail.com, vkuznets@redhat.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Jun 13, 2026, syzbot ci wrote:
> Full report is available here:
> https://ci.syzbot.org/series/674ef35a-9335-4710-8a6d-b18d01510cbb
> 
> ***
> 
> WARNING in kvm_hv_vcpu_uninit
> 
> tree:      linux-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> base:      c1f7303302927f9cbf4efedf70f0512cde168c65
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/20dd789e-0a89-4465-844c-9d91b5ce4a45/config
> syz repro: https://ci.syzbot.org/findings/eeefcfe6-b8e9-4c5b-900e-855d814f5d97/syz_repro
> 
> ------------[ cut here ]------------
> debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || vcpu->vcpu_idx < 0 || !refcount_read(&vcpu->kvm->users_count))
> WARNING: ./include/linux/kvm_host.h:996 at kvm_lockdep_assert_vcpu_is_locked_or_unreachable include/linux/kvm_host.h:994 [inline], CPU#1: syz.1.25/5883
> WARNING: ./include/linux/kvm_host.h:996 at to_hv_vcpu arch/x86/kvm/hyperv.h:78 [inline], CPU#1: syz.1.25/5883
> WARNING: ./include/linux/kvm_host.h:996 at kvm_hv_vcpu_uninit+0x198/0x210 arch/x86/kvm/hyperv.c:906, CPU#1: syz.1.25/5883
> Modules linked in:
> CPU: 1 UID: 0 PID: 5883 Comm: syz.1.25 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:kvm_lockdep_assert_vcpu_is_locked_or_unreachable include/linux/kvm_host.h:994 [inline]
> RIP: 0010:to_hv_vcpu arch/x86/kvm/hyperv.h:78 [inline]
> RIP: 0010:kvm_hv_vcpu_uninit+0x198/0x210 arch/x86/kvm/hyperv.c:906
> Call Trace:
>  <TASK>
>  kvm_arch_vcpu_destroy+0x1a9/0x380 arch/x86/kvm/x86.c:12905
>  kvm_vm_ioctl_create_vcpu+0x68b/0x940 virt/kvm/kvm_main.c:4262

Darn error injection.  xa_insert() can fail with -ENOMEM.  It's kinda ugly, but
unwinding vcpu_idx on failure is a logically sound fix.  And a good excuse to
document that the index needs to be set before adding it to the array, e.g.

diff --git virt/kvm/kvm_main.c virt/kvm/kvm_main.c
index b3d2a678210c..98da4c889ffc 100644
--- virt/kvm/kvm_main.c
+++ virt/kvm/kvm_main.c
@@ -4218,11 +4218,18 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
                goto unlock_vcpu_destroy;
        }
 
+       /*
+        * Set the vCPU's index *before* the vCPU is reachable by other tasks.
+        * Unwind the index back to -1 on failure so that KVM can use the index
+        * to detect that the vCPU is unreachable, e.g. for lockdep asserts.
+        */
        vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
        r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
        WARN_ON_ONCE(r == -EBUSY);
-       if (r)
+       if (r) {
+               vcpu->vcpu_idx = -1;
                goto unlock_vcpu_destroy;
+       }
 
        /*
         * Now it's all set up, let userspace reach it.  Grab the vCPU's mutex

>  kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5161
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbc0659ce59
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fbc073dc028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fbc06815fa0 RCX: 00007fbc0659ce59
> RDX: 0000000000000001 RSI: 000000000000ae41 RDI: 00000000000000f7
> RBP: 00007fbc06632d6f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fbc06816038 R14: 00007fbc06815fa0 R15: 00007fffc5de9fc8
>  </TASK>
