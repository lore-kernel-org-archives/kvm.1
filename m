Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635C472F98
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266795; cv=none; b=GhQLe7LYMUGd4YRHfEQMZB/KuQSevOpduw+Xv7dI6nqRGF4fiMuKZQxwveMlzjMBXHh4gGGoE56oKdghLNPXt7+QAWct2ONToOcYRtDLltma9Lxhq/E7vGmSR/IgJTMu5pKEgtI8QhXgxpswIE+0OPOX8JnZEDhRgD0XTB+75OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266795; c=relaxed/simple;
	bh=ODhetCkv+Li9ahgZe8Idz2p6MApXjZlundlnczY426k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXXkfImE9h9OYZpKD1hTwezQpyk6XrUdzgOqhiXUFFWtxlHcwPpjVh3dxQXp89TC7mkTMdSD5opEUcfSQwRPb35ejilagWfnXPQlroA2eRp4G9gadW6SjvkLoaGlUHV2D+EJqdZJIMFCewHbZLja8+j/LfQPtAxgKuAEcaBPVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMPhZDiK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMPhZDiK"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso257053a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266794; x=1785871594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mIfJvrcdId2+irdyMzI0RwFl4uOmWff7aVexV8ovtSk=;
        b=wMPhZDiKQ+hfkmTVQF3lNrJBh7jn9X6Sz1HkedDPCEJf+yhi5rwBdxD9egXuPCLWUJ
         qaIu4HgQegM83GaqAWg7y4ilZRYtXxuuR8hvDOcR/REieJt0gU4rm83IsPaa6rwyHbQL
         xs5FtWQSmMduPukhzQxDcIlMgr2P95/i5ojkoP05cq2k45sZsps001WotOCByTz4Djv0
         RndYjwljjz+ARVxAR8QKX7chz1NNEyBd2/7fv8VXTOo2wVLG51N6m/kJ3hxH3RPFnqN0
         UH1QVz5avJOnUsFaSgh6/CZxmqF1a9Te59DAe1o+qq8UqIJMW/3AtnEnViPi7u2cVDhe
         M81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266794; x=1785871594;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mIfJvrcdId2+irdyMzI0RwFl4uOmWff7aVexV8ovtSk=;
        b=KqdSScV5fA0m7E3fYgO9QIgJ36lBtPbRBwmqIhWzpFSPxow2nNxdMoDmj70c9ELdnl
         inSLiHMZX4uaS6HvvA9PtegaPuqMDYMXs+JL8iNzTy2rRTvjt3Vtfho8SE+ajRG34hS+
         LfVWVozMg5bPb5VDYNELrpElZBjFf3aXB3+QbyEvL14x0aeZqwWqAz4Tw+rKmXFX8QIm
         Y0uZeaQwebCQWRKwOixzKpo2QcLnx3/tby5H8KK1NMzcbBB9q4pFG3CUT7yJa5yYj/lq
         eLGKX9tvUlIty7l5IJ+w5ZiS6X4zEONPJvPsa3X8007tnzbi05EdzxnFXMHKnHAPEzR2
         8dmw==
X-Forwarded-Encrypted: i=1; AHgh+RpjPZz6rv991rHkUSqyNQ7jkhA0iEX73CmDE1Ff+XVDFHxtcf+7LnGugyK0zRhQ3ODmRMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJ5W0vJDIdAhLkgtXM7XQ4MVmzB6pS9V3CxHrKkPbedwf9gnk
	/hMewuBgWiaRPl6knVMCik8cFvtHAvBGN/hdVpwPoLcjdlDQDvi5o8w9oEwgWxptw9g=
X-Gm-Gg: AR+sD10+P1ekVP45Tv7c5nALkQewjf23DxQ1m9xkZgasRC5n70jE8u8xtT4Yt49mX6u
	2BBaLv4ePKsbovtCsGX4Zy1qWxKW6C+wG4BtHqWcI6gOaY4D6kOrui9j+IW3rU5VQIK4N+d8Gi2
	3Zt3qU95k8jnNqTuOrEkP2SWfVMrJThZHS5G2oNxPbl8rk8z0CJZsneYzrl18wa090kE3wzoSae
	4SA610YeWOZgP9gQZPJv4bqbrslE8iyECEtKr5xbRYm6mpLtGX7z1JIoC0DwnedKia+wh7ri7fG
	Og0x6tge+yI/6kUfZ+xQnFvgfrXq0evs32iv8jnoUgxo+o6O5Eq99xr006zqjihJHacyjNnRnD9
	07N/CtM2+HfMpp5/H/N+M3gNOGOzDqjnD+m8VaHfXWvSinb53h38lj5ZyPNREtPSe4BG9RPxn3+
	39g165MMpzQK18tO8DaraA8dXMwymSQD87+A8Hw6U=
X-Received: by 2002:a17:90b:1a8f:b0:387:e0db:3fad with SMTP id 98e67ed59e1d1-38f6a53f3a4mr3897416a91.38.1785266793575;
        Tue, 28 Jul 2026 12:26:33 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:31 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 00/24] Add Realm support to QEMU-VMM 
Date: Tue, 28 Jul 2026 13:26:06 -0600
Message-ID: <20260728192630.240375-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset provides minimal functionality to start a Realm VM
from an Arm RME capable host using the following command line:

qemu-system-aarch64 \
 -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
 -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..

It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
back.  It is compatible with Steven Price's v14 revision [1] of his work adding
CCA support to KVM.

* We are currently working on rebasing the work to v15.

It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
here [2], along with the TF-A [3], RMM [4] and Linux kernel [5] for the SBSA
machine (compatible with Steven's v14 patchset).

Instructions to compile and run the entire stack can be found here [6].

Device Assignment is not included.

Thanks,
Mathieu

[1]. https://lore.kernel.org/kvm/20260513131757.116630-1-steven.price@arm.com/T/#m06dd14216aaf76acab65b0a76fb84653141ea64f
[2]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v2?ref_type=heads
[3]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
[4]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v14?ref_type=heads
[5]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads 
[6]. https://gitlab.com/Linaro/cca-public/build-instructions

RFC v1:
https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html

Changes for V2:
- Fixed linux headers to include correct bit shift for Realm VM (Gavin).
- Removed obsolete rme-guest options (Markus).
- Set ConfidentialGuestSupportClass::kvm_init() to kvm_arm_rme_init() (Gavin).
- Got rid of kvm_arm_rme_vm_type() (Gavin).
- Used kvm_vm_check_extension() instead of kvm_check_extension() to avoid
  error message when starting a Realm (Gavin).
- Removed obsolete kvm_arm_rme_init_guest_ram() (Gavin).
- Collected A-B and R-B.

Jean-Philippe Brucker (23):
  linux-headers: Add RME related definitions
  target/arm/kvm: Return immediately on error in kvm_arch_init()
  target/arm: Add confidential guest support
  target/arm/kvm: Split kvm_arch_get/put_registers
  target/arm/kvm-rme: Initialize vCPU
  target/arm/kvm: Create scratch Realm VM when requested
  target/arm/kvm: Use kvm_vm_check_extension() where necessary
  hw/core/loader: Add a ROM loader notifier
  target/arm/kvm-rme: Keep track of images loaded in Realm memory
  target/arm/kvm-rme: Populate Realm with runtime images
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

Mathieu Poirier (1):
  target/arm/kvm-rme: Add mechanic to initialize realms

 docs/interop/firmware.json                 |   5 +-
 docs/system/arm/virt.rst                   |   9 +-
 docs/system/confidential-guest-support.rst |   1 +
 hw/arm/boot.c                              |  70 ++++-
 hw/arm/virt.c                              | 142 ++++++++--
 hw/core/loader.c                           |  15 +
 include/hw/arm/boot.h                      |   9 +
 include/hw/arm/virt.h                      |   2 +-
 include/hw/core/loader.h                   |  17 ++
 linux-headers/asm-arm64/kvm.h              |   9 +
 linux-headers/linux/kvm.h                  |  10 +-
 qapi/qom.json                              |   1 +
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu.h                           |  10 +
 target/arm/cpu64.c                         | 122 ++++++++
 target/arm/kvm-rme.c                       | 313 +++++++++++++++++++++
 target/arm/kvm-stub.c                      |   9 +
 target/arm/kvm.c                           | 202 ++++++++++++-
 target/arm/kvm_arm.h                       |  20 ++
 target/arm/meson.build                     |   5 +-
 21 files changed, 927 insertions(+), 50 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.43.0

