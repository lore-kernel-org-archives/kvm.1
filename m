Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41E36A34E
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543112; cv=none; b=k5vxmJB6SxEbU0RxX5iwpguCqnIphE23AlaKMC4kM6zcl9fp8Ge5DmFvx3I65VCfXsxHtZRlBdaorZ3QuvpCZBM+e1iRUJIfXxflJ8NT2euHBdCZ00mdn4ZpkBt7Wzoc15hWJ6rFniIuC8HKpfy1p+8lccjaPZDPlq1OXt/ItbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543112; c=relaxed/simple;
	bh=44EbtyQY6KaNsRN/j51Gk/fguShf1HUfi+DO3GHdYI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dViN8vdF2toSV8n+m+Oj/2hmeVjwuQZg24r3RboPghsp/5MZrAImoRXMTYtX651QBGE7HLDQolZ9dJrKpOgSBQecnWCP1WoQaY8+lRQetaufGuSaCCdWz19cPe91A3OG8udsLGpVr+euPWHwT8nXSDQiBRIVRJBI1M7DCpwZDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OT1hN/2k; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OT1hN/2k"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12ddbe104ccso4503568c88.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543109; x=1779147909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TGj0aB2s3/hynQboLxlyJ7QKELXcK5iUlYfrmty2+zs=;
        b=OT1hN/2kWmjQiLC90bHLWXSxg9vemERvBxgt6IFcAdrUWThmIQ4yW+rSHTzzp/uVVn
         40ey9at3IXOM1LJHnma+VrGmgIv5oPMDZhWmRMdTwlnSiEyXEhhCYPUxg8uVhYUbUm78
         mjndhlH7tXFZ0FrrSosZmdPtzc172dNOd7Vk+b3IIo9XWhL6y+EuvMY4zU5P1iTVV3r9
         c98bXPLnNtKDepeh0L3ixDbQdcyehJFjzeVcS/ECUwfrL8nev/Icpp13QX9tX3FuwCXn
         hsEptKsNHLL0RAfrPq75x/bqICVs4JOIMdmqeEqAmANXkLAbgT4UMvBv7MJsDzad2ZsL
         5Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543109; x=1779147909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGj0aB2s3/hynQboLxlyJ7QKELXcK5iUlYfrmty2+zs=;
        b=Wy78VRzm9tr1HuFVNASQ9FstczssvL7hGloChmSxJgILM89wc7XeYbovCQVXGf9Nvp
         H1Fij+SqN43rlDokADQEhpo+emGbHuM8erxcJ2hoCF289Flm1OQAOe2P+PqS2FKuyirY
         Cbo0R2TLs6JEf9Er96Tps8LmDTWwLP0z1bxpV439DJ3USEW5PhT9JoljsafFe2wK0ae3
         2Mh9JxZqzil2tCmQaz9TeQkuzk+EyyDc8Hyh+rAz0DJ3eF6LBHsgByh08fU792O/B7hP
         uXobpyRqJjJUuD8JjWdE4L3n4BkNzC0sb9/TG42E46nMmt6VbgfReGTyo8Q73+4SFFhs
         cf9w==
X-Forwarded-Encrypted: i=1; AFNElJ+x/QFM1rcldxceTKRI+vENHSwPDaSMyiv/xshw/Vs9cy1bHcEeL/78bhmDtuDVlbxxaz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5LvQptCwQaQozo5MlhvG+rLWHu3zEGapyYmo+N5cfvK97DfI
	MbCvGqOI6bE8IcncB8dPRZCQWq69beCol1sW0SkpxLyVIM3f3dqewmeJdTl848aUJw==
X-Gm-Gg: Acq92OEwLfxcsNzhBn2m6wMQxk9NrZ1yPoMhXdWYelarPyFyY0KRuPyGcRip8AcWCt+
	mRYb3nz7llKTJxuaDp2/uH2cwThf+su6/L5VLVjLZ9EXkjGWieihhDNXEdCgjrYTlwhBSdxYvKo
	/W5z3MvySaGDK6JJgf77pD/kzsU9rcr1G1dCGPvDSoUkk/if4FjNEuSWa/zcICEu0Pw7HSXyWwL
	DZzoYQN0t7W5E0Tr6OlG/TNtIBgncHIkDlLNjmP71vKxguuX+nEu5vGS/RFE37RJFOGHj/UKLNS
	HTmdM887KoS2yz7eV4LjtWzLxZV84feolVuL8/wAaDd3JekrdXg9AKJ+BBXpLoP4ewtJesHLHc3
	zY970Hel5czoeCSB+Ln1a9hFSfct4I47eXG0Z8BczXVas7rHDUyOqBW8KaDlC4U1FBUOnwJcYrR
	BZ8gdDSQYu9ZX1rYySv2+Q9tvu9vkokCtXdcxShSWz1nCHciCTa8PkES4LR8ae7+HP5n6s9EVt
X-Received: by 2002:a05:7022:6b9a:b0:12b:f8d6:d4bc with SMTP id a92af1059eb24-133451a2e7dmr481710c88.34.1778543108508;
        Mon, 11 May 2026 16:45:08 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ffb9sm22979645c88.2.2026.05.11.16.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 16:45:07 -0700 (PDT)
Date: Mon, 11 May 2026 23:45:04 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add driver for IGB QEMU device
Message-ID: <agJqAO-RRdjMrUZJ@google.com>
References: <20260511211839.2781731-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511211839.2781731-1-jrhilke@google.com>

On 2026-05-11 09:18 PM, Josh Hilke wrote:
> Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
> (IGB). IGB is fully virtualized in QEMU [1] which makes it easy to run
> VFIO selftests without needing any specific hardware.
> 
> IGB does not have a default memcpy operation, and memcpy is required for
> all VFIO selftest drivers. However, IGB has a "loopback" mode which is
> used in this driver to implement memcpy. When IGB is in loopback mode,
> it doesn't send data out to the network. Instead, it sends data from the
> Tx queue directly to the Rx queue which points to the memcpy
> destination, instead of sending the data out to the network.
> 
> This driver passes all of the VFIO selftests in
> tools/testing/selftests/vfio/ when running in QEMU. The driver has not
> been tested using a real IGB device since the main goal of writing this
> driver is to run VFIO selftests in QEMU without requiring any hardware.
> 
> This command is used to test the driver. It runs
> ./tools/testing/selftests/vfio/vfio_pci_driver_test using virtme-ng [2],
> which runs a kernel in a virtualized environment using QEMU that has a
> copy-on-write snapshot the host filesystem.
> 
> vng \
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
> 
> Code was written entirely by AI (Gemini) by feeding it the Intel IGB
> specification, the code for the real IGB driver, and the QEMU
> implementation of the IGB device. It took many iterations of prompting
> to get the driver to pass all of the tests, and lot's of de-slopping to
> remove unnecessary code and make the code readable.
> 
> Code comments are also written by Gemini through iterative
> prompting.
> 
> This patch is based on the kvm/queue branch.
> 
> [1] https://www.qemu.org/docs/master/system/devices/igb.html
> [2] https://github.com/arighi/virtme-ng
> 
> Assisted-by: Gemini:gemini-3-pro-preview
> Signed-off-by: Josh Hilke <jrhilke@google.com>

I just did a quick first pass and left some feedback. Overall I'm very
excited to have a driver for a device supported by QEMU!

> ---
>  .../selftests/vfio/lib/drivers/igb/igb.c      | 381 ++++++++++++++++++
>  .../vfio/lib/drivers/igb/registers.h          | 103 +++++
>  tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
>  .../selftests/vfio/lib/vfio_pci_driver.c      |   2 +
>  4 files changed, 487 insertions(+)
>  create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/igb.c
>  create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/registers.h
> 
> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> new file mode 100644
> index 000000000000..13c8429784ac
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> @@ -0,0 +1,381 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <linux/io.h>
> +#include <linux/pci_regs.h>
> +#include <libvfio/vfio_pci_device.h>
> +
> +#include "registers.h"
> +
> +#define PCI_VENDOR_ID_INTEL 0x8086
> +#define PCI_DEVICE_ID_INTEL_IGB 0x10C9

You should be able to include <linux/pci_id.h> for these.

> +#define IGB_MAX_CHUNK_SIZE 1024
> +#define MSIX_VECTOR 0
> +#define RING_SIZE 4096 /* Number of descriptors in ring */

What's the maximum ring size that IGB can support? The max chunk size is
quite small so using a larger ring will be helpful toward getting the
device to do a lot of memcpys for Live Update testing.

> +
> +struct igb_tx_desc {
> +	union {
> +		struct {
> +			uint64_t buffer_addr; /* Address of descriptor's data buffer */
> +			uint32_t cmd_type_len; /* Command/Type/Length */
> +			uint32_t olinfo_status; /* Context/Buffer info */

Use kernel-style fixed width types (u64, u32, etc.).

> +		} read;
> +
> +		struct {
> +			uint64_t rsvd;        /* Reserved */
> +			uint32_t nxtseq_seed; /* Next sequence seed */
> +			uint32_t status;      /* Descriptor status */
> +		} wb;
> +	};
> +};
> +
> +struct igb_rx_desc {
> +	union {
> +		struct {
> +			uint64_t pkt_addr; /* Packet buffer address */
> +			uint64_t hdr_addr; /* Header buffer address */
> +		} read;
> +		struct {
> +			uint16_t pkt_info;     /* RSS type, Packet type */
> +			uint16_t hdr_info;     /* Split Head, buf len */
> +			uint32_t rss;          /* RSS Hash */
> +			uint32_t status_error; /* ext status/error */
> +			uint16_t length;       /* Packet length */
> +			uint16_t vlan;         /* VLAN tag */
> +		} wb; /* writeback */
> +	};
> +};
> +
> +struct igb {
> +	void *bar0;
> +	struct igb_tx_desc *tx_ring;
> +	struct igb_rx_desc *rx_ring;
> +	uint32_t tx_tail;
> +	uint32_t rx_tail;
> +};
> +
> +static inline struct igb *to_igb_state(struct vfio_pci_device *device)
> +{
> +	return (struct igb *)device->driver.region.vaddr;
> +}
> +
> +static inline void igb_write32(struct igb *igb, uint32_t reg, uint32_t val)
> +{
> +	writel(val, igb->bar0 + reg);
> +}
> +
> +static inline uint32_t igb_read32(struct igb *igb, uint32_t reg)
> +{
> +	return readl(igb->bar0 + reg);
> +}
> +
> +static int igb_write_phy(struct igb *igb, uint32_t offset, uint16_t data)
> +{
> +	uint32_t mdic;
> +	int i;
> +
> +	mdic = (((uint32_t)data) |
> +		(offset << IGB_MDIC_REG_SHIFT) |
> +		(1 << IGB_MDIC_PHY_SHIFT) |
> +		IGB_MDIC_OP_WRITE);
> +
> +	igb_write32(igb, IGB_MDIC, mdic);
> +
> +	for (i = 0; i < 1000; i++) {
> +		usleep(50);
> +		mdic = igb_read32(igb, IGB_MDIC);
> +		if (mdic & IGB_MDIC_READY)
> +			break;
> +	}
> +
> +	if (!(mdic & IGB_MDIC_READY))
> +		return -1;
> +
> +	if (mdic & IGB_MDIC_ERROR)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int igb_read_phy(struct igb *igb, uint32_t offset, uint16_t *data)
> +{
> +	uint32_t mdic;
> +	int i;
> +
> +	mdic = ((offset << IGB_MDIC_REG_SHIFT) |
> +		(1 << IGB_MDIC_PHY_SHIFT) |
> +		IGB_MDIC_OP_READ);
> +
> +	igb_write32(igb, IGB_MDIC, mdic);
> +
> +	for (i = 0; i < 1000; i++) {
> +		usleep(50);
> +		mdic = igb_read32(igb, IGB_MDIC);
> +		if (mdic & IGB_MDIC_READY)
> +			break;
> +	}
> +
> +	if (!(mdic & IGB_MDIC_READY))
> +		return -1;
> +
> +	if (mdic & IGB_MDIC_ERROR)
> +		return -1;
> +
> +	*data = (uint16_t)mdic;
> +	return 0;
> +}
> +
> +static int igb_phy_setup_autoneg(struct igb *igb)
> +{
> +	int timeout_ms = 1000;
> +	bool success = false;
> +	uint16_t phy_status;
> +	int ret;
> +	int i;
> +
> +	/* Trigger auto-negotiation */
> +	ret = igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
> +			    IGB_PHY_CTRL_AN_ENABLE | IGB_PHY_CTRL_RESTART_AN);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < timeout_ms; i++) {
> +		if (igb_read_phy(igb, IGB_PHY_STATUS_REG_OFFSET, &phy_status) == 0) {
> +			success = !!(phy_status & IGB_PHY_STATUS_AN_COMP);
> +			if (success)
> +				break;
> +		}
> +		usleep(1000);
> +	}
> +
> +	if (!success) {
> +		printf("igb: Auto-negotiation did not complete in time\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int igb_probe(struct vfio_pci_device *device)
> +{
> +	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IGB))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void igb_init(struct vfio_pci_device *device)
> +{
> +	struct igb *igb = to_igb_state(device);
> +	uint64_t iova_tx, iova_rx;
> +	uint32_t ctrl, rctl;
> +	uint16_t cmd_reg;
> +	int retries;
> +
> +	VFIO_ASSERT_GE(device->driver.region.size,
> +		       sizeof(struct igb) + 2 * RING_SIZE * sizeof(struct igb_tx_desc));

Please put these rings into struct igb directly rather than doing raw
pointer arithmetic and size calculations. e.g.

struct igb {
	void *bar0;
	u32 tx_tail;
	u32 rx_tail;
	struct igb_tx_desc tx_ring[RING_SIZE];
	struct igb_rx_desc rx_ring[RING_SIZE];
};

> +
> +	/* Set up rings and calculate IOVAs */
> +	igb->bar0 = device->bars[0].vaddr;
> +
> +	igb->tx_ring = (struct igb_tx_desc *)(igb + 1);
> +	igb->rx_ring = (struct igb_rx_desc *)(igb->tx_ring + RING_SIZE);
> +
> +	iova_tx = to_iova(device, igb->tx_ring);
> +	iova_rx = to_iova(device, igb->rx_ring);
> +
> +	/* Reset device and disable all interrupts */
> +	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
> +	usleep(20000);
> +	igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
> +
> +	/* Signal that the driver is loaded */
> +	ctrl = igb_read32(igb, IGB_CTRL_EXT);
> +	ctrl |= IGB_CTRL_EXT_DRV_LOAD;
> +	ctrl &= ~IGB_CTRL_EXT_LINK_MODE_MASK;
> +	igb_write32(igb, IGB_CTRL_EXT, ctrl);
> +
> +	/* Enable PCI Bus Master. */
> +	cmd_reg = vfio_pci_config_readw(device, PCI_COMMAND);
> +	if (!(cmd_reg & PCI_COMMAND_MASTER)) {
> +		cmd_reg |= (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> +		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
> +	}
> +
> +	/* Trigger autonegotiation. This enables IGB to transmit data. */
> +	if (igb_phy_setup_autoneg(igb))
> +		return;
> +
> +	/* Configure TX and RX descriptor rings */
> +	igb_write32(igb, IGB_TDBAL0, (uint32_t)iova_tx);
> +	igb_write32(igb, IGB_TDBAH0, (uint32_t)(iova_tx >> 32));
> +	igb_write32(igb, IGB_TDLEN0, RING_SIZE * sizeof(struct igb_tx_desc));
> +	igb_write32(igb, IGB_TDH0, 0);
> +	igb_write32(igb, IGB_TDT0, 0);
> +	igb_write32(igb, IGB_TXDCTL0, IGB_TXDCTL0_Q_EN);
> +
> +	igb_write32(igb, IGB_RDBAL0, (uint32_t)iova_rx);
> +	igb_write32(igb, IGB_RDBAH0, (uint32_t)(iova_rx >> 32));
> +	igb_write32(igb, IGB_RDLEN0, RING_SIZE * sizeof(struct igb_rx_desc));
> +	igb_write32(igb, IGB_RDH0, 0);
> +	igb_write32(igb, IGB_RDT0, 0);
> +	igb_write32(igb, IGB_RXDCTL0, IGB_RXDCTL0_Q_EN);
> +
> +	/* Wait for TX and RX queues to be enabled */
> +	retries = 2000;
> +	while (retries-- > 0) {
> +		if ((igb_read32(igb, IGB_TXDCTL0) & IGB_TXDCTL0_Q_EN) &&
> +		    (igb_read32(igb, IGB_RXDCTL0) & IGB_RXDCTL0_Q_EN))
> +			break;
> +		usleep(10);
> +	}
> +
> +	/* Enable Receiver and Transmitter */
> +	rctl = IGB_RCTL_EN |       /* Receiver Enable */
> +	       IGB_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
> +	       IGB_RCTL_LBM_MAC |  /* MAC Loopback Mode */
> +	       IGB_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> +	igb_write32(igb, IGB_RCTL, rctl);
> +	igb_write32(igb, IGB_TCTL, IGB_TCTL_EN);
> +
> +	/* Enable MSI-X with 1 vector for the test */
> +	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> +
> +	/* Enable auto-masking of interrupts to avoid storms without a real ISR */
> +	igb_write32(igb, IGB_GPIE, IGB_GPIE_EIAME);
> +
> +	/* Enable interrupts on vector 0 */
> +	igb_write32(igb, IGB_EIMS, 1);
> +
> +	/* Map vector 0 to interrupt cause 0 and mark it valid */
> +	igb_write32(igb, IGB_IVAR0, IGB_IVAR_VALID);
> +
> +	/* Initialize driver state and capability limits */
> +	igb->tx_tail = 0;
> +	igb->rx_tail = 0;

This comment seems wrong.

> +
> +	device->driver.max_memcpy_size = (RING_SIZE - 1) * IGB_MAX_CHUNK_SIZE;
> +	device->driver.max_memcpy_count = RING_SIZE - 1;

The device must be able to do max_memcpy_count copies of
max_memcpy_size, so max_memcpy_size should be IGB_MAX_CHUNK_SIZE.

Once you do this you can also get rid of the chunking loop in
memcpy_start().

> +	device->driver.msi = MSIX_VECTOR;
> +}
> +
> +static void igb_remove(struct vfio_pci_device *device)
> +{
> +	struct igb *igb = to_igb_state(device);
> +
> +	vfio_pci_msix_disable(device);
> +	igb_write32(igb, IGB_RCTL, 0);
> +	igb_write32(igb, IGB_TCTL, 0);
> +	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
> +}
> +
> +static void igb_irq_disable(struct igb *igb)
> +{
> +	igb_write32(igb, IGB_EIMC, 1);
> +}
> +
> +static void igb_irq_enable(struct igb *igb)
> +{
> +	igb_write32(igb, IGB_EIMS, 1);
> +}
> +
> +static void igb_irq_clear(struct igb *igb)
> +{
> +	igb_read32(igb, IGB_EICR);
> +}
> +
> +static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
> +			     iova_t dst, u64 size, u64 count)
> +{
> +	struct igb *igb = to_igb_state(device);
> +	iova_t curr_src, curr_dst;
> +	struct igb_rx_desc *rx;
> +	struct igb_tx_desc *tx;
> +	u64 chunk_size;
> +	u64 remaining;
> +	uint32_t i;
> +
> +	igb_irq_disable(igb);
> +
> +	for (i = 0; i < count; i++) {
> +		curr_src = src;
> +		curr_dst = dst;
> +		remaining = size;
> +
> +		while (remaining > 0) {
> +			chunk_size = min_t(u64, remaining, IGB_MAX_CHUNK_SIZE);
> +
> +			tx = &igb->tx_ring[igb->tx_tail];
> +			rx = &igb->rx_ring[igb->rx_tail];
> +
> +			memset(tx, 0, sizeof(struct igb_tx_desc));
> +			memset(rx, 0, sizeof(struct igb_rx_desc));
> +
> +			rx->read.pkt_addr = curr_dst;
> +			rx->read.hdr_addr = 0;
> +			rx->wb.status_error = 0;

Don't rx->read.hdr_addr and rx->wb.status_error overlap the same u64?
It's not a bug since both write 0 but it is weird.

> +
> +			tx->read.buffer_addr = curr_src;
> +			tx->read.cmd_type_len = (uint32_t)chunk_size;
> +			tx->read.cmd_type_len |= (uint32_t)(IGB_TXD_CMD_EOP) << IGB_TXD_CMD_SHIFT;
> +
> +			/* Set to 0 to disable offloads and avoid needing a context descriptor */
> +			tx->read.olinfo_status = 0;
> +
> +			curr_src += chunk_size;
> +			curr_dst += chunk_size;
> +			remaining -= chunk_size;
> +
> +			igb->tx_tail = (igb->tx_tail + 1) % RING_SIZE;
> +			igb->rx_tail = (igb->rx_tail + 1) % RING_SIZE;
> +		}
> +	}
> +
> +	igb_write32(igb, IGB_RDT0, igb->rx_tail);
> +	igb_write32(igb, IGB_TDT0, igb->tx_tail);
> +}
> +
> +static int igb_memcpy_wait(struct vfio_pci_device *device)
> +{
> +	struct igb *igb = to_igb_state(device);
> +	struct igb_rx_desc *rx;
> +	uint32_t prev_tail;
> +	int retries;
> +
> +	prev_tail = (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
> +	rx = &igb->rx_ring[prev_tail];
> +
> +	retries = 100;
> +	while (retries-- > 0) {
> +		if (rx->wb.status_error & 1)
> +			break;
> +		usleep(10);
> +	}

Why bail after a certain timeout? The test may have kicked off a large
count of memcpys. Is this for error detection?

> +
> +	igb_irq_clear(igb);
> +
> +	igb_irq_enable(igb);
> +
> +	if (rx->wb.status_error & 1)
> +		return 0;
> +
> +	return -ETIMEDOUT;

Is there any other way to the device signals errors other than failing
to set bit 0 of status_error? I'm especially curious how it handles
memcpy_from_unmapped_iova in vfio_pci_driver_test.c.

> +}
> +
> +static void igb_send_msi(struct vfio_pci_device *device)
> +{
> +	struct igb *igb = to_igb_state(device);
> +
> +	igb_write32(igb, IGB_EICS, 1);
> +}
> +
> +const struct vfio_pci_driver_ops igb_ops = {
> +	.name = "igb",
> +	.probe = igb_probe,
> +	.init = igb_init,
> +	.remove = igb_remove,
> +	.memcpy_start = igb_memcpy_start,
> +	.memcpy_wait = igb_memcpy_wait,
> +	.send_msi = igb_send_msi,
> +};
> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
> new file mode 100644
> index 000000000000..e2756be2e9c0
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _IGB_REGISTERS_H_
> +#define _IGB_REGISTERS_H_
> +
> +/* Register Offsets (Intel 82576EB Datasheet) */
> +#define IGB_CTRL 0x00000 /* Device Control */
> +#define IGB_STATUS 0x00008 /* Device Status */
> +#define IGB_CTRL_EXT 0x00018 /* Extended Device Control */
> +#define IGB_MDIC 0x00020 /* MDI Control */
> +#define IGB_RCTL 0x00100 /* Receive Control */
> +#define IGB_TCTL 0x00400 /* Transmit Control */
> +#define IGB_SCTL 0x00420 /* SerDes Control */
> +
> +/* Interrupt Registers */
> +#define IGB_IMC 0x0150C /* Interrupt Mask Clear */
> +#define IGB_IVAR0 0x01700 /* Interrupt Vector Allocation Register 0 */
> +
> +/* Rx Ring 0 Registers */
> +#define IGB_RDBAL0 0x0C000 /* Rx Desc Base Address Low */
> +#define IGB_RDBAH0 0x0C004 /* Rx Desc Base Address High */
> +#define IGB_RDLEN0 0x0C008 /* Rx Desc Length */
> +#define IGB_RDH0 0x0C010 /* Rx Desc Head */
> +#define IGB_RDT0 0x0C018 /* Rx Desc Tail */
> +#define IGB_RXDCTL0 0x0C028 /* Rx Desc Control */
> +
> +/* Tx Ring 0 Registers */
> +#define IGB_TDBAL0 0x0E000 /* Tx Desc Base Address Low */
> +#define IGB_TDBAH0 0x0E004 /* Tx Desc Base Address High */
> +#define IGB_TDLEN0 0x0E008 /* Tx Desc Length */
> +#define IGB_TDH0 0x0E010 /* Tx Desc Head */
> +#define IGB_TDT0 0x0E018 /* Tx Desc Tail */
> +#define IGB_TXDCTL0 0x0E028 /* Tx Desc Control */
> +
> +/* Control Bit Definitions */
> +/* CTRL */
> +#define IGB_CTRL_RST (1 << 26) /* Device Reset */
> +#define IGB_CTRL_EXT_LINK_MODE_MASK (3 << 22)
> +
> +/* CTRL_EXT */
> +#define IGB_CTRL_EXT_DRV_LOAD (1 << 28) /* Driver Loaded */
> +
> +/* RCTL */
> +#define IGB_RCTL_EN (1 << 1) /* Receiver Enable */
> +#define IGB_RCTL_UPE (1 << 3) /* Unicast Promiscuous Enabled */
> +#define IGB_RCTL_LPE (1 << 5) /* Long Packet Reception Enable */
> +#define IGB_RCTL_LBM_MAC (1 << 6) /* Loopback Mode - MAC */
> +#define IGB_RCTL_SECRC (1 << 26) /* Strip Ethernet CRC */
> +
> +/* TCTL */
> +#define IGB_TCTL_EN (1 << 1) /* Transmit Enable */
> +
> +/* SCTL */
> +#define IGB_SCTL_DISABLE_SERDES_LOOPBACK (1 << 6)
> +
> +/* MDIC */
> +#define IGB_MDIC_OP_WRITE (1 << 26)
> +#define IGB_MDIC_OP_READ  (2 << 26)
> +
> +#define IGB_EICR 0x01580 /* Extended Interrupt Cause Read */
> +
> +#define IGB_RAH0 0x05404 /* Receive Address High 0 */
> +#define IGB_VMOLR0 0x05AD0 /* VM Offload Layout Register 0 */
> +
> +#define IGB_VMOLR_LPE 0x00010000 /* Long Packet Enable */
> +#define IGB_VMOLR_BAM 0x08000000 /* Broadcast Accept Mode */
> +#define IGB_RAH_POOL_1 0x00040000 /* Pool 1 assignment */
> +
> +#define IGB_EIMS 0x01524 /* Extended Interrupt Mask Set */
> +#define IGB_EICS 0x01520 /* Extended Interrupt Cause Set */
> +#define IGB_EIMC 0x01528 /* Extended Interrupt Mask Clear */
> +#define IGB_CTRL_GIO_MASTER_DISABLE (1 << 2) /* GIO Master Disable */
> +#define IGB_STATUS_GIO_MASTER_ENABLE (1 << 19) /* GIO Master Enable */
> +#define IGB_GPIE 0x01514 /* General Purpose Interrupt Enable */
> +#define IGB_TXDCTL0_Q_EN (1 << 25) /* Transmit Queue Enable */
> +#define IGB_RXDCTL0_Q_EN (1 << 25) /* Receive Queue Enable */
> +#define IGB_MRQC 0x05818 /* Multiple Receive Queues Command */
> +
> +#define IGB_MDIC_PHY_SHIFT 21 /* PHY Address Shift */
> +#define IGB_MDIC_REG_SHIFT 16 /* Register Address Shift */
> +#define IGB_MDIC_READY (1 << 28) /* MDI Data Ready */
> +#define IGB_MDIC_ERROR (1 << 29) /* MDI Error */
> +
> +#define IGB_PHY_CTRL_REG_OFFSET 0
> +#define IGB_PHY_STATUS_REG_OFFSET 1
> +#define IGB_PHY_STATUS_AN_COMP 0x0020 /* Auto-negotiation complete */
> +#define IGB_PHY_CTRL_AN_ENABLE 0x1000 /* Auto-Negotiation Enable */
> +#define IGB_PHY_CTRL_RESTART_AN 0x0200 /* Restart Auto-Negotiation */
> +
> +#define IGB_PHY_AUTONEG_ADV_REG_OFFSET 4 /* Auto-Negotiation Advertisement */
> +#define IGB_PHY_1000T_CTRL_REG_OFFSET 9 /* 1000Base-T Control */
> +#define IGB_CR_1000T_FD_CAPS 0x0200 /* Advertise 1000 Mbps Full Duplex */
> +
> +#define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
> +#define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
> +
> +#define IGB_TXD_CMD_EOP 0x01 /* End of Packet */
> +#define IGB_TXD_CMD_IFCS 0x02 /* Insert FCS */
> +#define IGB_TXD_CMD_RS 0x08 /* Report Status */
> +#define IGB_TXD_CMD_SHIFT 24 /* Shift for command bits in cmd_type_len */
> +#define IGB_TXD_CMD_LEGACY_FORMAT (1 << 20) /* Forces legacy descriptor format in QEMU */

IGB_TXD_CMD_LEGACY_FORMAT appears to be unused. I didn't check the rest.
Can you prune out the unused macros?

Related: Are these macros and/or the descriptor struct available in any
kernel headers that we could symlink into the VFIO selftests like we do
for DSA?

> +
> +#endif /* _IGB_REGISTERS_H_ */
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index 9f47bceed16f..1f13cca04348 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -12,6 +12,7 @@ LIBVFIO_C += vfio_pci_driver.c
>  ifeq ($(ARCH:x86_64=x86),x86)
>  LIBVFIO_C += drivers/ioat/ioat.c
>  LIBVFIO_C += drivers/dsa/dsa.c
> +LIBVFIO_C += drivers/igb/igb.c
>  endif
>  
>  LIBVFIO_OUTPUT := $(OUTPUT)/libvfio
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> index 6827f4a6febe..a5d0547132c4 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> @@ -5,12 +5,14 @@
>  #ifdef __x86_64__
>  extern struct vfio_pci_driver_ops dsa_ops;
>  extern struct vfio_pci_driver_ops ioat_ops;
> +extern struct vfio_pci_driver_ops igb_ops;
>  #endif
>  
>  static struct vfio_pci_driver_ops *driver_ops[] = {
>  #ifdef __x86_64__
>  	&dsa_ops,
>  	&ioat_ops,
> +	&igb_ops,
>  #endif
>  };
>  
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
