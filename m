Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA955C31F
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085256; cv=none; b=V9gjdCKkRuNW/e1UQWW6mw9vqcLeE71FxNyO1szwKHsOKiJ8kcR2lcFYo6GlQRZNwzCiu+6OSnrtLdmUtin8LiiLbVCm3U0/IInJ82+KGC9+1FxtFX1q3vwJdhJTwJR5UONbaF11t1b+wKWY25EyKEiJVBifROxDxhqAGEwe+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085256; c=relaxed/simple;
	bh=6pDnnvNYcTtt19CIrth6NENKS6tjI40drrKRwKUJtcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBSSro7RlE8U7ee65Pw4EHPa7KVSss2Sfk8C8mjg1Grk/0ImVKVAmx5xpTs563lfn69+bZZ6eGGfYK/LCyJTJFx+vJoF96y/i/bonsn2eZvGYVuJ/k8/lkTIr3LxhsQm84sclJVIQW9crVSxkill54FguZHQsX0DnCTRhecQkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=LTryTMeK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OYGTzYmX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="LTryTMeK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYGTzYmX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D196B14000F9
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 13:27:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 13:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792085242;
	 x=1792171642; bh=DlhdpAAAf4G88GBMhYV6E8iQn5Ky9Djq4f697k4MBMQ=; b=
	LTryTMeKlZ2bxlDlVzx4GaxLHrwMP3quvTHcjzNjDx9q4VjxBcvmCVMwUybp/Wr8
	L51nldmRTwJG9HrIykHw1SZytAa+7msg5mlrvxCQUpQ3mJT0m38f3e2PgGUV/7NY
	BBGGzYyVGQITSHLSNIZD/ctZoujP5BfVWsh4CGw7A2T5356HjQwJuhl0VguV2l/X
	LnxqtCIKwq2dFGiCiW6fQqactytDkcRhFjlyitaTn5WwvfAif3FQI4uhkf4hwH8Y
	mjB2j71LdkDAoCZp97I5DypShNf+mQXNiVU7eIZJHYbiQUDe5H9IS5qhLv+eX0fo
	uQ2k/9kfGfQTULZ1ocP/sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792085242; x=
	1792171642; bh=DlhdpAAAf4G88GBMhYV6E8iQn5Ky9Djq4f697k4MBMQ=; b=O
	YGTzYmXpJ5WdWtVZe6aBSpaJaCZl+0JluU6ZrIkbyMiaJPblef+Jxl/kS/CuXCRc
	PX3+6804+Y3kQyQe+japXRM3l6yHrW6uX7QmsohYBrZL4FuWrYapV6lzWTIZGinQ
	/F1mMDQtanr8Q7/thH9pyRozw+6EM5OdtPj5WdoETW8i2PPjUYcYfl/pVfTSl9qv
	nu6tTvXsCjvgj7ZiOjnqf7CyOCWBqm0pOGfoBNCjBqldY1O+QuHRAO7zV2aX2+Dx
	MXCPz83XHiqX3B7ZX3CRZ3V+pBejoQInYXklH0NXulh3Ncr30yDGNgkst+OZbZfs
	JfhNKCRahV+29+9rjAzHA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792085242; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CGaghr4dB6WtZ78DWLGGWqsHivkDSvPYX/0qg+zieas6Moi
	PmVlVcEFw7BL80kZNukEVFWGOGeUqpjKGdkODUdGciQKHe0gxf4XCfWe7RPyQ4t6
	w3enNpvTvEm0IczYYitHXTP8YaWLbu1sVFvTRPeO3YIhMYAJ+JiWrsz1o/Rx/jk7
	Z4d7gWHWaH8onN7a5urZ9squ+Io1Nn4vAWCYxvURRYI3hJHsf+fCIUM1LEYAlDA7
	yNWeBMrqOrZMUgans2CElT8ORbF9aqR4PTISnnR+m2k+/QVn6Q8EFEOhG1JfhE9c
	z9/FmGGgiz+KOoDv2tQhnKneF4TYYlCb+PFUqKA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bFGSwDnOrWQYWX4bVL1Spm/PxZufA8i2duEx0Sou/FM=:6pDnnvNYcTtt19CIrth6NENKS6tjI40drrKRwKUJtcc=;
X-ME-Sender: <xms:-gzRaqwroQeLtVMnAQEEuAP3R5RlsH8Lc7i5hWLD3FXnGUhDDd5Zbw>
    <xme:-gzRakEujFAajxY8UBReTGxHquRORr86ZlT0-Fl40dllhZ8MuVK96S-is8FKUClLR
    gYUWNE_IbfdXtxLfkazSVw-UO9R2apr8tGbNvc8HrAzQdXpPkN1HOW4>
X-ME-Received: <xmr:-gzRamxNa-wWQEiT-R7Z5gs8tIS5szPBLc7s8bTPQpo-plAi7dxhIZZ3xdmYkQ>
X-ME-Proxy-Cause: dmFkZTEB+Q5CzUtKjWMMyvGnwvvr/Iwv5C71koaDtCsPz2YSki//+U+/3RzhIpPbfloUDW
    Xr1/UcIIJBHgBUdTql78tquignidJgsIBry0q1SRdyD6OUO38blRD6ZkGBBx2zkQqFrjgT
    18kPQFkUMLHOTDoD5N5bAuc+b02UVyGFEmRi5Uzt7cfrcsZZ5T7pWNegghcFbvGxcEOJwl
    kAKVSm1hfSO8Kh0G13N1ILPeT6KhG2d7WMNkJcarG5ksZAyZ/fqnTv8AYCJbG/88tQZTSv
    pHL2oGiHBuUCniMXXjII31E20/yvA9vSpsg19VnZm2EPMHGBnNmoKMdwq65HS4XCQwCWdg
    NX8njqEzyL4YGKh0EPuMquX02ZSmTaDSNeqlrr2CVG2d6rdH1GyKyHzRU+zvI3qQFuXUeE
    aV12s9jcmomVDyRMq9YYIjCkyJyzv5EOtC1qscc0wTtYerwLD3o9zY9PJAYpk9N/hklOo9
    9zfMvPu8Ff2nSG0faSqm6PivFw3ZOx4uDH8jbK2Gic9dWpCtT1AmGudT4PYbe9go7DeKds
    f9N41F+P7GanlsdhzjrhcP8bZcQFdqLILTBz1FSq3kcXlKJJ4tsLOhM71U7sHj5bW6//Ui
    KffT1NQuDCeO1+8HQKixuhCP0ayg+q+8/ykOw2EUmZbDBHqUvKwOXXDQePug
X-ME-Proxy: <xmx:-gzRattMZWc-DQeUYXkF9PPBQ6LU44m3yaHJYEEYC27MrhrnuqzoFg>
    <xmx:-gzRar2O_VQKOAVeifd_ytiSWUDaLgy_C66hzRbFkwOSDbG7eySKkw>
    <xmx:-gzRag97nJUIqN7fEavnTljXwtMK23nNBFVYkEXoPs7-iUy48sX_LA>
    <xmx:-gzRakNyFmHgc-G5ld6goHBurRwY5ajc15tp92XoKOQrmPKsicTSFA>
    <xmx:-gzRajx9DW2rX53yjn3MG_-NnM70LSj7dIFsHprnHFIgKyDxM1lyx9ya>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:27:22 -0400 (EDT)
Date: Thu, 15 Oct 2026 11:27:19 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: read ROM via ACPI _ROM when hardware ROM is
 unreadable
Message-ID: <20261015112719.20d08b4c@shazbot.org>
In-Reply-To: <31aa2fb273d7ff7ea535c74e0780e279aa9a119c.1791933554.git.mst@redhat.com>
References: <31aa2fb273d7ff7ea535c74e0780e279aa9a119c.1791933554.git.mst@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 19:25:15 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Some GPUs (e.g. NVIDIA Quadro P2000 Mobile in a laptop) have a ROM
> BAR that exists but is unreadable because the GPU was never POSTed
> by the system BIOS. On these systems the VBIOS is available via the
> ACPI _ROM method provided by the platform firmware.
> 
> Add an ACPI _ROM fallback in the VFIO PCI ROM region handler. When
> both pci_map_rom() and the platform ROM (pdev->rom) fail, evaluate
> the device's ACPI _ROM method to read the ROM.
> 
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Hi Alex,
> this makes this box I found in the dumpster go brr) Pls take a look.

I think I've run into one of these long ago too, but I extracted the
image and passed it as a file to QEMU.  I don't have any complaints
about adding it as another ROM source.

There's a gap here though, vfio_bar_fixup() handles BAR sizing via
config space and needs to add emulation for this mechanism.

I also think we can improve on the brute force sizing, the ROM has a
known structure and we can walk the images it contains.  Doing this
once at device open seems better than letting the user so easily
monopolize the ACPI interpreter lock.

I had an LLM chew on it for a bit and it came up with this counter
proposal.  Please test and feel free to use as a basis for v2.  Thanks,

Alex

 drivers/vfio/pci/vfio_pci_config.c |    4 
 drivers/vfio/pci/vfio_pci_core.c   |    6 
 drivers/vfio/pci/vfio_pci_priv.h   |    4 
 drivers/vfio/pci/vfio_pci_rdwr.c   |  230 +++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h      |    3 
 5 files changed, 247 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..0b741f414c1b 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -516,6 +516,10 @@ static void vfio_bar_fixup(struct vfio_pci_core_device *vdev)
 		mask = ~(roundup_pow_of_two(pdev->romlen) - 1);
 		mask |= PCI_ROM_ADDRESS_ENABLE;
 		*vbar &= cpu_to_le32((u32)mask);
+	} else if (vdev->acpi_rom_len) {
+		mask = ~(roundup_pow_of_two(vdev->acpi_rom_len) - 1);
+		mask |= PCI_ROM_ADDRESS_ENABLE;
+		*vbar &= cpu_to_le32((u32)mask);
 	} else {
 		*vbar = 0;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..11544cac1288 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -649,6 +649,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled(vdev) && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
+	vfio_pci_acpi_rom_init(vdev);
+
 	vfio_pci_core_map_bars(vdev);
 
 	return 0;
@@ -1178,6 +1180,10 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 			info->flags = VFIO_REGION_INFO_FLAG_READ;
 			/* Report BAR size as power of two. */
 			info->size = roundup_pow_of_two(pdev->romlen);
+		} else if (vdev->acpi_rom_len) {
+			info->flags = VFIO_REGION_INFO_FLAG_READ;
+			/* Emulate a ROM BAR: report size as power of two. */
+			info->size = roundup_pow_of_two(vdev->acpi_rom_len);
 		}
 
 		break;
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..2ad93bfbf960 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -44,6 +44,10 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
+void vfio_pci_acpi_rom_init(struct vfio_pci_core_device *vdev);
+ssize_t vfio_pci_acpi_rom_rw(struct vfio_pci_core_device *vdev, char __user *buf,
+			     size_t count, loff_t *ppos);
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index df8848087681..36cab5350ec1 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -10,8 +10,11 @@
  * Author: Tom Lyon, pugs@cisco.com
  */
 
+#include <linux/acpi.h>
 #include <linux/fs.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/vfio.h>
@@ -215,6 +218,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		end = pci_resource_len(pdev, bar);
 	else if (bar == PCI_ROM_RESOURCE && pdev->rom && pdev->romlen)
 		end = roundup_pow_of_two(pdev->romlen);
+	else if (bar == PCI_ROM_RESOURCE && vdev->acpi_rom_len)
+		return vfio_pci_acpi_rom_rw(vdev, buf, count, ppos);
 	else
 		return -EINVAL;
 
@@ -278,6 +283,231 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	return done;
 }
 
+#ifdef CONFIG_ACPI
+
+/*
+ * Some platforms expose a device's option ROM only through the ACPI "_ROM"
+ * method (ACPI Specification v6.5, Section B.4.3) rather than a ROM BAR or a
+ * firmware-provided shadow copy (pdev->rom).  The method takes a byte offset
+ * and length and returns at most 4KB per invocation.
+ *
+ * A ROM is a chain of images; each image's PCI Data Structure (PCIR) records
+ * the image length in 512-byte sectors and whether it is the last image, all
+ * multi-byte fields little-endian (PCI Firmware Specification v3.2, Section 5).
+ * The chain is walked to size the ROM.
+ */
+
+#define VFIO_ACPI_ROM_SIG	0xAA55		/* image header signature */
+#define VFIO_ACPI_PCIR_SIG	0x52494350	/* "PCIR", little-endian */
+#define VFIO_ACPI_LAST_IMAGE	0x80		/* PCIR last-image indicator */
+#define VFIO_ACPI_ROM_SECTOR	512
+/* Sanity bound; far larger than any real option ROM. */
+#define VFIO_ACPI_ROM_MAX	SZ_16M
+
+struct vfio_acpi_rom_header {
+	__le16	signature;		/* 0x00: 0xAA55 */
+	u8	reserved[0x16];		/* 0x02 */
+	__le16	pcir_offset;		/* 0x18: byte offset to PCIR */
+} __packed;
+
+struct vfio_acpi_rom_pcir {
+	__le32	signature;		/* 0x00: "PCIR" */
+	u8	reserved0[0x0c];	/* 0x04 */
+	__le16	image_length;		/* 0x10: length in 512-byte sectors */
+	u8	reserved1[0x03];	/* 0x12 */
+	u8	last_image;		/* 0x15: bit 7 == last image */
+} __packed;
+
+/*
+ * Evaluate _ROM(offset, len) and copy up to @len bytes into @out.  A single
+ * call returns at most 4KB; the byte count copied is returned.
+ */
+static int vfio_acpi_rom_eval(acpi_handle handle, u32 offset, u32 len,
+			      void *out)
+{
+	union acpi_object args[2];
+	struct acpi_object_list arg_list = { .count = 2, .pointer = args };
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	int ret;
+
+	len = min_t(u32, len, SZ_4K);
+
+	args[0].type = ACPI_TYPE_INTEGER;
+	args[0].integer.value = offset;
+	args[1].type = ACPI_TYPE_INTEGER;
+	args[1].integer.value = len;
+
+	status = acpi_evaluate_object(handle, NULL, &arg_list, &buffer);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj = buffer.pointer;
+	if (!obj || obj->type != ACPI_TYPE_BUFFER) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = min_t(u32, len, obj->buffer.length);
+	memcpy(out, obj->buffer.pointer, ret);
+out:
+	kfree(buffer.pointer);
+	return ret;
+}
+
+/* Walk the image chain to determine the total ROM length, or 0 if invalid. */
+static size_t vfio_acpi_rom_size(acpi_handle handle)
+{
+	struct vfio_acpi_rom_header hdr;
+	struct vfio_acpi_rom_pcir pcir;
+	u32 offset = 0;
+	size_t total = 0;
+	int ret;
+
+	for (;;) {
+		u32 image_len;
+
+		ret = vfio_acpi_rom_eval(handle, offset, sizeof(hdr), &hdr);
+		if (ret < (int)sizeof(hdr) ||
+		    le16_to_cpu(hdr.signature) != VFIO_ACPI_ROM_SIG)
+			break;
+
+		ret = vfio_acpi_rom_eval(handle,
+					 offset + le16_to_cpu(hdr.pcir_offset),
+					 sizeof(pcir), &pcir);
+		if (ret < (int)sizeof(pcir) ||
+		    le32_to_cpu(pcir.signature) != VFIO_ACPI_PCIR_SIG)
+			break;
+
+		image_len = le16_to_cpu(pcir.image_length);
+		if (!image_len)
+			break;
+
+		total += (size_t)image_len * VFIO_ACPI_ROM_SECTOR;
+		offset += image_len * VFIO_ACPI_ROM_SECTOR;
+
+		/* Guard against a malformed or hostile method. */
+		if (total > VFIO_ACPI_ROM_MAX)
+			return 0;
+
+		if (pcir.last_image & VFIO_ACPI_LAST_IMAGE)
+			break;
+	}
+
+	return total;
+}
+
+void vfio_pci_acpi_rom_init(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	acpi_handle handle, rom_handle;
+	acpi_status status;
+	size_t len;
+
+	vdev->acpi_rom_handle = NULL;
+	vdev->acpi_rom_len = 0;
+
+	/* Only a fallback when there is no ROM BAR and no shadow copy. */
+	if (pci_resource_start(pdev, PCI_ROM_RESOURCE) ||
+	    (pdev->rom && pdev->romlen))
+		return;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return;
+
+	status = acpi_get_handle(handle, "_ROM", &rom_handle);
+	if (ACPI_FAILURE(status))
+		return;
+
+	len = vfio_acpi_rom_size(rom_handle);
+	if (!len)
+		return;
+
+	vdev->acpi_rom_handle = rom_handle;
+	vdev->acpi_rom_len = len;
+}
+
+ssize_t vfio_pci_acpi_rom_rw(struct vfio_pci_core_device *vdev, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	size_t rounded = roundup_pow_of_two(vdev->acpi_rom_len);
+	ssize_t done = 0;
+
+	if (pos >= rounded)
+		return -EINVAL;
+	count = min_t(size_t, count, rounded - pos);
+
+	/* Serve the real ROM from _ROM, at most 4KB per call. */
+	if (pos < vdev->acpi_rom_len) {
+		size_t rom = min_t(size_t, count, vdev->acpi_rom_len - pos);
+		char *tmp = kmalloc(min_t(size_t, rom, SZ_4K), GFP_KERNEL);
+
+		if (!tmp)
+			return -ENOMEM;
+
+		while (rom) {
+			int ret = vfio_acpi_rom_eval(vdev->acpi_rom_handle, pos,
+					min_t(size_t, rom, SZ_4K), tmp);
+
+			if (ret <= 0) {
+				if (!done)
+					done = ret ? ret : -EIO;
+				break;
+			}
+			if (copy_to_user(buf, tmp, ret)) {
+				if (!done)
+					done = -EFAULT;
+				break;
+			}
+			pos += ret;
+			buf += ret;
+			rom -= ret;
+			count -= ret;
+			done += ret;
+		}
+
+		kfree(tmp);
+		if (rom)	/* stopped early on error, skip the pad */
+			goto out;
+	}
+
+	/* The tail past the real ROM reads back as -1, like a ROM BAR. */
+	while (count) {
+		u8 val = 0xff;
+
+		if (copy_to_user(buf, &val, 1)) {
+			if (!done)
+				done = -EFAULT;
+			break;
+		}
+		buf++;
+		count--;
+		done++;
+	}
+
+out:
+	if (done > 0)
+		*ppos += done;
+	return done;
+}
+
+#else /* !CONFIG_ACPI */
+
+void vfio_pci_acpi_rom_init(struct vfio_pci_core_device *vdev)
+{
+}
+
+ssize_t vfio_pci_acpi_rom_rw(struct vfio_pci_core_device *vdev, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+#endif /* CONFIG_ACPI */
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			       size_t count, loff_t *ppos, bool iswrite)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2f3fa2787737..ced1d7385185 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -8,6 +8,7 @@
  * Author: Tom Lyon, pugs@cisco.com
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -151,6 +152,8 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	acpi_handle		acpi_rom_handle;
+	size_t			acpi_rom_len;
 };
 
 enum vfio_pci_io_width {
