Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E972FFDEA
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973571; cv=none; b=nBIa5k0qh1Fon8OEgCyw8fMO7WgGT1t+uYmwOiRUIRWewHFUBxWymHGFxhtIVqpLZX9kS4HnO8n4yPX00MhI7kisiMKbmb6rMIR0dJFBZbh5FKTo0PWoJwjNqUWyjPiETyiUFnlVymrg1RtK7Gp9HE/ehqjIjfvLHVmv5iRcgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973571; c=relaxed/simple;
	bh=S0ge2C9Y15thBhCiKs8x41HME8Zo3cnqn4nPcWu4Sog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NVjR9mZnmviw4N+UZboMy9EzejC/wsUtlOQsOaAjtXNmd7WqspydpNryGFKuAtEK57c9hawyeLq2/fBlutJcZKFEz71NJuDc7vNCclIfJ2BQmY8MlyzBcyZc0YNMNIxbjBQDGUA7ozwRmCE7npzojOLGLb2jU48o0IFuSS7Wn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBJvUis5; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBJvUis5"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db3d832827so12925ad.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790973566; x=1791578366; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0j9tHQdvgPyeE7kOurEk+4M8mVRW7MJtC+t0YWufic=;
        b=SBJvUis5KY8wXHSaIN/u2BXJhx9DSZbbjTIt2n4EFKuapooE1lve5HESVD+Ib9GUmW
         GEwA2Ci68XirUnpDcjOxW/wMBE8SYcHmI9fIAc7mTom25WJFkWU+tYht7/HlUXg5XvNL
         RTyEQhaSb8AbJYL0qNfCzHfJx5KMcQ3cTpI7FhkIZBPo6BSNtxTri/9Z/KLbYzS+0oyN
         oWOLaiXk5gIEX7rpdjaTxYLa2lfqQWx0Weu+8GSLvNodFw0NEI5m3QJZQ5OJH/1+ehN+
         Js4aJCXdkVpvXmXz6qJDIN/0uXJ5U48pRSZnkjXTrLVPopyKa6wb5Etlk34WGrI5qhaD
         Kr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790973566; x=1791578366;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0j9tHQdvgPyeE7kOurEk+4M8mVRW7MJtC+t0YWufic=;
        b=k34Xb6PPAr3XneIp2JWiut5nerqez2/dGWfRKasSLZWNFW0QxUtVaaG4GvDvK+lzmO
         fQPRTtqIfjqSwPbTuCDVDu3vSxZ6fbiOTIekBYi2QAJqAGL3Nr5UL+BO48UsgCtlAnGJ
         CLSv82BtTkpMoFJvLvQau9BdM6B9nSJ+QVh78oPIqlpEcx0FyA8hSmIcSmsfPr6DBepB
         XhG2x6IVYILq8qDT7IhjHYKE8faJVPeFjqoPStQj5nyriGbS2c/x+4RPc6AYKp9k6xMk
         WmUpi5CC4IJrHE6v8Vj+aYS5J07k7XQHQ0Wg1CeppLn/whGmi0F332nwyvURHbuf0MS/
         dsfg==
X-Forwarded-Encrypted: i=1; AKwUvBzBg8m+EJRhVMGDvn01RpI1YExpMu23/A0QbyOmWDaOIMGha92QDqfsFWCfO+jl2ALyk7k=@vger.kernel.org
X-Gm-Message-State: AFq9FYI++sIDvZKs0vV+eSF57Hk1qQPCpneUvenolYDD1xdrsjdiAWea
	wNeQQo38IlxWs+xfqOFDPZsfUPVDnt0SIVgjq6ryMRu70laQnSRKakLrVQJsIyc9jG+hMajk1zQ
	P33rRgQ==
X-Received: from plhd13.prod.google.com ([2002:a17:903:230d:b0:2df:8053:e258])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18b:b0:2e3:1bb4:611d
 with SMTP id d9443c01a7336-2e49b6771e7mr42633885ad.49.1790973566345; Fri, 02
 Oct 2026 13:39:26 -0700 (PDT)
Date: Fri, 2 Oct 2026 13:39:25 -0700
In-Reply-To: <6ac0145f.34119e79.2f92f3.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com> <6ac0145f.34119e79.2f92f3.0003.GAE@google.com>
Message-ID: <asAWfZ0N1MXgwQtn@google.com>
Subject: Re: [syzbot ci] Re: KVM: Fix+harden against bad uaccess using dying VM
From: Sean Christopherson <seanjc@google.com>
To: syzbot ci <syzbot+ci69d67bf25886d3bd@syzkaller.appspotmail.com>
Cc: jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, npiggin@gmail.com, 
	pbonzini@redhat.com, syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 02, 2026, syzbot ci wrote:
> ------------[ cut here ]------------
> !__kvm_can_do_uaccess(kvm)
> WARNING: ./include/linux/kvm_host.h:1360 at kvm_can_do_uaccess include/linux/kvm_host.h:1360 [inline], CPU#1: syz.1.18/5858
> WARNING: ./include/linux/kvm_host.h:1360 at kvm_is_guest_access_ok virt/kvm/kvm_main.c:3216 [inline], CPU#1: syz.1.18/5858
> WARNING: ./include/linux/kvm_host.h:1360 at __kvm_read_guest_page+0x38e/0x440 virt/kvm/kvm_main.c:3226, CPU#1: syz.1.18/5858
> Modules linked in:
> CPU: 1 UID: 0 PID: 5858 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:kvm_can_do_uaccess include/linux/kvm_host.h:1360 [inline]
> RIP: 0010:kvm_is_guest_access_ok virt/kvm/kvm_main.c:3216 [inline]
> RIP: 0010:__kvm_read_guest_page+0x38e/0x440 virt/kvm/kvm_main.c:3226
> Code: f2 ff ff ff 0f 44 d8 31 ff e8 5e a4 89 00 89 d8 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9 09 ac a8 0a cc e8 83 9e 89 00 90 <0f> 0b 90 bb f2 ff ff ff eb da e8 73 9e 89 00 90 0f 0b 90 bb f2 ff
> RSP: 0018:ffffc90003157778 EFLAGS: 00010293
> RAX: ffffffff813e2d22 RBX: 0000000000000000 RCX: ffff888174382580
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 1ffff1102217d82a R08: ffff888110bee183 R09: 1ffff1102217dc30
> R10: dffffc0000000000 R11: ffffed102217dc31 R12: ffff888110bee180
> R13: ffff888174382b40 R14: 1ffff1102217dc30 R15: 0000000000000000
> FS:  000055557c0db500(0000) GS:ffff8882a8cda000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f458dfeb840 CR3: 000000016c9d0000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  kvm_vcpu_read_guest+0x64/0x140 virt/kvm/kvm_main.c:3284
>  nested_vmx_load_msr+0x133/0x4d0 arch/x86/kvm/vmx/nested.c:1107

Oh man.  vmx_leave_nested() is so broken.  If loading MSRs on nested VM-Exit is
broken (and it obviously is), then storing MSRs on nested VM-Exit is also broken,
i.e. there's at least a second case where nVMX can write to random process memory
on vCPU teardown (shadow vmcs12 being the other one).

It probably makes sense to go straight to open coding punting the vCPU out of L2
in vmx_leave_nested() instead of hack-a-fixing a bunch of flows.  I.e. replace
patch 8 and 9 with a proper fix.
