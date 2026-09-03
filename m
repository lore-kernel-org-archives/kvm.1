Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E550C2B8
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464192; cv=none; b=TG4PtQQY+XUIYSL6BZJ75rForh1gRSy/EtOfQGdWGDyBLdxsCHhUYEldFpOzuFc4aFJykHO8n6UhV0J/rI+togdN/zdmWveiKQHNeZhKscrvqvOjZfYpBY8CRL2Plnjp0yfDl7HiYlnbxAujf0wyAJX0VE2hyZ1VjLWbBTms+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464192; c=relaxed/simple;
	bh=XWQnuTgpPF0Wc0I68otXg9OVKJyZU5biZKHyiuDbZpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c5iMl8pToY6RBDTu6+FTejUWh0cOT0iLfopGrAbGm0chqDmLrhZ5st//5dala/corciJBnMR73GoZ1zU7rLiTK1CN5KzQiS6nPOSREo7wwDm0VtP3TM/nLAo41AWgrVv9bd9GbwtVeBURKiaP9T7an+Aa8Oi+7jSMfQtrWJPB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IC1m5alx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IC1m5alx"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbee846deecso460243a12.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464174; x=1789068974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nWbGRl4D0xxd2T/AosPXgomaBayHTnR4GLenLBHLpTw=;
        b=IC1m5alxnSO8Oa8JG9b5ByN+mXMCTaNl/ATBt9TAEkWbdbCI0KPnbDng6+IaSwIXej
         G2ppDk9jElru23IROIk8kmVl4Y9t+3dzxqD7COjGCoADHODBUPjHhKw3DZiMVK7U3uEv
         CCvkK0ZleTPn8l5Jr9OsUYsHQwhbGyrPK/qhboYl9W32g6NLl8bFL3YnZhsechedp5hi
         OzMtPyG8aN4CatYoIlmf9DaktuK+iNnZJnAIsrXecnO2KlZfaWwMvyQCcVOR2obZHeux
         l8+1j6HToPsHwiET5gi6mtNTXdgjRBf7BrZyM7oQGSIlnPdSVweA1fv4ZQcqQD2Ph8OF
         V+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464174; x=1789068974;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nWbGRl4D0xxd2T/AosPXgomaBayHTnR4GLenLBHLpTw=;
        b=QEkiRrAruNCsKCaox5CCWtgli9a+NSim3c78bD6BKG/hVxhGUJX6YIwfQxitIFRFw6
         agXgIToFcxieJBkpLjlDuxgp7/zdgDCNmj9x7l4gu2qwAsbBx/90CG5hIUnWy6lCrgni
         xRwQiUrPGNum0WC0S8TuQHxlmiD7BnktuVKo22uOA9vlYGEfgy6Bp+V5VVsjUDWFJlaI
         6wlBdPiAn7rQpUg3AwxqF6ANauv8Vh/PokURi6ob74gyZsifY5SBcdvFOk3IWqpB55OE
         3DlmWTnFjLphdpCkV/gnedEGOoS9ySrzadAVtC8DDd6TK2yppT1U2FHJCQFAfEj8//86
         ys0w==
X-Forwarded-Encrypted: i=1; AKwUvBzgcq3UtQ0ESis22Wf6VulwkDa6PL6irKnzE5T1xiRxNp3ArYPNzlOdwltkyAlWWNSofx4=@vger.kernel.org
X-Gm-Message-State: AFuF++nu2NvEmEm/DoYDSrZbiApYmI2nbZUL6gJ+5davgHwInBKSxnqh
	5NkXxAtr64QIdce5F7yUxWvqTPM7zRbE6VI8zDEzH6WatChu/MA7PS3LLz8p6sbxv6I=
X-Gm-Gg: AYBFou1ZDdqTfsbwbqldhGs88QIeH3QF6tT8ybFGZEC3n6gl990dD1noHyxWWAD9Hqf
	xr6TS7FwhWMkmWeSkoSYBvLLqJZaPFL5h74S8wzDTcZTDxFeTxfhmI++JfhMI6p0fEAATlmpU/8
	vfOf4qAQIj7WYpVKwzXpjn/BSipepWHYYRsd0a8FWNjMjrPZAwWwJL6ERi/1ksPL3hI7sDku4AR
	BfN+sa8+zFy+/Tn5n+j/oC+Z3AprfjZCFcV52CHJgrOyvLAxjP+6/mAUHK9UyJQHMHJYh2IBCSj
	DrjMDlaftL9RcgLNWsL/77W/b5fE8HDjUoi1MaG+6w+tddaziScTui/v8Nkf2MNQqt+ogXT3yaD
	bDd+cb/xCmFFkoKtDuACnKfhbDbwz++z8l3Qy5lltzB5jaZWn2IStqTLS0UOx2PXfq3UNs4JjR6
	gIUrYIGwIgUr8KXAOnsxVSZpDdRK1FyNR7xKpNUtMFl4mSBFYxlhv5lpU+NOMCZQbHyJr6L3gTp
	Qm7tUv/k1z40fQ=
X-Received: by 2002:a17:90b:4b90:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39b2610f2fbmr1046991a91.8.1788464173806;
        Thu, 03 Sep 2026 12:36:13 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:13 -0700 (PDT)
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
Subject: [RFC v4 00/24] Add Realm support to QEMU-VMM
Date: Thu,  3 Sep 2026 13:35:47 -0600
Message-ID: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
conversion [2], rebased to QEMU master.  I left out the AMD specific changes  
from Michael's work because I can't test the result.  Other than the
modications to the linux headers, this series is identical to V3. 

It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
here [3], along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
with Steven's v16 patchset).  The Repository for the kernel [6] is also
available.  Note that for the latter, defines for
KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI have been modified to
follow QEMU master. 

Instructions to compile and run the entire stack can be found here [7].

Device Assignment is not included.

Thanks,
Mathieu

[1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
[2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
[3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v4?ref_type=heads 
[4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
[5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
[6]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v4?ref_type=heads 
[7]. https://gitlab.com/Linaro/cca-public/build-instructions

RFC v3: https://lore.kernel.org/kvm/20260825220101.3443954-1-mathieu.poirier@linaro.org/
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
 linux-headers/linux/kvm.h                  |  10 +-
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
 21 files changed, 962 insertions(+), 50 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.43.0

