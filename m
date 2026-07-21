Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180373DC4C2
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653618; cv=none; b=KpdLzsoZVh5NLVnvAV5TVA44YwtYaUqSXFMzg9m7DBNkY03Tfwg/K953XnEXrw627app35nI5+sDqxWrKeTei8BlUG4MF04agNV+EaRZ5ViiviOqK2Z5eKQSMTNMYUkwReTmN0OTMMZrxDmbXzjYyhBb/zBtCLUQ/7IwwM86NKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653618; c=relaxed/simple;
	bh=XKva3Lj2Xfayaug20zCR1RwMHfcLwu0bunMPkKl3nfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoHRjITA9c4JX/agADP9xAU7OT7Z6ZnOp3571DnCkNNLfH+X/Z42a73Og38ALDuUso0yqtsDgjEy0SCjyNXLlu51rJAnlrgbVq41mPpzAHxZcWgG3siAgHQfgNiGps7PbtJUrJ1ZBNq5JuUmd2Pnh/b7lT0/LmHcNBoo4wxKDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T6L5ok3j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T6L5ok3j"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDgYrQ3488548;
	Tue, 21 Jul 2026 17:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8BuHm9
	hDz7cZX+bLVhGXI40gtHMcbUHO6CZQ4KCnZ0w=; b=T6L5ok3jusBteK99ZxOo4N
	8NbOMaNXSbQgIxQuIx/vYSHqWjf3XcVcYjnUZ160kcdvexmq8PdEsPNzhzkVV2j6
	LDHmFLf9Bu47dgv6q5Ea9JiI9S/44RQ8GkTZsqtmxlyANbX6yDEbC8IRg6QLTQkz
	X9mM16zJV0UcT3tjU5oqxR/x13fWZu0q8OwIG4RSdrrouWic8jRsPwEHJ9wmciWe
	zB33XIJWLTulPDKKSC58uISydcqfGv9qNV7SOn2ynajc0z12uw3LjnhGcfG1vAaK
	dMdR9tuQKKKPypOZ91fuqRUmpf0d74nWD1jTLKl3UbZPJ4BLTo5tS2QXPMwXPW2g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77adsbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 17:06:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LGnvnq010271;
	Tue, 21 Jul 2026 17:06:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq3gbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 17:06:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66LH6gPB52625798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 17:06:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB31C5805A;
	Tue, 21 Jul 2026 17:06:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE1DA58056;
	Tue, 21 Jul 2026 17:06:37 +0000 (GMT)
Received: from [9.39.17.135] (unknown [9.39.17.135])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 17:06:37 +0000 (GMT)
Message-ID: <7cf674d9-6928-47a3-9d80-c1bd22ae6f7b@linux.ibm.com>
Date: Tue, 21 Jul 2026 22:36:35 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 0/6] powerpc improvements
To: Chinmay Rath <rathc@linux.ibm.com>, thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <20260719130027.2347519-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ClcdY5LGqlOf9nD5qzULr7fHX8UVUCVi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE3NiBTYWx0ZWRfXw19ShM+wp65T
 r7Dmte6eyjERONZ5V9lPMYQ+AkfXP8ylcPPrcGoJjYVlfhk/ofpzMDMg6u4Y+6KaXJwFG/zIsUW
 bzMF0n2fT2NgsIM6Xe7jGU+xl7uHu2o=
X-Proofpoint-GUID: YdE9I3v58JVDP-bImoWM2tpa2vk1fwly
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE3NiBTYWx0ZWRfX+jPHTH+nWzvA
 hWZCQuriGB8jA5HfcNfz9pBQ26CU9d1QI/kPdyoTlb26Zk3nlb2HiYL0LR6phBduFeII7bvtIk6
 rD5ZPKzefEGrqW3R6wuEIjWlk3Sfy3KGz7q9f6AVCw21yCfJhtU+kWbFAVH1GxdgZLa5diFTm3j
 DIRxunT0ksPtv6RPkYaTSTHizW5bFN79v801P18Npb26pPfQ2MmHxFO+JBoqFvtm8U0uT2hSkBm
 V6KlvUj+/YiDnZF93z2AcRBVpWTE4j5BPCUqWMPmBWyRP/SNwLekntezmQu6dN44q7AGlxYiaXK
 kbDFy0b2r5obosIk9w935G5ad/fp3VKebpa7BzB5JuUoQFzBMhH5BsghO79vExIQ+NuWkL0GmcL
 /VJKwZEQnbuXKtQvZoNf74I9q8fi2b0y9kRndZl2mvR4LZEWxw4RoN+XoQ6u+c+UQR2yUnP97tr
 hs8oG8CFi/PyYeB1Dlw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5fa725 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=rlXZG5oQsmkG2E2Rr58A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210176

On Sun, 19 Jul 2026, Chinmay Rath wrote: > This series aims to add a 
couple of new powerpc tests and improve > the powerpc build structure. 
Tested on POWER10 (native KVM, ppc64le). Tested-by: Aniket Sahu 
<asahu1x@linux.ibm.com> --- Environment --- Host CPU : POWER10 
(architected), altivec supported Kernel : Linux 7.0.0-27-generic 
#27-Ubuntu SMP PREEMPT_DYNAMIC Thu Jun 18 19:14:19 UTC 2026 ppc64le 
GNU/Linux OS : Ubuntu 26.04 LTS (Resolute Raccoon) QEMU : 10.2.1 (Debian 
1:10.2.1+ds-1ubuntu3.1) Accelerator: KVM (-accel kvm -machine 
pseries,cap-ccf-assist=off) Branch : origin/ppc64 @ dde8f397 --- Test: 
pmu (Patch 1) --- $ ./run_tests.sh -a powerpc pmu PASS pmu (22 tests, 1 
known failure) Full log: timeout -k 1s --foreground 90s \ 
/usr/bin/qemu-system-ppc64 -nodefaults -accel kvm \ -machine 
pseries,cap-ccf-assist=off -bios powerpc/boot_rom.bin \ -display none 
-serial stdio -kernel powerpc/pmu.elf -smp 1 PASS: pmu: pmc56: PMC5 
zeroed PASS: pmu: pmc56: PMC6 zeroed PASS: pmu: pmc56: PMC5 frozen PASS: 
pmu: pmc56: PMC6 frozen PASS: pmu: pmc56: PMC5 counting PASS: pmu: 
pmc56: PMC6 counting PASS: pmu: pmc56: PMC6 ratio to reported clock 
frequency is 116% PASS: pmu: pmc56: PMC5 counts instructions precisely 
900 PASS: pmu: pmc56: PMC5 counts instructions exactly 21 PASS: pmu: 
pmc56: PMC5 counts instructions with branch 21 PASS: pmu: pmc56: PMC5 
counts instructions wth conditional branch 24 PASS: pmu: pmc56: PMC5 
counts instructions with illegal instruction PASS: pmu: pmc56: PMC5 
counts instructions with fault PASS: pmu: pmc56: PMC5 counts 
instructions with syscall PASS: pmu: pmc56: PMC5 counts instructions 
with rfid 2 PASS: pmu: pmc56: PMC5 counts instructions with ldat PASS: 
pmu: pmi: PMAO caused interrupt PASS: pmu: bhrb: BHRB is frozen PASS: 
pmu: bhrb: BHRB has been written KFAIL: pmu: bhrb: BHRB has written 8 
entries PASS: pmu: bhrb: BHRB has written 4 entries PASS: pmu: bhrb: 
correct conditional branch address SUMMARY: 22 tests, 1 known failure 
EXIT: STATUS=1 Note: The KFAIL on "BHRB has written 8 entries" is 
expected. POWER10 records 4 BHRB entries when other threads are active 
on the core; the test explicitly accounts for this with a fallback 
4-entry check which passes. STATUS=1 is the correct exit code when known 
failures exist. --- Test: selftest-setup (Patch 3/build structure) --- $ 
./run_tests.sh -a powerpc selftest-setup PASS selftest-setup (2 tests) 
Full log: timeout -k 1s --foreground 90s \ /usr/bin/qemu-system-ppc64 
-nodefaults -accel kvm \ -machine pseries,cap-ccf-assist=off -bios 
powerpc/boot_rom.bin \ -display none -serial stdio -kernel 
powerpc/selftest.elf \ -smp 2 -append setup smp=2 mem=1024 -m 1g PASS: 
selftest: setup: smp: nr_cpus_present = 2 PASS: selftest: setup: mem: 
size = 1024 MB SUMMARY: 2 tests EXIT: STATUS=1 --- Test: selftest-panic 
(Patches 5 & 6) --- $ ./run_tests.sh -a powerpc selftest-panic PASS 
selftest-panic Full log: run_panic timeout -k 1s --foreground 90s \ 
/usr/bin/qemu-system-ppc64 -nodefaults -accel kvm \ -machine 
pseries,cap-ccf-assist=off -bios powerpc/boot_rom.bin \ -display none 
-serial stdio -kernel powerpc/selftest.elf \ -smp 1 -append panic 
qemu-system-ppc64: OS terminated: rtas_os_panic PASS: guest panicked 
EXIT: STATUS=1 Note: The panic test validates both the new 
rtas_os_panic() RTAS call (Patch 6) and the run_panic() exit status fix 
(Patch 5). QEMU exits with "OS terminated: rtas_os_panic" confirming the 
ibm,os-term RTAS token is correctly invoked, and the test runner 
correctly identifies this as a successful (expected) panic. Aniket Sahu
