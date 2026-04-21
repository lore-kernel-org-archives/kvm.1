Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482A3B6363
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770274; cv=pass; b=MWjjyw9YTfxL69Vt/ax3c6d6A6NhHmMl7kTw8Sv6s5d5b+/ghT+T/VzXdx2SUleFVIXJL5oRjpt3HPEKdhwvLLIVRiremPWLmwapkkKzRNJbwSDy3qoXBbXJk8yhJRqajCtKEAmRQBfkT4alcpU0lcqaCP99wMhkKmmTa2Ymo8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770274; c=relaxed/simple;
	bh=UAxfHPswwQ5G31rFFAOLdCIIYxIqmhsNU274XI2LiA8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CVaeaYUBLT80a4Yc9guT4btr7/zOoeYOm4vYBr4BgW7ieDsJEddar4auOnL1ZX4qok0dTQYVRQy6jyysNaXVfcvkRPAvAOIu+zWZT1crafRiMCYIkPzEC1SIs0b6eP1YOxnu+EYcjtCiYjXkBN+9QGT/bRwxUmndMhmiMx8asXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELueQRLt; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELueQRLt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab46931cf1so35974375ad.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 04:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776770272; cv=none;
        d=google.com; s=arc-20240605;
        b=f4DooqVDUv2nMYqK09c8zUBPe7gsN3aE5JnftVLonTuPQX+GFnbDjTbJQbKJHEK0WX
         9+KCnoQ/MinqJTu6WDOxGthHwhYwVpT6PmB1/prQLbx5o7nZJJmx+0zU+MnIrJime4eF
         69O1Jkd5B1UHf+iyzkmnJI3wuTviYtH5IyDgM8OuYj29X+w6QhiBxUagUEwnNQJ4UNdw
         hYjFKBlHcGH2mq0YOAyzjFdIklQQOE1XOnZ6/AJw5KOiRMypWzjbiiGUbiIXZufs8GJo
         FPkX29XzbjaOXslz3Uqy+i4fjjbvshqFqipgsFmSqEUZKbHwy49gEmMs8t+yC272OGYm
         iqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UAxfHPswwQ5G31rFFAOLdCIIYxIqmhsNU274XI2LiA8=;
        fh=SE3zyewpUcCqiPQOMljTuLBzsoq8qqj1t/jNCufcqig=;
        b=gjqxatLfe09FkR6FK1I1PgjgeCf+XwFjaorrqHOPP+TLy+F9Z7eRPEPLbJAp0dauim
         xZb6KZu6Qs/TVWi7G8lDGhfzAGFC799ojy/3EThhJ48cuBWzLqTbHo8aCurTVvlHFtEH
         p1sJqdzJuhVViK0NQ4jSMYIeTJQByJrQY+E3QcS4Na24CWJJYqlhsI8zwawHkLiyHQL4
         W6nNKyr7XuCMkXeaY4aPvZtZeczQQIdlcEGLi8YBILWc64+Otokgmt4Rt7nQqettsc1F
         HMmba1tqReEsj4PI2S/a74YDFtq9fmO6DAkMiz3tNxbxcjnEC4Ep19CvHxJ3+Lp9Ilj4
         7A0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770272; x=1777375072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UAxfHPswwQ5G31rFFAOLdCIIYxIqmhsNU274XI2LiA8=;
        b=ELueQRLtmf75Xi+ZZyWFpi8Mg85fY8cnBX+9ZkKQggNNvunD2uWYBuf2jVOBSUqnLu
         qsuCCuNFBD+Fq1WduFzquI1+3Xat9lu/XYsZAvtc33/blxEcchJJEf3MI2o4Lq6I/jXK
         7DBfut+EuO8HmDvlbm8XxGUzrDmb9TvYZPlBsaTL313NkASvz1zky27lpd4Dn2ltcEHa
         yNghMTtN98ItEf0O0hSHwlVi1ZE3YbXjS3LQF6TZAcsYNycxthUoFrhZVSyRLglIkYm6
         4zjOAJ38z8qdEYhCuiFRFRpQ4uYz+b72762qcuVuodaNbF5p4ZMt5hCkGQZjywP8xliF
         rkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770272; x=1777375072;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAxfHPswwQ5G31rFFAOLdCIIYxIqmhsNU274XI2LiA8=;
        b=fL3qEnrL6IlH7fOEkvAXXKhT/vr/vbEZ57i8yQrciNn8k982vQ1+SpdR7yE1+yd484
         mCq8E1al0GsmXhilHoRnOsuFM+MROF6beztk21w6UWkzWXexvgUkvN7oRZ6a0Y1hxjZO
         cT5D+FipESpK2X1/sAGzWFeA75vlZkDGJ/9rgqp2Nz66dzVeM4R1T+6U20Qj9gVE3RBY
         enXoYBxneJhtWcKXAchzFyByhegOQtO9FHh53x4NdMHzkX05peHD3wPwIEbqSJLjO6T/
         oL9R5h6Z4uR/xv+HmgT77L/UW/WCgLlUt17VqdllMNP38MPGp4eOmYUi7LKWkPToaOyE
         uqGA==
X-Gm-Message-State: AOJu0YxN3Iaf4NgeFVBL52hFrvPLNBpEWmXgSZi/AXg7qTO2bGqIF9zG
	TIm3RyNtDQjMm+1a27ErUmyAb64pTnxdFtHis2BcFrp6tY5BdeVIUzlHwLh7wEzX5sFd1kWv9t1
	mX41RGzZM1DUxM+iCy9N9jfQQ7XvB8uY=
X-Gm-Gg: AeBDiesoTV0UN55ZSMfMs6jOFhxFyBYyt092p4x6hf+zSVOlKX8STCsOGyUrosGRMCF
	MYnC0GIj6ybUqi500Bq8cRvO6wLjUVcc+jNgeXCJZWVGtykErbPGulF26IfB9/AZuwJO6AHH05H
	NVMgLAUY3oMXABvHuZXDPKk3aOjDJ5jC6ASxD1j4EKtofK3ILpid59Q/6bTgS0b6kV+IDyQZEM+
	yyKzw2bgwuGDsXnsBKV8MLLBM4Mxfp2Ee80RvnaswMZNZCKs0eLpRhxizSZ/5VHMiB6h32SY5ly
	Q0Gc+CG05wgVXep0IXVau3jyGlwn
X-Received: by 2002:a17:903:166e:b0:2b4:64cf:e8f8 with SMTP id
 d9443c01a7336-2b5f9dbcd22mr166529785ad.2.1776770272491; Tue, 21 Apr 2026
 04:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Tue, 21 Apr 2026 19:17:40 +0800
X-Gm-Features: AQROBzCvxTzVOatYGD3oQlMzZmTAz5McY1A204T_VliE2k6DNBeXHfpitVDrZ9A
Message-ID: <CAPHJ_VJGTsRDc7_Kv0oDObuDX2pJ0evcAvH-mnD_RYMX536+mw@mail.gmail.com>
Subject: [BUG] WARNING in workingset_activation triggered by KVM page fault
 path on Linux 7.0.0-08391-g1d51b370a0f8
To: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a WARNING in workingset_activation() triggered by a
syzkaller C reproducer on Linux 7.0.0-08391-g1d51b370a0f8.

The warning is hit from the KVM page fault path:
kvm_set_page_accessed() -> folio_mark_accessed() -> workingset_activation().

At first glance this looks more like an MM/workingset issue than a
KVM-specific bug, although KVM/SVM is the trigger path.

Reproducer:
C reproducer: pastebin.com/raw/zzNSd9HK
console output: pastebin.com/raw/TuipfpyA
kernel config: pastebin.com/raw/aq1V3cLk

Kernel:
HEAD commit: 1d51b370a0f8
git tree: torvalds/linux
kernel version: 7.0.0-08391-g1d51b370a0f8 #1 PREEMPT(lazy) (QEMU
Standard PC, Q35)

The warning is:

WARNING in workingset_activation

Log excerpt:

WARNING: include/linux/memcontrol.h:381 at
workingset_activation+0x466/0x540, CPU#1: repro/238

Call Trace:
folio_mark_accessed+0x1d3/0x650
kvm_set_page_accessed+0x5a/0x70
kvm_release_page_clean+0x26/0x180
direct_page_fault+0x553/0x11a0
kvm_mmu_page_fault+0x35b/0x2020
kvm_handle_page_fault+0x1aa/0x380
svm_invoke_exit_handler+0x7a/0xe0
svm_handle_exit+0x416/0x7f0
vcpu_enter_guest+0x26ad/0x49c0
kvm_arch_vcpu_ioctl_run+0x697/0x25e0
kvm_vcpu_ioctl+0x737/0x1610
__x64_sys_ioctl+0x192/0x220
do_syscall_64+0x117/0xfc0
entry_SYSCALL_64_after_hwframe+0x4b/0x53

The reproducer appears to drive KVM into a guest page fault flow that
marks a folio as accessed, and the warning is then emitted inside
workingset_activation().

Because the RIP is in workingset_activation() itself, this may
indicate a problem in workingset/LRU or memcg/lruvec handling, with
KVM only serving as the trigger path.

Please let me know if I should also send this to additional KVM x86
maintainers, but mm/workingset.c seems to be the primary fault
location.

Thanks.
