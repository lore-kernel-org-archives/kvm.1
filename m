Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7383C5559
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186522; cv=none; b=nhoSM8bhaYSNgavm/H2XJJSc/MXNwZR78mdhEHeihWlyDoppIVQ5lW3WNVuN4HgrJSLbziEa3k5YJuib8+4Y4aN709hQ5h63PG8f4SGKF2jBr0/gaI/pE8TsFKMkE1bXtbWCLVFtgIQ7kjHN867cSPEZSKDZzTE8YkpT/DgGwoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186522; c=relaxed/simple;
	bh=b+5ch2gAT5ERnn5NbXyhxSiq0SzA5rU9kaWO6cIeDtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tee7YETkeAe+E6oYN8pcAhbHnvBXgdzssnwfpETgX8d8x5hS8Rsh28NLYyoMtw7h+ZJ32FbBbDvsoYLAH8VG7tRmxIU+TLzwd3eFjNcBu9lPjUseCb/02Pjv8shvn7WwP+gZ5b6YOPAciWNq//mXJn/IXHcDM8H8L2MROKS+MMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ugiyn73l; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ugiyn73l"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae59e057f1so102110765ad.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186521; x=1773791321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JjsNKd0HOBrtHRwBgNBz3zDbDewW5UJ/SeZaXW6KVIw=;
        b=Ugiyn73ljZN6gsvnDiGosw0D/cjoKNKaAX4c9DV41u/qeFOwe+wgOZ6TV9caZNNGRx
         NIp8xbaHRUEbmOf0qBLe/MU089Cn5HHkis4rX/B7W6lrwfw+ublRZbcH/SVpJav43GWx
         lvhl3ES70vsH1aoxnNGtrejvuoUXqaErVfvXFMJoBmPpbFGG4arOOimQKwbDTPxjp6VQ
         Jjyw+HasfZLX6vD/9+5VX8C30iyh+tKPEJe2uMOu8FqHUcdtNRTeoF0JdLg9rQuo/C37
         7FsKwPCLky4YlZac/94bTLs8XoACsrC4hcJRcT6GFSBo3lHDtu+J48O0JiuLCXcM4gQG
         EPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186521; x=1773791321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjsNKd0HOBrtHRwBgNBz3zDbDewW5UJ/SeZaXW6KVIw=;
        b=Dszkh+tN3i7DvRe1X7c3j8DeJPbbqirnys302hsuw+RohZa11Bl5cZdKMudBMWfH8a
         TNNTJN1crpgnhPuzCRCq3tB0+AY1Cqq6UjdiPZ4w5sJVsxgzWA0WGykhmKYFh62GSSKq
         3CkG2ss1x9MaZa8qbEHzIzxOoyzbaWuDlwgWt9PN1+xYLFmsltDRLTyyfWUcNg5jQiu7
         mmwNd9Ac4g+6S8baEHv5O1WKdMyNZvmQN7+wDRACIRTDLXmLpvGABKaff+lDQK6vvkEE
         x5rEEbKSkRvrWDDg04QVZZgpFt0Qrt6UfsS8xBpgxKIkn+cAx5dULkOTEBUcGm49TXFX
         gGkw==
X-Gm-Message-State: AOJu0YzIl+t+TJjn7TigJ5OPV5ogyBETH1GlQed2P+oQqFspy7h0druh
	NS7YAg++wR5//ifAYjFzObULBt8gbNRXNBZG7EK2aSbR0PjPdee7BrzoYjZT6QWfN6b7w89mFeP
	GT84RQg==
X-Received: from pfbhg13.prod.google.com ([2002:a05:6a00:860d:b0:827:3eb4:a39a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:46c5:b0:398:c2d8:14c
 with SMTP id adf61e73a8af0-398c5e6e2bcmr328641637.7.1773186520900; Tue, 10
 Mar 2026 16:48:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:11 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-4-seanjc@google.com>
Subject: [PATCH 03/21] KVM: SEV: Protect *all* of sev_mem_enc_register_region()
 with kvm->lock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Take and hold kvm->lock for before checking sev_guest() in
sev_mem_enc_register_region(), as sev_guest() isn't stable unless kvm->lock
is held (or KVM can guarantee KVM_SEV_INIT{2} has completed and can't
rollack state).  If KVM_SEV_INIT{2} fails, KVM can end up trying to add to
a not-yet-initialized sev->regions_list, e.g. triggering a #GP

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  CPU: 110 UID: 0 PID: 72717 Comm: syz.15.11462 Tainted: G     U  W  O        6.16.0-smp-DEV #1 NONE
  Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE
  Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 12.52.0-0 10/28/2024
  RIP: 0010:sev_mem_enc_register_region+0x3f0/0x4f0 ../include/linux/list.h:83
  Code: <41> 80 3c 04 00 74 08 4c 89 ff e8 f1 c7 a2 00 49 39 ed 0f 84 c6 00
  RSP: 0018:ffff88838647fbb8 EFLAGS: 00010256
  RAX: dffffc0000000000 RBX: 1ffff92015cf1e0b RCX: dffffc0000000000
  RDX: 0000000000000000 RSI: 0000000000001000 RDI: ffff888367870000
  RBP: ffffc900ae78f050 R08: ffffea000d9e0007 R09: 1ffffd4001b3c000
  R10: dffffc0000000000 R11: fffff94001b3c001 R12: 0000000000000000
  R13: ffff8982ab0bde00 R14: ffffc900ae78f058 R15: 0000000000000000
  FS:  00007f34e9dc66c0(0000) GS:ffff89ee64d33000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fe180adef98 CR3: 000000047210e000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   kvm_arch_vm_ioctl+0xa72/0x1240 ../arch/x86/kvm/x86.c:7371
   kvm_vm_ioctl+0x649/0x990 ../virt/kvm/kvm_main.c:5363
   __se_sys_ioctl+0x101/0x170 ../fs/ioctl.c:51
   do_syscall_x64 ../arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x6f/0x1f0 ../arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f34e9f7e9a9
  Code: <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007f34e9dc6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007f34ea1a6080 RCX: 00007f34e9f7e9a9
  RDX: 0000200000000280 RSI: 000000008010aebb RDI: 0000000000000007
  RBP: 00007f34ea000d69 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 0000000000000000 R14: 00007f34ea1a6080 R15: 00007ffce77197a8
   </TASK>

with a syzlang reproducer that looks like:

  syz_kvm_add_vcpu$x86(0x0, &(0x7f0000000040)={0x0, &(0x7f0000000180)=ANY=[], 0x70}) (async)
  syz_kvm_add_vcpu$x86(0x0, &(0x7f0000000080)={0x0, &(0x7f0000000180)=ANY=[@ANYBLOB="..."], 0x4f}) (async)
  r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000200), 0x0, 0x0)
  r1 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)
  r2 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000240), 0x0, 0x0)
  r3 = ioctl$KVM_CREATE_VM(r2, 0xae01, 0x0)
  ioctl$KVM_SET_CLOCK(r3, 0xc008aeba, &(0x7f0000000040)={0x1, 0x8, 0x0, 0x5625e9b0}) (async)
  ioctl$KVM_SET_PIT2(r3, 0x8010aebb, &(0x7f0000000280)={[...], 0x5}) (async)
  ioctl$KVM_SET_PIT2(r1, 0x4070aea0, 0x0) (async)
  r4 = ioctl$KVM_CREATE_VM(0xffffffffffffffff, 0xae01, 0x0)
  openat$kvm(0xffffffffffffff9c, 0x0, 0x0, 0x0) (async)
  ioctl$KVM_SET_USER_MEMORY_REGION(r4, 0x4020ae46, &(0x7f0000000400)={0x0, 0x0, 0x0, 0x2000, &(0x7f0000001000/0x2000)=nil}) (async)
  r5 = ioctl$KVM_CREATE_VCPU(r4, 0xae41, 0x2)
  close(r0) (async)
  openat$kvm(0xffffffffffffff9c, &(0x7f0000000000), 0x8000, 0x0) (async)
  ioctl$KVM_SET_GUEST_DEBUG(r5, 0x4048ae9b, &(0x7f0000000300)={0x4376ea830d46549b, 0x0, [0x46, 0x0, 0x0, 0x0, 0x0, 0x1000]}) (async)
  ioctl$KVM_RUN(r5, 0xae80, 0x0)

Opportunistically use guard() to avoid having to define a new error label
and goto usage.

Fixes: 1e80fdc09d12 ("KVM: SVM: Pin guest memory when SEV is active")
Cc: stable@vger.kernel.org
Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fa319a66938c..7da040baba1c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2704,6 +2704,8 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	struct enc_region *region;
 	int ret = 0;
 
+	guard(mutex)(&kvm->lock);
+
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
@@ -2718,12 +2720,10 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	if (!region)
 		return -ENOMEM;
 
-	mutex_lock(&kvm->lock);
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
 				       FOLL_WRITE | FOLL_LONGTERM);
 	if (IS_ERR(region->pages)) {
 		ret = PTR_ERR(region->pages);
-		mutex_unlock(&kvm->lock);
 		goto e_free;
 	}
 
@@ -2741,8 +2741,6 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	region->size = range->size;
 
 	list_add_tail(&region->list, &sev->regions_list);
-	mutex_unlock(&kvm->lock);
-
 	return ret;
 
 e_free:
-- 
2.53.0.473.g4a7958ca14-goog

