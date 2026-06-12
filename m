Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA75340416
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246192; cv=none; b=sxKrPCSCBDRNQEJgkro3R6NYq7YLJ7JGtZvZwi71iFAY/r8QV+c+N/d8TXpYOBO8tlBDVZZLJTcpdMznECIfhpYw6M4l6fEr4MnmvHy11RJ+1zNbYuC03qk+ekWnZjicOhIR77znQ7NHqVMa+RnU/AY0mlqWB6MwM+jCSXd2zEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246192; c=relaxed/simple;
	bh=+1rWn+CZ2B26mcHtKcZuLefpGwJd27vWkvu9PDRRlzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnZhu0Yj3cVUbsGOVgEF5FiwvIQYFmeA0uBjv0LtP4WsWqgbfbgEA+lPHncMPrtCYRvGCytCh2I8i5re3K8JN1LAe4VvrHYy95AoEEI7yXupB5nKYjhBdK/XSEQcHR/o0EPR+YsFwD7nuqN8b/sRDh0/KprxNsI6za58QH/CYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b7yMeEpi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b7yMeEpi"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BMHHTJ4146662;
	Fri, 12 Jun 2026 06:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+1rWn+
	CZ2B26mcHtKcZuLefpGwJd27vWkvu9PDRRlzI=; b=b7yMeEpiWhKRU5UPIt9IqN
	YXtv3/1BIlJAQOwp6YNhCe4o9NT/rnh9exrBZ8JLeMEUxqXATbY1msyc1Q2bD7SG
	ntaAtiODg5vtfPVE9YE0Jr9q6jSjOqP3RsOflxyFY5KLxcCobFPDsKl4PFqTqTUF
	laGtgdkdZelADe4C2KJDZaOV6CJyf0VgbwsIzUdezfGc74fRLMQdMuqRUEZKCxOw
	gBhXdDCz5qA16Vc9Ii2acW175dsiRqgMyEe5gm44ric+BvhbgqcwQvz0RLrCl172
	72ZcuQTUEzbpiB0RetB1iawU1ESjLaHdzwpMO14xpX+9eGWriss95fa+kzp/QCTA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c7jj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 06:36:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C6Yc6G008900;
	Fri, 12 Jun 2026 06:36:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08xmd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 06:36:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65C6aDrD49873170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 06:36:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC89820043;
	Fri, 12 Jun 2026 06:36:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A943420040;
	Fri, 12 Jun 2026 06:36:07 +0000 (GMT)
Received: from [9.124.211.181] (unknown [9.124.211.181])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 06:36:07 +0000 (GMT)
Message-ID: <e87e7d6f-2ee2-423e-9111-19b7f14f376e@linux.ibm.com>
Date: Fri, 12 Jun 2026 12:06:05 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ppc/pnv: Remove Power8E and Power8NVL spapr cores
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-4-adityag@linux.ibm.com>
 <2610e4bd-7ddc-4880-808d-3f55bb166938@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <2610e4bd-7ddc-4880-808d-3f55bb166938@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA1OCBTYWx0ZWRfX+nwDxc+/Zh3P
 QQgmv4hdp9JxoSnYYpuatN4ePapVX4FWTzBSiXNjLZ9udr2/0rxc90XjeSHGgpZBUdHBgxgbQ2o
 8XAQqnwlXlXt9nRXi5N1a6sYmbBcDBI=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2ba8e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=MFgsVc_P71K-EoIa1lMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zko1NFm39B5RYfWzefPsOq9Zl13t8aEo
X-Proofpoint-ORIG-GUID: AbRD2TZNRJE-OGv-lwpMI5Ula9L1zne2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA1OCBTYWx0ZWRfX7NVrGtLpjENA
 b9T8bFDiNxDdt7z8M7E2aMRmobQcNjt+LMBaG0g3kI8e0dLEVYXXXeTpQQC6emHvaT8iyECg4NV
 f1S0ycUnc9/IADJiJvf31ZJq+GFuBSXsbPlZ6Jdk/tAwPIn8svjmSpNEF6k25BSSqKpyvGWR93t
 tJueHfj6h0vu8Da01R1EFJ5+usNrlIeNUf7cmpc8P19Q2SghNCRdC3PMAr2kr5rJ+uT0ZW/d9xs
 eSkGp/dU5dz2Yj6Ebyizqj+nVGqcvcuWRneLN4bBRPAKrbGXYhj+Y2OhPv4I1USP/vwvtboX4Rp
 wIH/I1rRsdQVX+5hR+BFeBMCcTGPbRjU8+ap2Ecri1XwJcpgENFkwpwY2tNTyejnA+f/LRZj6Z6
 FPuD/y/I9y6CT7fuujEZtEJ0uihdagGElvxKP7JCuGoP5UOw9Pp8Lhu66Szpy/HhA7dumZdKkXx
 ur0MRnozRKrP55PKNhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120058

On 11/06/26 12:12, Philippe Mathieu-Daudé wrote:

> On 10/6/26 11:07, Aditya Gupta wrote:
>> Power8E and Power8NVL were deprecated since QEMU 10.1, with
>> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
>>
>> Remove the corresponding 8E and 8NVL CPU cores from spapr/pseries
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   docs/system/ppc/pseries.rst | 2 +-
>>   hw/ppc/spapr_cpu_core.c     | 2 --
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>
> Squash with following?
>
Sure, you mean squash into patch #4, the target/ppc change ?


Thanks for reviewing !

- Aditya G

