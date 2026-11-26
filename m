Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689025;
	b=wn2B5moCzYIc+b2KZKW2mlOZ64jccJKlKiaRsPmUCtKQ1WOa3zqOBLR48egcGHxkNctD
	 9vKntTN+DIUf6hzLFHQILro9antHqhuJt5320QJKVuv/LT/JtNavN4Qo707b+/qS27lys
	 apBldI45Bnn3MeMqSn0uPXc/BmumR9bOd7PTlntLYgmEo3QYU+lA10EhuXvNCLv5F1x8C
	 cnKYgkn3vrPU4RdlmAy+MyfWP4cNYwYyG5gBQ0wTkGJ14FuiveMPrC0EV441hq4U5MFyE
	 yO2giXFZQfRysmmbkNPSQLc3i6T3vS0RVlSHAfk4lGzhH1OB+VKIzrNm+1FoVH1QFFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689025;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=e6zbMSlOPebg0JldMW65x3X+8puCWhODngf/n0pItJU=;
	b=uO8A5AkZDPzfdYc+ogXlYQFrkoItZg0WlQR4P+64qF5ATH5uSDm0+GJx5DFz6ZIokdzF
	 aqN5w5CPWpunct/WXZqJJOu8Og1ON7U0MsozP6NICZFfPxcwXnQNH3ktu4BHU6ZMEMGqm
	 Ghx3T0hplpsMSPvWMIahjticG/85fsrtjweGwkgJFj3H2wxncljHAs9bbbXq7PMsyAn14
	 pZfzj/9OLh5KRvHE/OmNntTKiigyMWkWBUTGpQ3XZo/Ghyy6pR9NtX8MjQI1eye7C28+n
	 hu8/IgSiAaxH/1CWbRhtbMs4jrHAKpf/Ki4Fbdg5yZ2PwBk/o9Hbl/ZmCVA0tQZCUhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JB9AnSNz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9460A260F
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BB9460A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JB9AnSNz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795689014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6zbMSlOPebg0JldMW65x3X+8puCWhODngf/n0pItJU=;
	b=JB9AnSNzVm7maqKBF9TYt05MtHVwy/ZU1YwlemGBIS4edts6vS0vYeemQ8ji+1veIG5Y65
	pdDHT0GzRkn18UpX/cwT55brDQ1YEkYfuNOHAERIUzbCZY8c1dk7AK2gkuW092jsNJ+tep
	xv0Rwp9gpA/eTQIXIgWP5L8feWAC4D0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-IY43AknENJ6YSgdn-7MmWQ-1; Thu,
 26 Nov 2026 10:30:09 +0000
X-MC-Unique: IY43AknENJ6YSgdn-7MmWQ-1
X-Mimecast-MFC-AGG-ID: IY43AknENJ6YSgdn-7MmWQ_1795689009
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE6B41953976;
	Thu, 26 Nov 2026 10:30:08 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5EC51956086;
	Thu, 26 Nov 2026 10:30:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com,
	andrew.jones@linux.dev
Subject: [PATCH kvm-unit-tests 2/6] remove errata mechanism
Date: Thu, 26 Nov 2026 11:29:58 +0100
Message-ID: <20261126103002.2145135-3-pbonzini@redhat.com>
In-Reply-To: <20261126103002.2145135-1-pbonzini@redhat.com>
References: <20261126103002.2145135-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The mechanism has no users anymore, and kernel version checks are
not a good way to implement test waivers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 README.md               | 32 ++----------------
 configure               | 15 ---------
 errata.txt              |  9 -----
 lib/errata.h            | 58 -------------------------------
 run_tests.sh            |  4 +--
 scripts/arch-run.bash   | 75 -----------------------------------------
 scripts/mkstandalone.sh | 10 ------
 7 files changed, 4 insertions(+), 199 deletions(-)
 delete mode 100644 errata.txt
 delete mode 100644 lib/errata.h

diff --git a/README.md b/README.md
index cbd8a994..7e377680 100644
--- a/README.md
+++ b/README.md
@@ -137,11 +137,9 @@ Additionally these self-explanatory variables are reserved
 # Guarding unsafe tests
 
 Some tests are not safe to run by default, as they may crash the
-host. kvm-unit-tests provides two ways to handle tests like those.
-
- 1) Adding 'nodefault' to the groups field for the unit test in the
-    unittests.cfg file.  When a unit test is in the nodefault group
-    it is only run when invoked
+host. To avoid this, you can add 'nodefault' to the groups field for
+the unit test in the unittests.cfg file.  When a unit test is in the
+nodefault group it is only run when invoked
 
      a) independently, `ARCH-run ARCH/test`
 
@@ -150,30 +148,6 @@ host. kvm-unit-tests provides two ways to handle tests like those.
 
      c) by specifying all tests should be run, `./run_tests.sh -a`
 
- 2) Making the test conditional on errata in the code,
-    ```
-    if (ERRATA(abcdef012345)) {
-        do_unsafe_test();
-    }
-    ```
-
-    With the errata condition the unsafe unit test is only run
-    when
-
-    a) the ERRATA_abcdef012345 environment variable is provided and 'y'
-
-    b) the ERRATA_FORCE environment variable is provided and 'y'
-
-    c) by specifying all tests should be run, `./run_tests.sh -a`
-       (The -a switch ensures the ERRATA_FORCE is provided and set
-        to 'y'.)
-
-The ./errata.txt file provides a mapping of the commits needed by errata
-conditionals to their respective minimum kernel versions.  By default,
-when the user does not provide an environ, then an environ generated
-from the ./errata.txt file and the host's kernel version is provided to
-all unit tests.
-
 # Contributing
 
 ## Directory structure
diff --git a/configure b/configure
index 974ef4b4..7c9ebd49 100755
--- a/configure
+++ b/configure
@@ -57,8 +57,6 @@ environ_default=yes
 u32_long=
 wa_divide=
 target=
-errata_force=0
-erratatxt="$srcdir/errata.txt"
 host_key_document=
 gen_se_header=
 enable_dump=no
@@ -102,8 +100,6 @@ usage() {
 	    --[enable|disable]-default-environ
 	                           enable or disable the generation of a default environ when
 	                           no environ is provided by the user (enabled by default)
-	    --erratatxt=FILE       specify a file to use instead of errata.txt. Use
-	                           '--erratatxt=' to ensure no file is used.
 	    --host-key-document=HOST_KEY_DOCUMENT
 	                           Specify the machine-specific host-key document for creating
 	                           a PVM image with 'genprotimg' (s390x only)
@@ -199,10 +195,6 @@ while [[ $optno -le $argc ]]; do
 	--disable-default-environ)
 	    environ_default=no
 	    ;;
-	--erratatxt)
-	    erratatxt=
-	    [ "$arg" ] && erratatxt=$(eval realpath "$arg")
-	    ;;
 	--host-key-document)
 	    host_key_document="$arg"
 	    ;;
@@ -266,11 +258,6 @@ if [ -n "$host_key_document" ] && [ ! -f "$host_key_document" ]; then
     exit 1
 fi
 
-if [ "$erratatxt" ] && [ ! -f "$erratatxt" ]; then
-    echo "erratatxt: $erratatxt does not exist or is not a regular file"
-    exit 1
-fi
-
 arch_name=$arch
 [ "$arch" = "aarch64" ] && arch="arm64"
 [ "$arch" = "powerpc" ] && arch="ppc64"
@@ -518,7 +505,6 @@ FIRMWARE=$firmware
 ENDIAN=$endian
 PRETTY_PRINT_STACKS=$pretty_print_stacks
 ENVIRON_DEFAULT=$environ_default
-ERRATATXT=$erratatxt
 U32_LONG_FMT=$u32_long
 WA_DIVIDE=$wa_divide
 GENPROTIMG=${GENPROTIMG-genprotimg}
@@ -547,7 +533,6 @@ if [ "$arch" = "arm" ] || [ "$arch" = "arm64" ]; then
 cat <<EOF >> lib/config.h
 
 #define CONFIG_UART_EARLY_BASE ${uart_early_addr}
-#define CONFIG_ERRATA_FORCE ${errata_force}
 
 EOF
 fi
diff --git a/errata.txt b/errata.txt
deleted file mode 100644
index b66afaa9..00000000
--- a/errata.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-#---------------:-------------------------------:---------------------------------------------------
-# commit        : minimum kernel                : summary
-# 12 hex digits : version                       :
-#---------------:-------------------------------:---------------------------------------------------
-9e3f7a296940    : 4.9                           : arm64: KVM: pmu: Fix AArch32 cycle counter access
-7b6b46311a85    : 4.11                          : KVM: arm/arm64: Emulate the EL1 phys timer registers
-6c7a5dce22b3    : 4.12                          : KVM: arm/arm64: fix races in kvm_psci_vcpu_on
-8c58be34494b    : 5.6                           : KVM: arm/arm64: vgic-its: Fix restoration of unmapped collections
-#---------------:-------------------------------:---------------------------------------------------
diff --git a/lib/errata.h b/lib/errata.h
deleted file mode 100644
index de8205d8..00000000
--- a/lib/errata.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * errata functions
- *
- * This code is free software; you can redistribute it and/or modify it
- * under the terms of the GNU Library General Public License version 2.
- */
-#ifndef _ERRATA_H_
-#define _ERRATA_H_
-#include <libcflat.h>
-
-#include "config.h"
-
-#ifndef CONFIG_ERRATA_FORCE
-#define CONFIG_ERRATA_FORCE 0
-#endif
-
-#define _ERRATA(erratum) errata("ERRATA_" # erratum)
-#define ERRATA(erratum) _ERRATA(erratum)
-
-#define _ERRATA_RELAXED(erratum) errata_relaxed("ERRATA_" # erratum)
-#define ERRATA_RELAXED(erratum) _ERRATA_RELAXED(erratum)
-
-static inline bool errata_force(void)
-{
-	char *s;
-
-	if (CONFIG_ERRATA_FORCE == 1)
-		return true;
-
-	s = getenv("ERRATA_FORCE");
-	return s && (*s == '1' || *s == 'y' || *s == 'Y');
-}
-
-static inline bool errata(const char *erratum)
-{
-	char *s;
-
-	if (errata_force())
-		return true;
-
-	s = getenv(erratum);
-
-	return s && (*s == '1' || *s == 'y' || *s == 'Y');
-}
-
-static inline bool errata_relaxed(const char *erratum)
-{
-	char *s;
-
-	if (errata_force())
-		return true;
-
-	s = getenv(erratum);
-
-	return !(s && (*s == '0' || *s == 'n' || *s == 'N'));
-}
-
-#endif
diff --git a/run_tests.sh b/run_tests.sh
index 4cfc3cd9..87d89751 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -20,8 +20,7 @@ Usage: $0 [-h] [-v] [-a] [-g group] [-j NUM-TASKS] [-t] [-l]
 
     -h, --help          Output this help text
     -v, --verbose       Enables verbose mode
-    -a, --all           Run all tests, including those flagged as 'nodefault'
-                        and those guarded by errata.
+    -a, --all           Run all tests, including those flagged as 'nodefault'.
     -g, --group         Only execute tests in the given group
     -j, --parallel      Execute tests in parallel
     -t, --tap13         Output test results in TAP format
@@ -63,7 +62,6 @@ while [ $# -gt 0 ]; do
     case "$1" in
         -a | --all)
             run_all_tests="yes"
-            export ERRATA_FORCE=y
             ;;
         -g | --group)
             shift
diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
index 41a903e4..2b3154ce 100644
--- a/scripts/arch-run.bash
+++ b/scripts/arch-run.bash
@@ -399,7 +399,6 @@ initrd_create ()
 		KVM_UNIT_TESTS_ENV=$(mktemp)
 		env_params
 		env_file
-		env_errata || return $?
 	fi
 
 	unset INITRD
@@ -470,80 +469,6 @@ env_file ()
 	done
 }
 
-env_errata ()
-{
-	local new_env
-
-	if [ "$ACCEL" = "tcg" ]; then
-		export "ERRATA_FORCE=y"
-	elif [ "$ERRATATXT" ] && [ ! -f "$ERRATATXT" ]; then
-		echo "$ERRATATXT not found. (ERRATATXT=$ERRATATXT)" >&2
-		return 2
-	elif [ "$ERRATATXT" ]; then
-		env_generate_errata
-	fi
-	new_env=$(sort <(env | grep '^ERRATA_') <(grep '^ERRATA_' $KVM_UNIT_TESTS_ENV) | uniq -u)
-	echo "$new_env" >>$KVM_UNIT_TESTS_ENV
-}
-
-env_generate_errata ()
-{
-	local line commit minver errata rest v p s x have
-
-	for line in $(grep -v '^#' "$ERRATATXT" | tr -d '[:blank:]' | cut -d: -f1,2); do
-		commit=${line%:*}
-		minver=${line#*:}
-
-		test -z "$commit" && continue
-		errata="ERRATA_$commit"
-		[ -n "${!errata}" ] && continue
-
-		IFS=. read -r v p rest <<<"$minver"
-		IFS=- read -r s x <<<"$rest"
-		s=${s%%[!0-9]*}
-		x=${x%%[!0-9]*}
-
-		if ! [[ $v =~ ^[0-9]+$ ]] || ! [[ $p =~ ^[0-9]+$ ]]; then
-			echo "Bad minimum kernel version in $ERRATATXT, $minver"
-			return 2
-		fi
-		! [[ $s =~ ^[0-9]+$ ]] && unset $s
-		! [[ $x =~ ^[0-9]+$ ]] && unset $x
-
-		if (( $KERNEL_VERSION > $v ||
-		      ($KERNEL_VERSION == $v && $KERNEL_PATCHLEVEL > $p) )); then
-			have=y
-		elif (( $KERNEL_VERSION == $v && $KERNEL_PATCHLEVEL == $p )); then
-			if [ "$KERNEL_SUBLEVEL" ] && [ "$s" ]; then
-				if (( $KERNEL_SUBLEVEL > $s )); then
-					have=y
-				elif (( $KERNEL_SUBLEVEL == $s )); then
-					if [ "$KERNEL_EXTRAVERSION" ] && [ "$x" ]; then
-						if (( $KERNEL_EXTRAVERSION >= $x )); then
-							have=y
-						else
-							have=n
-						fi
-					elif [ "$x" ] && (( $x != 0 )); then
-						have=n
-					else
-						have=y
-					fi
-				else
-					have=n
-				fi
-			elif [ "$s" ] && (( $s != 0 )); then
-				have=n
-			else
-				have=y
-			fi
-		else
-			have=n
-		fi
-		eval export "$errata=$have"
-	done
-}
-
 trap_exit_push ()
 {
 	local old_exit
diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
index 6f46a4c3..90507cc3 100755
--- a/scripts/mkstandalone.sh
+++ b/scripts/mkstandalone.sh
@@ -67,11 +67,6 @@ generate_test ()
 		echo 'export FIRMWARE'
 	fi
 
-	if [ "$ENVIRON_DEFAULT" = "yes" ] && [ "$ERRATATXT" ]; then
-		temp_file ERRATATXT "$ERRATATXT"
-		echo 'export ERRATATXT'
-	fi
-
 	temp_file bin "$kernel"
 	# Don't want to expand $bin but print it as-is.
 	# shellcheck disable=SC2016
@@ -107,11 +102,6 @@ function mkstandalone()
 	echo Written $standalone.
 }
 
-if [ "$ENVIRON_DEFAULT" = "yes" ] && [ "$ERRATATXT" ] && [ ! -f "$ERRATATXT" ]; then
-	echo "$ERRATATXT not found. (ERRATATXT=$ERRATATXT)" >&2
-	exit 2
-fi
-
 trap 'rm -f $cfg' EXIT
 cfg=$(mktemp)
 
-- 
2.56.1


