Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6F128816
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781492945; cv=none; b=PKTrYq1ruyClaZ/E5JtTB/M2m5Amnmeu10thvUaZyC0+yxNoRSPMP0yEfWVwdnbRk31RPlKpJfnqSNvjzrlz65SUMIi7JECVAtvWATovRjE6Om/9WynqTQRyF6fXszH8ZQQ5isOYctIoDljiy1PLGt70bFlCpcz/su0lnCg7NQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781492945; c=relaxed/simple;
	bh=Sn+XkO4QGZb5vddTZf7YcmslGXfJpOcSMn1tgQKu3RA=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=FshDlezolGwcxSMfuIMH35qF6zlob3s9bBTcsMTP7QkzxqPdx3QdMu4pG2QtXdv0t9shc5VZLg+UWw6h6ivHJGEiYlaire40mjMDLQyy0/naneB2VksvJkLh1UrNvtaqdDDp7yCoor6M+qWD90GydGuJq3qFkhVBEdwK3tImgAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KKBWspdx; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KKBWspdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781492923; bh=64Mfmoc59Y3TO9Hq1NRSh+zdDYYU4EnkzDIVLQKyfvo=;
	h=Date:From:To:Cc:Subject;
	b=KKBWspdxKaPfkRvOnKw5YOkC6ZUVCkWdIjcRjX9resb67yhKjbM68VenEogiD/0aL
	 2xb3Bh8d/yN2nc3qJsEcGBHhlCG2ahzG559kyAMIEMhGU6XBD3VnDNyZNe/WhT6Vxq
	 LF13GgrxlAgS9CO0EoRfxqGWqj38T5Ky6M3chT/E=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 2289B27D; Mon, 15 Jun 2026 11:08:40 +0800
X-QQ-mid: xmsmtpt1781492920tnhl9w4cg
Message-ID: <tencent_7DA064CAC9B463EB9B651801011E2CE4230A@qq.com>
X-QQ-XMAILINFO: MsXRu/p5kTbf1viHl3BrLWl/1JFPOKh9U1B+LcvD9CWA8uFEc3m2lErNN3YQtr
	 pStClrxKHlZh/LSsliFA8DGsjpk7DpnBQXKgw5T1f14CdquWR8CyNeg1XSsygu/tpn2Jkn/2fx1p
	 4afygOZ5qv8jrj9WNe1I0EFJ7nHZFoiAn9QGiN0avS9VkEBqMeoleGj4QktL1zHLNp1p+EZ6eZRL
	 bRt/LtlcdgWQnzMPAPMkYMJqkZLsD4gbV5LLSr80GbIWn9r9VzZs2noDLntR40OfuO9TQVTtwOBS
	 k/wQsxtlyT6PtxsQR6eG1gZLN7lfUHE9HNlupN1fA1wfBg7kpC5Czw3zoND3zj65Ecq4T69TljU+
	 TsIbH2W9PSKDcKJo7k+d8n0x/+8nKmqUtF1/QOWXUTILCpJlU7b9QokeRodPiui/Xfn5yFN7l9pv
	 YIG4ebiCbA5OooCXkDCn/k70uxz7gnmWdCT/0LKZvHZIPFaCQUQsi708bm4qFtmgm59UCBITXULC
	 K1ErS3D8HF0kQBbbzUESFonVOM1n+rbthoMbFgZiYoqp2cO25B548aNzKrEjsTjtuS9Va4WdtVEV
	 /zjN0nOGbJggIJLcpKTIr/L+gd5FqzUIgCuHAFKYVAMa6ot5txY4nS5JqgZZr9gCpsGdZnyJiZpT
	 qzOiSLl4jL8pqv7zO56uNMb3GmnL5lnGmlUnE5FqFJY/hQMX/1gv1YsNG8HPnGZkjPhnC8pZTmlT
	 89PYeg25zBzrSzLBAKwJdHZJV/4meHFe7qmdlToLfXuu0btiWGJOLbDDgCGO0awXy+6RANa7+IeJ
	 uHJ3D37V/tqZtIj/kj0zjD4NctXkvFrQB0IiLYK4b46/WamVQTG5aL32TruF+jVnmhhmhm0ebuzH
	 kFc62T0pV67vCHZ+W1w2+j2/4/j42nNtkj8+12DmNr90M+gNYGp7Wc5bnoiCkMGyi5JeZIzdGwrO
	 oydTbeqvV55/aFlZ16PragKh6Lx77HUv9DigzpTf94VjC5gFzaGZ3JbUB1T2wJXuwDTX89eb5f4P
	 rVaxZGwEEi1MQR1q+hCC/AVCYCv6bBRsGXeFfX+BM4YCu5XQLEt+Jvaahij5HE2EWS6FEGfKuuaK
	 0WWW1gF62apj+mSB+bGJmnYN6gaHyXDv5NwtUySmouGU2JpzlFrz+h54ax0A==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
Date: Mon, 15 Jun 2026 11:08:40 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Ackerley Tng <ackerleytng@google.com>,
	Lisa Wang <wyihan@google.com>, David Hildenbrand <david@kernel.org>
Subject: [PATCH v2] KVM: guest_memfd: Fix ABBA deadlock in error_remove_folio
X-OQ-MSGID: <20260615030840.GA53051@zh-pc>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From e7f25639c05eac51b4ac8add3dd3e3a76f6f7340 Mon Sep 17 00:00:00 2001
From: Hao Zhang <zhanghao1@kylinos.cn>
Date: Thu, 11 Jun 2026 15:27:27 +0800

memory_failure() calls ->error_remove_folio() while holding the poisoned
folio lock.  guest_memfd's implementation takes mapping.invalidate_lock for
read before zapping KVM mappings.

That lock ordering can deadlock against paths that hold
mapping.invalidate_lock for write and then try to lock the same folio, e.g.
guest_memfd punch-hole via truncate_inode_pages_range().

The invalidate lock is needed for page-cache invalidation, but
->error_remove_folio() only needs stable guest_memfd bindings while walking
them to zap KVM mappings.  Add a guest_memfd-private rwsem to protect
established gmem file entries and their bindings during invalidation and
removal, and use it in ->error_remove_folio() instead of
mapping.invalidate_lock.  Update bind, unbind, and release paths to take
the new lock when modifying bindings or removing a gmem file entry.

Keep taking mapping.invalidate_lock before the bindings lock in paths that
need both locks, so writers cannot queue on the bindings lock while a
punch-hole operation is blocked on a folio lock.

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
Changes in v2:
- add a guest_memfd-private rwsem to protect the
  gmem_file_list and each gmem_file's bindings

Link to v1: https://lore.kernel.org/all/tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com/

 virt/kvm/guest_memfd.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..2ca68d09e2d3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -6,6 +6,7 @@
 #include <linux/kvm_host.h>
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
+#include <linux/rwsem.h>
 #include <linux/pagemap.h>
 
 #include "kvm_mm.h"
@@ -32,6 +33,13 @@ struct gmem_inode {
 	struct inode vfs_inode;
 	struct list_head gmem_file_list;
 
+	/*
+	 * Serializes established gmem_file entries and bindings with
+	 * invalidations that don't hold mapping->invalidate_lock, e.g.
+	 * ->error_remove_folio().
+	 */
+	struct rw_semaphore bindings_lock;
+
 	u64 flags;
 };
 
@@ -344,6 +352,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 
 	filemap_invalidate_lock(inode->i_mapping);
 
+	down_write(&GMEM_I(inode)->bindings_lock);
 	xa_for_each(&f->bindings, index, slot)
 		WRITE_ONCE(slot->gmem.file, NULL);
 
@@ -357,6 +366,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	__kvm_gmem_invalidate_end(f, 0, -1ul);
 
 	list_del(&f->entry);
+	up_write(&GMEM_I(inode)->bindings_lock);
 
 	filemap_invalidate_unlock(inode->i_mapping);
 
@@ -499,11 +509,10 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 {
 	pgoff_t start, end;
 
-	filemap_invalidate_lock_shared(mapping);
-
 	start = folio->index;
 	end = start + folio_nr_pages(folio);
 
+	down_read(&GMEM_I(mapping->host)->bindings_lock);
 	kvm_gmem_invalidate_begin(mapping->host, start, end);
 
 	/*
@@ -516,8 +525,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	 */
 
 	kvm_gmem_invalidate_end(mapping->host, start, end);
-
-	filemap_invalidate_unlock_shared(mapping);
+	up_read(&GMEM_I(mapping->host)->bindings_lock);
 
 	return MF_DELAYED;
 }
@@ -673,10 +681,11 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	start = offset >> PAGE_SHIFT;
 	end = start + slot->npages;
 
+	down_write(&GMEM_I(inode)->bindings_lock);
 	if (!xa_empty(&f->bindings) &&
 	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
-		filemap_invalidate_unlock(inode->i_mapping);
-		goto err;
+		r = -EINVAL;
+		goto err_unlock;
 	}
 
 	/*
@@ -690,6 +699,10 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
 	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+	r = 0;
+
+err_unlock:
+	up_write(&GMEM_I(inode)->bindings_lock);
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
@@ -697,7 +710,6 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
 err:
 	fput(file);
 	return r;
@@ -739,12 +751,21 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	 * until the caller drops slots_lock.
 	 */
 	if (!file) {
-		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
+		struct file *slot_file = slot->gmem.file;
+		struct inode *inode = file_inode(slot_file);
+
+		filemap_invalidate_lock(inode->i_mapping);
+		down_write(&GMEM_I(inode)->bindings_lock);
+		__kvm_gmem_unbind(slot, slot_file->private_data);
+		up_write(&GMEM_I(inode)->bindings_lock);
+		filemap_invalidate_unlock(inode->i_mapping);
 		return;
 	}
 
 	filemap_invalidate_lock(file->f_mapping);
+	down_write(&GMEM_I(file_inode(file))->bindings_lock);
 	__kvm_gmem_unbind(slot, file->private_data);
+	up_write(&GMEM_I(file_inode(file))->bindings_lock);
 	filemap_invalidate_unlock(file->f_mapping);
 }
 
@@ -946,6 +967,7 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 
 	gi->flags = 0;
 	INIT_LIST_HEAD(&gi->gmem_file_list);
+	init_rwsem(&gi->bindings_lock);
 	return &gi->vfs_inode;
 }
 

base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
-- 
2.15.0

