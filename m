Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036F3B3BE5
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791580711; cv=none; b=vGhLXMjYBGSlURkbdyPtJA5KDjaxOa8p2xxoRed187neVlYhpvCDd7zO8VgKcX+ak4GhVqDy1/rHlEkZKGTdnLoqaWR0lUStRE+KFv4a/r6iNhJIX/S2x2CEI6UezsbBa4khlTqK8wiBqgMxkWG2/fgApOoXNy5dtHZ0iluqDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791580711; c=relaxed/simple;
	bh=GFvYY8TNypheZvAUixOHukYWfd7SjDI+cqVtol8ssvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsRqY/LS3d6HMfecWYEfFNH2k0eRBmIZsFkqNRX9C5gn1J0bqU2ncLNeTGVMdUo/1yWpUkWR6x26hsGB4ug+7yjBNVF8cijNVBGDD4+Gzo6RklREMGjrW3PzVhf0iiqtrO+MK9C+qNFLKZKTQuisQuY+mgrtycf/ursotDiU4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=hbDiM/4X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzpmNFnY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="hbDiM/4X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzpmNFnY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EB0CFEC0B02
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 17:18:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Oct 2026 17:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791580705;
	 x=1791667105; bh=QkHM/UMH47uFZln4brjrfrpKO2AM6/kdhan5+UbmzIQ=; b=
	hbDiM/4X43oQUOxeR1QG8CuPUganu8R2LIIBqds2LYYFQCOWomiI3/moYTaGRyak
	OjcPVx5YPrXoJJQJVP/EAn6yppPO7TEMb8sdRy/A/zTNOsIQg0ydvmCGfljddiJL
	0ZAahRU4QpgXjo1OpJoWPWUKMo+KK4wCJ87g2MBPWWZGVENwBRU3v+sONL5qk0Vx
	+sZ57VQ0dwZ4i/om0vDlv3YFQC7YadNhvjqIOz8xGyHS93f1nZy/klHL10kUK2JZ
	JnsMD1pNaRNLYyEoFT+O8AYXBrHlJo5zR30rwDrsAEbV2nU0QCwNhI/D6YORHx3v
	B/5teyEsZoV0rcXVIpbVBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791580705; x=
	1791667105; bh=QkHM/UMH47uFZln4brjrfrpKO2AM6/kdhan5+UbmzIQ=; b=j
	zpmNFnY7lm4SjmeQa8rOr1wr+1IiftvcAMs5NT+5J+Rzeqj0lQ7OtIMzWyL4STO7
	68KFM3+fI5iBLpd88DkPZiewYthUsftHQ4vqAuBf69IwMK1nPZI8E67da8v3E/Bl
	OAzR6FnWOU/AAOm9pPfVpv82QywPfgW9Ox93K0ROFf0RsCt8QKOq51c0x9+QmRn9
	aTzl1MD95ea8CZiCYRGHQdOKDBB5trMrZmJyBCoJ8lCZCwrdTLX9ZO7m1ZlgC/YE
	hEuyy/5ekOrJrAxdFFfwW0w0WA+Fhdv0BOxV+xwKnwBOSwTlcO0aDfk2/FRUGsp+
	ihH+9Efy5G7D+rorCys3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791580705; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:m6oTDCtmK+64AuNuh29qSzeRY21K2puFjth4AOXlzKJy/RJ
	dtYy57ZKxtQG+HNsXhZ3tOcHH2iJtisS8WaRhylMFb0ftLoLwkpmvaNk67IOTnDz
	sFzPSHr1M0ljepGQk4RF2n4NVjuv7d7jZklOsqNrpapGOE1ND3PY+3Q0iWq4MuY+
	eCYgvvFoY8xv3kCsXPyNt8u6PMIrcvKQdgPVOzkxa0IaYT1/KjbGOqxhZC7tuyyU
	si6o208CfmtOtZz9wwEIu5u/r/+4oGl3BrMs1oVC0JOMZj3t0G9Q9QK6C0Jws2NG
	7hYsKHqvk/BXWjoFrrIxPOld8GamZ/1QcGgIi3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7z/x0g5QRzRyb/8Z/2p5aNAn/EjA62Pc4P25TvM8UPc=:GFvYY8TNypheZvAUixOHukYWfd7SjDI+cqVtol8ssvQ=;
X-ME-Sender: <xms:IVrJarH4qwYhy91CAsDhEYVZ8qWneARdjjV0JnCuNTaMw6RZXD_E7w>
    <xme:IVrJalhADDDZPazA3EPysFCE3tS52orr8T6gEhIzpfXKOBcOTz9wR83ESnCJDNd-A
    uniruAaYUNl8S45FA3p_LpygRB4ws1y_ELvF5H38EL1GxPgNer2fmM>
X-ME-Received: <xmr:IVrJahru3Q8ehKUU5C056-v6uuJU6mYwWn4ZgpC8ctVkpRQUg0CNskgCwCgraw>
X-ME-Proxy-Cause: dmFkZTGIUL7lVPaExFDyvoYeFdjh2QeI3+jdddK3tqUU4NoEhdJNQK2WvrpTB69TSi4QFd
    TM+nWeUAcV5KC2b0TudTLP0BUFMvuZ78yBC1aLgX90F9Vi7MPi0+YJIENrBbh+uuuZ6i4U
    IHTJD8tT5v5uxROjDN14e78afMw9j18yW9Ab8ki15BAhwEx7hobYBEveH0srKUDxB5h6at
    HElvGy0yHYxuIUyqX+PEpk3Fibi2xQ/XbkR7+MWYsqWVHBQK4m85/aNfmreJFHuyqS/5I7
    mFakJVFZ74RrfJCl5XLwMrCn1mzw5aZb77u7Fz5aQviRoCEap5LZ5pkQ4aY8TwjV632cTJ
    yWJzj2tv/4eRdcT6ic+BGKEePLTTo4EO51PbcgyMdCfYpd3aPl/ED4cFPW2jSHGeGF55jA
    7fs8Ee4WhIJXlN7mDvV1RM4eAU7dKbNSs2u5hftGYRat/Mo0FZfphOS3rChKDwy9fD4l+P
    WHMg/c2fnPx2OAn/2DBOrffgWvT2e/aa6FbIjlrnulB4OXIz+ko01cQwqFUIFZBxiPP4vz
    HL2XfQiiYLH6bOLX6Vgx2VvdM6cDVZ9OPg1O/nMEozdjqpRYDf0fMhTaIvplUCqHzeEHsn
    4IaX6ueESDlrYd55IVrNFiXPdTK7wYaZcg04LZ9xnvlDWI0sm7B8BRKKePiQ
X-ME-Proxy: <xmx:IVrJalTEKkcg_13Ui-JB_mHs5wnTmSYmkJE-NF_mLYBUPLlcb5ASxA>
    <xmx:IVrJaiT1yvVbg2bSynakf05toGtNG4kaaUBwMbEvIF_GMlHRq6Ehew>
    <xmx:IVrJajVf6voQPbH0ZMOwBPEMyfJziziCPa1kUvc-jlfAAY9iPHvv8w>
    <xmx:IVrJav3DKvAxPQi08gBMkgjmC04Oqk7MZbiK-Pp27J3Ou2DcMWpIpA>
    <xmx:IVrJajwrEj8IbnPMhXTz79JlNlXsKERlcW-3EuFSXRWSaAWr-OgMGfk5>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 17:18:24 -0400 (EDT)
Date: Fri, 9 Oct 2026 15:18:21 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Simon Song <xinmengs@nvidia.com>, dakr@kernel.org, acourbot@nvidia.com,
 yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
 jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com,
 smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, zhiwang@kernel.org,
 zhiw@nvidia.com, Alex Williamson <alex.williamson@nvidia.com>,
 alex@shazbot.org
Subject: Re: [PATCH v3 1/1] vfio/pci: Remove the core dependency on driver
 data
Message-ID: <20261009151821.461dbefa@shazbot.org>
In-Reply-To: <20261009192800.GG13920@nvidia.com>
References: <20261005184236.1946167-1-xinmengs@nvidia.com>
	<20261005184236.1946167-2-xinmengs@nvidia.com>
	<20261009192800.GG13920@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Oct 2026 16:28:00 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Oct 05, 2026 at 11:42:36AM -0700, Simon Song wrote:
> > vfio-pci-core currently has runtime functions that interpret pci
> > driver_data as a pointer to vfio_pci_core_device, and enforce vfio
> > variant drivers must set vfio_pci_core_device to their pci driver_data.
> > This constrains variant drivers' private-data layout, including the
> > typed driver data used by the Rust PCI infrastructure.
> > 
> > Add VFIO_PCI_CORE_DEFINE_CALLBACKS marcos to generate wrapper code for
> > each vfio variant driver, update vfio variant drivers to store their
> > private strctures in driver_data and use generated wrapper to pass the
> > vfio core device to helpers.
> > 
> > Select the vga decode callback during vfio_pci_vga_init based on if
> > vfio_vga_disabled, the callback only use pci_dev and does not require
> > driver_data
> > 
> > Assisted-by: LLM
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Suggested-by: Alex Williamson <alex.williamson@nvidia.com>
> > Suggested-by: Danilo Krummrich <dakr@kernel.org>
> > Link: https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
> > Signed-off-by: Simon Song <xinmengs@nvidia.com>
> > ---
> >  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 27 ++++----
> >  drivers/vfio/pci/ism/main.c                   | 19 +++---
> >  drivers/vfio/pci/mlx5/main.c                  | 13 ++--
> >  drivers/vfio/pci/nvgrace-gpu/main.c           | 19 +++---
> >  drivers/vfio/pci/pds/pci_drv.c                |  8 ++-
> >  drivers/vfio/pci/pds/vfio_dev.c               |  5 +-
> >  drivers/vfio/pci/qat/main.c                   | 12 ++--
> >  drivers/vfio/pci/vfio_pci.c                   | 33 +++++++++-
> >  drivers/vfio/pci/vfio_pci_core.c              | 61 +++++++------------
> >  drivers/vfio/pci/virtio/main.c                |  8 ++-
> >  drivers/vfio/pci/xe/main.c                    |  8 ++-
> >  include/linux/vfio_pci_core.h                 | 41 ++++++++++++-
> >  12 files changed, 159 insertions(+), 95 deletions(-)  
> 
> This looks OK to me, but it probably should have been 3 patches,
> mixing the VGA stuff into all of this (and you have a smart approach)
> is not how upstream likes to see things arranged.

The VGA stuff actually goes away entirely when this is rebased onto
Dave's vgaarb changes in linux-next[1].  All 3 VGA related chunks are
simply dropped.  vga_client_register() takes an opaque pointer, which
then already removes the dependency on the pci_dev drvdata.

To apply, the below 3 chunks are dropped in their entirety.  If this
looks right, please someone double check, I'll apply it.  Thanks,

Alex

[1]https://lore.kernel.org/all/20260922071807.2533884-1-airlied@gmail.com/

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 362c375a0579..f8ed54841723 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -153,6 +153,12 @@ static inline void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
 }
 #endif /* CONFIG_VFIO_DEBUGFS */
 
+static unsigned int vfio_pci_vga_decode_all(struct pci_dev *pdev, bool single_vga)
+{
+	return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM |
+	       VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
+}
+
 /*
  * Our VGA arbiter participation is limited since we don't know anything
  * about the device itself.  However, if the device is the only VGA device
@@ -161,16 +167,14 @@ static inline void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
  * has no way to get to it and routing can be disabled externally at the
  * bridge.
  */
-static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool single_vga)
+static unsigned int vfio_pci_vga_decode_novga(struct pci_dev *pdev, bool single_vga)
 {
-	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 	struct pci_dev *tmp = NULL;
 	unsigned char max_busnr;
 	unsigned int decodes;
 
-	if (single_vga || !vfio_vga_disabled(vdev) || pci_is_root_bus(pdev->bus))
-		return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM |
-		       VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
+	if (single_vga || pci_is_root_bus(pdev->bus))
+		return vfio_pci_vga_decode_all(pdev, single_vga);
 
 	max_busnr = pci_bus_max_busnr(pdev->bus);
 	decodes = VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
@@ -2148,20 +2138,27 @@ static void vfio_pci_vf_uninit(struct vfio_pci_core_device *vdev)
 
 static int vfio_pci_vga_init(struct vfio_pci_core_device *vdev)
 {
+	unsigned int (*set_decode)(struct pci_dev *pdev, bool single_vga);
 	struct pci_dev *pdev = vdev->pdev;
 	int ret;
 
 	if (!vfio_pci_is_vga(pdev))
 		return 0;
 
+	/* VGA access is fixed for the lifetime of this registration. */
+	if (vfio_vga_disabled(vdev))
+		set_decode = vfio_pci_vga_decode_novga;
+	else
+		set_decode = vfio_pci_vga_decode_all;
+
 	ret = aperture_remove_conflicting_pci_devices(pdev, vdev->vdev.ops->name);
 	if (ret)
 		return ret;
 
-	ret = vga_client_register(pdev, vfio_pci_set_decode);
+	ret = vga_client_register(pdev, set_decode);
 	if (ret)
 		return ret;
-	vga_set_legacy_decoding(pdev, vfio_pci_set_decode(pdev, false));
+	vga_set_legacy_decoding(pdev, set_decode(pdev, false));
 	return 0;
 }
 
