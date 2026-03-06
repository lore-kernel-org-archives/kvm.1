Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0C3793B5;
	Fri,  6 Mar 2026 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792195; cv=none; b=SpYe8WTXt7hI8CV20r0JFr8WmQNUINzkPrblWY/wpoGiQ8sZlUdgAkbJj29zFa8YCGKYiN2XA2ngMrptAqWNjdUA8HNRWCihH3+ZmBeBgvOGkBUN9GR0SA3CNAMPHiXHlmH2zPpoM++rBW6wpploSVCKKVvQ/HYQ0Q6wLJdRw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792195; c=relaxed/simple;
	bh=ltugaujY6fYQ/bBQe0co3tDjQ1T6cgZ91J0YQTonPoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haQVP7HQZfUJZzOHvwHP4tnnZ48/4gPUHkv7+TA4uWj4EyMRj9bzWHwL2ajVTcLpnTfRVwYB1daJm9UCM5muqRaDWiupfaUY3zcvDCrIYIAixmLInxaDPxhPsyj1tLVOJc2u4Rc1LlvQtqkarCwT/8b8kXVbzxecIrnr2h7npIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfMFKTIS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfMFKTIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D250C4CEF7;
	Fri,  6 Mar 2026 10:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772792194;
	bh=ltugaujY6fYQ/bBQe0co3tDjQ1T6cgZ91J0YQTonPoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfMFKTISWy6XmE2PIb9BpEGaudJtZSFT3m04+Td9Q5T7Gtl5odhVnpSKvAaWekMq5
	 YHbT6av2ZV+y2SZEABL2S1pqe2js5staTWbWCHUQ4B7m9ij0IMohuU27s1qBBdgbPv
	 /xvSBtXv6lHzyCRnpv+esgazI7+0+/ywXmzcHmgMjvA3sRdXUm2hLsggmuK9Ra3vRW
	 01wq2YBeDQDBfoijNG5nKwFgIVYW1Tdu+trdWwEzNjdxxjyrd/WSFkp0EGvSNT+xvh
	 NuY+Mjb/VVLtIe/Vr8TymfRbCZjTQbk4VUHJmhMxLi8b0TxsdAUHDe6yKXN4FWInAE
	 fumJUEFoLAn4w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v1 4/4] KVM: PPC: remove hugetlb.h inclusion
Date: Fri,  6 Mar 2026 11:16:00 +0100
Message-ID: <20260306101600.57355-5-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306101600.57355-1-david@kernel.org>
References: <20260306101600.57355-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
to mm.h.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/powerpc/kvm/book3s_hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 08e5816fdd61..61dbeea317f3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -36,7 +36,6 @@
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
-#include <linux/hugetlb.h>
 #include <linux/kvm_irqfd.h>
 #include <linux/irqbypass.h>
 #include <linux/module.h>
-- 
2.43.0

