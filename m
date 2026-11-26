Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795651982;
	b=rER4q9gWs1GCoH7sxJE8INNZoUY5eYFu3yhWuAkSHA2GBvZLzcrokQSAS6T/qzE0jG6r
	 2Gg46CcTclj/OI7ms4GWHb/umLl5hGWaq5Ak1oW8QIx+Z9H8PnMhR0qXN+d5fballsxZk
	 H223ACfdsNe7mQE7l9G0bTxVvjF2gJ1q2gdjUq5sG879DeNwLnAoXhFCkSJ/DFHgsUtji
	 i1Ef6/xco7Ug9xbC06ch3+IryTHCfjisoQ9bNFSwIQw5AJD+COslqSAHJNYqQLvmbNS0c
	 fNxCHWg46fZ2FcmRw1DOG6BurbDFKlyI/yIhgzn7thwF4GCM3rn5R4taAPsc6GHANag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=F7ZXso7jhWjYiqUU7UwYJiU8JPoYkJS5VDECLxAjalg=;
	b=JBlMQLVz4hljtc8h6FCcbIrfJRgGtegY0kOZTvxLnp+ifmXz2MciFG4dG9hUdhAeI5gE
	 FFyEfynvvuQeAGLVKKOdkFONoiAqrsIgoiDM+uFRs6EdfezIXsu4MkhbPrY0+dP8HWYZS
	 YppxA8yRMm++DkTda0YUSgch5zkB5k1YN8HiSIpp8bFA7//n7iGax1NbBLZh9CCJZSyeL
	 kTEpUyl9g0pFe2AUcF7QPZNV070LFib/v1M53XqmfOWVT3jwGE+qMh6diLk5Oct61vYic
	 OACJRYkz2WNwMSuMUJpuoMV7RRJ+QuqXUYWCu7d0xrA74hbDWDRM0GgLqhSgh0tYfMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CRyZoz22;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A32606A326
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58A32606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CRyZoz22
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb628232d2so3568732a12.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 16:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795651982; x=1796256782; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F7ZXso7jhWjYiqUU7UwYJiU8JPoYkJS5VDECLxAjalg=;
        b=CRyZoz223YPEgFuLspAYVU4C+wiGlk9ZRfC4HfdodSy0pSclT2YuU4hBncddoQ7NAP
         zKu4VT2oW5ZfFBULJgFASRshVh9mA1r8lP6fnGbhH9xU2mqRmzIvmCWYvB+Kzom27kg5
         JJFYfPxyGKTK03zpQXmD9E413UorfTlNFa+Rwa99uJ2mqFEPKSmjgNKtfgwMcAAa2/c4
         Jqk3Tl75ny2JX/QBzMoJ5GTw1mxy+LgQ//NvfV60s+uFw7IkRE2D1pb05BgAhEcW0/G0
         1p1usltjtOOjzyoVvVnmt3ft9YgNNpYavOWs8OxOi1FPdeQYukgE+XbkeBQ52EeN4OG5
         +NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795651982; x=1796256782;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7ZXso7jhWjYiqUU7UwYJiU8JPoYkJS5VDECLxAjalg=;
        b=ZWFK914v7MJtiYY5hOfauHt6ctc7Hgez2I4OxSgxw0NnIpGgyauckRbjWEzgDlMSRZ
         faXhvgs6yn+BIxHyJoV+JCpsscuYNQNKiwrm92jFwRwDF8ayx0hVdW6uY1aBndZllgMH
         H3u8rG/uHt12Owx3ikTPHOGF9bp6ZZnl/tNgVlWoes88iFNW1WKaNpim5GjFC2SrJIoC
         fCKTa2NdG6tK1OvxflPj5AlgEf7+A8VUl0mdYMZ19LVpKN18QXVg0saCkPZIZFqsXasO
         RoD6Sw6qU45Sqhlo6rlT7s3SO5fEjiBK9rseyYPf+GfDiGD6Uy3nbVPZBQSz9tIn1h5B
         mZAg==
X-Gm-Message-State: APuU4Z/5pOWDPXxyCTjm5tbaI8WKH4vv6ceEiJMB9RmWs46ySF329hfa
	ZQ/JQoTaNIYRNPXRZOsxl7SReu4L90N9fL/CC5VbmZVVdpXfbJJCi7646q+pMKbP5Q==
X-Gm-Gg: AZFdTZeiD9nXinxIuquLdnMkdDsHmYFd9HcLDlMMaKFQgolQ0JiYh+R1PPkPAZ/RGXq
	ax7jwcAZHpipWw82wvEb3w/HhCvocDce0CJ0MAu4t5NU1ttGw4OyA9ZdwM92KuhE78C8vDb2DAn
	0GIzS2I8zgRXhf8wGmDEURZsNq0gMboYqmtLmz31lsF9twGmZVPeJnfN/HKpb+lQaNZ2XE0ilWs
	vfcbTyZR5pknQm4J4w3+u61gpFIXOGYgNyvOntK3Xp2x/Moj7sRK+CAn9QNEkzZD6H3BeI+LO5b
	GGEudEckRiBHCAWi8iMhr6+AYl+2H+2olSqV9NvTXtHl0aZKRfBtELEpi1RvffjO0/KRcyYwcvz
	qX1QzRc+2lTAYINepSit92/lTA+4ueWHUBqAF4hWxOlRl5MgfsISM1QXJUTCKFc9qhBxBMN8jGr
	X0UUMVy9gNrb6VGlhbQnvAaIfiFcZCdsWcpSlJJx7CRVnS8bdrl9Dsl8MOBCDM8mhT6lYHdDP09
	wlOXaZ8Q87jxAqx7EmMcfarn0E+LVN2C91cklgJwuY/eI/kFgCdkJdRs5HJZuIIC26X65V903ly
	eGnZa3CZrbOklaQwbajG+Zj7hOacaV5I5bzsuJs0OX2lPVmwtz4ArddbkFdLPtxx
X-Received: by 2002:a17:90b:1dcd:b0:3b0:968f:fdef with SMTP id 98e67ed59e1d1-3b41c9758d8mr19498651a91.49.1795651980863;
        Wed, 25 Nov 2026 16:13:00 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdec1168866sm83815a12.25.2026.11.25.16.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 16:13:00 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 16:12:59 -0800
Message-Id: <DN4PI3EAYYBF.NM3BHJ2OYRDG@google.com>
Cc: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio: selftests: Add NVMe driver
From: "David Matlack" <dmatlack@google.com>
To: "Josh Hilke" <jrhilke@google.com>, "David Matlack"
 <dmatlack@google.com>, "Alex Williamson" <alex@shazbot.org>
X-Mailer: aerc 0.21.0
References: <20261124020814.1679635-1-jrhilke@google.com>
In-Reply-To: <20261124020814.1679635-1-jrhilke@google.com>

On Mon Nov 23, 2026 at 6:08 PM PST, Josh Hilke wrote:
> The driver overwrites the first max_memcpy_size bytes of the namespace.
> Do not use a device that holds data you want to keep.

I'm worried about this. Today vfio_pci_driver_test skips NVMe devices
("No driver found"), so anyone who already passes an NVMe device to the
VFIO selftests (e.g. to run vfio_pci_device_test) would start losing the
start of namespace 1 after this patch, without changing anything on
their end. On a real disk that's the partition table or filesystem
superblock. A note in the commit message and docs isn't enough
protection for that.

I'd like the driver to refuse to write anywhere that it can't prove is
unused. How about something like this:

 - Reserve the first 4 KiB of the namespace for a header (a magic string
   plus the number of bytes after the header the driver has claimed),
   and do the memcpys in the blocks after it.

 - On the first memcpy, read the header. If it's present and covers
   max_memcpy_size, proceed.

 - Otherwise, check that every byte the driver could write (the header
   plus max_memcpy_size, or just the part past what an existing header
   already covers) is zero. If it isn't, fail with a message explaining
   how to zero the range if the user really wants to use this device.
   If it is, write the header and proceed.

That way things just work on a blank namespace (e.g. the QEMU device in
your instructions), reruns on the same namespace just work since the
memcpys never touch the header, and a disk with data on it is refused.
A crash in the middle of a test doesn't matter either. And since the
check happens on the first memcpy, tests that only use send_msi() (e.g.
KVM's irq_test) still work on any NVMe device.

I prototyped this on top of your patch (about 130 lines, mostly one
function called from the first nvme_memcpy_start()) and
vfio_pci_driver_test passes 35/35 on QEMU on a fresh namespace and on a
rerun, and correctly refuses when there's data in the range. The diff is
at the end of this email.

> +/* nvme.h needs uuid_t from libuuid and struct_group(). */
> +#include <uuid/uuid.h>

Samiullah's "vfio: selftests: Remove libuuid dependency" removes libuuid
from the VFIO selftests and adds uuid_t to libvfio, so please drop this
include and rebase on top of that if it lands first.

> +#include "nvme.h"

This fails to build with clang:

  nvme.h:524:52: error: '_Static_assert' with no message is a C23 extension=
 [-Werror,-Wc23-extensions]
    524 | static_assert(sizeof(struct nvme_id_ns_nvm) =3D=3D 4096);

include/linux/nvme.h uses the kernel's static_assert(), where the
message is optional, but <assert.h> has already defined static_assert()
as _Static_assert(), which requires one before C23. gcc doesn't
complain, so please build with LLVM=3D1 too. Something like this before
including nvme.h fixes it:

	/*
	 * nvme.h uses the kernel's static_assert(), which makes the message
	 * optional. <assert.h> defines static_assert() as _Static_assert(),
	 * which needs one before C23.
	 */
	#undef static_assert
	#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #exp=
r)
	#ifndef __static_assert
	#define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
	#endif

Also, please Cc linux-nvme and the NVMe maintainers on the next version,
so they're aware that the selftests now depend on include/linux/nvme.h,
and to get their feedback on the driver, especially the scratch header
design above.

[...]

> +static void nvme_enable_irqs(struct vfio_pci_device *device)
> +{
> +	/*
> +	 * Admin completions always use vector 0. Require at least two MSI-X
> +	 * vectors so I/O completions use vector 1 and admin commands never
> +	 * signal the eventfd that the tests check.
> +	 */
> +	VFIO_ASSERT_GE(device->msix_info.count, 2,
> +		       "Device must support at least 2 MSI-X vectors");

Please check this in nvme_probe() instead, and fail the probe rather
than asserting. A device that can't work with the driver shouldn't
probe successfully. msix_info and the BARs are already set up when
probe() runs (ioat_probe() already reads BAR0), so the CAP checks in
nvme_enable_ctrl() (NVM command set, 4 KiB pages) can move to probe()
too. Only the checks that need admin commands (number of queues,
namespace format) have to stay in init().

[...]

> +static void nvme_create_io_queue(struct vfio_pci_device *device,
> +				 struct nvme_queue *q, bool ien)

nit: ien is hard to read unless you know it's the IEN bit from the spec.
Please spell it out, e.g. irq_enabled.

[...]

> +static void nvme_set_prp(struct vfio_pci_device *device,
> +			 struct nvme_command *cmd, iova_t buf, u64 size,
> +			 __le64 *prp_list)
> +{
> +	u64 first =3D SZ_4K - (buf & (SZ_4K - 1));

nit: Please add something like NVME_CTRL_PAGE_SIZE (like the kernel
driver has in drivers/nvme/host/nvme.h) and use it instead of SZ_4K
everywhere the code means the controller's memory page size (CC.MPS),
e.g. here, in the PRP list and queue alignment, and in
NVME_PRP_LIST_ENTRIES. That makes it clear that it's unrelated to the
CPU's page size, which can be 16K or 64K on arm64.

[...]

> +	nvme_prep_rw_cmd(device, &cmd, nvme_cmd_read, dst, size,
> +			 state->prp_dst);
> +	for (i =3D 0; i < count; i++)
> +		nvme_sq_push(device, &state->pollq[i % state->nr_pollqs], &cmd);

memcpy_start() is supposed to kick off @count memcpy operations, i.e.
@count DMA reads of @src and @count DMA writes to @dst. This only reads
@src once. Please do @count writes from @src as well. e.g. keep the
first write and the wait for it, and then queue the other @count - 1
writes along with the @count reads. Once the first write completes, the
blocks already hold @src, and the other writes store the same data, so
the reads see @src no matter what order the controller runs them in.

Note that max_memcpy_count will need to account for the extra commands
(2 * @count - 1 in flight instead of @count).

One possible concern with this is SSD wear. memcpy_storm would write
around max_memcpy_count * max_memcpy_size (several GiB) per run on a real
SSD, for each IOMMU mode. That's probably fine on datacenter drives, but
I'm curious what you think.

---

diff --git a/Documentation/driver-api/vfio-selftests.rst b/Documentation/dr=
iver-api/vfio-selftests.rst
index b26040c48d5d..567262ac3d55 100644
--- a/Documentation/driver-api/vfio-selftests.rst
+++ b/Documentation/driver-api/vfio-selftests.rst
@@ -44,8 +44,10 @@ includes driver support for the following devices:
 Note that using Intel DSA devices requires setting the module parameter
 ``vfio_pci.disable_denylist=3DY`` to allow ``vfio-pci`` to bind to DSA dev=
ices.
=20
-Note that the NVMe driver overwrites the start of the first active namespa=
ce.
-Do not use an NVMe device that holds data you want to keep.
+Note that the NVMe driver writes to the start of the first active namespac=
e.
+To avoid destroying data, it refuses to write unless that space is all zer=
o,
+or was zeroed and claimed by an earlier run (marked by a header in the fir=
st
+4 KiB).
=20
 Setting up Devices
 ------------------
diff --git a/tools/testing/selftests/vfio/lib/drivers/nvme/nvme.c b/tools/t=
esting/selftests/vfio/lib/drivers/nvme/nvme.c
index 01f38b71a46b..04ae89f31cb2 100644
--- a/tools/testing/selftests/vfio/lib/drivers/nvme/nvme.c
+++ b/tools/testing/selftests/vfio/lib/drivers/nvme/nvme.c
@@ -69,6 +69,21 @@
 #define NVME_CAP_TIMEOUT_UNIT_MS	500ULL
 #define NVME_POLL_INTERVAL_US		1000
=20
+/*
+ * The first NVME_SCRATCH_HDR_SIZE bytes of the namespace hold a header th=
at
+ * marks the namespace as scratch space for VFIO selftests. memcpy command=
s
+ * use the blocks after it, so the header survives a test that crashes.
+ */
+#define NVME_SCRATCH_HDR_SIZE		SZ_4K
+#define NVME_SCRATCH_MAGIC		"VFIO selftests NVMe scratch v1"
+#define NVME_SCRATCH_CHUNK		SZ_64K
+
+struct nvme_scratch_header {
+	char magic[32];
+	/* Bytes after the header that the driver has verified were zero. */
+	__le64 size;
+};
+
 struct nvme_queue {
 	/* Byte offsets of the submission and completion rings in the region. */
 	u64 sq_offset;
@@ -113,6 +128,12 @@ struct nvme_state {
 	/* Power-of-two shift for converting bytes to logical blocks. */
 	u32 lba_shift;
=20
+	/* First logical block that memcpy commands use, after the header. */
+	u64 data_slba;
+
+	/* Set once nvme_claim_scratch() has verified the scratch space. */
+	bool scratch_claimed;
+
 	/* Result of the write in nvme_memcpy_start(). */
 	int memcpy_err;
=20
@@ -132,6 +153,8 @@ struct nvme_state {
 	 */
 	__le64 prp_src[NVME_PRP_LIST_ENTRIES] __aligned(SZ_4K);
 	__le64 prp_dst[NVME_PRP_LIST_ENTRIES] __aligned(SZ_4K);
+	/* Bounce buffer for reading and writing the scratch header and space. */
+	u8 scratch_buf[NVME_SCRATCH_CHUNK] __aligned(SZ_4K);
 	u8 poll_rings[] __aligned(SZ_4K);
 };
=20
@@ -259,10 +282,6 @@ static u16 nvme_status(const struct nvme_completion *c=
qe)
 	return (le16_to_cpu(cqe->status) >> 1) & NVME_SCT_SC_MASK;
 }
=20
-/*
- * The driver overwrites the first max_memcpy_size bytes of the namespace.=
 Do
- * not use a device that holds data you want to keep.
- */
 static int nvme_probe(struct vfio_pci_device *device)
 {
 	u32 class_code;
@@ -570,10 +589,12 @@ static void nvme_set_limits(struct vfio_pci_device *d=
evice)
 	if (mdts && mdts < 32)
 		max_size =3D min_t(u64, max_size, (u64)SZ_4K << mdts);
=20
-	/* All memcpy operations use the logical blocks from LBA 0. */
-	nsze =3D le64_to_cpu(state->id_ns.nsze);
-	if (nsze < max_size >> state->lba_shift)
-		max_size =3D nsze << state->lba_shift;
+	/* All memcpy operations use the logical blocks after the header. */
+	nsze =3D le64_to_cpu(state->id_ns.nsze) << state->lba_shift;
+	VFIO_ASSERT_GT(nsze, NVME_SCRATCH_HDR_SIZE,
+		       "Namespace %u is too small", state->nsid);
+	max_size =3D min_t(u64, max_size, nsze - NVME_SCRATCH_HDR_SIZE);
+	state->data_slba =3D NVME_SCRATCH_HDR_SIZE >> state->lba_shift;
=20
 	device->driver.max_memcpy_size =3D max_size;
 	/* A ring of depth entries holds at most depth - 1 commands. */
@@ -652,11 +673,11 @@ static void nvme_set_prp(struct vfio_pci_device *devi=
ce,
 }
=20
 /*
- * Build a read or write command covering @size bytes from LBA 0, transfer=
ring
+ * Build a read or write command covering @size bytes from @slba, transfer=
ring
  * to or from @buf. @size must be a whole number of logical blocks.
  */
 static void nvme_prep_rw_cmd(struct vfio_pci_device *device,
-			     struct nvme_command *cmd, u8 opcode,
+			     struct nvme_command *cmd, u8 opcode, u64 slba,
 			     iova_t buf, u64 size, __le64 *prp_list)
 {
 	struct nvme_state *state =3D to_nvme_state(device);
@@ -667,6 +688,7 @@ static void nvme_prep_rw_cmd(struct vfio_pci_device *de=
vice,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->rw.opcode =3D opcode;
 	cmd->rw.nsid =3D cpu_to_le32(state->nsid);
+	cmd->rw.slba =3D cpu_to_le64(slba);
 	nvme_set_prp(device, cmd, buf, size, prp_list);
 	cmd->rw.length =3D cpu_to_le16((size >> state->lba_shift) - 1);
 }
@@ -683,8 +705,92 @@ static int nvme_io_wait(struct vfio_pci_device *device=
, struct nvme_queue *q)
 	return nvme_status(&cqe) ? -EIO : 0;
 }
=20
+/* Synchronously read or write @size bytes at byte @offset of the namespac=
e. */
+static int nvme_scratch_rw(struct vfio_pci_device *device, u8 opcode,
+			   u64 offset, u64 size)
+{
+	struct nvme_state *state =3D to_nvme_state(device);
+	struct nvme_command cmd;
+
+	nvme_prep_rw_cmd(device, &cmd, opcode, offset >> state->lba_shift,
+			 to_iova(device, state->scratch_buf), size, state->prp_src);
+	nvme_sq_submit(device, &state->pollq[0], &cmd);
+
+	return nvme_io_wait(device, &state->pollq[0]);
+}
+
+static bool nvme_scratch_buf_is_zero(struct nvme_state *state, u64 size)
+{
+	u64 *p =3D (u64 *)state->scratch_buf;
+	u64 i;
+
+	for (i =3D 0; i < size / sizeof(*p); i++) {
+		if (p[i])
+			return false;
+	}
+
+	return true;
+}
+
 /*
- * Copy @src to @dst through the logical blocks from LBA 0 of the namespac=
e.
+ * Refuse to overwrite data that the driver did not put there. The namespa=
ce
+ * is scratch space if it starts with a header that covers max_memcpy_size=
.
+ * Otherwise, claim it by checking that every byte the driver could write =
is
+ * zero, and then writing the header. If the header covers less than
+ * max_memcpy_size, only the bytes past what it covers need to be zero.
+ */
+static void nvme_claim_scratch(struct vfio_pci_device *device)
+{
+	struct nvme_scratch_header *hdr =3D (void *)to_nvme_state(device)->scratc=
h_buf;
+	struct nvme_state *state =3D to_nvme_state(device);
+	u64 max_size =3D device->driver.max_memcpy_size;
+	u64 start =3D 0, end, offset, size;
+	struct nvme_command cmd;
+	int ret;
+
+	ret =3D nvme_scratch_rw(device, nvme_cmd_read, 0, NVME_SCRATCH_HDR_SIZE);
+	VFIO_ASSERT_EQ(ret, 0, "Failed to read the scratch header");
+
+	if (!memcmp(hdr->magic, NVME_SCRATCH_MAGIC, sizeof(NVME_SCRATCH_MAGIC))) =
{
+		if (le64_to_cpu(hdr->size) >=3D max_size)
+			return;
+
+		start =3D NVME_SCRATCH_HDR_SIZE + le64_to_cpu(hdr->size);
+	}
+
+	end =3D NVME_SCRATCH_HDR_SIZE + max_size;
+	for (offset =3D start; offset < end; offset +=3D size) {
+		size =3D min_t(u64, end - offset, NVME_SCRATCH_CHUNK);
+
+		ret =3D nvme_scratch_rw(device, nvme_cmd_read, offset, size);
+		VFIO_ASSERT_EQ(ret, 0, "Failed to read namespace %u", state->nsid);
+
+		VFIO_ASSERT_TRUE(nvme_scratch_buf_is_zero(state, size),
+				 "Namespace %u: bytes [0x%lx, 0x%lx) are not all zero.\n"
+				 "The NVMe driver only writes to zeroed space, to avoid\n"
+				 "destroying data. Zero that range to allow it, e.g.\n"
+				 "  blkdiscard -z -l %lu /dev/nvmeXn%u\n",
+				 state->nsid, start, end, end, state->nsid);
+	}
+
+	memset(state->scratch_buf, 0, NVME_SCRATCH_HDR_SIZE);
+	memcpy(hdr->magic, NVME_SCRATCH_MAGIC, sizeof(NVME_SCRATCH_MAGIC));
+	hdr->size =3D cpu_to_le64(max_size);
+
+	ret =3D nvme_scratch_rw(device, nvme_cmd_write, 0, NVME_SCRATCH_HDR_SIZE)=
;
+	VFIO_ASSERT_EQ(ret, 0, "Failed to write the scratch header");
+
+	/* Make sure the header survives a reset or FLR of the controller. */
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.common.opcode =3D nvme_cmd_flush;
+	cmd.common.nsid =3D cpu_to_le32(state->nsid);
+	nvme_sq_submit(device, &state->pollq[0], &cmd);
+	VFIO_ASSERT_EQ(nvme_io_wait(device, &state->pollq[0]), 0,
+		       "Failed to flush the scratch header");
+}
+
+/*
+ * Copy @src to @dst through the logical blocks after the scratch header.
  * A write stores @src first. Then the driver queues @count reads of those
  * blocks into @dst, spread over the polled queues.
  *
@@ -700,14 +806,19 @@ static void nvme_memcpy_start(struct vfio_pci_device =
*device,
 	struct nvme_command cmd;
 	u64 i;
=20
-	nvme_prep_rw_cmd(device, &cmd, nvme_cmd_write, src, size,
+	if (!state->scratch_claimed) {
+		nvme_claim_scratch(device);
+		state->scratch_claimed =3D true;
+	}
+
+	nvme_prep_rw_cmd(device, &cmd, nvme_cmd_write, state->data_slba, src, siz=
e,
 			 state->prp_src);
 	nvme_sq_submit(device, &state->pollq[0], &cmd);
 	state->memcpy_err =3D nvme_io_wait(device, &state->pollq[0]);
 	if (state->memcpy_err)
 		return;
=20
-	nvme_prep_rw_cmd(device, &cmd, nvme_cmd_read, dst, size,
+	nvme_prep_rw_cmd(device, &cmd, nvme_cmd_read, state->data_slba, dst, size=
,
 			 state->prp_dst);
 	for (i =3D 0; i < count; i++)
 		nvme_sq_push(device, &state->pollq[i % state->nr_pollqs], &cmd);
