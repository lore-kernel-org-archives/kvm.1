Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97049402B93;
	Thu, 23 Jul 2026 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842852; cv=none; b=hr4GDnVxtBU64jEzc/dCzCofjTec0r+Faxk6wn9AaNXzs5gfqDTgxVZrE4DxYNx4mea1pP0qoOAegjUURSB+7gu3K98zl7o2mfOjFaCCFNoJyH0IWJn/fdczg0qdTxG/rQYw/PUwsbI+nkmZFXkKOEYHkJf2A5klPGovS/oJy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842852; c=relaxed/simple;
	bh=Cjv8QJHtd0pUb3u+ff15sC/JZFNqeFKcymojrXSFakY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o8sYefWZPH2xH21H5bjBrMxDZZE/hoaspjieENAZS6LY0tZQpmcU2J6FRlB0ajgJ5omqbIg6uU4pVfuAGuiooOe5XHKdcYky/FGcN0+LcudTAv6y4qAIFaCHd80Lt6pNHUYJJkGpV6uph9RsPBUU93k8wjpSmVmNi9qpIryOIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OBhTohL3; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OBhTohL3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=RbKMBHxwEqRPyiK68GNVWi/JR+RCBD76zT5sOBWEx+0=; b=OBhTohL3yIiqVZUi6mQMYoEAp8
	gjDDg1kax8Gxc7FMsNwjy/Ier0dqYMS3QF1FOlO1FeVoB27vzk0SrPx5UXXvAtkYthHVEO8FeeE3c
	g661wVhEKnpBvwtuaVDjCrsRfBQfLduRwX/WZ6JbrMVZRpPqLaVkjUpJXcHQ3EdHjbf32gkpXySwZ
	dpwWccOr4wkf7SlgAvEihwdmkuyBmcbMkTv2WU1rLK7ZbRLq5LaFJgRMw1ztEUaJ2wDUAjzKneMV0
	duZnerR2G0RFmMvs5eG0GcVYyKoKZRKoYXWveavezQ+uMENcAHCUZwApgr+ebUCdAu6qPm/OMezPn
	J2/2Ziog==;
Received: from 189-14-83-55.vmaxnet.com.br ([189.14.83.55] helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wn19c-003cGW-65; Thu, 23 Jul 2026 23:40:32 +0200
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Thu, 23 Jul 2026 18:40:10 -0300
Subject: [PATCH] KVM: pfncache: invalidate sibling GPCs before releasing
 retry pages
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-kvm_guest_pvclock-v1-1-bba3ea77419b@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0Q5DQBBA0V+RebbJGFL0V0SENWWqRXbYSMS/d
 9s+nod7T1B2wgr36ATHXlSWOSCJI7BjOw9spA8GQrphTmgm/26GnXVrVm9fi50MtlRiisRFVkD
 oVscPOX7Pqv5b9+7JdvuO4Lo+knJ7sHUAAAA=
X-Change-ID: 20260720-kvm_guest_pvclock-0a290302e848
To: Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>
Cc: kernel-dev@igalia.com, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+fb7c2dd166d3ea63df2a@syzkaller.appspotmail.com, stable@kernel.org
X-Mailer: b4 0.15.2

When refreshing a GPC, hva_to_pfn_retry() drops the GPC write lock and
re-acquires it on each retry iteration. During the unlocked window, it
can release the page from the previous iteration via
kvm_release_page_unused().

If a concurrent munmap removes the page-table reference during that
window, the GUP reference could be the last one left:
kvm_release_page_unused() drops it and the page is freed while sibling
GPCs could still hold mappings to the same physical page. A KVM_RUN that
hits kvm_setup_guest_pvclock() through such a sibling GPC then reads
freed memory, causing the use-after-free reported by syzbot:

  BUG: KASAN: use-after-free in kvm_setup_guest_pvclock+0x439/0x620
  Read of size 4 at addr ffff88804d02c320

The existing gfn_to_pfn_cache_invalidate_start() can't reliably prevent
this: the page is released without holding any GPC locks, so the
mmu_notifier invalidation may reach the sibling only after the page has
already been freed.

Fix by invalidating sibling GPCs that have a matching PFN before
releasing the page. This is done via the new kvm_gpc_invalidate_pfn()
helper, similar to gfn_to_pfn_cache_invalidate_start().

Fixes: 58cd407ca4c6 ("KVM: Fix multiple races in gfn=>pfn cache refresh")
Reported-by: syzbot+fb7c2dd166d3ea63df2a@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=fb7c2dd166d3ea63df2a
Cc: stable@kernel.org
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 virt/kvm/pfncache.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..9ea595e90d08 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -152,6 +152,37 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
 	return kvm->mmu_invalidate_seq != mmu_seq;
 }
 
+static void kvm_gpc_invalidate_pfn(struct kvm *kvm, kvm_pfn_t pfn)
+{
+	struct gfn_to_pfn_cache *gpc;
+
+	if (is_error_noslot_pfn(pfn))
+		return;
+
+	spin_lock(&kvm->gpc_lock);
+	list_for_each_entry(gpc, &kvm->gpc_list, list) {
+		read_lock_irq(&gpc->lock);
+
+		if (gpc->valid && gpc->pfn == pfn) {
+			read_unlock_irq(&gpc->lock);
+
+			/*
+			 * Re-check if invalidation is still necessary
+			 * after acquiring the write lock.
+			 * See gfn_to_pfn_cache_invalidate_start()
+			 */
+			write_lock_irq(&gpc->lock);
+			if (gpc->valid && gpc->pfn == pfn)
+				gpc->valid = false;
+			write_unlock_irq(&gpc->lock);
+			continue;
+		}
+
+		read_unlock_irq(&gpc->lock);
+	}
+	spin_unlock(&kvm->gpc_lock);
+}
+
 static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 {
 	/* Note, the new page offset may be different than the old! */
@@ -201,6 +232,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 			if (new_khva != old_khva)
 				gpc_unmap(new_pfn, new_khva);
 
+			kvm_gpc_invalidate_pfn(gpc->kvm, new_pfn);
 			kvm_release_page_unused(page);
 
 			cond_resched();
@@ -221,6 +253,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 			new_khva = gpc_map(new_pfn);
 
 		if (!new_khva) {
+			kvm_gpc_invalidate_pfn(gpc->kvm, new_pfn);
 			kvm_release_page_unused(page);
 			goto out_error;
 		}

---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260720-kvm_guest_pvclock-0a290302e848

Best regards,
--  
Heitor Alves de Siqueira <halves@igalia.com>

