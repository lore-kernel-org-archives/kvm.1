Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753614;
	b=Eexon9ExLwOZamGS8NRUUjFh4DFKWyiGEhAzfpPkEFr0t1yl2LKS76MIdK6VJZE034Z3
	 Fn+sQqBQTwOB+uZQXFWMCYZqn5Yx9vhsRJyMMwY5CbrrwGSESVZjtNfRKlncnCYzm4Aqn
	 rng8o5LLxGmYYB0Ar94HreS5CpC4vhOlMNjWeDNjPvIk1QeHNWQWFoERbRekOtvv7j++D
	 7QM/X0hcVGPlRuqvDIhpmeU5m8wOiy+P15MAk/J65cD/sS7UWOssXe3f/K+mZKU9F4WpH
	 o+dtMVwmcsN96rDGtfxu4j0VRnG//31oU5KLH0BMsu0usqSEbceFU0vhOOuUXz86kmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Noyht4TuZWh1NE3NpPCNH4SGr3Qu8mV0olkuMsgHzks=;
	b=KjRFPxfwXiCsIducw2bM4GWQ4XajP3af78+xR4bA6M6unJRJyLVs9s3jfxo2u5b/ix/2
	 5tN68CiCeTfUiGwCyQXB8KIHzwgMHGO7MuG2VaekVCAFMk6r6SuPTmhGOZB2XyPvLdMQA
	 oh8j/4W4aNyy3DUcwTWqoBnQOfzBo//9xSfFSNuqXLGSq/jZZJZn1eu3RypipySZx0vWb
	 EFmyGCS1P0f+bY36aR67eDvIWmn0Xbjd1R/FE2KM5pgB2OaHp/xlbLac0nznboegafUm3
	 srq+9eDfFxhJqwixXCmiNCDDe+e/XrvxxnAcerwctBvpTMS5bTDZKOR2zjwjFOo6+Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RN2C0KHP;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58048606A329
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 00:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58048606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RN2C0KHP
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so7957415e9.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753613; x=1794358413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Noyht4TuZWh1NE3NpPCNH4SGr3Qu8mV0olkuMsgHzks=;
        b=RN2C0KHPgGM+2f8SuD524sHUC+d5SrztGovvNaxe6Lma7wMD6m9ZJcwpAeou2IeAE+
         KQLCt22JEXGsIIRekVf4EZZbAq/ZNSYNU6PnSNgCusUDsubM3IFg1etC8XuJ+u6aOSqe
         wGlQN346RV6rDDbiTZgJRSQVrJW7LEKJWBZmCowZXzb6Cxhef8nJj3U4fyVj8FJvDCuv
         4ZQhy/jzkbqheRrShgZai+iuxIIMaC0KgolG5oWvECYEdcomqxPv5z/alHTYcHEQLcP/
         yUZXN11GnvFtNF088Si/dPtkfVLUUhJathHRFs8rhSCd1ZWlD8tp2thWrbkFqj9jsvkI
         OCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753613; x=1794358413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Noyht4TuZWh1NE3NpPCNH4SGr3Qu8mV0olkuMsgHzks=;
        b=HBDO3JvK7UZGPoStzw+qGtNO2n1JLSP5dmBcDzoNt7naKJETTMKVorlszKv6BVILhR
         Vq3Fp4Y5sti0pxVpzY19MEFcejmSIkWq+3LiRCJI6GJFwq+y7F6TY3pdzTFDLTFVB9yF
         rpdOXQbh82coJit5FRanv68RQjZpmv9TiWXCQzepb0rhPAGZ9BYLUTM46+MisX+TvCEW
         ap3uPi7W0usjhITkwBfNekYiEnDgubcywik8rYLe6RPHLwnw1XGfppnnGPPOxpgPe4GW
         LWG1cqigwz2yYQYLRBeDosUzQYZPZvFDf0XQCLAiuLyLJiiWvs/FzTKL3O08yO44rcmI
         SiRA==
X-Forwarded-Encrypted: i=1; AKwUvBzkyZ5tFDKUBpSI/9jCzDkPqB17gEJlwjt714KO5X6nikt1ln19+70FzPPhGVvJqn5PA1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8A2H2jhysLgg4NDMytYEvZnaCzbSpQBM+eK5xwDOCd1clfiOEn
	r0ETTu9f3ncXWq3tEIl/s/K2SsjLIi/CKz9aC39PhkvroeDCFPtb4Yql
X-Gm-Gg: AYBFou2BEPWloN6Aa9PxkKFbu6LBlEjAa+mtVwx5Gg72YW+ZLjNspg21zwX9gwy9lZo
	AA8BJ7QYOlmtOHrDWuXyhMz8hWPx9QBU8EYmCNrUUG0YB/4gm86lY7qE5mbKHX7572UsHQV3kVe
	jmdVOE1xLabVadZ/Ro18rtSOrSCaej/NY0HmTHAM/b0yCYTIMbTUIr6w1MNMVZ3CLzhDRZ9hn90
	cmbpWoaLU+e1itcnC/TDB+hcqI0SC61Ic/ppGOwMlHJ9Na5b2zbQZ0iLHH4Fv3282L/ihlGhlth
	s6raW4ARxVFeGvrYJ8e0AGaw5b1jacMnsCSa7Ct+mVSbIU83eqCUdyTzzgkYQFjCesH6hxzCiDu
	moRh4h3nXE7iNSA0tV3Bm/e7eOUMc0nycDQjo9XHch3EPn6kOXmd/WtWDrC1rZTQ2pjiJ9/pLoi
	qTu7j67EqjY2/0/ddi71SL2yDP+DBcTJns9IVGMWdLIS1pVu/hiF0Vza7ClPC5NYcSxpt/1g1lw
	ns4Rwixjcpxmx0YOcvESndZgFW/FY0ZfoJ0cso6yn1i+zWLyA1rWPOI9KayjLhNv0flcw5xz+4D
	LlmnN7j66Gif1exSNxaNMmZWmz48rRcUAMYB8TnZWto8gMUTRrElkyilxVsHFYujd30YTbpPCpM
	J/1mORKc70XPsV36zQAZAoRYo3wU6vrr+GkB2vLK9J1Ndi3ANN4aNIGDJXNpiAkNazQ==
X-Received: by 2002:a05:600c:4715:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4ac17567cc8mr323435835e9.11.1793753612715;
        Tue, 03 Nov 2026 16:53:32 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ed95sm11899275e9.4.2026.11.03.16.53.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:53:32 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>,
	James Houghton <jthoughton@google.com>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] KVM: x86/mmu: Walk memslot rmaps by index
Date: Wed,  4 Nov 2026 00:53:27 +0000
Message-ID: <20261104005331.50600-2-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104005331.50600-1-griffoul@gmail.com>
References: <20261104005331.50600-1-griffoul@gmail.com>
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

In preparation for storing memslot rmaps in chunks that are not
contiguous in memory, walk a slot's rmaps by index instead of stepping
a pointer through the array, and look each head up through a new
__idx_to_rmap() helper.

No functional change intended.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/mmu/mmu.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f4b12d6aef55..b3fcd6f2a991 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1236,13 +1236,17 @@ unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
 	return desc->tail_count + desc->spte_count;
 }
 
+static struct kvm_rmap_head *__idx_to_rmap(const struct kvm_memory_slot *slot,
+					   int level, unsigned long idx)
+{
+	return &slot->arch.rmap[level - PG_LEVEL_4K][idx];
+}
+
 static struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
 					 const struct kvm_memory_slot *slot)
 {
-	unsigned long idx;
-
-	idx = gfn_to_index(gfn, slot->base_gfn, level);
-	return &slot->arch.rmap[level - PG_LEVEL_4K][idx];
+	return __idx_to_rmap(slot, level,
+			     gfn_to_index(gfn, slot->base_gfn, level));
 }
 
 static void rmap_remove(struct kvm *kvm, u64 *spte)
@@ -1577,17 +1581,21 @@ struct slot_rmap_walk_iterator {
 	struct kvm_rmap_head *rmap;
 	int level;
 
-	/* private field. */
-	struct kvm_rmap_head *end_rmap;
+	/* private fields. */
+	unsigned long idx;
+	unsigned long end_idx;
 };
 
 static void rmap_walk_init_level(struct slot_rmap_walk_iterator *iterator,
 				 int level)
 {
+	const struct kvm_memory_slot *slot = iterator->slot;
+
 	iterator->level = level;
 	iterator->gfn = iterator->start_gfn;
-	iterator->rmap = gfn_to_rmap(iterator->gfn, level, iterator->slot);
-	iterator->end_rmap = gfn_to_rmap(iterator->end_gfn, level, iterator->slot);
+	iterator->idx = gfn_to_index(iterator->start_gfn, slot->base_gfn, level);
+	iterator->end_idx = gfn_to_index(iterator->end_gfn, slot->base_gfn, level);
+	iterator->rmap = gfn_to_rmap(iterator->gfn, level, slot);
 }
 
 static void slot_rmap_walk_init(struct slot_rmap_walk_iterator *iterator,
@@ -1611,11 +1619,17 @@ static bool slot_rmap_walk_okay(struct slot_rmap_walk_iterator *iterator)
 
 static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
 {
-	while (++iterator->rmap <= iterator->end_rmap) {
+	struct kvm_rmap_head *rmap_head;
+
+	while (++iterator->idx <= iterator->end_idx) {
 		iterator->gfn += KVM_PAGES_PER_HPAGE(iterator->level);
 
-		if (atomic_long_read(&iterator->rmap->val))
+		rmap_head = __idx_to_rmap(iterator->slot, iterator->level,
+					  iterator->idx);
+		if (atomic_long_read(&rmap_head->val)) {
+			iterator->rmap = rmap_head;
 			return;
+		}
 	}
 
 	if (++iterator->level > iterator->end_level) {
-- 
2.47.3

