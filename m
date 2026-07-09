Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AF4499AB
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632839; cv=none; b=SJ8IE+oycuYm887Wrq1mRfG6d5+8fxm7s4VvG5EMVBTbeOBuGh3Xgt3FYToTOOhLuE+NUoTB3iQWfTKwf/4lPmgAAYQw4nEQeujgT2mVi0/Nh/cZ+Mru6VgJEFxTP5P/iS2J2kEXoDcby5ByYHlYsQoEVa6q8Vbhxu7yIswUeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632839; c=relaxed/simple;
	bh=bDY1ggdf1S3+C8UKq4n6TBAFVY1TJb00f5V4Sb1ZnNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eq5hC0oiUrK9Pu8d9cHONo2E4iI1oSra1aB8WCsfTWC0COQEW+e62wma6FmPvUe+PY6YRmsMeui1CX2CqhErubExVSYQWZHSFxB9bJtH+GNuIQJvOAFt9M7mvhV5clQ7wsii0FZUj/JhxOQd8v0xR1INo4iNTCEc0m2Xpecx5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=iPz6QY/1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ULuDYHUs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="iPz6QY/1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULuDYHUs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F23A140013E;
	Thu,  9 Jul 2026 17:33:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 17:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783632834;
	 x=1783719234; bh=RAR4gZTC/LkyD7Jqu6tan/KWZ63Btah1FaIite8ky88=; b=
	iPz6QY/1FFW0FReqBi/jqCb1+YcDPKRmwEoiycgL/d4IGm1jWpvfDS31cJj5f9o5
	zuxZnkj3lIwodt+Kph+wcvT6CRAkHubTphbZfUvNZNkT/TfMsBGcs+9Gfzp2lItx
	5WTlL0BFN06UAkspoMTEiiDd0kw+AA2mbxCoh0mt/gKNt1hzgoqgLiMB6OSS6vS5
	YEohD49Mp26+ctDiIuG3MlgDJ9PTAUe11t87Dbv0ry9aepM9NWr3XzXel9J4M1aj
	eUa2QnHI6qCocs3qeDo0Vuodej4uxy3sfhGbcX8orQD+4ha9sUcfGpZsfm0yTbLA
	cfNiOzyhYPcioT/oZyoJLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783632834; x=
	1783719234; bh=RAR4gZTC/LkyD7Jqu6tan/KWZ63Btah1FaIite8ky88=; b=U
	LuDYHUshSUz19Oz6q8ZkccdLVD0VwzCqrKLiT4uCQYm29GznX3my5VcXfuakEomx
	RW3NFij/eMx3/j2yaJs07Psi0VCCO2ThK0BAfrpjsiNvMGD0xqkzHil61yLn3Y4E
	6bdXCgI7aveFGn6FHCS7pjZqvOyfEppCmn3SkQkpRCX93BPk0wVi87dWzlp5rnHA
	N9uJCNIqC337ZY2/hl54+L11r2rBrKrrl79YZcVGQUsKurKCYIUp9M4nMk84T/NV
	7LvKfzkYVraksNvohDKe9DhbxJfZoJ5UZWBBRRSQTHUgjqLd750ssM7Q3GKRKeVC
	LZNgdVD80cZ4PmBBl8+xQ==
X-ME-Sender: <xms:whNQalSfuyIQn0fMUbl6yMDQmclBhfYVc3I8BjvxdWeERmFKSMfEAQ>
    <xme:whNQagR5GZpKkUiPFek0AeWC6gUtf0VpKxRJRniRlBU9YQkQdhOjEAoi2v9o9z_0U
    GYiW53Ld5bORFQdMwKEKhAGbkJweu2ZuU5H85yjAf2FTsLJczQx>
X-ME-Received: <xmr:whNQaq7bV7xHTKc3-D0MZckYsE4ve1KmXeyYVMS2ddoJlez1gm_89-XEpUM>
X-ME-Proxy-Cause: dmFkZTF+FqJ6YVJXjd1sT4e7cd+hteE3kqMx863xqOF0LDAAdjpdhasuKzYC5s0PY4TDOZ
    5GDYT0ZW8ZUh4XIkdM29H8tPL9o3eT6eyd/eLsI512kvh59QcbSeD8gFfW0u+1YwG7VJhe
    03N59939uYY4a27WSzDPxyf4QmK5p01Q2I+Km4sbXZA+FFptjqwDrbIC/v+/5kLdaSeyDu
    Tt9RrFiNbvZ72fSh3hrxbqyzhnZRJfTN3sxGPohOvO615mjnassrY+wE3/FTuOhu3TTYoE
    SIgK6UnSKKLW3optSLC5SGBLppx6lMVK5mUZ7scqLIQ1pSiGhGMMpZwaPruxjjqNIrEQo8
    6TONDcqMF6PP9RhlPPSp0qCjHP+0qoH+zZN2FiCFn6LQUVAlRfqYsiukXdALVDarOJ+ut1
    grpTqhU5HDAzTs0BPHvQLX4pkSW4riVqhDKVnTnOETc5r9ytbZLCNyrve1Xe78Wpg72wFb
    uvOBBckO4zgzFJgwAdOCxt82MLURHuvWUTxJ7sDuDi4ILk5YroP//1Qxk6BqWt92xouJlj
    iWhSFWwP0gZCgLQ7qDC05NLIsAsy13EDjHgTBH+DvfmyVwUHlGMeQSP1uPdk136+4Bl+Xh
    GmeybkX3tD1jKUGXm711rHdXyD0lUQSrnyTWLoMCbwginhCCWhkpgxSjy6FA
X-ME-Proxy: <xmx:whNQas02K4197W5S-htZsjS4KCvqsDeZHCUQV9qYe5DNqLkySfK4mg>
    <xmx:whNQalDL14_e9ysnt7TDSsmsOct1g8q8dkMc9G0nA6DK-uBbMlCjtA>
    <xmx:whNQanOyvOS9Kw6OUu31-WiCspkwdJO4ZAD2a3PrmKCd921TpBsblg>
    <xmx:whNQaqancnHHRSPPIVh96LSiKzJzcF-fm7UjZCMqfYIGbuj6MOVkEQ>
    <xmx:whNQald5EIfGY2q8FFOm6mhrhqyxnaUrggEJNwbd2XXkb3RKNzCVtyBk>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 17:33:53 -0400 (EDT)
Date: Thu, 9 Jul 2026 15:33:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Josh Hilke" <jrhilke@google.com>,
 kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v3 3/9] vfio: selftests: igb: Use advanced TX and RX
 descriptors
Message-ID: <20260709153352.0e98cfbe@shazbot.org>
In-Reply-To: <20260708232925.D2AE31F000E9@smtp.kernel.org>
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
	<20260708-igb_v3_b4-v3-3-1272650ca614@google.com>
	<20260708232925.D2AE31F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Jul 2026 23:29:25 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Programming `SRRCTL` with `E1000_SRRCTL_DESCTYPE_ADV_ONEBUF` overwrites the register, clearing the `BSIZEPACKET` (Receive Buffer Size) field to 0, which violates the 82576 datasheet.
> - [Medium] The commit message incorrectly claims to add new header macros and remove legacy CMD macros, but the patch contains no such header modifications.
> --
> 
> --- Patch [3]: [PATCH v3 3/9] vfio: selftests: igb: Use advanced TX and RX descriptors ---
> commit 44f58d3e0349aa95894e8741ae9ff09ee319dcae
> Author: Alex Williamson <alex.williamson@nvidia.com>
> 
> vfio: selftests: igb: Use advanced TX and RX descriptors
> 
> The submitted driver builds a partial legacy TX descriptor (just
> DTALEN | CMD_EOP) and never programs SRRCTL.DESCTYPE.  QEMU's emulated
> igb tolerates this by treating descriptors as advanced regardless of
> DESCTYPE, but real 82576 hardware does not.
> 
> [ ... ]
> 
> >     Remove the legacy CMD macros (IGB_TXD_CMD_EOP, IGB_TXD_CMD_IFCS,
> >     IGB_TXD_CMD_RS, IGB_TXD_CMD_SHIFT, IGB_TXD_CMD_LEGACY_FORMAT) that
> >     become unused, and add the SRRCTL register offset, DESCTYPE encoding,
> >     and advanced TX descriptor field macros.  
> 
> [Severity: Medium]
> Does the patch actually include these macro changes?
> 
> The commit message claims to remove legacy CMD macros and add new ones, but
> there are no header modifications in the diff.

Entire paragraph is stale after including E1000 headers, drop.
 
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > index 58c6aceea63a9..f4f6d2ee262da 100644
> > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > @@ -235,6 +235,17 @@ static void igb_init(struct vfio_pci_device *device)
> >  	igb_write32(igb, E1000_RDLEN(0), RING_SIZE * sizeof(struct igb_rx_desc));
> >  	igb_write32(igb, E1000_RDH(0), 0);
> >  	igb_write32(igb, E1000_RDT(0), 0);
> > +
> > +	/*
> > +	 * Select the advanced one-buffer descriptor format.  Per 82576
> > +	 * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to a
> > +	 * value other than 000b for the 82576 to write back the special
> > +	 * descriptors."  struct igb_rx_desc matches the advanced one-buffer
> > +	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
> > +	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
> > +	 */
> > +	igb_write32(igb, E1000_SRRCTL(0), E1000_SRRCTL_DESCTYPE_ADV_ONEBUF);  
> 
> [Severity: Medium]
> Will this overwrite the SRRCTL register and clear the BSIZEPACKET field to 0?
> 
> By clearing BSIZEPACKET (bits 6:0 of SRRCTL), real 82576 hardware may see a
> 0-byte receive buffer and truncate or drop received packets, causing the test
> to fail on hardware.

Same false positive as flagged and rebutted[1] last time.  If we
extrapolate that a human reviewer might have the same confusion, it
might be worth expanding this comment to include:

  +      *
  +      * The direct write also zeroes SRRCTL.BSIZEPACKET, which is           
  +      * intentional: per section 7.1.3.1 a zero BSIZEPACKET falls back to   
  +      * the RCTL.BSIZE buffer size, whose reset default (00b) is 2048       
  +      * bytes -- ample for the loopback frames here.

Thanks,
Alex

[1]https://lore.kernel.org/all/20260529142439.5bd03e5f@nvidia.com/

