Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50B3890F1
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069235; cv=none; b=TU/6GNFQykwUm/TdBWzeUnvmoEHf2iluLH8KCDdDCzZN7jmiRkX4xKmn8eA7sjoFEJHFJ2zH5UYIn71pJlBcz7dHk66e9DosP2qN/bfHP1GdFvDh3vpwWeryLnPaFXnfu03u8FEKs+m8WPJDXFAf+TIwmlU+zHTryDKruX3dNfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069235; c=relaxed/simple;
	bh=GPl7qwDso3g39IJIy9Jr0PxkZ13FOs+A5Fq5NizkN/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljXSTZpEoKc9JOgkC+dDhnmIJboWYUxti2B6nUzAesLr9KAGf1ej1fcWfK2AAff07ziOZc7rLI9QnUYkLoPv3EGSUv/kvSt968PwTWYBvGm16tBLbN9KtCFTW9qq8gV1y1/mhg7ny8jNAF8qXCYuYf7GpRK3lpkxtAuz8bMQzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N0zBegiH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N0zBegiH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636JWwJ1762888;
	Fri, 3 Jul 2026 09:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o3Vsfx/BLTYWT8LjP
	UUSgBCHH0RDD7hktDGWZGoRP0I=; b=N0zBegiH4WeIZq+rlU0I+WA2Y8SDOSlJH
	oTdWYWderbzgg8jMGsX+3xoZkHr+nQGXv/2nG0decSZ42v52YHKkbBxtyhlK2mnL
	znSEZ2MCvkrpsQr8fztyNJL7u5d8KGuYXfERYKcteyL7yMCosatOcF5nWR7PXOjU
	HN5PY1CLDJrUXASDLutTBQMyMYy+C/ET1cPliMX4i+PUFX53lVT1EEJ5gLXX8D17
	35Sr9D8jJRe7l9SLl7g8ceGqjOkA0BDFzoedy/l1445vQeJSE18vVGHMZYI5CSNW
	Q7nMD8UQSD9pZpZOoG/7z+KWlFrTDfo4h1r/tVKHWEsXqD37I9q0A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk5w18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6638niD4003434;
	Fri, 3 Jul 2026 09:00:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukg1j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66390DDw16187826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:00:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44BB52004B;
	Fri,  3 Jul 2026 09:00:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41F6020043;
	Fri,  3 Jul 2026 09:00:06 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.212.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 09:00:05 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH v4 RESEND 1/8] tests/functional: Add remote interrupts test for PowerNV
Date: Fri,  3 Jul 2026 14:29:48 +0530
Message-ID: <20260703085955.2318600-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703085955.2318600-1-adityag@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfXy8xmorFcj+KY
 eC3S4XZ1goGHgqya2ikOxeRE8GLdT6Da+4CEF9eJN6IbTxSLu4VBaatzFgFMW2Zf+XGFa2O0r52
 vvOVW7zPE3bdFx0MzYaVNMnX/S7fzLuRYpgOkL56E5V4ZMEg5lnXthVil6ezm1KpIVbsbcfWDuV
 Lf2MFzqDuFWiI69AQjTnAtDnYqtN9prUNtpeYCp+uFX/iStVCexWRv30UmCTijEjoeDZUxGo4zE
 vvGD4fEDE0zVLSyjU0ozD1MqmPmrNztBPbb5vg6ayj1k0Pb0oUCrXezmDB9JTBIrie+9X9ABXMw
 CwGfD7BkGTjAiejUGqb5ScFKYYqrkK3F0z/YuolHfmgKo51TnaIwZqLaWbpfgBHCncwESMfI5xj
 lCSfskMiTx4CCPuEO/5GZVDhHHCYjzMWHORRwrScOPi0JKndyAu1PE6ExO9s3FiETm+gQT9aMhm
 D1O/2lpq7ZfdKrD95Fw==
X-Proofpoint-GUID: 04TbfEA1QCfZE-oGjIxSfHFmx3mmTHkY
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a477a23 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=7FOmGxExo5DkOBRayjgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX0vIEt7emrjJh
 SdEvItUVp3VbFayoTNxE+uBwpzcru5/gDYSZl32xWvi+vbT5NqFj71+iV8q8neR++wtdPmGTSxB
 Lm6wNlg0BB7mOeMcMNVYmAYRoiECNCo=
X-Proofpoint-ORIG-GUID: H47soin9a5vmR1d_iH8B6YCInvNJMBna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030083

In the past there have been hard to recreate issues where XIVE changes
cause qemu crashes due to multi-socket interrupts such as in [1].

Add a functional test explicitly to test whether remote interrupts work.

The test can also work as additional boot test for multi-socket boot,
initrd boot test, as well as a check for e1000e to be working in powernv,
though that's not a target goal, and are additional benefits.

From docs/system/devices/net.rst:

  In order to check that the user mode network is working, you can ping
  the address 10.0.2.2 and verify that you got an address in the range
  10.0.2.x from the QEMU virtual DHCP server.

Hence use 10.0.2.2 with ping.

[1]: https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/

Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 95 ++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index b5b2f0d15857..bac2017e18df 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -9,6 +9,7 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 
 class PowernvMachine(LinuxKernelTest):
 
@@ -32,6 +33,17 @@ class PowernvMachine(LinuxKernelTest):
         ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/qemu-powernv11.dtb'),
         'ea1271516264eea1eb58a067a99d0c2ca9528be8dc7d4e46bb2d5ae0d42fc568')
 
+    def shell_exec_command_check_fail(self, command):
+        fail_msg="Fail"
+        self.shell_exec_command(f"export __FAIL_MSG={fail_msg}")
+
+        # If the exit code for the command is non 0, print fail message
+        command = command + " || echo $__FAIL_MSG"
+        exec_command_and_wait_for_pattern(self, command, '#', fail_msg)
+
+    def shell_exec_command(self, command):
+        exec_command_and_wait_for_pattern(self, command, '#', self.panic_message)
+
     def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
         kernel_path = self.ASSET_KERNEL.fetch()
@@ -76,6 +88,89 @@ def test_linux_smt_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_linux_remote_interrupts(self):
+        self.require_accelerator("tcg")
+        self.set_machine('powernv')
+
+        # Have below setup in this test:
+        # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd
+        #    socket (chip 1), in a powernv boot with default 6 PHBs per socket
+        # 2. CPU on 2nd socket (chip 1) disabled
+        # 3. RX IRQ's affinity to chip 2, and TX IRQ's affinity to chip 3
+        #
+        # Then ping is done, to generate interrupts from e1000e which should go
+        # to IRQ server on the remote sockets
+        self.vm.add_args('-smp', '4,sockets=4,cores=1,threads=1')
+        self.vm.add_args('-netdev', 'user,id=net0')
+        self.vm.add_args('-device', 'e1000e,netdev=net0,bus=pcie.6')
+
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_INITRD.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+            '-drive',
+            f'file={rootfs_path},format=raw,if=none,id=drive0,readonly=on',
+            '-append', 'root=/dev/nvme0n1 console=hvc0',
+            '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234')
+        self.vm.launch()
+
+        # Wait for boot to complete
+        console_pattern = 'CPU maps initialized for 1 thread per core'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        console_pattern = 'smp: Brought up 4 nodes, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, 'Run /sbin/init as init process',
+                                 self.panic_message)
+
+        # Wait for login prompt and login as root (no password in buildroot)
+        wait_for_console_pattern(self, 'login:', self.panic_message)
+        exec_command_and_wait_for_pattern(self, 'root', '#', self.panic_message)
+
+        # e1000e is connected to socket 1, disable the CPU on socket 1
+        self.shell_exec_command("echo 0 > /sys/devices/system/cpu/cpu1/online")
+        self.shell_exec_command(
+            "export CPU1_STATE=$(cat /sys/devices/system/cpu/cpu1/online)")
+        self.shell_exec_command_check_fail("[ $CPU1_STATE -eq 0 ]")
+
+        # RX, TX interrupts to chip/cpu 2 & 3 respectively
+        self.shell_exec_command(
+            "export RX_IRQ=$(awk '/eth0-rx/ {print $1}' /proc/interrupts | tr -d ':')")
+        self.shell_exec_command(
+            "export TX_IRQ=$(awk '/eth0-tx/ {print $1}' /proc/interrupts | tr -d ':')")
+        self.shell_exec_command("echo 2 > /proc/irq/$RX_IRQ/smp_affinity_list")
+        self.shell_exec_command("echo 3 > /proc/irq/$TX_IRQ/smp_affinity_list")
+
+        # Capture interrupt counts before generating traffic
+        self.shell_exec_command(
+            "export RX_BEFORE=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
+        self.shell_exec_command(
+            "export TX_BEFORE=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
+
+        # Wait up to 15 seconds for eth0 link to come up
+        self.shell_exec_command(
+            "c=0; while ! ip addr show eth0 | grep 'inet 10.0.2'; do "
+            "sleep 1; c=$((c+1)); [ $c -gt 15 ] && break; done")
+
+        self.shell_exec_command_check_fail(
+            "ip addr show eth0 | grep 'inet 10.0.2'")
+
+        # Generate network traffic to trigger remote interrupts
+        # Ping QEMU's user-mode network gateway (10.0.2.2)
+        self.shell_exec_command("ping -W2 -c5 10.0.2.2")
+
+        # Show final interrupt counts to verify remote interrupts occurred
+        self.shell_exec_command("cat /proc/interrupts | grep eth0")
+
+        # Verify interrupt counts increased (whether interrupts were delivered)
+        self.shell_exec_command(
+            "export RX_AFTER=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
+        self.shell_exec_command(
+            "export TX_AFTER=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
+
+        # Check that interrupt counts increased
+        self.shell_exec_command_check_fail("[ $RX_AFTER -gt $RX_BEFORE ]")
+        self.shell_exec_command_check_fail("[ $TX_AFTER -gt $TX_BEFORE ]")
+
     def test_linux_big_boot(self):
         self.set_machine('powernv')
         self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
-- 
2.55.0

