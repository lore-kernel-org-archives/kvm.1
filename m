Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A903D3B3
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391864; cv=none; b=RSa94jezyCtyJnGgwMxpG/flieVN7ytnlCjcVYC0G4i7IwIGSv64bSfLeGB9md/rR9HRNeAoaLDbdSlWyKfJytkJTv1f1k2sqYz4DfiP+AkFMycFXUQWEUIxb5S5yYFeN52bMIJGoElwH64r9Pf8aguiOJ+P+l5pXok5jhr0138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391864; c=relaxed/simple;
	bh=tQevGbuEHeR19yGgjOxsXuG62aMIuZmznIit007E2d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcEb8F0PaVz65hPH5nBX06xLQeEqQs8SoC7K7kJdHtqu7IuwFpbkAPZRN+QasLp/nfIpKqseORbWRA+t9/3wsSODkmasxHrkZ7lx+MAKrX6raGtIMwCOrZipBqGb71NNfyE8Ah6ZuGJbQiQkH8duJDzpa+re3bBfOmhiMvdAoqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jAaWMQZJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jAaWMQZJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65250BTm2190646;
	Tue, 2 Jun 2026 09:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E91io9
	zCEgeZuKiWP7mNyL3V3qLGzAITrvNk9+eh3Pw=; b=jAaWMQZJpU/D6a/4926JdJ
	lb3/5orLWm0IMw/1E8HgrHqmN+A+WSMGU0SHrMNyarVkimCC2SElHeRV3Fn1FbzS
	c9+oEKC9miWBMjCwt7KFGQOblePipamKceLByYTE8Ft/DEV00nQYfeMzlohMoW5K
	Y3o4Z2nu3KsAx1DkOtMg58BPJnhgNXR6OQEnMA+OaeRMh1im/m1BWfSYYzIWPyvd
	vzS7S+rSmJUMqeWX1xlQN3ufu70MGtWvK+Pgnq8g8Ueykl2XayCBD8CxhrvZbAjv
	WvUSU/RDkypF06wpkSJESSKZ0vQ5tqhbY8u020doPzwdSL2J3mT2g6oQOW/rdyoA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae4sgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 09:17:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65299FRG028485;
	Tue, 2 Jun 2026 09:17:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qap70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 09:17:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6529H0uw11600628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 09:17:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2B0458052;
	Tue,  2 Jun 2026 09:17:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E75FC58056;
	Tue,  2 Jun 2026 09:16:48 +0000 (GMT)
Received: from [9.61.248.60] (unknown [9.61.248.60])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 09:16:48 +0000 (GMT)
Message-ID: <e15e4567-5c34-444d-af21-59a5e8c8415e@linux.ibm.com>
Date: Tue, 2 Jun 2026 14:46:47 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] accel: Remove need for AccelCPUClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
        kvm@vger.kernel.org, qemu-s390x@nongnu.org,
        Chao Liu <chao.liu.zevorn@gmail.com>,
        David Hildenbrand <david@kernel.org>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anton Johansson <anjo@rev.ng>,
        Claudio Fontana <cfontana@suse.de>, Eric Farman <farman@linux.ibm.com>,
        Alexander Graf <agraf@csgraf.de>, Chinmay Rath <rathc@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
        qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>,
        Reinoud Zandijk
 <reinoud@netbsd.org>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20260529194940.97143-1-philmd@linaro.org>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1e9f8f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=SOZPGa2L7nfW4cl26ZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eTynKQ6sXh_L99CJ4jkN-RTX8FmjwTnM
X-Proofpoint-ORIG-GUID: S9wyZdWo0YkJupn2gqXu3HJDveoDPPUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NSBTYWx0ZWRfX81AQsoduUD1F
 Yrd6Q0kSCXsmTA2BZ2RGBrFRpnDn2CKgTLVLlZ3q0E8Vd/1MPa6heQSODd7OjcC8dDvsEKct4ny
 Ten5gtXf563WziY6yspbwtiuWuea1h9MpqVvfmpYqJ4akoP1WvB8B1W9UBEwdjARcMtu3L1puba
 0mGu+Usjv1DHNj6+HN0b8+KzXqBh4JykXU5Uqwsl44QQHN0SwaoHSHByvexj5J4bTE4huYLBHkV
 u1l425Ap5GYu20FD0XF10WBfGiUoJya75VTESuHvfgM28Nuu3ANg3BC9fvxRvNQPHdtHOe5QUnQ
 As+ODl207eiarogMYTPB28PCktrPhx4qy5nEhz+3v7l6gqPGT4GXv+HCu7V+ke1QqN67ySn0ilB
 Ck8Y5JdNUg1CEgYCyYbHxdFE3Qa2s9tGVQkxyYgKsMYfDrOtSGOqopYGGWKY9fLzkRGy71Wup7r
 VN0JpxYogd090VFFAJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020085



On 30/05/26 1:19 AM, Philippe Mathieu-Daudé wrote:
> Could get re-review: 4 & 5
>
> Move cpu_init/realize hooks from AccelCPUClass to
> AccelOpsClass. Specialize them for TCG in TCGCPUOps.
>
> This drastically simplifies the need of per-binary QOM
> types per accelerator per target (see also the nice
> diff-stat).
>
> Based-on: tag single-binary-20260528
Hi Philippe,
I have tested this patch series on ppc64 (pseries) in both KVM and TCG 
acceleration modes and it seems to work as expected.
So, feel free to add
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

I am sharing logs below:

smp as 8 and maxcpus as 64
i) Guest bringup with sockets 2 cores 16 and threads 2
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 2
Core(s) per socket: 16
Socket(s): 2
ii) Guest bringup with sockets 2 cores 8 and threads 4
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 8
On-line CPU(s) list: 0-7
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 4
Core(s) per socket: 2
Socket(s): 1
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 4
Core(s) per socket: 8
Socket(s): 2
iii) Guest bringup with sockets 2 cores 4 and threads 8
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 8
On-line CPU(s) list: 0-7
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 8
Core(s) per socket: 1
Socket(s): 1
After hotplug:
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 8
Core(s) per socket: 4
Socket(s): 2
iv) Guest bringup with sockets 4 cores 2 and threads 8
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 8
On-line CPU(s) list: 0-7
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 8
Core(s) per socket: 1
Socket(s): 1
After cpu hotplug
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 8
Core(s) per socket: 2
Socket(s): 4
v) Guest bringup with sockets 8 cores 1 and threads 8
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 8
On-line CPU(s) list: 0-7
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 8
Core(s) per socket: 1
Socket(s): 1
After hotplug :
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 8
Core(s) per socket: 1
Socket(s): 8
Trying all scenarios without any maxcpus :
i) Guest bringup with sockets 8 cores 1 and threads 8
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 8
Core(s) per socket: 1
Socket(s): 8
ii) Guest bringup with sockets 8 cores 2 and threads 4
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 4
Core(s) per socket: 2
Socket(s): 8
iii) Guest bringup with sockets 8 cores 4 and threads 2
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 2
Core(s) per socket: 4
Socket(s): 8
iv) Guest bringup with sockets 4 cores 8 and threads 2
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 2
Core(s) per socket: 8
Socket(s): 4
v) Guest bringup with sockets 2 cores 16 and threads 2
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 64
On-line CPU(s) list: 0-63
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 2
Core(s) per socket: 16
Socket(s): 2
vi) Different smp values :
a) 32
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 32
On-line CPU(s) list: 0-31
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 2
Core(s) per socket: 8
Socket(s): 2
b) 16
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 16
On-line CPU(s) list: 0-15
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 2
Core(s) per socket: 4
Socket(s): 2
c) 8
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 8
On-line CPU(s) list: 0-7
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 2
Core(s) per socket: 2
Socket(s): 2
d) 4
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 4
On-line CPU(s) list: 0-3
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 2
Core(s) per socket: 1
Socket(s): 2
e) 2
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 2
On-line CPU(s) list: 0,1
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 2
Core(s) per socket: 1
Socket(s): 1
f) 1
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 1
On-line CPU(s) list: 0
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 1
Core(s) per socket: 1
Socket(s): 1
iii) smp without any topology:
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 32
On-line CPU(s) list: 0-31
Model name: Power11 (architected), altivec supported
Model: 2.0 (pvr 0082 0200)
Thread(s) per core: 1
Core(s) per socket: 1
Socket(s): 32
iv) TCG tests:
a) smp 32 without topology :
/home/Anu/qemu/build/qemu-system-ppc64 -name 
guest=sles16_migrate,debug-threads=on -S -object 
{"qom-type":"secret","id":"masterKey0","format":"raw","file":"/var/lib/libvirt/qemu/domain-18-sles16_migrate/master-key.aes"} 
-machine 
pseries-10.2,usb=off,dump-guest-core=off,memory-backend=ppc_spapr.ram 
-accel tcg -cpu POWER11 -m size=16777216k -object 
{"qom-type":"memory-backend-ram","id":"ppc_spapr.ram","size":17179869184} 
-overcommit mem-lock=off -smp 32,sockets=32,cores=1,threads=1
b) smp 16 with topology
Threads 2 :
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 16
On-line CPU(s) list: 0-15
Model name: Power11 (architected), altivec supported
Model: 18.0 (pvr 0082 1200)
Thread(s) per core: 2
Core(s) per socket: 1
Socket(s): 8
Threads 4:
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 16
On-line CPU(s) list: 0-15
Model name: Power11 (architected), altivec supported
Model: 18.0 (pvr 0082 1200)
Thread(s) per core: 4
Core(s) per socket: 1
Socket(s): 4
Threads 8:
localhost:~ # lscpu
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 16
On-line CPU(s) list: 0-15
Model name: Power11 (architected), altivec supported
Model: 18.0 (pvr 0082 1200)
Thread(s) per core: 8
Core(s) per socket: 2
Socket(s): 1
Virtualization features:


Thank you
Anushree Mathur
> Ignoring checkpatch.pl:
>
>    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>      accel/accel-target.c
>      include/accel/accel-cpu-target.h
>      include/accel/accel-cpu.h
>
> $ git backport-diff since v1:
>
>    [----] : patches are identical
>    [####] : number of functional differences between upstream/downstream patch
>    [down] : patch is downstream-only
>    The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>
>    001/      17:[----] [--] 'target/loongarch: Remove unused 'accel/accel-cpu-target.h' header'
>    002/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_class_init()'
>    003/      17:[----] [--] 'accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()'
>    004/      17:[----] [--] 'accel/hvf: Remove need for AccelCPUClass::cpu_realize'
>    005/      17:[----] [--] 'accel/kvm: Remove need for AccelCPUClass::cpu_realize'
>    006/      17:[----] [--] 'accel: Introduce AccelOpsClass::cpu_instance_init handler'
>    007/      17:[----] [--] 'accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
>    008/      17:[0002] [FC] 'accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
>    009/      17:[0002] [FC] 'accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
>    010/      17:[0016] [FC] 'accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
>    011/      17:[----] [--] 'accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init'
>    012/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_instance_init()'
>    013/      17:[----] [--] 'accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize'
>    014/      17:[----] [--] 'accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize'
>    015/      17:[----] [--] 'accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize'
>    016/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_target_realize()'
>    017/      17:[----] [--] 'accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h''
>
>    diff --git a/include/system/kvm.h b/include/system/kvm.h
>    index 2c31fa6019e..a249f076763 100644
>    --- a/include/system/kvm.h
>    +++ b/include/system/kvm.h
>    @@ -225,0 +226,3 @@ void kvm_irqchip_change_notify(void);
>    +void kvm_arch_cpu_instance_init(CPUState *cpu);
>    +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
>    +
>    @@ -367,3 +369,0 @@ int kvm_arch_destroy_vcpu(CPUState *cpu);
>    -void kvm_arch_cpu_instance_init(CPUState *cpu);
>    -bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
>    -
>    diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>    index 113a23f2384..edad3c1acea 100644
>    --- a/accel/kvm/kvm-accel-ops.c
>    +++ b/accel/kvm/kvm-accel-ops.c
>    @@ -101 +101 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>    -    ops->cpu_target_realize = kvm_arch_cpu_realize;
>    +    ops->cpu_realize = kvm_arch_cpu_realize;
>    diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>    index 7d194ea112b..0f1a98b430f 100644
>    --- a/target/arm/kvm.c
>    +++ b/target/arm/kvm.c
>    @@ -1785,0 +1786,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>    +void kvm_arch_cpu_instance_init(CPUState *cpu)
>    +{
>    +}
>    +
>    +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
>    +{
>    +    return true;
>    +}
>    +
>    diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
>    index 5d74ca6fd56..536bcecd7d2 100644
>    --- a/target/i386/hvf/hvf-cpu.c
>    +++ b/target/i386/hvf/hvf-cpu.c
>    @@ -58 +58 @@ static void hvf_cpu_xsave_init(void)
>    -void hvf_arch_cpu_instance_init(CPUState *cpu)
>    +void hvf_arch_cpu_instance_init(CPUState *cs)
>    diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
>    index 10ab7b2a4dc..2973e28122a 100644
>    --- a/target/i386/nvmm/nvmm-all.c
>    +++ b/target/i386/nvmm/nvmm-all.c
>    @@ -1214 +1214 @@ static const TypeInfo nvmm_accel_type = {
>    -void nvmm_arch_cpu_instance_init(CPUState *cpu)
>    +void nvmm_arch_cpu_instance_init(CPUState *cs)
>    diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>    index 9d844c4905a..167fdd515be 100644
>    --- a/target/loongarch/kvm/kvm.c
>    +++ b/target/loongarch/kvm/kvm.c
>    @@ -1497,0 +1498,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>    +
>    +void kvm_arch_cpu_instance_init(CPUState *cpu)
>    +{
>    +}
>    +
>    +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
>    +{
>    +    return true;
>    +}
>    diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>    index 013f5e852e1..894962d509f 100644
>    --- a/target/ppc/kvm.c
>    +++ b/target/ppc/kvm.c
>    @@ -2354,0 +2355,4 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>    +void kvm_arch_cpu_instance_init(CPUState *cpu)
>    +{
>    +}
>    +
>    diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>    index 2e4f435c537..46730e72a92 100644
>    --- a/target/s390x/kvm/kvm.c
>    +++ b/target/s390x/kvm/kvm.c
>    @@ -2613,0 +2614,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>    +
>    +void kvm_arch_cpu_instance_init(CPUState *cpu)
>    +{
>    +}
>    +
>    +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
>    +{
>    +    return true;
>    +}
>
> Philippe Mathieu-Daudé (17):
>    target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
>    accel: Remove AccelCPUClass::cpu_class_init()
>    accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()
>    accel/hvf: Remove need for AccelCPUClass::cpu_realize
>    accel/kvm: Remove need for AccelCPUClass::cpu_realize
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
>   target/arm/kvm.c                  |  9 ++++
>   target/arm/whpx/whpx-all.c        |  1 -
>   target/i386/hvf/hvf-cpu.c         | 25 ++----------
>   target/i386/hvf/hvf.c             |  5 ---
>   target/i386/kvm/kvm-cpu.c         | 25 +-----------
>   target/i386/nvmm/nvmm-accel-ops.c |  2 +
>   target/i386/nvmm/nvmm-all.c       | 19 +--------
>   target/i386/tcg/tcg-cpu.c         | 28 ++-----------
>   target/i386/whpx/whpx-all.c       |  1 -
>   target/loongarch/kvm/kvm.c        |  9 ++++
>   target/loongarch/tcg/tcg_cpu.c    |  1 -
>   target/ppc/kvm.c                  | 27 +++---------
>   target/riscv/kvm/kvm-cpu.c        | 33 +--------------
>   target/riscv/tcg/tcg-cpu.c        | 28 +++----------
>   target/s390x/kvm/kvm.c            |  9 ++++
>   31 files changed, 95 insertions(+), 305 deletions(-)
>   delete mode 100644 include/accel/accel-cpu-target.h
>   delete mode 100644 include/accel/accel-cpu.h
>
