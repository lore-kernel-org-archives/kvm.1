Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A81B7910
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637958; cv=none; b=Gfys5zaCyRTAJV+buuUtmoqE4hH8yzKZJhFlLWlTk6msHZ8Bi6QAnL7ZBy3mL4F22QN8duS+hNIUVExO2hEVYxwW7Oi5He2sHOjxuAzEwv9Ue6dB6RAIIAfk7WNt8XtHfN8T5bVJ6NxXNJrfcJrRqjJoo3Obn4z6KXZs2UOGW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637958; c=relaxed/simple;
	bh=63TwnTVP6l2jIkd9Wi3upGC5v0gLJqyNzNqWN6WuTEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e35kvA2yK+oeZ4BgJy9Kw3Gq5L70MDkxhtabCmIqMrvxb1XYizB4siG/4Q13NSVPUUasyptQMjcVyoq9TSJbRaYSqB8fX3pbpK2Pz5PLAwtHom/shhrosB3PSNAoRDOpAZmxYxup4Daw0m7C/Gt3AU6H8rLMyhXQp49KuXUCwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=dGbFZ4lF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AC0xBbVM; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="dGbFZ4lF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AC0xBbVM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 80ACCEC0189;
	Thu,  9 Jul 2026 18:59:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 18:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783637955;
	 x=1783724355; bh=FZCDsNIXPKrzfAxORBm5mfTxW9Xy1PMDTusoVd6BlCE=; b=
	dGbFZ4lFHL6pXl+v24U9VCXpbnQEijTRqZqOFQeWmb9n4XAL2h+eXBgZ1aVFg0Af
	uMEmlWKInHQwZcCv60I6QzR1LwhuUZY7hEqN5ed8RPPAyyB++ikw/PdQz0TONSG+
	erjC8tgGwNw6eByEX15ColyJXqDQhRSdNYv+G6XKwUcNMWWrrtzPMZzs/t08Vydf
	Idig3PvzxDX+p7ZluJU2NLS6H0evHRIHUYePsrTE/57gU8DnY2AQ1smOaX9EZcGb
	Xpa3FFMWgjBjqs7SDgEyaDBUlvuUubUOtD6NS6/P//14mugLTkzZxjfB6bTnY50d
	i2tFGamJNnoKRaIid0lVlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783637955; x=
	1783724355; bh=FZCDsNIXPKrzfAxORBm5mfTxW9Xy1PMDTusoVd6BlCE=; b=A
	C0xBbVMef4sdaRZ2QU9bosA066vHCogbLAXQordra4njWNWPdES8A1ffcDJQ+CvN
	m51G/DLIrdIbG3u93vTmkljU88RXH16dftjNQl/UffdOLqTloHawPTpHWRD7NlNc
	nvUamTThJkxpAtNzeTY5ArVDKcHXpaa43atXmQ6BdTuj9vHdbeG2DdWsv43T50/R
	UwFFKbL/Q4nBvhGipKv0J22l0kk2Vt2n2cMOmy/tnP6pFSsbPBkZGbcUYmFBPjX1
	C6ALQZmHsT6CQ8Y2X2Wpq3Lf82tdnt5B272CNdZr8LYrh5WKKWzoxTfwZMturc2Q
	10NNoIy2Cisvgctt5aCBA==
X-ME-Sender: <xms:wydQavJi0dHLLkyVaR9ACiQFnQeT1qwUraeN-7t9OcACsIxtjaDjRw>
    <xme:wydQakq3xQ1-NSFJO5f78C_s04LoH7Qi1jnBDBlkeGW-1si6JMeuyuvYHzRGti17m
    TNGLzzyfnRkXZ30n7EEcjWGaMnqkq0YiJa3T2FxS403Rt2Q7ngsIw>
X-ME-Received: <xmr:wydQanxDKdly5ELjXILMBqkei_ajlBPA6-wdU21qIOuYwUXOeNa8C24gtt4>
X-ME-Proxy-Cause: dmFkZTGaFekSOOIdJUZP0c6+OVVyumAoamaV7n5ICD3plcDVzbFPMMbZLcQDN9JyPN+EoC
    dHBY/B0S+d6fPxiMovnnozConHaWks7rxyCjvm/vHZQOZwMOoNrWo2zgbISYSSQTk/TudC
    KJSz6Z0DmJ+0NjLAMcvjRBy6IEbHBaTiLrPdGXgHPGQiGl47prL56MYH0mEQzoPVtmebCy
    qs4cHiJehHLrzCdN1/EPHAUYDtIwXcyqNYf2l9CgghD6mpA4UQOUuik7Ondzyus+sLnBdL
    n3gZ2EGxvw6gGRmNsXlEYTeQ41/dvFcoVcPyTZ9QWuGelbnwqKb9IrhilZQtEvrgF4egsz
    bo0mYsPZ+ZAyrgiPqdwKl3zp6hb6Srsa4tpDSCBETm9WWNNkT4cAEaP3DRNXVBm/HzFWvh
    xJqXxVFr/lYA83InIRaqAOYG0qFzeSE7cJo2d+cfAcwl6LxeKSUfiNXZzBTjSRzgfFFzBY
    t31RQ145Di/fYnbXWJ7TTfjqRdBG0ahz7g81m+GWdIa9ixltLYjj3Ymv5tJUs6Hj+BzHYZ
    aL3v7BnczSev1ly+eGEPaQf/VgHJltkp0aFy6dHJuJmXyVagRuxd+R+S1PqL376dMzKpOR
    fEU21qcKqYtE5BC4v5w5GmBJszdj73o1a/9xCNR5upkTTFDeJ2ZSeOXq1mVg
X-ME-Proxy: <xmx:wydQaoN9f0v-BkBbVfo2by0HcBQtsNKy_YhRRcV4x4BqNnagaOVMqA>
    <xmx:wydQas5qCVVD7jUAEcbgBYj6HsRSjZxkUqX16d_fYoBe84DYJsuIaQ>
    <xmx:wydQahnPULyZejDL-bIX2RTVakd2Kt9U0bAmFu5VbuWVKtL5pwL48A>
    <xmx:wydQalT-R6rfd7qCbxZXVvkug_1Z8wJZ9ADYc5VpF_KxoeS8qaYRfQ>
    <xmx:wydQahVNHTmbTvyUjQkLMxmLPMMaN1MzWjAnMWX_9Cjz3H4RzfT1XwCd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 18:59:14 -0400 (EDT)
Date: Thu, 9 Jul 2026 16:59:13 -0600
From: Alex Williamson <alex@shazbot.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Josh Hilke" <jrhilke@google.com>,
 kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v3 6/9] vfio: selftests: igb: Disable PCIe completion
 timeout retries
Message-ID: <20260709165913.422fd951@shazbot.org>
In-Reply-To: <20260708233123.F2EEC1F000E9@smtp.kernel.org>
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
	<20260708-igb_v3_b4-v3-6-1272650ca614@google.com>
	<20260708233123.F2EEC1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Jul 2026 23:31:23 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Missing SW/FW synchronization semaphore when accessing PHY registers via MDIO.
> - [Medium] Missing DMA read memory barrier (dma_rmb) after descriptor completion polling.
> --
> 
> --- Patch [6]: [PATCH v3 6/9] vfio: selftests: igb: Disable PCIe completion timeout retries ---
> commit b47012b45a463be841715f383fb27408df2c020e
> Author: Alex Williamson <alex.williamson@nvidia.com>
> 
> vfio: selftests: igb: Disable PCIe completion timeout retries
> 
> The mix_and_match test intentionally submits TX descriptors with an
> unmapped source IOVA so that the DMA read fails.  By default the 82576
> re-sends the request after a PCIe completion timeout (datasheet section
> 8.6.1, GCR.Completion_Timeout_Resend, bit 16, initial value 1b).  On
> real hardware this turns a single fault into a stream of retried reads,
> keeping PCIe AER and IOMMU error handling busy and interfering with
> reset recovery.
>     
> Clear GCR.Completion_Timeout_Resend during device initialization so a
> failed read fails once and stays failed.
> 
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > index 1848be6cd46c9..a7a30660b23ed 100644
> > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > @@ -219,6 +219,18 @@ static void igb_init(struct vfio_pci_device *device)
> >  		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
> >  	}
> >  
> > +	/*
> > +	 * Disable DMA re-send on PCIe completion timeout (82576 datasheet
> > +	 * section 8.6.1, GCR.Completion_Timeout_Resend, bit 16).  The
> > +	 * mix_and_match test intentionally submits descriptors targeting
> > +	 * unmapped IOVAs; with the default (set) value, the device keeps
> > +	 * retrying the failed read indefinitely, which keeps PCIe AER and
> > +	 * IOMMU error handling busy and interferes with reset recovery.
> > +	 */
> > +	ctrl = igb_read32(igb, E1000_GCR);
> > +	ctrl &= ~E1000_GCR_CMPL_TMOUT_RESEND;
> > +	igb_write32(igb, E1000_GCR, ctrl);
> > +
> >  	/* Configure PHY internal loopback for testing. */
> >  	igb_setup_loopback(igb);  
> 
> [Severity: Medium]
> Does writing directly to the MDIC register on real 82576 hardware risk
> colliding with the firmware or BMC management engine?
> 
> When running tests on physical devices, accessing PHY registers without
> acquiring the E1000_SW_FW_SYNC semaphore can cause corrupted MDIO
> transactions or hardware hangs.  For example, in igb_write_phy():
> 
> 	mdic = (((u32)data) |
> 		(offset << E1000_MDIC_REG_SHIFT) |
> 		(1 << E1000_MDIC_PHY_SHIFT) |
> 		E1000_MDIC_OP_WRITE);
> 
> 	igb_write32(igb, E1000_MDIC, mdic);

Technically yes, but it's non-trivial and we assume an isolated
environment.  I test on a plugin dual-port NIC, potentially an
integrated NIC with manageability on the platform might encounter
something like this, but it's a narrow window that's probably
acceptable for a selftest driver.  We could add the following above
igb_write_phy() to note the deferral:

+/*
+ * Write a PHY register over MDIO.
+ *
+ * A production driver would hold the SW/FW semaphore (SWSM.SWESMBI + the
+ * SW_FW_SYNC PHY bit) across the MDIO transaction to serialize against the
+ * device's management firmware.  The selftest owns the assigned function
+ * exclusively on a dedicated test device with no active manageability
+ * contending for the PHY, so the sync is omitted; it should be added here
+ * if this ever needs to run on a manageability-enabled NIC.
+ */

> [Severity: Medium]
> Can the CPU speculatively read the destination DMA buffer before the hardware
> descriptor writeback is architecturally complete?
> 
> In igb_memcpy_wait(), the code polls the status bit via READ_ONCE() but
> returns without issuing a dma_rmb():
> 
> 		status = le32_to_cpu(READ_ONCE(rx->wb.status_error));
> 		if (status & 1)
> 			break;
> 		usleep(1000);
> 	}
> 
> 	igb_irq_clear(igb);
> 
> On weakly-ordered architectures like ARM64, the test runner's subsequent
> memcmp() reads on the DMA destination buffer could be speculatively
> reordered before the loop's status poll finishes, resulting in stale
> data reads and sporadic test failures.

igb_memcpy_wait() is implemented in patch 1, and could indeed make use
of an rmb().  This function changes through the series, created in 1,
touched in 5 and 9.  Before we get here we could include
<asm/barrier.h> and call rmb() just before return 0;

Re-tested all the suggested code changes, reorder in igb_hw_init() and
rmb() in igb_memcpy_wait() against physical 82576 NIC, 35/35 pass.
Thanks,

Alex
