Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9446AF38
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753931; cv=none; b=tQr/ZfDM9rrAZv6TWz16PpAehbUFwInNQgB1DHASxwOm38+VoL6LpPj0fBVQSiV/WyeNokNVdDuePfTDektivG+SkPvYDPkXFWp1RVkXLLzrekQ+2+Z01WNhH1SnxbNY9vax8zKyhixCFCFjt+0+ZxH1vAWrsIEDOuwiNJhsquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753931; c=relaxed/simple;
	bh=mhqmW1/G42kb0sKbY/Zr5v7nsga8gmScsCwneH77M/g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UsT4rxUfmEuQY7AvKBPx6fAbCrIkvvmHWCNS8dAkIQ2cVpCRJuuxhkpeqtz3Tf7qtU7GVU87cMyQ+xDkFVBWytbEhZZPCFz4pj3bLOqe7Y354U1XQBFC5IIMRBFIV2zoeJQWBTJ6WZ4/Rqnxuu6YynqkurMnpzhLjC2X8TKyuaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PjRRs1zR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PjRRs1zR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TGJnOe3904134;
	Mon, 29 Jun 2026 17:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3sgfdM
	b9aHAkPGmhuTEM8bCjDG00Y+GpCVlP3FjJ8II=; b=PjRRs1zRfWxmhY1QV2JEu2
	HcEQx1fueFoMdkyolq3I/o6iTsvXw3+W6cawOuVX62yrrNWQtSSFWrHEWXhE5SWF
	C4yUlx+LmRf9t8j8AdbNA5dVt0d3mFfKqd6XkTImwFHpnxgEuVYWXXf6FxVO6+v8
	fRSYTi/QgTfSicaSCarMCEdZ754tYirRW3fYVQyNEWs1yByA2hO8C1Nn+zrW/yee
	CRdsHeZNkzjxjxq6QZxVz2WKZKrA/QWDl3qdjR4QUG8N1PFIlvCn9v39+SYP2Vw2
	J7+79xZd6JryUKsNdHdGKocoELbW3aRAV4SL+ZINGUnf1BVxJVI0gCgbtOTbMjZQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qftqb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 17:25:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65THJgK2023053;
	Mon, 29 Jun 2026 17:25:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7vxqs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 17:25:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65THP9pV6750842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 17:25:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E03425805D;
	Mon, 29 Jun 2026 17:25:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80C8B58052;
	Mon, 29 Jun 2026 17:25:08 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 17:25:08 +0000 (GMT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 22:55:08 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora
 <harshpb@linux.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang
 Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang?=
 =?UTF-8?Q?=C3=A9?= <berrange@redhat.com>,
        Sourabh Jain
 <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas
 Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano
 Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Anushree Mathur
 <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani
 <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH v2 0/8] Testcase improvements and Power8E/NVL removal
In-Reply-To: <20260624195924.1422821-1-adityag@linux.ibm.com>
References: <20260624195924.1422821-1-adityag@linux.ibm.com>
Message-ID: <24f5f50517e3c01012223b7c774d7094@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a42aa78 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=uOxguaagmlPXxrVSXkIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE0NSBTYWx0ZWRfXwUcCbi4CN2t/
 Caw8GGO0mRZ4w86jqEOVszTW3Es0GPxhcND8yDhstA+ZHBtvNqH0Qv0MZF4V3J9Qq6/pWyh35kP
 sVzXc6JA+pSvuhaU2fHwbOd0e+aaXTQ=
X-Proofpoint-GUID: ohg5Ws7yQ_D0WhDtrBOuXrQEJ7RznMrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE0NSBTYWx0ZWRfX+89fMKRDRgHP
 4oY8f+VE36ppsni2e1TQk48YOd3yqSeGkhpZx0Vc5x+h34flCx2F73zWwcCk+ot/tcRaTR+EleY
 npGJoH+YlWqP0zdrRU7EFyFrz8CFqpAZaJl3Vd/k8s98ZEfdW5W0izGZmMdJMmIRycGr0AhRcgX
 /srqYNJ+DM/Xzfq8iFze43Euclfq1A/QaNANY6uteijbQswIVzhL+LzTuSgjmdqk5fTKbdxLidr
 AURy0Hokgsa1COahoE8hil1BvOa72b0CgGi7P0RB73XwptcxYtTTLwHVs30jXy/CynQ3kPLmXd9
 RFjCKkP2KZfxFKexvDP1o6FPVybYGEoS5qwR0iozrcJ9fGLZoIpkGa0jRnMfZEg6xAw9voaDEMJ
 5FXtUGxqSXLUiFFgGFLysgeQX1TBQd7XHtEkdyTYoAP8j646uNK9XcRnCWTRayESyske4RGXCzz
 87CYkabD2OuPeLqpq9w==
X-Proofpoint-ORIG-GUID: tMjJM78y7r9H3iM5QiVcor-nklN4h-bu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290145

On 2026-06-25 01:29, Aditya Gupta via Devel wrote:
> Overview
> ========
> 
> This patch series merged two patch series sent earlier:
> 	"Testcase improvements for PowerNV"
> 	"Remove deprecated Power8E and 8NVL CPUs"
> since the Power8E removal series depended on the former due to pnv-spi 
> test
> 
> Broadly contains 3 changes:
> 1. Testcase improvements:
>     Add a testcase to detect regression in remote interrupts when XIVE 
> changes,
>     since such regression had occurred during Power11 XIVE changes:
> 
> https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/
> 
>     Also add Power11 chip and testcase in qtests, and fadump functional 
> test
> 
> 2. Power8E/Power8NVL removal
>     Power8E and Power8NVL were deprecated since QEMU 10.1, with
>     commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
>     Hence, remove usage (chip and core types) of Power8E and 8NVL from 
> PowerNV,
>     PSeries as well as testcases.
> 
> 3. Maintainer changes
>     Add myself as maintainer for PowerNV machine
> 
> Testing
> =======
> 
> * Git tree for testing:
> https://gitlab.com/adi-g15-ibm/qemu/tree/feat_maintainer-v2
> * Gitlab pipeline: 
> https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2627063408
> * Successful ppc64 functional tests, qtests, boot tests, builds at all 
> commits
> 
> Changelog
> =========
> v2:
> + #1: put e1000e on socket 1, and disable it's cpu, as suggested by 
> cedric
> + #1: pull out command fail checks into a helper, as suggested by 
> shivang
> + #2: use g_autofree, suggested by cedric
> + #3: use g_autofree in tests updated
> + #8: remove G:, as suggested by daniel
> + rebased to upstream
> 
> from previous split series:
> + #1: added checks to see if network is up and interrupts happened,
> based on shivang's review
> + #3: replaced common if-else-if check for machine type with
> pnv_get_machine_type
> + #7: added doc in removed-features, as suggested by cedric
> + #6,7: added rb from philippe
> + #8: new patch, maintainer change
> 
> Aditya Gupta (8):
>   tests/functional: Add remote interrupts test for PowerNV
>   tests/qtest/pnv_spi: Test Power11 PNV_SPI
>   tests/qtest: Add Power11 chip & machine to qtests
>   tests/functional: Use default powernv machine instead of power10
>   ppc/pnv: Replace Power8E with Power11 for 'none' machine test
>   ppc/pnv: Remove Power8E and Power8NVL pnv chips
>   ppc/pnv: Remove Power8E and Power8NVL CPUs
>   MAINTAINERS: Add self as maintainer for PowerNV
> 
>  MAINTAINERS                            |  2 +-
>  docs/about/deprecated.rst              |  9 ---
>  docs/about/removed-features.rst        |  8 +++
>  docs/system/ppc/powernv.rst            |  2 +-
>  docs/system/ppc/pseries.rst            |  2 +-
>  hw/ppc/pnv.c                           | 62 -----------------
>  hw/ppc/pnv_core.c                      |  2 -
>  hw/ppc/spapr_cpu_core.c                |  2 -
>  include/hw/ppc/pnv.h                   |  8 ---
>  target/ppc/cpu-models.c                |  6 --
>  target/ppc/cpu-models.h                |  4 --
>  target/ppc/cpu_init.c                  |  6 --
>  target/ppc/kvm.c                       |  4 +-
>  tests/functional/ppc64/test_fadump.py  |  2 +-
>  tests/functional/ppc64/test_powernv.py | 95 ++++++++++++++++++++++++++
>  tests/qtest/machine-none-test.c        |  2 +-
>  tests/qtest/pnv-host-i2c-test.c        | 10 ++-
>  tests/qtest/pnv-spi-seeprom-test.c     | 20 ++++--
>  tests/qtest/pnv-xive2-test.c           |  2 +-
>  tests/qtest/pnv-xscom-test.c           | 22 ++----
>  tests/qtest/pnv-xscom.h                | 42 ++++++++----
>  21 files changed, 163 insertions(+), 149 deletions(-)
> 
> 
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb

Hi Aditya,

I've tested the patch series on PowerNV and pSeries guests including the 
new remote interrupts functional test and Power8E/NVL removal.

Testing Environment:
- Host: Fedora 42 ppc64le
- Arch: ppc64le
- QEMU: emulator version 11.0.50 (v11.0.0-2400-g20553466cc-dirty)

PowerNV Guest Bringup
Status: Success
qemu-system-ppc64 -name test-vm -machine powernv -m 4096 -smp 4 
-nographic \
   -kernel 
~/.cache/qemu/download/6fd29aff9ad4362511ea5d0acbb510667c7031928e97d64ec15bbc5daf4b8151 
\
   -drive 
file=~/.cache/qemu/download/aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2,format=raw,if=none,id=drive0,readonly=on 
\
   -device nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234 \
   -append "root=/dev/nvme0n1 console=tty0 console=hvc0"

PSeries Guest Bringup
Status: Success
qemu-system-ppc64 -name test-vm -machine pseries,accel=kvm -m 4096 \
   -smp 8,sockets=1,cores=8,threads=1 -nographic -serial mon:stdio \
   -drive 
file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=virtio,format=qcow2 
\
   -netdev bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0

Power8E/NVL Removal Verification
Status: Success (both correctly rejected after removal)
   qemu-system-ppc64: unable to find CPU model 'power8e_v2.1'
   qemu-system-ppc64: unable to find CPU model 'power8nvl_v1.0'

QEMU Functional Test Results (make check-functional-ppc64)
Status: Success
Ok:                 12
Fail:               0
Skipped:            4

QEMU Unit Test Results (make check-qtest-ppc64)
Status: Success
Ok:                 33
Fail:               0
Skipped:            0

Result: All tests passed successfully.

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>

Thanks,
Misbah Anjum N
