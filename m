Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570839;
	b=JoxYt1gwp5EMdSKmMQSPfH93Rtr3aTxlTBFlFBr84JShZmz7hHYAIM0duUVBK/v+nazW
	 DK5vCGma/LuyrX+yeRiCzVil2YsDvHSCNmdkbffVsIsvFMxTuCGr8T3sbTP5uitWKWea5
	 YNO+xCW8lDo3vyp4sLAGFg+AyJybuA9GhCJEPq1UqgUR2DOx34k9Fr1kDbCs45QaFDg/w
	 Ykvi/YQoevyQWpOE/2qF9qE3okzA2KekGdBCUL+cowKC/xv7SlmihPv2zhMCHSIyehbg1
	 a2wGrLrW/o1YLjVeyLx8qSFlDkddc2Ux5WgT+6NrceXd2O4F9SSzOa7N/4BsX+9eSFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570839;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=N3zhSUFcOuUecMmOF2S/sOJZ1XZuTYWlBZE5Z6JPRz0=;
	b=HR4Cnm6nGU/NmOly9iRXK8T7mNJuU7tvOYXSi0SVVtAwe7FxUkEVDkqpTvEZbv9qJJFV
	 poh2zMFjJtObJ+e8JBWqOIsbsgLn/0JQzcSFT5jfZUtvUWOzzWKMB6XpnkVmzOS6yZNOQ
	 ZShCJJkaMoIqTsDb5XykWy3KgM7hNG2slQCd7tVc3PT+w3O2F1lkZ2mrHd++ZOFTpS5i6
	 zhbJMYHDktpOqXE4i1P88kfVyXQ7ZdEI8BKo+FzjqsTOddxvp/YX6yEX1Zf3Lb1TciKTp
	 Qsy0EnjzGnmC4x1jWXYrGB2bGNt8ftN7Mq3QFQEvvDCSBUJPKIORkAcqXAnIZgdawgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cElEAZbI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YhfvEEoU;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1720606A31E
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 08:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1720606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cElEAZbI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YhfvEEoU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792570837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=N3zhSUFcOuUecMmOF2S/sOJZ1XZuTYWlBZE5Z6JPRz0=;
	b=cElEAZbI6LlcuO5yixatepkqQlulMPbFMz5D3Ff69Vse3oiOOXk4tUpQPzYWueMwvbhOYU
	zRvcDnzJVNlroTzcoiiPdjjVWAVvRmfPvg8dp2OLS+fKn6RDDq+2YqEY7VRM6ZC75jzISD
	2MIARdwihH0+dmZ8+xjKiuD//ddRs8w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-5LU86w9rPy--GOt7TFpnUQ-1; Wed, 21 Oct 2026 08:20:36 +0000
X-MC-Unique: 5LU86w9rPy--GOt7TFpnUQ-1
X-Mimecast-MFC-AGG-ID: 5LU86w9rPy--GOt7TFpnUQ_1792570835
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso305438f8f.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792570835; x=1793175635; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N3zhSUFcOuUecMmOF2S/sOJZ1XZuTYWlBZE5Z6JPRz0=;
        b=YhfvEEoUE84ZewaXrchWkHCvvdoWGp5xopLYfABvQ+0yBwBYSAXhcXT37o91O/RvTj
         x4WDoJ9OaMi3a+tVrNTcoVxUzdrG7+edekT3K3sCOs3oQfomVROQTPznFzrkdHnKMJzT
         RpMw8BOfwvnTBxi4AGEXCk3g0DjnkNMpYMyvx9pb9fA/vSOSm9qIYG0u/OKgDxb+Z17o
         d6kPRw17l6tRNyzZ79KmQF4FAfN2JlcnIxiYsEEIxFq8ufXwiy1lAzgt0Ri/ivz5p/gN
         2C4ox1fQCnXV+W9WJknDgJze6K92V6A0PyT8QsUL/XVc3Vj6Lbi0FV7Imc0+umjq7kjs
         R1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792570835; x=1793175635;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N3zhSUFcOuUecMmOF2S/sOJZ1XZuTYWlBZE5Z6JPRz0=;
        b=TM7T1WPvOPU7hE7Va1wZR4kqM8jX2yvDNP/SXdMCbxthe3rnVYemAmkarxmdbSIIzL
         Pc7SjcXG8h1z+syr2X6znoAh09pWXasVicTYrXyAHQ8HuC5kuR0ZGJUKlwJ+iNZ5TU6/
         62sVREL65JIVS1xgafin4LOPcvJcwwKMQ9//1CmJfpjmp/4yWFCd3CVWLS8Rh0CeLwi7
         jRQq+w64eYq/HsEvL6pQ1jerGUL1dXjLvaxulmKgaEWVKXb4MMdwf5wPN6/jljjtF/TH
         7Qs1o2Q+ZnpXQCHU/wn9vvXBDIjrmKpjHXC8vY41yH8BY7RbvNV70DIH9HGsKPGRMHMh
         4qjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxt6p6kFx7RET8vXa/xNl660Ac+nmLHCpsHR3leZtL0lsl/UseJHduw1NURejfi1W4bsU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZLqUp9zCpR1fjk4av56fI5VRmLj2s0OGBoz1hr6gTq/vgkcGI
	yp9BDZcSgzDnEy+HZGa8VE8wNQjO3NDF4lJl2XER2E1fLKQtaeHwx6XeLPe+Q0b6dKNuIy/6jhP
	nX8kPoUMRMKLqdKu9kAWltgJme0jjoxSMC8jfOw4aDXyokvfoWKcKRmw2gRRnsw==
X-Gm-Gg: AYBFou0MNudarZzdJ9cmX9gjLAfj5rf+BBMp2++rTGhcRaCDHLxWJXWm4Vw3hVM5adL
	vVj5oeetl77d2Va9U6w0ki5/pM5URjT89/gGQ6FAELzRkJEv2bdOknAuLt0L5tDC1nLzw5cX4yX
	Q+ShIazAPff/BFZStcUkLpEp3/l3ROL76y83O4O2y1/fYf3k/hs8egU6llI9lJtXxzgNpQeg4iq
	bPssuyhoKQFBD7vu7U01cnGrYrea9eucdtPLzNO+u3PeLWol9NGoYEzsGPrtCprctuS8whokTMA
	68fe2NyAxHIh+AHOyul8urJR/muMk2HC8j2VUkHXIk4hxSPvzyyVWKVAdGfFesGuXeSmCQ==
X-Received: by 2002:a5d:42ce:0:b0:488:5af8:eabc with SMTP id ffacd0b85a97d-48e264bc498mr1798851f8f.26.1792570834816;
        Wed, 21 Oct 2026 01:20:34 -0700 (PDT)
X-Received: by 2002:a5d:42ce:0:b0:488:5af8:eabc with SMTP id ffacd0b85a97d-48e264bc498mr1798809f8f.26.1792570834289;
        Wed, 21 Oct 2026 01:20:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258420e4sm3889294f8f.49.2026.10.21.01.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:20:33 -0700 (PDT)
Date: Wed, 21 Oct 2026 04:20:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org
Subject: [PATCH v2 1/2] vfio/pci: fall back to platform ROM when
 pci_map_rom() fails
Message-ID: <c5d91752c7bbd40d89f5fce5da8582f1673cdfc3.1792566536.git.mst@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When pci_resource_start() returns non-zero but pci_map_rom() fails
(ROM BAR exists but content is unreadable), the pdev->rom fallback
is unreachable because it's behind an else-if that only triggers
when pci_resource_start() is zero.

Try pdev->rom whenever the ROM BAR didn't produce a mapping, in both
the region info ioctl and the read path.

Fixes: e021e6cbfb5a ("vfio/pci: Expose setup ROM at ROM bar when needed")
Cc: Yunxiang Li <Yunxiang.Li@amd.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v1->v2:
        bound reads by the ROM image rather than the BAR once the
        pdev->rom fallback is selected, so reads match the reported
        region size (a pread spanning the image used to fail with
        -EINVAL past the BAR size)
        add Fixes: tag

 drivers/vfio/pci/vfio_pci_core.c |  4 +++-
 drivers/vfio/pci/vfio_pci_rdwr.c | 32 ++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 050e7542952e..630474d03e3b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1128,7 +1128,9 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 				pci_unmap_rom(pdev, io);
 			}
 			vfio_pci_memory_unlock_and_restore(vdev, cmd);
-		} else if (pdev->rom && pdev->romlen) {
+		}
+
+		if (!info->size && pdev->rom && pdev->romlen) {
 			info->flags = VFIO_REGION_INFO_FLAG_READ;
 			/* Report BAR size as power of two. */
 			info->size = roundup_pow_of_two(pdev->romlen);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 3bfbb879a005..6e47d529cbb9 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -219,7 +219,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	int bar = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
 	size_t x_start = 0, x_end = 0;
 	resource_size_t end;
-	void __iomem *io;
+	void __iomem *io = NULL;
+	bool rom_is_mapped = false;
 	struct resource *res = &vdev->pdev->resource[bar];
 	ssize_t done;
 	enum vfio_pci_io_width max_width = VFIO_PCI_IO_WIDTH_8;
@@ -231,11 +232,6 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	else
 		return -EINVAL;
 
-	if (pos >= end)
-		return -EINVAL;
-
-	count = min(count, (size_t)(end - pos));
-
 	if (bar == PCI_ROM_RESOURCE) {
 		/*
 		 * The ROM can fill less space than the BAR, so we start the
@@ -244,10 +240,30 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		 */
 		if (pci_resource_start(pdev, bar)) {
 			io = pci_map_rom(pdev, &x_start);
-		} else {
+			if (io)
+				rom_is_mapped = true;
+		}
+
+		/*
+		 * The BAR can also exist but be unreadable, e.g. on a GPU
+		 * that was never POSTed.  Fall back to the ROM image stashed
+		 * by the boot loader; the region then follows the image size
+		 * rather than the BAR, so bound the access only after the
+		 * source of the ROM content is known.
+		 */
+		if (!io && pdev->rom && pdev->romlen) {
+			end = roundup_pow_of_two(pdev->romlen);
 			io = ioremap(pdev->rom, pdev->romlen);
 			x_start = pdev->romlen;
 		}
+	}
+
+	if (pos >= end)
+		return -EINVAL;
+
+	count = min(count, (size_t)(end - pos));
+
+	if (bar == PCI_ROM_RESOURCE) {
 		if (!io)
 			return -ENOMEM;
 		x_end = end;
@@ -283,7 +299,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		*ppos += done;
 
 	if (bar == PCI_ROM_RESOURCE) {
-		if (pci_resource_start(pdev, bar))
+		if (rom_is_mapped)
 			pci_unmap_rom(pdev, io);
 		else
 			iounmap(io);
-- 
MST


