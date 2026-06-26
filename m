Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529DC389E13
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452364; cv=none; b=ADytRLgZX9tZP84OerafU1TCgUy7yvKbGXn/rFxVVpDG9/Ai1IuYj3qEE+qKxlZwOBeEJxdSct2+9BROu2z/238Vemzv89ASuSEi6ooWVms5iIwssLy2hrlb7yNe2jqHdrCO1zpNyQO6VMok4C7cnL8bzAG0nLv/Jr+EhXswe+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452364; c=relaxed/simple;
	bh=C4tY2kb2NmFwl+KNWH/jKyAgBvBWieM/pAz9BVHeAw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNGc38fKVPj9BH8JxMSgu9pVV457DS4dlM9kQqnMuKTnDCvx5HprRsZliaKeoY7/j0KiZeqetOkBeQWBjQ+9z1n/JgBhoMCMWcG6IpRJIkvz5aXu/Q9TgXkJRZxXZB9uEIeaRC8knpxfEhaFnOaI+HZdidc0aLvT4ohURU+A0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qftX2/iI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qftX2/iI"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2me261794480;
	Fri, 26 Jun 2026 05:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KCdgC0
	HcmqD/5uth1lUeqwdkiL0tQL+uVIdhAqozD5Y=; b=qftX2/iIydTwvzDpk8bWqK
	lOSeFqpzby0AjzOFbpyBrUlDPkjUqb6R3Ne5+c/sDr4ZD+TnoXET4HB/JhVzZSY6
	nxRPUPplLAz6wocRQQScTrzTtw12EYWZLRX/k9pCWrOaoa5YNHgzys7Hkq6h3Aqf
	ZQVwVNuyFLP1AK6cSf7P+Xe5XXyRgY5VRBn3Hei9YgStm6d40SSvMASig2WFe1t8
	CDbiM3mw2UZOCXWMZmKNbCHPFWKQxWwMVljh9Iob5y7bgqd34KuvpPDKlEmWY4Ty
	yRrAu8AZl3UvwZrAdhRyS+/W++KMXo8yMdzZ9tLlm3fAfN9ohOCVIOdMpLusXPFg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4wer5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 05:39:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q5YwMb022844;
	Fri, 26 Jun 2026 05:39:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phsk3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 05:39:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65Q5cwuj48562444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 05:38:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7064E20049;
	Fri, 26 Jun 2026 05:38:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 019DF20040;
	Fri, 26 Jun 2026 05:38:54 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 05:38:53 +0000 (GMT)
Message-ID: <e681d0b31ad42dba8595f09e0936c476fdc09d7b.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/8] tests/functional: Add remote interrupts test for
 PowerNV
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater
	 <clg@redhat.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	 <philmd@oss.qualcomm.com>,
        "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?=
	 <berrange@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini	
 <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn	
 <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier	
 <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree
 Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani
 <gautam@linux.ibm.com>,
        Chinmay Rath	 <rathc@linux.ibm.com>
Date: Fri, 26 Jun 2026 11:08:53 +0530
In-Reply-To: <20260624195924.1422821-2-adityag@linux.ibm.com>
References: <20260624195924.1422821-1-adityag@linux.ibm.com>
	 <20260624195924.1422821-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX2NjbbrGbePwe
 /xUuQ9gZpPzWkPnHDx+09ui6joVfnziKgX8YIZTeOQLsMa7ZAjYBi9Eb4ZlvZ/v3E0EESNoF4uR
 B3vG48cLK7evG7OFNagn1awJTd6T96o=
X-Proofpoint-ORIG-GUID: LpjclnvK5vbGFgNzdG14iRChfT7vBrRF
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3e1078 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=c2MNTF9r4_0dSDPVjxAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfXy16fnzMNDEqp
 A5SXs+Ou+aq41hXGAZUN0zOVIOAtKySekCQIcXvJFUIbNc46/+dQ2adWa+zr+t98rH/8F2WloMc
 +cTiKm42BCKQ8lMXF786/DjTpOYLjVRWT/JD8LjSE3FW1Zi5i5FsQj2c8T7BNo4cyXzUKlnfWrn
 Tz0R9Pjh+qLc7Jjm9GHj8RiteKa2BGrr/99Qd9UQ28RhrTwgAIhYsIsZgoE33M/v2kcnnscvQvb
 l9ilAA3S62DHb69z7yPRo3QS+1DI0Y2QF/iUY5d27QnQ9zfIchwf3Ygk34oihH62kMk/3H3A1CG
 EPw/haHIkvXs9KOi78d/DXxw/FmkXU/fKSY8zC8GWkpzYFjUNrUoJL0TwWc5PP3dSXALf/f/UT9
 uYwI3H24f62G+E500+I8xVgReXgAUDLMW2trYdH4dNzX3Iq0PS138WmMc/OvGvj6X9YWWu677EA
 OTCSkGOyQ+ELDuvagKQ==
X-Proofpoint-GUID: 5qlqY1xz4Jmo0oiSh0FerjQbuH7BwSaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260040

On Thu, 2026-06-25 at 01:29 +0530, Aditya Gupta wrote:
> In the past there have been hard to recreate issues where XIVE
> changes
> cause qemu crashes due to multi-socket interrupts such as in [1].
>=20
> Add a functional test explicitly to test whether remote interrupts
> work.
>=20
> The test can also work as additional boot test for multi-socket boot,
> initrd boot test, as well as a check for e1000e to be working in
> powernv,
> though that's not a target goal, and are additional benefits.
>=20
> From docs/system/devices/net.rst:
>=20
> =C2=A0 In order to check that the user mode network is working, you can
> ping
> =C2=A0 the address 10.0.2.2 and verify that you got an address in the
> range
> =C2=A0 10.0.2.x from the QEMU virtual DHCP server.
>=20
> Hence use 10.0.2.2 with ping.
>=20
> [1]:
> https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@r=
edhat.com/
>=20
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
> =C2=A0tests/functional/ppc64/test_powernv.py | 95
> ++++++++++++++++++++++++++
> =C2=A01 file changed, 95 insertions(+)
>=20
> diff --git a/tests/functional/ppc64/test_powernv.py
> b/tests/functional/ppc64/test_powernv.py
> index 0ea6c93e4287..9760f58ee41e 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -9,6 +9,7 @@
> =C2=A0
> =C2=A0from qemu_test import LinuxKernelTest, Asset
> =C2=A0from qemu_test import wait_for_console_pattern
> +from qemu_test import exec_command_and_wait_for_pattern
> =C2=A0
> =C2=A0class PowernvMachine(LinuxKernelTest):
> =C2=A0
> @@ -27,6 +28,17 @@ class PowernvMachine(LinuxKernelTest):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'buildroot/qemu_pp=
c64le_powernv8-2025.02/rootfs.ext2'),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 def shell_exec_command_check_fail(self, command):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_msg=3D"Fail"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command(f"exp=
ort __FAIL_MSG=3D{fail_msg}")

nice idea.

> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If the exit code for the co=
mmand is non 0, print fail
> message
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 command =3D command + " || ec=
ho $__FAIL_MSG"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pat=
tern(self, command, '#',
> fail_msg)
> +
> +=C2=A0=C2=A0=C2=A0 def shell_exec_command(self, command):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pat=
tern(self, command, '#',
> self.panic_message)
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 def do_test_linux_boot(self, command_line =3D
> KERNEL_COMMON_COMMAND_LINE):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.require_accelerator=
("tcg")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D self.ASS=
ET_KERNEL.fetch()
> @@ -71,6 +83,89 @@ def test_linux_smt_boot(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_console_pattern=
(self, console_pattern,
> self.panic_message)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_console_pattern=
(self, self.good_message,
> self.panic_message)
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 def test_linux_remote_interrupts(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.require_accelerator("tcg=
")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.set_machine('powernv')
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Have below setup in this te=
st:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 1. e1000e attached to pcie.=
6, which is from 7th PHB,
> belonging to 2nd
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #=C2=A0=C2=A0=C2=A0 socket (c=
hip 1), in a powernv boot with default 6 PHBs
> per socket
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 2. CPU on 2nd socket (chip =
1) disabled
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 3. RX IRQ's affinity to chi=
p 2, and TX IRQ's affinity to
> chip 3
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Then ping is done, to gener=
ate interrupts from e1000e
> which should go
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # to IRQ server on the remote=
 sockets
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-smp', '4,s=
ockets=3D4,threads=3D1')
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-netdev', '=
user,id=3Dnet0')
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-device', '=
e1000e,netdev=3Dnet0,bus=3Dpcie.6')
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D self.ASSET_KE=
RNEL.fetch()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootfs_path =3D self.ASSET_IN=
ITRD.fetch()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_console()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-kernel', k=
ernel_path,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '-dri=
ve',
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> f'file=3D{rootfs_path},format=3Draw,if=3Dnone,id=3Ddrive0,readonly=3Don',
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '-app=
end', 'root=3D/dev/nvme0n1 console=3Dhvc0',
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '-dev=
ice',
> 'nvme,drive=3Ddrive0,bus=3Dpcie.2,addr=3D0x0,serial=3D1234')
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Wait for boot to complete
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_pattern =3D 'CPU maps=
 initialized for 1 thread per
> core'
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_console_pattern(self=
, console_pattern,
> self.panic_message)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_pattern =3D 'smp: Bro=
ught up 4 nodes, 4 CPUs'
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_console_pattern(self=
, console_pattern,
> self.panic_message)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_console_pattern(self=
, 'Run /sbin/init as init
> process',
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.panic_message)
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Wait for login prompt and l=
ogin as root (no password in
> buildroot)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_console_pattern(self=
, 'login:', self.panic_message)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pat=
tern(self, 'root', '#',
> self.panic_message)
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # e1000e is connected to sock=
et 1, disable the CPU on socket
> 1
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command("echo=
 0 >
> /sys/devices/system/cpu/cpu1/online")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "expo=
rt CPU1_STATE=3D$(cat
> /sys/devices/system/cpu/cpu1/online)")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command_check=
_fail("[ $CPU1_STATE -eq 0 ]")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RX, TX interrupts to chip/c=
pu 2 & 3 respectively
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "expo=
rt RX_IRQ=3D$(awk '/eth0-rx/ {print $1}'
> /proc/interrupts | tr -d ':')")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "expo=
rt TX_IRQ=3D$(awk '/eth0-tx/ {print $1}'
> /proc/interrupts | tr -d ':')")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command("echo=
 2 >
> /proc/irq/$RX_IRQ/smp_affinity_list")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command("echo=
 3 >
> /proc/irq/$TX_IRQ/smp_affinity_list")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Capture interrupt counts be=
fore generating traffic
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "expo=
rt RX_BEFORE=3D$(awk '/eth0-rx/ {print $3}'
> /proc/interrupts)")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "expo=
rt TX_BEFORE=3D$(awk '/eth0-tx/ {print $4}'
> /proc/interrupts)")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Wait up to 15 seconds for e=
th0 link to come up
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "c=3D=
0; while ! ip addr show eth0 | grep 'inet 10.0.2'; do
> "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "slee=
p 1; c=3D$((c+1)); [ $c -gt 15 ] && break; done")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command_check=
_fail(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ip a=
ddr show eth0 | grep 'inet 10.0.2'")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Generate network traffic to=
 trigger remote interrupts
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Ping QEMU's user-mode netwo=
rk gateway (10.0.2.2)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command("ping=
 -W2 -c5 10.0.2.2")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Show final interrupt counts=
 to verify remote interrupts
> occurred
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command("cat =
/proc/interrupts | grep eth0")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Verify interrupt counts inc=
reased (whether interrupts were
> delivered)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "expo=
rt RX_AFTER=3D$(awk '/eth0-rx/ {print $3}'
> /proc/interrupts)")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "expo=
rt TX_AFTER=3D$(awk '/eth0-tx/ {print $4}'
> /proc/interrupts)")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check that interrupt counts=
 increased
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command_check=
_fail("[ $RX_AFTER -gt
> $RX_BEFORE ]")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.shell_exec_command_check=
_fail("[ $TX_AFTER -gt
> $TX_BEFORE ]")
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 def test_linux_big_boot(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.set_machine('powern=
v')
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-smp',=
 '16,threads=3D4,cores=3D2,sockets=3D2')

Here's some of the log

2026-06-25 21:21:41,820: --- 10.0.2.2 ping statistics ---
2026-06-25 21:21:41,820: 5 packets transmitted, 5 packets received, 0%
packet loss
2026-06-25 21:21:41,820: round-trip min/avg/max =3D 0.547/2.077/7.575 ms
2026-06-25 21:21:41,823: #
2026-06-25 21:21:41,826: cat /proc/interrupts | grep eth0
2026-06-25 21:21:41,874: 131:          0         26          0  PNV-
PCI-MSI 2416443392 Edge      eth0-rx-0
2026-06-25 21:21:41,875: 132:          0          0         18  PNV-
PCI-MSI 2416443393 Edge      eth0-tx-0
2026-06-25 21:21:41,875: 133:          0          0          0  PNV-
PCI-MSI 2416443394 Edge      eth0
2026-06-25 21:21:41,877: #
2026-06-25 21:21:41,881: export RX_AFTER=3D$(awk '/eth0-rx/ {print $3}'
/proc/interrupts)
2026-06-25 21:21:41,920: #
2026-06-25 21:21:41,926: export TX_AFTER=3D$(awk '/eth0-tx/ {print $4}'
/proc/interrupts)
2026-06-25 21:21:41,969: #
2026-06-25 21:21:41,971: export __FAIL_MSG=3DFail
2026-06-25 21:21:41,971: #
2026-06-25 21:21:41,974: [ $RX_AFTER -gt $RX_BEFORE ] || echo
$__FAIL_MSG
2026-06-25 21:21:41,974: #
2026-06-25 21:21:41,976: export __FAIL_MSG=3DFail
2026-06-25 21:21:41,976: #

Maybe we can design this __FAIL_MSG, that doesn't need to interfere
with stdout directly. But This is alright currently.


Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>

Regards
~Shivang.
