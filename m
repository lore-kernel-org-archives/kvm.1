Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77339A045
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381051; cv=none; b=K3plNJ7u4Uxvz8boV1Ynd2QGKSh7slbB8tU0KVj8iKAnRGf8OD6Cu6ndx6TEu/uP0qDni8UNRe6Ew6kilWwY3rWAtbYS7FVDdhQxAgL4Yg1/BPDFF1ProaQRbBYgIXUffRPOtTFawxSK95vtf9yILaFIk+neyJM5cINxsUmWGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381051; c=relaxed/simple;
	bh=9rNPGkTreelzLILSOGZqVPCjG69Up2clw9XS0zVDc+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bD7KBRiS/ZzbTuJwei4m0YjYPe6LWuHRhOBHWeOXt99mPEqcwfGDYlRZlYLvddYHkNIOyjxR8Ofut5zrCjwe0nSqLi0rnHTki4n8xZwkUMm4qMQuL7gBthPAkKTaBJbDPcOtXPoYV4/tn2dgpqxgxWVepPdKgIKsjQkHLk/1EDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C9n7dTle; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9n7dTle"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82ce34a78edso174753b3a.1
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381050; x=1776985850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9XumdmAM5k86iU84PyqR7i86FKgUtltq5DYpR2bGk2E=;
        b=C9n7dTleTErcDZDs1mPBcuBDzWRis9DXNVPUP5sl8+fATEn5fNcMQXRz7vCAFVg1z7
         tq0fRXo+YOS48nurxyx+vwF47s1flGA0p2GiRd/pUvRzcOBgQz+qNoMj9e0jRXSxMMWi
         SwJnPeHqVOrX+81M/Dehu5DWqb8Xj8iIVCwVLpJijFtzq5oTuQcy+pDC3QTz6xnWXsNR
         qBisIleGvSFibpnel/3z2Ezuj428TZ9qgQgRYnwwzpmBCkzPb5kZxsBYog96dtOXQRVW
         Cv2EzCiVNjAojT3QdgJiqSgCgydnEOf88D8mKwnWsYjIuZKgNkdzOIEn+uYai1/vWzDP
         KLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381050; x=1776985850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XumdmAM5k86iU84PyqR7i86FKgUtltq5DYpR2bGk2E=;
        b=FKYccr/GhGVg6jP5gJH5FnNvKeWMi+tpbHxj0Vgv1ufOQ/bX+pTA0e23UY1mWvXXFY
         OpPQVdHXl3ErpilFpTfzbNe3sC0pdUgh1FGrRkfklU4k1T847v5Rqn5fcFAUcfJzuk/d
         S1kBNE9l+eKiPr2j3+CJ2UYOe9hkp2T070iKvUhL6M3h8uU3X0lNjA9kDYWHv1Fsobkd
         Nlx+4ugqODgcVQyGxoOi+yReCjk1Z8KXk+72Q6hN2BXGGYn8NKcw0063ubJqD4SISJvB
         TjKZ2xSUz29fboY1NaWgp93txPBtJFvR2D59vo2jjG1ngi9cyDLM2KsdZZUReyT682A9
         GfSw==
X-Gm-Message-State: AOJu0Yx9Ay544hxFyTVSQKFSc8eFQsX+Z9cIW9gVm/gbFWsLgG5LEaeo
	wjippH8sijvn0HmJmpbK2v6g/MBf5eohrCpyvPL2y6nYH3k2J+HXcmuFwvl/zc2kYFn4s0rvG/U
	sUbKTeg==
X-Received: from pfzz15.prod.google.com ([2002:a05:6a00:1ef:b0:82c:e899:f08d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3385:b0:82a:805a:7cc
 with SMTP id d2e1a72fcca58-82f8c7da23fmr229961b3a.4.1776381049416; Thu, 16
 Apr 2026 16:10:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:10:38 -0700
In-Reply-To: <20260416231043.3402410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416231043.3402410-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416231043.3402410-2-seanjc@google.com>
Subject: [PATCH v2 1/6] KVM: SVM: Fix page overflow in sev_dbg_crypt() for
 ENCRYPT path
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ashutosh Desai <ashutoshdesai993@gmail.com>

In sev_dbg_crypt(), the per-iteration transfer length is bounded by
the source page offset (PAGE_SIZE - s_off) but not by the destination
page offset (PAGE_SIZE - d_off).  When d_off > s_off, the encrypt
path (__sev_dbg_encrypt_user) performs a read-modify-write using a
single-page intermediate buffer (dst_tpage):

  1. __sev_dbg_decrypt() expands the size to round_up(len + (d_off & 15), 16)
     before issuing the PSP command.  If len + (d_off & 15) > PAGE_SIZE,
     the PSP writes beyond the end of the 4096-byte dst_tpage allocation.

  2. The subsequent memcpy()/copy_from_user() into
     page_address(dst_tpage) + (d_off & 15) of 'len' bytes overflows
     by up to 15 bytes under the same condition.

Trigger example: s_off = 0, d_off = 1, debug.len = PAGE_SIZE -
the PSP is instructed to write round_up(4097, 16) = 4112 bytes to
a 4096-byte buffer.

Fix by also bounding len by (PAGE_SIZE - d_off), the same check that
sev_send_update_data() already performs for its single-page guest
region.

 ==================================================================
 BUG: KASAN: slab-use-after-free in sev_dbg_crypt+0x993/0xd10 [kvm_amd]
 Write of size 4095 at addr ff110062293bb009 by task sev_dbg_test/228214

 CPU: 96 UID: 0 PID: 228214 Comm: sev_dbg_test Tainted: G     U  W           7.0.0-smp--5ce9b0c48211-dbg #156 PREEMPTLAZY
 Tainted: [U]=USER, [W]=WARN
 Hardware name: Google Astoria/astoria, BIOS 0.20250817.1-0 08/25/2025
 Call Trace:
  <TASK>
  dump_stack_lvl+0x54/0x70
  print_report+0xbc/0x260
  kasan_report+0xa2/0xd0
  kasan_check_range+0x25f/0x2c0
  __asan_memcpy+0x40/0x70
  sev_dbg_crypt+0x993/0xd10 [kvm_amd]
  sev_mem_enc_ioctl+0x33c/0x450 [kvm_amd]
  kvm_vm_ioctl+0x65d/0x6d0 [kvm]
  __se_sys_ioctl+0xb2/0x100
  do_syscall_64+0xe8/0x870
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
  </TASK>

 The buggy address belongs to the physical page:
 page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x7fe72b6a0 pfn:0x62293bb
 memcg:ff11000112827d82
 flags: 0x1400000000000000(node=1|zone=1)
 raw: 1400000000000000 0000000000000000 dead000000000122 0000000000000000
 raw: 00000007fe72b6a0 0000000000000000 00000001ffffffff ff11000112827d82
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ff110062293bbf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ff110062293bbf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ff110062293bc000: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                    ^
  ff110062293bc080: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ff110062293bc100: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ==================================================================
 Disabling lock debugging due to kernel taint

Fixes: 24f41fb23a39 ("KVM: SVM: Add support for SEV DEBUG_DECRYPT command")
Fixes: 7d1594f5d94b ("KVM: SVM: Add support for SEV DEBUG_ENCRYPT command")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
[sean: add sample KASAN splat, Fixes, and stable@]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..b9d7bd868e0b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1396,6 +1396,7 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 		s_off = vaddr & ~PAGE_MASK;
 		d_off = dst_vaddr & ~PAGE_MASK;
 		len = min_t(size_t, (PAGE_SIZE - s_off), size);
+		len = min_t(size_t, len, PAGE_SIZE - d_off);
 
 		if (dec)
 			ret = __sev_dbg_decrypt_user(kvm,
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

