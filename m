Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EC3F0AB1
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703872; cv=none; b=mEguPFpG88AXAcfJDXxwDJkHgaE3xaR4mw4T1UeDdu9X8c2L6KTXwwmyWtQCJ3ylX+w4yU1BNILEfeW2iGCYAkqzUhTspwPvYeSs1n0xyNKIaXIMADdfBxIYsL28djxj5KjjwNwwVq/PE3+ZZJT8daidNajEVz4vscm3f4MDGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703872; c=relaxed/simple;
	bh=trzGjat07CTfPxrPQU1zxoBvahM3fPjTAmut22APz2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lffh2J6qsqAbyRjf+dyuG1mh1szt0q14cKZxPjLZx9gysGVDSs/nvfmoedQ5o0MgBsPPN0VSEvJqupQsDqQwuqJ9ss+9mf+p2PfhJSVUI5KOn6JdVZlifhQd+mnc/Po/rTSEmHNiZgnQiqQ9ktU41AGHwC1M+JjNlC1iSIFAlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtAfmqBd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMszsz82; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtAfmqBd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMszsz82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781703870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NkGGkGXV+1YZVOqd6U7cg5LVTCuD/L4oMW+qufKkKlg=;
	b=LtAfmqBdxtuam+JTrs1eo8FQezTvUUw3Pw7pBcOlvaFeT9QYC6AP3IW9bX4vud5Z4RcEW4
	pocx+fwv14d8f42gmsSagHeIoO6P9ey5KlrxVVKIPlnASllYIFJZP58429Pu9yRNvekxuP
	zz5EJxjno19Q75B8lIaGywnRc20yPaw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-6Gtmy8FiN9SXjHH0BtGNsg-1; Wed, 17 Jun 2026 09:44:29 -0400
X-MC-Unique: 6Gtmy8FiN9SXjHH0BtGNsg-1
X-Mimecast-MFC-AGG-ID: 6Gtmy8FiN9SXjHH0BtGNsg_1781703868
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5ad2acc5c9aso586143e87.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781703868; x=1782308668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkGGkGXV+1YZVOqd6U7cg5LVTCuD/L4oMW+qufKkKlg=;
        b=AMszsz82VyjPmc1UWIu0ZR1uoYusjEJZYdNlRX2YS/k+O7gOYq0HtqXQC9BE+xuyVg
         2RcCe3dwyqVH3sKHBh1CCEeIQdnjYN/BPpfk3lh4MOyfPD+hfIM2ZZnrtDHdD67g5Efy
         paJSixlx+iRy0yoLupbsTGT/fjgyUbTJ3q1u0UO/Q5wNCGzA7UOINLN/dchY1CimkZlv
         iGJHqSj6d37tB0QAw6VkRZgVVPqG8ZW5q7cscH8syko/vv3PdEangyGRBhBx9cyCMO8k
         kW9SU8ILchXXc1Y67ufBUUKdoUuCR5tLQIELIXkSFDCokIdbZRD7TJpHk+9TnqcxDwgw
         WKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781703868; x=1782308668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkGGkGXV+1YZVOqd6U7cg5LVTCuD/L4oMW+qufKkKlg=;
        b=CjyuwPdRsTSAwQp9bCLl4qMH2tK+QrKPtnsU4abnfTkswZRzCSt33YumkTCyZmX8tv
         WCM7Gqmp3gVVwJ1gY5eiU3RQEuJUUAgrjZA4p/r1Oqu+lo8tAOy3xZVoxFfElgt8ykX4
         h/DER3ZB0QeCBJv9PzWP2FP24zPGKS7hKJf0dmLFHJNl6OTgrex4KPSiFoA/8z/j58u3
         +jWX6zJsg7Tv3tzErzfe8Jxty9cgFvpC13SXWZ56ZQDvJ4iRk0WK1ljWOe+haZ+zs3UM
         Zn0EOdAswdoj6uxXh5XSRQQcGvIxwM5krFK5bC7NjQQprIqfaYVs+fSjMjg2Vh+b1tTJ
         axDg==
X-Forwarded-Encrypted: i=1; AFNElJ/sViqVjMLXXEEg7IjmIvtkCzXd1t/3JzLPfHSeaRLB1xHj58ZtzVOLLCFtsz9IoXKywwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+X0ElRZCIgvIVGKhiHtErLPO1oaGz3RkocL90YvCsP3dNOhm
	Chp69w9iJz2LHM6VYBvxN3e6gUZ/zNtobRn54/qQwWTqdmDb4JMPcGdvPljumHRIBSziCpmjh+M
	GEzeJRK4vteU1GuciQGZHUy4ZX+mNm6m5JkaqEF6TQv7Zpw5rbGRZSQ==
X-Gm-Gg: AfdE7clnTc4+0ABCaMzKOMYZSDm8cMxL2JDDxaA0C6XP2yChvxk8HImwWMrzhWUe2UB
	BN336BXUSKMd7yHhtBb70T+ytyaEAvvEMqFXbRXON2/g19dSgWU+z+6MgLxQVVwSKpKQ3zE40W2
	60pq9AuzKFW+F4JFLCptlAFFfF38g02/pARLs706SuTM0MnGGnfbaQ8BbBLyB5zWhF9RfGKMjg6
	3Yz7P5zCKS9vszBt88AD4pLVC8buxQ6GpNGiIfEtRUp9HvVDoJEdBlvSHXwrmJ+kxT3qFReYfPA
	tjnrQRgQ1Lj2W4zVAIcxSWXwGP3csgFePEWfTJEaui/v10yQb2vmOKY8WLTglu3MyrUlJnw3TEB
	/Im4Bb/z9hBjycjtw1q6xFME5W4w+GA3nYCsukylHgHyd0q+t3/rFj1wsKRrLjTNHn1cQFQjj6O
	rkSvTOgeWcO/gMx6GD
X-Received: by 2002:a05:6512:6716:b0:5ad:4bbf:3c03 with SMTP id 2adb3069b0e04-5ad4bbf3c8fmr427106e87.16.1781703867815;
        Wed, 17 Jun 2026 06:44:27 -0700 (PDT)
X-Received: by 2002:a05:6512:6716:b0:5ad:4bbf:3c03 with SMTP id 2adb3069b0e04-5ad4bbf3c8fmr427096e87.16.1781703867235;
        Wed, 17 Jun 2026 06:44:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1ae945sm4429397e87.62.2026.06.17.06.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:44:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Wed, 17 Jun 2026 15:44:24 +0200
Message-ID: <20260617134425.440091-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 9368a71336fe..c13b80fe3125 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2459,13 +2459,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
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

