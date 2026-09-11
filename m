Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F631195B
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167763; cv=none; b=DCY8vcMQHbehAQxXn4+CpqgbEJuiZd2rmExHHqCpzE7AGvBzpOAD3ggh/tizhgtLYpRh6Y48HF5CfzFpVXGw+maqsPWf8Km7tep7G3AmuyimQxdmYGvvpiWl7fuZgAWcaJHCykFm8JaPu3dIKxxGq+cYgJYMRsD+AbJgJQevNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167763; c=relaxed/simple;
	bh=pVbTlLoDm+S9jN7eKvEDSV5CsESkIuH1mUkM1lAGMtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lNd3n6lp+oqh05qBsgD5URJpqsJpfpv3H8ICbKumjuH4vE++jIdwOu2YGGyW8UuNeMc4P+/9RpE68v47DqgrhLdmi+brm1NL51HwwjmYfwVeg8IZT15mHbWSO+2mqs494nbgfO71TIBCiHpGyucLMQuoXT+nylRnk42jVYdKeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NB6TdAyn; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NB6TdAyn"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so1719406a12.1
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 16:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789167761; x=1789772561; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4sGUTYvoDW2MVTsbs//H54y6wfcBW71MO9hfW0DoGV0=;
        b=NB6TdAynkei95/K13zLvDOlzlNG0eLnoWBB/iuYM7QgbcpLJMqCo4+U/+mGJ7DsnUT
         Rjh+zXzCAPxa9n6SRBV0YibYcXE9PQiaFYO1/YK63lWwUVqRemSEYAB3Vs0MjBaRSXSk
         LtTqR+1eX1OmAVm7KcOriJr9qwIN/wwIepp+EB6FlFng6EjpI967rDeCJEYeO9hG+Vbu
         wrcRegkNyd1MEzsv1vK5Q9oOU913NIX6lauQ+9KlvO5Sl3ytYdnrCEf9Ss4HdXwIWo38
         TLfimxYK43Ut/85Z1+IBAOVUPPUfbGXR0CCvOfpCW0dkujfD5WcDQTTtVFvScOS0tws1
         zJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167761; x=1789772561;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4sGUTYvoDW2MVTsbs//H54y6wfcBW71MO9hfW0DoGV0=;
        b=VrtBrWsyNMyUdV8JL/FLB98506Kss88y54BR0M11fXQrp+V4sbJp/PC1yLv33VlH1V
         00UcBI8XMJn+ajkjltYQBPqMJVA9l42YnKhYxXYVBiMcfbOZcVsYM1mbqPYvW8n8hU5M
         //1BybvBnGRMXAYpOZWDje7mjzqRid5legY3RHDOc1BPICL0UPomnTjAvHs4qLq5XEja
         HCS1ED1UMuXnBtajLhflzTbxqC9e4zehp9cPt2T2AT9pGe27zR1X0xAVoibJ7ocnktfK
         23uu7oRz+1t8Cpqq45bU/bL7/TvOE6G7px7Uv8Wi3t0JtzgvduREjUEFRNT2MX/cT1fi
         UEpg==
X-Forwarded-Encrypted: i=1; AKwUvBya4mxGkpcxy7pfgRrkGe5JM0aOe6TceORu+84KwAlogUyFDQ/9p1GUmY3s6m6FhIe6w44=@vger.kernel.org
X-Gm-Message-State: AFuF++l9RdUvH7jPWI8z2I3PJGrNkLcLN1vvqoM6G5itzifUrhwJHdkf
	1SojGyLwhlnq5iq/S1as60ErsBpzpBM3YZ+rrkq6WPj65kSStFb+9z/aGqi70OvbdpZyFC26965
	KraF5YQ==
X-Received: from pjc7.prod.google.com ([2002:a17:90b:2f47:b0:38f:dec2:2549])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f91:b0:398:9bd5:4910
 with SMTP id 98e67ed59e1d1-39dbc7205aemr573686a91.23.1789167761268; Fri, 11
 Sep 2026 16:02:41 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:02:40 -0700
In-Reply-To: <6aa42297.f2639fcc.29487d.002f.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6aa42297.f2639fcc.29487d.002f.GAE@google.com>
Message-ID: <aqSIkEt-GqCIJh9w@google.com>
Subject: Re: [syzbot] [kvm?] INFO: task hung in kvm_gmem_release (2)
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+ab6273c58262b9de56d9@syzkaller.appspotmail.com>
Cc: david@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 11, 2026, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13db5ef9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
> dashboard link: https://syzkaller.appspot.com/bug?extid=ab6273c58262b9de56d9
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143121f9580000

The reproducer is "only" setting memory attributes on a 16MiB range.  I was
expecting a much, much larger range.  I suspect this one may be due to a problem
with the underlying GCE host?  Though it did spit out a reproducer...

> CPU: 1 UID: 0 PID: 6083 Comm: syz.4.24 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> RIP: 0010:__this_cpu_preempt_check+0x0/0x20 lib/smp_processor_id.c:63
> Code: f5 48 8b 74 24 20 48 c7 c7 00 9b 6d 8c e8 88 ac 42 f5 e8 23 ab 4d f5 eb ae 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 89 fe 48 c7 c7 80 9a 6d 8c e9 0d ff ff ff cc cc cc
> RSP: 0018:ffffc90003d27460 EFLAGS: 00000046
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: 8000000000000001
> RDX: 0000000000000000 RSI: ffff88807ea4a3d0 RDI: ffffffff8e6fe7fc
> RBP: 00000000ffffffff R08: ffffc90003d2755f R09: 0000000000000000
> R10: ffffc90003d27548 R11: fffff520007a4eac R12: 0000000000000246
> R13: ffff8880314c5dc0 R14: ffff88807ea4a3d0 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff888124dd2000(0063) knlGS:00000000f6834b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000f71e8c10 CR3: 0000000073d5a000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  lockdep_recursion_finish kernel/locking/lockdep.c:470 [inline]
>  lock_is_held_type+0xdf/0x150 kernel/locking/lockdep.c:6017
>  lock_is_held include/linux/lockdep.h:249 [inline]
>  xa_entry include/linux/xarray.h:1227 [inline]
>  xas_descend lib/xarray.c:208 [inline]
>  xas_load+0x198/0x5a0 lib/xarray.c:246
>  __xa_cmpxchg_raw lib/xarray.c:1783 [inline]
>  __xa_cmpxchg+0xc3/0x1f0 lib/xarray.c:1769
>  xa_cmpxchg include/linux/xarray.h:699 [inline]
>  xa_reserve include/linux/xarray.h:1088 [inline]
>  kvm_vm_set_mem_attributes virt/kvm/kvm_main.c:2577 [inline]
>  kvm_vm_ioctl_set_mem_attributes+0x429/0x1600 virt/kvm/kvm_main.c:2625
>  kvm_vm_ioctl+0xb33/0xd30 virt/kvm/kvm_main.c:5356
>  kvm_vm_compat_ioctl+0x2b1/0x3a0 virt/kvm/kvm_main.c:5480
>  __do_compat_sys_ioctl fs/ioctl.c:695 [inline]
>  __se_compat_sys_ioctl fs/ioctl.c:638 [inline]
>  __ia32_compat_sys_ioctl+0x5ea/0x950 fs/ioctl.c:638
>  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
>  __do_fast_syscall_32+0x27a/0x6a0 arch/x86/entry/syscall_32.c:291
>  do_fast_syscall_32+0x33/0x70 arch/x86/entry/syscall_32.c:316
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf705f0ec
> Code: 90 85 d2 74 0a 89 ce 81 e6 ff 0f 00 00 89 32 85 c0 74 05 c1 e9 0c 89 08 31 c0 5e 5d c3 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 58 b8
> RSP: 002b:00000000f683450c EFLAGS: 00000206 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 000000004020aed2
> RDX: 0000000080000200 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>


