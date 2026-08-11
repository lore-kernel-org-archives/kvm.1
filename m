Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749423A9BD;
	Tue, 11 Aug 2026 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413181; cv=none; b=uY9LmAfn6NHieyFFiFVK3VLtdp9gO1whAWgXt5/6UQpk0iaXAHuJv3U3UweO4mV3GBnyYb+pHjY0mIJ5BwvoqjBw58JlraKyodWOYM4ORNJffCmEnHDbDvcL0S4zDNgF6uYO25WLUuS4yfOVT7S0QVXDkHadgpE5q+AxCKDOt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413181; c=relaxed/simple;
	bh=80Jo101e/GINoT0nwf2V/dfnkn8BACSgvAu6ozaXtSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUAGdxvGTtHViK/7FqG965F0B2sur/dnlAApslHqCGyC+z4yf8BZXdLWbrOGKpvMe+FO6YKL8if9JRmhxbRzwD6uudJI8PG5d6gUgleZaT1sCF1aGClgsob8Ds4WmqaBATfTkmd3b8udrfgifAZT6J9odRAHiZ2g1LtzFveHHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aMcgZz3c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aMcgZz3c"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D263920B7167;
	Mon, 10 Aug 2026 18:52:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D263920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413155;
	bh=hnPfEoqze/XGl+i9fRYwhjGhjYASitxPAVdEdjoOkpY=;
	h=From:To:Cc:Subject:Date:From;
	b=aMcgZz3cuXlj34UPtQBVy8MON7Nt6rv2fPz5KQSefs2t5dToY6LiV5vyn80H/OgRu
	 486Xbt7FhRTSIKUad3jfQfzqjKiTWYDcx/zio/+3n/cqAeCO9UWCjfWJs5sAU1ZG3n
	 iX9cWM8Zs1/nEu8L6yQRaXalyJiKReq5eGO4B2qE=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/8] VBS/VSM-on-KVM: guest support using VM Planes
Date: Mon, 10 Aug 2026 18:52:35 -0700
Message-ID: <20260811015243.188486-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC adds guest-side Virtualization-Based Security (VBS) support using
KVM VM Planes.  Plane 0 runs the normal guest kernel and plane 1 runs a
higher-trust secure kernel that receives VTL calls through the KVM
hypercall-mediated plane switch.

The series enables a second software plane by default, introduces the VBS
core and KVM backend, bootstraps the secure plane, and adds the secure-side
monitor and park/dispatch handshake.

This is v2 of the series.  Based on feedback from maintainers, the KVM
host, guest, and QEMU changes are now being posted as three separate,
layered RFCs to make it easier to understand the context of these
changes as they pertain to the KVM host, guest, and QEMU.  This
patchset does not yet include memory protection between planes; that
will be added in a future version.

This series is based on the KVM VM Planes prerequisite patchset obtained
from Joerg Roedel's tree (kvm-planes-v7.1):
https://github.com/joergroedel/linux/tree/kvm-planes-v7.1

This series depends on the separately posted four-patch KVM host RFC ending
at commit 6cbd0b038cb3 ("KVM: x86: handle VBS VTL call/return via in-kernel
plane switch"):
https://lore.kernel.org/kvm/20260811003114.30107-1-snambakam@linux.microsoft.com/

This remains prototype code and is not intended for production use.

The implementation and integration tooling are available at:

  Linux and KVM support:
  https://github.com/safe-tee/linux/tree/vm-planes-layered

  QEMU support:
  https://github.com/safe-tee/qemu/tree/vm-planes-layered

  Build, test, and integration tooling:
  https://github.com/safe-tee/lvbs/tree/vm-planes-layered

Acknowledgments
===============

This work stands on top of, and is indebted to, several prior efforts:

  - Joerg Roedel, whose QEMU and KVM VM Planes work provides the
    infrastructure that the VBS/VSM secure plane relies on.

  - Paolo Bonzini, whose "[RFC PATCH 00/29] KVM: VM planes" introduced
    the VM Plane concept to KVM as a common in-kernel model for AMD VMPLs,
    Intel TDX partitions, Hyper-V VTLs, and Arm CCA planes.
    https://lwn.net/Articles/1016113/

  - James Bottomley and James Morris, for their ongoing VSM-on-KVM work,
    which informed the design and direction of this series.

Feedback on the VBS framework, guest bootstrap, backend interface, and
normal-plane/secure-plane division is welcome.

Sriram Nambakam (8):
  KVM: x86: raise the default maximum planes to two
  security/vbs: introduce core VBS framework
  security/vbs: add platform probe and backend registration
  security/vbs: add KVM software planes backend
  security/vbs: enable the backend after driver init
  vm_planes: add hypervisor-assisted plane bootstrap
  security/vbs: bootstrap the plane from the enable path
  drivers/virt: add KVM VM-planes secure-plane monitor

 arch/x86/kernel/cpu/common.c  |  64 ++++
 arch/x86/kvm/x86.c            |   3 +-
 arch/x86/realmode/init.c      |  21 ++
 drivers/virt/Kconfig          |  15 +
 drivers/virt/Makefile         |   1 +
 drivers/virt/secure_monitor.c | 141 ++++++++
 include/linux/vbs.h           |  74 ++++
 include/linux/vm_planes.h     |  46 +++
 init/Kconfig                  |  18 +
 init/Makefile                 |   4 +
 init/vm_planes.c              | 636 ++++++++++++++++++++++++++++++++++
 security/Kconfig              |   2 +
 security/Makefile             |   1 +
 security/vbs/Kconfig          |  32 ++
 security/vbs/Makefile         |   7 +
 security/vbs/core.c           | 182 ++++++++++
 security/vbs/internal.h       |  20 ++
 security/vbs/kvm_planes.c     | 177 ++++++++++
 security/vbs/probe.c          |  61 ++++
 19 files changed, 1504 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/secure_monitor.c
 create mode 100644 include/linux/vbs.h
 create mode 100644 include/linux/vm_planes.h
 create mode 100644 init/vm_planes.c
 create mode 100644 security/vbs/Kconfig
 create mode 100644 security/vbs/Makefile
 create mode 100644 security/vbs/core.c
 create mode 100644 security/vbs/internal.h
 create mode 100644 security/vbs/kvm_planes.c
 create mode 100644 security/vbs/probe.c


base-commit: 6cbd0b038cb31db2f06fe6516f5982d5bdb50174
-- 
2.55.0

