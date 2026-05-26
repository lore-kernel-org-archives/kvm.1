Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288F3E8323
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839707; cv=none; b=HWVjSgJFVqldr1+ikG3XIgqNVLdIUfjkNByaEGINLvGP5EgABa73WqMRA8OWGfKUZ/UwmoaMl1+n5Zop7/IPDXpoLLtesrOCAr5xuS1Yk6+m/fI09QZcLWFB/kUGLGvHiNeXbALZVdxIY0VzVgahmdsnLZIfUn2qjU+VwqYiP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839707; c=relaxed/simple;
	bh=CkH0Vzpqcgvxa7Y2LQJUZJmUrJFwjbVNSoXMV7tcqZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XGUBnn9808NPrlI3ZXq2Puzb8ff5HfhZrTyUaPfBn8APrJFW2Gqfm0JeQNlhk7ggMjoFu7NHqh+4doGFt6PnRu/iY9TDCqU0qjIsFWTBVAm5fpMxfJZdSrl6llDZSrOR9uH/t+GLP58pDxjik/djBXpgxRM8RGzp3KnzxYyfbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHms+Axk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHms+Axk"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8292e18166so5390486a12.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839689; x=1780444489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0Hu/D8rAuWKbGc4lHoFkn5GJfHnwhou62SLjESXk+s=;
        b=EHms+Axkefp8PwSTahgdtD2/Sisow1YdDbwPFldOw1JaAOZe6OILHgqMiAx2UiS1Z6
         Qe2cr9VG6d2ayLtpZjMVdmmQPRkBpcdptEEmwrnBZxL2wpvKrIsZhcHr3JN9j6uRHj/V
         g3iLtT3Cm98vhM1R+9G8O2E//zWCtNwDSLs+saijUrRq46xD9EqhpPsRdOXTDi1Q85UC
         D9PlRs1r1Rqjqiwcac5cktHVXoXwzVSrZNTcupgntUB5IMT7jWDRYtStCzkc7GNszs55
         8qiDoO4EMVh6YI5uFfuLNflxqdr+psbOSAoT36T6nCrdFUfdPwc2sn0exV+yPUQ8tkMV
         duIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839689; x=1780444489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0Hu/D8rAuWKbGc4lHoFkn5GJfHnwhou62SLjESXk+s=;
        b=pKK8PysVfQr9kNXLzW4auDoSAksjy3dKXnKwsVO85soAtuOmBPcUvE+wBgpMa0cU4F
         6rZWNJJqBzOL72ZGxW9NMC6YKLwS63N5o7NOMi5kbYZovR9r0wuE64reqVuvPQzBPNI2
         2q5a2NKbMCU6D8agudwtRd32mg8nOqQT8zJOOCKQZY6Q3TQ9/62XOTHMlJfKl2GKDjNh
         5AL1z+QLoqa3cXBQl3kr5sR3bYtkuMW/4el/u5kMeQF7sii3QdSzNSVKFzFmw64lYkrM
         B+CKyp0j5mjCuaIMwdDO9i6NksjV6zQbVb2U1bFFghMb5wiSvlMtWg+8fsUmO632kWv3
         glkA==
X-Forwarded-Encrypted: i=1; AFNElJ/k2o4ivbHVYq8IHCNa5iRhvETgSo7vEiJ0pv4Fs64CmlDOL0ZmDJfI/ofaWJ7NJd3HKUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGidQCF7rGoMiZAEQ+Ax6V8p9/4NsfzIrhtywbytYFwDMLcsk
	ZAUuUYGU/Ug4Se72aeByffTQ+zztudJ+hDW6zWpFPT3vPVr+1imNAtx9/7lbcMriTYNJqmvUS0i
	duruO/nT1
X-Received: from pfblu13.prod.google.com ([2002:a05:6a00:748d:b0:82f:ad57:40bb])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c6:b0:836:900e:8743
 with SMTP id d2e1a72fcca58-8415f35d58amr21464806b3a.36.1779839688895; Tue, 26
 May 2026 16:54:48 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:13 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-7-jrhilke@google.com>
Subject: [PATCH v2 06/10] selftests/vfio: igb: Disable PCIe completion timeout retries
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

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
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c   | 12 ++++++++++++
 .../selftests/vfio/lib/drivers/igb/registers.h       |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 879c21780f5b..89537f8345d1 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -209,6 +209,18 @@ static void igb_init(struct vfio_pci_device *device)
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
+	ctrl = igb_read32(igb, IGB_GCR);
+	ctrl &= ~IGB_GCR_CMPL_TMOUT_RESEND;
+	igb_write32(igb, IGB_GCR, ctrl);
+
 	/* Configure PHY internal loopback for testing. */
 	if (igb_setup_loopback(igb))
 		return;
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
index a133a208ed08..3f04bcaa44ba 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
@@ -73,6 +73,8 @@
 
 #define IGB_RAH0 0x05404 /* Receive Address High 0 */
 #define IGB_VMOLR0 0x05AD0 /* VM Offload Layout Register 0 */
+#define IGB_GCR 0x05B00 /* PCIe Control */
+#define IGB_GCR_CMPL_TMOUT_RESEND BIT(16) /* Re-send on completion timeout */
 
 #define IGB_VMOLR_LPE 0x00010000 /* Long Packet Enable */
 #define IGB_VMOLR_BAM 0x08000000 /* Broadcast Accept Mode */
-- 
2.54.0.794.g4f17f83d09-goog

