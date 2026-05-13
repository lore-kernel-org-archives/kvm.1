Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53928366560
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638385; cv=pass; b=NDbqtf28zX+HaQc4QMQUBtwN9gEcrCCK+jTNH16nt16MMtvx1iUE+QSQBSF2ehuSbtHQfSVWLqWCujj7GXK+bHfw2Y4FT624lDoGr7iIn2E1/DpII3CrEXF9uWtrtg6RLSO2gyA8lWCcFxn9PR5qZarIQxRrXkNt0pFI9JVpgZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638385; c=relaxed/simple;
	bh=ZFn/pgUe4Ls9Pv9vbwRzPQh7K7+gMF0b+RHc1DgcDX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuI7MaXbUZqrl2G/Cis3nS+eEQyCP1IDXaUMLOJtCYKn6y7MRRqY1F1xJ5d6Sq/V1t6dORIYEsXN3EJZtbBv0+McsA0F7G95NpYhidDlSxc3/0gMGIPj2Yu/1SFB+pY3xGWQwB94nq6Uiw6XzFoKrG8pAfCz9SZxPcqzJ5ZqK+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLhewuzS; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLhewuzS"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d864c23bdso7321cf.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 19:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778638381; cv=none;
        d=google.com; s=arc-20240605;
        b=LU/LAXmgZueS2E6xnAWqkK5reO+x/9o07xTZSfSG7/KpkpvFQUAMhCL4jk2rlQ5Vac
         yoAD/Ddd2r5+PeB4NkImHbsTK7xTtHZFSicEoHc/9XVMUQjAjCdBfsLIxUBDJ90NWzyB
         ovK7qEyE+UH94k2K2esr+c3eS1IW8X/5NQVHTSoBWWCHjtn0YFUnDwj2pA5grxzgp4lh
         d8OrcV9fPVMODbQssPsicNo03ObCJ0KAqxoxmqUUYdunS2+vphORCLj7658lhNUpCgRa
         zEJNzi5XnhV5QL8he8jvpfliOSqavgbdRgSW2FXOVthc6tIxJSP9S1WCMH+knHTCCZYs
         vCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=caRcgZGiuTOdObp1kOe3hguBxHMV/aHEiHCo2q2JCMk=;
        fh=tkjsRHuDOov6UOG853D+KRWxDwwJdAKVk6Q52PJyMvE=;
        b=ABN7VPcPpPDioQ8nqO5A27s0uRl8kOdBjcu++zqZpffMelM1z2cAKgL7CG2xlbXaAO
         7h31DfOoB0W9UWUAmFzGu2gnxYj5BKf6RjEvtf8rQf2gOQGJj5LEHxFtlqJLcZz1vWXZ
         pPFd1CMywZU5JBaZ3p1TYUKSsRyv70zauFgcL2jSZfArJT2+02dZPbJ4bBIPdt7a0Yjt
         bdiRKwehng0eclSh6bJPTvgsQXWbyXLuGOk8+sOCs1uSNa+KUoDVBB6zht9RFu+ZXWi1
         34mPw6Is7siIXhky/5HIRyf5E8fh6/8ZXYFukN8oIIfwgceil0CQXczNCTvAVd2eslh6
         Pm6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778638381; x=1779243181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caRcgZGiuTOdObp1kOe3hguBxHMV/aHEiHCo2q2JCMk=;
        b=eLhewuzS/pt29LMHMvetEM+n5SBFrl55S4r/GNwvOPoq6bKfyxIHg/3gKw2JOi6hlP
         8jp5JbnIRVA4drsoWyAsYgQBffJuIjDfUcev4m6RybKdOLFIMDyF/rz4EjV6iFVmeQzA
         cOD+smjvciDawfvbYoofittgSl48zCXiYLJcHalFHn8bKhzSIlFK9+NXj+hFwVV8Kl3j
         LKdbPHO62swXLV2O298MxS2kbVzXVBqUCFXBLGnCVxc3kVd8TKTKvgzzoUI4446eyMPe
         CHQDzlG2r5ymWW0iVKGT1BwodEAI13ejXoMSiczx1M3vsC4VYCFKzBx0wUarmtsq+umj
         PkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778638381; x=1779243181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=caRcgZGiuTOdObp1kOe3hguBxHMV/aHEiHCo2q2JCMk=;
        b=ST89mdMSb6y1AZJHesfvCxNDFQiidV2JRBDr+j5HcmmIUDwaJxLlcCCZF7TbKx46oy
         0wDfTR2mPjIvbkirAFR4U4Uhs30QFxw9L8+FlgmoLjya+78YcFCtOdYlXYaJr89EhyRk
         1JgZHNL0gHIr0MWCKYYKG/t0CaX5a73kptJU2n3m/r+8G+Ub5AvPmK1J5PtyvKyRS4Di
         yV0GtQscDxPQhj2luEWk+IRxJ/GP7T01yHy5zGdYtEsMxRfDiHS3ZVV1yaOpwydtgcZ9
         R28LQHKkC07BI9AN+Ltgri7VAohVi2yrS6Mw8ksqpo7+dliSK4c/7/PpXJMgdZ0lwk0q
         noXg==
X-Forwarded-Encrypted: i=1; AFNElJ/BotQzxC46xHRG4vUTwDgd8A5cVKjtSOaTQae7JgMQro6/U8l9qQVKJ7tw0ELYSO00mFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFyKRXNanr/kUvnNHPGF5rVPS8/aWm7WSNGZH5QuuvZ+Jm7Pf
	OQXYYVoygAWw71KJnZN330Aa5eF/5RXtyf+vUZ2N7h6//aMI9bAoqPpw9paH76T7bj5ZYi+ngZX
	cbT3NuNomaKxVLayXuK66tBbQ/yn4gVaWadILc98=
X-Gm-Gg: Acq92OG2UZk8lELhK0afy/IMZQ4Ox8NlkNtqsYDFHGszpNt92vj0Grjow3qKiHSPXol
	AU6a4OBLyYK3nIycretrz5Y33AGiAEjD3ooXY8ksDqe4UHp6mc0BUqY8pZqIwGbRLuoN79e/zma
	AAm6b4zj7deg1FBuhxzud0xZXNYyBySC9zcYKeCbsFsgBnzFCLSZyUASDGT1euTa16VImqePvRG
	RXD5Yb3bVgvtYctH1oQj14ibKzNBtwGfET+BjkDqqn6KcyUa+Lxak0tYYgj9T+ZqKWHNE5WiPjG
	OizHAyPyECVGNd8=
X-Received: by 2002:a05:622a:830c:b0:511:2f95:2741 with SMTP id
 d75a77b69052e-5162b15cbc7mr7296231cf.14.1778638380710; Tue, 12 May 2026
 19:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511211839.2781731-1-jrhilke@google.com> <agJqAO-RRdjMrUZJ@google.com>
In-Reply-To: <agJqAO-RRdjMrUZJ@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 12 May 2026 19:12:48 -0700
X-Gm-Features: AVHnY4I37FQycLo8APV0MUj3UWiyQH7zUeq6AOMCJ8X2XXsQH2QzJ9e6NEMg0GU
Message-ID: <CAAdrzjtiiOtw7-YL2COgZC-QSFp6LLwq+jP9V3jPKLUe0w7Y0g@mail.gmail.com>
Subject: Re: [PATCH] vfio: selftests: Add driver for IGB QEMU device
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 4:45=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-05-11 09:18 PM, Josh Hilke wrote:
> > Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
> > (IGB). IGB is fully virtualized in QEMU [1] which makes it easy to run
> > VFIO selftests without needing any specific hardware.
> >
> > IGB does not have a default memcpy operation, and memcpy is required fo=
r
> > all VFIO selftest drivers. However, IGB has a "loopback" mode which is
> > used in this driver to implement memcpy. When IGB is in loopback mode,
> > it doesn't send data out to the network. Instead, it sends data from th=
e
> > Tx queue directly to the Rx queue which points to the memcpy
> > destination, instead of sending the data out to the network.
> >
> > This driver passes all of the VFIO selftests in
> > tools/testing/selftests/vfio/ when running in QEMU. The driver has not
> > been tested using a real IGB device since the main goal of writing this
> > driver is to run VFIO selftests in QEMU without requiring any hardware.
> >
> > This command is used to test the driver. It runs
> > ./tools/testing/selftests/vfio/vfio_pci_driver_test using virtme-ng [2]=
,
> > which runs a kernel in a virtualized environment using QEMU that has a
> > copy-on-write snapshot the host filesystem.
> >
> > vng \
> >   --run arch/x86/boot/bzImage \
> >   --user root \
> >   --disable-microvm \
> >   --memory 32G \
> >   --cpus 8 \
> >   --qemu-opts=3D"-M q35,accel=3Dkvm,kernel-irqchip=3Dsplit" \
> >   --qemu-opts=3D"-device intel-iommu,intremap=3Don,caching-mode=3Don,de=
vice-iotlb=3Don" \
> >   --qemu-opts=3D"-netdev user,id=3Dnet0 -device igb,netdev=3Dnet0,addr=
=3D09.0" \
> >   --append "console=3DttyS0 earlyprintk=3DttyS0 intel_iommu=3Don iommu=
=3Dpt" \
> >   --exec "modprobe vfio-pci && \
> >           ./tools/testing/selftests/vfio/scripts/setup.sh 0000:00:09.0 =
&& \
> >           ./tools/testing/selftests/vfio/scripts/run.sh ./tools/testing=
/selftests/vfio/vfio_pci_driver_test"
> >
> > Code was written entirely by AI (Gemini) by feeding it the Intel IGB
> > specification, the code for the real IGB driver, and the QEMU
> > implementation of the IGB device. It took many iterations of prompting
> > to get the driver to pass all of the tests, and lot's of de-slopping to
> > remove unnecessary code and make the code readable.
> >
> > Code comments are also written by Gemini through iterative
> > prompting.
> >
> > This patch is based on the kvm/queue branch.
> >
> > [1] https://www.qemu.org/docs/master/system/devices/igb.html
> > [2] https://github.com/arighi/virtme-ng
> >
> > Assisted-by: Gemini:gemini-3-pro-preview
> > Signed-off-by: Josh Hilke <jrhilke@google.com>
>
> I just did a quick first pass and left some feedback. Overall I'm very
> excited to have a driver for a device supported by QEMU!
>
> > ---
> >  .../selftests/vfio/lib/drivers/igb/igb.c      | 381 ++++++++++++++++++
> >  .../vfio/lib/drivers/igb/registers.h          | 103 +++++
> >  tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
> >  .../selftests/vfio/lib/vfio_pci_driver.c      |   2 +
> >  4 files changed, 487 insertions(+)
> >  create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> >  create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/regist=
ers.h
> >
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > new file mode 100644
> > index 000000000000..13c8429784ac
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > @@ -0,0 +1,381 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <stdint.h>
> > +#include <linux/io.h>
> > +#include <linux/pci_regs.h>
> > +#include <libvfio/vfio_pci_device.h>
> > +
> > +#include "registers.h"
> > +
> > +#define PCI_VENDOR_ID_INTEL 0x8086
> > +#define PCI_DEVICE_ID_INTEL_IGB 0x10C9
>
> You should be able to include <linux/pci_id.h> for these.

PCI_VENDOR_ID_INTEL is in <linux/pci_id.h>, so I can remove that one,
but PCI_DEVICE_ID_INTEL_IGB is only defined in the private header,
drivers/net/ethernet/intel/e1000/e1000_hw.h. I added more detail about
private headers to your comment below about utilizing existing
constants from IGB header files.

>
> > +#define IGB_MAX_CHUNK_SIZE 1024
> > +#define MSIX_VECTOR 0
> > +#define RING_SIZE 4096 /* Number of descriptors in ring */
>
> What's the maximum ring size that IGB can support? The max chunk size is
> quite small so using a larger ring will be helpful toward getting the
> device to do a lot of memcpys for Live Update testing.

I can dig into QEMU code and investigate the max ring size the QEMU
IGB implementation can handle. 4096 is just the max ring size for real
the IGB in drivers/net/ethernet/intel/igb/igb.h. What's our target for
the maximum memcpy size?

> > +
> > +struct igb_tx_desc {
> > +     union {
> > +             struct {
> > +                     uint64_t buffer_addr; /* Address of descriptor's =
data buffer */
> > +                     uint32_t cmd_type_len; /* Command/Type/Length */
> > +                     uint32_t olinfo_status; /* Context/Buffer info */
>
> Use kernel-style fixed width types (u64, u32, etc.).

Will do in v2.

>
> > +             } read;
> > +
> > +             struct {
> > +                     uint64_t rsvd;        /* Reserved */
> > +                     uint32_t nxtseq_seed; /* Next sequence seed */
> > +                     uint32_t status;      /* Descriptor status */
> > +             } wb;
> > +     };
> > +};
> > +
> > +struct igb_rx_desc {
> > +     union {
> > +             struct {
> > +                     uint64_t pkt_addr; /* Packet buffer address */
> > +                     uint64_t hdr_addr; /* Header buffer address */
> > +             } read;
> > +             struct {
> > +                     uint16_t pkt_info;     /* RSS type, Packet type *=
/
> > +                     uint16_t hdr_info;     /* Split Head, buf len */
> > +                     uint32_t rss;          /* RSS Hash */
> > +                     uint32_t status_error; /* ext status/error */
> > +                     uint16_t length;       /* Packet length */
> > +                     uint16_t vlan;         /* VLAN tag */
> > +             } wb; /* writeback */
> > +     };
> > +};
> > +
> > +struct igb {
> > +     void *bar0;
> > +     struct igb_tx_desc *tx_ring;
> > +     struct igb_rx_desc *rx_ring;
> > +     uint32_t tx_tail;
> > +     uint32_t rx_tail;
> > +};
> > +
> > +static inline struct igb *to_igb_state(struct vfio_pci_device *device)
> > +{
> > +     return (struct igb *)device->driver.region.vaddr;
> > +}
> > +
> > +static inline void igb_write32(struct igb *igb, uint32_t reg, uint32_t=
 val)
> > +{
> > +     writel(val, igb->bar0 + reg);
> > +}
> > +
> > +static inline uint32_t igb_read32(struct igb *igb, uint32_t reg)
> > +{
> > +     return readl(igb->bar0 + reg);
> > +}
> > +
> > +static int igb_write_phy(struct igb *igb, uint32_t offset, uint16_t da=
ta)
> > +{
> > +     uint32_t mdic;
> > +     int i;
> > +
> > +     mdic =3D (((uint32_t)data) |
> > +             (offset << IGB_MDIC_REG_SHIFT) |
> > +             (1 << IGB_MDIC_PHY_SHIFT) |
> > +             IGB_MDIC_OP_WRITE);
> > +
> > +     igb_write32(igb, IGB_MDIC, mdic);
> > +
> > +     for (i =3D 0; i < 1000; i++) {
> > +             usleep(50);
> > +             mdic =3D igb_read32(igb, IGB_MDIC);
> > +             if (mdic & IGB_MDIC_READY)
> > +                     break;
> > +     }
> > +
> > +     if (!(mdic & IGB_MDIC_READY))
> > +             return -1;
> > +
> > +     if (mdic & IGB_MDIC_ERROR)
> > +             return -1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int igb_read_phy(struct igb *igb, uint32_t offset, uint16_t *da=
ta)
> > +{
> > +     uint32_t mdic;
> > +     int i;
> > +
> > +     mdic =3D ((offset << IGB_MDIC_REG_SHIFT) |
> > +             (1 << IGB_MDIC_PHY_SHIFT) |
> > +             IGB_MDIC_OP_READ);
> > +
> > +     igb_write32(igb, IGB_MDIC, mdic);
> > +
> > +     for (i =3D 0; i < 1000; i++) {
> > +             usleep(50);
> > +             mdic =3D igb_read32(igb, IGB_MDIC);
> > +             if (mdic & IGB_MDIC_READY)
> > +                     break;
> > +     }
> > +
> > +     if (!(mdic & IGB_MDIC_READY))
> > +             return -1;
> > +
> > +     if (mdic & IGB_MDIC_ERROR)
> > +             return -1;
> > +
> > +     *data =3D (uint16_t)mdic;
> > +     return 0;
> > +}
> > +
> > +static int igb_phy_setup_autoneg(struct igb *igb)
> > +{
> > +     int timeout_ms =3D 1000;
> > +     bool success =3D false;
> > +     uint16_t phy_status;
> > +     int ret;
> > +     int i;
> > +
> > +     /* Trigger auto-negotiation */
> > +     ret =3D igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
> > +                         IGB_PHY_CTRL_AN_ENABLE | IGB_PHY_CTRL_RESTART=
_AN);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (i =3D 0; i < timeout_ms; i++) {
> > +             if (igb_read_phy(igb, IGB_PHY_STATUS_REG_OFFSET, &phy_sta=
tus) =3D=3D 0) {
> > +                     success =3D !!(phy_status & IGB_PHY_STATUS_AN_COM=
P);
> > +                     if (success)
> > +                             break;
> > +             }
> > +             usleep(1000);
> > +     }
> > +
> > +     if (!success) {
> > +             printf("igb: Auto-negotiation did not complete in time\n"=
);
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int igb_probe(struct vfio_pci_device *device)
> > +{
> > +     if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL, PCI_DEVIC=
E_ID_INTEL_IGB))
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> > +static void igb_init(struct vfio_pci_device *device)
> > +{
> > +     struct igb *igb =3D to_igb_state(device);
> > +     uint64_t iova_tx, iova_rx;
> > +     uint32_t ctrl, rctl;
> > +     uint16_t cmd_reg;
> > +     int retries;
> > +
> > +     VFIO_ASSERT_GE(device->driver.region.size,
> > +                    sizeof(struct igb) + 2 * RING_SIZE * sizeof(struct=
 igb_tx_desc));
>
> Please put these rings into struct igb directly rather than doing raw
> pointer arithmetic and size calculations. e.g.

Will do in v2.

> struct igb {
>         void *bar0;
>         u32 tx_tail;
>         u32 rx_tail;
>         struct igb_tx_desc tx_ring[RING_SIZE];
>         struct igb_rx_desc rx_ring[RING_SIZE];
> };
>
> > +
> > +     /* Set up rings and calculate IOVAs */
> > +     igb->bar0 =3D device->bars[0].vaddr;
> > +
> > +     igb->tx_ring =3D (struct igb_tx_desc *)(igb + 1);
> > +     igb->rx_ring =3D (struct igb_rx_desc *)(igb->tx_ring + RING_SIZE)=
;
> > +
> > +     iova_tx =3D to_iova(device, igb->tx_ring);
> > +     iova_rx =3D to_iova(device, igb->rx_ring);
> > +
> > +     /* Reset device and disable all interrupts */
> > +     igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_R=
ST);
> > +     usleep(20000);
> > +     igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
> > +
> > +     /* Signal that the driver is loaded */
> > +     ctrl =3D igb_read32(igb, IGB_CTRL_EXT);
> > +     ctrl |=3D IGB_CTRL_EXT_DRV_LOAD;
> > +     ctrl &=3D ~IGB_CTRL_EXT_LINK_MODE_MASK;
> > +     igb_write32(igb, IGB_CTRL_EXT, ctrl);
> > +
> > +     /* Enable PCI Bus Master. */
> > +     cmd_reg =3D vfio_pci_config_readw(device, PCI_COMMAND);
> > +     if (!(cmd_reg & PCI_COMMAND_MASTER)) {
> > +             cmd_reg |=3D (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> > +             vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
> > +     }
> > +
> > +     /* Trigger autonegotiation. This enables IGB to transmit data. */
> > +     if (igb_phy_setup_autoneg(igb))
> > +             return;
> > +
> > +     /* Configure TX and RX descriptor rings */
> > +     igb_write32(igb, IGB_TDBAL0, (uint32_t)iova_tx);
> > +     igb_write32(igb, IGB_TDBAH0, (uint32_t)(iova_tx >> 32));
> > +     igb_write32(igb, IGB_TDLEN0, RING_SIZE * sizeof(struct igb_tx_des=
c));
> > +     igb_write32(igb, IGB_TDH0, 0);
> > +     igb_write32(igb, IGB_TDT0, 0);
> > +     igb_write32(igb, IGB_TXDCTL0, IGB_TXDCTL0_Q_EN);
> > +
> > +     igb_write32(igb, IGB_RDBAL0, (uint32_t)iova_rx);
> > +     igb_write32(igb, IGB_RDBAH0, (uint32_t)(iova_rx >> 32));
> > +     igb_write32(igb, IGB_RDLEN0, RING_SIZE * sizeof(struct igb_rx_des=
c));
> > +     igb_write32(igb, IGB_RDH0, 0);
> > +     igb_write32(igb, IGB_RDT0, 0);
> > +     igb_write32(igb, IGB_RXDCTL0, IGB_RXDCTL0_Q_EN);
> > +
> > +     /* Wait for TX and RX queues to be enabled */
> > +     retries =3D 2000;
> > +     while (retries-- > 0) {
> > +             if ((igb_read32(igb, IGB_TXDCTL0) & IGB_TXDCTL0_Q_EN) &&
> > +                 (igb_read32(igb, IGB_RXDCTL0) & IGB_RXDCTL0_Q_EN))
> > +                     break;
> > +             usleep(10);
> > +     }
> > +
> > +     /* Enable Receiver and Transmitter */
> > +     rctl =3D IGB_RCTL_EN |       /* Receiver Enable */
> > +            IGB_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC)=
 */
> > +            IGB_RCTL_LBM_MAC |  /* MAC Loopback Mode */
> > +            IGB_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> > +     igb_write32(igb, IGB_RCTL, rctl);
> > +     igb_write32(igb, IGB_TCTL, IGB_TCTL_EN);
> > +
> > +     /* Enable MSI-X with 1 vector for the test */
> > +     vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> > +
> > +     /* Enable auto-masking of interrupts to avoid storms without a re=
al ISR */
> > +     igb_write32(igb, IGB_GPIE, IGB_GPIE_EIAME);
> > +
> > +     /* Enable interrupts on vector 0 */
> > +     igb_write32(igb, IGB_EIMS, 1);
> > +
> > +     /* Map vector 0 to interrupt cause 0 and mark it valid */
> > +     igb_write32(igb, IGB_IVAR0, IGB_IVAR_VALID);
> > +
> > +     /* Initialize driver state and capability limits */
> > +     igb->tx_tail =3D 0;
> > +     igb->rx_tail =3D 0;
>
> This comment seems wrong.

Ah, yea, looks like some stuff got shuffled around during refactoring.
I'll fix it in v2.

> > +
> > +     device->driver.max_memcpy_size =3D (RING_SIZE - 1) * IGB_MAX_CHUN=
K_SIZE;
> > +     device->driver.max_memcpy_count =3D RING_SIZE - 1;
>
> The device must be able to do max_memcpy_count copies of
> max_memcpy_size, so max_memcpy_size should be IGB_MAX_CHUNK_SIZE.
>
> Once you do this you can also get rid of the chunking loop in
> memcpy_start().

Got it. Will do in v2.

>
> > +     device->driver.msi =3D MSIX_VECTOR;
> > +}
> > +
> > +static void igb_remove(struct vfio_pci_device *device)
> > +{
> > +     struct igb *igb =3D to_igb_state(device);
> > +
> > +     vfio_pci_msix_disable(device);
> > +     igb_write32(igb, IGB_RCTL, 0);
> > +     igb_write32(igb, IGB_TCTL, 0);
> > +     igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_R=
ST);
> > +}
> > +
> > +static void igb_irq_disable(struct igb *igb)
> > +{
> > +     igb_write32(igb, IGB_EIMC, 1);
> > +}
> > +
> > +static void igb_irq_enable(struct igb *igb)
> > +{
> > +     igb_write32(igb, IGB_EIMS, 1);
> > +}
> > +
> > +static void igb_irq_clear(struct igb *igb)
> > +{
> > +     igb_read32(igb, IGB_EICR);
> > +}
> > +
> > +static void igb_memcpy_start(struct vfio_pci_device *device, iova_t sr=
c,
> > +                          iova_t dst, u64 size, u64 count)
> > +{
> > +     struct igb *igb =3D to_igb_state(device);
> > +     iova_t curr_src, curr_dst;
> > +     struct igb_rx_desc *rx;
> > +     struct igb_tx_desc *tx;
> > +     u64 chunk_size;
> > +     u64 remaining;
> > +     uint32_t i;
> > +
> > +     igb_irq_disable(igb);
> > +
> > +     for (i =3D 0; i < count; i++) {
> > +             curr_src =3D src;
> > +             curr_dst =3D dst;
> > +             remaining =3D size;
> > +
> > +             while (remaining > 0) {
> > +                     chunk_size =3D min_t(u64, remaining, IGB_MAX_CHUN=
K_SIZE);
> > +
> > +                     tx =3D &igb->tx_ring[igb->tx_tail];
> > +                     rx =3D &igb->rx_ring[igb->rx_tail];
> > +
> > +                     memset(tx, 0, sizeof(struct igb_tx_desc));
> > +                     memset(rx, 0, sizeof(struct igb_rx_desc));
> > +
> > +                     rx->read.pkt_addr =3D curr_dst;
> > +                     rx->read.hdr_addr =3D 0;
> > +                     rx->wb.status_error =3D 0;
>
> Don't rx->read.hdr_addr and rx->wb.status_error overlap the same u64?
> It's not a bug since both write 0 but it is weird.

That's correct, they overlap. I agree it's a bit weird -- it's a
hardware optimization to save memory. This layout is also how the real
descriptor (`e1000_adv_rx_desc`) is structured in
drivers/net/ethernet/intel/igb/e1000_82575.h.  The QEMU IGB
implementation also assumes this layout for the bits.

>
> > +
> > +                     tx->read.buffer_addr =3D curr_src;
> > +                     tx->read.cmd_type_len =3D (uint32_t)chunk_size;
> > +                     tx->read.cmd_type_len |=3D (uint32_t)(IGB_TXD_CMD=
_EOP) << IGB_TXD_CMD_SHIFT;
> > +
> > +                     /* Set to 0 to disable offloads and avoid needing=
 a context descriptor */
> > +                     tx->read.olinfo_status =3D 0;
> > +
> > +                     curr_src +=3D chunk_size;
> > +                     curr_dst +=3D chunk_size;
> > +                     remaining -=3D chunk_size;
> > +
> > +                     igb->tx_tail =3D (igb->tx_tail + 1) % RING_SIZE;
> > +                     igb->rx_tail =3D (igb->rx_tail + 1) % RING_SIZE;
> > +             }
> > +     }
> > +
> > +     igb_write32(igb, IGB_RDT0, igb->rx_tail);
> > +     igb_write32(igb, IGB_TDT0, igb->tx_tail);
> > +}
> > +
> > +static int igb_memcpy_wait(struct vfio_pci_device *device)
> > +{
> > +     struct igb *igb =3D to_igb_state(device);
> > +     struct igb_rx_desc *rx;
> > +     uint32_t prev_tail;
> > +     int retries;
> > +
> > +     prev_tail =3D (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
> > +     rx =3D &igb->rx_ring[prev_tail];
> > +
> > +     retries =3D 100;
> > +     while (retries-- > 0) {
> > +             if (rx->wb.status_error & 1)
> > +                     break;
> > +             usleep(10);
> > +     }
>
> Why bail after a certain timeout? The test may have kicked off a large
> count of memcpys. Is this for error detection?

The bailout was intended to detect errors during development.
Shouldn't need it anymore. I'll remove it in v2.

> > +
> > +     igb_irq_clear(igb);
> > +
> > +     igb_irq_enable(igb);
> > +
> > +     if (rx->wb.status_error & 1)
> > +             return 0;
> > +
> > +     return -ETIMEDOUT;
>
> Is there any other way to the device signals errors other than failing
> to set bit 0 of status_error? I'm especially curious how it handles
> memcpy_from_unmapped_iova in vfio_pci_driver_test.c.

Yea, there are some relevant error bits in status_err, but
unfortunately QEMU IGB doesn't emulate them:
- E1000_RXDEXT_STATERR_LB: confirms that the packet actually traversed
the loopback path
- E1000_RXDEXT_STATERR_CE: detects bit flips during transmission
- E1000_RXDEXT_STATERR_RXE: catch-all error bit for the receive engine
(buffer overflows, etc.)

The other error bits (E1000_RXDEXT_STATERR_IPE,
E1000_RXDEXT_STATERR_TCPE) validate network packet integrity, which
isn't relevant because the driver doesn't package the memcpy data
within IP or TCP/UDP packets.

Regarding the memcpy_from_unmapped_iova test, the test only cares that
the device doesn't trigger an MSI. Normally, the QEMU IGB sends an MSI
once it sets the descriptor done bit on completion of a memcpy
operation. To prevent this, the driver disables interrupts before
starting memcpy, and then re-enables them after the memcpy finishes.

> > +}
> > +
> > +static void igb_send_msi(struct vfio_pci_device *device)
> > +{
> > +     struct igb *igb =3D to_igb_state(device);
> > +
> > +     igb_write32(igb, IGB_EICS, 1);
> > +}
> > +
> > +const struct vfio_pci_driver_ops igb_ops =3D {
> > +     .name =3D "igb",
> > +     .probe =3D igb_probe,
> > +     .init =3D igb_init,
> > +     .remove =3D igb_remove,
> > +     .memcpy_start =3D igb_memcpy_start,
> > +     .memcpy_wait =3D igb_memcpy_wait,
> > +     .send_msi =3D igb_send_msi,
> > +};
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b=
/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
> > new file mode 100644
> > index 000000000000..e2756be2e9c0
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
> > @@ -0,0 +1,103 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef _IGB_REGISTERS_H_
> > +#define _IGB_REGISTERS_H_
> > +
> > +/* Register Offsets (Intel 82576EB Datasheet) */
> > +#define IGB_CTRL 0x00000 /* Device Control */
> > +#define IGB_STATUS 0x00008 /* Device Status */
> > +#define IGB_CTRL_EXT 0x00018 /* Extended Device Control */
> > +#define IGB_MDIC 0x00020 /* MDI Control */
> > +#define IGB_RCTL 0x00100 /* Receive Control */
> > +#define IGB_TCTL 0x00400 /* Transmit Control */
> > +#define IGB_SCTL 0x00420 /* SerDes Control */
> > +
> > +/* Interrupt Registers */
> > +#define IGB_IMC 0x0150C /* Interrupt Mask Clear */
> > +#define IGB_IVAR0 0x01700 /* Interrupt Vector Allocation Register 0 */
> > +
> > +/* Rx Ring 0 Registers */
> > +#define IGB_RDBAL0 0x0C000 /* Rx Desc Base Address Low */
> > +#define IGB_RDBAH0 0x0C004 /* Rx Desc Base Address High */
> > +#define IGB_RDLEN0 0x0C008 /* Rx Desc Length */
> > +#define IGB_RDH0 0x0C010 /* Rx Desc Head */
> > +#define IGB_RDT0 0x0C018 /* Rx Desc Tail */
> > +#define IGB_RXDCTL0 0x0C028 /* Rx Desc Control */
> > +
> > +/* Tx Ring 0 Registers */
> > +#define IGB_TDBAL0 0x0E000 /* Tx Desc Base Address Low */
> > +#define IGB_TDBAH0 0x0E004 /* Tx Desc Base Address High */
> > +#define IGB_TDLEN0 0x0E008 /* Tx Desc Length */
> > +#define IGB_TDH0 0x0E010 /* Tx Desc Head */
> > +#define IGB_TDT0 0x0E018 /* Tx Desc Tail */
> > +#define IGB_TXDCTL0 0x0E028 /* Tx Desc Control */
> > +
> > +/* Control Bit Definitions */
> > +/* CTRL */
> > +#define IGB_CTRL_RST (1 << 26) /* Device Reset */
> > +#define IGB_CTRL_EXT_LINK_MODE_MASK (3 << 22)
> > +
> > +/* CTRL_EXT */
> > +#define IGB_CTRL_EXT_DRV_LOAD (1 << 28) /* Driver Loaded */
> > +
> > +/* RCTL */
> > +#define IGB_RCTL_EN (1 << 1) /* Receiver Enable */
> > +#define IGB_RCTL_UPE (1 << 3) /* Unicast Promiscuous Enabled */
> > +#define IGB_RCTL_LPE (1 << 5) /* Long Packet Reception Enable */
> > +#define IGB_RCTL_LBM_MAC (1 << 6) /* Loopback Mode - MAC */
> > +#define IGB_RCTL_SECRC (1 << 26) /* Strip Ethernet CRC */
> > +
> > +/* TCTL */
> > +#define IGB_TCTL_EN (1 << 1) /* Transmit Enable */
> > +
> > +/* SCTL */
> > +#define IGB_SCTL_DISABLE_SERDES_LOOPBACK (1 << 6)
> > +
> > +/* MDIC */
> > +#define IGB_MDIC_OP_WRITE (1 << 26)
> > +#define IGB_MDIC_OP_READ  (2 << 26)
> > +
> > +#define IGB_EICR 0x01580 /* Extended Interrupt Cause Read */
> > +
> > +#define IGB_RAH0 0x05404 /* Receive Address High 0 */
> > +#define IGB_VMOLR0 0x05AD0 /* VM Offload Layout Register 0 */
> > +
> > +#define IGB_VMOLR_LPE 0x00010000 /* Long Packet Enable */
> > +#define IGB_VMOLR_BAM 0x08000000 /* Broadcast Accept Mode */
> > +#define IGB_RAH_POOL_1 0x00040000 /* Pool 1 assignment */
> > +
> > +#define IGB_EIMS 0x01524 /* Extended Interrupt Mask Set */
> > +#define IGB_EICS 0x01520 /* Extended Interrupt Cause Set */
> > +#define IGB_EIMC 0x01528 /* Extended Interrupt Mask Clear */
> > +#define IGB_CTRL_GIO_MASTER_DISABLE (1 << 2) /* GIO Master Disable */
> > +#define IGB_STATUS_GIO_MASTER_ENABLE (1 << 19) /* GIO Master Enable */
> > +#define IGB_GPIE 0x01514 /* General Purpose Interrupt Enable */
> > +#define IGB_TXDCTL0_Q_EN (1 << 25) /* Transmit Queue Enable */
> > +#define IGB_RXDCTL0_Q_EN (1 << 25) /* Receive Queue Enable */
> > +#define IGB_MRQC 0x05818 /* Multiple Receive Queues Command */
> > +
> > +#define IGB_MDIC_PHY_SHIFT 21 /* PHY Address Shift */
> > +#define IGB_MDIC_REG_SHIFT 16 /* Register Address Shift */
> > +#define IGB_MDIC_READY (1 << 28) /* MDI Data Ready */
> > +#define IGB_MDIC_ERROR (1 << 29) /* MDI Error */
> > +
> > +#define IGB_PHY_CTRL_REG_OFFSET 0
> > +#define IGB_PHY_STATUS_REG_OFFSET 1
> > +#define IGB_PHY_STATUS_AN_COMP 0x0020 /* Auto-negotiation complete */
> > +#define IGB_PHY_CTRL_AN_ENABLE 0x1000 /* Auto-Negotiation Enable */
> > +#define IGB_PHY_CTRL_RESTART_AN 0x0200 /* Restart Auto-Negotiation */
> > +
> > +#define IGB_PHY_AUTONEG_ADV_REG_OFFSET 4 /* Auto-Negotiation Advertise=
ment */
> > +#define IGB_PHY_1000T_CTRL_REG_OFFSET 9 /* 1000Base-T Control */
> > +#define IGB_CR_1000T_FD_CAPS 0x0200 /* Advertise 1000 Mbps Full Duplex=
 */
> > +
> > +#define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
> > +#define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
> > +
> > +#define IGB_TXD_CMD_EOP 0x01 /* End of Packet */
> > +#define IGB_TXD_CMD_IFCS 0x02 /* Insert FCS */
> > +#define IGB_TXD_CMD_RS 0x08 /* Report Status */
> > +#define IGB_TXD_CMD_SHIFT 24 /* Shift for command bits in cmd_type_len=
 */
> > +#define IGB_TXD_CMD_LEGACY_FORMAT (1 << 20) /* Forces legacy descripto=
r format in QEMU */
>
> IGB_TXD_CMD_LEGACY_FORMAT appears to be unused. I didn't check the rest.
> Can you prune out the unused macros?

Yep, will do!

>
> Related: Are these macros and/or the descriptor struct available in any
> kernel headers that we could symlink into the VFIO selftests like we do
> for DSA?

They're in private headers under drivers/net/ethernet/intel/igb. Are
you ok with linking in private headers? The DSA headers are public.

> > +
> > +#endif /* _IGB_REGISTERS_H_ */
> > diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testin=
g/selftests/vfio/lib/libvfio.mk
> > index 9f47bceed16f..1f13cca04348 100644
> > --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> > +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> > @@ -12,6 +12,7 @@ LIBVFIO_C +=3D vfio_pci_driver.c
> >  ifeq ($(ARCH:x86_64=3Dx86),x86)
> >  LIBVFIO_C +=3D drivers/ioat/ioat.c
> >  LIBVFIO_C +=3D drivers/dsa/dsa.c
> > +LIBVFIO_C +=3D drivers/igb/igb.c
> >  endif
> >
> >  LIBVFIO_OUTPUT :=3D $(OUTPUT)/libvfio
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools=
/testing/selftests/vfio/lib/vfio_pci_driver.c
> > index 6827f4a6febe..a5d0547132c4 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> > @@ -5,12 +5,14 @@
> >  #ifdef __x86_64__
> >  extern struct vfio_pci_driver_ops dsa_ops;
> >  extern struct vfio_pci_driver_ops ioat_ops;
> > +extern struct vfio_pci_driver_ops igb_ops;
> >  #endif
> >
> >  static struct vfio_pci_driver_ops *driver_ops[] =3D {
> >  #ifdef __x86_64__
> >       &dsa_ops,
> >       &ioat_ops,
> > +     &igb_ops,
> >  #endif
> >  };
> >
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
