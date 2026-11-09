Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263473;
	b=t65TyIv9bw9UlwK47xfvXimhp0HSkIZ51UM7tpyGJwnvuyzETzbzerTegepYbAW9c3/v
	 h8e3U3U/D9ImowuRPUu+0qksbKMGT/jS7F3QYTzmJf3US8hSM5AbhZurjQw5xJEq9+QG9
	 XeR0W9aHDzMbil+2sKZVe2QGaRO69sPE1/kvlxjnd5k3WwNBhrG3QWRkiBMTXAR/zN2Cx
	 BL5Ta18ivq3YkuM9iQtO/iNeO3Z29mNcwiNRagDD4vPDBzjl9hT+ob2a/x8Zz2Qs8Jr5m
	 wGPqJsJ+WOxJAGRdeub2B3fmm8XkC53XWf4iuyZam+OeMTpw+aznZP6aX/5mpu4/z/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2Xvf9o4c8oUpaT9noZn7hIYvZqZxntXJddruExxf9kQ=;
	b=VxeA9CZFzp5c3wR0hsTcNOU8iEbOjwwW5KzxswwtKnMMDUaRhUs0tC0gHc10K/GxR1sa
	 x6+F0/OgcGXiBc9pa3onckrYSdD3cXSi4LvIGB1BFS9JXGH+5JwOLiWRvZ3iadu0Sv1KM
	 YipQi9aC4EwgpGRPxztcnntdwP7YcK6N6xLnI0emRUuQOl63yr5SdtiMy1VBdIZ04EOqL
	 /IPxg8SWBnGKbW4XHNQdHLgVzFy3D6qJg7yu6SQT7lF+2vS47qbMirjM/wwE3LXtWeQsI
	 Sb3MVmaUnynLYk+XjMrsBe3I2vGFngu+Nrdf6OpKsVjGqRLvdaTdC3Q4N91xjaYJTyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bfX2yYou;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E1D606A332
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E1D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bfX2yYou
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so837134b3a.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263473; x=1794868273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Xvf9o4c8oUpaT9noZn7hIYvZqZxntXJddruExxf9kQ=;
        b=bfX2yYoupjQLHZ7Jklzk0ZrIYAzc+R1S6rymq8oeK8D4sGzmxMlpN+f1/nAR8vF5bb
         4YjeIS1srGJbhwJMymET5Mu2Qb5eVQiDcbmd9G/xpjlZM4G2C2d1VcR8OWsKHArbS1uY
         7IICoTRxvuz2vlKCVsAGq+OJILDl/+gOxVNHcc5zylMVVuXRDaArwoaw2NTJkxdRLkmu
         bv9lzxsggOloHCnwZ8mcco4Cdq/TixHWOjwncPp9HNgnJHqPIqhuljpBv9hY2H8atg5X
         HmyaOtDGdrD6DOOGxuKKd0zDmX0zmncsLbOcnyCaVEvGAkSLu+2tL5OCgo5B7j1AghS3
         a3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263473; x=1794868273;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Xvf9o4c8oUpaT9noZn7hIYvZqZxntXJddruExxf9kQ=;
        b=oX/X69s6pQtQPtInRFoe2dmn7KHpOSKLQjN2Hubq2b+Vb7JHBBmJwDM3wo8IR3q7q4
         SCl6wecJB6scYyQUNCsoNPi9wQAfr360MO/VoCDv3GJFtwmO5CHn1/O2jLewFe+DhAnY
         1iFLVCXuRfjAxvPz2ZbbxflYEAjTgllTlY2KBIkVjEDP7fXEHU14bBiyFExyYO6UAQbd
         gfzs8tTQGCB2/ctTWdBH4+xygR4AxWS6UfV84TvSybOQUW66vN+Y9oHQ3u/Gr6JIYey0
         PN9kyO7iFI6LVJIVAxkpjle0eaNWhJ3nQhXoHtUQ5FzIJ5j2cTM8P4qM4B88ubz3l2pY
         brNg==
X-Forwarded-Encrypted: i=1; AL+hErHrc2V4CuEHD/Lp6IA8BIw5vUMfz5eAzg1aEG8fkt00yNPXyDTXFaQxL93hjUhNkebAGJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0wC8NoV098C8pAgzwjsf2qcC3sqG4w4fjctpBDUdGJYibuOcM
	8uq0eNVFNr8nur73RgEdndw0QuLWhrxZ9ivIT3XkQqACR2SnO01abd/YaPuiz4xfRT0=
X-Gm-Gg: AYBFou1iy5IcDsSCk73/lvkueCj7zWNbRF7rjFx8HCoTRuRTctRy2+o/21B5orKx6tz
	pZClhYg9RdoMRVoFOtzUdw9BZXaxj6ThLopZuUo/boUzqKOfBOmhQgz1GqKAZJB4yWafNJv7P3l
	aP4lUFnnQ1AsmkUga+fiItgqJB9ZrJ4jtegtphcUYXv9eeAuX9IaeatkEwccJLuDV0AOs80a2jr
	45Ssb/ER1lS/8PBjWS+xfDzRmGlfr70HI6NbiSUOXHUpBNtSrWNhOkagtPTttNjO1qquHtm1t4l
	IKbVkPmAAc45cRkeMMa0Qj6rYdePtj429rIkTqdmyvhPAgiIMEhWkuM9ai4+fL5UDhPBpi7qCXH
	Dd3NkQ4jm+CgqCGR9AwKeWZr6XV8mZpQdr/lsPHKLkUw4J2LpAnsmkYTARX/eJN9gIMb3z0tIvk
	Y46bdGoJZCmVJJ2OpD/H7wh7jLqPZklRnJd5r0RnBlTkY/IEwTyLJ5AyP/LoHWsOm2ZGeNxByaU
	5Oa1LtlU9NK+QJ5WEYcfLcquuIhPfWJ9/g/fGOrWocoQFowrF9UiNg0AamziLmCjd1G5OL000zs
	v/cwP2MvWuqnJxKCimD8U6xkGmShcMzIpNQ2A5C4CpMc+96owRFvm3c=
X-Received: by 2002:a05:6a00:b48:b0:8b5:a10a:a3e7 with SMTP id d2e1a72fcca58-8ba8773db51mr952190b3a.49.1794263472480;
        Mon, 09 Nov 2026 14:31:12 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:11 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 00/23] Add Realm support to QEMU-VMM
Date: Mon,  9 Nov 2026 16:30:47 -0600
Message-ID: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset provides minimal functionality to start a Realm VM
from an Arm RME capable host using the following command line:

qemu-system-aarch64 \
 -M confidential-guest-support=rme0,memory-backend=ram0 \
 -object rme-guest,id=rme0 \
 -object memory-backend-memfd,id=ram0,size=1G,share=on \
 -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..

It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
back.  It is based on Steven Price's latest work [1] and the integration branch
that comes with it.  It is also compatible with Michael Roth's third revision of
his work on guest-memfd convert-in-place [2], rebased to QEMU master.

It was tested on the QEMU SBSA machine.

For convenience a repository is hosted here [3], along with the TF-A [4],
RMM [5] and kernel [6].  Instructions to compile and run the entire stack are
here [7].

Gavin raised a number of relevant issues in this post [8].  Due to the time
needed to look at each and the importance to keep up with the latest kernel
work [1], those issues have not been included in this release.  They will be
discussed further on the mailing list and addressed in upcoming releases if
need be.

[1]. https://lore.kernel.org/kvm/20261102141304.126883-1-steven.price@arm.com/  
[2]. https://lore.kernel.org/kvm/20261007134323.1606088-1-michael.roth@amd.com/
[3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v6?ref_type=heads
[4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
[5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v20?ref_type=heads
[6]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v6?ref_type=heads
[7]. https://gitlab.com/Linaro/cca-public/build-instructions/-/tree/upstream-v6?ref_type=heads
[8]. https://lore.kernel.org/kvm/20260903193611.1058589-1-mathieu.poirier@linaro.org/T/#ma596f1f403f045262a39cbddd796349eb7d02e63


RFC v5: https://lore.kernel.org/kvm/20261002202026.1204110-1-mathieu.poirier@linaro.org/
RFC v4: https://lore.kernel.org/kvm/20260903193611.1058589-1-mathieu.poirier@linaro.org/
RFC v3: https://lore.kernel.org/kvm/20260825220101.3443954-1-mathieu.poirier@linaro.org/
RFC v2: https://lore.kernel.org/kvm/20260728192630.240375-1-mathieu.poirier@linaro.org/
RFC v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html

Changes for V6:
- Several code alignment fixes (Gavin)
- Use MACHINE()->cgs instead of dedicated function (Gavin)
- Code simplifications and imporvements in several places (Gavin)
- Fixed changelog [06/23] (Enju)
- Respect alignement constraints when images are transferred to Realms (Gavin, Lorenzo)
- New patch [08/23] to set t he KVM_CAP_ARM_PSCI_0_2 extension (Lorenzo)

Jean-Philippe Brucker (20):
  [NOT-FOR-MERGE] linux-headers: Add RME related definitions
  target/arm: Add confidential guest support
  target/arm/kvm: Split kvm_arch_get/put_registers
  target/arm/kvm-rme: Initialize vCPU
  target/arm/kvm: Create scratch Realm VM when requested
  target/arm/kvm: Use kvm_vm_check_extension() where necessary
  target/arm/kvm-rme: Keep track of images loaded in Realm memory
  target/arm/cpu: Set number of breakpoints and watchpoints in KVM
  target/arm/cpu: Set number of PMU counters in KVM
  target/arm/cpu: Don't read Realm registers
  hw/arm/virt: Set proper conduit method for Realms
  hw/arm/virt: Embed Realm VM type with IPA address space
  hw/arm/virt: Reserve one bit of guest physical address for RME
  hw/arm/virt: Disable DTB randomness for confidential VMs
  hw/arm/virt: Move virt_flash_create() to machvirt_init()
  hw/arm/virt: Use RAM instead of flash for confidential guest firmware
  target/arm/kvm-rme: Add DMA remapping for the shared memory region
  docs/interop/firmware.json: Add arm-rme firmware feature
  hw/arm/boot: Load DTB as is for confidential VMs
  hw/arm/boot: Skip bootloader for confidential guests

Lorenzo Pieralisi (1):
  target/arm/kvm: Add support for PSCI 0.2 to 'features' flag

Mathieu Poirier (2):
  target/arm/kvm-rme: Add mechanic to initialize realms
  target/arm/kvm-rme: Populate Realm with runtime images

 docs/interop/firmware.json                 |   5 +-
 docs/system/arm/virt.rst                   |   9 +-
 docs/system/confidential-guest-support.rst |   1 +
 hw/arm/boot.c                              |  70 +++-
 hw/arm/virt.c                              | 142 ++++++--
 hw/core/loader.c                           |  24 ++
 include/hw/arm/boot.h                      |   9 +
 include/hw/arm/virt.h                      |   2 +-
 include/hw/core/loader.h                   |  14 +
 linux-headers/linux/kvm.h                  |  18 +-
 qapi/qom.json                              |   1 +
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu.h                           |   7 +
 target/arm/cpu64.c                         | 135 +++++++
 target/arm/kvm-rme.c                       | 395 +++++++++++++++++++++
 target/arm/kvm-stub.c                      |   4 +
 target/arm/kvm.c                           | 198 ++++++++++-
 target/arm/kvm_arm.h                       |  10 +
 target/arm/meson.build                     |   5 +-
 20 files changed, 1005 insertions(+), 50 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.53.0

