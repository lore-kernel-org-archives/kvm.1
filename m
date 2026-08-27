Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1690442386;
	Thu, 27 Aug 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828807; cv=none; b=Vz2j2DFwc94Q9FPidQxMNx1T3J26kFzFwmLLu0ULK0ItQj4KW1YKjgi+IFF736lw0Y1YNWYy9+et0YG1zSqCu673ZROLcdOM3sGkENbkC3KFp9IvRWtSsCg784Q3yiku5808n5MzKXasJkRSKfRHPbTJTnhaE3zXmmWy8/umcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828807; c=relaxed/simple;
	bh=Mwok4D6Z97zpbH+7hsrLXnbXIFTqw5arzv1nPOyNruI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZhGlf97M5dAyXUo+6N8JS0BB4QVOVy6GUxLfnWYqbCWADtQqjCKdIUgeEa6q12n/FiktnWWN4XyoeMOiTSA69TfUjE7dYUGxxbQydWiY/JnuS6Z1LrBz1bgjQ11PxAFTVF4V3diKvupD41sAVlxE2q2ghKcMRsQmh2gIubeF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UH+3EmeY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UH+3EmeY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+c
	beuehtt3XZHv1/3LwaEWwYrGuUef3m9TDF3qzwGi8=; b=UH+3EmeYazpiL7raB3
	w2QIi9SCX7ZlDnVVAGy9FuMaJa6CUNl9ue0fNsxEgGwcErNhkL3//qIfXveb+KJm
	H0slzFNB4+CWUFXiCIea6TVCvWcdc7SJlU3AnWmxDAEegMAYUTIv0EziAQk32dFH
	sdS3GBTuZvDOmHMPLSzinIJQw=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXG9EaGpBq3ORxRw--.60880S2;
	Thu, 27 Aug 2026 19:06:04 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: pbonzini@redhat.com,
	seanjc@google.com,
	chao.p.peng@linux.intel.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn
Subject: [PATCH] KVM: Release reserved xarray entries if reserving memory attributes fails
Date: Thu, 27 Aug 2026 19:05:58 +0800
Message-Id: <20260827110558.457891-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXG9EaGpBq3ORxRw--.60880S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW7ury5WFW3KFW8WF43GFg_yoW8ZFWUpF
	yDGrWDGw45Jr12qaykta1Du3W8u3yS9FW7AF15Ka47Zr15Jwn2qryrKr4jvr45ArWvva4j
	qFyjg347CrWUXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8iSdUUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbC6BxMCGqQGhwp-AAA3Z

From: Zeng Chi <zengchi@kylinos.cn>

kvm_vm_set_mem_attributes() reserves an xarray entry for every gfn in
the range before modifying any attributes, so that the actual updates
can't fail partway through.  But if one of the reservations fails, e.g.
due to -ENOMEM, the entries that were already reserved are left behind,
as the error path bails without releasing them.

A reserved entry is XA_ZERO_ENTRY, not NULL.  xa_load() hides the
difference, but kvm_range_has_memory_attributes() uses xas_find() to
check whether a range has no attributes at all, and xas_find() returns
zero entries as-is.  As a result, a leaked reservation makes KVM think
the range has attributes set even though kvm_get_memory_attributes()
reports none.  On x86, the next time mixed-attribute tracking is
recomputed for the range (memslot creation, or a later attribute change
that straddles the 2MiB page), hugepage_has_attrs() treats a fully
shared 2MiB range as having mixed attributes and refuses to map it with
a hugepage, until userspace happens to set attributes on the range
again.

Release the successfully reserved entries on failure.  xa_release() is
a nop for entries that hold a real value, so it's safe to blindly
release all entries in [start, i).

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 virt/kvm/kvm_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..20031a832c21 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2575,8 +2575,11 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	 */
 	for (i = start; i < end; i++) {
 		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
-		if (r)
+		if (r) {
+			while (i-- > start)
+				xa_release(&kvm->mem_attr_array, i);
 			goto out_unlock;
+		}
 
 		cond_resched();
 	}
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

