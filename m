Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7593845D0
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224439; cv=none; b=t9Odq5/gFpwEY7wzZJNBPKK9eiR6/4eLjhTDXavak+SrsQPpEalSvmQRWCJEPBscq4XYOlYpINx8urvLWaN7sC+d1vqnP2WelTtAFPoMlfamUgiyHfn0ATtiKlZEoXCJardSWirs+xsieYO7goetkdqiXYWaKbTT4UUXH49MnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224439; c=relaxed/simple;
	bh=e9NVoHZx2snqnehKXBVedxuoAftcTSW4GkWnWe2+ddA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osrQnTbhEuxIvbmNd/NCGf1juDM8ijoIPDKm40QEChFfD3umrQmLymPQfpm0UElGwv/K/NQjdYPlL917VAeVQwoazkY1ANjNMUIlOmo53sCfCaMgZWC+mSwIRMO64AgQYToi7fwYPyeN3rtsbU/AykYeJ8lrn6lzGD8qBdokET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=REeXqw+7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="REeXqw+7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmEEH2135665;
	Tue, 23 Jun 2026 14:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lnInS4xNwokhispFI
	Xp70mgLncEQN+v27xf/v2estt0=; b=REeXqw+7G9R6k9I4A+fs+pZBGLMEDpado
	6SQ8ZfFrjPiL6wyHpBGG3bBcX5b3tSLNMPz4xUGicYhhCA4Ouln9m0LifXc39RKU
	oMKuZ1xDz40MevHHf6uHs3m7+3aYdiH8JMIm5yPqDsgAJBxqmjDZWCIWjpoQwVPT
	lWWzrRTNCFrb07Y0h3nQoNgmGZZLoUyZjjhpHoQ3WmuoRe4XTZUc+K7YJRucBVPU
	bXZv04oODnQQhWpPP2B2W24IZbGMktchCQSjJZYSv/UtK/hmR9m5hnlQF724o1FY
	i5GIlv3YF6p/LO4WZWV/oOr4AD4vBkbh4ARpCDjymU4bVmQNvwsYg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqpxbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:20:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJc29005016;
	Tue, 23 Jun 2026 14:20:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykbcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:20:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEKJQ430343926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:20:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39C8C2004B;
	Tue, 23 Jun 2026 14:20:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF0FF20043;
	Tue, 23 Jun 2026 14:20:09 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:20:09 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 1/8] tests/functional: Add remote interrupts test for PowerNV
Date: Tue, 23 Jun 2026 19:49:26 +0530
Message-ID: <20260623141933.577981-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141933.577981-1-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3a9628 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=7FOmGxExo5DkOBRayjgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX8w4HVLcdUZAz
 RlJKZTEmOfQzVSAcqc6Q81IUTt4gVsf8jP1qs1tjs+O+VZAJNmv0VxHP07DizR76S/o56uqTgpP
 pNbGwBMv1+v/IFr54Cy8a3dQjEvAZ11vRH7GWUs098PyGjGyAnOzK7ZVw30GESmDocRWymrEzwj
 WuyEGtqJsZyndKxsLHQe3Iz/MOxXz645iEuDqVYzYAmYFt155snjQ2koO1jyHnEFkkgRy7W2NoV
 EGjajQyLxETSGvKXVF7jo9J8116PYcnKK2XxzVU5kZShxR2Q6gk4uY9kDAdmHqNV2J5xrq6U7wX
 SAdH+V+IoDu7D9dphW8MDkTvq1yThkcSIVL5DAMkbbwHFv23bolPSZiyaQCh8HSCRzVXeuatAvz
 fGQSGh7Sja10qWt1BEqewFuLiqa/ZRIuP+S0HPxF7EaDFo1wWRtqCAaAz2+9+Se7fLMWV4V0HQ3
 FHKVF0iDNxju06vC8PQ==
X-Proofpoint-GUID: caHrLgjB1fv9nDODXFXsJ-7-Y4Ork7fv
X-Proofpoint-ORIG-GUID: UzFqbExD0EsGg-0Aut3-VXrHCKdADFpK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX1eF9hHhuUznO
 21hFAka/bIpqM4q0FTgH3Kbcn9+6OZkj/q0MzeMjc/8jhk1Q0HSZYIUtxlUCXAKs0DRzOtL0/Bk
 n2uV/y5oRUP1NkAIuNTpTinOXcslZx8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230117

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

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 86 ++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index 0ea6c93e4287..17d2447815f9 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -9,6 +9,7 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 
 class PowernvMachine(LinuxKernelTest):
 
@@ -27,6 +28,9 @@ class PowernvMachine(LinuxKernelTest):
          'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
         'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
 
+    def helper_exec_shell_command(self, command):
+        exec_command_and_wait_for_pattern(self, command, '#', self.panic_message)
+
     def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
         kernel_path = self.ASSET_KERNEL.fetch()
@@ -71,6 +75,88 @@ def test_linux_smt_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_linux_remote_interrupts(self):
+        self.require_accelerator("tcg")
+        self.set_machine('powernv')
+
+        # have more sockets with as few CPUs as possible, increasing the
+        # probability to have remote interrupts from one chip to another
+        # also have e1000e network device to generate interrupts
+        self.vm.add_args('-smp', '4,sockets=4,threads=1')
+        self.vm.add_args('-device', 'e1000e,netdev=net0')
+        self.vm.add_args('-netdev', 'user,id=net0')
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
+        # RX, TX interrupts to chip/cpu 1 & 2 respectively
+        self.helper_exec_shell_command(
+            "export RX_IRQ=$(awk '/eth0-rx/ {print $1}' /proc/interrupts | tr -d ':')")
+        self.helper_exec_shell_command(
+            "export TX_IRQ=$(awk '/eth0-tx/ {print $1}' /proc/interrupts | tr -d ':')")
+        self.helper_exec_shell_command("echo 1 > /proc/irq/$RX_IRQ/smp_affinity_list")
+        self.helper_exec_shell_command("echo 2 > /proc/irq/$TX_IRQ/smp_affinity_list")
+
+        # Capture interrupt counts before generating traffic
+        self.helper_exec_shell_command(
+            "export RX_BEFORE=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
+        self.helper_exec_shell_command(
+            "export TX_BEFORE=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
+
+        # Wait up to 15 seconds for eth0 link to come up
+        self.helper_exec_shell_command(
+            "c=0; while ! ip addr show eth0 | grep 'inet 10.0.2'; do "
+            "sleep 1; c=$((c+1)); [ $c -gt 15 ] && break; done")
+
+        fail_msg="Fail"
+        self.helper_exec_shell_command(f"export FAIL={fail_msg}")
+        exec_command_and_wait_for_pattern(self,
+            "ip addr show eth0 | grep 'inet 10.0.2' || echo $FAIL",
+            '#', fail_msg)
+
+        # Generate network traffic to trigger remote interrupts
+        # Ping QEMU's user-mode network gateway (10.0.2.2)
+        self.helper_exec_shell_command("ping -W2 -c5 10.0.2.2")
+
+        # Show final interrupt counts to verify remote interrupts occurred
+        self.helper_exec_shell_command("cat /proc/interrupts | grep eth0")
+
+        # Verify interrupt counts increased (whether interrupts were delivered)
+        self.helper_exec_shell_command(
+            "export RX_AFTER=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
+        self.helper_exec_shell_command(
+            "export TX_AFTER=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
+
+        # Check that interrupt counts increased
+        success_msg = "Interrupts increased"
+        self.helper_exec_shell_command(f"export PASS='{success_msg}'")
+
+        exec_command_and_wait_for_pattern(self,
+            "[ $RX_AFTER -gt $RX_BEFORE ] && echo $PASS || echo $FAIL",
+            success_msg, fail_msg)
+        exec_command_and_wait_for_pattern(self,
+            "[ $TX_AFTER -gt $TX_BEFORE ] && echo $PASS || echo $FAIL",
+            success_msg, fail_msg)
+
     def test_linux_big_boot(self):
         self.set_machine('powernv')
         self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
-- 
2.54.0

