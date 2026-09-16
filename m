Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D964FB9DF
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567710; cv=none; b=f63Td/4AzuarmSGekczcU5VzzMT1a72zrtXKoH8qR105xmnR6tkCbvSYN9YmgDXwy8Dpd1Dzid2iMEFL91oRX7fh4DTpIhNh/fRNOTHhrWzTsduAa2D6BhG+nVauIdxPWH/C6HwSpbvOvKmwgiyFYBp4vvt8jzJfHJ35qbcqo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567710; c=relaxed/simple;
	bh=qn7QE2Vhw0BaRhEZiS9hTTSjPpHUeCBsathFgkcuJMg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FNb0Lgj9/9gqZiNFVxIvzJp3mmJ1Xm1OtFikNnjxi/mjsoZEmt3T+gLVUyFIQI2lZOWSxDkHVff1+RZBYCUgC65fLJaJ2ucnMLpSdN1Z6Ze1wdVzV7YUIWzUYMUboulZjZlUsCBJocgmt/lu6AqDiZhetCYMKh2GkluDXOeFi6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4b94bb43008so924853b6e.0
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 07:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789567707; x=1790172507;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=htUCy0q7FG4YSd/XI01PpxHhl9O1HtPtmWa1pKHUGLE=;
        b=yMawPqGN94vMoezmg6QEI45v831fe+Wk+zpCswesl/AMQ6vPvPvuKVcD3aCCtry4Gw
         Lb0Ues7b361xkRUCHfEthdzx4RjIHNL4xff9fzUg/4RgR8fBZY2cT97o+n8pDvGWAaqF
         P7lMZdh0k8Jp8xTvtbAoD5hjGccuZvRck9M/QyTjdpEGdorLlHUAo3in1X0Nv755Tdec
         GB4EsRetxte6eZNRj6S9UtUQ1wU10KG6VHBhVibUEk+tAKtylFBaslIakIOFjLAt2ZG9
         kO+dbMBGUGSwlJw4pnRoOxJ1QQND2HqSojlDfa09dq6izChJDQIR4zZbxw2f4bkleqwP
         kjEA==
X-Forwarded-Encrypted: i=1; AKwUvBzVF7ju9ae0GUIg2vt8FNK66kkggf8cMUEnjRyZNlVn6zmjxyqVWDTyGH3KxyoGLrBe+GI=@vger.kernel.org
X-Gm-Message-State: AFuF++kOW/E22tN2H/V9wFzraS4p71HgUaVFCx/ZEA/d5JpMZPtUOVDF
	Ot+xsxfrFXcLLCSRpuVvAKky0hbxAXjSxS4RiDedGWqx2Oa7SAR1hq35cRtlLLB1rEucj9+kPvL
	2CChFAwhnIGNn1F7sCiwRiC1pCbnRbaUS7QXzU/E383YN7bWrgtK3nnKDEuQ=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81c9:b0:6be:4eb3:e1c0 with SMTP id
 006d021491bc7-6c7d3fe744bmr2517440eaf.45.1789567706922; Wed, 16 Sep 2026
 07:08:26 -0700 (PDT)
Date: Wed, 16 Sep 2026 07:08:26 -0700
In-Reply-To: <6936812a.a70a0220.38f243.0090.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aaaa2da.86093f18.33004f.0001.GAE@google.com>
Subject: Re: [syzbot] [kvm?] BUG: sleeping function called from invalid
 context in kvm_mmu_notifier_invalidate_range_start
From: syzbot <syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, dwmw2@infradead.org, 
	dwmw@amazon.co.uk, kvm@vger.kernel.org, liam.howlett@oracle.com, 
	liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, ljs@kernel.org, lkp@intel.com, 
	llvm@lists.linux.dev, lorenzo.stoakes@oracle.com, me@brighamcampbell.com, 
	mhocko@suse.com, nogikh@google.com, oe-kbuild-all@lists.linux.dev, 
	pbonzini@redhat.com, rientjes@google.com, rppt@kernel.org, seanjc@google.com, 
	shaikhkamal2012@gmail.com, shakeel.butt@linux.dev, skhan@linuxfoundation.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9b87fdc9af2f Merge tag 'sched_ext-for-7.3-rc3-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f46bf9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f23925580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f23925580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d9d20c79bd3c/disk-9b87fdc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a6a8f176798/vmlinux-9b87fdc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db8864d1c812/bzImage-9b87fdc9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 38, name: oom_reaper
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
locks held by oom_reaper/38: 4, last CPU#1:
 #0: ffff8880370147b0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:619 [inline]
 #0: ffff8880370147b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task_mm mm/oom_kill.c:566 [inline]
 #0: ffff8880370147b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task mm/oom_kill.c:609 [inline]
 #0: ffff8880370147b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reaper+0x2b4/0xc10 mm/oom_kill.c:650
 #1: ffffffff8e30af80 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: mmu_notifier_invalidate_range_start_nonblock include/linux/mmu_notifier.h:495 [inline]
 #1: ffffffff8e30af80 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: zap_vma_for_reaping+0x193/0x380 mm/memory.c:2266
 #2: ffffffff8e30afd8 (srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:198 [inline]
 #2: ffffffff8e30afd8 (srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:305 [inline]
 #2: ffffffff8e30afd8 (srcu){.+.+}-{0:0}, at: mn_hlist_invalidate_range_start mm/mmu_notifier.c:515 [inline]
 #2: ffffffff8e30afd8 (srcu){.+.+}-{0:0}, at: __mmu_notifier_invalidate_range_start+0x5c6/0xb80 mm/mmu_notifier.c:580
 #3: ffff8880465ad560 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #3: ffff8880465ad560 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: kvm_mmu_notifier_invalidate_range_start+0x1b6/0xc10 virt/kvm/kvm_main.c:745
CPU: 1 UID: 0 PID: 38 Comm: oom_reaper Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x31b/0x470 kernel/sched/core.c:9257
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc2/0x400 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 kvm_mmu_notifier_invalidate_range_start+0x1b6/0xc10 virt/kvm/kvm_main.c:745
 mn_hlist_invalidate_range_start mm/mmu_notifier.c:525 [inline]
 __mmu_notifier_invalidate_range_start+0x709/0xb80 mm/mmu_notifier.c:580
 mmu_notifier_invalidate_range_start_nonblock include/linux/mmu_notifier.h:498 [inline]
 zap_vma_for_reaping+0x1f7/0x380 mm/memory.c:2266
 __oom_reap_task_mm mm/oom_kill.c:548 [inline]
 oom_reap_task_mm mm/oom_kill.c:585 [inline]
 oom_reap_task mm/oom_kill.c:609 [inline]
 oom_reaper+0x519/0xc10 mm/oom_kill.c:650
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
oom_reaper: reaped process 8617 (syz.2.1028), now anon-rss:0kB, file-rss:72kB, shmem-rss:0kB


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
