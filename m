Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA23E5EF1
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293854; cv=none; b=QihX6j/LSeP7mKsWnzEFEMIpvn0bI+C2lXxM8eGp7ePKRD7k3pAwD+mK49I65ojOkQpSmDxWf7R2ngbvgn0BsH5XG9gMFWSKOba+CJbZ4V8bvh13h8KdBnUWqoQU2Zat33J6HDXi0r5EaKQOuO2fmHH5DC+I+WXUUXtE9G/FFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293854; c=relaxed/simple;
	bh=DDCZ9Mqu1FH9Osr7KFh+7vfu+BuP+rNmjrrGNJm6z/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y6wtOKZYUyej32kVVcVDfbYqVbpj2AdGj/YGivO0RXyVeG9Y7FjNYGpgaB8MlRrNtlD2rzVrty7t5uQRC1fAjon6PCa8RniW4DO4sdUJ7gqV4EqDLKEu1AmSdNsf9rkNiRWspBstJ2dw8ai+SZS/yu0MD5K0PEZfJoPJ6qToNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFQSMZ4I; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFQSMZ4I"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ccca9481fb6so1721925a12.3
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791293853; x=1791898653; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F/qBmMLuBmnpwWTygvTCZyx4zAAU2cLGG3mNQcChlaE=;
        b=iFQSMZ4IZmrbzp2B5rwy6YUFa70v0vVTsKRP6H6DNrFSRRgVNVzAMpLHfGHHU+PxG8
         3CLiPouQvVhcJYVOJwAsIG5yNKB4eF317kmYFewFgGqd+dYgnzWxTEV0XjIEz4zc1BSc
         U0oqZYArWgPT/gRG6xk/psizyAbrsc1PIn9RfcMtROSDjpi4TgKocNwk+Yp4gg+7+dJd
         IOhQ1rmicFbZDMHlm2N65dy8Phtkf+pJfDdssYM6fygW+HzQbYkdOotTqfch2PUz8blH
         FXtIw84OCGwwU8n2q34RLgNx2v+dt0p81PCTQU6HZ+Qq0sbJeMkR7o70evkzx/XrNwWd
         b4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791293853; x=1791898653;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/qBmMLuBmnpwWTygvTCZyx4zAAU2cLGG3mNQcChlaE=;
        b=Mve/5GXfSnFi7GBTETpHIZvVa1CodOtRhF62nYRKdmTBLG73h1H2ULs1DtJhezZIlU
         ZkZXtaPIEMfdZ1GULV8hub06Pt00VzLwKFSUv/voinl7UT2BUMtxipEBWf708dYOHz5o
         0Sn6xSTWhcWjOH1ygOqdxFF5lJ2WzQK+l3dfoQILFs9t+b32ur37/WE4yOxEqUwAF+29
         hByjr/cdoEsUMA+tEgu+8S2rGxfJURNvcjgFA5vs9XOBQrXXS3futiCNwLvprLsqXrCM
         bbm00HzjSw6URF1XF7J0lMoJyDv4CaE7vVvr2D8LGMxMMeuC2HFfL0aNIRYTNCposmMo
         yB0A==
X-Gm-Message-State: AFuF++miXXeILsWDaTxjHcnBWkgoh/ZI8uvmVAIDAul4etJtpOVLHpaa
	7DummdO+LvN/OXFZXA8nxO/vd4a2xfn/t4Eb3iX0tAGA5JrIHcdCUoIimL8BhOyeyxNniWkouFz
	sonYoGQ==
X-Received: from pgp20-n1.prod.google.com ([2002:a05:6a02:62d4:10b0:cc7:9e1d:7d45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1014:b0:3dd:a006:7b31
 with SMTP id adf61e73a8af0-3e1247894f7mr1269961637.48.1791293852598; Tue, 06
 Oct 2026 06:37:32 -0700 (PDT)
Date: Tue, 6 Oct 2026 06:37:31 -0700
In-Reply-To: <6ac316c7.01314a6c.556a8.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6ac316c7.01314a6c.556a8.000d.GAE@google.com>
Message-ID: <asT5m8OClUbYT8ZX@google.com>
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
> RIP: 0033:0x7f9c4118db49
> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f9c411181d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f9c4123bb88 RCX: 00007f9c4118db49
> RDX: 0000200000000100 RSI: 00000000c040aed5 RDI: 0000000000000005
> RBP: 00007f9c4123bb80 R08: 38203a6b63617473 R09: 38203a6b63617473
> R10: 38203a6b63617473 R11: 0000000000000246 R12: 00007f9c4120b858
> R13: 0000200000000118 R14: 0000200000000100 R15: 0000200000000600
>  </TASK>

#syz test

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 108d42c5c1d6..31aba0c6f883 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4386,10 +4386,7 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 		}
 
 		r = kvm_arch_vcpu_pre_fault_memory(vcpu, range);
-		if (WARN_ON_ONCE(r == 0 || r == -EIO))
-			break;
-
-		if (r < 0)
+		if (WARN_ON_ONCE(!r) || r < 0)
 			break;
 
 		range->size -= r;

