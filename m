Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36E4A64E5;
	Fri, 11 Sep 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148251; cv=none; b=hQr6k95wWIBj9l92IVhYVdJ5uuQGJjn9jKhY2b32FEfEssPb55aekd9k1wipWVH6i/gMzL3h4hJPY0qYnCpcLVHcUem+L3Uq6SSXmes56BmAz2EmUbWDDZK7fJ6h6fOsOCZFx7+oO49iPEHzP0C2HREZxUBK7qJ2RXtUd1BQKZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148251; c=relaxed/simple;
	bh=9rps6h8CX3751Qigsrs1xRzB6UGeygYwEZZG5N3pHZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1KhJM09GJoqkyy01LKoD/BXh8D+QZspMhh6ta3L07bbp9DQNm2H2CFhQJGM5MBTbrf4PFBatwGC08LyVCQtHWkQkfYVZaxzfPXdp6L2/YEZANX5WrtnsKNPkHKZJJaFBbPAyZGu8oYsOw3GuZTUA/eG/FvYnRlwapBJ07joDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=i+DNEFnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EGE5eaFg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="i+DNEFnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EGE5eaFg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A8B21400179;
	Fri, 11 Sep 2026 13:37:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 13:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789148247;
	 x=1789234647; bh=tYootpTuFhcQH2BtMYvaYBKyL5HjOxl59QyXB39Yyfc=; b=
	i+DNEFnnrq7SSV9DULKTlUojV3D+Ds6AS1PDLqUrgNNvMRCWI+khLoah1pfPamNk
	ddA0t2na4MVaGmCs3AE4d3tdVFaIJxj0XINUSTOOmwHobQoQ9qo4ODwbjCkeOyb3
	lpbPq2wtYYV6JsYAubO/BN6Bu8r1dap9fk0jTfwlIYmCtDJpsKg553BjwpvEPgSE
	mpDBWuFin44JJiiiBQR68rZmfI6Qk04TR7ld0nozWZNEJZFQVSo1pccMqi9j8OU3
	CDHuhF1KWP760fpxtgwo4RYr2U7Ij/ZIOIPSj3P/n4/LkCubc56fHoMfcgmG/NmT
	TvbtHyOKcgdGPDpJMDetog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789148247; x=
	1789234647; bh=tYootpTuFhcQH2BtMYvaYBKyL5HjOxl59QyXB39Yyfc=; b=E
	GE5eaFgmW5NpQ1TPnG6ie8x8MdobPzJfu0oB4Fh/Crq5jBEVq88nLF1PR/nvQp5Y
	5XAMSZK2CymFOvkWa9jQc7uMyshmaSJJvNdBmLrnbJZMk3gITOQzebLMC3+ll/vC
	wbDRRR+mcVrmxdBZxDwThvccWSSMNqgZuyGQb69cjgTP9tWX+/QP5iJjHur0KTor
	q8DXCFd2nsAjedR7p8YS4BKLkEYGMzTEoLrtedRtI+kXMaksGb0JE3CphVR2pfb5
	d+HTL5UYpfMdcRfcN9Fh7cfKcr7AAA0jXVnFdcsYtZyvz6Ja/f81FS4j1bItJXV3
	tdtB9HBRVJgZqd7QwBe3A==
X-ME-Sender: <xms:VjykavzqmtZUF8iSnH_m91NH5nLE-qTa1Od0XMUH-QYrTOdJYvXTxw>
    <xme:VjykagnlUZu6qdervo4Ip5HqH16k-EXWHPtpGEMxgrj2obUhCyP3Px2XK19OqulYm
    nU_R_mhcfmigh3Z_p8n8py7cwp_nLKzfb0yjoN8V5sRX1QurgSopO4>
X-ME-Received: <xmr:VjykaglqZg77cAtyOUudJ7oBun62rlxqXm5BXTi9Elvbwxa17Jm1fYbqmDAMfg>
X-ME-Proxy-Cause: dmFkZTELuHWubJnO/bcf4GIqjr5C5hrBSy34IQGrjCXpQ41u01AFzYuVhs2L024veMtT0C
    srDYoAgF+BlWZc8PCxuwt11cQHZNF73Wj00inz7fgb8xPW5xkaEF8RdCfnNf3ab0fmzJMg
    C3PMs6E2obWspbzxrecHDABJMXKhj2m2LUbfBJLGKvAIMilK3SIEEld9CmK8NrHN7UmEot
    ZDJWS8bQa3+/CYg8WRv0V+ifvsiR7SODySMQ7EvyZ0JrB5yvK+i6KLkggdCFO+Mz2tp8u+
    YlMFidlUu+tKmNg2ZtEfHTreTEXQHa4EBtzEDuWkccElky+/dL+jlkx8u4q3GaxxltLfOA
    2K0XMeagmE9wnAvPuG6+oOdUuJVxoVnMvZAI8tahpfI2EylkXMhak9XHXcPlexn8Fd0+/Q
    O81Tkuj8nejTkVV14RTIGz1E2c/M1lYf1vJsQOqhpIQvbNSiLknHhDUykURwSpT956ejWP
    3B0HWjUYKDtZKUmwlFdb8t5aJTqcxnind+uUWiW9J/3npmPPq0A6X/uFFAP3TC+cyQG1ev
    IZttuyuGF+YL8lD7zk4snA0DZB7j3zaKoQ5gbG8jSnIFY7NN/2H2WA//EQoNwHLltjVmVT
    gfI+8oNYBMoF9yG9bt3JAachICcyxRGyhWYXsOo6FpgnwsgegkJIya5q2voQ
X-ME-Proxy: <xmx:VjykaqxaW0LaFU4-ru1ZUGu76j8TmU9AavMvY74Zxh1Onsz90CZv5g>
    <xmx:VjykatqZ9CB8Zyq6BXGXdoNaMm0bZSNoskr5nFNxPQuJfjZxYbnZMQ>
    <xmx:Vjykah5iJaq78oJBhAujw1mjyz-q-0ldA-rieBujF8BUqYxTT4MXlw>
    <xmx:VjykaseW_Wr9GeU86tauJpbwIYxq6iWjyJgp45WnMS9htspcGUpAEg>
    <xmx:VzykaumqIM76yj9lFZossRH8Nfckq5udb3LL8OfZrlAJqJINlg1YN1KI>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 13:37:25 -0400 (EDT)
Date: Fri, 11 Sep 2026 11:37:21 -0600
From: Alex Williamson <alex@shazbot.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v3 3/3] hisi_acc_vfio_pci: reject live migration on 64KB
 page with QM_HW_V3 hardware
Message-ID: <20260911113721.35d7383d@shazbot.org>
In-Reply-To: <20260831090951.844569-4-liulongfang@huawei.com>
References: <20260831090951.844569-1-liulongfang@huawei.com>
	<20260831090951.844569-4-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 17:09:51 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> In the scenario combining QM_HW_V3 hardware with 64KB large pages, the
> device functional region and migration registers share the BAR2 physical
> page, resulting in a lack of isolation that triggers security issues.
> More critically, since KVM does not support the specific 16-byte read/write
> instructions used by the guest driver, operating under the KVM emulated
> device scheme will lead to Guest kernel calltrace issues.
> To prevent Guest exceptions and avoid security vulnerabilities, the
> driver directly disables live migration functionality in this scenario.
> This ensures the system fails cleanly with an error early during startup,
> while other configuration modes remain unaffected and can still utilize
> passthrough functionality normally.
> 
> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 4abed2e49986..4f12cab96545 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1210,6 +1210,23 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  	else
>  		hisi_acc_vdev->drv_mode = HW_ACC_MIG_VF_CTRL;
>  
> +	/*
> +	 * On VF_CTRL hardware, BAR2 holds 32KB functional + 32KB
> +	 * migration registers. When the host page exceeds 32KB, the
> +	 * two share one physical page and cannot be isolated by mmap.
> +	 * Reject the open so QEMU fails cleanly at startup.
> +	 */
> +	if (hisi_acc_vdev->drv_mode == HW_ACC_MIG_VF_CTRL) {
> +		resource_size_t func_len =
> +			pci_resource_len(vf_dev, VFIO_PCI_BAR2_REGION_INDEX) >> 1;
> +
> +		if (func_len < PAGE_SIZE) {
> +			dev_err(&vf_dev->dev,
> +				"migration not supported on 64KB pages with QM_HW_V3\n");
> +			return -EINVAL;
> +		}
> +	}
> +

Sashiko correctly identifies that this breaks any assignment on 64K
pages, which is contradictory to the comment that indicates this is
only intended to disable migration support.  This should instead be
invoking the non-migration path in the probe function.  Thanks,

Alex
