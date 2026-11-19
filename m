Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126064;
	b=Pwj2AY29E6pJ9hPLDPZZfh8OtUr0VP+cDy0lpF5udE/Q1revd8fPcPOoQwSTPWTQ6PDx
	 RjWHFruBaPVDlnjaWAKTSq46zhJNDmUfTpT926FVIdfbiNkzmOfMAZuCGZKTGLcei+FDQ
	 0GDfCl2P7YGZrcirwlWvCbbrBy8j2qAMJQEAcz1GVsMVSi5QtfRPEXL9TZ30syc0fk3Pl
	 80WR30L7K37fMV3OAZ76Xiy5ma++KEtDog3wbhNk2uHeYll7v99zZ//uEi9p1EjbCKwVU
	 HF42IQ2I3V8gfhdso+/d7/L5ZeFxpFQcpAh7Ni/R/5UEkla/DgxfAu/wK4pMUJOZPag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126064;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=6P+RyyJwpxahGR7rDRI0rdU4ZKtS3hog8XYO8XVNAu0=;
	b=2MXdyC3i9XJ+EI0aZAGFdbaT7xQ/Gq5ITBun1ogxKyrfQB9XHIUGyU6qvwcYch00Fc4k
	 hV+wdpZQ1eegAhqG8J60LAJjMdodcN2Uxns/9cwCLmhddJJs6tvv+5inKwNEAf4F5L7uR
	 B7W1xYIGRSPnRDMdOfTdrHsxqfnyJLnAOuRJ4BEdHjRsyWIr5zyOc4j5UL8wFANygBCVz
	 E+EDIDmhQqhOvw6hGUebl6Zg2YR7MA2WrhogNRrliGskVlc7+biB/2CTDwzOSc6CBMiFz
	 L6m47kDnS30f5D8xIe0C4AmMaGW+p+pZ6a9bxVrhylUyV3IH6uJKq9pbhe0wt7OzdQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA02606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 22:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA02606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-862b952fb06so282127a34.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 14:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126063; x=1795730863;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6P+RyyJwpxahGR7rDRI0rdU4ZKtS3hog8XYO8XVNAu0=;
        b=V2LEcXwrK4L9u5AnN7q2/dLu6HolQ8GXzOXzoDn7h6WCl1yOg5LsDRzDmU79jkUFjj
         Zl7U0K/PyNWxRERmxkxSX+4tiQaWurQldy7EEZVUuaQIBSu/LuOBjQQPf7Of5uDqbhBo
         YzIPhKLHBBj58sEFS+xwje/OY86qXao8SM1yPCA7jkM5AqVvHpX0iM+SqzOVo83g8AZy
         S7pGQtuvIpPUYum0bQ6AY5kRmvuBHUCJBoMhfcJgIWD18JhPPK+dOaKfVuFodXTkEK0S
         fmwShe6Z+x/8kgqBQDtf8pI2S/D/kyWOIJY9sD9gzx8RSRivzG7Op+WIUAepqDWI9gJ6
         3VHw==
X-Forwarded-Encrypted: i=1; AL+hErFV/RJqwSXftcSEWbmU3E/gII3XuXYhS1fcifKzXK8JJA6yofe6UfDvEkj/PtISOF9fwE4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0WFhH+cDh/zALbCtAmzafpUeBLj3CwQ99jLPrNSNCowA8dVk3
	vhC4xuiebmHL5hEmKZDpPuh/UPW1hg0zGvl0MpYTzqS02fSedgDt6Gs5nk3eBm9uIh9b/2fFDVy
	xzBDm00zsVOQ6GOugCHworniyOS9vtIiYU3EhA3QJoy/+J/NuDFxCSmKfTpg=
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:244d:b0:55b:f88d:6e8b with SMTP id
 5614622812f47-57a0a10c8b9mr1833089b6e.13.1795126062844; Thu, 19 Nov 2026
 14:07:42 -0800 (PST)
Date: Thu, 19 Nov 2026 14:07:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aff732e.d9dac7f4.1ece0.0000.GAE@google.com>
Subject: [syzbot] [kvm-x86?] WARNING in __nested_vmx_vmexit
From: syzbot <syzbot+483ee9b97423483ca602@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7475ea8b5861 Linux 7.4-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12372a4e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cf189394a856f11
dashboard link: https://syzkaller.appspot.com/bug?extid=483ee9b97423483ca602
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1360d4d9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17839409580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-7475ea8b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/db4e8a9a4461/vmlinux-7475ea8b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2abcfcabee20/bzImage-7475ea8b.xz

AI-generated root cause summary:
When an L1 vCPU encounters a hardware VM-Fail on VM-Entry, `vmx_handle_exit()`
processes the failure and returns KVM_EXIT_FAIL_ENTRY to userspace without
clearing the `vmx->fail` flag. If userspace then calls KVM_SET_NESTED_STATE with
KVM_STATE_NESTED_GUEST_MODE set, the vCPU enters guest mode without resetting
`vmx->fail`. If the VM is subsequently torn down without another KVM_RUN,
`vmx_leave_nested()` synthesizes a nested VM-exit where `__nested_vmx_vmexit()`
observes the stale `vmx->fail == 1` and reads VM_INSTRUCTION_ERROR from vmcs02
(which was never launched), triggering a WARN_ON_ONCE because
VM_INSTRUCTION_ERROR is not VMXERR_ENTRY_INVALID_CONTROL_FIELD.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=483ee9b97423483ca602

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+483ee9b97423483ca602@syzkaller.appspotmail.com

kvm_intel: set kvm_intel.dump_invalid_vmcs=1 to dump internal KVM state.
------------[ cut here ]------------
vmcs_read32(VM_INSTRUCTION_ERROR) != VMXERR_ENTRY_INVALID_CONTROL_FIELD
WARNING: arch/x86/kvm/vmx/nested.c:5149 at __nested_vmx_vmexit+0x2734/0x4000 arch/x86/kvm/vmx/nested.c:5149, CPU#1: syz.0.17/6007
Modules linked in:
CPU: 1 UID: 0 PID: 6007 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__nested_vmx_vmexit+0x2734/0x4000 arch/x86/kvm/vmx/nested.c:5149
Code: ff ff e8 0f a0 67 00 90 bf 0e 44 00 00 e8 c4 ed f8 ff 90 31 db e9 01 ec ff ff e8 f7 9f 67 00 e8 f2 1b 48 0a e8 ed 9f 67 00 90 <0f> 0b 90 e9 6a ff ff ff e8 df 9f 67 00 90 bf 00 44 00 00 e8 94 ed
RSP: 0018:ffffc9000338f960 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802c514b00 RSI: ffffffff81a6e113 RDI: 0000000000000005
RBP: ffffc9000338fac0 R08: 0000000000000007 R09: 0000000000000000
R10: ffff888035f7003f R11: 0000000000000000 R12: 0000000000000001
R13: ffff8880382442ec R14: 0000000000000000 R15: ffff888035f70000
FS:  00005555645d0500(0000) GS:ffff8880d4571000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b5cc929ff0 CR3: 000000003db67000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nested_vmx_vmexit arch/x86/kvm/vmx/nested.h:46 [inline]
 vmx_leave_nested arch/x86/kvm/vmx/nested.c:6895 [inline]
 nested_vmx_free_vcpu+0xb3/0xd0 arch/x86/kvm/vmx/nested.c:389
 vmx_vcpu_free+0x94/0x340 arch/x86/kvm/vmx/vmx.c:7519
 kvm_arch_vcpu_destroy+0x159/0x3e0 arch/x86/kvm/x86.c:9558
 kvm_vcpu_destroy virt/kvm/kvm_main.c:477 [inline]
 kvm_destroy_vcpus+0x24e/0x3c0 virt/kvm/kvm_main.c:497
 kvm_arch_destroy_vm+0xc7/0x230 arch/x86/kvm/x86.c:10129
 kvm_destroy_vm virt/kvm/kvm_main.c:1313 [inline]
 kvm_put_kvm+0x556/0xc00 virt/kvm/kvm_main.c:1350
 kvm_vm_release+0x65/0x80 virt/kvm/kvm_main.c:1375
 __fput+0x3fb/0xb50 fs/file_table.c:512
 fput_close_sync+0x118/0x250 fs/file_table.c:618
 filp_close_sync+0x75/0xa0 fs/open.c:1574
 __range_close+0x4a6/0x8b0 fs/file.c:919
 __do_sys_close_range fs/file.c:1003 [inline]
 __se_sys_close_range fs/file.c:954 [inline]
 __x64_sys_close_range+0x1f8/0x430 fs/file.c:954
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f6ab9fb19
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0931e598 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: ffffffffffffffda RBX: 00007fff0931e680 RCX: 00007f5f6ab9fb19
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000000e232 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b2fb20000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5f6ae25fac R14: 00007f5f6ae25fa8 R15: 00007f5f6ae25fa0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
