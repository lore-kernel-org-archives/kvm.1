Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3934195DA
	for <kvm@vger.kernel.org>; Sat, 12 Sep 2026 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202906; cv=none; b=LjSh17Obj+TzvgRL2u/iS7Su1R/qgy4WM7+F9i/x9RC30BSFFl/EVXXo+AR4/1XT3RfXy2BZdomqHMjatU0G50rljI/MFBXhPq5+iGNhpmximq6/Kg5GzHKmDbljN3EoJ7yCvQZhwdW3POGWSUKcrKjv90oIAV6Law35wJunSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202906; c=relaxed/simple;
	bh=yysx8Y0bcy59mHotiMIZQi0N58Cnci1NMeONCIlVnTI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=SS0JGfY6VK3cU26JdBkhfcWuEf/rCBOgPC1Bstd2xo+iv7Mneq9BLXd2PDtHxHTdRokea51jjivkUKjKIhMFWqqt2Ns+ROBF65vfVdJbmR49aDO9lKmBHt6T3mxOUuzKSKNXS2lC1fGQ4k7aUJ+mVTcLSBTAhVdaL0Sh7AMEkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-80491594629so1605347a34.1
        for <kvm@vger.kernel.org>; Sat, 12 Sep 2026 01:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202903; x=1789807703;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n80Is/8U/sZ2QtYs0sLpkVOTjf/v6x4Vh+jPSJboZLk=;
        b=Bki46XWNlooKacnq0NpJ9fc0ij14VMS1f3nS+eEtUkq6CF6N3cHG970tLGLnIZxXhr
         wwVP4pDV+n1fU5nqk+BYCr9JvtGu640gk0t4fmmQ/nI7zMpA1+kXlo2pR3O8lgwQmuOv
         MAaLTxa5PhKwgjYXT0+NnJtKWHcWgaKhFul8oh3vJdtIzNEli9bweOhWpCIbIwGnjDkz
         geJDmQLvZFcx2KpbqrhNFSE1ArdpUXgxPW1L0UVNtcVPsESKFUj+2+1thJ1X8gIYnMQP
         eEoxdiwtNSGIdrQeBDnraidjDCBeZbybP3N2ILL+500I2lKOkpHw23YQ24ysCCUy20zI
         RHmg==
X-Forwarded-Encrypted: i=1; AKwUvBwslO5pG/OJlZI2IAcLDw0SYjJon4a0Sdo/F0jEXrZPbT/wxE3v4HeTgTQBoOTcAIhYmSc=@vger.kernel.org
X-Gm-Message-State: AFuF++llHgcVLbmoHzftuUGl3hyX9YapHvkLlSL2Sz3yHBYc11qeJVf/
	eGAQAVMCJWI29K/GSgC7vfcMYWKoCD+muOTLijdy1winuHXyRG+HfhvWhML6vysnpD5w6V3Gh69
	+BxesRK21tB41NNFcwI/3YP3etlyXkFFQw1XWHfgFqwU4dKbi/zr3Xdd6DDI=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a3:b0:6bd:f79e:5022 with SMTP id
 006d021491bc7-6bf460f37b7mr6566585eaf.23.1789202903330; Sat, 12 Sep 2026
 01:48:23 -0700 (PDT)
Date: Sat, 12 Sep 2026 01:48:23 -0700
In-Reply-To: <20260911184819.101123-1-davimaba.v@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa511d7.f81106d8.2ab401.0029.GAE@google.com>
Subject: [syzbot ci] Re: KVM: unbounded per-VM kernel memory growth via KVM_SET_MEMORY_ATTRIBUTES
From: syzbot ci <syzbot+ci9f9bcee0bbb4155d@syzkaller.appspotmail.com>
To: davimaba.v@proton.me, kvm@vger.kernel.org, pbonzini@redhat.com, 
	security@kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] KVM: unbounded per-VM kernel memory growth via KVM_SET_MEMORY_ATTRIBUTES
https://lore.kernel.org/all/20260911184819.101123-1-davimaba.v@proton.me
* [PATCH 1/2] KVM: Bound per-VM GFN materialization in KVM_SET_MEMORY_ATTRIBUTES
* [PATCH 2/2] KVM: Account mem_attr_array nodes to the caller's memcg

and found the following issue:
WARNING: suspicious RCU usage in kvm_vm_ioctl_set_mem_attributes

Full report is available here:
https://ci.syzbot.org/series/734bda86-476d-49cf-9a5e-335cc5b006c0

***

WARNING: suspicious RCU usage in kvm_vm_ioctl_set_mem_attributes

tree:      kvm-next
URL:       https://kernel.googlesource.com/pub/scm/virt/kvm/kvm/
base:      d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/a54b5b46-809d-4f22-a473-c317ec575648/config
syz repro: https://ci.syzbot.org/findings/c345c736-c3eb-46c9-9d9d-cc78ce4bf677/syz_repro

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/linux/xarray.h:1211 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz.2.19/5790: 1, last CPU#0:
 #0: ffff88810b9900a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2605 [inline]
 #0: ffff88810b9900a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x365/0x1af0 virt/kvm/kvm_main.c:2690

stack backtrace:
CPU: 0 UID: 0 PID: 5790 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6938
 xa_head include/linux/xarray.h:1210 [inline]
 xas_start+0x618/0x770 lib/xarray.c:191
 xas_load+0x2c/0x5a0 lib/xarray.c:239
 xas_find+0x157/0x980 lib/xarray.c:1409
 kvm_count_mem_attr_entries virt/kvm/kvm_main.c:2558 [inline]
 kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2660 [inline]
 kvm_vm_ioctl_set_mem_attributes+0x1578/0x1af0 virt/kvm/kvm_main.c:2690
 kvm_vm_ioctl+0xb33/0xd30 virt/kvm/kvm_main.c:5421
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4321f9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4322e33028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4322225fa0 RCX: 00007f4321f9e159
RDX: 0000200000002200 RSI: 000000004020aed2 RDI: 0000000000000004
RBP: 00007f432203503b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4322226038 R14: 00007f4322225fa0 R15: 00007ffea2b6d9c8
 </TASK>

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/linux/xarray.h:1227 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz.2.19/5790: 1, last CPU#0:
 #0: ffff88810b9900a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2605 [inline]
 #0: ffff88810b9900a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x365/0x1af0 virt/kvm/kvm_main.c:2690

stack backtrace:
CPU: 0 UID: 0 PID: 5790 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6938
 xa_entry include/linux/xarray.h:1226 [inline]
 xas_descend lib/xarray.c:208 [inline]
 xas_load+0x4dc/0x5a0 lib/xarray.c:246
 xas_find+0x157/0x980 lib/xarray.c:1409
 kvm_count_mem_attr_entries virt/kvm/kvm_main.c:2558 [inline]
 kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2660 [inline]
 kvm_vm_ioctl_set_mem_attributes+0x1578/0x1af0 virt/kvm/kvm_main.c:2690
 kvm_vm_ioctl+0xb33/0xd30 virt/kvm/kvm_main.c:5421
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4321f9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4322e33028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4322225fa0 RCX: 00007f4321f9e159
RDX: 0000200000002200 RSI: 000000004020aed2 RDI: 0000000000000004
RBP: 00007f432203503b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4322226038 R14: 00007f4322225fa0 R15: 00007ffea2b6d9c8
 </TASK>

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/linux/xarray.h:1227 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz.2.19/5790: 1, last CPU#0:
 #0: ffff88810b9900a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2605 [inline]
 #0: ffff88810b9900a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x365/0x1af0 virt/kvm/kvm_main.c:2690

stack backtrace:
CPU: 0 UID: 0 PID: 5790 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6938
 xa_entry include/linux/xarray.h:1226 [inline]
 xas_next_entry include/linux/xarray.h:1731 [inline]
 kvm_count_mem_attr_entries virt/kvm/kvm_main.c:2558 [inline]
 kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2660 [inline]
 kvm_vm_ioctl_set_mem_attributes+0x1834/0x1af0 virt/kvm/kvm_main.c:2690
 kvm_vm_ioctl+0xb33/0xd30 virt/kvm/kvm_main.c:5421
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4321f9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4322e33028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4322225fa0 RCX: 00007f4321f9e159
RDX: 0000200000002200 RSI: 000000004020aed2 RDI: 0000000000000004
RBP: 00007f432203503b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4322226038 R14: 00007f4322225fa0 R15: 00007ffea2b6d9c8
 </TASK>

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/linux/xarray.h:1244 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz.2.19/5790: 1, last CPU#0:
 #0: ffff88810b9900a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2605 [inline]
 #0: ffff88810b9900a0 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_mem_attributes+0x365/0x1af0 virt/kvm/kvm_main.c:2690

stack backtrace:
CPU: 0 UID: 0 PID: 5790 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6938
 xa_parent+0xec/0xf0 include/linux/xarray.h:1243
 xas_find+0x6f2/0x980 lib/xarray.c:1422
 kvm_count_mem_attr_entries virt/kvm/kvm_main.c:2558 [inline]
 kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2660 [inline]
 kvm_vm_ioctl_set_mem_attributes+0x1578/0x1af0 virt/kvm/kvm_main.c:2690
 kvm_vm_ioctl+0xb33/0xd30 virt/kvm/kvm_main.c:5421
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4321f9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4322e33028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4322225fa0 RCX: 00007f4321f9e159
RDX: 0000200000002200 RSI: 000000004020aed2 RDI: 0000000000000004
RBP: 00007f432203503b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4322226038 R14: 00007f4322225fa0 R15: 00007ffea2b6d9c8
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
