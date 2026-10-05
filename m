Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0FF23E325
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172364; cv=none; b=lt5D0busrThRg4fPy8SnZORPQK51G7TodPfVsoaYum90H0vuyuyPLsHmX4SEihrKoUZCPNIDb6XO3FTfQen7pMdXSF5AD68hmJus2hNLBs4ZxTtY91/I1RSuDcrXX82yME4vxIEKHT4//ZMOBUtx6IhljoXEDBB3zsKplV0I6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172364; c=relaxed/simple;
	bh=s2zh7kQOYUOfo5+PW6vusZ44faTYrMQ/g2KGrtLTDJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gI23WobTf2Z2RxfBy76A8PfJutVMCQeSO0lcv+rLRg69yX5EkT//Ay6yco1VU6aV7WJ3wz2Qi3pUpssV4qsVORsb/s1q/z4OXV9r21FbG8Phb08JywDYSqYV6txAIv3zcaKIa5EIbbObQkz92BD26wfsJxMUSWC84vJE9viB3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ucag5UES; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ucag5UES"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-88c768885b0so810300b3a.2
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791172362; x=1791777162; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eT9i+7cM2ZrBnjrZ9dBZbNh3S/dmFUNTqgnErmGrbH0=;
        b=Ucag5UESzUD4xkep/u/x+cHYaLgIlz1kG/KZVOTHTx5dZ/ki8OoppleI6J/mNtdG7N
         UT2e26ttqc7FrMRWJ0CKS2PmmodidcpOYTDMcLTQfOsmgUMiejy3MuvBQ2bqXtL6CyMm
         1kfmbRzkAWvzPWfrwnr/yRAEhQeeiNbpuPabXUwxwC5EzbaCflnenYmnhxQ9gpangCKf
         IdcKDNT+Mw24KkDddKzsmDEtVeKQUvS0ZjRNkkO9A02KILnoyAIQENa7KINiTHjh+g3J
         Oj6CbY1FM37cTeSlzjQTgKiXL4Rfl8sIbbhDCJAa0psPlDX3b6fRMRnpT1VP+yzQRyBL
         D4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172362; x=1791777162;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eT9i+7cM2ZrBnjrZ9dBZbNh3S/dmFUNTqgnErmGrbH0=;
        b=YoRLmPvwS61lNqcpRJo101Vsh7LzLc+DCoME/VoJHqWO8M7rzsrHQ9vqz4ql5BnO30
         +MHu4EWhccGq10TLUSCGIPyStdFYn/CQA+fhtK1TBPuRdwOp8B8pzrTcl2gI6C8ZSt0q
         kA31GeFZ5Fw1Pk//FGwwggDbLgcLQ5LCCjDRRsg0NMGjD8T3VDRi2k6FeOTFmQd5qtV1
         BqF+x0rU8qNNwPe2Nm4gGtBgmkmRDVfRsZ/wgmye8A7YCQ0JtQhbcMyBui07cd6EuaTM
         pnGoZTP2TupqZLV3TM9YDVvmiKRc7r65Y7GzurYYDBM2wz7To0kW/GWs0TTgGx3WgAim
         rJ+g==
X-Gm-Message-State: AFuF++nOjM9c3eM/Dvb/3uANnnm3H6rZOB+CCd3JnNR4hUZjThbsJP3b
	MdY3+Tqbp7wNfniJyzHviMqJgKL+AEAJx0W7gC56kfc+namxVro8ukSgOWvOVj9REbDJS0U+mi8
	y2MjreA==
X-Received: from pfbhu44.prod.google.com ([2002:a05:6a00:69ac:b0:88f:275d:43a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:759a:b0:88d:20ff:15c1
 with SMTP id d2e1a72fcca58-88d20ff2bd5mr4191394b3a.18.1791172362021; Sun, 04
 Oct 2026 20:52:42 -0700 (PDT)
Date: Sun, 4 Oct 2026 20:52:41 -0700
In-Reply-To: <6ac316c7.01314a6c.556a8.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6ac316c7.01314a6c.556a8.000d.GAE@google.com>
Message-ID: <asMfCUiPnW-GGu5J@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_vcpu_pre_fault_memory
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Oct 04, 2026, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ce1e0223d8ad Merge tag 'devicetree-fixes-for-7.3-2' of git..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1353dbf5580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d4242cb1c54cdf7
> dashboard link: https://syzkaller.appspot.com/bug?extid=db7bd0f41c2a7e82d4ba
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cdf6c9580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cdf6c9580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/217b0c1b14ee/disk-ce1e0223.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/335343cc5803/vmlinux-ce1e0223.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/760ef2f39df0/bzImage-ce1e0223.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> r == 0 || r == -EIO
> WARNING: arch/x86/kvm/../../../virt/kvm/kvm_main.c:4389 at kvm_vcpu_pre_fault_memory+0x45d/0x470 virt/kvm/kvm_main.c:4389, CPU#1: syz-executor267/8523
> Modules linked in:
> CPU: 1 UID: 0 PID: 8523 Comm: syz-executor267 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
> RIP: 0010:kvm_vcpu_pre_fault_memory+0x45d/0x470 virt/kvm/kvm_main.c:4389
> Code: fe ff ff e8 85 2e 88 00 90 0f 0b 90 e9 0d ff ff ff e8 77 2e 88 00 e8 42 85 f3 ff eb 8f e8 6b 2e 88 00 eb 05 e8 64 2e 88 00 90 <0f> 0b 90 e9 a7 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
> RSP: 0018:ffffc900024dfc28 EFLAGS: 00010293
> RAX: ffffffff813fe025 RBX: ffffc900024dfe00 RCX: ffff88807fcc0000
> RDX: 0000000000000000 RSI: ffffffff8eaf6510 RDI: fffffffffffffffb
> RBP: dffffc0000000000 R08: ffff88807fcc0000 R09: 0000000000000002
> R10: fffffffffffffffb R11: 0000000000000000 R12: ffffc900024dfe00
> R13: ffff88807fcc0000 R14: 1ffff1100ff98000 R15: fffffffffffffffb
> FS:  00007f9c411186c0(0000) GS:ffff888124dc7000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9c4116312d CR3: 0000000026a4a000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  kvm_vcpu_ioctl+0x8a6/0xfd0 virt/kvm/kvm_main.c:4668
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

I haven't tried the reproducer yet, but based on code inspection I'm pretty sure
the kvm_vm_dead() call in enter_smm() is colliding with commit 958810a09412d
("KVM: x86/mmu: Bail out kvm_tdp_map_page() when VM dead"), especialy since there
is SMM setup in the reproducer.

I'm think we can and should just drop EIO from the WARN.  It showed up in v5 of
the original series without any real explanation.  v5 did add -EIO as a documented
error code[1]:
  
  v4->v5:
    - add EIO as possible error

in response to Xiaoyao's review[2]:

  > +	case RET_PF_CONTINUE:
  > +	case RET_PF_INVALID:
  > +	default:
  > +		WARN_ON_ONCE(r);
  > +		return -EIO;
  
  Need to update patch 1 for -EIO
  
  > +	}


but AFAICT that was just talking about the documentation.  And at the time, KVM
x86 already WARNed when returning -EIO, so I've no idea common KVM also WARNed
on seeing -EIO.

[1] https://lore.kernel.org/all/20240710174031.312055-1-pbonzini@redhat.com
[2] https://lore.kernel.org/all/d5a6e125-bff4-4d82-ae65-b99d9cb10e90@intel.com
