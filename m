Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447663CF210
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721218; cv=none; b=rK/EYDrotxD+VUxSxrbcwqNy98fKLmPrLtzw+b9dziEOWx0pih9JCMpeYr3WG1gmS20AjNGYp8dq/I1aEg/M0j0ogoig11d4dwUtdxTrdoQ6F2XgN4rwKcQ0L8Jn6GpvrjuDdKmdbqi6fOdJg1dqg4OGZvRPe5L10F5DhoKszcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721218; c=relaxed/simple;
	bh=NagcJVpSawnrGB5aTa7laT6+AHk/7WT/b5cOVYFNLMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V/y9XZlfas4WngEyV3YD5ls6dj3GqCn/6wkPOKca5c4auuCb6I4XHaCEq58Jr27iVEgzB6sC+e7Gkum9fzZssGBbwINe+sQ1Y9FTwyJvRdJsbagvp+wHWztaHKCScfXjoNRyavoCy6UCjHhcWYB0PbkR/zAwx+LFqS5yNq9+C20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSa7kks2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSa7kks2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca5d2474c7so30728345ad.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783721213; x=1784326013; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGZ8xblzsGAm9fHuvl78rZ7mmqIkbGhLb4jrriYJ9GM=;
        b=hSa7kks20OGMwc8jFuf1HMCBceTsS1TIo8NzC0JdCuAKLqhT/PPWs7A4vSOoPivfv0
         oySp4eRlKBVkKqfD6jpXa0KtjnswShPzGAK5vs/E09yaQi6ZFxVHcgYBlqn0QCQB58ZX
         dQz4rV3YWe6Do2ERi6w213K5awV2Z17qXx5rvs9c9lXGpv8oj1xZHQCWkm0B4yXTAEdS
         yMyI3P+mxdFcwtnuydbXQYl033dBWiQ9Mxn+25P5Xi/ZeSNxqQ8qPc/B64Luidm51sBO
         oj3DPdA/9w3NC+C4WL6qh4YLa8KhgIXq3AqctkzAhS4j5jO+QVznebe2NPcJfSw8I3AH
         OuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721213; x=1784326013;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGZ8xblzsGAm9fHuvl78rZ7mmqIkbGhLb4jrriYJ9GM=;
        b=Dvh4j7kl0k52YkbNtyrH9UQ0adLdXV/7LJrV1ZTZTJz/KMnc+dPJpsV2sZcy/ApVj7
         mwtgVv3ubSU29uWGJ/IiYjZK75huYoX+lffFc+kmiatRJukVwQ+OcGG4LJNgOv/fidrm
         vlT3fqM+JJiFO6QELKzoK3vJWZqfpzZo/guWGSCoUktWsUEOYnzZRft1tWloWU+0mInW
         llstoP3h/ietzNk3pwQgaRG08Tsu/h12yp+BZqmICN0en77+Y9x4sP7d5rmOzXbZeyNq
         l9K8g+LUvD+y4kYSqquymD/MPRir4fET2Nyey3nWQEydcNfxaW+X++jAW6/8vd34/zBB
         l6lA==
X-Forwarded-Encrypted: i=1; AHgh+RovV2YYCEqGQwoXVCY+o6MRAW2f5o1cpTz5n9c5fzg3WFXuXfDRZBg3XlUAnj8+8EAdAqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7NsXeKalYy9zIp6bKw1qqp0ZbLLkMp19OE5E2Cc981Yfh9nq
	1lCG879XgSqN2HMXW/ERznBW5AR25eRWSZ/yG/hMr65eEFX24brKSyCKUKAYfZBlYtkJzIN73Ux
	yuurYLbqh
X-Received: from plnm6.prod.google.com ([2002:a17:902:fda6:b0:2ca:b48c:5a92])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a0c:b0:2c9:e5ff:995d
 with SMTP id d9443c01a7336-2ce9ec0f09emr9029395ad.31.1783721212677; Fri, 10
 Jul 2026 15:06:52 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:06:48 +0000
In-Reply-To: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783721208; l=4613;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=nNNDGNJyFJDlOeB1he63eGYVs6CuWCKpVYovsf0zL60=; b=9R3nJNBsbirCZ4QZxsSBHZXAQa1UGt/eBuSwkrAzHrxhD1LsIhNtNL6Oz0rvTVXhQMgTtF6bE
 qni9q3JbcRjASVb9OtYiaREbOyexj4xDl8NTVD3+usBrkhWP0mwLmOR
X-Mailer: b4 0.14.3
Message-ID: <20260710-igb_v3_b4-v4-4-56e7e2576cc1@google.com>
Subject: [PATCH v4 4/9] vfio: selftests: igb: Program MSI-X interrupt routing
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

The submitted driver writes only GPIE.EIAME (with a register value of
0x10, which is actually GPIE.Multiple_MSIX, bit 4) and clears EICR by
reading it.  On QEMU this works because the emulated loopback path is
synchronous and EICR is implemented as read-to-clear unconditionally.
Real 82576 hardware needs the full MSI-X programming sequence.

Per 82576 datasheet section 7.3.2.11 Table 7-47, MSI-X mode requires:

  GPIE.Multiple_MSIX (bit 4): route causes through IVAR.
  GPIE.EIAME (bit 30): apply EIAM on MSI-X assertion.  Without EIAME,
    section 7.3.2.11 specifies EIAM only takes effect on EICR
    read/write, which is not the path used here.

Configure auto-clear and auto-mask for vector 0:

  EIAC (section 8.8.5): auto-clear of EICR cause bit on MSI-X assertion.
  EIAM (section 8.8.6): with EIAME set, auto-mask of EIMS on MSI-X
    assertion.  This guarantees one interrupt per memcpy batch and
    prevents repeat delivery if the cause re-asserts before EIMS is
    restored.

Replace the read-to-clear of EICR with write-to-clear.  Section 8.8.5
states "If any bits are set in EIAC, the EICR register should not be
read", and section 7.3.4.3 cautions against read-to-clear in MSI-X
mode in general.  Write-to-clear (section 7.3.4.2) is unconditional.

Replace the magic '1' values written to EIMS/EIMC with the standard
E1000_EICR_RX_QUEUE0 macro.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 40 ++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 033997ad45e0..cd51a72b0e7f 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -296,14 +296,35 @@ static void igb_init(struct vfio_pci_device *device)
 	/* Enable MSI-X with 1 vector for the test */
 	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
 
-	/* Enable auto-masking of interrupts to avoid storms without a real ISR */
-	igb_write32(igb, E1000_GPIE, E1000_GPIE_EIAME | E1000_GPIE_MSIX_MODE);
+	/*
+	 * Program MSI-X interrupt routing per 82576 datasheet:
+	 *
+	 * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4) to
+	 * route interrupt causes through IVAR mapping, and EIAME (bit 30)
+	 * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
+	 * applies on EICR read/write).
+	 *
+	 * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
+	 * Without auto-clear the cause stays set after delivery and the
+	 * test can see spurious interrupts on the next memcpy batch.
+	 *
+	 * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
+	 * MSI-X assertion (effective because EIAME is set), so a single
+	 * interrupt is delivered per memcpy batch even if the cause
+	 * re-asserts before software re-enables the mask.
+	 *
+	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
+	 * cause 0 to MSI-X vector 0 and mark the entry valid.
+	 */
+	igb_write32(igb, E1000_GPIE, E1000_GPIE_MSIX_MODE | E1000_GPIE_EIAME);
+	igb_write32(igb, E1000_EIAC, E1000_EICR_RX_QUEUE0);
+	igb_write32(igb, E1000_EIAM, E1000_EICR_RX_QUEUE0);
 
 	/* Map vector 0 to interrupt cause 0 and mark it valid */
 	igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);
 
 	/* Enable interrupts on vector 0 */
-	igb_write32(igb, E1000_EIMS, 1);
+	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
 
 	/* Initialize driver state and capability limits */
 	igb->tx_tail = 0;
@@ -326,17 +347,24 @@ static void igb_remove(struct vfio_pci_device *device)
 
 static void igb_irq_disable(struct igb *igb)
 {
-	igb_write32(igb, E1000_EIMC, 1);
+	igb_write32(igb, E1000_EIMC, E1000_EICR_RX_QUEUE0);
 }
 
 static void igb_irq_enable(struct igb *igb)
 {
-	igb_write32(igb, E1000_EIMS, 1);
+	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
 }
 
 static void igb_irq_clear(struct igb *igb)
 {
-	igb_read32(igb, E1000_EICR);
+	/*
+	 * Use write-to-clear (datasheet 7.3.4.2).  In MSI-X mode with EIAC
+	 * programmed, section 8.8.5 explicitly states "If any bits are set
+	 * in EIAC, the EICR register should not be read", which rules out
+	 * the read-to-clear path in 7.3.4.3.  Bits not in EIAC are still
+	 * cleared by writing 1.
+	 */
+	igb_write32(igb, E1000_EICR, 0xFFFFFFFF);
 }
 
 static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,

-- 
2.55.0.795.g602f6c329a-goog

