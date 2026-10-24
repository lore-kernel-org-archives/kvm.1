Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858818;
	b=Cuet2Q0lpeb8oK2z2rGdG1EuuISsZ3wgS2HPyeaCWPntgmrW1rGsQ9+dd9oJTKQTXr4Z
	 gSxjtEddJ3piufb6VSTVVpu9/f7yYs3v1WuPfTFj0tOocaGKwzAQcbKb+H3lVu5/pRmh3
	 W6NNCnpVVhqiiIyg2hKrQIymLjfGR1mqTdZOj88HWoABGIo+wXNE3f/+8V8qdX6FZb1iI
	 PpNvytyPp+PW+HvqcRsu9N23o5dYz/1iH/gaPmnhENLB1Amtq6wjV8SeP0KLH2i58iese
	 OXqX0iNWXHZeqFRU0dTfMkxmsqNuRWgtEctq+TuukmzhZs1NNyaoR0z3Rt1rP3Pxjqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=0LUNcR/8KJKuB0k5JLTs6CD6KvSgfj2q7nuRdY/7M0c=;
	b=kVabdQLXwR8wvDNprgGqc4di03Ie7gITXJWK+satYiOCLJV9Qx/i9Y0J5DM+dvLvIDr9
	 464LJyKERWCUYDIbyr/Mzn2MtFiIrmpRd5plWydrepkLd9X/uh6E2s0GimuTmSWYYmZXv
	 5zmeTtvsTJ80sy44RVNeETEUca+1+yXLwbxlSTW2108C3vnCAzuXXwa/iWqCSUaw6UBB8
	 hAXBn6WHQtXvBTtgfuH5xwQoBncl253PgWFRZMJg8UHOwNm5abNnXr6PML3f6kMYOcBYh
	 imQbLcBYswQ8WdA9ZrsPdqHCuEOLfSx6y+Eengh6BEPt1YCBK/gJXw3pGMfP61Pp5Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="p4/I1/p/";
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55581606A31A
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55581606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p4/I1/p/
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a2063be13dso14365335e9.3
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858816; x=1793463616; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0LUNcR/8KJKuB0k5JLTs6CD6KvSgfj2q7nuRdY/7M0c=;
        b=p4/I1/p/qx18W8SN4qIaz/kr+mXT4Peo9FUO750ksKj0gVPIy3sSeDxLRELIttU9pQ
         zwp/o55Yil1MUxPqOv5TzpsAr1jJPF2btTTbEB5/JsevSE6FRy1BlxI9ib1vkYyJtu4C
         ww7BnghqYkierN/p8VCCRhHaihhwh69JbqsnYHa3fZ/cYmezowWChILxyjMFEplUe2Hg
         ri/AzJtkejlypiQLtaL2RSpCp/69IkmMMXkJrDssJJspeL3o6Ci7sf6NqhPezI5HbN3U
         zGTX9tL5vX2PWuYzUaMQvuUDaCjLKUi+IdJFsiA540U5X/tXEdxp2rIFvkhy8xudnTTa
         Mw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858816; x=1793463616;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0LUNcR/8KJKuB0k5JLTs6CD6KvSgfj2q7nuRdY/7M0c=;
        b=zwFbuF7hiHmD9ZGfmQWne7hUx2OPQRsSRD+ic7jTk6ZAQAR5pvWsmz8TjXo7bvyvX8
         InPTNCJCdIk17spjCxicMJjM3GaB46bd49hCfKsjNEu3mKKOWINoGvD04bJsshHlL+Ot
         tuMlSTGo8FhkwIdoVi8fKKxNxK4oyJfz9vb3+NkICS2nu2LLq/U7yb7cc1uKb3h7iPRp
         Zk4pDDZQkgfZCqSPXe6sIvScNABvMVQjihCtj94zNOi8YTLZtrJGQs7o5nhPY1qGTgsM
         oy9XDtYtzsdiHa46bmvwHmQmDMbr+Ga/ePEoO9MUsXaU0FXNoiaK2crhaNJBmorIjkcY
         whZA==
X-Gm-Message-State: AFq9FYKeX1ZJRPqWvrejA2JRC6V76sMo6LhyaRIBPC5NpLNxohEl28VQ
	lDH6ftzMABMJvYQrZE3kBBItIOYXZ0RtUt4Ge8+tp2LdkGw/Z6TVfDyIq5HmbQyyXBUUgeYEPL+
	XBceDyom/IjNOCJ3NOMimuA2kJU+QeoudFwZcXS/ChN1IDTO2TgjTabDxPdiiGh+rWHH7Nj4k8i
	2+x5LxmrOCW9aVJEGPevL6Egy/php+J6e/dnV4wrQeL1E=
X-Received: from wmbg13.prod.google.com ([2002:a05:600c:a40d:b0:4a1:de16:b260])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:84ca:20b0:4a1:97c6:d2e8 with SMTP id 5b1f17b1804b1-4a35acb35dbmr23105455e9.32.1792858816235;
 Sat, 24 Oct 2026 09:20:16 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:18:53 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261024161902.2093581-1-smostafa@google.com>
Subject: [PATCH kvmtool 0/9] vfio: Add support for platform devices
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series extend VFIO support to platform devices by using
VFIO-platform.

One of the main difference is how the guest discover the device, which
is done through the device tree.
kvmtool can only describe:
- regs
- interrupts

However, the guest still needs a compatible string and other per device
bindings.
To avoid having any hardcoded DT nodes in the source code, kvmtool will
accept a dtb argument with each assigned device that will be copied to
the guest node.

Patches
=======
1-4: Fixes, code refactoring and improving interrupt support.
5: DT common function.
6-8: VFIO-platform support.
9: Custom device tree support.

Patch 2 is better viewed with --color-moved

Testing
=======
Tested on Lenovo Mini-x Gen 10 (Snapdragon-X) by assigning 2 devices,
QCE and BAM as follows:

echo 1dfa000.crypto > /sys/bus/platform/drivers/qcrypto/unbind
echo 1dc4000.dma-controller > /sys/bus/platform/drivers/bam-dma-engine/unbind

echo "vfio-platform" > /sys/bus/platform/devices/1dfa000.crypto/driver_override
echo "vfio-platform" > /sys/bus/platform/devices/1dc4000.dma-controller/driver_override

echo 1dc4000.dma-controller > /sys/bus/platform/drivers/vfio-platform/bind
echo 1dfa000.crypto > /sys/bus/platform/drivers/vfio-platform/bind

./lkvm-static run --irqchip gicv3 -k Image -p "nokaslr" -d rootfs.ext2 --force-pci -c 1  --debug --vfio-
platform 1dc4000.dma-controller,purwa-cryptobam.dtb --vfio-platform 1dfa000.crypto,purwa-qce.dtb

There are some fixes on the list that are needed to be able to unbind
the bam device [1]

Mostafa Saleh (9):
  vfio: Fix fd leak in vfio_group_get_for_dev()
  vfio: Factor out wired IRQ setup and teardown
  vfio: Support edge-triggered wired IRQs
  fdt: Allow fdt_irq_fn to generate multiple interrupts
  fdt: Add helper to copy an FDT node
  vfio: Reserve guest address space for VFIO platform
  vfio: Add basic support for vfio-platform
  vfio: platform: Add interrupts support
  vfio: platform: Take the guest node from a device tree template

 Makefile                       |   1 +
 arm64/fdt.c                    |  36 ++--
 arm64/include/kvm/kvm-arch.h   |  10 +-
 builtin-run.c                  |   3 +
 hw/cfi_flash.c                 |   4 +-
 hw/rtc.c                       |   4 +-
 hw/serial.c                    |   3 +-
 include/kvm/fdt.h              |  32 +++-
 include/kvm/vfio.h             |  41 ++++-
 mips/include/kvm/kvm-arch.h    |   2 +
 powerpc/include/kvm/kvm-arch.h |   2 +
 riscv/fdt.c                    |   2 +-
 riscv/include/kvm/kvm-arch.h   |   7 +-
 riscv/irq.c                    |  27 ++-
 vfio/core.c                    | 152 +++++++++++++++-
 vfio/pci.c                     | 111 +-----------
 vfio/platform.c                | 317 +++++++++++++++++++++++++++++++++
 virtio/mmio.c                  |  10 +-
 x86/include/kvm/kvm-arch.h     |   2 +
 19 files changed, 619 insertions(+), 147 deletions(-)
 create mode 100644 vfio/platform.c

-- 
2.56.0.307.g5fe7bd680c-goog

