Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D145A3F5BDB
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932077; cv=none; b=MSIH7eNd6UZmM32Tm3DhORDIZQLqLZdkIouxk0hy+Ymg/fTT1OexakbOcwafmKsM79QZyOHeJsJ/nHdHT7zAOyE1hSx5PDmiTb2pgFz1rfAY8om5KLaVa6bl76Oiyur3fBJK9u+SVuIsNlVP73FYyYFnn7R2Kr7wkFt0ggE18pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932077; c=relaxed/simple;
	bh=EJ7FOHWwIfBNh4wD5qmQyFiTyHaKzXk6Bkq1dQycSe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXFqhWdc7KEDq37ltoQpeS+OdRaO4j/fdLafoM1iftoH+n/NxA+s34yaNLwF2M5Bir6AUPA5jyGb84FEHFKeGVr8zP+UTAXVY+LWjnjV0Awcqt7J7/7kfbrJEV9CoEljlfnnlPtG8HlO0OU3chV5Eu5Oh1sViLBpTO/9yKWHt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8F74120243E;
	Mon,  8 Jun 2026 17:21:14 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org,
	marcel.apfelbaum@gmail.com,
	zhao1.liu@intel.com,
	berrange@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com,
	mtosatti@redhat.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [RFC PATCH 00/10] QEMU Support for KVM Planes
Date: Mon,  8 Jun 2026 17:20:59 +0200
Message-ID: <20260608152109.356783-1-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Hi,

here are the required QEMU changes to make use of the KVM Planes
interface posted here[1].

The patches are based on QEMU v11.0.0 and can be used to launch an AMD
SEV-SNP VM with COCONUT-SVSM + a Linux guest.

To make this work a change to the QEMU command line is required to
tell QEMU which plane to target external IRQs to. this is done with
the new device-plane property to the machine specification, e.g:

$ qemu-system-x86_64 \
  -enable-kvm \
  -cpu EPYC-v4 \
  -machine q35,confidential-guest-support=sev0,memory-backend=ram1,igvm-cfg=igvm0,kernel-irqchip=split,device-plane=2 \
  -object memory-backend-memfd,id=ram1,size=32G,share=true \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
  -object igvm-cfg,id=igvm0,file=$IGVM_FILE \
  ...

Any feedback appreciated.

-Joerg

[1] https://lore.kernel.org/kvm/20260608144252.351443-1-joro@8bytes.org/T/#t

Joerg Roedel (10):
  Update Linux Header for KVM Planes Support
  accel/kvm: Extend KVMState to carry fds for planes
  accel/kvm: Extend CPUState to handle Planes
  accel: Add nr_planes() op
  accel/kvm: Support nr_planes call-back
  accel/kvm: Handle KVM_PLANE_EVENT_CREATE_CPU event
  hw/core/machine: Add device-plane property
  qdev: Add plane property
  MSI: Inject into correct plane
  KVM: Set GSI routes for default plane

 accel/accel-system.c                          |  13 +
 accel/kvm/kvm-all.c                           | 247 ++++++++--
 accel/kvm/trace-events                        |   2 +
 dtc                                           |   1 +
 hw/core/machine.c                             |  22 +
 hw/core/qdev.c                                |  26 +
 hw/i386/kvm/apic.c                            |   6 +-
 hw/pci/msi.c                                  |   3 +
 hw/pci/msix.c                                 |   3 +
 include/accel/accel-ops.h                     |   3 +
 include/hw/core/boards.h                      |   3 +
 include/hw/core/cpu.h                         |  17 +-
 include/hw/core/qdev.h                        |   5 +
 include/hw/pci/msi.h                          |   1 +
 include/qemu/accel.h                          |   7 +
 include/standard-headers/drm/drm_fourcc.h     |  28 +-
 include/standard-headers/linux/const.h        |  18 +
 include/standard-headers/linux/ethtool.h      |  28 +-
 .../linux/input-event-codes.h                 |  13 +
 include/standard-headers/linux/pci_regs.h     |  71 ++-
 include/standard-headers/linux/typelimits.h   |   8 +
 include/standard-headers/linux/virtio_ring.h  |   3 +-
 include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
 include/standard-headers/linux/vmclock-abi.h  |  20 +
 include/system/kvm.h                          |   7 +
 include/system/kvm_int.h                      |  30 +-
 linux-headers/asm-arm64/kvm.h                 |   1 +
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/unistd.h            |   5 +-
 linux-headers/asm-loongarch/kvm.h             |   5 +
 linux-headers/asm-loongarch/kvm_para.h        |   1 +
 linux-headers/asm-loongarch/unistd_64.h       |   2 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |  11 +-
 linux-headers/asm-riscv/ptrace.h              |  37 ++
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/unistd_32.h            | 446 ------------------
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |  21 +-
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/const.h                   |  18 +
 linux-headers/linux/iommufd.h                 |  48 ++
 linux-headers/linux/kvm.h                     |  64 ++-
 linux-headers/linux/mshv.h                    |   4 +-
 linux-headers/linux/psp-sev.h                 |   2 +-
 linux-headers/linux/stddef.h                  |   4 +
 linux-headers/linux/vduse.h                   |  85 +++-
 linux-headers/linux/vfio.h                    |  30 +-
 target/arm/kvm.c                              |   2 +-
 target/i386/kvm/kvm.c                         |  57 +++
 tests/unit/test-qdev-global-props.c           |   5 +
 tests/unit/test-qdev.c                        |   5 +
 ui/keycodemapdb                               |   1 +
 60 files changed, 1150 insertions(+), 538 deletions(-)
 create mode 160000 dtc
 create mode 100644 include/standard-headers/linux/typelimits.h
 create mode 100644 include/standard-headers/linux/virtio_rtc.h
 delete mode 100644 linux-headers/asm-s390/unistd_32.h
 create mode 160000 ui/keycodemapdb

-- 
2.53.0

