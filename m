Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A39233704
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367214; cv=none; b=VNn2gJGRA7rEduygoUVC1QLXgFXbrtWwor9WgKoYAdKFFd4GBVCHGLxPAcQ3LnuOirZrvDXwCpRwz5xOwm4NFu8EINsmUyESwBPcdAR8+O3zSpI+ZhIGZ2espEbA6zVBvtIRbkNvfNCz0coTqsb/VW+N+JgSiiVyBJs+rJ1kuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367214; c=relaxed/simple;
	bh=SKXARVczZeUfydJt9edGvsotRbhxV44hTbTbMsKyLOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gboQ3vnHb0PxSx0z6jiy/dBZWPPB/MjowTAGcc9LGnrEYCZSG4OzjosBp1iL44k1YVdDjQFeACHiZgXyprUdMUHXhO5a2Y1ay+3Z2Ei51NGcsXoOj1Uo7CIAT8mEjAB2aKhYiOF4Fi+aqMWgVMPPMmCYyivkQnttl+ertX3qW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NZFWOOh0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NZFWOOh0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mIcU3040743;
	Thu, 25 Jun 2026 05:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Askk4u
	GAbpTmSSMvHbA3eDcObDuylWmra3z7jzrykIY=; b=NZFWOOh0akxJ2KEH5qyWRd
	1tBgPIXnxjzmA9BQHykLvhlNq7JSHH6WIUix16Av9DyWhNP8m2+ueIGeegHpEPNw
	1n3tY0SjrlkuT/ERVomwOfuDfZ6/uKqPsc5LYjsbW4XU7OZWY5UeyZivaAmVU9G0
	eilXOC10CoDY7yJ2LiFMSMVUN4FSNVtA7xRJXQAB1K1A5BG+cr56uz0j7n4hAV1a
	VZeqhQMfDtmuOkBfLIPd5UEnQerjFWPFenve/dgeEPha5TIDOC3G11cM8hxxo+5a
	6rqg0e2ywE/Fayk8hTXnSP3LqJ/OukS/nmPpy5qhCdna8Q7fYDjaEBnnrJT0enNw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3ra6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 05:59:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P5njNG026747;
	Thu, 25 Jun 2026 05:59:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyvcjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 05:59:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65P5xtJp31523344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 05:59:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4CBE5805C;
	Thu, 25 Jun 2026 05:59:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54DF25805A;
	Thu, 25 Jun 2026 05:59:49 +0000 (GMT)
Received: from [9.123.1.190] (unknown [9.123.1.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 05:59:49 +0000 (GMT)
Message-ID: <4edf1ef8-1d88-4ad1-92eb-d587974bcd20@linux.ibm.com>
Date: Thu, 25 Jun 2026 11:29:48 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
Content-Language: en-GB
To: Aditya Gupta <adityag@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
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
        Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
 <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com>
 <ajvemcUx0k12xOIW@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <ajvemcUx0k12xOIW@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3cc3de cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=GL2pwhq3XJ6zHIDeOc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0OCBTYWx0ZWRfX5lRzK9JZNmYd
 6u45k/8bfRG+y5h8G19h9jd65mEAHmjRFPVehPJV5YgKOdGvm8B5R2O80HbU+EZJbesIyZACqOU
 XLLtdHQdTA4MapLkHZMuedu4lHvBWMk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0OCBTYWx0ZWRfX7Zeg3sqxVT/F
 oUjunawp43t3KgW+eM1I5KV9reDxnLWEIrhG2CN72/aXQViVpRtmgVq4CNGn83E7TBqbd/mzpTs
 xU3g1ZvTJzBUn1xFtOsNpjopBusIAnaqFWHogU8zXbOQLOFlMHg64RGOQSKBJCRQoKa4tr5fySX
 LXu4s72du1fipB0tgw9KvAGj+SRnikankQ1kvR4eyKkezjr0BzA9urX4ms00tJDNjm+t+nlL5pl
 GGM6D8OhOLeXBepw1B2MgpIYZXL4qaFILJkmBFx076ysPERwKcPhndPBSpOe3Cn48debKXzVGV+
 UeM9HIjsXC2wManxuvUmddoZ6N+/czkoX0kM01ukdmXjKSHZTbxMjQFpmOl+MR45jttIOzy4RyH
 C9hTdVpQcxM67XNigmM50DpYn9h3oFYLaQpvctlTtVW13om0wuIfCJsmrhr033V4eETUCTAM6l+
 OxYaC1Zqat7EPSM1jhA==
X-Proofpoint-ORIG-GUID: lvAYF7OdUJihUlprfyRtsj8miGujFbwx
X-Proofpoint-GUID: Y44GQ_92li0VyBXhkFcjwQfOssESDX_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250048



On 24/06/26 7:14 pm, Aditya Gupta wrote:
> On 26/06/23 09:24PM, Shivang Upadhyay wrote:
>> On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
>>> +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
>>> +{
>>> +    if (chip_type == PNV_CHIP_POWER8) {
>>> +        return "powernv8";
>>> +    } else if (chip_type == PNV_CHIP_POWER9) {
>>> +        return "powernv9";
>>> +    } else if (chip_type == PNV_CHIP_POWER10) {
>>> +        return "powernv10";
>>> +    } else if (chip_type == PNV_CHIP_POWER11) {
>>> +        return "powernv11";
>>> +    } else {
>>> +        g_assert_not_reached();
>>> +    }
>>> +}
>>
>> How about refactoring to the following?
>>
>>      static const char *const machine_types[] = {
>>          [PNV_CHIP_POWER8]  = "powernv8",
>>          [PNV_CHIP_POWER9]  = "powernv9",
>>          [PNV_CHIP_POWER10] = "powernv10",
>>          [PNV_CHIP_POWER11] = "powernv11",
>>      };
>>      return machine_types[x];
> 
> Has a subtle difference, that it may not assert/segfault on unknown
> value for x, I want the test to crash/fail if this is called with an
> unknown/new processor chip. I believe the if-else/switch is better as it
> handles (by 'crashing') unknown values too.

We could just do:

if (chip_type >= PNV_CHIP_MAX) {
     g_assert_not_reached();
} else {
     return machine_types[chip_type];
}

That way just adding new array entry would work for future chips.

> 
> - Aditya G
> 
>>
>> ~Shivang.

