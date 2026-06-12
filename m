Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08B388E4E
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304764; cv=none; b=lN+dxswhM0JJXTyLh0xV8AXFy0zcgS6bTz4ZbvyasAvUujlcFNaHbLfyKeFeDFqwCCAJZeqy52gWJXIcwRIc5o6nLH+y2/rBVniEeaFrFonWqGFMx60YEILHP2C+xrMXNbO4gYjnT6wL6enpY2NeTNqs5cK6Jgg1nwf4acQKB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304764; c=relaxed/simple;
	bh=h2dAjfmTiaNC+yrVDnVqViLm0QjWgBGRupEkYaf2woE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pxB3QjmOQV+fn2HDV3ZmeuVQuHpZVBT3k0Z8hFRm3PqSLmuhGp21DciC9cLbvy091u/jlaLDv2I+FD4U+KB9sWwdLdTtBavOMi3WwJO3fXkCHTr2VlcoRrExysnDCGE/d0UR2JZHDD4qWbe/u+/9ksw8xp0fiKFhFUd7sLpyKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDm9B/wn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDm9B/wn"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84256bee9a9so988768b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781304762; x=1781909562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvWh/13eYPU+BdcM7p3YAz7iJ/jBnYTIFM3WoibiZfw=;
        b=KDm9B/wni0XpvhC6CwO9P66B5Uk/XUQ5nIYD2QdHGJarlSPKNpaRNpyrlmjB2eJ7aN
         g4HfMhmwy8pm3JOwqEsTlF67vNKiFATLMDQJv5Eme5ff46CWZNSpE3RSdCvlbv9wO5QS
         FydP2udU2l16EHZem9jPsEJXogFc+60Hip8nSmNkubGGtYe5gb4jjjCx22h6r+I+k7Pt
         lp1z/4WimFVeVtmjhz1zro7Ib7UgRvrpesRFTZ4jorFMmdBaBPYyse5RQvJHIMrd/8y0
         qzK+BZ1U8efvUmUwXEvvMsZhQo3qyNdSumdc64wQklGkZhmo4PGD0Oct8mUlqfKLTD4E
         s6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781304762; x=1781909562;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvWh/13eYPU+BdcM7p3YAz7iJ/jBnYTIFM3WoibiZfw=;
        b=k6y+6nRyvXb3OJXOLvwf9S1qcwvwz7RduxVLljsW1J2Q/VxfJuSgOICJCLmR6pc/Kc
         8KHersLFCbkbak8VsXyq9ThIu2xi0eQG+0vEEybPRGCROFds69bGskfRYm5aBz22hse0
         3zEibM17h7B96fWF8aKRH/HAAZFhTrwC0Mss+wSSPOVv4rn3x78CUwGandID31y4cogt
         IMlNBE8TsDfTAD3NKSaGKfCh913jjLk1+a300SMtHBfiNXOQc+oJY8neNHC+iuzRbJSa
         TSXMjA6u5K5K1vPQLlEhM82bhCqjdHyuivGrOj0H/O4mN4JT4ZXG4bjHTsSoFz/PoHiM
         9clA==
X-Gm-Message-State: AOJu0YwTE5U5eESqZww8OXVw8ZP4oD1ZCkzWScUzX31MKVxNt56ewh4E
	/Myio3jipYupTpJD5lH4VHlt5knkluiR2mV3iSNcqKlGoUrcS4Me+mGrJFm2k4tk86Gq1398TAM
	sd7Zfqg==
X-Received: from pfbcn15.prod.google.com ([2002:a05:6a00:340f:b0:842:2542:d064])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:198d:b0:842:4e43:6f6c
 with SMTP id d2e1a72fcca58-844e1a9bc65mr1552519b3a.39.1781304762404; Fri, 12
 Jun 2026 15:52:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 15:52:41 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612225241.678509-1-seanjc@google.com>
Subject: [PATCH v2] KVM: Replace guest-triggerable BUG_ON() in ioeventfd
 datamatch with get_unaligned()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop a BUG_ON() that has been reachable since it was first added, way back
in 2009, and instead use get_unaligned() to perform potentially-unaligned
accesses.

For a given store, KVM x86's emulator tracks the entire value in the
destination operand, x86_emulate_ctxt.dst.  If the destination is memory,
and the target splits multiple pages and/or is emulated MMIO, then KVM
handles each fragment independently.  E.g. on a page split starting at page
offset 0xffc, KVM writes 4 bytes to the first page, then the remaining
bytes to the second page, using ctxt->dst as the source for both (with
appropriate offsets).

If the destination splits a page *and* hits emulated MMIO on the second
page, then KVM will complete the write to the first page, then emulate the
MMIO access to the second page.  If there is a datamatch-enabled ioeventfd
at offset 0 of the second page, then KVM will process the remainder of the
store as a potential ioeventfd signal.

Putting it all together, if the guest emits a store that splits a page
starting at page offset N, and the second page has a datamatch-enabled
ioeventfd at offset 0, then KVM will check for datamatch using
&dst.valptr[N] as the source.  Due to dst (and thus dst.valptr) being
32-byte aligned, if N is not aligned to @len, the BUG_ON() fires.

E.g. with a 16-byte store at page offset 0xffc, to an ioeventfd of len 8,
all initial checks in ioeventfd_in_range() will succeed, and the BUG_ON()
fires due to @val being 4-byte aligned, but not 8-byte aligned.

  ------------[ cut here ]------------
  kernel BUG at arch/x86/kvm/../../../virt/kvm/eventfd.c:783!
  Oops: invalid opcode: 0000 [#1] SMP
  CPU: 0 UID: 1000 PID: 615 Comm: repro Not tainted 7.1.0-rc2-ff238429d1ea #365 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:ioeventfd_write+0x6c/0x70 [kvm]
  Call Trace:
   <TASK>
   __kvm_io_bus_write+0x85/0xb0 [kvm]
   kvm_io_bus_write+0x53/0x80 [kvm]
   vcpu_mmio_write+0x66/0xf0 [kvm]
   emulator_read_write_onepage+0x12a/0x540 [kvm]
   emulator_read_write+0x109/0x2b0 [kvm]
   x86_emulate_insn+0x4f8/0xfb0 [kvm]
   x86_emulate_instruction+0x181/0x790 [kvm]
   kvm_mmu_page_fault+0x313/0x630 [kvm]
   vmx_handle_exit+0x18a/0x590 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc81/0x1c90 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x970 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb7/0x890
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f19c931a9bf
   </TASK>
  Modules linked in: kvm_intel kvm irqbypass
  ---[ end trace 0000000000000000 ]---

In a perfect world, the fix would be to simply delete the BUG_ON(), as KVM
x86 doesn't perform alignment checks on "normal" memory accesses at CPL0.
Sadly, C99 ruins all the fun; while the x86 architecture plays nice,
dereferencing an unaligned pointer directly is undefined behavior in C,
e.g. triggers splats when running with CONFIG_UBSAN_ALIGNMENT=y.

Fixes: d34e6b175e61 ("KVM: add ioeventfd support")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Use get_unaligned() to make UBSAN happy. [Sashiko]

v1: https://lore.kernel.org/all/20260527002910.3931382-1-seanjc@google.com

 virt/kvm/eventfd.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 0e8b8a2c5b79..93ad2ebc963f 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/seqlock.h>
 #include <linux/irqbypass.h>
+#include <linux/unaligned.h>
 #include <trace/events/kvm.h>
 
 #include <kvm/iodev.h>
@@ -779,21 +780,18 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
 		return true;
 
 	/* otherwise, we have to actually compare the data */
-
-	BUG_ON(!IS_ALIGNED((unsigned long)val, len));
-
 	switch (len) {
 	case 1:
-		_val = *(u8 *)val;
+		_val = get_unaligned((u8 *)val);
 		break;
 	case 2:
-		_val = *(u16 *)val;
+		_val = get_unaligned((u16 *)val);
 		break;
 	case 4:
-		_val = *(u32 *)val;
+		_val = get_unaligned((u32 *)val);
 		break;
 	case 8:
-		_val = *(u64 *)val;
+		_val = get_unaligned((u64 *)val);
 		break;
 	default:
 		return false;

base-commit: c1f7303302927f9cbf4efedf70f0512cde168c65
-- 
2.54.0.1136.gdb2ca164c4-goog

