Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA02773DE
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853482; cv=none; b=Vh3Vf9H+X0U3ger0xYuPSsY1vhHuCJ442wWBQ0GF5imbzNHHakrTkMZ3DLCwRYaoDlKI61mjPcNj0EddcYs8yZSNT4xGUHzgw8YDbt700dqpShfovo+fx8Hzi/sl6604qi1aqIs2nDihCQCW463Hw9rBsXSoATlvBZX6tMvDaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853482; c=relaxed/simple;
	bh=O7qUis4Nok9G13G0uCenmn6YWOwaNmrC9zQduJz7TXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZQ9txuWKAtU/os53q6gJD/QyTpLbzDm1LFzpAVSp8MdxiGt/FxrBcfgV3i37yjTjMJME30ttf9TKMWKAGClCGqtTBArKF9d0mDm7arcIhr3wzEQPxeTbO6DGkGOkQXk92tXuI5fzi1/Tzejudk4MC1hQxMs/Q2UywxpTZlxfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ii2rgv9m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ii2rgv9m"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJILn12838802;
	Tue, 30 Jun 2026 21:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7Rb9n8umCHcpWAM+X
	WZq3ezgFPWAa/MTToK+fMpCPKc=; b=Ii2rgv9mOxQlAzT7CIbrADOvvaWIP9udd
	Z6Ync2CT6GHaMLfHuVpXF25GEfhC0YFqKoqeiqXWsUijXwp+Tz0GtqAVpvrPpmuh
	mwVlkfWrcKyGbatgjmhh633bpK3yTjx8Q2PPZuxf9L0vRPOKEo/t5V5BPEgsX1fa
	zG7g6++khqEv235Vl9/JIKafKb+FkToBt2oDam73Hq5b6W1ncGSptTs/BW8npSxE
	7qsXXQdPgj2+l/3Bm8Om+BkMn/mrjU0Gi8yJ8Ln2EXwOKJsYjrLi9E8pu5FhVysO
	j3ZoMRPGWHTmNTFPCaOIDzql0qaQRKzuIf07ZAB6Z+gDvwr1Iv1kA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa0uua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UKnfkQ009296;
	Tue, 30 Jun 2026 21:04:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w4bkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UL4G6H50790874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 21:04:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4A6620040;
	Tue, 30 Jun 2026 21:04:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A00120043;
	Tue, 30 Jun 2026 21:04:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.22.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 21:04:08 +0000 (GMT)
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
Subject: [PATCH v4 1/8] tests/functional: Add remote interrupts test for PowerNV
Date: Wed,  1 Jul 2026 02:33:48 +0530
Message-ID: <20260630210355.789109-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630210355.789109-1-adityag@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX0vdT9e0/yRRW
 X9j8Plb6UszPZlJVzZi0DaY96C4UYTmjN6Pm+Va0EyAD2V9jifZBN/vyqZQOF8HI3p12sNcnMtW
 UT8km7trX99tpALTj1FtwGybX8YEuzOkG5U0V7L9li5T67IYiQA6V63EstIn/NJcETT3zQOUyil
 VVAASG70PZ1KeKZmG1MHb9qPOoMGmLn1OFYtCLsVp1j3E/29EH/3rBHWVK9q01vBRczeGtNsAgy
 3JZ+GwgiVIj7RMMZfJUoJHh+rbEcrecSbP4r7Cq8XUSWg5rEggTT3RbWOIql7gjOqx87P+NerjT
 aBMX/DI3JDrIO4t5OrpVh2v16FZiT4ZGQVyv/FAIyHxpn4LVytI0euXRAvfkLhQzqbPwL4cjIbS
 UGa4cH8EUhr69wfRJ7zTnaRSMXqSu4Np7M1EtHs0812vRelfya5i8gY2g7Fg6I6UPE8tQnGhcmM
 5Pc6Yv9sNYpv37B166A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX7kngAERjyNvH
 227KpLfFS1Af5w5EK87dFc3kAqHDjOgZp2plMAFYwY7JlCheuIuz1hig0cIx0YihofydLoH+ZVJ
 ld7/eROLV1huaPrZwgEmuSLg9ckNcK8=
X-Proofpoint-GUID: zWIod4ZmaqjusO8wXqdsDms9Qm7HRugL
X-Proofpoint-ORIG-GUID: Xvp_PEe-1a9kgf4neTuF3kd4bEKqFQtg
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a442f56 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=7FOmGxExo5DkOBRayjgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300202

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
index 0ea6c93e4287..c95925c0975a 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -9,6 +9,7 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 
 class PowernvMachine(LinuxKernelTest):
 
@@ -27,6 +28,17 @@ class PowernvMachine(LinuxKernelTest):
          'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
         'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
 
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
@@ -71,6 +83,89 @@ def test_linux_smt_boot(self):
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
2.54.0

