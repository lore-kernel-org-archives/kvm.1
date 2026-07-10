Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC13D6692
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721221; cv=none; b=Rd/f1CfFiSTrVZqFQDOAPqX/EHuT6waz3JkV5XkaKM2xJuPEJDvpEaxAaSCrUP9P/FuaIT63Mzyjoe2GDza2uILyHkdsyI4/TyAKlpOrLIjhLEcFnK7L1MO2zGysHw92/LB0h72mBVU9idyLFXljs6JT1PpUPocF+nz7eN7oqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721221; c=relaxed/simple;
	bh=shDmtApnZvdyo7L5TZAFGjMrm9vqx2VXSgijpuIkVbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tMhJV6oPq5fcusAU7pPZ4/6+yHUlQl1YgzLDFDFIymW55LFRRmu1XYRSkgfFjpiONn9TI/CoJ1TR22zOzCv/eu9L4HlmtQJK+6je9Et50uN3pdvl7pUpqEtN3md+YsNwoCCUIGeoBAVsZeUlToVNizNgZqSAxdePrOsQ+VWHoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkVrxyz9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkVrxyz9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7f385887bso27422875ad.0
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783721215; x=1784326015; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tQns3HevZIzRhw7H0Nuhca8MxJp9vTEMOhRtrWCAyX8=;
        b=GkVrxyz9ajBJh5WbyHLI/BScIE/Vk/hATQ6746H/ZoQxtfn4057+EiHRUHQNXksPXS
         lVGYGF3QwSu/Kj/JkXHWqdFy2yCnhG6gdFxGDgjFPqAQQOCf8+GOHyWOy5JOrOiBL3zN
         fM+uOcrlpjr5mihIJeu4eh5LomoGmzHMdYu/lljujSXfhOFdq6ARgAipg+wEnCStAfFo
         MBw80LUK409kK4DvY7NZrmZf2raxdK9oDRvRBJ1P/sXV0MvAuv0pTGty7eWqxHxBFmKc
         HpVJ34YCf/YqXG4Tw8QMh9LpDZBqmz00HlDcOFW6/Rdz528PxOTVyCuMg9D9kjHkw/tm
         wEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721215; x=1784326015;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQns3HevZIzRhw7H0Nuhca8MxJp9vTEMOhRtrWCAyX8=;
        b=sISuL106AXdy/vQaaLIYYLrMqM0MlX7mmJjqf2TRNgfSx79FfN1o1c/2GkbiObTwZb
         mcSoJUCINKS6zfeumqRgFfZzVVhykmYbs2neGyxe/sKrr7efnphAY3b254IiRgegYyYd
         Wjk4/OEB/fw0Bra+kG6TGwAXLMTxdC3VKildbnf2bsWWkNbQ3e5Bpght5en6WQaEDVnU
         TXX+B6gQpdP+plH151MiZXLtKk1la/Dey4og1KIC5sosTR7v/vD8Qfxb/fwqWj0zGzOv
         RWaD0BloFkln+otyhGxLQtagy2xLfIrxzT6P684o9jkE/x3mX2TM6RhbHVxTfVS8/wp2
         VsLg==
X-Forwarded-Encrypted: i=1; AHgh+RqZU3sRPTs0sem66HzpsrSicglDVYUcazU8j97TfBQfKwLt1oC5iH0rbQA6th0BBEOH6fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUuM3UAmdf16vHp2mmkoJ9cuhKMYqUSnjZJjVT6p5MzvxCMtdX
	SWtwM9SK3QTMew/75xiz0MxuPIq/g8kE7xjcmRwuLGllj9dqk0wHmPAhy/wJuhKWeOt3d+UhZFM
	azCgUVzYa
X-Received: from plhq14.prod.google.com ([2002:a17:903:11ce:b0:2ca:d246:c7c8])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:110f:b0:2cc:fa08:eebc
 with SMTP id d9443c01a7336-2ce9e7a544cmr8374465ad.1.1783721214508; Fri, 10
 Jul 2026 15:06:54 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:06:50 +0000
In-Reply-To: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783721208; l=1853;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=ULyYN7S4rWudzktl97NB9xV0EBoQIE8YAYNFU9RV/IU=; b=faKEKwlLwFC21rtzYiGCpQGJmOlryRDxBoYYhFyHp8njegao69icprtRlf8nh38PY+sZzwK2l
 DR3dNnTn1LyAkg2ZZPsDGJ0KklKobjPJMUPaj986jiAhVElN5+cUsJj
X-Mailer: b4 0.14.3
Message-ID: <20260710-igb_v3_b4-v4-6-56e7e2576cc1@google.com>
Subject: [PATCH v4 6/9] vfio: selftests: igb: Disable PCIe completion timeout retries
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

The mix_and_match test intentionally submits TX descriptors with an
unmapped source IOVA so that the DMA read fails.  By default the 82576
re-sends the request after a PCIe completion timeout (datasheet section
8.6.1, GCR.Completion_Timeout_Resend, bit 16, initial value 1b).  On
real hardware this turns a single fault into a stream of retried reads,
keeping PCIe AER and IOMMU error handling busy and interfering with
reset recovery.

Clear GCR.Completion_Timeout_Resend during device initialization so a
failed read fails once and stays failed.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 172c95cea3c8..ac116834bbf6 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -230,6 +230,18 @@ static void igb_init(struct vfio_pci_device *device)
 		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
 	}
 
+	/*
+	 * Disable DMA re-send on PCIe completion timeout (82576 datasheet
+	 * section 8.6.1, GCR.Completion_Timeout_Resend, bit 16).  The
+	 * mix_and_match test intentionally submits descriptors targeting
+	 * unmapped IOVAs; with the default (set) value, the device keeps
+	 * retrying the failed read indefinitely, which keeps PCIe AER and
+	 * IOMMU error handling busy and interferes with reset recovery.
+	 */
+	ctrl = igb_read32(igb, E1000_GCR);
+	ctrl &= ~E1000_GCR_CMPL_TMOUT_RESEND;
+	igb_write32(igb, E1000_GCR, ctrl);
+
 	/* Configure PHY internal loopback for testing. */
 	igb_setup_loopback(igb);
 

-- 
2.55.0.795.g602f6c329a-goog

