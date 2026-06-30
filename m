Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DEE33EB10
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844496; cv=none; b=SngsaMekZF3jbgJ3KMySWvTxrB4hQZKakvISyvwVQ3PxkbP8DNuRC6PEmnYcz1CCEI+OV//FCCohCe+DNmm0ELEJlB/03mGd8IrphqFkIgQ+MBRdEhdct18f3/w7g3FC0onY232P3sw2+ufUPJeRJ+4F0HcILpGDC6l8mtcdp9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844496; c=relaxed/simple;
	bh=C67zTDfUC570nxD7H4/DmblbSDbZ/3LKGiLQvSboP74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDFb5wETGDltCl1c2q8An2C80ze5tCH8qDu8MIc9WUYqwegRP6no6Y2Eq2vTYksHG6XaG3a3mkuMIE0sc/2Qypd+ke3nw7+Wps1tSzmyT733vSx4yqinofUu3578ctoub4p5y2p8Hsf2fE85HSyZi646D77ygpTNbRYFM9IaS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JatE03W7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JatE03W7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIc8t2171251;
	Tue, 30 Jun 2026 18:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xMwXUV
	4ej667qW/ukKiVjWOVOdoMrryVkbVp9K4ur5s=; b=JatE03W7vTUN/CIQjf19Zl
	4rBXLSvJXqqx9IdPoefaWyO/cQFxPWix2LusKLXEdu5YhRORySnXwJOfiw7FY/Qj
	zHHjMxFx48eoS5lMF7Deg0JnxxXL1yrxlxDG+QF5a5Sh5GpgnDvbJI4Ayz77+CpV
	juCM/A9Q14rFJy2rlPHlUoqtFT2sNorkdflBty+fdNO2ekRYWoA/u62NvI1UVMMn
	nLjyClvg7994e0Oh9oLu3o4rkxtXlCRyYpnXPgbcZOYZSzGX0ia2mxxxwlcbJ586
	6l1pL+BqteX0taUQj8FAaJcykg/UeNYp5fs8qdJIO8yqnSL9Z92CwfX73EXUZ2Jg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf07cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 18:34:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UIJb4c015060;
	Tue, 30 Jun 2026 18:34:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhbnqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 18:34:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UIYfmL27132312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 18:34:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3604720043;
	Tue, 30 Jun 2026 18:34:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BE1D2004B;
	Tue, 30 Jun 2026 18:34:27 +0000 (GMT)
Received: from [9.39.22.35] (unknown [9.39.22.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 18:34:27 +0000 (GMT)
Message-ID: <9eb293a6-4619-4499-8ba8-e63a1d703ac2@linux.ibm.com>
Date: Wed, 1 Jul 2026 00:04:01 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Testcase improvements and Power8E/NVL removal
To: Misbah Anjum N <misanjum@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <9eefc074b799f7380cf61885bc37642a@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <9eefc074b799f7380cf61885bc37642a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a440c46 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=C9BDwd5fFWHTyHC46gQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qgHq8iGx1BOwy5u4DcpFOjgtT-tOuA8l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE3NSBTYWx0ZWRfX/OIIw2DTGf+M
 Xu5EH+kePlX7npn3rK8GAcpF+AqqsWqjbzYHnlI9o1MaQ2Jo61DfbATjOvFj9WLoFnfZZw98QyH
 4clSDhflnvfP/P9cP9tmu/KUFHJfC9kMEgKBmFJtVxzPFa2F6NnW0NPBOh2/ZvERFjh+NcKMAyi
 vMJiur4E2UmelG4jxAH46mKnYtzDKoC//pg5ExjsH7frLhf/BYsMlF/ZvM1qo+tK2NeDmOrvwzR
 JK6YcfiYFARx16XHgTNwPJl4/Hnf5An0vGkaVrK3hsBZckQTgEdRmyXJr7SeCKDNM3umKPpfkJH
 iUZqB5mH0dYkIX6en+IzArPr/nnojRkGeANAVTfIU74VzjTtNlSKi9WdxkqnLPQc3Ji4mXDuQvL
 xox/Txaz4YOCszdEveKJwmn9cr65gYjLZbS3UUAMeIHs0sXyHwMg6fM1LEt5weHpbBTT0ABXXMJ
 1rxOQE6Ys3FiaTCwK0A==
X-Proofpoint-GUID: 3P-6R5aZUoDbSgkA86zm_rCdVOX4gFhO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE3NSBTYWx0ZWRfX0jlt5WXJJnKZ
 L4XrOPhNoQyxN05xfLY8hANtQxhLTVKmLyXQqHjJLcQc8TaUuRamiuV6rlAqHV8kdxVA/y2JT59
 1rvwoaqZed63WkAXypojKPEglllvKmg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300175


On 30/06/26 09:49, Misbah Anjum N wrote:
> On 2026-06-29 16:34, Aditya Gupta wrote:
>> <...snip...>
>>
>> base-commit: 20553466cc47af6a8c95f665b601fce3c852e503
>
> Hi Aditya,
>
> I've tested the v3 patch series on PowerNV and pSeries guests 
> including the new remote interrupts functional test and Power8E/NVL 
> removal.
>
> Testing Environment:
> - Host: Fedora 42 ppc64le
> - Arch: ppc64le
> - QEMU: emulator version 11.0.50 (v11.0.0-2400-g20553466cc-dirty)
>
> PowerNV Guest Bringup
> Status: Success
> qemu-system-ppc64 -name test-vm -machine powernv -m 4096 -smp 4 
> -nographic -kernel 
> ~/.cache/qemu/download/6fd29aff9ad4362511ea5d0acbb510667c7031928e97d64ec15bbc5daf4b8151 
> -drive 
> file=~/.cache/qemu/download/aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2,format=raw,if=none,id=drive0,readonly=on 
> -device nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234 -append 
> "root=/dev/nvme0n1 console=tty0 console=hvc0"
>
> PSeries Guest Bringup
> Status: Success
> qemu-system-ppc64 -name test-vm -machine pseries,accel=kvm -m 4096 smp 
> 8,sockets=1,cores=8,threads=1 -nographic -serial mon:stdio -drive 
> file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=virtio,format=qcow2 
> -netdev bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0
>
> Power8E/NVL Removal Verification
> Status: Success (both correctly rejected after removal)
>   qemu-system-ppc64: unable to find CPU model 'power8e_v2.1'
>   qemu-system-ppc64: unable to find CPU model 'power8nvl_v1.0'
>
> QEMU Functional Test Results (make check-functional-ppc64)
> Status: Success
> Ok:                 12
> Fail:               0
> Skipped:            4
>
> QEMU Unit Test Results (make check-qtest-ppc64)
> Status: Success
> Ok:                 33
> Fail:               0
> Skipped:            0
>
> Result: All tests passed successfully.
>
> Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>

Thank you for thoroughly testing this misbah !

- Aditya G

>
> Thanks,
> Misbah Anjum N
