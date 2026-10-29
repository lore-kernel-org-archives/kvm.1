Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290940;
	b=1VceRR2hVWtLwO1leogSIxC83QzbBj7uGSvEFSwk9DNYGFws0drZdeded++BFosjfkgN
	 OQuOHF42fjgc7kC4ZcpnAoVojnIcwXWnGN8vcE3M3gH1yV9YGK6d+iMnq6uKzGcKrIFwM
	 kGwIZVO2SiYbdZJQehAs635Yn3is5vNq+GfQTTSGcsfWf/HvTpqBrl1rHK/IhZNsPfu+M
	 PWuAV+j13+nKvBujypcCNzB4QSNwoe7QxdBhCx/h//nxImGIEmu7ioVK9GY4u1oRbdzH2
	 G1ggLp4KLvUTRWA4Nm9HWO2MqnRilCuhBVYMyivvoxfKCRECldr17idVvYNL1IvMbpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290940;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=KgdUnNUWCNlIAgBJdIYDXqo6rzMWK5cU3WZgkhH6N4s=;
	b=33Lq3AiiLCdnE6OWkxU46VqOhgZMEoHe5Nr4xaGfC2rvXELr5nrsRd2v652dUgeT3k3N
	 UNFyf6Q7jmGw86eSqkdDPcc0soZ4ujQQLmBilPD7GS7GD7G/blDq1A2bjfgk7D70U6ihR
	 QkQtSlq+VFEFSH2TbzDpmDbwNEDcsQuaLNXDmW5uYWJP9fFUcf19WyCRYIcZ4frlkpbWG
	 iPELeAgYdJCTloQaQvgZGyVjjCrGZ1niniHytOhe+eCL49XvrECKMGP828i5gVv2Els17
	 BLJgVE+8B09iF4ft99/yT4xFN1mCOJfmgVLs8LUK+J/eVfTzpX7oV0Ji25hSytRTlZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4289606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4289606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4fb73e868aaso3817281b6e.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 09:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290938; x=1793895738;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgdUnNUWCNlIAgBJdIYDXqo6rzMWK5cU3WZgkhH6N4s=;
        b=opjnYeiWDjNJUJmbKelPP78k4j2V7nQiq3eR02+o0hj5QnhSdfYytJcAMmB1PUjUSu
         VHbhcnBbDwLMVVgeB1CurFmGOyi2LIy33tYk938EimyZbHokmYonYoDOkEaZh36tVICo
         WUg0Uj86w4uL64CQ9YYxrZuf8JL/l8MNR2n+hUi+YywqFCVvf7hWaWmPmGqsedFcsIaX
         bEwbgZ23K6OeiR5BQUHmfXNLpC0tZOZhofemcZIgCEUYNbeVoNpy2/flg37VyyMbO7/d
         kvoOB4Rb2n+OoY/W2+SiE1plq8GZLLtGcw9XddY731uTFwCbEZxD7fGCfiw0/WluCwKm
         9/Ig==
X-Gm-Message-State: AFq9FYLfDr4nfEylBVptyCec0jcUneNG1RYIT1AVq8wMBgpFo6jhFkZQ
	cQQQOc++a6mkBGo/AfJpcVKzYMrnk42VED4lJwwvm/Xd9fwZTiLaEE/wvEI6yio1HsplTnlsa8i
	pei3VdgfdhlJ7+PCGYlaymc+6oWoF2m6NGp0E28RBHvgF422EPtnulLyl5O8=
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:199f:b0:4f4:73a9:f831 with SMTP id
 5614622812f47-56382187452mr4062396b6e.19.1793290938480; Thu, 29 Oct 2026
 09:22:18 -0700 (PDT)
Date: Thu, 29 Oct 2026 09:22:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae372ba.f57e0135.1770dd.0070.GAE@google.com>
Subject: [syzbot] [kvm?] WARNING in kvm_vcpu_ioctl
From: syzbot <syzbot+da2a2f350196c7a0a389@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c339f4010dea Merge tag 'platform-drivers-x86-v7.4-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f440b1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=119e5f4d0a8d39cf
dashboard link: https://syzkaller.appspot.com/bug?extid=da2a2f350196c7a0a389
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12952929580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c339f401.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff23ecfc810c/vmlinux-c339f401.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6554a89077aa/bzImage-c339f401.xz

AI-generated root cause summary:
When a VM is terminated or marked dead (e.g., via kvm_vm_dead() due to an error
in enter_smm() or migration), the KVM_REQ_VM_DEAD request is raised on its
vCPUs. If userspace subsequently issues the KVM_PRE_FAULT_MEMORY ioctl,
kvm_tdp_page_prefault() bails out upon observing KVM_REQ_VM_DEAD and returns
-EIO. However, kvm_vcpu_pre_fault_memory() in virt/kvm/kvm_main.c considers -EIO
an unexpected internal condition and triggers WARN_ON_ONCE(r == 0 || r == -EIO).
In a production kernel without panic_on_warn, execution breaks out of the loop
and cleanly returns -EIO to userspace without crashing or corrupting memory.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=da2a2f350196c7a0a389

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da2a2f350196c7a0a389@syzkaller.appspotmail.com

------------[ cut here ]------------
r == 0 || r == -EIO
WARNING: arch/x86/kvm/../../../virt/kvm/kvm_main.c:4465 at kvm_vcpu_pre_fault_memory virt/kvm/kvm_main.c:4465 [inline], CPU#1: syz.0.17/6063
WARNING: arch/x86/kvm/../../../virt/kvm/kvm_main.c:4465 at kvm_vcpu_ioctl+0x156a/0x17b0 virt/kvm/kvm_main.c:4744, CPU#1: syz.0.17/6063
Modules linked in:
CPU: 1 UID: 0 PID: 6063 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:kvm_vcpu_pre_fault_memory virt/kvm/kvm_main.c:4465 [inline]
RIP: 0010:kvm_vcpu_ioctl+0x156a/0x17b0 virt/kvm/kvm_main.c:4744
Code: 9c 35 8b 00 be 01 00 00 00 4c 89 f7 e8 4f b1 b5 03 e9 c3 f8 ff ff e8 85 35 8b 00 90 0f 0b 90 e9 2c f2 ff ff e8 77 35 8b 00 90 <0f> 0b 90 e9 38 fd ff ff e8 69 35 8b 00 65 48 8b 3d 99 02 36 14 31
RSP: 0018:ffffc90003957c98 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff9200072af98 RCX: 0000000000000000
RDX: ffff8880355fcb00 RSI: ffffffff81831d69 RDI: 0000000000000007
RBP: ffff8880459f8048 R08: fffffffffffffffb R09: fffffffffffffffb
R10: ffff8880459f803f R11: 0000000000000001 R12: fffffffffffffffb
R13: ffffed1006abf960 R14: ffff8880459f8000 R15: ffffc90003957d70
FS:  00007f7bf8c946c0(0000) GS:ffff8880d458e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0b9aa1ee9c CR3: 0000000037636000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7bf7d9f559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7bf8c94028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7bf8026090 RCX: 00007f7bf7d9f559
RDX: 0000200000000800 RSI: 00000000c040aed5 RDI: 0000000000000005
RBP: 00007f7bf7e36b20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7bf8026128 R14: 00007f7bf8026090 R15: 00007ffcdd24ea18
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
