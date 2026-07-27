Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAFC1B4156
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119882; cv=none; b=ERD9qKWhiwSFlbnXXpslixw8jNMucf8vqitljdnbJCUWO8/U5m6c0LOmEyppUyacDPZLbFPacVmlS6yqGCLd+w8eK1Ptgx4Lw7pL86AAXcSfo2rjoSl7TU6axonYh14B7lTbgdwKyfaxo2kyS6ENS4pafG/A0dbIXTzmwooLJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119882; c=relaxed/simple;
	bh=oj1DOFrjNWRy7Q/QMJnuCA2kGi9xnjTWciZXELUZIro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qc1RaaKSDWXVmqq3Eyz9w75EFoRf+X6ap39Q7VKj1Sy9l8aFbmxODiow02KcMcm3YGLbSnJxs6QHa2csAhsQHrXD9nhCGA8tyZQZkK2IYX24T02IQ4lkaphoL9betkcpYgOSruI4cFzkxD8PPz1s9ANZD05moN8wNx+suCBmfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gG/sk3Sp; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gG/sk3Sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ME/mVoz0xBLlk9PxxBwLpd+oIWCfBqeJcD1hzWSR6hE=;
	b=gG/sk3SpDDESqKGU0/ZyHmbsqLByMDbojFRnNDEKN7gvN+jFX2LHALTfwBUzw8
	UN+z0Rbdw1EmJVw8Y1pFoHU2VXwXD+HKmsLIFDZO/iBF7d5xvNgI5EJmjFjTYnKz
	gRv4rhLAYGXyVEAIOioAQAolfSseYHr6vpTxpwu2rhyAY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H8R2xGZqo7qlMA--.11370S2;
	Mon, 27 Jul 2026 10:37:42 +0800 (CST)
Date: Mon, 27 Jul 2026 10:37:41 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH v3] KVM: guest_memfd: Avoid deadlock in error_remove_folio()
Message-ID: <ambEdSPjerZIVN0b@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wD3H8R2xGZqo7qlMA--.11370S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF45CF47Cw4ftFy8KFy7trb_yoW5XrW3pF
	y7K398KrZxXr4xurn2y3W8XFy2g348XFy7CFy3JwnIvF1qqw1jgF4j93W7WFySkrZ7tan7
	XayS9F1DuFyUX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlZXrUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+RiDdmpmxHiSHgAA3o

From: Hao Zhang <zhanghao1@kylinos.cn>

memory_failure() invokes ->error_remove_folio() while holding the
poisoned folio lock.  KVM's guest_memfd callback then takes
mapping->invalidate_lock for read before invalidating guest mappings.

This can deadlock with paths that hold mapping->invalidate_lock for write
and then try to lock the same folio, e.g. truncation from MADV_REMOVE or
FALLOC_FL_PUNCH_HOLE.  Because rwsems are fair, the problem is not limited
to guest_memfd punch-hole: a pending writer can also block future readers,
so ->error_remove_folio() must not block on the invalidate lock while
holding the poisoned folio lock.

Use filemap_invalidate_trylock_shared() in kvm_gmem_error_folio().  If the
invalidate lock is contended, fail the recovery instead of potentially
deadlocking the memory-failure path.

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
Changes in v3:
 - Drop the guest_memfd-private bindings_lock approach from v2 and go back
   to the trylock stopgap from v1, as suggested by Sean.
 - Rewrite the changelog and code comment to describe the problematic lock
   dependency as the poisoned folio lock vs. mapping->invalidate_lock, and
   avoid implying that mf_mutex is part of the actual deadlock.
 - Account for rwsem fairness: a pending writer can block future readers, so
   the issue is not limited to guest_memfd punch-hole.

Link to v2: https://lore.kernel.org/all/tencent_7DA064CAC9B463EB9B651801011E2CE4230A@qq.com/

 virt/kvm/guest_memfd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index db57c5766ab6..6476ab4a2be7 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -500,7 +500,17 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 {
 	pgoff_t start, end;
 
-	filemap_invalidate_lock_shared(mapping);
+	/*
+	 * memory_failure() invokes ->error_remove_folio() while holding the
+	 * poisoned folio lock.  Do not block on mapping->invalidate_lock, as
+	 * a writer that already holds the invalidate lock can be waiting for
+	 * the same folio, e.g. truncation from MADV_REMOVE/FALLOC_FL_PUNCH_HOLE.
+	 *
+	 * If the invalidate lock is contended, fail the recovery instead of
+	 * risking a deadlock in the memory-failure path.
+	 */
+	if (!filemap_invalidate_trylock_shared(mapping))
+		return -EBUSY;
 
 	start = folio->index;
 	end = start + folio_nr_pages(folio);

base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.39.2

