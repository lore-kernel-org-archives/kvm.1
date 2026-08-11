Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10D72DCBEC
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413278; cv=none; b=XtY0bYEcKwhMG9gyAwSnfCN1426QX3vVzAZOgQXbQQRdaf+zbyYIDyvP1kurekk4z1L/zfVsbmjyfKrplJxNdXxxptPR18HbGQxJK+gNC8kTJV9ZCLkHykrk79N1vXMdhufayJQB/rFo2VmRntE927OaGhagie+lK1jwih8OAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413278; c=relaxed/simple;
	bh=Q5l0PAWEgly4ASTzp2BuTZDv+KtHUyuQpfBF8s3LP2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olA0noDPob1QlRDh6Jy01eDFNwUsrOX9H8pRyAbcdi2P+i5PqsUNK+Se3i1Qo5SoTkenbeSUZmNPVdX+Q7UW5o362pvisC8pB1rjZvHsspUK9opRXRa1biThAPdQSOrg4shYW2qQBgdHDhimheCQ6plzChtK1TRFLIn8jLjgLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cv0OZWju; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cv0OZWju"
Received: from fedora (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF08220B7167;
	Mon, 10 Aug 2026 18:54:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF08220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413252;
	bh=kOka5qlcuXusfVx+drGk+dXfjD1PnmcaiPUEK/CDTU0=;
	h=From:To:Cc:Subject:Date:From;
	b=cv0OZWjuqDqV7ZTuFlG8Chx8Qg0ObnI+FFQPKzDIS8rcukdwQOoYNE7Xqo7yQsJTb
	 P68yU+Vzqm5Z+GMqpQRI4Lxd2f3NKWgpH85ycfF3nUbOshlJhFJqO1QrAenG8kIGrC
	 P9fBeWe/zyvZyODhnuEWSka5ynUeLqcH/BS3m99c=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v2 0/1] qemu: KVM VM Planes host support for VBS
Date: Mon, 10 Aug 2026 18:54:26 -0700
Message-ID: <20260811015427.188876-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC adds the QEMU support needed to run Virtualization-Based
Security (VBS) across KVM VM Planes.  It handles the guest's plane
configure and activate hypercalls in userspace: allocating and mapping
each plane's RAM, creating the plane and its sibling vCPUs, and
initialising them to enter the loaded plane kernel.

This is v2 of the series.  Based on feedback from maintainers, the KVM
host, guest, and QEMU changes are now being posted as three separate,
layered RFCs to make it easier to understand the context of these
changes as they pertain to the KVM host, guest, and QEMU.  This
patchset does not yet include memory protection between planes; that
will be added in a future version.

This series is based on the QEMU VM Planes prerequisite patchset obtained
from Joerg Roedel's tree (qemu-planes-linux-v7.1).

This is the userspace counterpart to the separately posted four-patch
KVM host RFC.  This remains prototype code and is not intended for
production use.

The implementation and integration tooling are available at:

  Linux and KVM support:
  https://github.com/safe-tee/linux/tree/vm-planes-layered

  QEMU support:
  https://github.com/safe-tee/qemu/tree/vm-planes-layered

  Build, test, and integration tooling:
  https://github.com/safe-tee/lvbs

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

Feedback on the plane configuration/activation handling and the
memory/vCPU setup it performs is welcome.

Sriram Nambakam (1):
  kvm: handle VM-plane configure/activate hypercalls

 accel/kvm/kvm-all.c                       |  20 +
 include/standard-headers/linux/kvm_para.h |   2 +
 include/system/kvm_int.h                  |  20 +
 target/i386/kvm/kvm.c                     | 517 ++++++++++++++++++++++
 4 files changed, 559 insertions(+)


base-commit: e94b8abef8617a074fac3cfc2797c0c2359ceb8c
-- 
2.55.0

