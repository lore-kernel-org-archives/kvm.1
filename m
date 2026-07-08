Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBC371D0A
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553367; cv=none; b=RRPfmGZiPncIEvNrLb2u/zb/osOTSiGelWER0ByDmQln+kbhqP5+JEK2wx8ifXBjsATy+UJpCR39Zj7zDqGQeDotite2r3Bh0/vBUF76I6PXk8CUNXiOr+9NpkBnxXCavDxNJRm33brrJUzNF7da/LLaa8f9ykMCswl4B3za99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553367; c=relaxed/simple;
	bh=FoWFV/ESypQleioB7lSKdXx9xCJSUNSNcThiSz0Nbn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DnbbgQMuwcJ5hpLUiXK+b6kJmyA2tF7GdH1KcSJ7vp+4k0lP0N+hbFLP+FeYiw5jYirm+Yh8Em2eGqZjh9SRjQLw5ek/bnb1xFaEd8i2kJkNl0ziq1L0TLb3iwIerS0CfCaFYN+wmHEO2Nu1xUBHKO+78iSCKVosvMTFPlqo8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmmeO78L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmmeO78L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AE31F000E9;
	Wed,  8 Jul 2026 23:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783553366;
	bh=o8gl1ODASfWDzHs84FiRaRj9XEiH80mxMy/nUjGK/Lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JmmeO78LZMjcec5jr2TSUTkma8UrePJQNAwJsFO9gkrK5x5jUY4SIsPZiSdjm2AUb
	 1ANS+eNuyUx8tdiDFxtie7tj3g+MdpZNP+VPuPjyqK2QfAn7yqJposH+5g/5pvQVV7
	 whwNiMUmsBoYdw71+YV3+jPzIDDPbASRjNwA8WNdO54JHMXzotWVKl0Aj/rBUSCUiZ
	 GjsOgDyuLUowEp9N/1sZ0ZIugwxQchCoj11vecycdbyx0C8uhvKwX6xRQg6/TdQyuA
	 zTMqrFmQvm9wEgkD8eXFbP05A1aXtdmPg77RdyUm/pwGMApeis0urUrqSd8tsQBIc/
	 f61e0GkThxVPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] vfio: selftests: igb: Use advanced TX and RX
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708-igb_v3_b4-v3-3-1272650ca614@google.com>
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-3-1272650ca614@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 23:29:25 +0000
Message-Id: <20260708232925.D2AE31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Programming `SRRCTL` with `E1000_SRRCTL_DESCTYPE_ADV_ONEBUF` ove=
rwrites the register, clearing the `BSIZEPACKET` (Receive Buffer Size) fiel=
d to 0, which violates the 82576 datasheet.
- [Medium] The commit message incorrectly claims to add new header macros a=
nd remove legacy CMD macros, but the patch contains no such header modifica=
tions.
--

--- Patch [3]: [PATCH v3 3/9] vfio: selftests: igb: Use advanced TX and RX =
descriptors ---
commit 44f58d3e0349aa95894e8741ae9ff09ee319dcae
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio: selftests: igb: Use advanced TX and RX descriptors

The submitted driver builds a partial legacy TX descriptor (just
DTALEN | CMD_EOP) and never programs SRRCTL.DESCTYPE.  QEMU's emulated
igb tolerates this by treating descriptors as advanced regardless of
DESCTYPE, but real 82576 hardware does not.

[ ... ]

>     Remove the legacy CMD macros (IGB_TXD_CMD_EOP, IGB_TXD_CMD_IFCS,
>     IGB_TXD_CMD_RS, IGB_TXD_CMD_SHIFT, IGB_TXD_CMD_LEGACY_FORMAT) that
>     become unused, and add the SRRCTL register offset, DESCTYPE encoding,
>     and advanced TX descriptor field macros.

[Severity: Medium]
Does the patch actually include these macro changes?

The commit message claims to remove legacy CMD macros and add new ones, but
there are no header modifications in the diff.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> index 58c6aceea63a9..f4f6d2ee262da 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> @@ -235,6 +235,17 @@ static void igb_init(struct vfio_pci_device *device)
>  	igb_write32(igb, E1000_RDLEN(0), RING_SIZE * sizeof(struct igb_rx_desc)=
);
>  	igb_write32(igb, E1000_RDH(0), 0);
>  	igb_write32(igb, E1000_RDT(0), 0);
> +
> +	/*
> +	 * Select the advanced one-buffer descriptor format.  Per 82576
> +	 * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to a
> +	 * value other than 000b for the 82576 to write back the special
> +	 * descriptors."  struct igb_rx_desc matches the advanced one-buffer
> +	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
> +	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
> +	 */
> +	igb_write32(igb, E1000_SRRCTL(0), E1000_SRRCTL_DESCTYPE_ADV_ONEBUF);

[Severity: Medium]
Will this overwrite the SRRCTL register and clear the BSIZEPACKET field to =
0?

By clearing BSIZEPACKET (bits 6:0 of SRRCTL), real 82576 hardware may see a
0-byte receive buffer and truncate or drop received packets, causing the te=
st
to fail on hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-igb_v3_b4-=
v3-0-1272650ca614@google.com?part=3D3
