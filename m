Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8D4314A0
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927875; cv=none; b=YxmrVKAYaFVOTSjEfMI4ACtKZSZgCThvwXdTTeHvfKHOZ7zGcVlAQczPC/zLnF4rId7DY83AnIymA5Hzxs2UL4C3rQILPefkxZdTf+D+G5q0vKvYBUSeoU4ozk64/LVUuFITxRA7aL95dBngRerqjBH75kp9KrKI3/i5gJFbxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927875; c=relaxed/simple;
	bh=xIZNkwMDFEjjWLECZU545nYhcnHtWMO56ZlghFxw1wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLY6X3YpY7+cTk/blpA8VOWu9IVf5YY0w3PXTu+yxUSXr4Th7d++788Lxp6BsHP8ysxXAn7ROTLE3pRXQfiv2rekFDTICwGWQ3AAloX/tU9bqF4gGMM/Jd0TH2Pt7ykxsTpIehJC9hQjAuOUpd2q70wQIyGTMFEgxvimjMJdWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mPHn30/W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mPHn30/W"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id F403420B7169;
	Wed,  5 Aug 2026 04:04:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F403420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927853;
	bh=mBopCGB9U0UQQPrdHpzVGND3qjL34aJmORw3g1OLW1w=;
	h=From:To:Cc:Subject:Date:From;
	b=mPHn30/Wp0dlRDuCM3epRYEhPWX+7eoxi4ijvSauJLHBLwB1rcsfIPH6Y2iwV/Cmx
	 fn9T/i7UAYfcfkQQQZDqI1C9ECUhtcOcSVeOgzv9086mDz8dBk4k+c77pYPEqbCf3I
	 ZuyZOYxTsPQyrjltD2TFFTXEautQinPZWvAkEF5s=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v1 0/5] VBS/VSM-on-KVM: QEMU support for the secure VM plane
Date: Wed,  5 Aug 2026 04:04:27 -0700
Message-ID: <20260805110432.25167-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC adds the QEMU support needed to run a Virtualization-Based
Security (VBS), or Hyper-V VSM-style, secure environment using KVM VM
Planes.  It is the QEMU counterpart to the Linux VBS/VSM-on-KVM series.

The five patches in this mail series are authored by me and add:

  - userspace handlers for VM Plane and VBS VTL-call exits from KVM;
  - the VBS VTL hypercall definitions from the Linux UAPI;
  - loading and running the secure-plane kernel in-kernel; and
  - plane configuration access through the QEMU address-space API.

This series depends on the QEMU VM Planes infrastructure from Joerg
Roedel and related prerequisite work.  Those patches are not duplicated
in this mail series.  The integrated QEMU branch linked below contains
the complete tree, including Joerg's patches and the other prerequisites,
used for development and testing.

The complete implementation is available in three repositories under the
safe-tee organization:

  QEMU support and complete integrated tree:
  https://github.com/safe-tee/qemu/tree/qemu-planes-v11.1.0-rc1

  Linux and KVM support:
  https://github.com/safe-tee/linux/tree/kvm-planes-v7.2-rc5

  Build, test, and integration tooling:
  https://github.com/safe-tee/lvbs

Current build and run instructions are maintained in the lvbs repository:

  https://github.com/safe-tee/lvbs/blob/main/docs/how-to/how-to-build.md

This is prototype code and is not yet intended for production use.
Feedback on the QEMU integration, VTL-call handling, and division of
responsibility between QEMU and the in-kernel VM Plane implementation
would be appreciated.

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

Sriram Nambakam (5):
  kvm: add userspace handlers for VM planes and VBS VTL calls
  vm_planes: Add VBS VTL call handling and plane memory sealing
  linux-headers: sync kvm_para.h VBS VTL hypercalls
  target/i386/kvm: run the secure plane in-kernel (Option B)
  target/i386/kvm: read plane config via address_space API

 accel/kvm/kvm-all.c                       |  18 +
 include/standard-headers/linux/kvm_para.h |   7 +-
 include/system/kvm_int.h                  |  18 +
 linux-headers/linux/kvm.h                 |  16 +
 target/i386/kvm/kvm.c                     | 561 ++++++++++++++++++++++
 5 files changed, 619 insertions(+), 1 deletion(-)

-- 
2.55.0

