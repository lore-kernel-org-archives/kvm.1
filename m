Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D502372B3C
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908297; cv=none; b=Z64+jHNUbb3H0IrJXeR0V9dY+YyJg2oYU1ldbRUjByPewpAixXhL9dntg98JjiVD3s7MSF9Xi+zRJyS2To/2zI7pbUQHdNCGwRhPCXhUTxvWcTYpwiijNw1iV+jh273exFfjtvslNqmvw0bZrhBddyVf/Wo9pNlzW3urCZ+94NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908297; c=relaxed/simple;
	bh=QXkHVdlyt4lYT2LxnNiKA0ftn8apGpUnaxNrCspHojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YV1Q1hFScl2Wim7e5PR6tJz5NXdA0R0M5IwWkQYeViQLCq3STDSEOC4+48uZxo3JA3LfoMmuriNQjqxeWs8hc6Cths0e9L8SbEeoaQXj8lf9uyT57BCGQvpr5+uOjMMivIk+UzDy/srD+GTQoCqAddbwDktUMeBow0NnU3tCMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hv8l8n0T; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hv8l8n0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=GED7Myz53a4TbWnUNDwerLeteq21Ern4B3tgylt/3zk=;
	b=hv8l8n0T0qiPs1S/ZAjyb05XiE0o0ORcmdp7+Id3/yY7EJvqRMoMVTOh87eTsw
	MBAm2CcFRSyl5w6tIcPHI37pYS178Wo3zLDE/gD8eWWIwzniq2PllnA+vDrPZyZr
	cqv2BssWexQc8zZl3wyJ36qHtQldeCKNny09bEeSS63RY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXn_e1UJFqvEMmSA--.50127S2;
	Fri, 28 Aug 2026 17:11:17 +0800 (CST)
Date: Fri, 28 Aug 2026 17:11:16 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH 1/2] KVM: Flush dirty ring resets before handling signals
Message-ID: <apFQtIs9SLEobo04@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wBXn_e1UJFqvEMmSA--.50127S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1xXr13CF4UKFWfXF47Arb_yoW8uw1xpF
	sxK34ktrWfZr1UZFZxCrs5Zry2939aqFWkGrWrtws0qry3KF1rGF18KFy0y343uF97AFWa
	yF1jqF17ZF4jkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6pBhUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+RVAM2qRULWPhQAA3L

From: Hao Zhang <zhanghao1@kylinos.cn>

KVM bails out of KVM_RESET_DIRTY_RINGS if a signal is pending, but the
dirty ring reset flow can already have consumed harvested entries before
noticing the signal.  In that case, the entries have been marked invalid
and reset_index has been advanced, but the batched GFNs may not yet have
been reprotected by kvm_reset_dirty_gfn().

This breaks the dirty ring state machine: userspace has handed the GFNs
back to KVM, but KVM can leave the corresponding pages writable.  Future
guest writes to those pages may then fail to generate new dirty-ring
entries, causing dirty tracking to miss updates.

Make the signal path break out of the scan loop instead of returning
immediately, so any pending batch is flushed before kvm_dirty_ring_reset()
returns.

Fixes: 49005a2a3d2a ("KVM: Bail from the dirty ring reset flow if a signal is pending")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 virt/kvm/dirty_ring.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 572b854edf74..451eee9d8f69 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -122,6 +122,7 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
 	u64 cur_offset, next_offset;
 	unsigned long mask = 0;
 	struct kvm_dirty_gfn *entry;
+	int r = 0;
 
 	/*
 	 * Ensure concurrent calls to KVM_RESET_DIRTY_RINGS are serialized,
@@ -132,8 +133,10 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
 	lockdep_assert_held(&kvm->slots_lock);
 
 	while (likely((*nr_entries_reset) < INT_MAX)) {
-		if (signal_pending(current))
-			return -EINTR;
+		if (signal_pending(current)) {
+			r = -EINTR;
+			break;
+		}
 
 		entry = &ring->dirty_gfns[ring->reset_index & (ring->size - 1)];
 
@@ -213,7 +216,7 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
 
 	trace_kvm_dirty_ring_reset(ring);
 
-	return 0;
+	return r;
 }
 
 void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 slot, u64 offset)

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.15.0

