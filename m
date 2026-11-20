Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160378;
	b=qQAGS4wXH5W+fHm7nfWzjU4t/2AOIqwFxmrdNJIXtJzQZardm0l97Lv/uBguilxi8t6j
	 y8uDprWgh4tfwNF0HsPZwsIH2UWbJ7J2pHZLPWD6x+xCB3Dp4tujTL1FbCemDij6gZPth
	 oyR4MAxpG5M7CfWIRpsklIVCEkfhYNYZKw1rEYyMS32QKP1Xxohw2bglzqau3ylnR+4HT
	 O8mITQySZWcZBH5Bv6+13A2pA45Zomjf9Gj2obrpUhkD+hVT3cXsv3N+miqbTa5Kw6M+X
	 QKuhI/jz7OUPcK0UxfTQvN2XpxQRMe4zTKevFJkj1YjhMm/7r4rxadMqkYjgbPs2LqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160378;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5c7uywk/E3tz2aeqr8yqpmT/+X50oP6skbpWIQJiUgM=;
	b=lUSX6rGU83kED7OT4KaK9omseGZ5JBAMZP58ydBxRqixdzDOIQWhJK8I1mf+gUrcoVjS
	 NY0WBme7vw0rUchWltizzseOeocQhhgoec4GWlkCCeIslooorfcjOVsnC8fIDS/36Mp+W
	 moHp4keGfo+KbwXAchEF0mHgUPhcn3GzvQfi5bSEyuPCbMzHhIY66zYW8vF8vnI5X418/
	 5fGk8ligCCn7qdSghCxmXfL2H6T3ni7vOfbqnDV1vGo418LkQO6E4vu+nPA58fpb1MQek
	 Y09U+VR0h6cLPC4+bs/z2IRSPIbR1HMD4aGKeAtJ0qs8SX+Vv8AWbhV0BBicOYYeVKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AljYNS1D;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A0606A326;
	Fri, 20 Nov 2026 07:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 196A0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AljYNS1D
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3uL0J347670;
	Fri, 20 Nov 2026 07:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5c7uyw
	k/E3tz2aeqr8yqpmT/+X50oP6skbpWIQJiUgM=; b=AljYNS1D4qGNPbXfMCHpSn
	dTo08LBWf3eTJ6eLfDdU+l0uwCJS4Rby8i2/cHg4aa+YKpPVG7AffNPZZcP9B8uY
	DSqGmnYa2GaBPv4jVXPZwtwHZHOWa5vXPiyFkuerVIjxDzFFwZ0xkqvV9bhq3Pn7
	qHe76++INSvgGozKWlaWTFsaf68P9S0K7i77blnzZ2J+tvSNLthxzkpRPmVZKo2w
	5x/S/tJt/ORmrkCXZObQlwWlr8ALAiaWUALh2vhRJoBmImd9cV8OQdZQLIDuTEY6
	9gFkeF8/wRl7htQ7w7alY5Z8RgnJBopY7eBJmyDvFrAhxolt4uaFs5OW3BHB4weA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rxwe8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:39:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK6qgnY1946568;
	Fri, 20 Nov 2026 07:39:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd71fj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:39:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK7dFvG53281234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:39:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 716AA20040;
	Fri, 20 Nov 2026 07:39:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02D8120043;
	Fri, 20 Nov 2026 07:39:12 +0000 (GMT)
Received: from [9.124.218.70] (unknown [9.124.218.70])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 07:39:11 +0000 (GMT)
Message-ID: <9efa20ba-d79b-47b8-9677-474c19aa9168@linux.ibm.com>
Date: Fri, 20 Nov 2026 13:09:10 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] powerpc/powernv/eeh: Map generic EEH error types
 to OPAL
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <20261023073642.59657-6-nnmlinux@linux.ibm.com>
 <2ed69cf8-eca2-41ed-a100-844f9d84c2ad@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <2ed69cf8-eca2-41ed-a100-844f9d84c2ad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1hiMY-kLIMzNlPK_waTpyMDjXtif6Kfx
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afff929 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7823ekUkKOqZUaeGI9UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX0eVegqzIwYZj
 4oMVgLwxAJd9i2erxrlgLtL8D39sQqXp+FbaYRon3ws2ChRrEi9lfOrYS0pIsTp8Ty+PtHJeQlZ
 RvKu9qs0KlqD4eOHVyMOI8OZuSI2idQ=
X-Proofpoint-ORIG-GUID: FJ-e4OiTmQTmkvdqxxxgeh-3Nj7n5NZ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX93CPFQzl6Fr5
 fZRXUVG9oTQcSYxLILkeZAITcjQRcqGM/o7ZYDvB89bmr1ckjrNF7Rt8aR3wkUD0AHbtdJE2yH7
 NG5pyXVtfgZWWWBfd8Idrz7LFg6qY4eFvGjJ4kg9xr1tftA/p47jS8jxDDL9Acatg4EYJbG7zHI
 25bcRKLegaTMVJr0I0dSUifHNBdo1hmS+GIYaLxaDkNQxTmrTLp+zumjn7xPGmMRQBlyzDLkNY9
 eWT7ow7bPxsdY8Mub5hTcW6G8QyFYanVPk1dR8ZWzxpgFzWTZaFF5Twhjrof0km7jKVMioINucx
 DRcURRgswWrK5ftQhhPW6XQEEehNPLbjGr/5pfLeQli1Pv6o1k0VLd5EPiRXTS/jN97J8v8GJ7N
 GfTVbmFWUWinZ+f8z6AFrVTCig6ikjVZOSIHhfrGiHNI0I3sbhgoEg4W19mkWhwoyYD7mUQ/qf2
 vKo+jNTbKhMADuaLrCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200029

Hi Sourabh,

On 19/11/26 1:11 AM, Sourabh Jain wrote:
> Hello Narayana,
> 
> For my understanding, could you clarify why this change is needed as 
> part of this series?
> The series is about enabling RTAS-based error injection, and PowerNV 
> doesn't support RTAS.
> How does this change fit with the earlier patches in the series?
> 
The intention was to decouple the generic EEH error types from the
platform-specific OPAL encodings, similar to the explicit mapping
introduced for pSeries.

However, the generic EEH error-type values remain unchanged, and
the PowerNV mapping is not a prerequisite for RTAS-based error
injection.

I'll drop this patch from the next revision and will post it as seperate 
patch.

Thanks,
Narayana Murty.
> On 23/10/26 13:06, Narayana Murty N wrote:
>> eeh_pe_inject_err() is called with generic EEH error types defined in
>> the VFIO/EEH userspace ABI (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64).  The
>> PowerNV backend previously compared these generic values directly against
>> OPAL firmware constants (OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
>> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64).
>>
>> This is fragile: it relies on the generic EEH ABI values being
>> numerically identical to OPAL-specific values, and would silently
>> misbehave if they ever diverged.
>>
>> Add an explicit mapping in pnv_eeh_err_inject() that translates:
>>    EEH_ERR_TYPE_32 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR
>>    EEH_ERR_TYPE_64 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64
>>
>> Return -ERANGE for unsupported error types, preserving the behavior
>> of the original code.  Decouples the VFIO/EEH interface from OPAL
>> implementation details.
>>
>> No change to existing userspace ABI or PowerNV behavior.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 22 +++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/ 
>> powerpc/platforms/powernv/eeh-powernv.c
>> index db3370d1673c..01dae760cecb 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> @@ -1167,12 +1167,24 @@ static int pnv_eeh_err_inject(struct eeh_pe 
>> *pe, int type, int func,
>>   {
>>       struct pci_controller *hose = pe->phb;
>>       struct pnv_phb *phb = hose->private_data;
>> +    int opal_err_type;
>>       s64 rc;
>> -    if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
>> -        type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
>> -        pr_warn("%s: Invalid error type %d\n",
>> -            __func__, type);
>> +    /*
>> +     * eeh_pe_inject_err() receives generic EEH error types from the
>> +     * VFIO/EEH userspace ABI.  The PowerNV backend must not rely on
>> +     * these generic values being numerically identical to OPAL firmware
>> +     * values.  Translate to OPAL-specific types before calling 
>> firmware.
>> +     */
>> +    switch (type) {
>> +    case EEH_ERR_TYPE_32:
>> +        opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
>> +        break;
>> +    case EEH_ERR_TYPE_64:
>> +        opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
>> +        break;
>> +    default:
>> +        pr_warn("%s: Invalid error type %d\n", __func__, type);
>>           return -ERANGE;
>>       }
>> @@ -1192,7 +1204,7 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, 
>> int type, int func,
>>       /* Do error injection */
>>       rc = opal_pci_err_inject(phb->opal_id, pe->addr,
>> -                 type, func, addr, mask);
>> +                 opal_err_type, func, addr, mask);
>>       if (rc != OPAL_SUCCESS) {
>>           pr_warn("%s: Failure %lld injecting error "
>>               "%d-%d to PHB#%x-PE#%x\n",
> 

