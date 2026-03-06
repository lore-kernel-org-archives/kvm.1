Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577A37BE7C;
	Fri,  6 Mar 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792193; cv=none; b=T9h/D6LEonQQLwwoBaDTgWZMfE78eNzJnK2e8ouOpUB/NrWlFSL37q5Joyo0jnqZ9YYlKJl9WLsUoNd6AKhMspkwZml8XEB8Zgu4nQYDovE1AJzzNrIJS8gOi/zpb9WoWrvM6QD8gVfEndOV3a3vXdWzG7QE1BEU3CSdOD9p9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792193; c=relaxed/simple;
	bh=k5FQ3POVWHUqSFCK1KHjIrKMQkLSCam/RT4g8330CaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/0yB3vZMrVCYjk+jS7tuShUhC0pzsbsRSTJ8PA/wDvTFhoohfK/OeiHO8U7i/zPxGqhAszatyKauaD7k0LUh//4TmeXLzAm3SkojPZLc5BnkR/EGlqS+JJ2+myZuS01utTR7Q39zQIt4UxFt6D+itvXKj60tUaXXEtdBccF0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMh7g+zY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMh7g+zY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB1BC19422;
	Fri,  6 Mar 2026 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772792192;
	bh=k5FQ3POVWHUqSFCK1KHjIrKMQkLSCam/RT4g8330CaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMh7g+zYXegSicI9M1aLSZ+o/u9Faw6vtFXpS+dhIFChWaHhnesz2CqTrWf5lZ1YX
	 PwR/89DOY0KxCfaDF+zvV/j0Ch3nBLN4zXZ99O5x+zsLJnKtg+Jp/8d0ZrzcYbo67E
	 hJ4fiZkHg6cip8UbajFYj19bxe1E8BxOFId9YL/FGpdsypVTI0uZCX4EeT1GlBw/ab
	 v6QBUypGeW3DremKETuRvO9dxgJz/QXm1sCkZZIosBs97NVkjiLD8T1uFOzHSu9wWz
	 /ZloImQknfKb+rfKqLT+2ao8Mf7tlJQPkn+MKqx5VK5iK0Xrx6O7k0ZQZPwfkpqZws
	 H8SRiS+Qx0qUg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v1 3/4] KVM: remove hugetlb.h inclusion
Date: Fri,  6 Mar 2026 11:15:59 +0100
Message-ID: <20260306101600.57355-4-david@kernel.org>
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
 virt/kvm/kvm_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 22f8a672e1fd..58059648b881 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -41,7 +41,6 @@
 #include <linux/spinlock.h>
 #include <linux/compat.h>
 #include <linux/srcu.h>
-#include <linux/hugetlb.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/bsearch.h>
-- 
2.43.0

