Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B47C3438A2
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535130; cv=none; b=k0Y9x9ii7dXMXhN7t4dzVFdFM1F6igPePmgvwlV92b6N9wa47kpG2fEeQEhZM0Hz5hdiOqb8+oxhWzJA8u95hjLNJqBgyPHEd61PUE7aZrdEQoebVCkdQ1Jbc+y8rc5XhbiRAu5QyD8TSnb5K9aWE0uRUt+RjvhCo+4O+ARYBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535130; c=relaxed/simple;
	bh=6QNOkdhCbS1zSrynkcrf4iXWNtn7FlSJMHDEznG+FJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwNXLQMf7nCpnvN4dK0Hg1Sl9w2VN+dieUDVF85qetb/N4GUgh4E7v08RfJNuIBMtpdrXGfpltVu81cuPTgo/FqKSfrABFWmonUXyMANW73wsclLZc2H/NvVo37OIBsxWoi1fEQK2yvtr8PrcN0GNODFbjgeGgvf0Ls8JO2yKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kWC74xpj; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kWC74xpj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783535126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmUXCwO/YG7npJOqJHZit2JMx0cXqLbuiAg6odak188=;
	b=kWC74xpjlZoEPmVFUoX6zCsOTcOlWxxQQqHqJGaQ0mOnBE0pOvULzvRu8jcbVBZuJ/km5K
	+e7ZXlO+Q4gHo1ctPKss3tQtMaHPmLJ9dA9j1As62TrPIqcY+S2Noy5zcRaxxzNS2/kvqx
	ZCEh9vwJVe85VGtlo1A8mScQ7OL0fTI=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: kvm@vger.kernel.org
Cc: kvmarm@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH kvmtool v2 1/4] Initialize the return value in kvm__for_each_mem_bank()
Date: Wed,  8 Jul 2026 19:25:07 +0100
Message-Id: <20260708182510.2181857-2-fuad.tabba@linux.dev>
In-Reply-To: <20260708182510.2181857-1-fuad.tabba@linux.dev>
References: <20260708182510.2181857-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If none of the bank types match, the function would return an
uninitialized value.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 kvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kvm.c b/kvm.c
index 7a52c6a..95ccfcb 100644
--- a/kvm.c
+++ b/kvm.c
@@ -383,14 +383,15 @@ u64 host_to_guest_flat(struct kvm *kvm, void *ptr)
  * their type.
  *
  * If one call to @fun returns a non-zero value, stop iterating and return the
- * value. Otherwise, return zero.
+ * value. If none of the bank types match, return -ENODEV. Otherwise, return
+ * zero.
  */
 int kvm__for_each_mem_bank(struct kvm *kvm, enum kvm_mem_type type,
 			   int (*fun)(struct kvm *kvm, struct kvm_mem_bank *bank, void *data),
 			   void *data)
 {
-	int ret;
 	struct kvm_mem_bank *bank;
+	int ret = -ENODEV;
 
 	list_for_each_entry(bank, &kvm->mem_banks, list) {
 		if (type != KVM_MEM_TYPE_ALL && !(bank->type & type))
-- 
2.39.5

