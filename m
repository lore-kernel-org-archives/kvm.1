Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEA3909B3
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382957; cv=none; b=GNeetjfMeO4U+xVgLpnado47I0ZuORj9Y491MY/XCvy+8gVKIzPp0uyzbSD6EDYlxX5VG+0vMhO261mAefQd8/MTkFpYUNKnRjL3IJSDVEFWKuzQUV3/DTNu8OskgVs2Z4DXn3KZWL4CKsbsS000Ma4rMYTGm47t/y3RC4FqvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382957; c=relaxed/simple;
	bh=dSsEH1Vf9qxxznhQtixdo63+0nc1EpssuMN2xBw0T8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+ckclICQ2oUkjmS6HeHc7p2KZ0E8mKfuZ/aRQ+b9+YTscZjhyVBCqy0YQsmazrRpaExjTCiYonSAcMW8o8jIrL04h5qwU+0HEqLjaNWiLaaK98XH7kMP7v/XQIrzrc4ZQXRSMhkPKcdWx6oU+vNQhncg02eJCiEJK5j87mrkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lGxQMgHX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lGxQMgHX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651HED9c2905913;
	Tue, 2 Jun 2026 06:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4XVDGhABVLEu8f0zg
	l5Gku3RzciqmWz3WDsFwECafgE=; b=lGxQMgHXpOrWoBrT7KNBXDinMiMaV+hNs
	z7lLTS+D1/5N2fc05yF0JrbJD1fPsbidwRq274k46NJ10ZQp1UzPXnHYpIejUghA
	QjjioqXrumUgSAw5aREA3a5t4G6xxS5AW/Yfzf2zdbXquTVhtp6OIQlQ/tgorOK4
	yZzUJWt1Mwuz8qFEZ2c2IjEwwF0OUTiv23JtcDfzyK5dvD8+ZJWlswxCx89S/i6h
	Z+hoqIF59nGjRf1cIcWWYsTHyfgFIchqFCOY2ZT72QkuFJtjbFVmE+pxVXwPX4Cw
	1O1HovkahuRO4gDLAt13BmA5U9uKS5w2gEx2Pt9h1PNa18pXq+eyQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae48re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:48:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6526dGnc015481;
	Tue, 2 Jun 2026 06:48:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceghqs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:48:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6526msnL51315092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 06:48:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC2E420043;
	Tue,  2 Jun 2026 06:48:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6468820040;
	Tue,  2 Jun 2026 06:48:52 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.bl1-in.ibm.com (unknown [9.123.8.229])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 06:48:52 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests RFC PATCH 2/6] configure: Make arch_libdir a first-class entity
Date: Tue,  2 Jun 2026 12:18:02 +0530
Message-ID: <20260602064806.3101025-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602064806.3101025-1-rathc@linux.ibm.com>
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1e7cdb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=TgLM54nR-fRGc_TkKysA:9
X-Proofpoint-GUID: S4sXf4O1E8ZlBmrM8GsEQF3n4eWJmzgy
X-Proofpoint-ORIG-GUID: erRMb-XMUu0vbClHlysENjCv_AS7MKtF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1OSBTYWx0ZWRfXzqfG+qFs+JhS
 8uXcKGZApLwm4KbIUSpvW9OLaVhtYAxD+36OkjNopgyKjB0So2lPt68k2ECAmx8SCM7qywXpkns
 EetVZ1kp7rcL7m1ML6l+1xjfbR8tlIsuglvoibv4JLmElo9iBKQYs5FXjaVIjXzgaSHXWo5THEa
 in26ZKG1I5AwY5JEj/AKkEZPx1QfP5iczn6oTWVqNcS1C04adU8jkoDOZlTc8bzlaY/MTQ73Nwd
 7dnfBy7EbTLFSbkMfuWTJ84TtNyzeS4a8rlF3arPoWNbhs/KhkD6MGdY6KBHMy3xG/jaSlPSNy6
 h8C+srjyIO7kmt6Y+gCtzQbfY90Gj2Bak9B2AJXntwJVXjeLFzJM+H/Nzmfxkk3Q4xRZPv4oXKG
 e108eQ+BtTz7SnA7QfVHz1S30vy9IVx26U0EHqCtTm2ng/kMmDVTV20QVqi7zsLDbTLo8nqcLcI
 MBX0wtzqZUjCsI/qOOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020059

From: Nicholas Piggin <npiggin@gmail.com>

arch_libdir was brought in to improve the heuristic determination of
the lib/ directory based on arch and testdir names, but it did not
entirely clean that mess up.

Remove the arch_libdir->arch->testdir heuristic and just require
everybody sets arch_libdir correctly. Fail if the lib/arch or
lib/arch/asm directories can not be found.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 Makefile  |  2 +-
 configure | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 42ef5826..8e002043 100644
--- a/Makefile
+++ b/Makefile
@@ -12,7 +12,7 @@ vpath %.s $(SRCDIR)
 vpath %.S $(SRCDIR)
 
 libdirs-get = $(shell [ -d "lib/$(1)" ] && echo "lib/$(1) lib/$(1)/asm")
-ARCH_LIBDIRS := $(call libdirs-get,$(ARCH_LIBDIR)) $(call libdirs-get,$(TEST_DIR))
+ARCH_LIBDIRS := $(call libdirs-get,$(ARCH_LIBDIR))
 OBJDIRS := $(ARCH_LIBDIRS)
 
 DESTDIR := $(PREFIX)/share/kvm-unit-tests/
diff --git a/configure b/configure
index 6d549d1e..aeb5570c 100755
--- a/configure
+++ b/configure
@@ -274,7 +274,6 @@ fi
 arch_name=$arch
 [ "$arch" = "aarch64" ] && arch="arm64"
 [ "$arch_name" = "arm64" ] && arch_name="aarch64"
-arch_libdir=$arch
 
 if [ "$arch" = "riscv" ]; then
     echo "riscv32 or riscv64 must be specified"
@@ -373,8 +372,10 @@ fi
 
 if [ "$arch" = "i386" ] || [ "$arch" = "x86_64" ]; then
     testdir=x86
+    arch_libdir=x86
 elif [ "$arch" = "arm" ] || [ "$arch" = "arm64" ]; then
     testdir=arm
+    arch_libdir=$arch
     if [ "$target" = "qemu" ]; then
         : "${uart_early_addr:=0x9000000}"
     elif [ "$target" = "kvmtool" ]; then
@@ -385,6 +386,7 @@ elif [ "$arch" = "arm" ] || [ "$arch" = "arm64" ]; then
     fi
 elif [ "$arch" = "ppc64" ]; then
     testdir=powerpc
+    arch_libdir=ppc64
     firmware="$testdir/boot_rom.bin"
     if [ "$endian" != "little" ] && [ "$endian" != "big" ]; then
         echo "You must provide endianness (big or little)!"
@@ -400,6 +402,7 @@ elif [ "$arch" = "riscv32" ] || [ "$arch" = "riscv64" ]; then
     fi
 elif [ "$arch" = "s390x" ]; then
     testdir=s390x
+    arch_libdir=s390x
 else
     echo "arch $arch is not supported!"
     arch=
@@ -409,6 +412,10 @@ if [ ! -d "$srcdir/$testdir" ]; then
     echo "$srcdir/$testdir does not exist!"
     exit 1
 fi
+if [ ! -d "$srcdir/lib/$arch_libdir" ]; then
+    echo "$srcdir/lib/$arch_libdir does not exist!"
+    exit 1
+fi
 
 if [ "$efi" = "y" ] && [ -f "$srcdir/$testdir/efi/run" ]; then
     ln -fs "$srcdir/$testdir/efi/run" $testdir-run
@@ -471,15 +478,12 @@ fi
 # link lib/asm for the architecture
 rm -f lib/asm
 asm="asm-generic"
-if [ -d "$srcdir/lib/$arch/asm" ]; then
-	asm="$srcdir/lib/$arch/asm"
-	mkdir -p "lib/$arch"
-elif [ -d "$srcdir/lib/$arch_libdir/asm" ]; then
+if [ -d "$srcdir/lib/$arch_libdir/asm" ]; then
 	asm="$srcdir/lib/$arch_libdir/asm"
 	mkdir -p "lib/$arch_libdir"
-elif [ -d "$srcdir/lib/$testdir/asm" ]; then
-	asm="$srcdir/lib/$testdir/asm"
-	mkdir -p "lib/$testdir"
+else
+	echo "$srcdir/lib/$arch_libdir/asm does not exist"
+	exit 1
 fi
 ln -sf "$asm" lib/asm
 mkdir -p lib/generated lib/libfdt
-- 
2.53.0

