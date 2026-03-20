Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8238E103;
	Fri, 20 Mar 2026 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001979; cv=none; b=D5wZnNkiOb3EBxtyCDQhG1c2x1BMb4eYS+t+eScrBAUhrLmL6IYmGyapsYsVpZff95uZ8Ni4QtdSuyTmO1aTatv7tPsHD8y880BO8IoBHzyF+6LnBv/rAWwwp3lvOiux6ZHqgTV4jsMhUv0gJgV0xfzzeSFqovy9PhwU7PdORDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001979; c=relaxed/simple;
	bh=QRUfFyJwT6qOrnEazRDbPg1WDHxi2v472i7GoX8JcKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FS1xBkmzrO1vQ/+hyB2qPBlTrSNnxAV1JKVD4afe/LIBzwVZjzRXewv12xIPka+IiOHeMbO+mDU0cMm1t3KIHTtSvP5JHnK3VrhVHRy+VWZBN/wkklcA6VG1JwOds/WoLndWBkGsFKDxvUu2EYUE2RY0Ajqy9Vga/AKEjh4hV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cXLrhpme; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cXLrhpme"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 436BE20B710C;
	Fri, 20 Mar 2026 03:19:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 436BE20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774001973;
	bh=czjA+JLMJXAAj1eEQCrDT4VQOWKl8Iw1uQvMc0heQjo=;
	h=From:To:Cc:Subject:Date:From;
	b=cXLrhpmeFY9VRC1qv6cLXgYTQHhR/6ByOQ/e13dMhC5m79WmY1sCcoCpe0Yry9fBz
	 OPYgfoVcOQm9vWLHdeJNg10ucaNWlSkSofoEj+GS51mcsfFfaFUU6k71rRRp/JldRI
	 0/Voum0Ev2tKRoQ78IEgOEjJToQvqPtDxkB4yT4c=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: ptsm@linux.microsoft.com,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com,
	alex@shazbot.org,
	pieter.jansen-van-vuuren@amd.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] vfio/cdx: Fix NULL pointer dereference in interrupt trigger path
Date: Fri, 20 Mar 2026 03:19:33 -0700
Message-ID: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation to ensure MSI is configured before accessing cdx_irqs
array in vfio_cdx_set_msi_trigger(). Without this check, userspace
can trigger a NULL pointer dereference by calling VFIO_DEVICE_SET_IRQS
with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE flags before
ever setting up interrupts via VFIO_IRQ_SET_DATA_EVENTFD.

The vfio_cdx_msi_enable() function allocates the cdx_irqs array and
sets config_msi to 1 only when called through the EVENTFD path. The
trigger loop (for DATA_BOOL/DATA_NONE) assumed this had already been
done, but there was no enforcement of this call ordering.

This matches the protection used in the PCI VFIO driver where
vfio_pci_set_msi_trigger() checks irq_is() before the trigger loop.

Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
Cc: stable@vger.kernel.org
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/vfio/cdx/intr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/cdx/intr.c b/drivers/vfio/cdx/intr.c
index 8f4402cec9c5..c0eed065e8ef 100644
--- a/drivers/vfio/cdx/intr.c
+++ b/drivers/vfio/cdx/intr.c
@@ -175,6 +175,10 @@ static int vfio_cdx_set_msi_trigger(struct vfio_cdx_device *vdev,
 		return ret;
 	}
 
+	/* Ensure MSI is configured before accessing cdx_irqs */
+	if (!vdev->config_msi)
+		return -EINVAL;
+
 	for (i = start; i < start + count; i++) {
 		if (!vdev->cdx_irqs[i].trigger)
 			continue;
-- 
2.49.0

