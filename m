Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6F3BFACE
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892382; cv=none; b=lRIlqCqjzjVH3GL/gZw0K9tsZUQc16SAz2+IbX+R6eQIAGoL2giCeL4dMuPz1t/udlBCn/S8BkOMDPhB/kOOAJvJjob1HZZHu0J0GzgUTqY7pmv0VlG/1W1jzCZIfxhA1UFT5QtZBof3y49iZJ4YneSqnZf/PDTplZtSMusn6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892382; c=relaxed/simple;
	bh=PqVmucT/+U6UL39ZVNO8iSgump03Go9bnfbgSBn2Zlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CxTytwJkfMQh5nm0I8mKX92Mgb0hqmXF1r2ONndISMYvxVO5WfeSBD64h70bUVOipppIDK8NIkvBX/rCjt11EUm4DAjPXV2fZ1h5CmZ+JrHqKfE8FbCu6LADm66AvVPyfQDT+E5bKpRWV9/5NenQlmfsCzrtyp+uFhvyPDjYl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXNrM5lE; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXNrM5lE"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c96739a46acso131352a12.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782892381; x=1783497181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puBKmxakpyuhyti8JVghjO1VLPpzeh7Dz9u+N6AR8/o=;
        b=FXNrM5lEqXGSbVArrpOu7bpeeGaDiYGEXJCcww2gQfZ2KRipnItc9M+ZgY0rZL1DWJ
         epN1v1jkojQggTd5Q4rMQ5Fifph6EJtHoFqXQvPbfuYvbsTfIbqQ1y/ETst+iZgbymPj
         2BetxzmLxopGHyoynRXCap7MhyLzXxhkjHtTWNIik0XrvZZEJcIopk+layY1u9bN2TMh
         5+nio1H8mExstk8+jE5H/rPf+3gfJaAvrg4FQX3FQ3eN403MjJtrbWfEhBIr6PgKzuMJ
         z1IDsiv7SUo9GubsF7LctxkB5czjTj45fjzBqn/B7DnMGXVc5LdVZ1f5hjDvEMosJS7J
         X8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892381; x=1783497181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puBKmxakpyuhyti8JVghjO1VLPpzeh7Dz9u+N6AR8/o=;
        b=PzyYpM9wHRvEf0G7ExlpNkkTWlUFHO2IWPfZ3iOukIbCQpV9Viu05+qd9nrdFmTWj2
         Hz9IahebhvHtPqPTjYn2v4xM2SwHb6PyZkdS0xYVhWYovuBY5twxQnQs35zZzr63uVAW
         igDqeJ5hjIhj9w2OqYYW1+dVZiCylmz388uYwSo9YTjFdvg3pNcK3+DdsKdG44QicQZb
         fOpEAvFaM4JCbDubWU/ckwjgzq/iNPfG37XD2rjgFu9z/hv4sqstyTpm7m1BPSS+Bbiv
         PdicqxWPEuhaptyx4mobP776Ii5N3tgYPTCNiIFgpl0aRJr1s7B/7Fx68gX9N6RGJ/09
         TqrQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfQDHrvub5+fbB/uszQ2S6hvig8ndgvJA5bWLQ+hg+58Y14fMePQZGxsaw8VAc8M7QTaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdjeY5GUpy4n3kiEoycKRrYu+7teu4l+CMUCeE/Dg07KmvDch
	aYSUY1qgD1pgYbIOgrSLkUKn5PPv+lbWzrFfp8IgDb0lkiAxvfjXcwwIkAS0eWMeAJcMk2inoNB
	Tyw==
X-Gm-Gg: AfdE7clbHLlPUeDfVZoyYBOW3CqSE8cpkA/ebexdWI5WeKFjztxvfwvUOHcrrBSMXLB
	MML86sJIZiCwvpmy2xTztajQvC+54zEZBhhy0FtL+7h1oeP2vGN4+ONtbm8hd5Bec0CWSdfVjqb
	22swYziBh2UUXG5FOS3PoTmyvdhzxsFtvu4qBRnn14qoOUwyx9beGMVlUarasgJEwjlgTEVSi7d
	Xqnp8I/Y+nqiw30dePzpoCJYbYlAiK3NjwDBzsJ/UnUpqnJanscnzIQ/fZTJRnKhE6NuZ7H4voQ
	l0pcM7vCfqui94+vv+v6lomYxpUVUMBWpfa+sAxdH4cmgarb8yN5N+Dekp2BU2ZsPb7GHNl7k0b
	p2sba3A2mi+aIH3l6ZkRYBq1hvtrwJfcaMXPjGQVQK6Yu1SoPodgd8TGmPyfVDm1LsSYWc7M8bM
	utrDAJF3/KoYB5QS/3cm653iHnJEsqMTk=
X-Received: by 2002:a05:6a00:3d56:b0:845:e9e5:cdec with SMTP id d2e1a72fcca58-847c097e705mr532613b3a.62.1782892380950;
        Wed, 01 Jul 2026 00:53:00 -0700 (PDT)
Received: from wud.bbrouter ([2409:8a1e:9473:9f10:5de9:783b:c249:18c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff8f959sm3608232b3a.3.2026.07.01.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:53:00 -0700 (PDT)
From: "Dylan.Wu" <fredwudi0305@gmail.com>
To: anup@brainfault.org,
	palmer@dabbelt.com
Cc: atish.patra@linux.dev,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	zhouquan@iscas.ac.cn,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dylan.Wu" <fredwudi0305@gmail.com>
Subject: [PATCH] riscv: kvm: Skip preventive hfence.gvma for new G-stage mappings with Svvptc
Date: Wed,  1 Jul 2026 03:52:39 -0400
Message-Id: <20260701075239.95542-1-fredwudi0305@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Invalid->Valid G-stage leaf PTE updates, the flush in
kvm_riscv_gstage_set_pte() is preventive. When Svvptc is available, new
valid PTEs become visible to the page-table walker within a bounded
time, so an immediate hfence.gvma is unnecessary.

Skip gstage_tlb_flush() for that case. Permission-restricting updates
continue to use the existing flush path.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
---
 arch/riscv/kvm/gstage.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index c4c3b7956..7b805112d 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <linux/pgtable.h>
 #include <asm/kvm_gstage.h>
+#include <asm/cpufeature.h>
+#include <asm/hwcap.h>
 
 #ifdef CONFIG_64BIT
 unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 3;
@@ -171,8 +173,11 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 	}
 
 	if (pte_val(*ptep) != pte_val(map->pte)) {
+		bool was_invalid = !pte_val(*ptep);
 		set_pte(ptep, map->pte);
-		if (gstage_pte_leaf(ptep))
+		if (gstage_pte_leaf(ptep) &&
+		    !(was_invalid &&
+		      riscv_has_extension_unlikely(RISCV_ISA_EXT_SVVPTC)))
 			gstage_tlb_flush(gstage, current_level, map->addr);
 	}
 
-- 
2.34.1

