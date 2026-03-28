Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE79346E70
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774735140; cv=none; b=OpamL/Qwf5idP91A+Xls4icj2P2EOf6egj5Yp83g91b0/G8tWV53avmVBjJUckLvK/AiawFNrQDQASmMrSdR4wibf8U14QEMc0kpD1EC5s+zTVN7kjL8Lplojk/aMQP+723zqkWaPFp5zMtnOlbh+r+ZGek2VGazxY1B4qvlnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774735140; c=relaxed/simple;
	bh=w1OtwFSIIEFzlkWZVlPJH50aUgOjLaM4Wyv4g9zgn88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a0uud0tvHA9BIq6wK0/WbTIBtH10QDZ4/C56KON1Uu4Iw/Sq2sh1jhxQ/HbNMz36DzZxbU51qG0a6cGgj3xS9pRmaD6s6t4uciPHq669uz6+3DFGaucdVx12/RRGLa1FgUJSqqD5Kp6VbNq9H1yRRq034iZ5NXI6WyzSxuyoh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdhLs8pz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdhLs8pz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so31180395e9.3
        for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774735137; x=1775339937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GovFc/Quryn7Wrtc0cRqpho3m7htvaaEbNv4FAPywhk=;
        b=gdhLs8pzN4KgWuKwMOBKIfF2RBEaICGTNwYrXwU6m+D40/kr/+XbCsZp8i84fcmRTZ
         YzLYGuGM8A3VSNNaRy51lfmyjhGIthjIz5zXKWJX4As/ieh8Rya2/2v3CcDTVBwOOT34
         4vUyEDiTwfCWtaPzxgOxiQUSZ7F3syThzuQagRnuELS8vfU1mfsBzBTpwfvIF+RicJSz
         Ei0Qb02X/pCoSc7Z9hCWIInZq4E/TE8LaXobGWYDmyR3r1pmJHjXPmnD8k1M+fhUOuXm
         y1KHuyyDEf07j1lylNOE8okNkIh3PH0cUekxrbCr60tkHkN+GHAuJo9F+OfBirlIez04
         Pl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774735137; x=1775339937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GovFc/Quryn7Wrtc0cRqpho3m7htvaaEbNv4FAPywhk=;
        b=OBDAoWIYPUY5yuHEiX1yh+nphIvZKbEl6TLhcPEpHzVtiHVyK1cDKpCNAY4Thuz5cB
         3lVg23qmn0/5Cv90DEW0yrO7cXikPq/obhrhqC4RhQ8FdaXr0rl80KWXpBavq9/sm/TS
         IyzU2w1asG+INN5NfOJe2XQ3/0QoWwvoy7MO1Llpx0qe8rTKMKD/HBWFlXkojNMtYiMU
         K+dm9oekgI03MzD8JE07XfdFYwgpfMEzYmWdP5vYLOyHlNLdmJ04TAyi/hS1wUbT/VOA
         G7GJcza5hi0KKYAVNC7bwYFX1UNdvmlLPFjom96w08svPHBWIeeqv42vlyFk33Y5qK2V
         E1pw==
X-Gm-Message-State: AOJu0YyHhlpRxpW0xFsVcwt1HY5uylkZ11xcJpnvQ3FWd3mdgiV7kqhd
	l0Niv3HEtc25dNLZuCbkWbSm8tFt+Y71QdMK73G4EixHaWrJi/huwyPtZV6u6S7tRmI=
X-Gm-Gg: ATEYQzw137lFmf8DcrNrZxjjb04vxLjPrOj1ut9AOn729A5j31cESXIEmFtXOuU9i3C
	35KMvEye17NyfGesauBhCa6waQR5q75iFEEqI7VqkNVxtDysOrKFRiK/1wQjNdiZlagzI1xz/A9
	25en+EaGqPqlwoD4n8SSLPFmFKz9sxtzpUg84Ixmo9lCZe5ynJ4pgYphe5TpNjgo+jmyf21IlW+
	tywvaoxJrAqK9xqmCcxOqxBwRyuhKKXXWH9B0ODF8jdVBpLGL6GvdlXr9DqwiS/lxBoS0uR7YEI
	vTyTMkLiaHjdJ65PUJ0hPNTw1qa4FCMlLrC0z75LArsMpWvJmLMtnWZe2xKVfn1FE92GjdaEmk6
	qkIeGrEGmsIck9owDFq/6t/U2KnGVvY4U4vUM67QTLZUDK4KxI5S/+HUnpGeq1Pt2MtfIOEJ6q/
	BGtXnoDAvIns9/W31jqUKlwTAvB/ME3Ui7Vht/1KhIfDUEIUUxVkVNJLUK4n7coAt5yeY3Ex5kQ
	lMHApWx2OzVCVvdd7t2Gv/XpBY7889CohWPNLWDtRg++jTavBUB5r9FaFCzUsOqbsyKDoKmWQ9A
	DL6ixjpecfDqj6A3lqf2p72DSPMbTCtjTK4YFvFoDvGbnP9VrfnhuuDnvvA=
X-Received: by 2002:a05:600c:3586:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-48727d5a17cmr130395765e9.6.1774735136501;
        Sat, 28 Mar 2026 14:58:56 -0700 (PDT)
Received: from archlinux.kangaroo-newton.ts.net ([185.213.155.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c845b8sm158502225e9.4.2026.03.28.14.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:58:56 -0700 (PDT)
From: Christos Longros <chris.longros@gmail.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christos Longros <chris.longros@gmail.com>
Subject: [PATCH] vfio/pci: sanitize bogus INTx interrupt pin values
Date: Sat, 28 Mar 2026 22:58:08 +0100
Message-ID: <20260328215808.16108-1-chris.longros@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some PCI devices report invalid interrupt pin values in config space
(e.g., 0xFF instead of the valid range 0-4).  The VFIO PCI config
virtualization layer passes these values through to userspace, causing
QEMU to crash with an assertion failure in pci_irq_handler() when it
computes irq_num = pin - 1, which exceeds PCI_NUM_PINS (4).

The existing code already handles bogus VF interrupt pins (set to 0
per SR-IOV spec §3.4.1.18), but physical functions with out-of-range
pin values are not caught.  Extend the condition that clears the
virtualized interrupt pin to also cover values outside 1-4.

Observed on Realtek RTL8852CE (10ec:c852) which reports interrupt pin
0xFF in hardware config space.

Signed-off-by: Christos Longros <chris.longros@gmail.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index b4e39253f..ed75c1cc3 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1829,8 +1829,17 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
 					cpu_to_le16(PCI_COMMAND_MEMORY);
 	}
 
+	/*
+	 * Sanitize bogus interrupt pin values.  Valid pins are 1 (INTA)
+	 * through 4 (INTD); anything else disables legacy interrupts.
+	 */
+	if (vconfig[PCI_INTERRUPT_PIN] > 4)
+		pci_info(pdev, "Bogus INTx pin %d, disabling INTx virtualization\n",
+			 vconfig[PCI_INTERRUPT_PIN]);
+
 	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx ||
-	    !vdev->pdev->irq || vdev->pdev->irq == IRQ_NOTCONNECTED)
+	    !vdev->pdev->irq || vdev->pdev->irq == IRQ_NOTCONNECTED ||
+	    vconfig[PCI_INTERRUPT_PIN] > 4)
 		vconfig[PCI_INTERRUPT_PIN] = 0;
 
 	ret = vfio_cap_init(vdev);
-- 
2.53.0

