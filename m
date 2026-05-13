Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03033F4112
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698194; cv=pass; b=pjD0GmqBlATO+AVP2tUll00paE6yfKXDjMdDoU+zgBou7YYMswWl2GurmTl3g8y3gozLoBI4nfP2a9UMdz0zGT7hOpNOAZbc7aYfM9SapGbketB/ABxc2n9cKQ46f9pULrDF01gkMJQXf22j3IwsK1RVtKBDvXjP3rBE9YYGhgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698194; c=relaxed/simple;
	bh=i4uuQE0fHNETvdfrlwXYs0SUJ9Hr0U9mn5RmVNPTzSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPDUdvqBbLkHu7dk094yqKDfWN83e3jbKwoORbN7wQurRdVGFYEdBXs8tMbiOS/TDwukiN4prXMAUdN1Orz87rC52bYjR2Nc68gqZ2zO9lAbgGpKxbigHZ9xwcqb7MTX0NblpbbrZ9DMyVjU9N7l4xwEaR0uTMAuRjzF7+OxopE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlkoRlKK; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlkoRlKK"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d864c23bdso21151cf.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 11:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778698191; cv=none;
        d=google.com; s=arc-20240605;
        b=G5tS+z7dkECh99PURjsNg08V7EIwZmRAUpxm0MKwYDTeJUf99ZySN9TPZIY04rMclF
         HP/WFHdTUmIJhBvtizuOpXPqb+8CXV5IRPw44BhncdnKJVm/OU+UjbVG9eAyNeHXfj/K
         1PGZt7o8HUCJShQZmTSPdF1BrJmzBDoJ5W/u0ktJZIn/jNpzyhddkntmUXnDpVxldbXm
         H8lW/ubwAflN5w4+wJFnx28Cou/AwVY8Bj2NV1TWdy1bsCpZnuidpk1nTx0+DFVdewPv
         Ptg0uskv3PKFg2h9rpRf3ku8244pNUWdh0GMk3oL+gFX/xvpKg+jDLF1Tw0I8R1maFdr
         /y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmn+kTwadq538USWaPo3PQ+lROUznYRllhd6SFmenzU=;
        fh=zfDPvowZ/hzkrT0+4PrGpSJHRkmkDfU8GzICk3fKhL0=;
        b=QFVS/UVvAYuixkpwYntycpJNxKrF/uvmml18y/zDw51g7FGGN+rgMgFaFEBhbVzAct
         US+8d6lV7F/cDwxSBHJMO9Oci2HYI/ZhUf6hl3BndmG6QnDSqyAT4nNm/aDy8bV5s4I4
         3xNJGOkCMqlwfATFH3W/oYerNMaojWYcvdVkGNuH/UrgqEv2ewND3s/RvOBb+G/4a0M9
         YNt+xJnQwL0yMKVPDSwzOoKktzKFaLsV43npiVF705zebENirYipwN269goi6/wGI+pT
         O1TDRWmDSwyeiyoP7xGnxxo+SisvaOQEXCB1u/vPR+Zx79mAMaoiTcNNCTeGBmynVf34
         66aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778698191; x=1779302991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmn+kTwadq538USWaPo3PQ+lROUznYRllhd6SFmenzU=;
        b=DlkoRlKKsuVXAy8VK42MDLM5iG7qD15krGHr8rmXIEdcqXBrYDbGiEycHga4pVZ0YZ
         D0FaV3GvkTE0eh38s7wmv34YM9ADm54RzdTg1MGu+JzQklyqE63Ia4ShdSrM72tdO3JJ
         HWfRPh11pzlrpdoXw5FL0AQmUTP/Tbespk4dV70jnSIMmBMdWaTWAjpCurPrDhqEyw4u
         P/AWvpOxJos7d154Zd7Lk/ZS9lOKT4F6rVQp7QJNC3c80HGe5ZamsQAcSN1nkR4l0ohW
         tgN21MdcoqUBCkSYrvKVB7vHAbwMuoFNkTFEzAdNK6jP+9v6R14stYkeCwQ3QlNa1Ejo
         yBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698191; x=1779302991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmn+kTwadq538USWaPo3PQ+lROUznYRllhd6SFmenzU=;
        b=hCQdZhLh3yfn/f/VMcK5VyYe8qWLQ1iV56MWEc94Y7tQGJR7CzaZQnPLCDAvE7Jt4u
         XbYD2cZ3ZtwTUCTGoZYfTct9FP1VxUmm+JSO5t+vqmFXIaVgc7F+Caok2Ya04gkVuong
         P1amgFevVWI715MBsOw0Zj+YU/vTaEmmv2i/2VfNu8IGvmrqMeZVRvB/E+4KzavN1N+m
         crHPagv4+yExfveWJqquM4mxCzklWpno1XGZKd09YTJB0RFmk8r99Jm8xfwU/AbJs/LA
         Wq8FyLgedJrmZrF0riB7a1eNbdqAFDOC07gD6mz6k5UYi8QMSPdV7vGaAF4WhTVmTHAW
         MxqA==
X-Forwarded-Encrypted: i=1; AFNElJ9utYmRQu9q2obm11gkzyVDPsZLqTHIoo5WW1V8EGa6X3ipaJwJJ2OBzMOyWnIKlXAEiT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXY1Ahq3lIde1OxM9YRtrH5M9HWS2OZtHSi4cFc+/y8AfB0Xg
	wVWGgkTasMr+D7vhz+jAIX+rAKn7N1do+Ox9mdpFyztDycresfXUmuMOeRd4JjNO2iTQASotNw3
	/qEbnyaVVp5aMMKP9QLNNHfAAvJX7/Wl1/SZRuQY=
X-Gm-Gg: Acq92OHxN16k+0WdNUg3Xtp/strNNp1XX8nZv/6NBj2gydrhteLxlkyzM/Z5Vfqrgws
	q6Z2X1pL3EeI4nwRTESn+aKrhJEE05ppr9LD6zLJrzP0jt8h4B2gZpTpf0rTPOcH3UwQUnmqbjX
	r1qAKKfjgogqAPP0Nxh0N1kFoEIzpYrO/Y14PTAKM1ywmu0hIl9uITdSVsB0qbWs/rmmL4bfeLj
	4c8oReZeagXcpdBWOr5lBK9r2SjH4/WZSjkwCNBnCRu8CBTS8bax4jU3Tv8bDdUjCMLdNWiDUjV
	gm7FnNv7bP4uyzU=
X-Received: by 2002:a05:622a:8c1c:b0:50e:5e19:587a with SMTP id
 d75a77b69052e-516424c5165mr1428691cf.3.1778698190091; Wed, 13 May 2026
 11:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511211839.2781731-1-jrhilke@google.com> <agJqAO-RRdjMrUZJ@google.com>
 <CAAdrzjtiiOtw7-YL2COgZC-QSFp6LLwq+jP9V3jPKLUe0w7Y0g@mail.gmail.com>
In-Reply-To: <CAAdrzjtiiOtw7-YL2COgZC-QSFp6LLwq+jP9V3jPKLUe0w7Y0g@mail.gmail.com>
From: Josh Hilke <jrhilke@google.com>
Date: Wed, 13 May 2026 11:49:38 -0700
X-Gm-Features: AVHnY4KWBtkTPzZAAzCaJn3vFpOEafO3ho4wjsGwRbqJRyapibEfe5cU0bFGSAg
Message-ID: <CAAdrzjuf3z-CyWeBRPKmMQxmQZ9U=2Tc0cDAFqdRFRDHKw_K-Q@mail.gmail.com>
Subject: Re: [PATCH] vfio: selftests: Add driver for IGB QEMU device
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 7:12=E2=80=AFPM Josh Hilke <jrhilke@google.com> wro=
te:
>
> On Mon, May 11, 2026 at 4:45=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On 2026-05-11 09:18 PM, Josh Hilke wrote:
> > > Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
> > > (IGB). IGB is fully virtualized in QEMU [1] which makes it easy to ru=
n
> > > VFIO selftests without needing any specific hardware.
> > >
> > > IGB does not have a default memcpy operation, and memcpy is required =
for
> > > all VFIO selftest drivers. However, IGB has a "loopback" mode which i=
s
> > > used in this driver to implement memcpy. When IGB is in loopback mode=
,
> > > it doesn't send data out to the network. Instead, it sends data from =
the
> > > Tx queue directly to the Rx queue which points to the memcpy
> > > destination, instead of sending the data out to the network.
> > >
> > > This driver passes all of the VFIO selftests in
> > > tools/testing/selftests/vfio/ when running in QEMU. The driver has no=
t
> > > been tested using a real IGB device since the main goal of writing th=
is
> > > driver is to run VFIO selftests in QEMU without requiring any hardwar=
e.
> > >
> > > This command is used to test the driver. It runs
> > > ./tools/testing/selftests/vfio/vfio_pci_driver_test using virtme-ng [=
2],
> > > which runs a kernel in a virtualized environment using QEMU that has =
a
> > > copy-on-write snapshot the host filesystem.
> > >
> > > vng \
> > >   --run arch/x86/boot/bzImage \
> > >   --user root \
> > >   --disable-microvm \
> > >   --memory 32G \
> > >   --cpus 8 \
> > >   --qemu-opts=3D"-M q35,accel=3Dkvm,kernel-irqchip=3Dsplit" \
> > >   --qemu-opts=3D"-device intel-iommu,intremap=3Don,caching-mode=3Don,=
device-iotlb=3Don" \
> > >   --qemu-opts=3D"-netdev user,id=3Dnet0 -device igb,netdev=3Dnet0,add=
r=3D09.0" \
> > >   --append "console=3DttyS0 earlyprintk=3DttyS0 intel_iommu=3Don iomm=
u=3Dpt" \
> > >   --exec "modprobe vfio-pci && \
> > >           ./tools/testing/selftests/vfio/scripts/setup.sh 0000:00:09.=
0 && \
> > >           ./tools/testing/selftests/vfio/scripts/run.sh ./tools/testi=
ng/selftests/vfio/vfio_pci_driver_test"
> > >
> > > Code was written entirely by AI (Gemini) by feeding it the Intel IGB
> > > specification, the code for the real IGB driver, and the QEMU
> > > implementation of the IGB device. It took many iterations of promptin=
g
> > > to get the driver to pass all of the tests, and lot's of de-slopping =
to
> > > remove unnecessary code and make the code readable.
> > >
> > > Code comments are also written by Gemini through iterative
> > > prompting.
> > >
> > > This patch is based on the kvm/queue branch.
> > >
> > > [1] https://www.qemu.org/docs/master/system/devices/igb.html
> > > [2] https://github.com/arighi/virtme-ng
> > >
> > > Assisted-by: Gemini:gemini-3-pro-preview
> > > Signed-off-by: Josh Hilke <jrhilke@google.com>
> >
> > I just did a quick first pass and left some feedback. Overall I'm very
> > excited to have a driver for a device supported by QEMU!
> >
> > > ---
> > >  .../selftests/vfio/lib/drivers/igb/igb.c      | 381 ++++++++++++++++=
++
> > >  .../vfio/lib/drivers/igb/registers.h          | 103 +++++
> > >  tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
> > >  .../selftests/vfio/lib/vfio_pci_driver.c      |   2 +
> > >  4 files changed, 487 insertions(+)
> > >  create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/igb.=
c
> > >  create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/regi=
sters.h
> > >
> > > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/too=
ls/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > new file mode 100644
> > > index 000000000000..13c8429784ac
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > @@ -0,0 +1,381 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <unistd.h>
> > > +#include <errno.h>
> > > +#include <stdint.h>
> > > +#include <linux/io.h>
> > > +#include <linux/pci_regs.h>
> > > +#include <libvfio/vfio_pci_device.h>
> > > +
> > > +#include "registers.h"
> > > +
> > > +#define PCI_VENDOR_ID_INTEL 0x8086
> > > +#define PCI_DEVICE_ID_INTEL_IGB 0x10C9
> >
> > You should be able to include <linux/pci_id.h> for these.
>
> PCI_VENDOR_ID_INTEL is in <linux/pci_id.h>, so I can remove that one,
> but PCI_DEVICE_ID_INTEL_IGB is only defined in the private header,
> drivers/net/ethernet/intel/e1000/e1000_hw.h. I added more detail about
> private headers to your comment below about utilizing existing
> constants from IGB header files.
>
> >
> > > +#define IGB_MAX_CHUNK_SIZE 1024
> > > +#define MSIX_VECTOR 0
> > > +#define RING_SIZE 4096 /* Number of descriptors in ring */
> >
> > What's the maximum ring size that IGB can support? The max chunk size i=
s
> > quite small so using a larger ring will be helpful toward getting the
> > device to do a lot of memcpys for Live Update testing.
>
> I can dig into QEMU code and investigate the max ring size the QEMU
> IGB implementation can handle. 4096 is just the max ring size for real
> the IGB in drivers/net/ethernet/intel/igb/igb.h. What's our target for
> the maximum memcpy size?
>
> > > +
> > > +struct igb_tx_desc {
> > > +     union {
> > > +             struct {
> > > +                     uint64_t buffer_addr; /* Address of descriptor'=
s data buffer */
> > > +                     uint32_t cmd_type_len; /* Command/Type/Length *=
/
> > > +                     uint32_t olinfo_status; /* Context/Buffer info =
*/
> >
> > Use kernel-style fixed width types (u64, u32, etc.).
>
> Will do in v2.
>
> >
> > > +             } read;
> > > +
> > > +             struct {
> > > +                     uint64_t rsvd;        /* Reserved */
> > > +                     uint32_t nxtseq_seed; /* Next sequence seed */
> > > +                     uint32_t status;      /* Descriptor status */
> > > +             } wb;
> > > +     };
> > > +};
> > > +
> > > +struct igb_rx_desc {
> > > +     union {
> > > +             struct {
> > > +                     uint64_t pkt_addr; /* Packet buffer address */
> > > +                     uint64_t hdr_addr; /* Header buffer address */
> > > +             } read;
> > > +             struct {
> > > +                     uint16_t pkt_info;     /* RSS type, Packet type=
 */
> > > +                     uint16_t hdr_info;     /* Split Head, buf len *=
/
> > > +                     uint32_t rss;          /* RSS Hash */
> > > +                     uint32_t status_error; /* ext status/error */
> > > +                     uint16_t length;       /* Packet length */
> > > +                     uint16_t vlan;         /* VLAN tag */
> > > +             } wb; /* writeback */
> > > +     };
> > > +};
> > > +
> > > +struct igb {
> > > +     void *bar0;
> > > +     struct igb_tx_desc *tx_ring;
> > > +     struct igb_rx_desc *rx_ring;
> > > +     uint32_t tx_tail;
> > > +     uint32_t rx_tail;
> > > +};
> > > +
> > > +static inline struct igb *to_igb_state(struct vfio_pci_device *devic=
e)
> > > +{
> > > +     return (struct igb *)device->driver.region.vaddr;
> > > +}
> > > +
> > > +static inline void igb_write32(struct igb *igb, uint32_t reg, uint32=
_t val)
> > > +{
> > > +     writel(val, igb->bar0 + reg);
> > > +}
> > > +
> > > +static inline uint32_t igb_read32(struct igb *igb, uint32_t reg)
> > > +{
> > > +     return readl(igb->bar0 + reg);
> > > +}
> > > +
> > > +static int igb_write_phy(struct igb *igb, uint32_t offset, uint16_t =
data)
> > > +{
> > > +     uint32_t mdic;
> > > +     int i;
> > > +
> > > +     mdic =3D (((uint32_t)data) |
> > > +             (offset << IGB_MDIC_REG_SHIFT) |
> > > +             (1 << IGB_MDIC_PHY_SHIFT) |
> > > +             IGB_MDIC_OP_WRITE);
> > > +
> > > +     igb_write32(igb, IGB_MDIC, mdic);
> > > +
> > > +     for (i =3D 0; i < 1000; i++) {
> > > +             usleep(50);
> > > +             mdic =3D igb_read32(igb, IGB_MDIC);
> > > +             if (mdic & IGB_MDIC_READY)
> > > +                     break;
> > > +     }
> > > +
> > > +     if (!(mdic & IGB_MDIC_READY))
> > > +             return -1;
> > > +
> > > +     if (mdic & IGB_MDIC_ERROR)
> > > +             return -1;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int igb_read_phy(struct igb *igb, uint32_t offset, uint16_t *=
data)
> > > +{
> > > +     uint32_t mdic;
> > > +     int i;
> > > +
> > > +     mdic =3D ((offset << IGB_MDIC_REG_SHIFT) |
> > > +             (1 << IGB_MDIC_PHY_SHIFT) |
> > > +             IGB_MDIC_OP_READ);
> > > +
> > > +     igb_write32(igb, IGB_MDIC, mdic);
> > > +
> > > +     for (i =3D 0; i < 1000; i++) {
> > > +             usleep(50);
> > > +             mdic =3D igb_read32(igb, IGB_MDIC);
> > > +             if (mdic & IGB_MDIC_READY)
> > > +                     break;
> > > +     }
> > > +
> > > +     if (!(mdic & IGB_MDIC_READY))
> > > +             return -1;
> > > +
> > > +     if (mdic & IGB_MDIC_ERROR)
> > > +             return -1;
> > > +
> > > +     *data =3D (uint16_t)mdic;
> > > +     return 0;
> > > +}
> > > +
> > > +static int igb_phy_setup_autoneg(struct igb *igb)
> > > +{
> > > +     int timeout_ms =3D 1000;
> > > +     bool success =3D false;
> > > +     uint16_t phy_status;
> > > +     int ret;
> > > +     int i;
> > > +
> > > +     /* Trigger auto-negotiation */
> > > +     ret =3D igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
> > > +                         IGB_PHY_CTRL_AN_ENABLE | IGB_PHY_CTRL_RESTA=
RT_AN);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     for (i =3D 0; i < timeout_ms; i++) {
> > > +             if (igb_read_phy(igb, IGB_PHY_STATUS_REG_OFFSET, &phy_s=
tatus) =3D=3D 0) {
> > > +                     success =3D !!(phy_status & IGB_PHY_STATUS_AN_C=
OMP);
> > > +                     if (success)
> > > +                             break;
> > > +             }
> > > +             usleep(1000);
> > > +     }
> > > +
> > > +     if (!success) {
> > > +             printf("igb: Auto-negotiation did not complete in time\=
n");
> > > +             return -ETIMEDOUT;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int igb_probe(struct vfio_pci_device *device)
> > > +{
> > > +     if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL, PCI_DEV=
ICE_ID_INTEL_IGB))
> > > +             return -EINVAL;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void igb_init(struct vfio_pci_device *device)
> > > +{
> > > +     struct igb *igb =3D to_igb_state(device);
> > > +     uint64_t iova_tx, iova_rx;
> > > +     uint32_t ctrl, rctl;
> > > +     uint16_t cmd_reg;
> > > +     int retries;
> > > +
> > > +     VFIO_ASSERT_GE(device->driver.region.size,
> > > +                    sizeof(struct igb) + 2 * RING_SIZE * sizeof(stru=
ct igb_tx_desc));
> >
> > Please put these rings into struct igb directly rather than doing raw
> > pointer arithmetic and size calculations. e.g.
>
> Will do in v2.
>
> > struct igb {
> >         void *bar0;
> >         u32 tx_tail;
> >         u32 rx_tail;
> >         struct igb_tx_desc tx_ring[RING_SIZE];
> >         struct igb_rx_desc rx_ring[RING_SIZE];
> > };
> >
> > > +
> > > +     /* Set up rings and calculate IOVAs */
> > > +     igb->bar0 =3D device->bars[0].vaddr;
> > > +
> > > +     igb->tx_ring =3D (struct igb_tx_desc *)(igb + 1);
> > > +     igb->rx_ring =3D (struct igb_rx_desc *)(igb->tx_ring + RING_SIZ=
E);
> > > +
> > > +     iova_tx =3D to_iova(device, igb->tx_ring);
> > > +     iova_rx =3D to_iova(device, igb->rx_ring);
> > > +
> > > +     /* Reset device and disable all interrupts */
> > > +     igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL=
_RST);
> > > +     usleep(20000);
> > > +     igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
> > > +
> > > +     /* Signal that the driver is loaded */
> > > +     ctrl =3D igb_read32(igb, IGB_CTRL_EXT);
> > > +     ctrl |=3D IGB_CTRL_EXT_DRV_LOAD;
> > > +     ctrl &=3D ~IGB_CTRL_EXT_LINK_MODE_MASK;
> > > +     igb_write32(igb, IGB_CTRL_EXT, ctrl);
> > > +
> > > +     /* Enable PCI Bus Master. */
> > > +     cmd_reg =3D vfio_pci_config_readw(device, PCI_COMMAND);
> > > +     if (!(cmd_reg & PCI_COMMAND_MASTER)) {
> > > +             cmd_reg |=3D (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> > > +             vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
> > > +     }
> > > +
> > > +     /* Trigger autonegotiation. This enables IGB to transmit data. =
*/
> > > +     if (igb_phy_setup_autoneg(igb))
> > > +             return;
> > > +
> > > +     /* Configure TX and RX descriptor rings */
> > > +     igb_write32(igb, IGB_TDBAL0, (uint32_t)iova_tx);
> > > +     igb_write32(igb, IGB_TDBAH0, (uint32_t)(iova_tx >> 32));
> > > +     igb_write32(igb, IGB_TDLEN0, RING_SIZE * sizeof(struct igb_tx_d=
esc));
> > > +     igb_write32(igb, IGB_TDH0, 0);
> > > +     igb_write32(igb, IGB_TDT0, 0);
> > > +     igb_write32(igb, IGB_TXDCTL0, IGB_TXDCTL0_Q_EN);
> > > +
> > > +     igb_write32(igb, IGB_RDBAL0, (uint32_t)iova_rx);
> > > +     igb_write32(igb, IGB_RDBAH0, (uint32_t)(iova_rx >> 32));
> > > +     igb_write32(igb, IGB_RDLEN0, RING_SIZE * sizeof(struct igb_rx_d=
esc));
> > > +     igb_write32(igb, IGB_RDH0, 0);
> > > +     igb_write32(igb, IGB_RDT0, 0);
> > > +     igb_write32(igb, IGB_RXDCTL0, IGB_RXDCTL0_Q_EN);
> > > +
> > > +     /* Wait for TX and RX queues to be enabled */
> > > +     retries =3D 2000;
> > > +     while (retries-- > 0) {
> > > +             if ((igb_read32(igb, IGB_TXDCTL0) & IGB_TXDCTL0_Q_EN) &=
&
> > > +                 (igb_read32(igb, IGB_RXDCTL0) & IGB_RXDCTL0_Q_EN))
> > > +                     break;
> > > +             usleep(10);
> > > +     }
> > > +
> > > +     /* Enable Receiver and Transmitter */
> > > +     rctl =3D IGB_RCTL_EN |       /* Receiver Enable */
> > > +            IGB_RCTL_UPE |      /* Unicast Promiscuous (for dummy MA=
C) */
> > > +            IGB_RCTL_LBM_MAC |  /* MAC Loopback Mode */
> > > +            IGB_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> > > +     igb_write32(igb, IGB_RCTL, rctl);
> > > +     igb_write32(igb, IGB_TCTL, IGB_TCTL_EN);
> > > +
> > > +     /* Enable MSI-X with 1 vector for the test */
> > > +     vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> > > +
> > > +     /* Enable auto-masking of interrupts to avoid storms without a =
real ISR */
> > > +     igb_write32(igb, IGB_GPIE, IGB_GPIE_EIAME);
> > > +
> > > +     /* Enable interrupts on vector 0 */
> > > +     igb_write32(igb, IGB_EIMS, 1);
> > > +
> > > +     /* Map vector 0 to interrupt cause 0 and mark it valid */
> > > +     igb_write32(igb, IGB_IVAR0, IGB_IVAR_VALID);
> > > +
> > > +     /* Initialize driver state and capability limits */
> > > +     igb->tx_tail =3D 0;
> > > +     igb->rx_tail =3D 0;
> >
> > This comment seems wrong.
>
> Ah, yea, looks like some stuff got shuffled around during refactoring.
> I'll fix it in v2.
>
> > > +
> > > +     device->driver.max_memcpy_size =3D (RING_SIZE - 1) * IGB_MAX_CH=
UNK_SIZE;
> > > +     device->driver.max_memcpy_count =3D RING_SIZE - 1;
> >
> > The device must be able to do max_memcpy_count copies of
> > max_memcpy_size, so max_memcpy_size should be IGB_MAX_CHUNK_SIZE.
> >
> > Once you do this you can also get rid of the chunking loop in
> > memcpy_start().
>
> Got it. Will do in v2.
>
> >
> > > +     device->driver.msi =3D MSIX_VECTOR;
> > > +}
> > > +
> > > +static void igb_remove(struct vfio_pci_device *device)
> > > +{
> > > +     struct igb *igb =3D to_igb_state(device);
> > > +
> > > +     vfio_pci_msix_disable(device);
> > > +     igb_write32(igb, IGB_RCTL, 0);
> > > +     igb_write32(igb, IGB_TCTL, 0);
> > > +     igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL=
_RST);
> > > +}
> > > +
> > > +static void igb_irq_disable(struct igb *igb)
> > > +{
> > > +     igb_write32(igb, IGB_EIMC, 1);
> > > +}
> > > +
> > > +static void igb_irq_enable(struct igb *igb)
> > > +{
> > > +     igb_write32(igb, IGB_EIMS, 1);
> > > +}
> > > +
> > > +static void igb_irq_clear(struct igb *igb)
> > > +{
> > > +     igb_read32(igb, IGB_EICR);
> > > +}
> > > +
> > > +static void igb_memcpy_start(struct vfio_pci_device *device, iova_t =
src,
> > > +                          iova_t dst, u64 size, u64 count)
> > > +{
> > > +     struct igb *igb =3D to_igb_state(device);
> > > +     iova_t curr_src, curr_dst;
> > > +     struct igb_rx_desc *rx;
> > > +     struct igb_tx_desc *tx;
> > > +     u64 chunk_size;
> > > +     u64 remaining;
> > > +     uint32_t i;
> > > +
> > > +     igb_irq_disable(igb);
> > > +
> > > +     for (i =3D 0; i < count; i++) {
> > > +             curr_src =3D src;
> > > +             curr_dst =3D dst;
> > > +             remaining =3D size;
> > > +
> > > +             while (remaining > 0) {
> > > +                     chunk_size =3D min_t(u64, remaining, IGB_MAX_CH=
UNK_SIZE);
> > > +
> > > +                     tx =3D &igb->tx_ring[igb->tx_tail];
> > > +                     rx =3D &igb->rx_ring[igb->rx_tail];
> > > +
> > > +                     memset(tx, 0, sizeof(struct igb_tx_desc));
> > > +                     memset(rx, 0, sizeof(struct igb_rx_desc));
> > > +
> > > +                     rx->read.pkt_addr =3D curr_dst;
> > > +                     rx->read.hdr_addr =3D 0;
> > > +                     rx->wb.status_error =3D 0;
> >
> > Don't rx->read.hdr_addr and rx->wb.status_error overlap the same u64?
> > It's not a bug since both write 0 but it is weird.
>
> That's correct, they overlap. I agree it's a bit weird -- it's a
> hardware optimization to save memory. This layout is also how the real
> descriptor (`e1000_adv_rx_desc`) is structured in
> drivers/net/ethernet/intel/igb/e1000_82575.h.  The QEMU IGB
> implementation also assumes this layout for the bits.
>
> >
> > > +
> > > +                     tx->read.buffer_addr =3D curr_src;
> > > +                     tx->read.cmd_type_len =3D (uint32_t)chunk_size;
> > > +                     tx->read.cmd_type_len |=3D (uint32_t)(IGB_TXD_C=
MD_EOP) << IGB_TXD_CMD_SHIFT;
> > > +
> > > +                     /* Set to 0 to disable offloads and avoid needi=
ng a context descriptor */
> > > +                     tx->read.olinfo_status =3D 0;
> > > +
> > > +                     curr_src +=3D chunk_size;
> > > +                     curr_dst +=3D chunk_size;
> > > +                     remaining -=3D chunk_size;
> > > +
> > > +                     igb->tx_tail =3D (igb->tx_tail + 1) % RING_SIZE=
;
> > > +                     igb->rx_tail =3D (igb->rx_tail + 1) % RING_SIZE=
;
> > > +             }
> > > +     }
> > > +
> > > +     igb_write32(igb, IGB_RDT0, igb->rx_tail);
> > > +     igb_write32(igb, IGB_TDT0, igb->tx_tail);
> > > +}
> > > +
> > > +static int igb_memcpy_wait(struct vfio_pci_device *device)
> > > +{
> > > +     struct igb *igb =3D to_igb_state(device);
> > > +     struct igb_rx_desc *rx;
> > > +     uint32_t prev_tail;
> > > +     int retries;
> > > +
> > > +     prev_tail =3D (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
> > > +     rx =3D &igb->rx_ring[prev_tail];
> > > +
> > > +     retries =3D 100;
> > > +     while (retries-- > 0) {
> > > +             if (rx->wb.status_error & 1)
> > > +                     break;
> > > +             usleep(10);
> > > +     }
> >
> > Why bail after a certain timeout? The test may have kicked off a large
> > count of memcpys. Is this for error detection?
>
> The bailout was intended to detect errors during development.
> Shouldn't need it anymore. I'll remove it in v2.

Sorry, I forgot: we need the timeout  to detect DMA errors for the
memcpy_from_unmapped_iova test in vfio_pci_driver_test. The test
triggers an IOMMU fault because the IOVA is unmapped, and the IOMMU
aborts the DMA operation. However, the QEMU IGB implementation does
not set an error bit, so timing out is our only method for error
detection.

>
> > > +
> > > +     igb_irq_clear(igb);
> > > +
> > > +     igb_irq_enable(igb);
> > > +
> > > +     if (rx->wb.status_error & 1)
> > > +             return 0;
> > > +
> > > +     return -ETIMEDOUT;
> >
> > Is there any other way to the device signals errors other than failing
> > to set bit 0 of status_error? I'm especially curious how it handles
> > memcpy_from_unmapped_iova in vfio_pci_driver_test.c.
>
> Yea, there are some relevant error bits in status_err, but
> unfortunately QEMU IGB doesn't emulate them:
> - E1000_RXDEXT_STATERR_LB: confirms that the packet actually traversed
> the loopback path
> - E1000_RXDEXT_STATERR_CE: detects bit flips during transmission
> - E1000_RXDEXT_STATERR_RXE: catch-all error bit for the receive engine
> (buffer overflows, etc.)
>
> The other error bits (E1000_RXDEXT_STATERR_IPE,
> E1000_RXDEXT_STATERR_TCPE) validate network packet integrity, which
> isn't relevant because the driver doesn't package the memcpy data
> within IP or TCP/UDP packets.
>
> Regarding the memcpy_from_unmapped_iova test, the test only cares that
> the device doesn't trigger an MSI. Normally, the QEMU IGB sends an MSI
> once it sets the descriptor done bit on completion of a memcpy
> operation. To prevent this, the driver disables interrupts before
> starting memcpy, and then re-enables them after the memcpy finishes.
>
> > > +}
> > > +
> > > +static void igb_send_msi(struct vfio_pci_device *device)
> > > +{
> > > +     struct igb *igb =3D to_igb_state(device);
> > > +
> > > +     igb_write32(igb, IGB_EICS, 1);
> > > +}
> > > +
> > > +const struct vfio_pci_driver_ops igb_ops =3D {
> > > +     .name =3D "igb",
> > > +     .probe =3D igb_probe,
> > > +     .init =3D igb_init,
> > > +     .remove =3D igb_remove,
> > > +     .memcpy_start =3D igb_memcpy_start,
> > > +     .memcpy_wait =3D igb_memcpy_wait,
> > > +     .send_msi =3D igb_send_msi,
> > > +};
> > > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h=
 b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
> > > new file mode 100644
> > > index 000000000000..e2756be2e9c0
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
> > > @@ -0,0 +1,103 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +
> > > +#ifndef _IGB_REGISTERS_H_
> > > +#define _IGB_REGISTERS_H_
> > > +
> > > +/* Register Offsets (Intel 82576EB Datasheet) */
> > > +#define IGB_CTRL 0x00000 /* Device Control */
> > > +#define IGB_STATUS 0x00008 /* Device Status */
> > > +#define IGB_CTRL_EXT 0x00018 /* Extended Device Control */
> > > +#define IGB_MDIC 0x00020 /* MDI Control */
> > > +#define IGB_RCTL 0x00100 /* Receive Control */
> > > +#define IGB_TCTL 0x00400 /* Transmit Control */
> > > +#define IGB_SCTL 0x00420 /* SerDes Control */
> > > +
> > > +/* Interrupt Registers */
> > > +#define IGB_IMC 0x0150C /* Interrupt Mask Clear */
> > > +#define IGB_IVAR0 0x01700 /* Interrupt Vector Allocation Register 0 =
*/
> > > +
> > > +/* Rx Ring 0 Registers */
> > > +#define IGB_RDBAL0 0x0C000 /* Rx Desc Base Address Low */
> > > +#define IGB_RDBAH0 0x0C004 /* Rx Desc Base Address High */
> > > +#define IGB_RDLEN0 0x0C008 /* Rx Desc Length */
> > > +#define IGB_RDH0 0x0C010 /* Rx Desc Head */
> > > +#define IGB_RDT0 0x0C018 /* Rx Desc Tail */
> > > +#define IGB_RXDCTL0 0x0C028 /* Rx Desc Control */
> > > +
> > > +/* Tx Ring 0 Registers */
> > > +#define IGB_TDBAL0 0x0E000 /* Tx Desc Base Address Low */
> > > +#define IGB_TDBAH0 0x0E004 /* Tx Desc Base Address High */
> > > +#define IGB_TDLEN0 0x0E008 /* Tx Desc Length */
> > > +#define IGB_TDH0 0x0E010 /* Tx Desc Head */
> > > +#define IGB_TDT0 0x0E018 /* Tx Desc Tail */
> > > +#define IGB_TXDCTL0 0x0E028 /* Tx Desc Control */
> > > +
> > > +/* Control Bit Definitions */
> > > +/* CTRL */
> > > +#define IGB_CTRL_RST (1 << 26) /* Device Reset */
> > > +#define IGB_CTRL_EXT_LINK_MODE_MASK (3 << 22)
> > > +
> > > +/* CTRL_EXT */
> > > +#define IGB_CTRL_EXT_DRV_LOAD (1 << 28) /* Driver Loaded */
> > > +
> > > +/* RCTL */
> > > +#define IGB_RCTL_EN (1 << 1) /* Receiver Enable */
> > > +#define IGB_RCTL_UPE (1 << 3) /* Unicast Promiscuous Enabled */
> > > +#define IGB_RCTL_LPE (1 << 5) /* Long Packet Reception Enable */
> > > +#define IGB_RCTL_LBM_MAC (1 << 6) /* Loopback Mode - MAC */
> > > +#define IGB_RCTL_SECRC (1 << 26) /* Strip Ethernet CRC */
> > > +
> > > +/* TCTL */
> > > +#define IGB_TCTL_EN (1 << 1) /* Transmit Enable */
> > > +
> > > +/* SCTL */
> > > +#define IGB_SCTL_DISABLE_SERDES_LOOPBACK (1 << 6)
> > > +
> > > +/* MDIC */
> > > +#define IGB_MDIC_OP_WRITE (1 << 26)
> > > +#define IGB_MDIC_OP_READ  (2 << 26)
> > > +
> > > +#define IGB_EICR 0x01580 /* Extended Interrupt Cause Read */
> > > +
> > > +#define IGB_RAH0 0x05404 /* Receive Address High 0 */
> > > +#define IGB_VMOLR0 0x05AD0 /* VM Offload Layout Register 0 */
> > > +
> > > +#define IGB_VMOLR_LPE 0x00010000 /* Long Packet Enable */
> > > +#define IGB_VMOLR_BAM 0x08000000 /* Broadcast Accept Mode */
> > > +#define IGB_RAH_POOL_1 0x00040000 /* Pool 1 assignment */
> > > +
> > > +#define IGB_EIMS 0x01524 /* Extended Interrupt Mask Set */
> > > +#define IGB_EICS 0x01520 /* Extended Interrupt Cause Set */
> > > +#define IGB_EIMC 0x01528 /* Extended Interrupt Mask Clear */
> > > +#define IGB_CTRL_GIO_MASTER_DISABLE (1 << 2) /* GIO Master Disable *=
/
> > > +#define IGB_STATUS_GIO_MASTER_ENABLE (1 << 19) /* GIO Master Enable =
*/
> > > +#define IGB_GPIE 0x01514 /* General Purpose Interrupt Enable */
> > > +#define IGB_TXDCTL0_Q_EN (1 << 25) /* Transmit Queue Enable */
> > > +#define IGB_RXDCTL0_Q_EN (1 << 25) /* Receive Queue Enable */
> > > +#define IGB_MRQC 0x05818 /* Multiple Receive Queues Command */
> > > +
> > > +#define IGB_MDIC_PHY_SHIFT 21 /* PHY Address Shift */
> > > +#define IGB_MDIC_REG_SHIFT 16 /* Register Address Shift */
> > > +#define IGB_MDIC_READY (1 << 28) /* MDI Data Ready */
> > > +#define IGB_MDIC_ERROR (1 << 29) /* MDI Error */
> > > +
> > > +#define IGB_PHY_CTRL_REG_OFFSET 0
> > > +#define IGB_PHY_STATUS_REG_OFFSET 1
> > > +#define IGB_PHY_STATUS_AN_COMP 0x0020 /* Auto-negotiation complete *=
/
> > > +#define IGB_PHY_CTRL_AN_ENABLE 0x1000 /* Auto-Negotiation Enable */
> > > +#define IGB_PHY_CTRL_RESTART_AN 0x0200 /* Restart Auto-Negotiation *=
/
> > > +
> > > +#define IGB_PHY_AUTONEG_ADV_REG_OFFSET 4 /* Auto-Negotiation Adverti=
sement */
> > > +#define IGB_PHY_1000T_CTRL_REG_OFFSET 9 /* 1000Base-T Control */
> > > +#define IGB_CR_1000T_FD_CAPS 0x0200 /* Advertise 1000 Mbps Full Dupl=
ex */
> > > +
> > > +#define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable *=
/
> > > +#define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
> > > +
> > > +#define IGB_TXD_CMD_EOP 0x01 /* End of Packet */
> > > +#define IGB_TXD_CMD_IFCS 0x02 /* Insert FCS */
> > > +#define IGB_TXD_CMD_RS 0x08 /* Report Status */
> > > +#define IGB_TXD_CMD_SHIFT 24 /* Shift for command bits in cmd_type_l=
en */
> > > +#define IGB_TXD_CMD_LEGACY_FORMAT (1 << 20) /* Forces legacy descrip=
tor format in QEMU */
> >
> > IGB_TXD_CMD_LEGACY_FORMAT appears to be unused. I didn't check the rest=
.
> > Can you prune out the unused macros?
>
> Yep, will do!
>
> >
> > Related: Are these macros and/or the descriptor struct available in any
> > kernel headers that we could symlink into the VFIO selftests like we do
> > for DSA?
>
> They're in private headers under drivers/net/ethernet/intel/igb. Are
> you ok with linking in private headers? The DSA headers are public.
>
> > > +
> > > +#endif /* _IGB_REGISTERS_H_ */
> > > diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/test=
ing/selftests/vfio/lib/libvfio.mk
> > > index 9f47bceed16f..1f13cca04348 100644
> > > --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> > > +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> > > @@ -12,6 +12,7 @@ LIBVFIO_C +=3D vfio_pci_driver.c
> > >  ifeq ($(ARCH:x86_64=3Dx86),x86)
> > >  LIBVFIO_C +=3D drivers/ioat/ioat.c
> > >  LIBVFIO_C +=3D drivers/dsa/dsa.c
> > > +LIBVFIO_C +=3D drivers/igb/igb.c
> > >  endif
> > >
> > >  LIBVFIO_OUTPUT :=3D $(OUTPUT)/libvfio
> > > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/too=
ls/testing/selftests/vfio/lib/vfio_pci_driver.c
> > > index 6827f4a6febe..a5d0547132c4 100644
> > > --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> > > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> > > @@ -5,12 +5,14 @@
> > >  #ifdef __x86_64__
> > >  extern struct vfio_pci_driver_ops dsa_ops;
> > >  extern struct vfio_pci_driver_ops ioat_ops;
> > > +extern struct vfio_pci_driver_ops igb_ops;
> > >  #endif
> > >
> > >  static struct vfio_pci_driver_ops *driver_ops[] =3D {
> > >  #ifdef __x86_64__
> > >       &dsa_ops,
> > >       &ioat_ops,
> > > +     &igb_ops,
> > >  #endif
> > >  };
> > >
> > > --
> > > 2.54.0.563.g4f69b47b94-goog
> > >
