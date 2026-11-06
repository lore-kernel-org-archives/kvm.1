Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004534;
	b=vC8r/pPWL/b0sqG4EN+xEOsG12VdRD8cpDEK6EHOAsv4ExMLxh3W3LGbruizkQMKqLvU
	 YZuwOkbCG5OEDHMK3M+e+lfOicBxgSucc4sLiF/nm47rSeuIUlglgMfmTCm6hlh83a/Ip
	 +NTDWwc92wyE4KEIdd7MUMoQBXd6sCwORTlWmjPoRNmPomjMgMIj6cKP3GapLlBY/YnL6
	 uKcACzq42fbS2+YiuvTPew+KxPtoI8c0W6k+q4zysjfT4e2ESjHacDkhMNhNNyV34PU79
	 kGzVZzfkT5cSw+akU0hq0L80pSg8V/1Hvp8j2k5CsoWT0jyjy9oWUyqsebwLkJVcUbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BwjRA8ftZApzwOyImkXY8LHZEAElz+0AJdwAhV3strc=;
	b=grYERxxvSVaSqAIEUgP/Xi8KbxTj3iu2CEL18kkoECs7k8BakC+QgvxXZkgTKPRc+EhI
	 US7beO6uO4D5Q6EMH2TsfgC4wB9MJ9ag4bjMqWgZlSkNpvA2StHw9tTSoMzQuQ84rI/CY
	 YWh1zf7OOUNSnI66g4qBDt1lTAOJXf7b2uz5WGWHiCmtWYVxxgddLQ+7EcK8E2QcxRshU
	 9bT6vreu4il34UCMWTl+EPgC7FoBtc+ppCN99X+uj77R0HAgMF9DCQbfzelW6zQxzMH03
	 G6IJcvjgGZvCgT0TMB2QH5pCkPWVOe1F4xfsxcdbfy5ntCMzCMsFGk9yKzPXUhZDnFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NcAlRRKK;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2E606A32E
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 22:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C2E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NcAlRRKK
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ed3f563739so12135ad.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 14:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794004533; x=1794609333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BwjRA8ftZApzwOyImkXY8LHZEAElz+0AJdwAhV3strc=;
        b=NcAlRRKKPAjjj3R0MQ8Ie5G6V+chJBOIADQ7AtGo4vYYAU7+dXyxFCDK9w2/J+ZwmC
         6RltoK7XvSt70AoArkEGwuuNsTmkAgRiMRAppL0XaKswD0jPS9oTw17FnAvJswuvB8ye
         6PE5MkBZZYcLdTsdGBrM4IQCAd5QvEgr866oOdSyBFVpAY/DrMjmLVNUuylh8y3lpKzh
         2sDUKwJriyrG9RaErLw/St3p58hw8sRTZrpLIo49nReVZzVbdb8NQJo7qQwMWk4Y2hjL
         611IM0bnsdq0vhGRw8UhAmPiK5k80UA8hBDbwLtYvRs8EoAQ1VrK6XzBvz6afbizQmsr
         9yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794004533; x=1794609333;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BwjRA8ftZApzwOyImkXY8LHZEAElz+0AJdwAhV3strc=;
        b=Hp/QYiI+pdeLZ11jHzy4ZpmfdN6qPZFyn8s/pdOvuqqrK9s4r12y4NG/Go0nHPd+L8
         lGOLFZkyLfOlmkDSrVDa0PxGz0dpal22jh9Uo/xlT7TiIEE6pdHVYHiEDfuE1qptnXwp
         qd/cWe/2grpKsWKNfS8QyIA9/M4Cky9fbkc1D22B/qUNryfWXfAgbgDgxAQXLG5KzOyQ
         dtsrJT/baR0oymplHWdjEPc96Jp3UrWdBTkP7Fy/ijvVdgdS8qbK262T5tVMibEsf5xv
         aPT49QCdrHV6T/A41I7PFQgkzxultsBjwjyKKhFJBwTnjuH9Q7m8sn29CHxsUQ4HOeKd
         xv/g==
X-Forwarded-Encrypted: i=1; AL+hErHuDO3PQwMq9RAX0JIh88QNn780+UT6opPluRqCZCp133BHHdHpZOIgJglpntJNsizavaI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cLKWLxI/S85mfz3wLEc7tdL4biE1kTC69UrhenZnW/B3xowSR
	fKh2AOqbY0Ibik4MVCIaWn0g2Ga1X54yCoz5V/O3ZVC/geEfDDaPaHfhGe2cYb6jxA==
X-Gm-Gg: AYBFou2+3D6BnNmbJonj3l0GsN8e+lq+EkQtOzTXuEs2/cw4CZgrp3kceTTc8g/TdFL
	aZaI7j7I88jRJDhAjANO0B3fb8OwAJ2B9r+1BFJPpHb1bzBPY+aypcHINgdClqvkeNB/83FEASF
	R3WsVN+1dFkLvm58Kekhq292aezIgdGiPVdOJSxSu+o4nKEv+Qy2PDDASnQl3gmYBAj/WA++CgR
	zli7c6wIcX7h1knsdnDfyJv+aFjpUfVVp7HLwUdkE5s6z9Z7ecGlqec8rlTDjLjOeV+8uCh6Qn6
	vSVGVfSNLs8Sge1Ztj5UFtJ0+9zufXu4oVglrgJBRaIGbPcRGOeaeS73cUJXAsjEooDaOn4f/zo
	uKorRRnp39o9zaiN7GP8ZpfX3dmIatVVRmQ2L8IsAuzDjsch9fIk7m9qdxfv29AJtNYnvvCYlf/
	0Hd09EJzeNrEjqHc9Lc2jLB5ipUTIIzOm0DEVH0hHe82k4k66XUqUtEXX5Wv0aJkIYaQA/s4/TF
	YOaJ1NvfTYpJMzONoiGDOEeI+dn0nw8SZg2ortjN7dbOU0vrludHout4LHiZn9zBYJg8h3f1SCu
	GEmQ+7Bd8SaxY2yRnVThEgBhvNisyn8rKxUuNZfhsGEv0xvG9tWGSRdM65ssDZgugB64Nu5df4c
	jY/fvZnBcLBra5Vv1P2Gf
X-Received: by 2002:a17:902:e80e:b0:2ea:1079:e519 with SMTP id d9443c01a7336-2ed6a97c2c6mr202835ad.17.1794004532665;
        Fri, 06 Nov 2026 14:35:32 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103435561sm482994a91.3.2026.11.06.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:35:31 -0800 (PST)
Date: Fri, 6 Nov 2026 22:35:27 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <au5VMy7zhOb65xIE@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-8-vipinsh@google.com>

On Mon, Nov 02, 2026 at 07:36:36AM -0800, Vipin Sharma wrote:
>Implement the Live Update file handler callbacks to preserve a vfio-pci
>device in noiommu mode across a Live Update while keeping it running
>across kexec. Subsequent commits will enable userspace to retrieve and
>take over this file after the Live Update.
>
>State about each device is serialized into struct vfio_pci_core_device_ser
>using Kexec-Handover (KHO) to preserve the pages holding the struct and
>the Live Update Orchestrator (LUO) to preserve the physical address of
>the struct.
>
>Key design notes and constraints:
>
> * Noiommu-only policy and bound cdev requirement: can_preserve() verifies
>   that the preserved file is a bound vfio-pci cdev file descriptor via
>   vfio_file_is_bound_cdev(), and preserve() requires the device to be in
>   noiommu mode via vfio_device_is_noiommu() (returning -EOPNOTSUPP
>   otherwise). CONFIG_VFIO_PCI_LIVEUPDATE now depends on
>   CONFIG_VFIO_DEVICE_CDEV and CONFIG_VFIO_NOIOMMU.
>
> * Serialized state: During preserve(), serialize the PCI domain, BDF,
>   config space size, reset_works flag, and the initial pci_saved_state
>   captured when the device was first opened. During freeze(), snapshot
>   the virtualized PCI config space (vconfig) and capability map
>   (pci_config_map).
>
> * Keep-running freeze and unfreeze: Do not reset the device, clear
>   PCI_COMMAND_MASTER, zap BAR mappings, or revoke dma-bufs during
>   freeze(). Validate that VFIO interrupts are disabled, that the device
>   is in PCI_D0 (and not in VFIO runtime PM low-power mode), and that
>   SR-IOV is not enabled, as VFs are not preserved and the next kernel
>   disables SR-IOV on the running device. Then mask physical INTx
>   (recording the prior state) and mark the device frozen. If the
>   Live Update is aborted after freeze(), unfreeze() restores the physical
>   INTx state and clears liveupdate_frozen so the existing FD remains
>   usable.
>
> * TOCTOU synchronization: vfio_pci_dev_is_frozen() is checked locklessly
>   on entry to the ioctl, read/write and mmap paths, and re-checked under
>   a lock that freeze() holds before any operation that could change the
>   device or vconfig: under vdev->igate in vfio_pci_ioctl_set_irqs() and
>   around every config-space write in vfio_pci_config_rw_single(), under
>   vdev->memory_lock in vfio_pci_runtime_pm_entry(),
>   vfio_pci_ioctl_reset() and the SR-IOV enable path of
>   vfio_pci_core_sriov_configure(), and under dev_set->lock in
>   vfio_pci_dev_set_hot_reset(). A racing operation thus either completes
>   before freeze() takes its snapshot or fails, while existing BAR mmaps,
>   ioeventfds and dma-bufs keep working. Serializing config writes on
>   igate covers the PCI_COMMAND, INTx disable emulation, power state and
>   FLR paths at one point (the INTx disable emulation now uses the
>   igate-held __vfio_pci_intx_mask() and __vfio_pci_intx_unmask()
>   helpers), and also serializes the irq_type and virq_disabled accesses
>   of config writes with VFIO_DEVICE_SET_IRQS.
>
>Co-developed-by: David Matlack <dmatlack@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>---
> drivers/vfio/pci/Kconfig               |   2 +-
> drivers/vfio/pci/vfio_pci_config.c     |  19 +-
> drivers/vfio/pci/vfio_pci_core.c       |  49 +++-
> drivers/vfio/pci/vfio_pci_intrs.c      |   4 +-
> drivers/vfio/pci/vfio_pci_liveupdate.c | 303 ++++++++++++++++++++++++-
> drivers/vfio/pci/vfio_pci_priv.h       |  13 ++
> include/linux/kho/abi/vfio_pci.h       |  52 ++++-
> include/linux/vfio_pci_core.h          |   4 +
> 8 files changed, 434 insertions(+), 12 deletions(-)
>

[snip]

>diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
>index 67e8199eec59..725043a44b55 100644
>--- a/include/linux/kho/abi/vfio_pci.h
>+++ b/include/linux/kho/abi/vfio_pci.h
>@@ -9,14 +9,19 @@
> #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
> #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
>
>+#include <linux/bits.h>
>+#include <linux/compiler.h>
>+#include <linux/types.h>
>+
> /**
>  * DOC: VFIO PCI Live Update ABI
>  *
>  * VFIO uses the ABI defined below for preserving device files across a kexec
>  * reboot using LUO.
>  *
>- * Device metadata is serialized into memory which is then handed to the next
>- * kernel via KHO.
>+ * Device metadata, virtualized PCI configuration space, VFIO's capability map,
>+ * and the initial PCI saved state captured when the device was first opened are
>+ * serialized into memory which is then handed to the next kernel via KHO.
>  *
>  * This interface is a contract. Any modification to any of the serialization
>  * structs defined here constitutes a breaking change. Such changes require
>@@ -25,4 +30,47 @@
>
> #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
>
>+/**
>+ * define VFIO_PCI_SER_RESET_WORKS - Device supports function reset.
>+ *
>+ * Set in &vfio_pci_core_device_ser.flags when the preserved device had
>+ * ``vdev->reset_works == true`` prior to kexec.
>+ */
>+#define VFIO_PCI_SER_RESET_WORKS	BIT(0)
>+
>+#define VFIO_PCI_SER_KNOWN_FLAGS	VFIO_PCI_SER_RESET_WORKS
>+
>+/**
>+ * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
>+ * device.
>+ *
>+ * @domain: The device's PCI domain number (segment).
>+ * @bdf: The device's PCI bus, device, and function number.
>+ * @cfg_size: Size in bytes of the device's PCI configuration space
>+ *            (``PCI_CFG_SPACE_SIZE`` or ``PCI_CFG_SPACE_EXP_SIZE``).
>+ * @size: Total size in bytes of this serialized buffer, equal to
>+ *        ``sizeof(struct vfio_pci_core_device_ser) + 2 * @cfg_size + @saved_state_size``.
>+ * @flags: Bitmask of ``VFIO_PCI_SER_*`` flags; unknown bits are rejected.
>+ * @saved_state_size: Size in bytes of the serialized &struct pci_saved_state_ser
>+ *                    blob stored in @data after ``config_map``, or 0 if none.
>+ * @reserved: Reserved for future use; must be 0.
>+ * @data: Variable-length payload containing, in order:
>+ *        1. ``u8 vconfig[@cfg_size]`` - VFIO virtualized config space snapshot
>+ *           captured during ``freeze()``.
>+ *        2. ``u8 config_map[@cfg_size]`` - VFIO capability map snapshot
>+ *           captured during ``freeze()``.
>+ *        3. ``u8 saved_state[@saved_state_size]`` - serialized
>+ *           &struct pci_saved_state_ser captured during ``preserve()``.
>+ */
>+struct vfio_pci_core_device_ser {
>+	u32 domain;
>+	u16 bdf;
>+	u16 cfg_size;
>+	u32 size;
>+	u32 flags;
>+	u32 saved_state_size;

We will need space for iommufd_token when we preserve that, we should
probably add it now as otherwise the compatibility would be broken when
we add it? Is the reserved here for that?
>+	u32 reserved;
>+	u8 data[];
>+} __packed;
>+
> #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
>diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>index 9a1674c152aa..6bae7581f4f4 100644
>--- a/include/linux/vfio_pci_core.h
>+++ b/include/linux/vfio_pci_core.h
>@@ -149,6 +149,10 @@ struct vfio_pci_core_device {
> 	struct notifier_block	nb;
> 	struct rw_semaphore	memory_lock;
> 	struct list_head	dmabufs;
>+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
>+	bool			liveupdate_frozen;
>+	bool			liveupdate_intx_disabled;
>+#endif
> };
>
> enum vfio_pci_io_width {
>-- 
>2.56.0.317.g454f8302e1-goog
>

Thanks,
Sami
