Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794951121;
	b=VAmmHxTotftAYnbNJ7iESA3JNz1UTsUuZ4x4Hoh0g6LEC+o+f+GETLCHVUHZJIjQjb+1
	 iEctAVunslH60sPaNFNHT8k3odSem6DeVpRSSiGuCki6jJrBIJisLT6q6VaKDPmPXskRQ
	 pQaWNIVAWVV8Neyxd+ByP2Vv588ks56Ccnb018Pzg3B4/hI430FBtbvgeG8XluRJrNsIH
	 tVA8rmrwf87Iv2Pm7SeNwJv/zjgAPduTAcpmfyx4yDQp+gK9VqWePXBHkGjZYf0nXK5V7
	 FBrlUUDdknX1d2jZhskUbSXJuAYbGlLs2DK5uWeUfOKIYBUGr6LVWJYHFauRa9kunmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=B7xLf94htoLObSBPI81qpSW6fILxkkeL+R1ouXhRrTk=;
	b=LkPuQ1xwfWJ96Gu5Vw14cdXxTLNk1egIlqY3M6wDP+SZ/AHQ96PHATgUq+EMS2YXj1dp
	 KDKrYIvpAQY1VkvXupUVQLuFYbUIkLqg7fRRXBjQMmRFns20glcLfTTWOodFnzaByhx2M
	 iIcAkwfcU4dZ5YMFZeol27q4AD1qUO62W2gI32B6cEURLM0QmaSGRttRuOBxSjpDZKnq7
	 4QvI0kI1eMx2tVkMhDky3iNzr9fgnpLo/jtehjAgVmF+O1Se9hJhf8xuxcanOPvNhUyzD
	 kTvgvHTp1ODjOOs7gdc+pgI5fsQ+Ho4xOln7v9u/YDhfKPo/qSivh0g0qKE62DdD/hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="eiudZg/I";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC9606A331
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BDC9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eiudZg/I
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40f29667e6so30016166b.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:32:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794951120; cv=none;
        d=google.com; s=arc-20260327;
        b=E/zv0nTPRqMOMyDVCWyE2n/mOjziBWpOx2sUevBnhLSZU7v4XJ8o4F/Px15SNofCnK
         yQPOe5Z35dcUunNVXXDXzRR6S1v4WOnVWY7Y1kxPRcfB2V0EhfySvbp7X944f13m7lxp
         YD7ln5ifAldj3f5nyDNk5oNj3XxzqIIGsguM39KY3l2qZvsthRxeNIg8oB+wOA2LBCmI
         xQo00nfnxJLBpLoKHCL4v77mUTAl6VzYrC8dioCRTO2YCR/clJ3G6aVNgZEKYfE9S4l6
         ZAv+UM/867E6ZTFF2w9WJ/TTuHYAcy7VotUUA2Qa46Svf9vVtuz+tv8T2Ozmbtw1Cddy
         5b5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B7xLf94htoLObSBPI81qpSW6fILxkkeL+R1ouXhRrTk=;
        fh=u+9vB+cDzKmx0nGu75VEXOQx8Z6OV2oRd/Rs5qScGZA=;
        b=B69m9vT243SXEtKOXU/APjXSCj2FUj3G9hVj0FkXgNGTQtUnYTyPonAVoM2rbO27u7
         uDp8Z+IeZ8YQA8WxM54bD7bTS7rSckSux4+kQMtjdnQqG7AtNIsd96SDaEbQvLS7FH51
         30oTuYCgOe/Fo/Hk6HZ84PlLr6EO6ARr7zFCFguQPOwc2cZDWpyTzrNiUs2E7dQGp2vi
         KvGgv7P3ARzHnjaefGPaReEr6Bjf5uz/JotMAhDt5vyJ1I6c43pYtBKLcLZpVXMfjhrb
         yznljt91YneEDSEA5+mcAEjdRkYwyfGEIeACy7z4/eBW6v9VaXo5xKPztj/z4TzYRTBI
         Kr9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794951120; x=1795555920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B7xLf94htoLObSBPI81qpSW6fILxkkeL+R1ouXhRrTk=;
        b=eiudZg/I6LmnHOR9/TL994jv5j1td1odizQeKMZle1ZMiazbnZgAUzl3EpU2y9Mlok
         IZbJPbXG/1xKLWormHjDTBxmvWnAM2Osm/AiaUjpjy2q15ZU4InYW3hPAGKK3SZI+zT9
         M9QCKjIkdIvDOgO9KRq9quiKKQUpoo9SFdoNi+FvS5mSOiaMfrRmBJ/Q2iGbEMPXg3lb
         giebI5SqEL2gHjpLQHD37scpdxJggyH6O0SIRIsyCH5VwP81Wf9jsXI7IPIIU29pU9rB
         RsVrUtBxQNkcrUT9DTxDHpVa6+TMOVSOpHHVP0SjsVPIBJDs2X4moKsUHUZbOjJULk0+
         hy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794951120; x=1795555920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7xLf94htoLObSBPI81qpSW6fILxkkeL+R1ouXhRrTk=;
        b=VVcTgZtdY5mWc5a5nf4iY3gG+NKwGZSUnzuaZaYPVEezCNlJe4KZiHBevlNW/O/fYz
         mk1C0hBOezlky5y1aOgpC5Rp4S3knchylvTaRehmXAQuL/d413R9muoTE7c6r0yuAPIJ
         YVPTlqF8UyjI3SJLRZLjPonZ84+I2I3G6MGe4pKSEYun1/NvYVVyu2MzAmUfLagmVy/C
         Y7C2zxMtEGwok0i8RuTjoTqIkC2vNk+UI4maK7BiiWiVlpTZGfLZCXJzvWjZFmT7EmCh
         Yq3G1wNbatns9bmu7L2btOGDcStvZmC+/d5piCMmCNpyyN/SDx4bQqcpbmHuPldfWQ+S
         a2RQ==
X-Gm-Message-State: APuU4Z9podBldXuEDdjXX0ht44szhSDJPbvyhUP1jIuGOiQPkj07JoKJ
	7nqzapHIVRBOxtQucPJKvKe6p90kW04FYNCsrBaY5ax4QeryuG3Ur05jLHYi3bSBkexn+dP7eeB
	YZruxOrNCipgJK2l4cObKUutEaFg4Zm/wo3iUDk0V
X-Gm-Gg: AYBFou06w3LW/7oUiFxpfZ9zVzPRwYmXanFVSJuMUwbJ5rAAWOYuTuG4mU8LSpNfl0H
	kcpsWLMffKPGt3pMBY8qRbh4mmY/oWm8Gc13uSjLAq8pApik8GdweUiRTHaNt95SReY8pl7KJcF
	dYTJO6uux7I/5MUdHhzP3MtWQBtgOYbbf8ToEZjXS4FPyfKlgYPz3ov2mq8dFZGMo0ewO8jLUiu
	73YFvUBaGXkCKQWXcmVmOkOTKKuCzsA1U30p882O2z5ewhyKzt8IXNWZdwCHWN9s2QF1T4p5U3Z
	3f1n85bV+Qvi0q4snVX8GwIpufOm7r6k4n/wR8ylR6KX/8Wmi5yBKI33+qk4q/g1bOM4hCznw1D
	wAM/vssMntiF6PMH0WxCo32lb9c+83SeLROhRa+LqfRsT4rjcTBm5KVcGXrwqelm8syyQaEhquY
	BSRqmiFsGJrHYRGWBPFG3HjZviousJTvD43UR9uvHO1WfuWkS+sOPHo9tXTVFKl2UWN9L+WtalM
	o6dosUG
X-Received: by 2002:a17:907:9805:b0:c40:4848:f7fa with SMTP id
 a640c23a62f3a-c510e563fc5mr38867966b.44.1794951119176; Tue, 17 Nov 2026
 13:31:59 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6afbad4d.f3cfa7c9.844a4.0002.GAE@google.com> <6afc757f.6a9a30c8.1f5211.0003.GAE@google.com>
In-Reply-To: <6afc757f.6a9a30c8.1f5211.0003.GAE@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 17 Nov 2026 13:31:22 -0800
X-Gm-Features: AclHuK-mQfOt6xf_AE9IEd0i5-njzqVyPoo6411iIz3N-PqchfLdoPzuHJk7sjE
Message-ID: <CADrL8HU_L2kph5c1xUw4oH-Z==raYBSRbni1ATtQ5JwMG4_JUA@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_dirty_ring_push (2)
To: syzbot <syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com>
Cc: kvm@vger.kernel.org, lei.cao@stratus.com, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, peterx@redhat.com, seanjc@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 7:40=E2=80=AFAM syzbot
<syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    749a4de37040 Add linux-next specific files for 20261116
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1341e5c358000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfedda7175e1c0=
b47
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D55eaa971f4924b6=
2c9a5
> compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.=
8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D139fd73d580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10c1e5c358000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9bd53057353b/dis=
k-749a4de3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a0d84c6a978c/vmlinu=
x-749a4de3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7e9b601ca025/b=
zImage-749a4de3.xz
>
> The issue was bisected by AI to:
>
> commit fb04a1eddb1a65b6588a021bdc132270d5ae48bb
> Author: Peter Xu <peterx@redhat.com>
> Date:   Thu Oct 1 01:22:22 2020 +0000
>
>     KVM: X86: Implement ring-based dirty memory tracking
>
> AI reasoning:   https://syzkaller.appspot.com/ai_job?id=3D8ec79404-c0f6-4=
141-a152-96124787ad82
>
> AI-generated root cause summary:
> The KVM dirty ring implementation maps the per-vCPU dirty ring buffer
> (ring->dirty_gfns) writable into userspace. In kvm_dirty_ring_reset(), KV=
M
> iterates over entries marked with KVM_DIRTY_GFN_F_RESET and increments
> ring->reset_index without verifying that reset_index has not advanced pas=
t
> ring->dirty_index. When userspace sets KVM_DIRTY_GFN_F_RESET on un-dirtie=
d
> entries, reset_index surpasses dirty_index, causing kvm_dirty_ring_used()
> (dirty_index - reset_index) to underflow to a large 32-bit unsigned integ=
er
> (~UINT_MAX). On subsequent guest memory writes, kvm_dirty_ring_push() che=
cks
> kvm_dirty_ring_full(), observes that the used entry count exceeds ring->s=
ize,
> and triggers the WARN_ON_ONCE(kvm_dirty_ring_full(ring)) assertion.
>
> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=3D55eaa97=
1f4924b62c9a5
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com
>
> The cause commit was identified by AI and may be wrong.
> If you agree with it, please also add:
> Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory trackin=
g")
>
> ------------[ cut here ]------------
> kvm_dirty_ring_full(ring)
> WARNING: arch/x86/kvm/../../../virt/kvm/dirty_ring.c:225 at kvm_dirty_rin=
g_push+0x2b2/0x5e0 virt/kvm/dirty_ring.c:225, CPU#0: syz.0.2477/13660
> Modules linked in:
> CPU: 0 UID: 0 PID: 13660 Comm: syz.0.2477 Not tainted syzkaller #0 PREEMP=
T(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/06/2026
> RIP: 0010:kvm_dirty_ring_push+0x2b2/0x5e0 virt/kvm/dirty_ring.c:225
> Code: 38 be 08 00 00 00 e8 8d 10 08 01 f0 80 4b 38 08 48 83 c4 18 5b 41 5=
c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 cf 84 88 00 90 <0f> 0b 90 e9 f8=
 fd ff ff e8 c1 84 88 00 90 0f 0b 90 e9 00 ff ff ff
> RSP: 0018:ffffc900065872e0 EFLAGS: 00010293
> RAX: ffffffff81412d31 RBX: ffff888059575100 RCX: ffff88802a9b0000
> RDX: 0000000000000000 RSI: 0000000000000400 RDI: 00000000fffffffe
> RBP: 1ffff1100b2aedc9 R08: ffff8880369ec9d7 R09: 1ffff11006d3d93a
> R10: dffffc0000000000 R11: ffffed1006d3d93b R12: ffff888059576e50
> R13: 1ffff1100b2aedca R14: 0000000000000400 R15: 00000000fffffffe
> FS:  00007f585c1b76c0(0000) GS:ffff888123134000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000007a420000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  make_spte+0x71a/0xc80 arch/x86/kvm/mmu/spte.c:296
>  tdp_mmu_map_handle_target_level arch/x86/kvm/mmu/tdp_mmu.c:1144 [inline]
>  kvm_tdp_mmu_map+0x140e/0x1f40 arch/x86/kvm/mmu/tdp_mmu.c:1300
>  kvm_tdp_mmu_page_fault arch/x86/kvm/mmu/mmu.c:5029 [inline]
>  kvm_tdp_page_fault+0x2f7/0x3a0 arch/x86/kvm/mmu/mmu.c:5042
>  kvm_mmu_do_page_fault+0x31d/0x640 arch/x86/kvm/mmu/mmu.c:5089
>  kvm_mmu_page_fault+0x1f8/0xc00 arch/x86/kvm/mmu/mmu.c:6698
>  vt_handle_exit+0x28/0x160 arch/x86/kvm/vmx/main.c:974
>  vcpu_enter_guest arch/x86/kvm/x86.c:8540 [inline]
>  vcpu_run+0x4da1/0x7890 arch/x86/kvm/x86.c:8695
>  kvm_arch_vcpu_ioctl_run+0xe83/0x18b0 arch/x86/kvm/x86.c:9035
>  kvm_vcpu_ioctl+0xa61/0xfd0 virt/kvm/kvm_main.c:4595
>  vfs_ioctl fs/ioctl.c:52 [inline]
>  __do_sys_ioctl fs/ioctl.c:604 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:590
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x00007f585b3a94d9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f585c1b7028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f585b626090 RCX: 00007f585b3a94d9
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
> RBP: 00007f585b438136 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f585b626128 R14: 00007f585b626090 R15: 00007ffe50d85978
>  </TASK>

Hi,

I've posted what I think is the right fix for this here[1], first
patch of the series.

[1] https://lore.kernel.org/kvm/20261117212913.3634487-1-jthoughton@google.=
com/
