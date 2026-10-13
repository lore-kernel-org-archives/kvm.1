Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09F4B1D1A
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933925; cv=none; b=KI31DONf13Km502mzv0W/EfdwDy/lYfgeFWhZ+WOQ21BE4tEUP7CfOkiXf7ISe/YvvIFMbC89Xhy03YuhAFaqCoDxrqVNs5tovdq2GzETtgH+reG19yrDJHOAMhpUOk5+DX7tk5i7s5lirGpR0OXA4tsc8N1QQFlb31GmAUl/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933925; c=relaxed/simple;
	bh=Jrv9kGju1ubXttMf3FQmGNKOgn+nlWFmNu2o3zM+STI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NOUo41Vv5uniAT7oE2skivU+LKoWs0JxauKY5peQAs8GC6v4rQqLISDwK/xMa8Y1cQQ4WSHp8VhKfEAbtbyzdZrp/B9uA9Nq2NwKf8k3GGeELFE/EULxVBLMvQ/u/NF8Ld0pxknMIvN2n+pC5QSc8N9h/Zi+RXt37Xx44h13pnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fsnx4ztA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=agSfjwSB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fsnx4ztA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="agSfjwSB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791933921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gxnX1nWgf5lYJ1vuMyVU/f5WYTxcLN5xsMApA6mhHNQ=;
	b=Fsnx4ztAGxyU8lzpKib+AteNicbdxTg6nIsgCfSVNk3IAAJrAgtVev95fluP+yovOw7eE2
	8BEekbqy/8u28zSmZhpAMqi/JnXiOXt+0AODVcFcI+hSwpCxcpCPBjIOuL5MzT99BWI9bR
	b3AI83yeP/iYl65c7y4z1RaNbWNutzU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-XRr7FILEOw-Xe_DiRgXBdg-1; Tue, 13 Oct 2026 23:25:19 +0000
X-MC-Unique: XRr7FILEOw-Xe_DiRgXBdg-1
X-Mimecast-MFC-AGG-ID: XRr7FILEOw-Xe_DiRgXBdg_1791933918
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48b0679906dso2134640f8f.3
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791933918; x=1792538718; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxnX1nWgf5lYJ1vuMyVU/f5WYTxcLN5xsMApA6mhHNQ=;
        b=agSfjwSBX3Qbrij7mDSZOYlO2SD1FV7Nvpk2xLdReGJ2acuiBMY7BV5g8vgWIsZdZb
         o/+nrj/NQ3eS0yzOPlM4LTzgtwbTE0T1nELTEvTA/6VwilmbSG9nYIJcSAnkyA8jorJn
         9+HjQL4ah74pQWtOYeIsYOUDvBAPgsREOQKl3qTk7u2f+rYswK1k3b2lTX1GFYZ1aRgt
         lxAGXx3t+Sxnc35qn2ech09+F92KRYzXZ9PuwurPViQdLpBgEc54hCQllgyjBfHlas43
         Cj22OIGwAYNyDMUj33SK2G+DFVPgqntfq0vkSuR1QrrDwBgaObCB7iwuOJSc6s7XvPkT
         fdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791933918; x=1792538718;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxnX1nWgf5lYJ1vuMyVU/f5WYTxcLN5xsMApA6mhHNQ=;
        b=liduAp8h+bcGLD8tZz6a210CAgHMiXy1wSdcACOcNWawRjER2LIJtVIYHfqfRtT3VB
         czlcSJZ8ZW0oXkxQ+iKjRLmOhgOwCde6peLohOZnvJFUJDHPeQluCOFSDut4dVSXg74K
         6O9EouisdRYRNp6SmHohgTp2l1/YYQ9ap0X2jr2PVYoCGazkoEvF+N8xrs0JhLiMe5rG
         rHQcbxnEQBvinn8ECY5hsHdMNaQfgXLZ1A+au8GU/yCkmnyv9JHM5iBdZCMVzU0ozksr
         9pii2OgXYV5dpy/PJMCFid1zhe458/nPYP/y9shswBL4GZM4qBKR0K0W1N8nW8Rko+PG
         ky2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxMPlZM5TTyVIius3VtNjJ3lsM0nHaPjDSTCO+DijV0ac8eE9pYxR5CofnBqtXSJMQ0IG0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHZl5YWUZ3omlh9Uew87zQ3ez0KvLrg/D1rU8zB8kzVBxs6tqw
	WhObilGKIHHkkw3sMs0UBmArRji7j5rPBExhdpgBW0cgOF2tF2eC2NdXEgRHeZgUIrncWURA19f
	NCZH+l1IPltQeju6XuIKX0/n3xriiCkubu6njeX8cyGmP2YzCcbxiMA==
X-Gm-Gg: AYBFou21hTYZMVVho3JsrjZDKg0uiedV77s/LWOirjGSLGRWF2yHJWZo8OE339V9YHi
	Pkzog1/2+VmHeu1qUMcGEiOXHQ6efNo3YmXvbZIxr1I5NpiQVQvY/KzXtwvniU33xH+eInMRMKf
	CcgtULeT7W7jINPh6tiGPhnWc2kZGZVT/MpeeMsCFEj6bJ1wLpYSO8sChJZjlNLDmhKxQDBB0ta
	jijyJWrCk05H6wgyO9nAsDMlhL7FIZU0Dny9ZUDHrKqeEewssF7D06qb4QFXKQLgFC9Wwt9J4u6
	GuQs/WHRjQ9OevBC1wru2OdFeJiFWJdGozSzAPDCyDse7QhWMhDnvsXqwvk6iIEeOS87AA==
X-Received: by 2002:a5d:53c6:0:b0:488:88f6:36a9 with SMTP id ffacd0b85a97d-48dbaae3916mr19455754f8f.21.1791933918033;
        Tue, 13 Oct 2026 16:25:18 -0700 (PDT)
X-Received: by 2002:a5d:53c6:0:b0:488:88f6:36a9 with SMTP id ffacd0b85a97d-48dbaae3916mr19455732f8f.21.1791933917453;
        Tue, 13 Oct 2026 16:25:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaabb8sm8989435f8f.15.2026.10.13.16.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:25:16 -0700 (PDT)
Date: Tue, 13 Oct 2026 19:25:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org
Subject: [PATCH] vfio/pci: read ROM via ACPI _ROM when hardware ROM is
 unreadable
Message-ID: <31aa2fb273d7ff7ea535c74e0780e279aa9a119c.1791933554.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

Some GPUs (e.g. NVIDIA Quadro P2000 Mobile in a laptop) have a ROM
BAR that exists but is unreadable because the GPU was never POSTed
by the system BIOS. On these systems the VBIOS is available via the
ACPI _ROM method provided by the platform firmware.

Add an ACPI _ROM fallback in the VFIO PCI ROM region handler. When
both pci_map_rom() and the platform ROM (pdev->rom) fail, evaluate
the device's ACPI _ROM method to read the ROM.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Hi Alex,
this makes this box I found in the dumpster go brr) Pls take a look.


 drivers/vfio/pci/vfio_pci_core.c |   9 +++
 drivers/vfio/pci/vfio_pci_priv.h |   9 +++
 drivers/vfio/pci/vfio_pci_rdwr.c | 124 +++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..53f53653421e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1193,6 +1193,15 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 			info->size = roundup_pow_of_two(pdev->romlen);
 		}
 
+		if (!info->size) {
+			size_t acpi_size = vfio_pci_acpi_rom_size(pdev);
+
+			if (acpi_size) {
+				info->flags = VFIO_REGION_INFO_FLAG_READ;
+				info->size = roundup_pow_of_two(acpi_size);
+			}
+		}
+
 		break;
 	}
 	case VFIO_PCI_VGA_REGION_INDEX:
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..07c23507832c 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -44,6 +44,15 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
+#ifdef CONFIG_ACPI
+size_t vfio_pci_acpi_rom_size(struct pci_dev *pdev);
+#else
+static inline size_t vfio_pci_acpi_rom_size(struct pci_dev *pdev)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd46de17..654af45e8edc 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -10,6 +10,7 @@
  * Author: Tom Lyon, pugs@cisco.com
  */
 
+#include <linux/acpi.h>
 #include <linux/fs.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
@@ -198,6 +199,112 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
+#ifdef CONFIG_ACPI
+static int vfio_pci_acpi_rom_read(struct pci_dev *pdev, void *buf,
+				  loff_t offset, size_t length)
+{
+	acpi_handle handle, rom_handle;
+	acpi_status status;
+	union acpi_object rom_arg[2];
+	struct acpi_object_list rom_args;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
+	status = acpi_get_handle(handle, "_ROM", &rom_handle);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	rom_args.count = 2;
+	rom_args.pointer = rom_arg;
+	rom_arg[0].type = ACPI_TYPE_INTEGER;
+	rom_arg[0].integer.value = offset;
+	rom_arg[1].type = ACPI_TYPE_INTEGER;
+	rom_arg[1].integer.value = length;
+
+	status = acpi_evaluate_object(rom_handle, NULL, &rom_args, &buffer);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		kfree(buffer.pointer);
+		return -EIO;
+	}
+	length = min(length, (size_t)obj->buffer.length);
+	memcpy(buf, obj->buffer.pointer, length);
+	kfree(buffer.pointer);
+	return length;
+}
+
+static ssize_t vfio_pci_acpi_rom_rw(struct vfio_pci_core_device *vdev,
+				    char __user *buf, size_t count,
+				    loff_t pos, bool iswrite)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	void *chunk;
+	ssize_t done = 0;
+	int ret;
+
+	if (iswrite)
+		return -EINVAL;
+
+	chunk = kmalloc(0x1000, GFP_KERNEL);
+	if (!chunk)
+		return -ENOMEM;
+
+	while (count) {
+		size_t n = min(count, (size_t)0x1000);
+
+		ret = vfio_pci_acpi_rom_read(pdev, chunk, pos, n);
+		if (ret <= 0) {
+			if (ret < 0 && !done)
+				done = ret;
+			break;
+		}
+
+		if (copy_to_user(buf, chunk, ret)) {
+			done = done ? done : -EFAULT;
+			break;
+		}
+
+		buf += ret;
+		pos += ret;
+		done += ret;
+		count -= ret;
+
+		if (ret < n)
+			break;
+	}
+
+	kfree(chunk);
+	return done;
+}
+
+size_t vfio_pci_acpi_rom_size(struct pci_dev *pdev)
+{
+	void *buf;
+	size_t size = 0;
+	int ret;
+
+	buf = kmalloc(0x1000, GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	do {
+		ret = vfio_pci_acpi_rom_read(pdev, buf, size, 0x1000);
+		if (ret > 0)
+			size += ret;
+	} while (ret == 0x1000);
+
+	kfree(buf);
+	return size;
+}
+#endif /* CONFIG_ACPI */
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -215,6 +322,14 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		end = pci_resource_len(pdev, bar);
 	else if (bar == PCI_ROM_RESOURCE && pdev->rom && pdev->romlen)
 		end = roundup_pow_of_two(pdev->romlen);
+#ifdef CONFIG_ACPI
+	else if (bar == PCI_ROM_RESOURCE) {
+		end = vfio_pci_acpi_rom_size(pdev);
+		if (!end)
+			return -EINVAL;
+		end = roundup_pow_of_two(end);
+	}
+#endif
 	else
 		return -EINVAL;
 
@@ -235,6 +350,15 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			io = ioremap(pdev->rom, pdev->romlen);
 			x_start = pdev->romlen;
 		}
+#ifdef CONFIG_ACPI
+		if (!io) {
+			done = vfio_pci_acpi_rom_rw(vdev, buf, count,
+						    pos, iswrite);
+			if (done >= 0)
+				*ppos += done;
+			return done;
+		}
+#endif
 		if (!io)
 			return -ENOMEM;
 		x_end = end;
-- 
MST

