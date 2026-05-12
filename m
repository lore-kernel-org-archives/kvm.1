Received: from MTA-05-3.privateemail.com (mta-05-3.privateemail.com [198.54.118.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3443D4E2
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.118.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566107; cv=none; b=fvbP2n3ShvvQ0To4wQUWKSjVIgpRVtJkvrvuE2s1F4II6NBBkPK8Yj8j3GQSrHfTQcZTudA/sjWYtCpFV/mTnYFBNeXbhKn25qKOvpB0EXTr91ZhM3BdrHLWCnDn9Usy/Mn9GACoDtTDpq9U9xUD7MYx/C27RXslpadb+GE341A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566107; c=relaxed/simple;
	bh=QgX8FNFtPJum2/6/uFLT/qem7NZTN+FU7JKeW2Vhbqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6s7LB581JvCsYBg8jo17zbmxtwBEfvu/nwGRPJOHvWf1X4LXn3AzHaEJn63tuqJvsfBVJ9gN8DNk2/0xQxaDimxEvpnuOJBl5/QoyKXDUoWXfhc6qxQhlz/iQ2m24Aj3zYkq7H4N7He5OuOAdfMqB7dOneNQ6K2SQmlHprrJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xchglabs.com; spf=pass smtp.mailfrom=xchglabs.com; dkim=pass (2048-bit key) header.d=xchglabs.com header.i=@xchglabs.com header.b=MzfpFFV+; arc=none smtp.client-ip=198.54.118.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xchglabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xchglabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xchglabs.com header.i=@xchglabs.com header.b="MzfpFFV+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xchglabs.com;
	s=default; t=1778566082;
	bh=QgX8FNFtPJum2/6/uFLT/qem7NZTN+FU7JKeW2Vhbqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzfpFFV+lOGJfohxHbTmPAdnbBcrb25H0HwhJK7gjvFt6Fuj94sSqOQK2pYK7HeN5
	 aDWIQI5vunIB1cubIBaQ1NBr2E6b88/fTFRlAcl7G7GYYZWrdcjADBQwxGkHShmBd3
	 kl9KqsOKyRBfU4CuYvfdXgStkDAdNvetbOTdvzuUX+xAfVY+H5E73L2lY6gU+HEY3M
	 ycZ5T94RrFsOFtmZqQ99t3SvH/9xKIRsgYl3hhGRGupErICphMbsghcYoqNlH7qZfC
	 N2fqYEeSrpcpRHc+4wiR2FRauxQHesnURzUsnMOqCgwyzR+h1whkH0rH4q757SP3uF
	 g+8Y6WHP3v33w==
Received: from pope.mynetworksettings.com (unknown [146.70.165.159])
	by mta-05.privateemail.com (Postfix) with ESMTPA id 4gF5jn2Kzrz3hhTJ;
	Tue, 12 May 2026 02:07:57 -0400 (EDT)
From: Aaron Sacks <contact@xchglabs.com>
To: Willy Tarreau <w@1wt.eu>
Cc: security@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: Reject wrapped offset in kvm_reset_dirty_gfn()
Date: Tue, 12 May 2026 02:07:42 -0400
Message-ID: <20260512060742.1628959-1-contact@xchglabs.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <agFyH8UoHO5Q3Fta@1wt.eu>
References: <agFyH8UoHO5Q3Fta@1wt.eu>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_reset_dirty_gfn() guards the gfn range with

	if (!memslot || (offset + __fls(mask)) >= memslot->npages)
		return;

but offset is u64 and the addition is unchecked.  The check can be
silently bypassed by a u64 wrap.

The dirty ring backing those entries is MAP_SHARED at
KVM_DIRTY_LOG_PAGE_OFFSET of the vcpu fd, so the VMM can rewrite the
slot and offset fields of any entry between when the kernel pushes
them and when KVM_RESET_DIRTY_RINGS consumes them.  On reset,
kvm_dirty_ring_reset() re-reads the values via READ_ONCE() and feeds
them straight back into this check; only the flags handshake is
treated as the handover, the slot/offset payload is taken on trust.

Crafting two entries

	entry[i].offset   = 0xffffffffffffffc1
	entry[i+1].offset = 0

makes the coalescing loop in kvm_dirty_ring_reset() compute

	delta = (s64)(0 - 0xffffffffffffffc1) = 63

which falls in [0, BITS_PER_LONG), so it folds entry[i+1] into the
existing mask by setting bit 63.  The trailing kvm_reset_dirty_gfn()
call then sees offset = 0xffffffffffffffc1 and __fls(mask) = 63;
the sum is 0 in u64 and the bounds check passes.

That offset propagates into kvm_arch_mmu_enable_log_dirty_pt_masked()
unchanged.  On the legacy MMU path -- kvm_memslots_have_rmaps() ==
true, i.e. shadow paging, any VM that has allocated shadow roots, or
a write-tracked slot -- it reaches gfn_to_rmap(), which indexes
slot->arch.rmap[0][] with a near-U64_MAX gfn.  That is an
out-of-bounds load of a kvm_rmap_head, followed by a conditional
clear of PT_WRITABLE_MASK in whatever the loaded pointer points at.
The path is reachable from any process holding /dev/kvm.

Range-check offset on its own first, so the addition cannot wrap.
memslot->npages is bounded well below U64_MAX, so once offset <
npages holds, offset + __fls(mask) (with __fls(mask) < BITS_PER_LONG)
stays in range.

Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Sacks <contact@xchglabs.com>
---
Hi Willy,

Thanks for the review.  Re-sending this one as a proper patch and
addressing your points below.  I will reply separately to the
other three reports per your guidance there.

> Please could you check on an up-to-date kernel? 6.13.7 is long
> dead (1 year) and thousands of fixes were merged since.

Re-verified on v7.0.6 (current stable). The buggy bounds check
in virt/kvm/dirty_ring.c is unchanged:

    if (!memslot || (offset + __fls(mask)) >= memslot->npages)
        return;

Same PoC still produces the oops:

    Comm: poc Not tainted 7.0.6 #1
    BUG: unable to handle page fault for address: ffffa9bbc002ce08
    RIP: 0010:rmap_write_protect+0x6/0xf0
    RAX: ffffffffffffffc1   RBX: 8000000000000001
    Call Trace:
     kvm_arch_mmu_enable_log_dirty_pt_masked+0x145/0x210
     kvm_reset_dirty_gfn+0xcd/0x100
     kvm_dirty_ring_reset+0x12c/0x1f0
     kvm_vm_ioctl+0xb41/0x10b0
    Kernel panic - not syncing: Fatal exception

RAX is the crafted wrapped offset; RBX is the coalesced mask with
bit 63 set (__fls == 63).  Both match the values planted in the
ring entries from userspace, so the wrapped sum still passes the
existing bounds check on v7.0.6.

> Please also wrap long lines

Done -- this reply and the patch are at <=72 cols.

> Was all of this generated by an LLM?

The reports were generated by an LLM yes. But the analysis, PoC
and patch suggestions are mine. Happy to provide the PoC source,
kernel .config, or additional artifacts.

> Could you please turn this one into a real patch

Patch follows. Applies clean on v7.0.6; with it applied, the
same trigger no longer oopses (offset is rejected by the added
offset >= npages check before the addition can wrap).

Thanks,
Aaron

 virt/kvm/dirty_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 02bc6b00d..572b854ed 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -63,7 +63,8 @@ static void kvm_reset_dirty_gfn(struct kvm *kvm, u32 slot, u64 offset, u64 mask)
 
 	memslot = id_to_memslot(__kvm_memslots(kvm, as_id), id);
 
-	if (!memslot || (offset + __fls(mask)) >= memslot->npages)
+	if (!memslot || offset >= memslot->npages ||
+	    offset + __fls(mask) >= memslot->npages)
 		return;
 
 	KVM_MMU_LOCK(kvm);
-- 
2.43.0

