Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E8411668
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613323; cv=none; b=InfzyTFFQGNrjvsSxK7k0TzrD9jzhb+XmUi/2rnfJonbvz5y8IaeyDWLQEWWZguo1vnBAxkL8NYYaSWwk/aKkGJqNvAQb59PzzauEsMEsTSUB+cod+dBf7p25Mg+DBkPE5fL31wyCAcIKAZck1yWERw8amf4C4BAoExf1obzliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613323; c=relaxed/simple;
	bh=iLKsOBa+kqWdg9uz2A0Lq2s1xMh6kf/4nwlQJp4SKcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ls/g5BHA32Hz1L1QffNdxNjNElwM9noBToZHr1zjd572rWZgXGC6luXEeYWXl7LPHWBaWTc2Be7kaPv6u/3e6IvMqolQ0AnqQz3vJZO7v7ebCNWLsTQnxsbyzDzHesjN3xv0cPiOoCqi8137Tfl5XQnr5J8hysTgbw09wO1FlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ujro1y8F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ujro1y8F"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EITsc2171567;
	Thu, 9 Jul 2026 16:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2USklm
	ugU4nPeGq0rHesdoPn50kecPwdJ+WBZMJPFfk=; b=Ujro1y8FPrReVoV7AST3O7
	Y3Zfp3rIO/tGXN5pahEWp/JnrEtpLowV14TA4ioQsmZ0aJbwC6dkSGOlPwfv/PlC
	tcWFYE66pxY+TYQw8dWp1yVh9WkVhUUMovT5B3/ecRNfEl0HL3iSHke73a4h4AYh
	A3urN6y2w2ZTgLJ9LQTdGKcJonnXHYi97PcLsqUMAXyM/InMMLIAN9wPmi/VFB6V
	zU8NeXfbWBATOgJamdmwrkTkBTg4NMqILVqCJZAbWFMiFk6AVAE3nC146bxlWGk9
	cOQ7dR4u9gk7gcZf7U3YXlRC7YB6XnM74/T5PIoOk1QMOV0T2sDw9HCNlRqCo4KA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw52jfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 16:08:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669G4cca026361;
	Thu, 9 Jul 2026 16:08:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwe2xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 16:08:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669G8Te458393078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 16:08:29 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB2A85805B;
	Thu,  9 Jul 2026 16:08:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E6925805C;
	Thu,  9 Jul 2026 16:08:24 +0000 (GMT)
Received: from [9.39.26.55] (unknown [9.39.26.55])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 16:08:23 +0000 (GMT)
Message-ID: <4dd23a35-8dcc-422c-8ffa-2387abf92558@linux.ibm.com>
Date: Thu, 9 Jul 2026 21:38:21 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 4/6] powerpc: gitlab CI update
Content-Language: en-GB
To: Thomas Huth <thuth@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
 <20260708105122.1177210-5-rathc@linux.ibm.com>
 <bd10e435-de06-4b67-962c-b520a43a8280@redhat.com>
 <8c9b739c-8a9b-4e9a-8e43-7b1a6e1aa330@linux.ibm.com>
 <73573868-2fb9-445d-b5c6-02166a0feb25@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <73573868-2fb9-445d-b5c6-02166a0feb25@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: O2yiXJWz5U9dnQ341k-1M2kyCu2vucWq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE1NiBTYWx0ZWRfXzFad+uXX1GLp
 u17Muc2Wou+H4B7T5zEzWF4V83IQZ+Ibbcj3XQsImSaibYJI2eRYxnAQXgKCHrZwpmd2jR8wrOp
 J8lr3dB+pht1KtLp4soblPhmCGvKEmuH3YavcD5+BA+5RZ7XzO1BfSWpFB+Y5Z6SmKWOCaloKEi
 w4mNh7C8tUCq22AovO87i8tgXNYdQuQJa987SJC+nI0bMeN91e9ZFVe/kw5IKIyV4r2jpJnMR/2
 iq+sYNUpvOCjhVRqZVnru4L6nZpb9AsO1FmQf83aKOSbe0QwZF1QdftalalBvP43nPe37qzzv8v
 PEgg3K3PmzPzNo50bggCN3P68qGcQgbqPDKLSMVsHaPoFfG3rtSV9wHrLNF4BDOzfaM9p1Fgxea
 p2Ctlxx3Df7OKyTEeRQYkJ7n7ZLCjhpl7pgKU9oqtddZ3W+mYfKJEpPMwQe5Sv2vCdeEC1omgqE
 0uDj6dc5CN7sXqBKRSw==
X-Proofpoint-ORIG-GUID: YQ5i9Wu4PrujvY0hvAo_Kw3C4XGN2wIv
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4fc780 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=dx41-kcvcX-jZ8cbK5AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE1NiBTYWx0ZWRfXyzRNW+oE94Q9
 mmzEI+aBD6NXbOAPUSCVUE3p/PyE+JgXeKt9QjmEs2mxDjUN6ymca4cpGzq6xY6B4veTg0+He5S
 cMjeNWBkuq6tkH1ADE/eAPWkhCbf2RM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090156



On 09/07/26 8:46 pm, Thomas Huth wrote:
> On 09/07/2026 16.32, Harsh Prateek Bora wrote:
>> + folks who might be interested.
>>
>> Hi Thomas,
>>
>> On 09/07/26 12:16 pm, Thomas Huth wrote:
>>>> +++ b/powerpc/unittests.cfg
>>>> @@ -24,6 +24,14 @@ file = selftest-migration.elf
>>>>   machine = pseries
>>>>   groups = selftest migration
>>>> +# make a kvm-only version for CI for now
>>>> +# TCG accel support with Qemu and distro release used in gitlab CI 
>>>> needs to checked.
>>>> +[selftest-migration-ci]
>>>> +file = selftest-migration.elf
>>>> +machine = pseries
>>>> +groups = nodefault selftest migration
>>>> +accel = kvm
>>>
>>> This does not make sense (or I don't understand it) - gitlab-CI 
>>> currently only runs with TCG for the ppc64 jobs, so adding a separate 
>>> test for this with "accel = kvm" just adds a job there that will 
>>> always be skipped. What should this be good for?
>>
>> I understand it may get skipped in gitlab CI for kvm-unit-tests,
>> but it might be helpful to those who can run it on their Power HW.
>> If the job can safely skip on non-ppc HW, I hope it's fine?
>> We would like to get it integrated in IBM's internal CI with Power HW.
> You mean you also use a gitlab instance internally within IBM? ... 
> otherwise it does not make sense to add this to the .gitlab-ci.yml file 
> (which you did earlier in this patch).

I do not think we currently use a gitlab runner as of now, but that's a 
future possibility.

Chinmay,
My understanding is that we wanted to use kvm accel also when executed
manually using scripts, as we wanted it to be integrated in IBM's
internal CI that runs on Power HW. Do we need additional changes for that?

regards,
Harsh

> 
>   Thomas
> 

