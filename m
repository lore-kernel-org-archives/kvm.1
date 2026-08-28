Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0937F8A5;
	Fri, 28 Aug 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912882; cv=none; b=Vd6/9p4DKL+9jSG78TLx1xLx6tn6zlD3C1tQN907F4M0TcONtOrtKVC83dejfNXuqYqFSZw7zes0y7wEvq2mn7g565yg2oDvIex4CcrbyJa9QhK4ax3LvjN+CiIwQSwB6fNo6J1VRMpeHpGj7tMhlHn1vOy2C2iQEL+8VZQ2mRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912882; c=relaxed/simple;
	bh=0vvpMMamFLgrqOE4BxD14J+1SAbnF620PL4OJIHBmDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EnRTE6HEEqwZe1OfhhDRZHb2S+2kODoo2onO37u5wfuDPKkrWqLkSMmbmC9cb440b4QMQlnSkyfuI3M3+zMyZX8V6ZzpDBpwop1wUNPuEuJh3PIWXtXBKi179oobLdogynvG4/YQ+p/CL+99c5tOKJ23gGgBVokudbTqNU6SiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S4ahZAnT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S4ahZAnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aL
	9IUsm619dDhd54bRWHMTptXFJavLViAY6k08ZTYwo=; b=S4ahZAnT7WvQebnZcL
	CYVE8AqbiVK1WlLCisaAA8E8SSvn8NKRhv9ygLMEJKxVVxnsUkuXeA/6CaKi5SPQ
	gGXeshuixAu8Xs01x5hNDzdswU+sdZSmUpyF/v2cu/tiI58zX5RAdr00TwlD9qrj
	m/8KHNuj9ENCFd4xcZ1OkkgYA=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDn7zOTYpFq+qltRg--.31394S2;
	Fri, 28 Aug 2026 18:27:32 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: seanjc@google.com
Cc: chao.p.peng@linux.intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	zeng_chi911@163.com,
	zengchi@kylinos.cn
Subject: [PATCH v2] KVM: Don't treat reserved xarray entries as having memory attributes
Date: Fri, 28 Aug 2026 18:27:28 +0800
Message-Id: <20260828102728.1308266-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <apCD3F3oOyC6E5oN@google.com>
References: <apCD3F3oOyC6E5oN@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7zOTYpFq+qltRg--.31394S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4DtryfXrW3WF43uF18Grg_yoW5uFyrpF
	95GryDGws8tr1xXFZ2yw4Du3Wru34Sgw48Jr9rKr1DZr45J3ZIqryrKr1jqrW3ArWrW34j
	qa1jq34xu3y5Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEfOz7UUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCwBS8eGqRYpQjggAA38

From: Zeng Chi <zengchi@kylinos.cn>

kvm_vm_set_mem_attributes() reserves an xarray entry for every gfn in
the range before storing the new attributes, so that the store loop
can't fail partway through.  If one of the reservations fails, e.g. with
-ENOMEM, the entries that were already reserved are left in the array.
That is harmless as far as xa_reserve() is concerned, as the reserved
entries read back as NULL via xa_load(), but it confuses the "does this
range have no attributes at all" check:

	if (!attrs)
		return !xas_find(&xas, end - 1);

A reserved entry is XA_ZERO_ENTRY, not NULL, and xas_find() returns it
as present.  So a leftover reservation makes KVM report that a fully
shared range has attributes even though kvm_get_memory_attributes()
returns none for every gfn in the range.  On x86, the next time
mixed-attribute tracking is recomputed for the range (memslot creation,
or a later attribute change that straddles the 2MiB page),
hugepage_has_attrs() treats a fully shared 2MiB range as mixed and
refuses to map it with a hugepage, until userspace happens to set
attributes on the range again.

Walk the range and ignore reserved-but-unset entries when checking for
the absence of attributes, so a leftover reservation is treated the same
as an empty slot.  Note, the generic loop for the attrs != 0 case
already skips zero entries via xas_retry(), i.e. only the !attrs shortcut
was affected.

While at it, skip the reservation loop entirely when clearing attributes,
as storing NULL only erases the entry and never needs to allocate, so no
reservation (and no cleanup of a failed one) is required in that case.

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 virt/kvm/kvm_main.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..29534bcc7f02 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2447,8 +2447,19 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
 
 	guard(rcu)();
-	if (!attrs)
-		return !xas_find(&xas, end - 1);
+	if (!attrs) {
+		/*
+		 * Reserved but unset entries (XA_ZERO_ENTRY, e.g. left behind by
+		 * a failed reservation in kvm_vm_set_mem_attributes()) are
+		 * returned as present by xas_find(), but hold no attributes.
+		 * Skip them so that the range is correctly reported as having no
+		 * attributes.
+		 */
+		xas_for_each(&xas, entry, end - 1)
+			if (!xa_is_zero(entry))
+				return false;
+		return true;
+	}
 
 	for (index = start; index < end; index++) {
 		do {
@@ -2571,9 +2582,11 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	/*
 	 * Reserve memory ahead of time to avoid having to deal with failures
-	 * partway through setting the new attributes.
+	 * partway through setting the new attributes.  Clearing attributes
+	 * only stores NULL, which never needs to allocate, so skip the
+	 * reservations entirely in that case.
 	 */
-	for (i = start; i < end; i++) {
+	for (i = start; entry && i < end; i++) {
 		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
 		if (r)
 			goto out_unlock;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

