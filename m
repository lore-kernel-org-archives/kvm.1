Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6C31ED81
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464191; cv=none; b=oVcHb6BL1rYL8e/VJl/OVjE8R+v9ZvQGEt20gI5GisOwV+i72kSn5VChVIGRVll43UDkCIvAPvq3XdkzoMZb2N7FM6DB9xUK65QuT6Dd061HWxNwBmlzWQX9BEVzJbKudFAX8t6jnTc0Rbbo1T9pAJaeJO0jgAaZ/qltiwwxvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464191; c=relaxed/simple;
	bh=zmircIDvaewwodIQdMhw2LsAdmv6IWzBs6qvYrtMh0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftJZHBk8WAEo/YPyG7cUBg+uE09I25b+WTWs4pCkmCIwhp8eLlK/sP6s3yRM4X2hEd2LNH/pgbW1vnF8zmrP1asoZdTOf77zz0DyE0nfZslQeKbPHmv7SXWP8At4Sz3gjc3m04o9neQeKMRQ7tyB2ai6lqlJIa7t4I1LufzLV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/Gm/FP0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/Gm/FP0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc73e322dbso823995ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464189; x=1784068989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u5/jba+UKg2b5zj7sGmlFFRYyZFPHIXadYV3/lK+14I=;
        b=U/Gm/FP0uhwQDZmb8i2V7loAnHe0nJIbn4EfjeCjY8N5LX9Tu/2Yr9P26xmv41Ws6r
         jc/EDw4/kchjFlZq7kVU+vIKxexFIulEVYnHmw5GkoD5DMgMTAQS0NRxghKjXwD/T34T
         jHlxCPq6SRpllWxAe3HEqfWmjIzy329VbSmHSoD0dBkb4r4nNdYjj5v+Rtu8CVVFjs2H
         wvNej+LB0DSJt3ePtfyuJo+3ksHZ9czBYaPwa3dJAElQvI/KL4u8n+grJI2nO3scpu0C
         IGxr7YbWn531z6iAuLz1ZSz/67DuNwSokkZw94vUMG/vkq0QBseWlAZnqtVFMuPWjDgS
         brIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464189; x=1784068989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u5/jba+UKg2b5zj7sGmlFFRYyZFPHIXadYV3/lK+14I=;
        b=JktpV8hgm1XiJF5zhk58v8qajEsIRyGzIljHlykw5kkXo/c0cXKMPaIUCtBF4uVPEi
         iM2P8vI3QPbJ9ptY8171mW9euJlGY2fGJhZ99WwAkAdz5xlT1YX+JAcvQY4TORvrXv3d
         y97MUe8xEr48f6AUGbL7/7kFmmNdzNP+95nSYa8SCN7wEqrGwHAgDPeMqsKAQR5wFXrn
         w0Ogq/ZzFLZEME5DbG9uW04ySST0R+y35hb0KSNJbMqxlAav6hH1im2hlCuMsaBn5Sua
         4SFG1PD0GixG8VW9+Ev/LfKYyv5qgkhZMX3ZFooIci15A14sovmEjyO/i40VuIQ/AzsP
         z2Pw==
X-Forwarded-Encrypted: i=1; AHgh+RpNyptycf1HmhQMcCaa87P6lGklG6Jku0Uo0TaIJeddt5JD9ULNEnrvbPvnYtR/S9GsNmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0t8LfpU/Pd0ZL1K1iuY5LhUabD5PAXYt4mYoHTtTidAs6XIq
	0vvrSBTGkSju9F6tciy9sBE7PxRMeX3VofiYTZ0SZrV2npN1opdZrPFHIREq2j/6wv4=
X-Gm-Gg: AfdE7clnlm9BwHWOZNwGiM50+xzXzngFmkKYwapEjw+JDSzzbkpxdgKD8zaFqJYEvHW
	bNzWGDQYNW7+qNqXJsk28YMkvmfCICE0X8suXhutrbH+u5JwV/kdKwYlBM0tWmTOGZXPgriPTSX
	RXXt+mbbw9ONihrLAE9Evul3Y0wHXtEb4LcHxyncnQETXk9gjofJdU7Qqv+d0UhG+ioiOVNDJJN
	YRDRppwD/tSGVzWl9vJGxXWnVLze4Q5wdzj2E2ieZ3KKqCnRl9Yt6coeI+NFg5fHn7OACH6dz+D
	I5zawTaulzzTBN2WAqiNpxSyBUZdWIbLw16INax7z6XQAmmSWLizWcLY6tLWCQjU810RLfT86og
	FQwUwRwFealxDbQTnUCx40cpskTHpznQQ5tnnFhA/3FXvKOkc3gchE/6WMWGZHzI23/IfPiUnmF
	GvKEmY1xLlZj6qLxY7NzOLvdzlbZGsC/9R3cALA0U=
X-Received: by 2002:a17:902:d2ca:b0:2c9:da58:17dd with SMTP id d9443c01a7336-2ccbf02ea30mr66158095ad.34.1783464189142;
        Tue, 07 Jul 2026 15:43:09 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:08 -0700 (PDT)
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
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 00/25] Add Realm support to QEMU-VMM 
Date: Tue,  7 Jul 2026 16:42:41 -0600
Message-ID: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset provides minimal functionality to start a Realm VM
from an Arm RME cabable host using the following command line:

qemu-system-aarch64 -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
        -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..

This set is a refactoring of Jean-Philippe Brucker's initial work dating from
a while back.  It is compatible with Steven Price's v14 revision [1] of his work
adding CCA support to KVM.  

The RME capable host it was tested on is the QEMU SBSA machine.  For convenicence
a repository is hosted here [2], along with the TF-A [3], RMM [4] and Linux
kernel [5] for the SBSA machine (all compatible with Steven's v14 patchset).

Device Assignment is not included.

From hereon I will keep this set up to date with new releases from Steven.

Thanks,
Mathieu 

[1]. https://lore.kernel.org/kvm/20260513131757.116630-1-steven.price@arm.com/T/#m06dd14216aaf76acab65b0a76fb84653141ea64f
[2]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v1?ref_type=heads
[3]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
[4]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v14?ref_type=heads
[5]. https://gitlab.com/Linaro/cca-public/linux/-/tree/cca/v14?ref_type=heads


Jean-Philippe Brucker (25):
  linux-headers: Add RME related definitions
  target/arm/kvm: Return immediately on error in kvm_arch_init()
  target/arm: Add confidential guest support
  target/arm/kvm-rme: Add mechanic to initialize realms
  target/arm/kvm: Split kvm_arch_get/put_registers
  target/arm/kvm-rme: Initialize vCPU
  target/arm/kvm: Create scratch Realm VM when requested
  target/arm/kvm: Use kvm_vm_check_extension() where necessary
  target/arm/kvm-rme: Initialise Realm Initial Address space
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

 docs/interop/firmware.json                 |   5 +-
 docs/system/arm/virt.rst                   |   9 +-
 docs/system/confidential-guest-support.rst |   1 +
 hw/arm/boot.c                              |  74 ++++-
 hw/arm/virt.c                              | 138 +++++++--
 hw/core/loader.c                           |  15 +
 include/hw/arm/boot.h                      |   9 +
 include/hw/arm/virt.h                      |   2 +-
 include/hw/core/loader.h                   |  17 ++
 linux-headers/asm-arm64/kvm.h              |   9 +
 linux-headers/linux/kvm.h                  |  21 +-
 qapi/qom.json                              |   1 +
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu.h                           |  10 +
 target/arm/cpu64.c                         | 122 ++++++++
 target/arm/kvm-rme.c                       | 335 +++++++++++++++++++++
 target/arm/kvm-stub.c                      |  23 ++
 target/arm/kvm.c                           | 194 +++++++++++-
 target/arm/kvm_arm.h                       |  47 +++
 target/arm/meson.build                     |   5 +-
 21 files changed, 990 insertions(+), 53 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.43.0

