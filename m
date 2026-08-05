Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53D35F609;
	Wed,  5 Aug 2026 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944788; cv=none; b=FTVLGoqVGcZPeiG5h8nBpJgCs8KPoPU3PXYPzzL5gS9Iq1JM6hCTkok14aUpZnaYHSD1GOf3Pj6e5/J3VCH73jk4ZQk9bzLzlN1Bkcpa5yViHURa5BkDXfiyW3MDZ+XmOU6IQh+1rMGer2O6WqnR0/K+yQMuM2+eUDvfa2UpR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944788; c=relaxed/simple;
	bh=a4y5ePNVum6Ndg+qkY/jq42II26Iypkeo4L67TfrrRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P32ZDqtjvhvNka9aOSZJxLF1NeqtvqurTmaKtTEMfnMBSxNfuz/PPojfxLg6qXAo1WdrYVfS7p36jxPz/AeQ5boFiOormCzWrtuA2sDHqvoRQcMXfP0pvqeleVHNS0OOIfbnnwZb9C4PeThzgvley6Y5EpocTyQeWV/nK7LKV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=1VqgBge9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XpURbhcL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="1VqgBge9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XpURbhcL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EBC87A00D4;
	Wed,  5 Aug 2026 11:46:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 11:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785944784;
	 x=1786031184; bh=+y0lnxIqissW6jtwG7VJbrBSu7GtHTzmK8ZY5Nwav4k=; b=
	1VqgBge9zJvCUrt2ZjjtP/Zt4Q4eB2Brx25Xfv/EcgiqF/qjjyag79WW7SW2Yf2W
	N7yA7AK0thRo64Xt/ncANpJ+2P4KuAECRw1cI6JHVbc0KxhAGOsU0JWjmB23yMaE
	tj5W4SwKtiOSNqFMh4u0JpqIdlar0zXLYmtQTC7pVN/b+Q+UIZGdryGKO3ldRFB8
	cxsAQhn2jmlAarv6tBswYJKOxrqNDADox8m7HVHSaBld7De+bObmPh2VavuODIhT
	nT3KNFaL/RMTVAffel1txK/gmr3MsLIGX8C69Xqgad4DTYeXN6neksQ7D8ELk0Yz
	3wQrliPEdxPqzjyxq7tlDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785944784; x=
	1786031184; bh=+y0lnxIqissW6jtwG7VJbrBSu7GtHTzmK8ZY5Nwav4k=; b=X
	pURbhcLhTkyc/FNoHvRie68Nt0sHmFXTmhMxAPjGfEjSgjxCmX7AzjhgtlRrOr/5
	fjEGRu7RNv5saE9FS6S0jbkkxqjt2yBK6D5faXglGH8DH77+NsJG69Av00erE3tE
	L7SRPJ4Yop0Jml/ZnIjygynryCXnqFaHtzgD1x5UmvNbLBiZ39Ml0CCxtNebmXpQ
	kehsi9M3hdfyrzEaF7ayZ6Jhaf1QoWRBKgR2b3mLFRbEfq6Y/3ILnKR8r5w48qV7
	cw9lkagl3FCy+oQvAGzjUAbyF7ZbzI6ZosmAx2GZ4w/Jj5EY/TvCsjJmfL/CQ5Ht
	HlpNAjdpOIpU0q8ZQJnbg==
X-ME-Sender: <xms:0FpzanuLCeolDjojF20w5H3KlkVjXhTLTF_yC3hiQZ4bUWBlKj9rsw>
    <xme:0Fpzao6bZoo4bmlvNrYOAsUpJvz2VK6cNkjndsQdv5moTDgaXvypApumE6OBkpDul
    -KelqFC7lgJJN5TOdPd3mHySib194z6UA9pHKunC3FAEhzh-6ashJg>
X-ME-Received: <xmr:0FpzarfLYHFBxdry3aWcmXnDpjm4aOImnjAkCBOEUy2FFZFSRb4wMmiNu0ycQw>
X-ME-Proxy-Cause: dmFkZTFw5BG6GIPp0d1Y1L8wL2gKQlenZtZcUENWaMJujBERo7fhbBiMY93ldTU4Vft8bD
    TR4sj3rObDdpPlSCHWgS1Dv7bwH7B+pEADqL7c1Xe3wPmMnijnKXwVRqsO1GhOU3j5qzm+
    +6uus38MkHrVJ6RzJsJ5fVqaHKaUWqF0425hZNCgAkT86zSEZxLerdK51W+ZRkuZxqvm7I
    qL2Nnbd25H5cjtKxQRRwvlkqxKx3HGA9psymct5zkcwFWAZ4pGeTQmOFSYndSo6PxBcBRU
    jxG5UiEAIO5F5elmETNpvzElAFqYaphm7emxrZp6V5ORb51YyG//ZOm+pmGZUoUvj6MlTy
    jBVPuQxWyM1nXr05YGwczDr5mUkte3mMBSMP9QrCggpdfWsM1JvMCtvhLvPuCugUWZzCvD
    QvT7rPLRfcgfwLJTYPyZaDx2fvssEc2fA/m3xZUjzh9Vm19Qkakpv4+lbcVleRSre48H1r
    iYaiGumr95r7W8/g9bkesg1pBUra+D7mos6XVeK3Sm2UkEvbELxrxaJvfUgd4WiZXP+i2p
    H3VCI2rfpTLJ1Y32uMeC5dBUu3WuKeVEkMdO+/UpH1Fjg8mJNie4EfxgxfMyzNsF7ifKK7
    MKr/zxCMsp/EwLj119NkduaMEYC7ForZFTlbOiDlBRoDNgKccqKxrx+FfFcw
X-ME-Proxy: <xmx:0FpzatwNvTOxoohgD0H_dAId0CCYj7kIf-etuW8o2Vg5KO7WwMzQdA>
    <xmx:0Fpzao_HaOSQK_RGQduaGSmT-3UnDYJLuilZdTgCI6Bpkov-I8S9fA>
    <xmx:0FpzajxzMI6jl2UZIOCVVgpLQytK8LmXUSrvZbxsvFgKq44jtXWGUg>
    <xmx:0FpzaorQlrFQIv1C2Ke1va38Enk-xGefUCiFw3agK3r8rLvIp5VSjg>
    <xmx:0Fpzak36okrUOSexAY4HBHDYrU_YwHnYyNPlUFZwTzTUA7pJOy976rAT>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 11:46:23 -0400 (EDT)
Date: Wed, 5 Aug 2026 09:46:21 -0600
From: Alex Williamson <alex@shazbot.org>
To: Josh Hilke <jrhilke@google.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, Alex
 Williamson <alex.williamson@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v10 0/3] vfio: selftests: Add driver for Intel Ethernet
 Gigabit Controller (IGB)
Message-ID: <20260805094621.665d5ec0@shazbot.org>
In-Reply-To: <20260805-igb_v3_b4-v10-0-9c86dc849c0d@google.com>
References: <20260805-igb_v3_b4-v10-0-9c86dc849c0d@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Aug 2026 00:20:57 +0000
Josh Hilke <jrhilke@google.com> wrote:

> This v10 of a series which adds a VFIO selftest driver for the Intel
> Gigabit Ethernet controller (IGB), specifically targeting the 82576
> device. IGB is fully virtualized in QEMU, making it suitable for running
> VFIO selftests without specialized hardware.

LGTM, passes on physical NIC.  Thanks for the re-spins.

David, do you want to double check and provide an Ack?  Thanks,

Alex

 
> v9: https://lore.kernel.org/kvm/20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com/
> 
> Version 10 adds an assert in the IGB driver to prevent DMA transfers
> smaller than 60 bytes, avoiding out-of-bounds DMA writes caused by
> hardware padding on short transfers, and squashes the recovery logic
> (previously Patch 5) into the main driver patch to keep the driver
> self-contained. Also add some logic from Alex to correct the ordering of
> Tx/Rx queue setup.
> 
> This series applies on top of linux-next, but the VFIO selftests don't
> build without this patch which fixes a compile error for the test
> fixture:
> https://lore.kernel.org/linux-kselftest/20260630213341.1664345-1-dmatlack@google.com/
> 
> Testing
> =======
> - VFIO selftests builds clean at every commit
> - vfio_pci_driver_test passes using IGB driver + QEMU. Use the following
>   command to run the tests:
> 
>   vng \
>   --run arch/x86/boot/bzImage \
>   --user root \
>   --disable-microvm \
>   --memory 32G \
>   --cpus 8 \
>   --qemu-opts="-M q35,accel=kvm,kernel-irqchip=split" \
>   --qemu-opts="-device intel-iommu,intremap=on,caching-mode=on,device-iotlb=on" \
>   --qemu-opts="-netdev user,id=net0 -device igb,netdev=net0,addr=09.0" \
>   --append "console=ttyS0 earlyprintk=ttyS0 intel_iommu=on iommu=pt" \
>   --exec "modprobe vfio-pci && \
>           ./tools/testing/selftests/vfio/scripts/setup.sh 0000:00:09.0 && \
>           ./tools/testing/selftests/vfio/scripts/run.sh ./tools/testing/selftests/vfio/vfio_pci_driver_test"
> --------
> Changelog:
> 
> v9 -> v10:
> - Add assert in IGB driver to prevent DMA transfers < 60 bytes (Ethernet
>   minimum payload size) to avoid memory corruption from hardware padding. (Sashiko)
> - Squash recovery logic into the main driver patch to make the driver self-contained. 
> - Set per-queue enable bits _after_ enabling global queue bits (Alex)
> 
> v8 -> v9:
> - Enable Pad Short Packets (PSP) in TCTL to support transfers < 60 bytes. (Sashiko)
> - Correct misleading comment about interrupt delivery in Patch 1. (Sashiko)
> 
> v7 -> v8:
> - Rebase onto linux-next branch. (Alex)
> - Implement retry limit in vfio_pci_device_reset(). (Alex)
> - Carry David's reviewed-by tag onto the patches that haven't been
>   touched since v6.
> 
> v6 -> v7:
> - Allow the driver to be used on any architecture. (Alex) 
> - Fix regression in reset logic for the physical device. (Alex)
> 
> v5 -> v6:
> - Retry on EAGAIN during device reset to handle transient lock contention (Sashiko).
> 
> v4 -> v5:
> - Reordered igb_remove() to reset the device before disabling MSI-X (Sashiko)
> - Refactored hardware reset logic into igb_reset() helper.
> - Simplified reset completion check to usleep + assertion instead of retry loop (Sashiko).
> - Allow arbitrary test data by enabling Multicast Promiscuous (MPE)
>   and Broadcast Accept (BAM) modes (Sashiko).
> - Fixed igb_send_msi() to use MSIX_VECTOR_MASK instead of magic number (Sashiko).
> 
> v3 -> v4
> - Enable MSI-X mode in GPIE (Sashiko)
> - Fix hardware initilization order to avoid race conditions (Alex/Sashiko)
> - Add memory barrier to prevent speculative reads (Alex/Sashiko)
> - Clean up stale references in commit messages and comments (Alex/Sashiko)
> - Add a comment to address software/firmware semaphore (Alex/Sashiko)
> 
> v2 -> v3
> - Poll reset bit and document the required wait time (David/Sashiko)
> - Fix the logic for enabling PCI_COMMAND_MEMORY (David/Sashiko)
> - Fail the test if autonegotation fails (David/Sashiko)
> - Handle endianness conversions (David/Sashiko)
> - Use real IGB headers at the start of the series (David)
> - Add E1000_TXD_CMD_IFCS to the TX descriptor command word (Sashiko)
> 
> v1 -> v2
> - Removed the chunking loop in igb_memcpy_start() (David)
> - Removed redundant writes to status_error and hdr_addr (David)
> - Include official IGB header files (David)
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
> Alex Williamson (1):
>       vfio: selftests: Add helpers to re-enable interrupts
> 
> Josh Hilke (2):
>       vfio: selftests: igb: Add driver for Intel 82576 device
>       vfio: selftests: Retry on EAGAIN during device reset
> 
>  .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
>  .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
>  .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
>  tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 585 +++++++++++++++++++++
>  .../vfio/lib/include/libvfio/vfio_pci_device.h     |  15 +
>  tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c |  42 +-
>  tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   3 +-
>  8 files changed, 647 insertions(+), 2 deletions(-)
> ---
> base-commit: 0f6da28aab51b16762ed82e8fdeaa5042da45b08
> change-id: 20260707-igb_v3_b4-49194c14373c
> 
> Best regards,

