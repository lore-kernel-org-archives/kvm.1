Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17344E80D1
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610412; cv=none; b=quliaQaRXton518to3Y3LCCfqo7P5xTcsm/TtDusNXJ716MhsV3gtaeig0qNzJ4IbBIVpaINhXZRNnLVPbGIl+ISRd3TUe7hagDFr6QkfMXM3q5VpF1xu5/+gqX5Wa3ywQjT6EX3XuPzNRYgS7TZA0MoPRkM11/NaM9LcNzb+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610412; c=relaxed/simple;
	bh=tWFx7aDNJvGxi9DWbSYvH///da1frNHlvHoMsxVjCPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cn2Y/qTiz1Y64HFu1WdKnM8ec/4kV3Laru/2m326ftcfuiFXDUBgMMd+15XNjOqFeC0EjCsbvH3cL6DGqqIqW55Avo8VTCOxLRIp8tlx8DEpbky9EJpIJ+6c6lzL9uQq/b6mIRgF5EpntrEOQHGHy3hjWavdJ4n/B5A94EiVVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VhusoiYL; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VhusoiYL"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db3734d06dso31984905ad.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790610410; x=1791215210; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=taY2XbcgHMoS37yddUCoy3Y7+YiSTg0c+FIA7gSyzbU=;
        b=VhusoiYL16GBCDdpPy94c/dPLzVHK13svU6mAP0Kc66NzUrCmblgIiD/mHzFx1F2/4
         66I5Mvk9v9PE+w+rsprcWoQhpQanZ1LnzpZCelxIph/mX4fRSQs1sd+l/zjMbk0uSFR6
         3Iohk41sjTnbR0FFCtT9U81KJYFkKOu0iU+HJQhneKE6eECqMutfqhgKqi7zSi0ZNW1M
         dlGR9EYXxwCz79lpfur1dBHxI2GuF48sedB/7x+HUgxC2Ow0PZX956JoxwNSnYV5xunk
         MsGb05XspD+mtRUPkH0VMNXOr8h2+MblgoTkju/6MY4m9Q0Q5TH+wrzzbU0EOdL6L3jH
         DxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610410; x=1791215210;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=taY2XbcgHMoS37yddUCoy3Y7+YiSTg0c+FIA7gSyzbU=;
        b=E7r3PaQXpTCPz2z9vEEeLMAZinsC5fv/+lhSIt5YspHZIBRgMDr43KyC3A4UFgOqDY
         n0FAnE8qfJ3PUzsK1uIfJ4xFygouNWEY05PQLYkpjk9RLPSbI8fiyrhqTctXzqL4nbNr
         dVfWoX2wSfl3SuMu+HSOgDHYInYH8uhNQXY54m/4iHHW4+2Dn4OAipmQK1+388P4AK+8
         uFo19ePbtFxvHIhgU04ivs3anJtm4zRmSyfs9IxN+KbGMtRaVy0+FuNGjEh44dS4LhHF
         ls+C1CZF5ovjW3zyz/AHwKownOP5EH/FYzjDO1N6HcewE4l+VgSxOAJ/dtZRsRyaA0so
         xS4A==
X-Gm-Message-State: AFq9FYL3MbYWy3PeZBS4qUSZ/pTMirw1eZAw/qbhoEN9EeMCwWc4UroF
	UotplD0BDhLMD6vrPtUJpJfKhcpifSNDZbKhhIXgAWgnIMrg3V8DdbOIej80ljJjYHxqU9zZVjV
	werjB7w==
X-Received: from plov13.prod.google.com ([2002:a17:902:8d8d:b0:2df:806f:7687])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c40b:b0:2df:84e0:902f
 with SMTP id d9443c01a7336-2df84e098a5mr96176425ad.9.1790610409666; Mon, 28
 Sep 2026 08:46:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 28 Sep 2026 08:46:44 -0700
In-Reply-To: <20260928154644.2559454-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928154644.2559454-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928154644.2559454-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: SEV: Do cache maintenance on the source VM *before*
 clearing SEV state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly flush caches after intra-host migration before clearing "SEV
active" on the source VM, as doing cache maintenance afterwards creates a
tiny window where memory reclaim could return memory to the host without
performing a cache flush, e.g. as pointed out by Sashiko:

  CPU1 in sev_migrate_from():
    src->active = false;

  CPU2 running concurrent unmap:
    Since active is false, the automatic cache flush in
    sev_guest_memory_reclaimed is skipped.
    The host frees and reallocates the page.

  CPU1 in sev_migrate_from():
    sev_writeback_caches(src_kvm);
    Executes a hardware cache flush (wbnoinvd), which writes the guest's old
    dirty ciphertext over the new page owner's data.

Fixes: 93de2a6a4b91 ("KVM: SEV: Do cache maintenance on the source VM during intra-host migration")
Cc: stable@vger.kernel.org
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260923165304.1662E1F000FF@smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d3a2e6a51efc..0c1ebb16cec6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2045,6 +2045,13 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	struct kvm_sev_info *mirror;
 	unsigned long i;
 
+	/*
+	 * Do cache maintenance on the source VM *before* clearing "SEV active",
+	 * as memory reclaim flows won't trigger cache maintenance on the VM
+	 * once it's no longer an SEV VM.
+	 */
+	sev_writeback_caches(src_kvm);
+
 	dst->active = true;
 	dst->asid = src->asid;
 	dst->handle = src->handle;
@@ -2058,12 +2065,6 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	src->pages_locked = 0;
 	src->es_active = false;
 
-	/*
-	 * Do cache maintenance on the source VM as it is no longer an SEV VM,
-	 * i.e. memory reclaim flows won't trigger cache maintenance on the VM.
-	 */
-	sev_writeback_caches(src_kvm);
-
 	list_cut_before(&dst->regions_list, &src->regions_list, &src->regions_list);
 
 	mutex_lock(&sev_mirror_lock);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

