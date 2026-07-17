Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FFE2C11C4;
	Fri, 17 Jul 2026 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303037; cv=none; b=BweW1SPzmPfq4s+5+VCYptwmBq3y67/NIFQWTu1cX+nh0gfw5YW60Zbm7dup/groiE5EKUGqMrrv6FFDpkpUwk+ShOHqvi8fXl+DfrmD897zaZ60D5wdU7qc0dC4GOWeh/4rVi/nGPp2LbB9+K5OTppw9uYjAOJsq+muITuus1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303037; c=relaxed/simple;
	bh=VpjJe2JfDCSec3LSyM2oNupD6f5ORXd35g/fIttj7mU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBiX/v2DdQ4F3m/czsHwgo6Mdo5ADD6/+WePNZOCKLsRmN+mNZeT9RNcHiBNKAhGsqHsqpEtF0HCfSEsChzE61OKV7c9sOvIVwkONA8xHYywtlbTWdYW2QZw3n/q5IyKmF0o7WRhOs5Q8iI33QqJd2hEQDDGY6rclnZwJgBVFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=GkEboOpv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNT1YDxq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="GkEboOpv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNT1YDxq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5174140011F;
	Fri, 17 Jul 2026 11:43:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 11:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784303033;
	 x=1784389433; bh=BGBh5ijHRJh+02AFHFZvYLL90NolghTRj6Q1F0snpwE=; b=
	GkEboOpvwxQ9Kp30Rml1KxvEdZoGXKD9u0cfkDiFWZsNGieGTlAzJMW+zAztvjnG
	Fo93jdoOFcOYYUS1DSLOKi1QVHS4L0KR2g1lU8hMHBW2PJ9Q4hCXBVNpp9eiPEsi
	ZBiEF/SN7Uoh4DZhXqbo86vpGeO9HTt/Icx6lb39wEsL+LLZbotECSjhwnnLuhxY
	kCa4/Tg8UtUJnDUHBnmv7eEO9jJOjx5sxd1fuzZDhOqNstFxi/GU4KZcIFSHV8uh
	xxQ76RkHoa/BDwrzEUV424HRMHs8v78L/GQvUjwF/fbkibyxfxEbXiDg4g4mXVti
	uTc6qYzyGbbXiwLe0nRUmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784303033; x=
	1784389433; bh=BGBh5ijHRJh+02AFHFZvYLL90NolghTRj6Q1F0snpwE=; b=j
	NT1YDxqgFKo5H7NxZjfPJvhG8NKhoMPuOWMaxzCT9rI6bhc0AvB212/DDsaVYO7S
	mnP6w7SnzGYMCqd3aNfBuXDQrlUExcLxzm+9PZJCl8Az0MvAyJMzXyTsb9eEgdfM
	ykJEvrZvOb9H4SIJYR+pLViI4LDM78SStWnTDE85TJqpIp+GY6FuMvQiPlEVu5ic
	UEN7Hgi2QqgFca1jp9osysVL9lyqqoNYqSOMexpGD1fcCuJxf82I7QfIoybUR3dl
	P5mjUmS7yQhpm/7YgfNV37cwuN8pz8dsJx3LMqRBI3VHXHWAKy64gifQuPsCHWrO
	3G8ps5ob8J8rvRIBbliGw==
X-ME-Sender: <xms:uU1aahSmtMqVoW_lt6pLkRKllD0mq2f22W20ooz1WnO5UF-H5nK3ew>
    <xme:uU1aaiYKa4JWsnLPh8RJfgMKc7S8Gmp3H7XOXHM1hbyonvu_13Rng1cHfGfBBQGdU
    ovLMKjWkgqahkPjd2zNZMMxfEI9DzZVikQjurCCKCVWLnSGHsW6QA>
X-ME-Received: <xmr:uU1aakdxIpChOycg6Vyh3JBn3CEjfb7OIAHtZZR4gjWsFH2wPkYk7--syPE>
X-ME-Proxy-Cause: dmFkZTEy2zXuER1XoNziIjJVIVvASb/84FYkJYNW70SRcx1M3RLiBAgvmGliwMHBjBQit5
    +wTFsfvGUWIW0lQDJq3TCFmrnSx9hh1eF+8ZIyHYplayqqo8q062CwIhOvW7Yhgm0zA6gg
    Alo/KuFijTpJ0UY5xqJcBS6jKLZBdO6CXQrU1Dt5QlzpJeVNL58WCcglOgabKVP7LKJJiS
    BvlqJiEZMzVWlZ3Nn8002anKqzbuOUZp4kO8qpRm5nAcu9yeEiv9hJzv6MXTx5wTCI4c8q
    fr/ve8GN6ABxB8ra86i2SzSeHI+JdzR3bfHc5XWhLZmX3shgf+iUxMKWU9O5fHmeYievdY
    pX4ZQxqQ4Oc/PorBl6auMdNfwAEvGLxvm2863uu7pOpkY3cXY2nnwCdSPW6VdSAi2F+4ZV
    QwPfehyt1bZRd4pXFG2UWTQtbqbE7iXY5kadMfURGOLe68f2uT3HPNnlydq17xnyzV1iss
    kirpOZPNy3jOp/WG0WD3scKRafi94XWxksh26NAsuf67hw86Y8ATd+dn3bh29pgMhWBi/C
    8q4igpam1wE0wo5eTJXVX21HFFOf9W+e8H116y5vagy7Ly2dKiGzHjmEHYXq5nLuG3cHJo
    PNq2mC7T8IyS4NV5HWabPnCGNmHJ7MQSF+ySyMOS/Tl6JcDY+7PkjoDWq4HQ
X-ME-Proxy: <xmx:uU1aajLDcOO_rpjeR_0wgnBua7KwX0GExC_7Ott291srFLsBM9-Zsg>
    <xmx:uU1aahImY-lcbqU7S6Q7l8VN6U8WOMHEj6DP9BcIMdBiaa4-l5QUDQ>
    <xmx:uU1aaiXwQVD60JVlsW6MLGM2LYZkU7eGYyED4GRU6XAytqwjkw6fVQ>
    <xmx:uU1aaql7qMIRhR3fz0EHpHMFND8Y6AoBMYU32mWvAfGUMCFue2gDvQ>
    <xmx:uU1aasLlEBJCidToeK6OUT1yqLmRIQV8AjD4s7pJ9Ke1YqIUz7o9rrUv>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 11:43:52 -0400 (EDT)
Date: Fri, 17 Jul 2026 09:43:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: Rubin Du <rubind@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v14 0/4] vfio: selftest: Add NVIDIA GPU Falcon DMA test
 driver
Message-ID: <20260717094350.1a7970e6@shazbot.org>
In-Reply-To: <20260609232855.3808971-1-rubind@nvidia.com>
References: <20260609232855.3808971-1-rubind@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jun 2026 16:28:51 -0700
Rubin Du <rubind@nvidia.com> wrote:

> Patch 1:
> 
> Add a chunking loop to vfio_pci_driver_memcpy() so that it handles
> arbitrarily sized memcpy requests by breaking them into
> max_memcpy_size-sized chunks. This allows tests to request any memcpy
> size. Update the test to use a size of 4x max_memcpy_size to exercise
> the chunking logic.
> 
> Patch 2:
> 
> Add vfio_pci_cmd_set()/vfio_pci_cmd_clear() macros for PCI_COMMAND
> operations.
> 
> Patch 3:
> 
> Allow drivers that cannot trigger MSI interrupts to leave the
> send_msi callback NULL. Tests check ops->send_msi directly and
> gracefully skip MSI-related operations when it is absent.
> 
> Patch 4:
> 
> Introduce the nv_falcon plugin driver, which extracts and adapts
> relevant functionality from NVIDIA's gpu-admin-tools project [1] and
> integrates it into the VFIO selftest framework. As a result, any
> system equipped with a PCIe slot and a supported NVIDIA GPU can now
> run VFIO DMA selftests using commonly available hardware.
> 
> Falcons are general-purpose microcontrollers present on NVIDIA GPUs
> that can perform DMA operations between system memory and device
> memory.
> 
> [1] https://github.com/NVIDIA/gpu-admin-tools
> 
> Changes for v14:
>  - Re-tested with vfio_pci_driver_test on K2200, M60, P100, P4000, V100,
>    T4, RTX 3090, RTX 4000 Ada and H100.
>  - Alex prepared this respin addressing David's review of v13.
>  - Patch 1 & 3: No change.
>  - Patch 2: R-b collected.
>  - Patch 4: address David's review -
>    - Include <linux/types.h>
>    - Factor out get_elapsed_ms()
>    - Rename NV_*_BOOT_COMPLETE_MASK to _SUCCESS
>    - Drop the redundant falcon_enable() and move the no_outside_reset
>      check to the top of falcon_enable() so falcon_reset() is
>      unconditional
>    - Fold dev_err() and size_to_dma_encoding() into nv_falcon_dma()
>    - Drop gpu->memcpy_count and the redundant GPU_ARCH_UNKNOWN assert
>    - Alignment fixes
> 
> Note on version numbering: v1 through v9 were internal review iterations
> that were mistakenly carried over to the upstream submission. Apologies
> for the confusion, the internal changelog has been dropped.
> 
> Rubin Du (4):
>   vfio: selftests: Add memcpy chunking to vfio_pci_driver_memcpy()
>   vfio: selftests: Add generic PCI command register helpers
>   vfio: selftests: Allow drivers without send_msi() support
>   vfio: selftests: Add NVIDIA Falcon driver for DMA testing
> 
>  .../selftests/vfio/lib/drivers/nv_falcon/hw.h | 352 ++++++++
>  .../vfio/lib/drivers/nv_falcon/nv_falcon.c    | 783 ++++++++++++++++++
>  .../lib/include/libvfio/vfio_pci_device.h     |  14 +
>  tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
>  .../selftests/vfio/lib/vfio_pci_driver.c      |  21 +-
>  .../selftests/vfio/vfio_pci_driver_test.c     |  57 +-
>  6 files changed, 1206 insertions(+), 23 deletions(-)
>  create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
>  create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c
> 
> 
> base-commit: d0c3bcd5b8976159d835a897254048e078f447e6
> --
> 2.43.0

Applied to vfio next branch for v7.3.  Thanks,

Alex
