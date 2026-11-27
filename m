Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778878;
	b=v5qEdk8E7bPEkGbJTvtFHZvWVFa0Mrn7W+BVZzyTd/JdIXA1zrgarhbcqy8jq6/0aDxV
	 0stLdD8Rzp6okl1bORqj71rbnNZbHounvRdUYHkTtM9p/G3woODkjSDEMKWRIfDPi6Bjz
	 otRsWy+61kXlBGhqvbQ6FuXccgWX7eo5zjUDm9TNjlE1P7PT3i2sUYIevkGvhoWd1NCo7
	 e2v81IayAgXcSMuDgFwbBdFosl3ZBj7GTTKixbxYnQZ5vXUabUjDHWHBoM74Wi2ZeRagQ
	 fXuL/k3sOVcG5CiSCJuXlxZ5GYN1LPjireWKcdY5q4/3p1j8baVn7Q9RVDE9GaU08Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778878;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=XE2ARMdqjzGC3eYJ4eYvnmLdtPrB95chWrcFqgsLpdU=;
	b=owc6P0GDONlk4yDTpx8yvm4LZk+B1+VIXXjOSdhd027yDha3NBaPGAO1XhbGrtgsUQ1A
	 aYoeTZgom7Tom3JMOuPcfZN5aXYmYONgx9MT+QRw8DWyA5NB5SCIKnkPAdPBbtF2ED2TZ
	 Kk4OEl9hENyZxxIG5UJFfj0Y3fQuYJNZrwhAGxg+AhT38ORhlRcAon7zcioaufxNf7o0n
	 OrChsQ33sOut2lUlF47+yoxDcRQeD1oQ2RBkt379qm8TD6iUdx5C6ggXTf35yMgelLWqv
	 DuOrxN1TqdpD33JDPwvQeGtzqwDYe0IV5lVfIERZkGMbx5OYPGooIfzDkT85p5UUvuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SFS3P5Kl;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96924606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 11:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96924606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SFS3P5Kl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795778876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XE2ARMdqjzGC3eYJ4eYvnmLdtPrB95chWrcFqgsLpdU=;
	b=SFS3P5Klk/lOMvLaiUEUcKpjUTzucXcXpTFi31Qx6ffv/kahMnuttkQGzG2MNM8xzI6H0u
	IrdyVY3EcSa9EuquRf/z3W5VVo1hGmDiMV43xZPdGiSM1BiXOl6Al0lYTk6zNp6G+BOCKY
	A0PdZ4wP0YkjICjvvgJNuQaMNbyoizE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-yAlYoBQ9OVadX4Nu6wXyqw-1; Fri,
 27 Nov 2026 11:27:54 +0000
X-MC-Unique: yAlYoBQ9OVadX4Nu6wXyqw-1
X-Mimecast-MFC-AGG-ID: yAlYoBQ9OVadX4Nu6wXyqw_1795778874
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11382180028B
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 11:27:54 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DE481956042
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 11:27:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Subject: [PATCH kvm-unit-tests] run_tests: replace disabled_if with target
Date: Fri, 27 Nov 2026 12:27:51 +0100
Message-ID: <20261127112751.2510760-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

All instances of disabled_if are used to prevent the test from running
with kvmtool.  Make that explicit, just making target.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arm/unittests.cfg       | 14 +++++++-------
 docs/unittests.txt      | 16 +++++-----------
 scripts/common.bash     | 12 ++++++------
 scripts/runtime.bash    |  8 ++++----
 scripts/s390x/func.bash |  5 +++--
 5 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 12fc4468..df6f6d4e 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -43,7 +43,7 @@ groups = selftest
 [pci-test]
 file = pci-test.flat
 groups = pci
-disabled_if = [[ "$TARGET" != qemu ]]
+target = qemu
 
 # Test PMU support
 [pmu-cycle-counter]
@@ -220,7 +220,7 @@ test_args = its-migration
 qemu_params = -machine gic-version=3
 kvmtool_params = --irqchip=gicv3
 groups = its migration
-disabled_if = [[ "$TARGET" != qemu ]]
+target = qemu
 arch = arm64
 
 [its-pending-migration]
@@ -230,7 +230,7 @@ test_args = its-pending-migration
 qemu_params = -machine gic-version=3
 kvmtool_params = --irqchip=gicv3
 groups = its migration
-disabled_if = [[ "$TARGET" != qemu ]]
+target = qemu
 arch = arm64
 
 [its-migrate-unmapped-collection]
@@ -240,7 +240,7 @@ test_args = its-migrate-unmapped-collection
 qemu_params = -machine gic-version=3
 kvmtool_params = --irqchip=gicv3
 groups = its migration
-disabled_if = [[ "$TARGET" != qemu ]]
+target = qemu
 arch = arm64
 
 # Test PSCI emulation
@@ -282,7 +282,7 @@ file = debug.flat
 arch = arm64
 test_args = bp-migration
 groups = debug migration
-disabled_if = [[ "$TARGET" != qemu ]]
+target = qemu
 
 [debug-wp]
 file = debug.flat
@@ -295,7 +295,7 @@ file = debug.flat
 arch = arm64
 test_args = wp-migration
 groups = debug migration
-disabled_if = [[ "$TARGET" != qemu ]]
+target = qemu
 
 [debug-sstep]
 file = debug.flat
@@ -308,7 +308,7 @@ file = debug.flat
 arch = arm64
 test_args = ss-migration
 groups = debug migration
-disabled_if = [[ "$TARGET" != qemu ]]
+target = qemu
 
 # FPU/SIMD test
 [fpu-context]
diff --git a/docs/unittests.txt b/docs/unittests.txt
index 921318a6..fa0eb03d 100644
--- a/docs/unittests.txt
+++ b/docs/unittests.txt
@@ -125,15 +125,9 @@ The path and value cannot contain space, =, or shell wildcard characters.
 
 Can be overwritten with the CHECK environment variable with the same syntax.
 
-disabled_if
------------
-disabled_if = <condition>
+target
+------
+target = <target1> <target2> ...
 
-Do not run the test if <condition> is met. <condition> will be fed unmodified
-to a bash 'if' statement and follows the same syntax.
-
-This can be used to prevent running a test when kvm-unit-tests is configured a
-certain way. For example, it can be used to skip a qemu specific test when
-using another VMM and using UEFI:
-
-disabled_if = [[ "$TARGET" != qemu ]] && [[ "$CONFIG_EFI" = y ]]
+Restrict the test to the listed VMM targets, such as `qemu` or `kvmtool`.
+By default, the test can run with either target.
diff --git a/scripts/common.bash b/scripts/common.bash
index 47c45660..0f8ae5d6 100644
--- a/scripts/common.bash
+++ b/scripts/common.bash
@@ -16,7 +16,7 @@ function for_each_unittest()
 	local check
 	local accel
 	local timeout
-	local disabled_if
+	local test_target
 	local rematch
 	local raw
 	local current
@@ -50,7 +50,7 @@ function for_each_unittest()
 		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
 			rematch=${BASH_REMATCH[1]}
 			if [ -n "${testname}" ]; then
-				$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout" "$disabled_if"
+				$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout" "$test_target"
 			fi
 			testname=$rematch
 			smp="$(vmm_optname_nr_cpus) 1"
@@ -67,7 +67,7 @@ function for_each_unittest()
 			check=""
 			accel=""
 			timeout=""
-			disabled_if=""
+			test_target=""
 			continue
 		fi
 
@@ -97,8 +97,8 @@ function for_each_unittest()
 		elif [[ $line =~ ^check\ *=\ *(.*)$ ]]; then
 			current=check
 			value=${BASH_REMATCH[1]}
-		elif [[ $line =~ ^disabled_if\ *=\ *(.*)$ ]]; then
-			current=disabled_if
+		elif [[ $line =~ ^target\ *=\ *(.*)$ ]]; then
+			current=test_target
 			value=${BASH_REMATCH[1]}
 		elif [[ $line =~ ^accel\ *=\ *(.*)$ ]]; then
 			current=accel
@@ -114,7 +114,7 @@ function for_each_unittest()
 		[ -n "$current" ] && eval "$current=\$value"
 	done
 	if [ -n "${testname}" ]; then
-		$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
+		$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout" "$test_target"
 	fi
 	exec {fd}<&-
 }
diff --git a/scripts/runtime.bash b/scripts/runtime.bash
index bf5e2125..67518ca3 100644
--- a/scripts/runtime.bash
+++ b/scripts/runtime.bash
@@ -82,7 +82,7 @@ function run()
     local check="${CHECK:-$9}"
     local accel="${10}"
     local timeout="${TIMEOUT:-${11:-90s}}" # TIMEOUT env var overrides unittests.cfg
-    local disabled_if="${12}"
+    local test_target="${12}"
 
     if [ "${CONFIG_EFI}" == "y" ]; then
         kernel=${kernel/%.flat/.efi}
@@ -130,9 +130,9 @@ function run()
         accel="$ACCEL"
     fi
 
-    if [[ "$disabled_if" ]] && (eval $disabled_if); then
-        print_result "SKIP" $testname "" "disabled because: $disabled_if"
-	return 2
+    if [ -n "$test_target" ] && ! find_word "$(vmm_get_target)" "$test_target"; then
+        print_result "SKIP" $testname "" "$test_target only, but TARGET=$(vmm_get_target)"
+        return 2
     fi
 
     # check a file for a particular value before running a test
diff --git a/scripts/s390x/func.bash b/scripts/s390x/func.bash
index 28c3a70c..d5e132ef 100644
--- a/scripts/s390x/func.bash
+++ b/scripts/s390x/func.bash
@@ -18,9 +18,10 @@ function arch_cmd_s390x()
 	local check=${10}
 	local accel=${11}
 	local timeout=${12}
+	local test_target=${13}
 
 	# run the normal test case
-	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
+	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout" "$test_target"
 
 	# run PV test case
 	if [ "$accel" = 'tcg' ] || grep -q "migration" <<< "$groups"; then
@@ -36,5 +37,5 @@ function arch_cmd_s390x()
 		print_result 'SKIP' $testname '' 'PVM image was not created'
 		return 2
 	fi
-	"$cmd" "$testname" "$groups pv" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
+	"$cmd" "$testname" "$groups pv" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout" "$test_target"
 }
-- 
2.56.1

