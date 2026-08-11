Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC7C197A7D;
	Tue, 11 Aug 2026 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408293; cv=none; b=U4SuytnSkG08xAdzogRWWhJoFtQJ3n2IXf+PpQQGlfdOpPkd19m2TH1zkiyGqhc4q6ZCQN25sqjfhtCvg7BrVQQZ6y6yXNseJ3+F75t5dZEfyGuvSxyRzRnUVOHLfMwvwezNOCBjAgPES1t3dvH+a+7Cbejzy0e8lbTJ5/b3C7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408293; c=relaxed/simple;
	bh=PvnN/ZxXKh/huMg84bpjjpeBwDlumXVS9arg2KVIZMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8NvjC6AC0ZbTH8JJgg7Z1yzxUNKqvomFDbKw3LnfT4BtA2nqaWZfhltgpSOsxt1gPzccgqhsakWJy7kNU1wwQ3VhEQmqLAgmbx0L9L7GVd0cWIEx+q2fvp2T2q3q2Sx9kCv6YdZ5TFJz+4nhWZ40B5A8+QSA7k+bbZL3li8oQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bMI8DPUl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bMI8DPUl"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id B94FC20B7167;
	Mon, 10 Aug 2026 17:31:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B94FC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786408265;
	bh=Lb0GihC4Daxv7j76le1aACNRdXVo9CZb9L2APZUw5a0=;
	h=From:To:Cc:Subject:Date:From;
	b=bMI8DPUlEXmmIqhYsWLW+hMjp+BgN1idx3NWwQ72dvpnHT3NV2pjY6n3AQHvQv/zB
	 ETRBZN7xZhBjVNwy5cSUQmDdVcoZ/IBdWkUxtb4HJn+WpNGZjBqqyB1tl66lMiixSV
	 UYb3ZqJtZfo2xMpIOj/TsorX/hsRJ/2NYC97Lv54=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/4] KVM: VM Planes host support for VBS
Date: Mon, 10 Aug 2026 17:31:10 -0700
Message-ID: <20260811003114.30107-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC adds the KVM host support needed to run Virtualization-Based
Security (VBS) across KVM VM Planes.  The series reserves the VM Plane and
VTL hypercalls, exits plane configuration and activation to userspace,
adds shared VTL-call state, and handles VTL call/return with an in-kernel
plane switch.

This is v2 of the series.  Based on feedback from maintainers, the KVM
host, guest, and QEMU changes are now being posted as three separate,
layered RFCs to make it easier to understand the context of these
changes as they pertain to the KVM host, guest, and QEMU.  This
patchset does not yet include memory protection between planes; that
will be added in a future version.

This series is based on the KVM VM Planes prerequisite patchset obtained
from Joerg Roedel's tree (kvm-planes-v7.1):
https://github.com/joergroedel/linux/tree/kvm-planes-v7.1

The dependent guest-side VBS support is being posted as a separate RFC.
This remains prototype code and is not intended for production use.

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

Feedback on the hypercall ABI, userspace exits, and in-kernel plane-switch
handling is welcome.

Sriram Nambakam (4):
  kvm: uapi: reserve VM-plane and VBS hypercall numbers
  KVM: x86: exit VM-plane config/activate hypercalls to userspace
  KVM: x86: add VTL-call state to struct kvm_vcpu_common
  KVM: x86: handle VBS VTL call/return via in-kernel plane switch

 arch/x86/kvm/x86.c            | 88 ++++++++++++++++++++++++++++++++++-
 include/linux/kvm_host.h      |  5 ++
 include/uapi/linux/kvm_para.h |  4 ++
 3 files changed, 96 insertions(+), 1 deletion(-)


base-commit: ca4f6f8de47d9b9d9c3fc613668ec72579ba111c
-- 
2.55.0

