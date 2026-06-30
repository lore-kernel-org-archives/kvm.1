Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93863F58F0
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818046; cv=none; b=kBcWJqrG7xXowTGcvB3kTDqX16p5aQgMWNXTJwTdnx6jkDt6fkraTW0XQbsoJBZT5zvgkzGpjFLvLkNreOFWpG9XmlHUeo6RJUil1AUE5Zi4zHQyU386Hs4OiAKVQWFyM63Y8asx+sCo2Cw3nRCRW3zOdIs4ayuDfNE+6P8Ystk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818046; c=relaxed/simple;
	bh=xPjRU+I6qvKOn0jkR5t0FxVS8mo7n2Us/N0cRkmBboo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iltwM/WIoVg0Ztbqy7khw0HpJnD01jMW5zsK5SKl0b6JAxDp7eFBsZCGfwWMRVOuDoWYlE9b5K7BncI9QypnTqEs8zfnlQoB3cKgdNybvsZQ5ARFlDTl3Aj/LS7vyDukMvwGYqMAbA0DFFvwfLS7olPAwvWl9k7YqLs5MteXFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VoAnWFGd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VoAnWFGd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nIfo1535020;
	Tue, 30 Jun 2026 11:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=My92Za
	oJKd/ygESrX+/ZJAVsKvZSumekWHhLhIjHJ98=; b=VoAnWFGd+kv3ZGkrhk4z2P
	5HqH4slHoh1FxyC9ChdqzmuYI721Z+OVvwsxvcupJOZ4sUNvT4YqEx037ZWS83ax
	Nmxf8+riQfASZEjleZWSR+uQsJSgg54I+QycE0KfJU6nHNN+q0YQtudE/uB3/dpl
	6AZMj1y6HFcIv51Qktn3AkyyIMUx58BYD3sNze4OP+bUvIAgjgNREopuhLYUcj6B
	Zf21uUa+9ZvQ4TnjZED+ePhFuDRnpMN28LGc4RslrvcmjuVrRqRz65zmiRpoC7xR
	ls0Md3qTjkOTDeS3H8xOn119xU1nEINM9A77YBSnuR14/ipapBDPTsGzkMOFs39Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjp317-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 11:13:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UB4ceC006919;
	Tue, 30 Jun 2026 11:13:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy9m5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 11:13:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UBDiOe18219332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 11:13:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39BE320040;
	Tue, 30 Jun 2026 11:13:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 983D72004E;
	Tue, 30 Jun 2026 11:13:39 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 11:13:39 +0000 (GMT)
Message-ID: <b5a7ca45-e94a-415e-b08e-040c1e69d8a0@linux.ibm.com>
Date: Tue, 30 Jun 2026 16:43:38 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] tests/functional: Add remote interrupts test for
 PowerNV
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
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
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-2-adityag@linux.ibm.com>
 <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
 <akJXAebIn7BHhPRS@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <99726741-229a-4230-b19e-63a7f27ba9f0@redhat.com>
 <b489fbd0-a1f8-429a-90f0-9ed950cfda1a@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <b489fbd0-a1f8-429a-90f0-9ed950cfda1a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXz0aStE6/mYdf
 LGP5QFaTGqlRi2OdZJwwUsUAI/63FWRiSUBuyiMgQq4ezqWw61OKPLfTUwEpKUutr1xgMqk4vd5
 8USS3fqbIGNcSsCjJjVgqVijJmstMf8inJYsJZbr3gc4CwUGmnTstAcDHE1M6MWZTAH/+u31/Ol
 jbv7NX4WPTOVnRX20EurmiakHxcK8wYVxElEYa6grWlOSHDuHG8ENTh2ZsYZ/uGwG5pcyeE08iS
 Si1oSvEjTsXpXx+Fh0dxXt8NQxNrNLhtpZH5HipB4+zMv2SUc4muPy31IdxAa+iJM4xLvmYq0Y1
 C8Jpy8DiLSxC4h43bB9o6GfADTdN7GzHDnQg/xQ6e2IhejX8VjP/1nuFwxOr+EL8Sb+ZT/iaL82
 Lbmru4spm9774aRxMzyiqA27aKBv9UOfR8T6f02c8nba7Aope+4IcgFAxdu0mJ5xKaCIbn2EH96
 s5F4xykOMfV4BPQ8XfA==
X-Proofpoint-GUID: KWZxX_JVluCUsuCuIGm9Dm4XzzMxgij3
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a43a4ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=1nMXlMbU5ZgYPpbJ5sEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX/TJ/inclm7H0
 e15TnURuCf5xHgSvUqFwovxS7axDyIg8lVX7l+jBpl90wSyGoH+4WZ/EwQpkdTzKlr9UAkIhEe/
 28ltUv9/MPmTYUrcCR2wfKjnYbu+u1c=
X-Proofpoint-ORIG-GUID: p4zUcnT3qRk9_RCIU0xMzaADI31VBLpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

Do you have any further comments before i send a v4 with the #include's 
removed ?


Thanks,
- Aditya G

