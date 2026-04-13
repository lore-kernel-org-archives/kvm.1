Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75133BBC0
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092698; cv=none; b=KcThJsmEyFNe7TsNrXksqJiiuY1oVfh0WH+Ua4+pb6kSuP/cXAgoWltLYpPPKsDxIdD8waLfC2lEro7Y9vMD7SYJGECL8KjleDr4V7j5/AzpT1xPGH+uWYdz/ONTXmZuaWXw0P51N5FtQy/9/qvcBy5Gwj+5hZdsyqcq/t8B44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092698; c=relaxed/simple;
	bh=bNqGJy+RgoN/rIyGkSUFKsV62U8Y52qB5T5kGMowXX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0LQdaJJI936Nco9r7T6xTeD1mhQK9D8JfV0jUj/g9C7v9cXDQSOJ30hVCXuV52UMojwHUPZeK2N25YpifittO0anHuIUePrO6ApDZG9cnHBKtB8W/eCqvENAPL5eBXhrmL/BDT/0hK+HeIHvGnQnL/9XYT2722e2bF/7UCJA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byNANFdb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byNANFdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776092695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EtqSo8BZOV4BrbnYeN0DtB3CEdnovYlYOjbVxFX4Qzs=;
	b=byNANFdbse41yre8I2EL6T7Cyv7tmYiQqWOQB59vUG1YDwZqSp42BFVwqe2LR5/4ZhGo2o
	9gN0TAdq0YVKzq3U8l7b+3RH0Jr48hxMqcvaowJ+PRqbog1svoD/c0r0zPpobPsfsnjqkK
	2Ap0qQ25Zgzwy2ZTIA2/l2/NTSVNSTg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-87A7zPKvORav5fEtLZJl9A-1; Mon,
 13 Apr 2026 11:04:49 -0400
X-MC-Unique: 87A7zPKvORav5fEtLZJl9A-1
X-Mimecast-MFC-AGG-ID: 87A7zPKvORav5fEtLZJl9A_1776092688
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E5A6195608B;
	Mon, 13 Apr 2026 15:04:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD4B819560B1;
	Mon, 13 Apr 2026 15:04:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org
Cc: Andrew Jones <andrew.jones@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [kvm-unit-tests PATCH] Update gitlab-CI jobs to Fedora 43
Date: Mon, 13 Apr 2026 17:04:44 +0200
Message-ID: <20260413150444.28501-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thomas Huth <thuth@redhat.com>

Fedora 40 is EOL since a while already, so let's update to a more
recent version of Fedora here now. While we're at it, also refresh
the lists of tests according to what we can run with TCG of the
latest version of QEMU.

Something also has changed in the package dependencies in Fedora 43:
The "ps" program is not available by default anymore in some of the
jobs, so make sure to install it first via the "procps-ng" package now.

Additionallyly, the *-efi jobs don't seem to work right with the QEMU
or EDK2 firmware from Fedora 43 yet, so keep those pinned to an older
version for now until somebody tackled that problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 70 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2dffc050..daccdfef 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,8 +1,8 @@
-image: fedora:40
+image: fedora:43
 
 before_script:
  - dnf update -y
- - dnf install -y make python
+ - dnf install -y make python procps-ng
 
 # By default artifacts are only saved on success. This uses when:always
 # because the test logs are important to help diagnose failures.
@@ -40,6 +40,9 @@ build-aarch64:
       gicv3-ipi
       its-introspection
       its-trigger
+      mte-asymm
+      mte-async
+      mte-sync
       pci-test
       pmu-cycle-counter
       pmu-event-counter-config
@@ -54,6 +57,7 @@ build-aarch64:
 
 build-aarch64-efi:
  extends: .intree_template
+ image: fedora:41
  script:
  - dnf install -y qemu-system-aarch64 gcc-aarch64-linux-gnu edk2-aarch64
  - ./configure --arch=aarch64 --cross-prefix=aarch64-linux-gnu- --enable-efi --enable-efi-direct
@@ -68,6 +72,7 @@ build-aarch64-efi:
 
 build-aarch64-efi-acpi:
  extends: .intree_template
+ image: fedora:41
  script:
  - dnf install -y qemu-system-aarch64 gcc-aarch64-linux-gnu edk2-aarch64
  - ./configure --arch=aarch64 --cross-prefix=aarch64-linux-gnu- --enable-efi --enable-efi-direct
@@ -100,6 +105,9 @@ build-aarch64-clang:
       gicv3-ipi
       its-introspection
       its-trigger
+      mte-asymm
+      mte-async
+      mte-sync
       pci-test
       pmu-cycle-counter
       pmu-event-counter-config
@@ -114,6 +122,7 @@ build-aarch64-clang:
 
 build-aarch64-clang-efi:
  extends: .intree_template
+ image: fedora:41
  script:
  - dnf install -y edk2-aarch64 qemu-system-aarch64 gcc-aarch64-linux-gnu clang
  - ./configure --arch=arm64 --cc=clang --cflags='--target=aarch64' --cross-prefix=aarch64-linux-gnu- --enable-efi --enable-efi-direct
@@ -128,6 +137,7 @@ build-aarch64-clang-efi:
 
 build-aarch64-el2:
  extends: .intree_template
+ image: fedora:41
  script:
  - dnf install -y qemu-system-aarch64 gcc-aarch64-linux-gnu
  - ./configure --arch=aarch64 --cross-prefix=aarch64-linux-gnu-
@@ -144,6 +154,9 @@ build-aarch64-el2:
       gicv3-ipi
       its-introspection
       its-trigger
+      mte-asymm
+      mte-async
+      mte-sync
       pci-test
       pmu-cycle-counter
       pmu-event-counter-config
@@ -152,6 +165,7 @@ build-aarch64-el2:
       selftest-smp
       selftest-vectors-kernel
       selftest-vectors-user
+      timer
       | tee results.txt
  - grep -q PASS results.txt && ! grep -q FAIL results.txt
 
@@ -179,14 +193,24 @@ build-ppc64be:
  - ../configure --arch=ppc64 --endian=big --cross-prefix=powerpc64-linux-gnu-
  - make -j2
  - ACCEL=tcg ./run_tests.sh
-      selftest-setup
-      selftest-migration
-      selftest-migration-skip
-      spapr_hcall
+      atomics
+      emulator
+      interrupts
+      mmu
       rtas-get-time-of-day
       rtas-get-time-of-day-base
       rtas-set-time-of-day
-      emulator
+      selftest-migration
+      selftest-migration-skip
+      selftest-setup
+      sieve
+      smp
+      smp-smt
+      spapr_hcall
+      spapr_vpa
+      sprs
+      timebase
+      timebase-icount
       | tee results.txt
  - if grep -q FAIL results.txt ; then exit 1 ; fi
 
@@ -197,14 +221,24 @@ build-ppc64le:
  - ./configure --arch=ppc64 --endian=little --cross-prefix=powerpc64-linux-gnu-
  - make -j2
  - ACCEL=tcg ./run_tests.sh
-      selftest-setup
-      selftest-migration
-      selftest-migration-skip
-      spapr_hcall
+      atomics
+      emulator
+      interrupts
+      mmu
       rtas-get-time-of-day
       rtas-get-time-of-day-base
       rtas-set-time-of-day
-      emulator
+      selftest-migration
+      selftest-migration-skip
+      selftest-setup
+      sieve
+      smp
+      smp-smt
+      spapr_hcall
+      spapr_vpa
+      sprs
+      timebase
+      timebase-icount
       | tee results.txt
  - if grep -q FAIL results.txt ; then exit 1 ; fi
 
@@ -238,6 +272,7 @@ build-riscv64:
 
 build-riscv64-efi:
  extends: .intree_template
+ image: fedora:41
  script:
  - dnf install -y edk2-riscv64 qemu-system-riscv gcc-riscv64-linux-gnu
  - cp /usr/share/edk2/riscv/RISCV_VIRT_CODE.fd .
@@ -281,6 +316,7 @@ build-riscv64-clang:
 
 build-riscv64-clang-efi:
  extends: .intree_template
+ image: fedora:41
  script:
  - dnf install -y edk2-riscv64 qemu-system-riscv gcc-riscv64-linux-gnu clang
  - cp /usr/share/edk2/riscv/RISCV_VIRT_CODE.fd .
@@ -313,6 +349,7 @@ build-s390x:
       edat
       emulator
       epsw
+      execute
       exittime
       firq-linear-cpu-ids-tcg
       firq-nonlinear-cpu-ids-tcg
@@ -325,6 +362,7 @@ build-s390x:
       selftest-setup
       sieve
       smp
+      spec_ex
       stsi
       tprot
       vector
@@ -340,13 +378,14 @@ build-x86_64:
  - ACCEL=tcg ./run_tests.sh
       eventinj
       intel_iommu
-      ioapic-split
+      ioapic
       memory
       pks
       pku
       rdpru
       realmode
       rmap_chain
+      s3
       setjmp
       sieve
       smap
@@ -366,6 +405,7 @@ build-x86_64:
       vmexit_ple_round_robin
       vmexit_tscdeadline
       vmexit_tscdeadline_immed
+      xsave
       | tee results.txt
  - if grep -q FAIL results.txt ; then exit 1 ; fi
 
@@ -380,7 +420,9 @@ build-i386:
  - ACCEL=tcg ./run_tests.sh
       cmpxchg8b
       eventinj
+      la57
       realmode
+      s3
       setjmp
       sieve
       smap
@@ -412,7 +454,7 @@ build-clang:
  - ACCEL=tcg ./run_tests.sh
       eventinj
       intel_iommu
-      ioapic-split
+      ioapic
       memory
       pks
       pku
-- 
2.53.0

