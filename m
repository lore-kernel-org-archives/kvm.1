Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795485888;
	b=d0qldp97Nt5faZa2P5k5lSx6EuzbZFQxqFX4fp0YrdQ37GGhybSvHui7b5Ns5cfWCOHW
	 BHXt2FHMxTr/z/KhbrZUgfgps4TY7n/B1u+0mYZeQ89eDL7Hy55HNwqkPVUGb/qHgzl59
	 Cc22JUcyR1KIDmJZjabHhJm819JRsQmNwuxQ2NGPkRb8H0JfiXyrNZnAhVDOD+hBd5NPZ
	 mplNgs+RVaFEOjPQQ7D4F+qJDFpztjtUfqmt3V/+b6xMvGe65F/nSMtnFrFAQkbMTaHtd
	 ci0qX6BQi9a4EfcWpG2tzinWBaJL0ztbpaTFnl91c/LoLRi0q9IcaqNEOjd032PlLMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QZ8jeJhff8TwVzDr8mq7hnVn9Uwjnn1WsiAHJK7NNrs=;
	b=TUEpHHalhXZCtaP5PwMLYV0zkft9Mj8OwbMLNycap/Z/Na0jjqb9XCaKCSWDw0/w44ns
	 S8N7Rp9RFGMUp0xfUz7PxDZSXimf6GTztL5a+HIApK7K6ZKWorfz1igIt1kIyluvUt5j7
	 IKGrsvxQlbXNn2xlFpdEIAwrki+NbdpaZAn6WtVFssdkY+CatuHNN+4gvXDYucgC4dEQO
	 zjTjV+631dcniASmligkmvP/AOeO2r77TFZd+tleyqWgaq95RGqWp5PLVRy4YnXfPFnkv
	 Ox2SyVjCVNBx5OmJYcoYarij86iRJaI9N2iI1La0KgvXNd33SvVkqL9rAw07I8j6vCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L0RpxqJ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51F606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 02:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E51F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L0RpxqJ3
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be58ad9600so19740e87.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 18:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795485886; cv=none;
        d=google.com; s=arc-20260327;
        b=M/LBX+99lqiLsZNmK4KbXsoWQ5VtuGY0XmSU61mfcyo3x7gzdNn0dlYZKI/TQkSt/9
         Pj4vkhL0jkZPaqdf5ykcE+ZBfpMfb0vuEb/9QYDZnktQtsu1dbcg38iUIqWFfs2tcHty
         UCPSKxwoxAivJqpg4v0v8dVxQx9LVXarlk2VGA7KEMOiYV9TVkdy9Cym5aa1a6I0PNDv
         24145umw7IWTj1RbVzcOy/CjbYt6xLmgaSgKh0qg9P+UpqfUn8jz4mbnnAyM4+sLWqGT
         DpgwDXoei8rZh5krNYyBdXHyNtxta97S+HDfofPVxvchU+o+B58PENQQ6xjxF/qvZvWS
         oK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QZ8jeJhff8TwVzDr8mq7hnVn9Uwjnn1WsiAHJK7NNrs=;
        fh=DsiymIGnqbnxpH8tpINYYp7CX6Gtc1QBUZEU7XBXgSE=;
        b=S9fvPHAyb6UxSzn0DcoVdZxQLo8oRDmU3VynBA9kpj1Iz7vqXP1fsxn99UpisqK92+
         bR/AeLuTjI4Tq8USdBeKyqLNf2/12NrJyJwiL+0NEwZdHJGCl3Zyhs+w7CtDCAw+xTjp
         x1oomCxcNndSqqX3yhlH+mIFOvTU0NB/hcU9lVKFyUX2bPoQxEsY8lUdqVzGraseyQyG
         KekjgByjmYrlz+xFzM1qyNtlCBeCY2X2tsQagukxTxJQRVlryx5hqx160miura31rdXV
         LYxXHkQcB3U2wl1pCs6EuVe7hrW0vhhRsA5ILjBK8CVatyaiUlylDe8h5mTGcTWoFM0O
         /V7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795485886; x=1796090686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QZ8jeJhff8TwVzDr8mq7hnVn9Uwjnn1WsiAHJK7NNrs=;
        b=L0RpxqJ3H3vfIondTW9HJ/az8lgDil5r+HuyNxNnNhLQOf2oGb44oVjlYZZ+gh8FUp
         YRQV8N/SB+uatGgO1g6guubw92PZVRFi3ULUsqNY3tbCH9GO9MFBfzaiTxvGwihkI8E7
         Nux/OeuuUXG790sQr93e9tZhdiZJhFHzeJkdZ7c12Ywao2StJEmWY+YoDktqF8YdpAZN
         VB/eEBd2/XlFWhHx5tD5FNtvXH3i6BBM5TOujwrhcQi3WSBjYB28lHWY6ANGaCe1aD9F
         ql1zKRP3San7mpRd0WjMU4fGw762QFGBdqDJWQsSd1WcNze3/Tzy7yR/Z3t5U3V5sc5S
         u6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485886; x=1796090686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZ8jeJhff8TwVzDr8mq7hnVn9Uwjnn1WsiAHJK7NNrs=;
        b=DhbvAz9IgBQ3BfBmytcMrVkB2WnttUmkBh0VpL9IAGIYU22BFKahtYQ4OIo2190DPl
         oAPN+ui202YOv9gJpDfA9qQ4bDqa1HG6t2+S/S54Ht8+cZfZG+ftdYUpoV/bzaAG1mos
         AvXX3LWBMde57xk+gormjQqKcHGRkzEB2ZtWYo3314YJ+fLch8Pq2A9NFW5Wqx5VmTjd
         OYnpsl4KQ89Rs23qFPpGlXAUfbUoDIjct+cQhMkalvtnUQBu+DVfoNwAPxeV8eqk+PVP
         VYeNxygooh9eDj74OyVxrzEw8jivoTaUTEc48gQc1FXysKIeCXxbruGxC8mUP5VEiukO
         7bFg==
X-Forwarded-Encrypted: i=1; AL+hErFW6elF0aVFeROP4SyNjNLGjTMAW+YPH/XV04J2J9DhguxnXnxkzAED2g78+DQonqmRwfY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+liGINW3RywOA/hiVrWH8+de1/2TBYZHSyaWvlRc7pHZ/+UAxB
	rYJY+fZ8FLhbijIJUHe6Vxq83yQOxxlN9sAoIjiy3472LbvKS6Cl1Sbe7ffKwnZqLYIdHSIEIh1
	h6Ck/JEtx/QgJEs1kElb4ntHo2IheUteNOfrHDvfp
X-Gm-Gg: AZFdTZca9xLXdFrhBPJNuu8izP067BpjCdJhf5K7DbpRQYx1/SetAUpquUjruZ9KoSB
	EWcBAH8/R22UM6EMTPUkNsXTT6UfKExYnJRs/sQ8jG0sBlCxaFnyYyx3XZhBxRJRWtag/rj6PJW
	KzNYSCfbmsYCgiDr5GWCQ7nkxmPyXox3DIGW9UgjclsXG9llbp+QALoMhSe73ihom0cp9x1CFq+
	Sgc8b0dOTRSrHFGzyjjrZA/uTx/ABiBTD7Hts0dMthsds+VUG8805ZZi+dA9/R5fghAzuCOAlIt
	fu0CzOT3LgtugWSFnGnrjU4hjxIdWsasibAg4jgRxHB10tEOGOglBdtmonC7xIGeALk+zL4yEU2
	J6XRC68a+spYlbK7G+EqFBmdVWX08LF6GS6Gy9TwBBep91jy8Jmx/HLHEiQ0EUQtG4rC/Jga7hY
	KXgZPK5ziwf9B4SXjQcc2BILk4wcSypKn6xGXzS4hAJ4jeVTUQGi8=
X-Received: by 2002:a05:6512:b9e:b0:5c1:5209:5a44 with SMTP id
 2adb3069b0e04-5c1c8239441mr351300e87.4.1795485885773; Mon, 23 Nov 2026
 18:04:45 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org> <20261123083337.2731019-11-aneesh.kumar@kernel.org>
In-Reply-To: <20261123083337.2731019-11-aneesh.kumar@kernel.org>
From: Jianxiong Gao <jxgao@google.com>
Date: Mon, 23 Nov 2026 18:04:19 -0800
X-Gm-Features: Aa3M54qI-S6sAhD3oo3lD3dF7U9WjxfGl_G2FEa2MNAlB4C8vKhlPO9m5SK63WY
Message-ID: <CAMGD6P0pNAnq9U80dnpgbz+hHbX1yH1bdmXjcie4oiq7KizU=A@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] PCI/TSM: Configure accepted device DMA during
 driver attachment
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Lukas Wunner <lukas@wunner.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, patches@lists.linux.dev, 
	Zhichuang Sun <zhichuang@google.com>, Piranava Tamilselvan <piranavat@google.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 02:03:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> + /* driver_managed_dma is unsupported. */
> + if (to_pci_driver(pdev->dev.driver)->driver_managed_dma) {
> + ret =3D -EOPNOTSUPP;
> + goto out;
> + }

Hi Aneesh,
A short clarification question on this check: once a guest TSM driver
implements dma_enable, pci_tsm_dma_prepare() will reject binding
vfio-pci (and other driver_managed_dma drivers like pci-stub) with
-EOPNOTSUPP on both locked and accepted TDIs.
Is rejecting driver_managed_dma just a scope limit for this series, or
the intended long-term policy? If it's a scope limit, is the expected
direction for in-guest vfio-pci to enable private DMA when it claims DMA
ownership / attaches an IOMMU domain (via iommufd or vfio_iommu_type1),
rather than during pci_dma_configure()?
We run a userspace accelerator driver over vfio-pci inside a confidential
guest on an accepted TDI (similar in model to DPDK/SPDK), so knowing the
planned direction for driver_managed_dma =E2=80=94 and whether any upstream=
 work
is planned for in-guest vfio-pci support on TDIs =E2=80=94 would really hel=
p us
plan.

Thanks,
Jianxiong Gao and Zhichuang Sun
