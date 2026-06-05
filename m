Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77333146588
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648547; cv=none; b=TkFPuLBpyGUnToD8sISseCNGotDjRNAUoAjZVXQGDfXaMAoo2JcFFmMVt5acxa+5jVakLDXHndzA/n2fY3EYiGlwPAQabHb3vu3Fs4UhwOaKH2c17m3XqmoNsBVIzd2kVePlJhoIPC7WTsfooEJS40EV+Lcb0DNw629ZyKIJ2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648547; c=relaxed/simple;
	bh=lz/atQq6KStQh8U6xBfmp+khBGYPURd2L9nazoIfSAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbKpXbeJERuSAmsR3rBEUELmSPuJH9jc+Sgn1NOdZvVKMOyDoojVFQqWUMHOkn2a7qvRXxI5ink2rN4E1E9PzVqcCkazuSRzbgb7BNQV7F0MpGIk6j2UYvdUqmlz4j5vJYvgnUSiRWXdh4C57HBuPqpIV1Ss3yRKP+pmvpBzxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZV8FR6Iy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZV8FR6Iy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6551GJek2252299;
	Fri, 5 Jun 2026 08:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/bMthG
	QpBGrvZ1yGYTEDsg+MJuh7eQn1ERPWn07vDh0=; b=ZV8FR6Iye5OhdItmrxHP/j
	Ku8suE1pY4E0T31hZsTLRJB3WK36MR0LnHSB/cbjIEhupWStqcmJKuGqJdqH1BRw
	GcrRBujjhTU4+hIICkFi2l8BJDSTn6kyZ6NGkyp1BeEaOaWEnRkovNMogLrwc6z/
	laYwwc5kxnfCzr8TtnZVDx2zJ0kZ6L+FSX1qrveNwMOM9FqpPLWExf2s3fPMny8R
	l3Y4pZdOYll2vpiQMJ2XThwk7tjcBj6ypPwgjCxjNRCSucA8eZW8oTNMc2JYrzGw
	av+6A2f9rprdhBb5y8o81miGmu2bGu2Srv5dcZoRqXIdKNWaPfAy83Hdzv6vTCAw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaejxn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:35:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6558O7Gi001814;
	Fri, 5 Jun 2026 08:35:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kgw4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:35:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6558ZRKC34144848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 08:35:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26B7F5805F;
	Fri,  5 Jun 2026 08:35:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00AE45805D;
	Fri,  5 Jun 2026 08:35:24 +0000 (GMT)
Received: from [9.39.25.43] (unknown [9.39.25.43])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Jun 2026 08:35:23 +0000 (GMT)
Message-ID: <f7d17628-9a46-4a9c-b2c5-8dca05ba0eed@linux.ibm.com>
Date: Fri, 5 Jun 2026 14:04:55 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests RFC PATCH 2/6] configure: Make arch_libdir a
 first-class entity
To: Andrew Jones <andrew.jones@linux.dev>, thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-3-rathc@linux.ibm.com>
 <emxfxob3hs2kqjmdbtucwr65dlywqapsz76ow7ebnqhf5vmrtq@i2wodbzjs5cb>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <emxfxob3hs2kqjmdbtucwr65dlywqapsz76ow7ebnqhf5vmrtq@i2wodbzjs5cb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a228a51 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=3-C7bj3rQqdJ4O3LgvEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fFz-IzJsf7ZaJA3Qizz_hBCSqDH74Vj1
X-Proofpoint-ORIG-GUID: FZwyXgCu319T8eVsbqEKwGmPfRI2awcG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3NyBTYWx0ZWRfX9mRCAEeE+tQn
 GW/bpB45D8a8o+l4oW0qDUJLQjr3QqXefCF3TYuMltn6KNzvAC3begRBg7TwDOnfBHclGKBQIsn
 wpOu6ppOX8a/o1mJQ+cOlMh1MAYrspszyo5qWqHbiEeZZeBZjLA/KxC2CzWtnR5WPyjzj2afMd8
 upoTxmOPGKM4dZMtU52c6XMbJwzVNqBDXTHPs/S3gFK4Qna+EibTdPZkEuM1BaLDHkZetAgewk3
 Uk6MFcdjqG10F0lPwTzXkEtCsliRQyC8LqyNR8tMm8LA73iwR3t5k5H41+wR+e+arL8+2oEW/8Y
 wOfEl/WDHWVcNyzmrvr51gAw4iSYa3gn77RNM5Jlguqyg8jdkps2nErEiEl+kj895xH4WjCDoVS
 BiwZt3SBWCm1JWCuMJ0Tx+UWmx4r821mNSiQbJPZztDD5OluzoNmlaQsCnSEeBe7vZBHBV4kPuf
 Iu61UveTgdZp25MSIww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050077


On 6/2/26 21:24, Andrew Jones wrote:
> On Tue, Jun 02, 2026 at 12:18:02PM +0530, Chinmay Rath wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> arch_libdir was brought in to improve the heuristic determination of
>> the lib/ directory based on arch and testdir names, but it did not
>> entirely clean that mess up.
>>
>> Remove the arch_libdir->arch->testdir heuristic and just require
>> everybody sets arch_libdir correctly. Fail if the lib/arch or
>> lib/arch/asm directories can not be found.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   Makefile  |  2 +-
>>   configure | 20 ++++++++++++--------
>>   2 files changed, 13 insertions(+), 9 deletions(-)
>>
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
Thank you Andrew !

Hi Thomas, requesting your insight on the un-reviewed patches. TIA.

-Chinmay
