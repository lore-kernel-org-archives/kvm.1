Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354747;
	b=HU7Cu9hMy0+FnocnfamiINuck+6HpYdyjYgx8H8HE4WhyIA+je0XJtJCK8DuAQmH5An1
	 Z2Xnaj9MF8O3sQDEzGf15Sk9zXy4893kD4JvfcSK0PHwn6/2bli9VgWxioqJvaYF6H05w
	 ycaTKKnIcsHAk4QiEY6L60dejR0OsHAVNL4N8dYPZSryootnxWKXDLvftxoXKgMrt+u11
	 7GsUPaaUOO0QIBqDyWxjmqYBC8BSM1IpOgT+fg65URh+0aPvWC7W4QK5TdDKkzEoU1wCa
	 D7WUGr9tioCkw/zPtxVynq6PhrQaZlp7Vwa3lv4vbKA1VJ28TgUL5LcRUYD4k6T2QHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354747;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lpQllkDtrs6UdHQ1+/aBUgWIM9h8St8lEUek1falYhg=;
	b=jGBiR4cRrwFqYi665+8lbctAcAHSh5/oQeYE8QPgiU62NhaJaAD28cMuobQf+mNnx0uQ
	 6c3jntvUmFQp927rI5NQHejou8DJgLHsSdwxy2upt5Cb8IAOeTfpaWQCBITJXngS1ZB2M
	 cF0mmhrI/9eo6an2df1f+hjnm0rMkayqXuXT3jjHH8iHAyBUwo/fOmrhE9BR3rEUVFd6F
	 3TeGJfRusOHzgoF5tXjG330P+VRn9dIxJOCv+CLWY+RMiT2sY9kAVQrAtNOCzmui1L34l
	 k+jLT/BWeHdi5BR4hAbMOzb0w5Ien/AlxwFxA1Hd1pnhjez03unW/614WFJSxnowUlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=SUmWBA78;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XmHwMl1Z;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA277606A327
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 23:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA277606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=SUmWBA78;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XmHwMl1Z
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F1BC4EC049D
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 18:52:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 18:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794354744;
	 x=1794441144; bh=lpQllkDtrs6UdHQ1+/aBUgWIM9h8St8lEUek1falYhg=; b=
	SUmWBA78pzXq+RAdDwEFSHRIqqPZ0/Yviw7rEc8CG0Y829bYO2Yvwe4y/3WRQFdE
	82rGSJ6LP8E0zSehFhpXwL9L1vCkIAYIzyLgMqK8rpRhiweZ2lBQfGqogi5S7WXa
	sdBzNjrpQo6VZS2kmhN7EEkTGn6oY9IsWMUkBD2ziIn8bU+EYLN0KRcOF82LLbX4
	3dVTEQpWxp5N7rrsyA/PvlFmYlsKvl0oBBYU+f/JJwwyEv5UHmRV8kWC+iNTp/MA
	5h+wIrV8JELtObUdpa63vnktYgg+tucqtSGsVEOM0q4YTRTDcKEFbrKAWBd4NFiV
	RHyo9e4K9iGlkgpMOdGL/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794354744; x=
	1794441144; bh=lpQllkDtrs6UdHQ1+/aBUgWIM9h8St8lEUek1falYhg=; b=X
	mHwMl1ZCFgJbz+CCC7tvvHPOPy5RXxeXKsyVKr+QVYEv5b5KliYYuFRZD5brBs/B
	9Q9dtzyoLGIGzenn7RIB2DQhcEhLt+pbYOMiqsG9mUaLoCltvTmzU9ngOgrYj+kl
	CVUwm9Ahi6ivwbnvICuKXW+oL4VjYeE1WBE6T2EHFTZRleAaxQtbUS1NjC3fTTcr
	R57sBv8cn2gz3jgbwO0cqCHfRea5Q/ZmQ3A0Qv4BJzEXW5TGt2um55ZwYsJ1IdJf
	e3QK5VICuTUH20QwjZCbeddFehZmrl5jlbfZHn/P/2QAAa6EhU1YPyjO4isNmN+P
	d8kvuGpK8hveyskclXVCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794354744; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JXCwuHw/xH9lpdd+7+QcnA4J9yacV6Y/1UaVjryZGqZabS8
	wS9gBmOB0p+n2NHGeIRcuQVdo+XDl3+3/maft4a6gQC/J8C2MOOVg10bld0/Hb8m
	ZORzkZXtNqnATXmYp//9aWjGOMzDF/ovRaMMZU6pKtOScepwAmgjvmLwBRxDgCC+
	DqlUxkOoTx21eQOZx2Tc+S/0xy3zSHqxpyU2dvoPWdzGFQbWK9q/KllHNqzFldml
	gR4jICUDDUuozltINJ6KbPYRC9i4LEQlVNhISv7olscPcX28g0LOGDz8CY2PFJN2
	y4dWsyaB1aIgmFmPtLWr52QwqXrd1T/EIOQqxYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pZBh9oTa5KL9QQgPS9BP3OfEq92KND9TQJ74QqOhrnc=:fZ91BEP981QEjv2fnK4WJ+Lp3RZm87OtN0fTGdxkaLs=;
X-ME-Sender: <xms:OK7zaswEZwLetN31YyX0d0b_g-NgrIT8MVO9cMLkEyhWgofn9qW_UA>
    <xme:OK7zantKDpqIuHdreDgbbLv-XpjwDuTrM_Vxk98Y2-jeouUBK9erM3EkH-u8xLQ5q
    SzRmpdWlGWIRv1FRwRYuOFVHr203oBOC1p6NHlphLxuScGNBMJQT3A>
X-ME-Received: <xmr:OK7zartA4vagw5Y-tyYLdu07oMN0rlN8ZGP8bEhC0jzn2QPzYjc5AgZjmjhwIA>
X-ME-Proxy-Cause: dmFkZTGgNCkT1iTmDKFVZqPOJ1Xr6d/desjN71h8FhvToPwUY+1s13KXsl32/cXNnsgBXs
    hrPRNplkkG7R6+Ar9lWxTHTEKmRKy80n10Y2PgFWDNeoUPCoNTLNULBHDhkOkn31H7A7Ic
    qtViRzs+Hf3wlG42JJajQy6Gis6OcZogqbFBR5bGiiawJ+k7r/JTg/Y5C6M4nBCGt68MeI
    lFhTphStHKTgvakCbjc3B0JYYbOhBirDnpjbYF4Axu+KM547q5TrFsXVrJmaBDCV7kwlst
    INg5wGJ4PssB/8eVC7d1pRaN4Q9ZmgMbPcFc/2vgNQ/T4V/LHZioadY6v9HkgNxqNPNdPM
    khmHrCIDfqhNTTuWGP1LhO2gV49aLwabbaxjCnyOI33nJV/pg9jjv5hyl+9jfXlATAjqDt
    snql6VBjS/ORr8zZ9+QFSm+V3uzkcVQU7kd/CjSMVlULdDwJJv2x6i99N8NrC0CfONS0LV
    XI6FAsU5D9kul1/lz29dzswj6diZ25NJLJsUBC/Cx8UvSji9O7nm4M3yo7PCLom/TgzXbk
    0WVkfmTGLWQrIm/0UKeEBOQ+4eAEVwzOkvMv27P3Fozt0+FaBVNvhKMDjlI/Ru0po8rkEa
    KNeqASy3AxAVgpH9lbsLz5PoBoECFvPV19zRGhVxaYJKZZpwsKHfFZa152tg
X-ME-Proxy: <xmx:OK7zakMVrCPr-2c29zb32HvEUGEKz42SrIw5vmuVTnsSSIOH3gqCwA>
    <xmx:OK7zah27hOmO9MnhP0WvTy4qadghOEfQRoUM1URMFt_jrRqcRDbj7A>
    <xmx:OK7zaoM67Vx1RgKC3qGA5ls0CsGY3vcOynpbOa_Dvfchorqb2Zy_pw>
    <xmx:OK7zap2lKqzxN518NQzEl_AaE444shJ6lQvVI6A5cwKe1CUOo5eRwQ>
    <xmx:OK7zauU43OzyimQFaeBp1bw2xcHkOFc3WtUKWXSRGvUtDmqm-E8aIUzg>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 18:52:24 -0500 (EST)
Date: Tue, 10 Nov 2026 16:52:21 -0700
From: Alex Williamson <alex@shazbot.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2 1/2] vfio/pci: fall back to platform ROM when
 pci_map_rom() fails
Message-ID: <20261110165221.7fb75f91@shazbot.org>
In-Reply-To: <c5d91752c7bbd40d89f5fce5da8582f1673cdfc3.1792566536.git.mst@redhat.com>
References: <c5d91752c7bbd40d89f5fce5da8582f1673cdfc3.1792566536.git.mst@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 04:20:32 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> When pci_resource_start() returns non-zero but pci_map_rom() fails
> (ROM BAR exists but content is unreadable), the pdev->rom fallback
> is unreachable because it's behind an else-if that only triggers
> when pci_resource_start() is zero.
> 
> Try pdev->rom whenever the ROM BAR didn't produce a mapping, in both
> the region info ioctl and the read path.

Here's the crazy thing, users actually update firmware through
vfio-pci.  Therefore, what's an invalid ROM image on one check, may be
a valid ROM image next round.  If we fall through to a different ROM
provider, we might actually be presenting a changing view of the
device.

I believe this is why we intentionally always report the physical ROM
BAR when present and mapped, regardless of the contents.

QEMU, of course, has the ability to take the ROM as a file and override
whatever is provided through the kernel interface.  This is how I had
previously made use of a secondary GPU on a laptop, dumping the ACPI
ROM to a file to provide directly to QEMU.

Does your GPU support a ROM BAR?  The v1 patch didn't have this and
would have exposed the physical RAM BAR if present, so I'm guessing not.
Thanks,

Alex

 
> Fixes: e021e6cbfb5a ("vfio/pci: Expose setup ROM at ROM bar when needed")
> Cc: Yunxiang Li <Yunxiang.Li@amd.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Notes (changelog):
>     v1->v2:
>         bound reads by the ROM image rather than the BAR once the
>         pdev->rom fallback is selected, so reads match the reported
>         region size (a pread spanning the image used to fail with
>         -EINVAL past the BAR size)
>         add Fixes: tag
> 
>  drivers/vfio/pci/vfio_pci_core.c |  4 +++-
>  drivers/vfio/pci/vfio_pci_rdwr.c | 32 ++++++++++++++++++++++++--------
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 050e7542952e..630474d03e3b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1128,7 +1128,9 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
>  				pci_unmap_rom(pdev, io);
>  			}
>  			vfio_pci_memory_unlock_and_restore(vdev, cmd);
> -		} else if (pdev->rom && pdev->romlen) {
> +		}
> +
> +		if (!info->size && pdev->rom && pdev->romlen) {
>  			info->flags = VFIO_REGION_INFO_FLAG_READ;
>  			/* Report BAR size as power of two. */
>  			info->size = roundup_pow_of_two(pdev->romlen);
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 3bfbb879a005..6e47d529cbb9 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -219,7 +219,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  	int bar = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
>  	size_t x_start = 0, x_end = 0;
>  	resource_size_t end;
> -	void __iomem *io;
> +	void __iomem *io = NULL;
> +	bool rom_is_mapped = false;
>  	struct resource *res = &vdev->pdev->resource[bar];
>  	ssize_t done;
>  	enum vfio_pci_io_width max_width = VFIO_PCI_IO_WIDTH_8;
> @@ -231,11 +232,6 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  	else
>  		return -EINVAL;
>  
> -	if (pos >= end)
> -		return -EINVAL;
> -
> -	count = min(count, (size_t)(end - pos));
> -
>  	if (bar == PCI_ROM_RESOURCE) {
>  		/*
>  		 * The ROM can fill less space than the BAR, so we start the
> @@ -244,10 +240,30 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  		 */
>  		if (pci_resource_start(pdev, bar)) {
>  			io = pci_map_rom(pdev, &x_start);
> -		} else {
> +			if (io)
> +				rom_is_mapped = true;
> +		}
> +
> +		/*
> +		 * The BAR can also exist but be unreadable, e.g. on a GPU
> +		 * that was never POSTed.  Fall back to the ROM image stashed
> +		 * by the boot loader; the region then follows the image size
> +		 * rather than the BAR, so bound the access only after the
> +		 * source of the ROM content is known.
> +		 */
> +		if (!io && pdev->rom && pdev->romlen) {
> +			end = roundup_pow_of_two(pdev->romlen);
>  			io = ioremap(pdev->rom, pdev->romlen);
>  			x_start = pdev->romlen;
>  		}
> +	}
> +
> +	if (pos >= end)
> +		return -EINVAL;
> +
> +	count = min(count, (size_t)(end - pos));
> +
> +	if (bar == PCI_ROM_RESOURCE) {
>  		if (!io)
>  			return -ENOMEM;
>  		x_end = end;
> @@ -283,7 +299,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  		*ppos += done;
>  
>  	if (bar == PCI_ROM_RESOURCE) {
> -		if (pci_resource_start(pdev, bar))
> +		if (rom_is_mapped)
>  			pci_unmap_rom(pdev, io);
>  		else
>  			iounmap(io);

