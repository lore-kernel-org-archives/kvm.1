Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC213822A5
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473053; cv=none; b=beu0ePF1OB5nhR5FVUCIrlqtFP0MzCJ6/DC8Z0hh24sS5XPsEFO+oRtafF7j6yCmtPtpVoj+r0rTjsbzrXpEhAR1au/Zmc/mQZ+PZQ7+yuMkToJ93djaHoDbGtZBgbDg7WUnL8NHCK3wZy1dSp4+hbjFdlyVZTj2SfRpRL0R7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473053; c=relaxed/simple;
	bh=XlzafqtqzssCQn0fo6uVy5EqI86whNIzBdn0viwW6Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cjpbn5ozmkargzaY8C5WQY5+vjs9Ohu9IYaI3THpR5qMA93Gtse84X1APX5yN5vnhygr/W89pPE6KXlJI7S2/8zicrBhJhAR3H4kicSoZtpZWtoapYXBKuv4//XKI6XifFUEz6NGZqTPkR7wGRDanhrgTv6CS10mvq8QNEIhlak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBIc75is; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9GjIxwX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBIc75is";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9GjIxwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
	b=OBIc75isXHF5CKxxfWw2izA4Wx+3nIfQniDFYSDEQJbOYaWcVIScdGVIgiq+t173czs8Qd
	GX2pOgU/f/l/9pye16E6rU1yY56d3Q7DV+0NqkKDJT+ix6CjvaFxZ6KQ8SGuYKMxkj5ogU
	wmDC1aBmEJHGOJIVbkvbYNlGkKB8HAQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-FsDGYyxANqOp8HsBPfhejQ-1; Fri, 26 Jun 2026 07:24:08 -0400
X-MC-Unique: FsDGYyxANqOp8HsBPfhejQ-1
X-Mimecast-MFC-AGG-ID: FsDGYyxANqOp8HsBPfhejQ_1782473047
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4926596eebcso5724275e9.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473047; x=1783077847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
        b=I9GjIxwXr4EPY9uGQGMdNyvUX+kb/8/+EJ4EePUmA8A5Wlp/xsaCtZeMpQH7l6vjrq
         BFRawBnpqamLKqtZAxfUxf5YVa+SqXm8PnpI6vwzE4yKgK5izeGDB7I/eSWghPPVnOVl
         93wCk/vqgZ7tK2qLlMeX8WmoX+SRjyOz07RQKjOoLGfZpLfrJmRIJ5akIbLecf0X9Ht0
         97ZVfDUXVLA1MqpaaSPKih4MEBTvPoPd25jioB1Oyve5bPuK1mcL75PKd1oKFj3Xw43+
         4Az2toEtIne9qnJL+J8Q7KT7fioRuSgg7cHd0XxvWrLenzzyOecZlcWMoVRpccG8be84
         nf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473047; x=1783077847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
        b=gIzgH0hLkulqEMqlRnCXWUHRJAYxmNTuUto1FzSGxiFfVyP0EX/0DXIQOD8d2wKEft
         LdHbjM+gGqkF2oEgtSHghi/ulGTl5DLfiWEcaHXErcnQBxvLqHTH3VteKnVhMeF/UvXD
         DHEkztUqgsC7rQ3vCjXd1Iv9EgfUWjtr/J9Wf7G3PW/NwmTX4Xm2s8MdnUmy7sWzQ877
         8B6h0Y/eByMsTohlVt/hMiQnox7VZP0lB+ZC8tBxJsejtHpclWjfvKHGZ/C4qwFcNns0
         KYnWyTpoFYBRksPemqwBAIZpxtbuZWMXqDqVVisYxetMnmGw49p/eI1fn70LPLFOtSMj
         Q/2A==
X-Forwarded-Encrypted: i=1; AFNElJ/dvKNOg2QMEbYAUMgxWAvLjDA3oS51x3f/Iu8m9HpVnwdXJWBp7YeWvAn/4BzBwMcE6VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXf1l8k2sLlrvWb1AdidlTcoSxph6Ug4U/cB3qqwyYuW3f5mm
	aPG5IJB+2TuARmEqerUXioyhYR2hf5w8MDKl/jTozn842BH/Vk+dFw607zGpPZJi3x0lYLjEe5u
	54LhNE18BWtl5+9V2pkMYL5YCLK2NhGoFzeKe74Fq+2MqYP44e86YhQ==
X-Gm-Gg: AfdE7ck74jFZg5/PaEl6pksOhVsD277IzUzckU81k87vY4UhBRVQWBmg626NrDktU2H
	xroVmNhO0RC36NWYOXTzcoaj0I8nTgAu10pK7OOo6etlaarglr0lN8ABM4MPNF0Ip2KLaEHikeE
	tVpn8Bi9NkOpgWJmgqPuzydlD1c40AFhnuCmL08Pp3Sm5oGwB5EtVT7e2zKNsdJwRnQ8BDRWSaT
	gzwu/jVQpA6Dpgc4LlnZx0toBnRTkiU529yFz6vj6MViw8HTve1398LZ9LNqMge8WqUMz5WcCJG
	2Fh19gHCMCbeee0bgPeCiPflzMnFU6zXIGrXYgAFTqGjpb/sOoCZpH+J6V3Z25YdhH719KGorOr
	cSLAY9iPsdibHDJO04LzNOHW6iccme3bfiOoqfXsz73nfUzv1RijBCtAtmzA8gC/2wThJ5dWB4a
	UOXBifzOyReBagYkMm
X-Received: by 2002:a05:600c:4f90:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-49266884b39mr85434185e9.28.1782473047266;
        Fri, 26 Jun 2026 04:24:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4f90:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-49266884b39mr85433705e9.28.1782473046765;
        Fri, 26 Jun 2026 04:24:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f0db007b3sm5172225f8f.2.2026.06.26.04.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:24:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 6.12.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:24:04 +0200
Message-ID: <20260626112405.1777340-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 81ccda30b4e83d8f5cc4fd50503c44e3a33abfeb upstream.

Commit 0cb2af2ea66ad ("KVM: x86: Fix shadow paging use-after-free due
to unexpected GFN") fixed a shadow paging mismatch between stored and
computed GFNs; the bug could be triggered by changing a PDE mapping from
outside the guest, and then deleting a memslot.  The rmap_remove()
call would miss entries created after the PDE change because the GFN
of the leaf SPTE does not match the GFN of the struct kvm_mmu_page.

A similar hole however remains if the modified PDE points to a non-leaf
page.  In this case the gfn can be made to match, but the role does not
match: the original large 2MB page creates a kvm_mmu_page with direct=1,
while the new 4KB needs a kvm_mmu_page with direct=0.  However,
kvm_mmu_get_child_sp() does not compare the role, and therefore reuses
the page.

The next step is installing a leaf (4KB) SPTE on the new path which
records an rmap entry under the gfn resolved by the walk.  But when
that child is zapped its parent kvm_mmu_page has direct=1 and
kvm_mmu_page_get_gfn() computes the gfn for the 4KB page as
sp->gfn + index instead of using sp->shadowed_translation[] (or sp->gfns[]
in older kernels).  It therefore fails to remove the recorded entry.

When the memslot is dropped the shadow page is freed but the rmap
entry survives, as in the scenario that was already fixed.  Code that
later walks that gfn (dirty logging, MMU notifier invalidation, and
so on) dereferences an sptep that lies in the freed page, causing the
use-after-free.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d288c60ae200..a67d013fff4d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2329,13 +2329,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 						 u64 *sptep, gfn_t gfn,
 						 bool direct, unsigned int access)
 {
-	union kvm_mmu_page_role role;
+	union kvm_mmu_page_role role = kvm_mmu_child_role(sptep, direct, access);
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
-	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
+	if (is_shadow_present_pte(*sptep) &&
+	    !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) &&
+	    spte_to_child_sp(*sptep)->gfn == gfn &&
+	    spte_to_child_sp(*sptep)->role.word == role.word)
 		return ERR_PTR(-EEXIST);
 
-	role = kvm_mmu_child_role(sptep, direct, access);
 	return kvm_mmu_get_shadow_page(vcpu, gfn, role);
 }
 
-- 
2.54.0

