Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749658;
	b=L9oWCAK97KSp+LkyXnLpCQW450ybGQs4bDaq17i14tvXsEsWJh7FeMzVQvLSfBU35Aq8
	 +k2sywWeZxJT8Pf3Xmykpor20K7BTI3ItDDXVB4muKue8+45Uvp0I0h2IstWAAqWwlzwc
	 UVGifl+MJOMGWjS/Bocul4GRhJcctNG47KniTJRbj5CFBEOGYtlKp1Wkmwo3tz8Yy4gAS
	 kHvnYAdZIdM7puCdUUPYAOtgRjLgmmGikdzzJeGJBguh+tCRaO/lZV04Y9JuYLB6qSNwQ
	 yq1PI++kje6pgn6HKmhdcFcymyYO1itEzaLI8LtHiRkcpLK+uat19IMZX3pvcFAs/Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AkKw4T5m37AkLEe85hcfetEiJRRZnmi/qOahhWII6+4=;
	b=C61Fv/I6O/NjKNrvI4B9cu0NYF9hc8J6/mV04tJy/2S/B5hvhIzNk2IL1ZxEc+2TWn6n
	 Q+iOIyHCJMIJc4q8k08qwKfqQ8h61A7RibdjxuQy/ObvU13tG9umlyJWfbBRzfw+QWjyb
	 8WvBN1l6XyCBkGlny/1/Dih265Df8SPIudVjI5309VvUv6+Uc4O7TEo4NNITq/+s5Ib3I
	 4YTlXV5Bt/BzgD6lPPlJpNqK7wnUtw8npOiWwETyc5bMViq93dFMIf1F7juzG2f6f05Zs
	 H0r2jFU8AJ9o8vjhRW5p+mxZrP02deGAxy6NIq8TtWBuc2irVooAcIDAuqooDNUPQwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ERXTcHWS;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FA606A328
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 23:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3FA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ERXTcHWS
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso537365e9.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 15:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749656; x=1794354456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AkKw4T5m37AkLEe85hcfetEiJRRZnmi/qOahhWII6+4=;
        b=ERXTcHWSYCrkK2Qrh6f15zyBfRtOn/QeZy+UFHEqi3AW08uOHBNpKkrULsL3Qy3sN0
         MfxlbOAAFb2//xkWF0ZAuksl8OCrXuixPN/k2+yuQ/BFQHCujTyaeact3H8+qco3HkPv
         58U8g0M/vvgu7X7IeehrhIxJRca4IiiyXrFEDZksElVBfOIGiXl5K3BHyqX/xI+8Uc2R
         8+Z0CDSfd9a7BSZjk8ncQaf4tJG2if7DHqpykhBy04YuBoD6+XKLd4s6+Y0FWNu70ZaC
         sv2ZoLuUTg1xOPzQNnQyYzLaoEXlNCY3KZlZuTwvBw9v9jc3JR8UNViBdilNkXPtelLv
         8d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749656; x=1794354456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkKw4T5m37AkLEe85hcfetEiJRRZnmi/qOahhWII6+4=;
        b=BAC/igPSpjYYftalomiyoIlOmmvRTA303XLBLKujsxC46duYIc6Mm5FEKPUulmmV5O
         coJ9QPQKkT4ILx8ybSOu7hpGu4slNRYzN0p8AKzr3X8ea4/1fJaO/34UywrsiR/mbUaV
         8Sm2gi0yUDFvg5wR5Rf3IyBU66D+ve3Z50R6LxzUhD+k4CFv7Fn5l6/pSpTJhOqNj2sF
         TzRH5hzvkGUMzwLcq2tm3YplT4cI+NQ2fHEWiWWYJwdLnsiJY1qMBw8/qlN5LBSuPXNe
         nN0/Th+0AKg9Uoa+m2UMQ3+6pi2kveib2Wqdj1CeVIfByu01Q1XsvWfKpPENuSgpU1sZ
         q84g==
X-Forwarded-Encrypted: i=1; AKwUvBzTUGaGYUk4nyqa+OOvX/mkhRJWrdEMSvsmt133XAgz/DkL+DS7iYaNeadqooBQ8OWAshQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e6mRAQS6ijRlZiiXfGbX2qGSPw3JRsTYsVQbCJbKQnWZYsTsF
	2oxrDR9QLPdOmYIiBs31SiRUTnqgNpzdOQdF0HJ7G2tMdRbBtL+ffath
X-Gm-Gg: AYBFou0AWBg20ZGUtmkmfF0y4c8hx4minhpuxOWw8xtbMZ+Dy+Sox2nlWYkQAI4e0RY
	41GeNfdjRZklijsFrJA9ihScx4Ovzj1Qb9tRIzJbvX2dhZWa4otEGVi1gd98pkMW6CPthgoDRUD
	MzpD8sWdg/xBzPr2pCGVm+4j3pq8I+Jjhp0VBeXj3F1wxbLkKSrqm6tG5IHFlbeGgNOzsJq3uPn
	NMTNe2v2fObtkdmd7Xj7Ty8dfRHCBa7gfn1IW/eO9dmNAxQWD+ar0Rw+vPAVvZBEyvyUgIYHYUZ
	k9Y370k63WflKnYCLB+ik2df7NsUxHSlvIhJbzvjDPUpA0JaC+Yy9kAsCR+b3OlTvDJIVOLl1JN
	u8xvyYF3mght7Cd2daa1gjVg5fr4F7AfljLBxmB0CtNvoUm43CZIjskxMP1XqGxnAE73Xm8Fj6W
	tAnnrJJpc0x/lT4/MpCXbTFb8g67MQE/zj9cnR/LdEVihJZoHbBUpjYjTs59RemPBkd6oAWdtn3
	B6Wl7dyW9AKQDn3LB6vRa9uAZy+t+SXmolSihWira46+of1p85lqcJPyIGzz5fud/9kxo95ir5m
	qki2/TxgOhIftjgjon1+3W/isNbW8WHGb12Me9tQ3KI13jrHWTUhvJB8Fw8ZXzFW5tqZBZkljQ9
	Zk8EOnl2EBS9GgH1C5aXU+wHS7uhWe4NGUmEqiaTjhXTNsugOmP5hQ8mzKhmBfBDRBQ==
X-Received: by 2002:a05:6000:383:b0:48e:889b:5fe8 with SMTP id ffacd0b85a97d-48e889b6deamr11283948f8f.10.1793749656012;
        Tue, 03 Nov 2026 15:47:36 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feea5d4e4sm550961f8f.57.2026.11.03.15.47.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 15:47:35 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: Add helpers to allocate memslot metadata
Date: Tue,  3 Nov 2026 23:47:34 +0000
Message-ID: <20261103234734.45413-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

__vcalloc() makes every allocation at least one page, so a memslot
that spans a single page uses 8 KiB of vmalloc for 8 bytes of
lpage_info, plus 4 KiB for a 16-byte dirty bitmap once dirty logging
is enabled. The waste grows with the number of memslots and VMs on a
host. kvcalloc() avoids it for small arrays, but refuses allocations
above INT_MAX bytes, which the rmap and write-tracking arrays of a
large memslot exceed.

Add kvm_memslot_metadata_alloc() and kvm_memslot_metadata_free(),
which use kvzalloc() up to INT_MAX bytes and vmalloc above, and route
the dirty bitmap, rmaps, lpage_info and write-tracking arrays through
them. That way, how KVM allocates memslot metadata is decided in one
place instead of at each array.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/arr1VgGZmgUmY4hc@google.com/
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
Mushahid's patch [1] switched the lpage_info arrays and dirty bitmaps to
kvcalloc(). Sean suggested dedicated helpers for memslot metadata
instead [2], which this patch adds.

[1] https://lore.kernel.org/all/20260815142218.85067-1-hmushi@amazon.co.uk/
[2] https://lore.kernel.org/all/arr1VgGZmgUmY4hc@google.com/
---
 arch/x86/kvm/mmu/page_track.c |  6 +++---
 arch/x86/kvm/x86.c            | 10 +++++-----
 include/linux/kvm_host.h      |  2 ++
 virt/kvm/kvm_main.c           | 23 +++++++++++++++++++++--
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index f12558dfcd81..f33547964b98 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -43,7 +43,7 @@ bool kvm_page_track_write_tracking_enabled(struct kvm *kvm)
 
 void kvm_page_track_free_memslot(struct kvm_memory_slot *slot)
 {
-	vfree(slot->arch.gfn_write_track);
+	kvm_memslot_metadata_free(slot->arch.gfn_write_track);
 	slot->arch.gfn_write_track = NULL;
 }
 
@@ -53,8 +53,8 @@ static int __kvm_page_track_write_tracking_alloc(struct kvm_memory_slot *slot,
 	const size_t size = sizeof(*slot->arch.gfn_write_track);
 
 	if (!slot->arch.gfn_write_track)
-		slot->arch.gfn_write_track = __vcalloc(npages, size,
-						       GFP_KERNEL_ACCOUNT);
+		slot->arch.gfn_write_track =
+			kvm_memslot_metadata_alloc(npages, size);
 
 	return slot->arch.gfn_write_track ? 0 : -ENOMEM;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff8a0..dc716ad83c8f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10146,7 +10146,7 @@ static void memslot_rmap_free(struct kvm_memory_slot *slot)
 	int i;
 
 	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
-		vfree(slot->arch.rmap[i]);
+		kvm_memslot_metadata_free(slot->arch.rmap[i]);
 		slot->arch.rmap[i] = NULL;
 	}
 }
@@ -10158,7 +10158,7 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	memslot_rmap_free(slot);
 
 	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
-		vfree(slot->arch.lpage_info[i - 1]);
+		kvm_memslot_metadata_free(slot->arch.lpage_info[i - 1]);
 		slot->arch.lpage_info[i - 1] = NULL;
 	}
 
@@ -10177,7 +10177,7 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
 		if (slot->arch.rmap[i])
 			continue;
 
-		slot->arch.rmap[i] = __vcalloc(lpages, sz, GFP_KERNEL_ACCOUNT);
+		slot->arch.rmap[i] = kvm_memslot_metadata_alloc(lpages, sz);
 		if (!slot->arch.rmap[i]) {
 			memslot_rmap_free(slot);
 			return -ENOMEM;
@@ -10214,7 +10214,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 
 		lpages = __kvm_mmu_slot_lpages(slot, npages, level);
 
-		linfo = __vcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
+		linfo = kvm_memslot_metadata_alloc(lpages, sizeof(*linfo));
 		if (!linfo)
 			goto out_free;
 
@@ -10250,7 +10250,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 	memslot_rmap_free(slot);
 
 	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
-		vfree(slot->arch.lpage_info[i - 1]);
+		kvm_memslot_metadata_free(slot->arch.lpage_info[i - 1]);
 		slot->arch.lpage_info[i - 1] = NULL;
 	}
 	return -ENOMEM;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..11a6f501a78b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1253,6 +1253,8 @@ enum kvm_mr_change {
 
 int kvm_set_internal_memslot(struct kvm *kvm,
 			     const struct kvm_userspace_memory_region2 *mem);
+void *kvm_memslot_metadata_alloc(size_t n, size_t size);
+void kvm_memslot_metadata_free(void *p);
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..ce872ffc779f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -941,12 +941,31 @@ static void kvm_destroy_pm_notifier(struct kvm *kvm)
 }
 #endif /* CONFIG_HAVE_KVM_PM_NOTIFIER */
 
+void *kvm_memslot_metadata_alloc(size_t n, size_t size)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+
+	/* kvzalloc() refuses sizes above INT_MAX, which large memslots need. */
+	if (bytes <= INT_MAX)
+		return kvzalloc(bytes, GFP_KERNEL_ACCOUNT);
+
+	return __vmalloc(bytes, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+}
+
+void kvm_memslot_metadata_free(void *p)
+{
+	kvfree(p);
+}
+
 static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 {
 	if (!memslot->dirty_bitmap)
 		return;
 
-	vfree(memslot->dirty_bitmap);
+	kvm_memslot_metadata_free(memslot->dirty_bitmap);
 	memslot->dirty_bitmap = NULL;
 }
 
@@ -1449,7 +1468,7 @@ static int kvm_alloc_dirty_bitmap(struct kvm_memory_slot *memslot)
 {
 	unsigned long dirty_bytes = kvm_dirty_bitmap_bytes(memslot);
 
-	memslot->dirty_bitmap = __vcalloc(2, dirty_bytes, GFP_KERNEL_ACCOUNT);
+	memslot->dirty_bitmap = kvm_memslot_metadata_alloc(2, dirty_bytes);
 	if (!memslot->dirty_bitmap)
 		return -ENOMEM;
 

base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.47.3

