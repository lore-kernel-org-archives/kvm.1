Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29933CEA5
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092469; cv=none; b=XhYrGnEivqDKqp3+zyZKumEl3WDnjTD1UTj/Nl33nA8dAmuH087OUMfvfGODWT9BCE4UuTNzdk6ORNW28cEajtn/5iTiWBvAezSNUiSiBGPRKXpTXf11dwBhidkVOrsqD1M8oZ+qRPE9tdcDPBp7WOsWz0mDBxT1dKf4U/J2EU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092469; c=relaxed/simple;
	bh=iN8fKR5wtoJaEfAlwqO2ijAfhLGA/7arzUP99yGxMUU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T7T6mLdZ9sXuVOYWweTg42z+osHcW+lXmOFeeisUu7Zz7FbrsFf1sma6CRsNN6UwqnJ1nYv04hiqTw4f5bC3CUr9ogrnuOcpwPNZtuDB9ALHJry2nxeIvDFCdGrjzrhT5+NB7Dn8Mged9+sMSwDZQjtmceXMj/rlo6aYG1ncYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jm4gv2BC; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jm4gv2BC"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so247249a12.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787092467; x=1787697267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7xwBYfLUKLPOpkt5/GQYGFfBN9yGyR+1iH1KFRGKS2I=;
        b=jm4gv2BCi4vWyVuGMePHoCiccIzWnYsajHCfSpgUmx0Uz6a2/lgORcrqcaUGmF6AzB
         wyKGuQbwuUKeSWQszSQsYY8qGpIyOBlcbumnuGdUB7eitAj+1ytNMAak5dRtQ3N1o0Xw
         cLySbYwrmSHFSd42iG3FAH8/k1D209+pRisKX1YRi7SVJWFhQINamlysCzfuYHEf+InA
         wDTrCgm9RxW7Sx5d52alsQRalzUV0NEOkk89AOTRFq1VLIcekg/RRtMOM2BWvVXjV6nm
         x8oYDXSqpdj57eU3c1iv2HOG13g0pwiGYczm0WITPykWBsl5evUz3/vusCvYxExbhwan
         DB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787092467; x=1787697267;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xwBYfLUKLPOpkt5/GQYGFfBN9yGyR+1iH1KFRGKS2I=;
        b=GuO3dHq31oPcNEFREnbplnWx1MExDVOfPvwluW8/JDU1K/DDIHE09mgj0zPboym0/o
         BehFbJoNvSorCv7zxYxgMhvL3PH1r0dsl7tlZaAhsZ0395s4sFfFqQ5yySE/7rSaWVGx
         wxsN5aTCryZGHYiRRwOZHWF+Dume3Tkjiohf2Mj0MmEM/YBLKt3ng5twl5H6HgWzuH7F
         bWmROJYVxSO5w6ZnxjBIIhsUYLcDguoK4Q0ZOhOgX/k7ucBsRqV9Zhkk10B0P5WeqVPi
         xgdgqOVvS871bFsm76rxqh1OuwE6LaPFWENREegzBY0E2AcMsjpSlpPyWqQRZhRmzBCQ
         +8ZQ==
X-Gm-Message-State: AOJu0YzHmomvas7OQi5rbbSMpKXHG/kfu2mTOQ6q+HQmzvJ6yTiz2zFN
	pkpG9Haws8cltvklJAW9z6iWkn0rJTMvdcalRVKrhCW3Imk9nkK8e4jlvb6f+UI5xtgpuhStSzQ
	muJhuy/yHzrupX0iXKwoQHyvRb8iDEWcV/1mp6RnsiU7hPnWg/bBgd/CON4W0Os6MVi4ZRDvD7e
	jvTugAOY/aUE44UQFVWhETXWkO7cZJcQLYUTgaQyZqi8vBdWxm7NEesSohJJk=
X-Received: from pgbdo4.prod.google.com ([2002:a05:6a02:e84:b0:c8a:3e7c:1e5d])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a10f:b0:3cc:51ff:c2e7 with SMTP id adf61e73a8af0-3cd0193b93cmr466456637.10.1787092466770;
 Tue, 18 Aug 2026 15:34:26 -0700 (PDT)
Date: Tue, 18 Aug 2026 15:34:22 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260818223422.367803-1-jingzhangos@google.com>
Subject: [PATCH] KVM: arm64: vgic-its: Fix O(C*I) loop in vgic_its_free_collection_list
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

When destroying the vgic-its collection list,
vgic_its_free_collection_list() iterates over every collection and for
each, calls vgic_its_free_collection(). This function walks every
Interrupt Translation Entry (ITE) across all devices via
for_each_lpi_its() to nullify the collection pointer.

A guest can allocate up to 65536 collections and hundreds of thousands
of ITEs. By clearing GITS_CTLR.Enable and writing Valid=0 to
GITS_BASER1, the guest can trigger this teardown path from a single MMIO
exit. The resulting O(Collections * ITEs) nested loop executes billions
of iterations without a single cond_resched(). This pins a physical CPU
and stalls RCU grace periods for seconds or minutes on PREEMPT_NONE
kernels.

Fix this by replacing the O(Collections * ITEs) teardown with an
O(Collections + ITEs) pass. Since the entire collection list is being
freed, we can safely bulk-clear the collection pointers from all ITEs in
a single pass, and then free all the collections in a second pass.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/kvm/vgic/vgic-its.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 36ab3e4929154..a8e819fe97898 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1133,9 +1133,21 @@ static void vgic_its_free_device_list(struct kvm *kvm, struct vgic_its *its)
 static void vgic_its_free_collection_list(struct kvm *kvm, struct vgic_its *its)
 {
 	struct its_collection *cur, *temp;
+	struct its_device *device;
+	struct its_ite *ite;
 
-	list_for_each_entry_safe(cur, temp, &its->collection_list, coll_list)
-		vgic_its_free_collection(its, cur->collection_id);
+	/*
+	 * Bulk-clear the collection pointers for all ITEs.
+	 * This transforms the teardown complexity from O(Collections * ITEs)
+	 * to O(Collections + ITEs), avoiding guest-triggered host RCU stalls.
+	 */
+	for_each_lpi_its(device, ite, its)
+		ite->collection = NULL;
+
+	list_for_each_entry_safe(cur, temp, &its->collection_list, coll_list) {
+		list_del(&cur->coll_list);
+		kfree(cur);
+	}
 }
 
 /* Must be called with its_lock mutex held */
-- 
2.55.0.737.g08866a6d13-goog

