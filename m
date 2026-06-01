Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A934387369
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300556; cv=none; b=PlTC9rZ03vcSpWV8I5FSPUEcakxBxQsgE2QVH7RoPw0HG0dmSzKXec9U9dHUWvlg2QqNUyl+K5tldLHYxn7/uphslGIp4bT4AjrqtNKnHyEcCLtwehZIyYodAawJe1rasIfR8wAIXJOgZ8hH+Sb3LsYMQgXXeQJx/cjZMpme5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300556; c=relaxed/simple;
	bh=+L+lLI7lffuFJH84m3musCjNh3ZJ3M6l9YRyx4AuObQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odokZFhTHUtz58DWwPdoNn6PYNQPFiHosgaJ5tZVJB7MGgyKJSN/Dhh4Zy2BlslNi8xlbViotttZpLM50G2DoiiT6gOhkvf9HBXsRPIaPSKdcAy7KOTx94D5SalvtiRUKK/u5htzTHlLUeS81nCfahMH3SpW7T470IEIhP7wn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KXcraysT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KXcraysT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6516loQJ2548014;
	Mon, 1 Jun 2026 07:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tIihLj
	K/P9jxa16OO6bZuxhmsUAoFPmQnYeT0+yGMCI=; b=KXcraysT2BoEalv1QZmtbN
	QL0I6nVgQLZF4DMC2gqZqUmDbtSH6Hine9dR84tT88i5Pb4JC+ysQsCZlSyKiyHi
	99mbV8lkfLVDaTHQhRwrLTRBdEMxQe4VneUXQXd0teNRmtGLF8uxKwk3fVIvRGL5
	5wDnCs2zq7MbXlQCXxFzErJ7sMAbp4c+YS3bljVPOxPUTJxChXvJAxNbq2qV5vvj
	AWep4PXQFnE0Jz32fmrL9nwLxxUm+L/+m5eh3dQyf2BVuED/TRxYCIDQlcGmOxIF
	R+fK2B1T71piKsncpbnZ1vmGBMh5Cbl0lW40seO/VqB/LiM5+HT5XPT3xFcKfBsQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahfhj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:55:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6517sF0e015540;
	Mon, 1 Jun 2026 07:55:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegcuk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:55:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6517t2i61573868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 07:55:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7191958053;
	Mon,  1 Jun 2026 07:55:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 770C158043;
	Mon,  1 Jun 2026 07:54:52 +0000 (GMT)
Received: from [9.61.253.9] (unknown [9.61.253.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 07:54:52 +0000 (GMT)
Message-ID: <199da924-0621-4ffa-a9a0-126cfcccca4e@linux.ibm.com>
Date: Mon, 1 Jun 2026 13:24:50 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] accel: Remove need for AccelCPUClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
        qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>,
        Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
        Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
        kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
        Chinmay Rath <rathc@linux.ibm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA3NSBTYWx0ZWRfX+D55tEl1xiiA
 TFEcOFVpZa3buuD+BIpFsaArV0ycU5s+GpDasVB0e+EFDlpA63s/J+YoAKh4gDHJRtie0a0mUHO
 3nFuRY+snpjASa3G+FNt1XwEpCIPdPF0ZOFoPJtVfOPSG3Q3zCsC4zw/ALA4Xl9w0sM7hfS9XrU
 WnMWci/pAeVmBuMlB/CTVWMiqRzpyKkIcYl8R9ccdwycZffmSonFbaKL7g6WW9ja5wGLlaaBqXy
 p7H82LmzJrMcI7WIHtFZQfwL7C/pxUUV2drekUBN4IbQ72f28elQfTWj65Nnje0Jceod5S/GXwJ
 PB4JmtrSiVGkiAO2SM9aQNzuDfDyhlnRxGDj1hvWJygsM+Oyet9NiFflKGWu94/LwMYsBY2clWL
 BNH2aOronGeQTMf9Q82yCTNj8exSY5lkilyqO7v0VDYpPP1jonMQ4fNg9g2RlZUJzZhHwSGbbj8
 a7lK7OoXNoqPmCEalrw==
X-Proofpoint-ORIG-GUID: stbE1dKQO2CIs2klcuivsEzaTA0EBb87
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1d3ad9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=M1uAcgqxGuUR1RF059AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yqXAUGPoAcBrwED1JsmjUFs4wkBDWkZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010075



On 29/05/26 7:54 PM, Philippe Mathieu-Daudé wrote:
> Move cpu_init/realize hooks from AccelCPUClass to
> AccelOpsClass. Specialize them for TCG in TCGCPUOps.
>
> This drastically simplifies the need of per-binary QOM
> types per accelerator per target (see also the nice
> diff-stat).
>
> Based-on: tag single-binary-20260528
>
> Ignoring checkpatch.pl:
>
>    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>      accel/accel-target.c
>      include/accel/accel-cpu-target.h
>      include/accel/accel-cpu.h
>
> Philippe Mathieu-Daudé (17):
>    target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
>    accel: Remove AccelCPUClass::cpu_class_init()
>    accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()
>    accel/hvf: Remove need for AccelCPUClass::cpu_target_realize
>    accel/kvm: Remove need for AccelCPUClass::cpu_target_realize
>    accel: Introduce AccelOpsClass::cpu_instance_init handler
>    accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>    accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>    accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>    accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>    accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init
>    accel: Remove AccelCPUClass::cpu_instance_init()
>    accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize
>    accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize
>    accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize
>    accel: Remove AccelCPUClass::cpu_target_realize()
>    accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h'
>
>   accel/tcg/tcg-accel-ops.h         |  1 +
>   include/accel/accel-cpu-ops.h     |  3 +-
>   include/accel/accel-cpu-target.h  | 31 --------------
>   include/accel/accel-cpu.h         | 23 -----------
>   include/accel/tcg/cpu-ops.h       |  2 +
>   include/system/hvf_int.h          |  1 +
>   include/system/kvm.h              |  3 ++
>   target/i386/nvmm/nvmm-accel-ops.h |  2 +
>   accel/accel-common.c              | 68 ++++---------------------------
>   accel/hvf/hvf-accel-ops.c         |  3 +-
>   accel/kvm/kvm-accel-ops.c         |  2 +
>   accel/tcg/cpu-exec.c              | 15 ++++++-
>   accel/tcg/tcg-accel-ops.c         |  1 +
>   accel/whpx/whpx-accel-ops.c       |  2 +
>   accel/whpx/whpx-common.c          | 17 --------
>   target/arm/hvf/hvf.c              |  4 ++
>   target/arm/whpx/whpx-all.c        |  1 -
>   target/i386/hvf/hvf-cpu.c         | 25 ++----------
>   target/i386/hvf/hvf.c             |  5 ---
>   target/i386/kvm/kvm-cpu.c         | 25 +-----------
>   target/i386/nvmm/nvmm-accel-ops.c |  2 +
>   target/i386/nvmm/nvmm-all.c       | 19 +--------
>   target/i386/tcg/tcg-cpu.c         | 28 ++-----------
>   target/i386/whpx/whpx-all.c       |  1 -
>   target/loongarch/tcg/tcg_cpu.c    |  1 -
>   target/ppc/kvm.c                  | 23 +----------
>   target/riscv/kvm/kvm-cpu.c        | 33 +--------------
>   target/riscv/tcg/tcg-cpu.c        | 28 +++----------
>   28 files changed, 64 insertions(+), 305 deletions(-)
>   delete mode 100644 include/accel/accel-cpu-target.h
>   delete mode 100644 include/accel/accel-cpu.h
>

Hi Philippe,
I am seeing a compilation issue when I am building the qemu after 
applying this series of patch. I have tested this for arch PPC.

After applying the patch when I ran make command it failed with the 
below error:

[2418/2928] Compiling C object 
libqemu-ppc64-softmmu.a.p/hw_intc_xics_pnv.c.o
[2419/2928] Compiling C object 
libqemu-ppc64-softmmu.a.p/hw_ppc_spapr_drc.c.o
[2420/2928] Compiling C object 
libqemu-ppc64-softmmu.a.p/libdecnumber_dpd_decimal32.c.o
[2421/2928] Compiling C object 
libqemu-ppc64-softmmu.a.p/target_ppc_mmu_helper.c.o
[2422/2928] Compiling C object 
libqemu-ppc64-softmmu.a.p/accel_kvm_kvm-accel-ops.c.o
FAILED: [code=1] libqemu-ppc64-softmmu.a.p/accel_kvm_kvm-accel-ops.c.o
cc -m64 -mlittle-endian -Ilibqemu-ppc64-softmmu.a.p -I. -I.. 
-Itarget/ppc -I../target/ppc -Isubprojects/dtc/libfdt 
-I../subprojects/dtc/libfdt -Isubprojects/libvduse 
-I../subprojects/libvduse -Iqapi -Itrace -Iui -Iui/shader 
-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include 
-I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 
-fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g 
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE 
-fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero 
-fzero-init-padding-bits=all -fzero-call-used-regs=used-gpr 
-fstack-protector-strong -Wempty-body -Wendif-labels 
-Wexpansion-to-defined -Wformat-overflow=2 -Wformat-security 
-Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self 
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs 
-Wold-style-declaration -Wold-style-definition -Wredundant-decls 
-Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla 
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi 
-Wno-shift-negative-value -isystem /home/Anu/qemu/linux-headers -isystem 
linux-headers -iquote . -iquote /home/Anu/qemu -iquote 
/home/Anu/qemu/include -iquote /home/Anu/qemu/host/include/ppc64 -iquote 
/home/Anu/qemu/host/include/generic -iquote /home/Anu/qemu/tcg/ppc64 
-pthread -fPIE -isystem../linux-headers -isystemlinux-headers 
-DCOMPILING_PER_TARGET '-DCONFIG_TARGET="ppc64-softmmu-config-target.h"' 
'-DCONFIG_DEVICES="ppc64-softmmu-config-devices.h"' -MD -MQ 
libqemu-ppc64-softmmu.a.p/accel_kvm_kvm-accel-ops.c.o -MF 
libqemu-ppc64-softmmu.a.p/accel_kvm_kvm-accel-ops.c.o.d -o 
libqemu-ppc64-softmmu.a.p/accel_kvm_kvm-accel-ops.c.o -c 
../accel/kvm/kvm-accel-ops.c
../accel/kvm/kvm-accel-ops.c: In function ‘kvm_accel_ops_class_init’:
../accel/kvm/kvm-accel-ops.c:101:8: error: ‘AccelOpsClass’ has no member 
named ‘cpu_target_realize’
   101 |     ops->cpu_target_realize = kvm_arch_cpu_realize;
       |        ^~
[2423/2928] Compiling C object 
libqemu-ppc64-softmmu.a.p/hw_ppc_spapr_nested.c.o
[2424/2928] Compiling C object 
libqemu-ppc64-softmmu.a.p/hw_remote_memory.c.o
[2425/2928] Compiling C object 
libqemu-ppc64-softmmu.a.p/libdecnumber_decContext.c.o
[2426/2928] Compiling C object 
qga/qemu-ga.p/meson-generated_.._qga-qapi-emit-events.c.o
[2427/2928] Compiling C object libqemu-ppc64-softmmu.a.p/hw_intc_ppc-uic.c.o


Thank you,
Anushree Mathur
