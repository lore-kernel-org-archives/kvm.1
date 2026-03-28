Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1236CE14
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774738912; cv=none; b=GR7gKDwZJA1q826rNHqIxlEbdoPSKTyGObG20xEigzwaj9RxkW9m1OD+NBUUDloWv/QvhTl6EVvpDF1cr/mj8P4o0/Bmj+71ZyfT4uSjKA8G3PXhEyHh7+JxUADj6HPSZA02Z756EHOFG5Jf1XrgmpoNtH6ACKa+SJ3qlC++4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774738912; c=relaxed/simple;
	bh=lDpXKbbx+iUKi1EaJXjH5FYWfPCjxXzTGrKbapyCYk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbMqpj9raheEJS/8nIoN8ZoZk8OaCopyLks9iu+bRG1jSTvpVC4alS1e+LCt7lhpz54j1k3wzb+Bd8QtM8BV3CzobdFWH6x7Lts/sgUFPsUrcTBvVE1pQMh2G+X77gBWxDxBSciW+05fVvk/grsE/2NSwpuBmhaQgXSrxN+fnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6ewS6Db; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6ewS6Db"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so42916745e9.1
        for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774738908; x=1775343708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBt6KoG15kjXguWZ637dFltb5bZY9qwpDoNpuJqHG30=;
        b=E6ewS6DbFHi7hUux5YifeZAVXoMpkdKW86wLRhCcVE6kpBKuPG8X9e9MSlKsy7fqgn
         U/QL553f76br5VrG51/ngz7KzYw3UZREhWp705Z601gdYFIYwwCeO6N6bhuadDoq6rlF
         ytr996B5OSyUVWGARgXEDTuIZU3ucgYF6e/NKKiSjnz4dfN00254TMB57ftju8DLJvu6
         myuBfD0MR7dh93DbklPSsOyHwXJ3LGQuBF2jSQNakI6O41faW9JDkJMy23EViOBX+IgZ
         4qksxDLZYAMhVcnnBt/1kmVSxv4TByMYibaP0OGmC2wHpQzPhKZuSYgOvFRw/IcxH8c5
         57jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774738908; x=1775343708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YBt6KoG15kjXguWZ637dFltb5bZY9qwpDoNpuJqHG30=;
        b=LDFtEhlAafQb/wIIjhl5U8G/NR2/xkKDGOi4Xby93BqEWSq73cujRPTVBsLEF8RQoQ
         6r6u7J4qgi5Bwflr+S4KOT1kBxSO5t50izZB5EAotOopdZ/HTmA45AZoDvNuL0ttkBew
         /lZLlV/2qzfrkk+LWIXGWH7Ruo+5ZAL42eHZhDvCvdqJowjmi+zy1fDpGBilsE9B5UMB
         XcRnaBWGDgDZiw7zzzlSNuPn/pP45qqEtGhCgcdkyP/JCzzOX3wJeVPz4DOzwXdr2XE/
         eAVMn9g4Tkmdsv2U7Il/0rrYA0OWg62bOEF2t7petrDdaeeg8/SPthqvK2R27cu+VykW
         kPkg==
X-Forwarded-Encrypted: i=1; AJvYcCXDi4WwHfC3B7YME9X7vEYTcgO5XyAjPuMZVZxYGHN31s6hQfJZVN2q1MlVG9Pzx8BkQOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6WqJVkgvcrU+d65sW2yK+FFfvE3rd/tbZtSqkSyi/M7blNYJ
	7z5MCGw9X3oJRSCiQWql78iFUIJMB3ojQ2rkrmljqRwPv3yw3f7e6Ct7
X-Gm-Gg: ATEYQzwvaXo7F/BEvUJxDnDu12ciEwaeuhoOZdLPnqge4PfCLvPAje7WoScuLORwFTs
	AlDTk6+S6dvt8esvjzqY/GTa3cAaTL/w7hvWh+NLNeRjE2exvs+0PuJFIhCPO4CnqWR33XtNj3a
	+SbExcyq95WCqXEVZCe5G8p2oURuwkkMVTuAFDtaUA/dKdWlaDN4tqgQKE4dUo2Nv/NA7cVvwv6
	ZPBdy4WbfZ6W7ms3r6dXmnQT/IzCMsWRLfbkSegMogrKp+h5IMO+eL9ocq3K+SYRtxA8pOyGdey
	m9rn17xWw13ORPRN/38s+plMYcLT8rZoBtKu+gc5vg1psnzbqrVwtoyMOK17RqhXoryWibTaqgA
	fSo7UavlethX46KlwHlAcmtHJxuID0uKmSRLd2kbFj9dFZ/ygQwlQsOWzLX1+UK6I71VEf/Ma8e
	dHjRDd/P/kjtUZ4IJqwWUkmfZDWYGyYyIc2pQBZQBsfTYW1uxl4IFs/UvEeqoeFikJ9rxcV99QM
	Vk2RUS+wPql8rytRLZEBqcRhnSAYf7AHhPSfzrGpJi25aSj2JBeTpuR3L0EQEVW5Oxg8kUtGKMK
	lGG3qVIgO0cda0+t0f1X27Wve7+PBHyA88YWut9ntDEypCSmdkn5KgdVov0=
X-Received: by 2002:a05:600c:1d0e:b0:485:a4de:f4f9 with SMTP id 5b1f17b1804b1-48727ee54bcmr130405885e9.27.1774738908324;
        Sat, 28 Mar 2026 16:01:48 -0700 (PDT)
Received: from archlinux.kangaroo-newton.ts.net ([185.213.155.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873061ef41sm75078355e9.3.2026.03.28.16.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 16:01:48 -0700 (PDT)
From: Christos Longros <chris.longros@gmail.com>
To: Alex Williamson <alex@shazbot.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christos Longros <chris.longros@gmail.com>
Subject: [PATCH v2] vfio/pci: sanitize bogus INTx interrupt pin values
Date: Sun, 29 Mar 2026 00:01:26 +0100
Message-ID: <20260328230126.73230-1-chris.longros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328215808.16108-1-chris.longros@gmail.com>
References: <20260328215808.16108-1-chris.longros@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PCI devices may report out-of-range interrupt pin values in
config space (e.g., 0xFF when the device is in an error state).
The VFIO PCI config virtualization layer passes these values through
to userspace, causing QEMU to crash with an assertion failure in
pci_irq_handler() when it computes irq_num = pin - 1, which exceeds
PCI_NUM_PINS (4).

The existing code already handles bogus VF interrupt pins (set to 0
per SR-IOV spec 3.4.1.18), but physical functions with out-of-range
pin values are not caught.  Extend the condition that clears the
virtualized interrupt pin to also cover values outside 1-4.

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

