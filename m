Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43610340418;
	Fri, 17 Jul 2026 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303042; cv=none; b=Of7xhbSl3xNmXzOU7pDE2ZimYbNISSfg7OlcDRjKOwXe55YaiRi014yE2t22/ksQefzuzAsecEDqJRmmU8pgYzkweXAo8dGg3QpIsyKx8SmHdmnihNmmxL2nfpdKAKLclNGdOsjV9d+qmDcLfRewO2W8CSRUCvHWRLGHIu3kJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303042; c=relaxed/simple;
	bh=zYODuyEjX4ilUgJU4XAZaBYBqVFjMGi0Zxbd++ZgKMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOXz87Mo6HaUPsEoHyn49EF5VhA0fFMSBZ1fT3WFFj5RJbvsaGSsGFX1IDJOpvOWKBCN187uPAmLMBNcj3LU38S9RMjPc8bwWKrsn2geT5Mo++yIq0fnOlFT73OBRaC0QaAhP1jyIEuOTJ7ilVKlw5h7Qms9hu8P5UHRCmWYn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=cJY65GoD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lngmUxUB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="cJY65GoD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lngmUxUB"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 83F35EC01CD;
	Fri, 17 Jul 2026 11:43:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 17 Jul 2026 11:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784303039;
	 x=1784389439; bh=VrE9Md+hukjYgsf0FP2zBuXtupXtyZtzL+Oi8Un9PXw=; b=
	cJY65GoDz/kYCMT/ocbWKSwvF97Fw5BIFp6RhXLLSOgiNNxyhBjZQvqmiBG0YtyF
	9tPBBIYLo5ZNtWem1RBsQ5ttp79xoktUMZWJq/0E12qIjMMxf2iW1Lh6O1kLymDx
	9MSaM8wKkotg3iqbjYyLbg+nFaglyK6rsyf4U5B1Z6etBVc2GnAiGm3uVqNml85+
	g8XddFgg4jMX+gV2Zqr6SFx6Wqifh2HRUBO7pkXxjvJp6kMV+VatpN64VV0KHs7C
	WuVKJ0811XpwZJs3bD0MdpvpngCzmTY2io4y93ajBLRy7GuUR+IEiG0zqnco7u3n
	Pg1BDGDiVLtSD3tTkeIikQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784303039; x=
	1784389439; bh=VrE9Md+hukjYgsf0FP2zBuXtupXtyZtzL+Oi8Un9PXw=; b=l
	ngmUxUBdXjPpwR9pSBL/0tRiHrzDVSJASZAaOcrFMFB4qesp+BJYf2g7x0pV786Y
	vw3lLCT3XrJEc8Fx7cyrf7TQrp5+HNlRp/i35A8HMBTGK78yVWs/ouSvAC8FmVVb
	989vbJETQh1PkHt2BcBKJGib9+V4cNv32YOmDzT+jLclZagudP0TCae4ZIK/diLp
	VqEO9ioxAYIwm+EkYDwGEKDuQnRQ1o/qQcMNTIB0UyBYMvua2z2Qvp9Fc5XG/I+C
	Q44dkrUXzr9bY9UPqGmUhu6yzMJX4+wgbVsNkd88qDgycGmHz8rwnoaVD3dGods6
	Bya+6qa+LtHXPkpu6/Sxg==
X-ME-Sender: <xms:v01aar0qBLAPLHsDR1V3WbyYPHjEr4sBkBdu44clF13cqAtIEHPdQg>
    <xme:v01aaqxuF4vpaesL1afwV5p8uZ8nvAGxawb6q6__DvzrqTj4liZ6EQBriQH2KF7P-
    joZE1LBI0yX_H39ok86NsK7_Mx2nAcM3qgn1x01-mPGwJ5o4YKfhA>
X-ME-Received: <xmr:v01aaqF7rbxJNf634qXEVMnqzqBpUmtMCWBIK3mzlHHTirfMKIcPfKV9JzY>
X-ME-Proxy-Cause: dmFkZTGJPrM1ZA0P3oqGB4pwDelONYjrt05MSyN+05BnQj+niPIYkTRIfoBt01qkEEs2IS
    +VOYTCbxWYbref7Y5OwCcKLtGpnErjsYgrDqhq8wL7i6vIiPKYoEwR08d9EMtHViur5ZNk
    MACWVpqNf8vf4LAaqeiJDSvGJ/r+o1lS03yglDS61LnPgQzTO/kUXRKJYBz676tk8kWf7W
    lAotdU323yVwMU4YH3+nX290q1JFmGOo2/PudsSgCGflPpbq6t1SR8+AorAv1Ou2lXcY6z
    qnY1EAuTXamCpMGlLZAxI+PHlWmytE3R0nv94Tahnwqn51FV1hLfJ4SoMDLHnS/+hHaTBN
    FjFLwiJB7aXp3zaa1UmV+GQgtetuuJulUN71k7YD/kFTAqmKVYhepX6vFM4arM797JVtv8
    w0VUtR/Z9m4g7BrBiMz5NF5gMTQX62ScqHdWa2iDbkbxwo/vgp73ep9//E9Yw8/52J/uNg
    5QWBNNGcUl6cgwL2FNpM1tOavrPmdZUxajopIOKl0ABeSkRyJnbYZQ7U+xetiTH3O9+cAW
    458U3kVLbCAXiE5b4yXATLOcG25Mejgnoq4fFkMFmZk3xkkQyzRhNq+M5sLDkkZNvr4odE
    +Ad3b1/TTUEaD6TTRO6/dk82kFnAyiS3lK/7h5nyxwM2msedm7qkb5dt57cg
X-ME-Proxy: <xmx:v01aalapqRts1T4KFlTv1tQwMEmBLuxxXFJnv3LaNa-TyMg28rflfw>
    <xmx:v01aakC5gliw961OzOEQx4n5NuxqbX2W8k77gcf_oKxe5nV5nkCOfQ>
    <xmx:v01aallbgfdSLmQpaFXMqrLWAKuagwIC-E9dKAggfn3-GiLAyg9mrg>
    <xmx:v01aatyYvpHTQFVqzl3txMZkjeUHCDLv6JKaXnBcP1JxSfnoJ3LxKA>
    <xmx:v01aap0ScdeEkBrP2a05s0Nb4ChXc1aNjtCmFP6eLm2g_92SywFDVf8n>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 11:43:58 -0400 (EDT)
Date: Fri, 17 Jul 2026 09:43:57 -0600
From: Alex Williamson <alex@shazbot.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Auger
 <eric.auger@redhat.com>, Li Qiang <liq3ea@gmail.com>, Weiming Shi
 <bestswngs@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: clear vdev->msi_perm after freeing it on init
 failure
Message-ID: <20260717094357.00a6ec0b@shazbot.org>
In-Reply-To: <20260705014010.1297885-1-xmei5@asu.edu>
References: <20260705014010.1297885-1-xmei5@asu.edu>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Jul 2026 18:40:10 -0700
Xiang Mei <xmei5@asu.edu> wrote:

> vfio_msi_cap_len() lazily allocates the per-device MSI permission table:
> 
> 	vdev->msi_perm = kmalloc_obj(struct perm_bits, GFP_KERNEL_ACCOUNT);
> 	if (!vdev->msi_perm)
> 		return -ENOMEM;
> 
> 	ret = init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
> 	if (ret) {
> 		kfree(vdev->msi_perm);
> 		return ret;		/* vdev->msi_perm left dangling */
> 	}
> 
> When init_pci_cap_msi_perm() -> alloc_perm_bits() fails with -ENOMEM, the
> error path frees vdev->msi_perm but leaves the freed pointer stored in
> it. vdev->msi_perm is not re-zeroed later because struct
> vfio_pci_core_device is per-device and persists across open/close cycles,
> and the vfio_config_init() error path returns without calling
> vfio_config_free(). So the dangling pointer outlives the failed open.
> 
> That leads to two use-after-frees on the same device:
> 
> 1. Reuse. The next vfio_config_init() sees the stale pointer at
>    "if (vdev->msi_perm) return len;" and reuses the freed object. MSI
>    config accesses in vfio_pci_config_rw_single() then dereference and
>    call the freed perm->readfn / perm->writefn function pointers.
> 
> 2. Double free. A later vfio_config_free() runs free_perm_bits() and
>    kfree() on the already-freed object.
> 
> Fix it by NULLing vdev->msi_perm after the kfree(), matching the
> NULL-after-free discipline already used in free_perm_bits() and
> vfio_config_free().
> 
>   BUG: KASAN: slab-use-after-free in vfio_pci_config_rw_single (drivers/vfio/pci/vfio_pci_config.c:1961)
>   Read of size 8 at addr ffff88800fcc88d0 by task exploit/143
>   Call Trace:
>    ...
>    kasan_report (mm/kasan/report.c:595)
>    vfio_pci_config_rw_single (drivers/vfio/pci/vfio_pci_config.c:1961)
>    vfio_pci_config_rw (drivers/vfio/pci/vfio_pci_config.c:1986)
>    vfio_pci_rw (drivers/vfio/pci/vfio_pci_core.c:1599)
>    vfs_read (fs/read_write.c:572)
>    __x64_sys_pread64 (fs/read_write.c:764)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    ...
> 
> Followed on device close by a double free of the same object:
> 
>   Oops: general protection fault, probably for non-canonical address
>     0x1f63e0e8000008: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:kfree (mm/slub.c:6711)
>   Call Trace:
>    vfio_config_free (drivers/vfio/pci/vfio_pci_config.c:1861)
>    vfio_pci_core_disable (drivers/vfio/pci/vfio_pci_core.c:685)
>    vfio_pci_core_close_device (drivers/vfio/pci/vfio_pci_core.c:777)
>    vfio_df_close (drivers/vfio/vfio_main.c:602)
>    vfio_device_fops_release (drivers/vfio/vfio_main.c:648)
>    __fput (fs/file_table.c:512)
>    __x64_sys_close (fs/open.c:1496)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    ...
>   Kernel panic - not syncing: Fatal exception
> 
> Fixes: 30ea32ab1951 ("vfio/pci: Fix potential memory leak in vfio_msi_cap_len")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index a10ed733f0e3..9914f3ac69ae 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1272,6 +1272,7 @@ static int vfio_msi_cap_len(struct vfio_pci_core_device *vdev, u8 pos)
>  	ret = init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
>  	if (ret) {
>  		kfree(vdev->msi_perm);
> +		vdev->msi_perm = NULL;
>  		return ret;
>  	}
>  

Applied to vfio next branch for v7.3.  Thanks,

Alex
