Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F58421F14
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667746; cv=none; b=U5VHZ/sJ1lnvEXuAC6FQ0VqRShJNhUH7dkL4/41oXOQyvrZowlwTYQb9lPjNZJWW8dyOW+or60meK3w4zVf5r9Zsx71Kv+ZLOBMPnT+AeEfh1qv48TnlJ/IUY3klM+35VeHdB8p7uEJ8dDFEO4LHSS/tgpGh9+TMyn5bDusTe5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667746; c=relaxed/simple;
	bh=SAroxcNKrFSAqe7ITVNTDHFdcLEWgqlAkm56XUN81KE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XCeBTleZbLScmOgmdJzpxdosfasUlDk29ushfYuxEYSw82+qrHyD+/U1lMoncKM7zrbgkPeQnF1n88Z8SFF3nePmohzj4o/f6sGCxB8WKG/yOG6Bb+r1Af44JCxlVvLntwZbIU786fGDJIfcEq7rquAF7ixQKbfGw36cP1Qwdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onpZAtcL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onpZAtcL"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35641c14663so2950226a91.2
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777667743; x=1778272543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pYJswTuz+l+2YoiILOIj0xmNxa9rLIxr+BM7pEgolkw=;
        b=onpZAtcL8IHQbFnSemTLo3ZcEe84BtOrqVKt8V9WYoBDcZ2ixuYdsh4b4iuaog0MdA
         wazu4OEAQ63iLa1fOVi4ol3jFufnigWPcSGgOmeVW2/VO6NZ8+BIZNA0cvyktv/jVDf3
         TFtrvEn7I5L5KYWIN/Y8hqWlU2KFELJy7CqDb/eWVh5Pz64cMHe1+oRKZ+7doylAbTiA
         5i6K7RXFKm7iB2BoQtftiSuBRvJPeZ08p+Hw5bCVCp+esXafhZDZ2UgpRv7fid1QT9yK
         wRyzf/MsYQdDF+P6zcWhQooeO2yUD74u1VzlLw6r4D5HVBgVa/evfMguaYyaC4+c/EVL
         /AEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777667743; x=1778272543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYJswTuz+l+2YoiILOIj0xmNxa9rLIxr+BM7pEgolkw=;
        b=TUHH1XW2L4p94DkOzmMiaXDz6s1CeVwyjTem0D06Tvf45o9ZmrX42Z1UKnKjL9P9M/
         NblaykxMmcTjbuhAVTrKiGceeecEaPPDg4aE6U8ZSct/gGOF/AFke9McKbU8V2iZhAgX
         101FOt5Bm8au2mffwQbKDyIXmeIL5jZsD3PeCsIXQNELOLYHflbAfgMP5mNRZSjZX+1e
         BLVzQmpUtY2zjaElSOWUktd6vrATZtFklx80fv+XzbneK/QkoNbgjQGUhS9dqI24DIWF
         EkyUWaYjXiWmAXBNw1M3CF/Jv4rZUT2f7EZJziHJpSNM5BJI703EYgzTm+NavfgusUFv
         NVcw==
X-Gm-Message-State: AOJu0YyTsetDw2YkAE69ij82fpfULBYp/votOskc1guI/coLmvrsmtrA
	MZy/41gpdLFHJ1DZBynUpsbon19LbweuzCjP+sSm7ZBbsJpwpQgGimiEZmZto46bjasNuBGBlXW
	Wa7Q4lQ==
X-Received: from pjbdw12.prod.google.com ([2002:a17:90b:94c:b0:35f:b193:747d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e18c:b0:35d:a4c0:a0ac
 with SMTP id 98e67ed59e1d1-3650ccefc6cmr735595a91.3.1777667742797; Fri, 01
 May 2026 13:35:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 May 2026 13:35:32 -0700
In-Reply-To: <20260501203537.2120074-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501203537.2120074-2-seanjc@google.com>
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
2.54.0.545.g6539524ca2-goog

