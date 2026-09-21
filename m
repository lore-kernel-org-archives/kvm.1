Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3947011C;
	Mon, 21 Sep 2026 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986319; cv=none; b=jGXB8cPRcs5BSxo+lQbYC7IgCjvmUTZ7jLV6/T77YW20/JRA1ERVFsBjmXQm28KbOBnWapWQkTGieXohGk1wnnjSw65fKc5ibKgw1Jf6mCAWi7iTr8IHultxypyXADK7b6yjM1TxjET58q1ffAdT8zm2xVl5b3ET06B7q5UdJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986319; c=relaxed/simple;
	bh=Now0Qpi2foNjf/cfFRimz5v9RXKlErVsVE3KJdhDivE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L9J5yZSOxPPV1SJv1T99fwNAerKt6AhLuG/+ShyaXcr3iifsXDZ41C5vrljNzZbYa0UiEquY3yLkbfpW6V7FQx1ZC4rqtHkH7SdupYKUafVEp5iagBAd4xdGGVKAQd3aYOZguP2a2JaAsVGe5uLGwCGOyayyLSHBGQ8rvhbeTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V67Sce65; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V67Sce65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wx
	wZYCeDLl+p5Y5j0iGX/sMKQABMGkScHGtuKNgNBpY=; b=V67Sce65EGuVzYJ1kl
	01eraDdvUN54eUmqKZN21b1l688D+d23k3dZH/EWeX2iSCSem3EhmcZHFW8Us0IN
	TbhQnfko4+5uNF1cqAa0sR57e7d/6e2yawyJqqtpKapfoDwZo1rS8uUy6fJhbqPj
	mwSRH54MaKvQRUgKhKs2TW7/U=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wA3a9ntBbFqcIbHBw--.46549S2;
	Mon, 21 Sep 2026 18:24:47 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: chao.p.peng@linux.intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn,
	David Ballesteros <davimaba.v@proton.me>
Subject: [PATCH v3] KVM: Don't treat reserved xarray entries as having memory attributes
Date: Mon, 21 Sep 2026 18:24:42 +0800
Message-Id: <20260921102442.1232375-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3a9ntBbFqcIbHBw--.46549S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4DtryfXrW3WF43uF18Grg_yoWrXF1rpF
	95GryUKws5tr1xZFZaya1DZ3Wruw1Sqw45JrWDKw1DZw15JasaqryrKr1YvrW3ArWkW3Wj
	qF4jva48u3yDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCvw+DP2qxBe-MqAAA3Z

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

Drop the shortcut and handle the !attrs case in the per-index loop,
using xas_next_entry() to find the next non-NULL entry.  xas_next_entry()
is essentially an optimized xas_find(), so the effective change is that
the !attrs lookup now goes through xas_retry() like the attrs != 0 case,
i.e. reserved entries are skipped and retry entries restart the walk.
Don't check the index when no entry is found, as the xarray leaves the
xas index in a bogus state in that case; no entry simply means the rest
of the range has no attributes.

KVM never stores a non-NULL entry with a value of zero (clearing stores
NULL), but such an entry would be returned by xas_next_entry() and trip
the index check, so WARN if one is ever seen.

While at it, skip the reservation loop entirely when clearing attributes,
as storing NULL only erases the entry and never needs to allocate, so no
reservation (and no cleanup of a failed one) is required in that case.

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: David Ballesteros <davimaba.v@proton.me>
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 virt/kvm/kvm_main.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 108d42c5c1d6..c0b00c8ad2ea 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2457,14 +2457,23 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
 
 	guard(rcu)();
-	if (!attrs)
-		return !xas_find(&xas, end - 1);
 
+	/*
+	 * xas_retry() skips reserved (zero) entries.  For !attrs, find the
+	 * next non-NULL entry; not finding one means the range is clear, and
+	 * the xas index is bogus in that case, so don't check it.
+	 */
 	for (index = start; index < end; index++) {
 		do {
-			entry = xas_next(&xas);
+			entry = attrs ? xas_next(&xas) :
+					xas_next_entry(&xas, end - 1);
 		} while (xas_retry(&xas, entry));
 
+		if (!entry)
+			return !attrs;
+
+		WARN_ON_ONCE(!xa_to_value(entry));
+
 		if (xas.xa_index != index ||
 		    (xa_to_value(entry) & mask) != attrs)
 			return false;
@@ -2581,9 +2590,10 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	/*
 	 * Reserve memory ahead of time to avoid having to deal with failures
-	 * partway through setting the new attributes.
+	 * partway through setting the new attributes.  Storing NULL never
+	 * allocates, so no reservations are needed when clearing.
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

