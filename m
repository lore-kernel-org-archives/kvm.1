Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CB4AB1A1
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972431; cv=none; b=cedNNuUo8rmclzrT+jYVnsykfAttQXXB/Nvkl54wlzvjxD1r5MlojiVBWAoj6+jha1RIPvF9ZgzoD7kbTbQgvUqcGjlDGZSElkH3NdSsbnhONtpJm+o5Y/Diyj/zLNYgyd0SlHrF9UHfz6B6O3vr4PLfiBA2RgM1ljGO2R9mGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972431; c=relaxed/simple;
	bh=7RGoyN8FC23ySmMv+u4qpW5Y9O5HxDK4WnGg4hqeo5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=annSLO5oaR1tu00sBbsOnBINqCbavIVKk7/rq0XmbjzMRdlInm+ODfVmL42AJbQYXERZgLYgsMhftBv+k0uFZ98f7PNPx55o0A7coXXsofCZnHO2KYnJsJGwQkUsgXuwlJsyr2INv+p8mwH41oOBY8ix3ePAMuCSTK1sAhsjACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BXkn1Cv/; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXkn1Cv/"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc794a06e5fso4690783a12.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972429; x=1791577229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/jAQNOurkbQgnKI6cZW7c8GvzLntSTadaL0gN8ffsdw=;
        b=BXkn1Cv/v/rZUVTRhaUWACYQ5yve8sFvZTj59JkGIKGt5vo6XYwRXe+NMS2PlgeWWv
         28j4/TTiIxYAX2ObPV21MeEss1cEQCs8ThC/lblYc1bvzfY+I5lJ7nvXgBMWkOKQW7Lj
         cbbzwSDHz7FWpjG4ZGz34GjZb0Y/Vdtb1+HoLXEZ1xCMyNG+5aUobAzljvfwb5z8FzOY
         9I1Jr91tE2DnNLY7MlKkhvE/ouP5iUtXCEQJVuS8xM/M1zFuvKM1kkOobqpg33ZW4KIx
         +N4QXd9esBSPj9oBHwvetACRkv/GCdnfLAFfXbahMrKSPuXZeWNzPgN8J7egl9305YyU
         t4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972429; x=1791577229;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/jAQNOurkbQgnKI6cZW7c8GvzLntSTadaL0gN8ffsdw=;
        b=TqHzzru7Rum87Ls1seyaalFO1gxk7nviQQfQcK3T3PHia70YCsU0XskEB006Uyr7EA
         R/+wxcOggN+HPLy06tVjrjVfiXLDgWHzcSNFVEZFzCEkfowTk7hL6Amqd19PSsS/MQQg
         na2A5nw2uVXMbb3fu1caXDLELtPZMIPPlv4cq6aFHAwALLLTinEvzevqTZwJY+iGBtis
         ay6BLX4eigE523MGxf1EjXU470oq0jlzdtCUUQGDQhcHisU6W/AMv5KHTCkmMEje7icV
         qV2zyUgNivay9GOYl9bleCspYN/3jtat1phdYdaOqorO/NLxRCi06alAqEMq7qdIRng4
         5vAg==
X-Forwarded-Encrypted: i=1; AKwUvBxuup2FAn6WsQZf/RAeeekcvYMnMpL5UpTkxephXYtNtXkwlTZ4X653CoAUbbjKmtJmWFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXjdTnN3un3x/OhuDxjxsA7rSb1bIU1A8nfpYQs8JBNZohsQ7/
	7Pxv6yPft63Kf6HxryTctb59DPTBUxr+T9L4djYARYfM+JWyxY8qdFl6Bxuk3vp0stA=
X-Gm-Gg: AYBFou0TtZVn9g6m9llvTVif4q/kYJO8UOL3sYBob7WYurbxqbGA9ZjneeRnyNA/eRL
	qa6/ndLnrBa8/fwnWj4THMkTnJHSIWylQUSlg9jakpfSgI0tNDRy6YuVNDyjVkoY+U8JTvkL55C
	7xrrwx7geRJSi3TC4k32Fsbiu9c521tsgZitUhmcg9YZj7zLLhgPH0cEdk7iKJoUdoK22KG5gog
	1SbXa/A6F722fk71BlTM1WOKhHsOb6kOxut6q2UONp295z1a+gY1WKLX0U+RS3b6uIzp9h2Y8bU
	j5pgzQhzIs2BOIHcRviysOJ4ws8X1LpwOyRLW71lmMLjEB1CzyatOd1gjHYb04J/ToPnWD2tHKk
	B6u4fDMRP2rIPo4en82klL9H3YqToTWW+WSN6Ye5Uz9IFDYFum28Ogd93S5d9rTfxwa4V/tc2Sv
	ODe00nautqbggIhLIn34EeMo+d+64kX8f6GFiCZOHc+wdbjZ2ZQ34LD2oazNieiuZF03CgSnxCw
	+QQ5Cat5JVV4msiZEBWiYTe
X-Received: by 2002:a17:903:2b04:b0:2dd:c132:dc01 with SMTP id d9443c01a7336-2e49b6db84bmr33264295ad.46.1790972428637;
        Fri, 02 Oct 2026 13:20:28 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:28 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 00/22] Add Realm support to QEMU-VMM 
Date: Fri,  2 Oct 2026 14:20:04 -0600
Message-ID: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
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
 -object memory-backend-memfd,id=ram0,size=1G,share=on \
 -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..

It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
back.  It is compatible with Suzuki Poulose's basic KVM plumbing for Realms [1],
supplemented with Aneesh Kumar's latest work on swiotbl [2].

This revision is based on Michael Roth's second revision of his work on
guest-memfd in-place memory conversion [3], rebased to QEMU master.  It was
tested on the QEMU SBSA machine.

For convenience a repository is hosted here [4], along with the TF-A [5],
RMM [6] and kernel [7].

Instructions to compile and run the entire stack can be found here [8].

Thanks,
Mathieu

[1]. https://lore.kernel.org/kvm/63211ffe-fbf7-490e-940a-f9028f9412f6@arm.com/T/#m6a4fb7b947ba687795a9dd3c90874d9fb1eef02e
[2]. https://lore.kernel.org/all/20260921063628.362078-1-aneesh.kumar@kernel.org/
[3]. https://lore.kernel.org/kvm/20260908205236.838281-1-michael.roth@amd.com/
[4]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v5?ref_type=heads
[5]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
[6]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v20?ref_type=heads
[7]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v5-kvmv21?ref_type=heads
[8]. https://gitlab.com/Linaro/cca-public/build-instructions

RFC v4: https://lore.kernel.org/kvm/20260903193611.1058589-1-mathieu.poirier@linaro.org/
RFC v3: https://lore.kernel.org/kvm/20260825220101.3443954-1-mathieu.poirier@linaro.org/
RFC v2: https://lore.kernel.org/kvm/20260728192630.240375-1-mathieu.poirier@linaro.org/
RFC v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html

Changes since V4:
- Discarded original 02/24 because it was merged (thank you Philippe).
- Adjusted QEMU version i patch 03/24. 
- Fixed changelog in 06/24 (Kohei).
- Combined patches 09 and 10 (Michael).
- Moved check for "rom->addr == -1" to rom_reset() (Michael).

Jean-Philippe Brucker (21):
  linux-headers: Add RME related definitions
  target/arm: Add confidential guest support
  target/arm/kvm: Split kvm_arch_get/put_registers
  target/arm/kvm-rme: Initialize vCPU
  target/arm/kvm: Create scratch Realm VM when requested
  target/arm/kvm: Use kvm_vm_check_extension() where necessary
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
 hw/core/loader.c                           |  24 ++
 include/hw/arm/boot.h                      |   9 +
 include/hw/arm/virt.h                      |   2 +-
 include/hw/core/loader.h                   |  17 ++
 linux-headers/linux/kvm.h                  |  18 +-
 qapi/qom.json                              |  13 +
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu.h                           |  10 +
 target/arm/cpu64.c                         | 122 ++++++++
 target/arm/kvm-rme.c                       | 325 +++++++++++++++++++++
 target/arm/kvm-stub.c                      |   9 +
 target/arm/kvm.c                           | 201 ++++++++++++-
 target/arm/kvm_arm.h                       |  20 ++
 target/arm/meson.build                     |   5 +-
 20 files changed, 958 insertions(+), 50 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.43.0

