Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E032C11FA
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695267; cv=none; b=UsI0n7dimCXFG4mj2rpRa8I5QtTcbkRyEHsDrEH5f01yVIFvZfjeB6sKEyYKdn0xtBehWgy8Y2LNTDoFZT1Ld2f3sjXA/f2v6YV8xUXiEEQr5Etx+4yr2DdZxNznvrSc4F0H8c5CqS5M3DX67ksh6XGE6gPOttVA8PKDPMsnypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695267; c=relaxed/simple;
	bh=rQ70UhUodRTSiKvH0ozsLIWSQo3JCESCHHjTURhxtZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZSyQCVDc3nbwz9zsA8rJ9RPYVQMFPjkg/MflPUqJ0MZi+Ye9nsP/o/uzKVevL6INKXaYz4E7F4Qjdg5ULElTzSiTyutF+ePrBrfxZGHtccj+E1sefKZLJYOJJHIN8RWENR8X59qHhGIWLTlh1wrBKU6yzAo94AqD9h6UypErvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nMcKdT+y; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMcKdT+y"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so506204a91.1
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695265; x=1788300065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QiElhV40kLZgn2p0ydPjTL1vJDUlrNWu2jfkcIQqWeo=;
        b=nMcKdT+yMaPsTvL+TlrmG7uv1P4lNg3LDZudt5+XqxDbsG5eCFpfZO4ol8O+FpB+TF
         vlR+/iT8cWSDp2c/x1AvZnlzjo9aww+RAtPnKRE0KGbHj3ucWqJOIaxt3+RcJqjwzCJ1
         KQk6qdRzF3QWJytN0Lr9gF9YbI+kZ5+U6IuITNV090DNo3AgVhJVvLEXkvk6okBmGd7Q
         VPtvGvteTtgPBrKWcYT+Uo4LNHrUuQkfEa6lo0alAccMDrgzPQAOSh8QB2tCZMl8+IXt
         vH0B+HO4iYIlqQISkUoGSNU51cz4ln5dVFs52J0uAHLVKq6k6ZAnrRvCWLr4onRr8r5e
         o7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695265; x=1788300065;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QiElhV40kLZgn2p0ydPjTL1vJDUlrNWu2jfkcIQqWeo=;
        b=EoixQPJrNxkxaE9mEoBDmSahDV3qNdG2z39gEcT9cBlz08qMsbo73ahRfI9HFcw7j+
         ugPIc0RmfA5npk9MpKNCASi6gHl+Ptv9z9G0nZGmVWDwSktYAkdcM+M2d7mRI0bCohLO
         /dP01hY+DU6O23UL1kMGXURuZOAFb6+x9+pxk4dKNO9VA6cac9ZP3lZLJChvBOvx0cvE
         PY1/8bpXAKDguTTYgo1rqKRpsqJkZirochH6T1T87o1gUqd4PBvAYgdgcrgI0d53Eoeg
         j7GZt6lY9RyqIQnhcqq69I8FtSDkAEJWfOpF9vyupCngdlqe7iiP6iartrbZv+28ic5J
         oCBg==
X-Forwarded-Encrypted: i=1; AHgh+RpfNAGX2CwOfkO4sz2u7LdbumH4duFlhGd5zLHMnxPzt3WE0L/58N9PK+NPga7U6vc+KPE=@vger.kernel.org
X-Gm-Message-State: AFuF++m0rw1fFxYTuAjXOelHSgRsomdmZxCXGHlfl4WV/66ey+f+5X47
	YuKLMsnhwFCzAKwEt81ncUUbnKR+3NKdN5Dof4P2OQO7UiW8OHrfjot4byXaxWtKh28=
X-Gm-Gg: AR+sD10+23DbuEbB1UnUkOB/BJIaTc6fetLYvbJRlVfTc9EC2ICduOs23D8xJp1AUsB
	roYgJJJu1hxj8FVCm1noKuLGPqUJPo8FYbPFqtUd7VDAtL68OasNeqZ5EpqEsh8xmR1ILpj0Rac
	I0I3162Kgnt3hU8q+Kh2liBlH+p465lMSHg+FWce8n+bAZ/1FfXO8c2QH1p1uCwWg++tEeGlH/J
	aFWt5RSdwnc8TDFL/nt+EIgavju/cfrpgBIGs9LCnlsf9Ep9v4XCzNLN+0wZvKMhMk8YsfGaLRI
	8wMxjsEQVbS5HhK7iDtKgm1BrsV6aRq1dnFVYaEB6Rg7IyZLagdjsiVHCWSj9jkfwFnNHy9R9w1
	vcEucZ7Y0x4Xr/F2VTiqWX1C3q1tDK4EK9ilGkmqbmsxr4USxkXTFnB1UHcB/RyGct7QqVrsaT1
	/FVOBfnme4WaTgdLk/Z1HSNDURxc9oD/4eEUs0NIlbwFebHU7pO85wIdfWfX8uyVG0t81R82+PE
	Sg1jmc79bds0z0=
X-Received: by 2002:a17:90b:2885:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-3966d5c1a78mr4454909a91.15.1787695264783;
        Tue, 25 Aug 2026 15:01:04 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:03 -0700 (PDT)
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
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v3 00/24] Add Realm support to QEMU-VMM
Date: Tue, 25 Aug 2026 16:00:37 -0600
Message-ID: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
 -M confidential-guest-support=rme0,memory-backend=ram0 \
 -object rme-guest,id=rme0,convert-in-place=on \
 -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
 -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..

It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
back.  It is compatible with Steven Price's v16 revision [1] of his work adding
CCA support to KVM.

This revision is based on Michael Roth's work on guest memfd in-place memory
conversion [2] and as such, the QEMU baseline is different from 'master'.  Other
than modifications to use in-place memory conversion from Lorenzo Pieralisi that
were integrated to patches 04, 08-11, it is identical to V2.   

It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
here [3], along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
with Steven's v16 patchset).  The Repository for the kernel [6] is available
from Arm.

Instructions to compile and run the entire stack can be found here [7].

Device Assignment is not included.

Thanks,
Mathieu

[1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
[2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
[3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v3?ref_type=heads
[4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
[5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
[6]. https://gitlab.arm.com/linux-arm/linux-cca/-/tree/cca-host/v16?ref_type=heads
[7]. https://gitlab.com/Linaro/cca-public/build-instructions

RFC v2: https://lore.kernel.org/kvm/20260728192630.240375-1-mathieu.poirier@linaro.org/
RFC v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html

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
 hw/arm/virt.c                              | 142 +++++++--
 hw/core/loader.c                           |  15 +
 include/hw/arm/boot.h                      |   9 +
 include/hw/arm/virt.h                      |   2 +-
 include/hw/core/loader.h                   |  17 ++
 linux-headers/asm-arm64/kvm.h              |   9 +
 linux-headers/linux/kvm.h                  |  12 +-
 qapi/qom.json                              |  13 +
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu.h                           |  10 +
 target/arm/cpu64.c                         | 122 ++++++++
 target/arm/kvm-rme.c                       | 336 +++++++++++++++++++++
 target/arm/kvm-stub.c                      |   9 +
 target/arm/kvm.c                           | 202 ++++++++++++-
 target/arm/kvm_arm.h                       |  20 ++
 target/arm/meson.build                     |   5 +-
 21 files changed, 963 insertions(+), 51 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.43.0

