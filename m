Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160445;
	b=L+VpDKuFhkGuZwgn4lPL/TYOaNAEgB5IHmpv1OfT01lHSy9rT1i4voUwZYY8yJByTPl7
	 cgiFuC0SY5T/ODBZNBQeojchhlCCoZBB94f0ur5Eoq0HItXFrtZGDVIDNfI1ObWHV6Yb5
	 w9qGFRrhlJXTGg8GVZUlJ04fvkTBJ0tqbjcgTEpvXBi4i/fU13G5HFmpX+Z6s9qZXuLWi
	 QoebWtmZKQEMyZO+fs5aKquh5OBO4XcuiTuNzPTRl1ewKKKnOAW3D25NbN31+u4uZNlqI
	 5/JF4/6zE9zxpScs+4FEG8y3DnRk4AypOlB3J/iYZqVmEsbBlZgeoi0JuH8E5wpoCjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160445;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vXp0hy8i8EssNCH31fRKL6Cul/GRpRbRIXs/wnt65A4=;
	b=pkiKYbRC3S5h2+DUMlYYUBNlB+aX5B2n3GTS09KnxJZcxV9qe7F2N+L4HZKfC3HUk114
	 I2nQumUn8NkHqfYoIJEvt7/kn14Nvwh7vDBwj3OhCtvdhXI4cXFkIyZJk9vRAU1zvJ5GA
	 a7DHF+1SV3WY0Viw9B5JQ63s5RjgxwkSLznyPN6UkrvahbwtBzwwTUnQSlxZgGlCjHZxs
	 In17/eN0U4C1RXFfX+4SzncaRkdoJejCQ+N/bFlF2GjUnadE+lhtAtmxxP4tcbZPADR74
	 CirUqJKyZXiTubBixaGscHLtJb1F2zCHfV+OjeMDcePMKosn5jyFgUDQs3/8p40AfWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e1tqSNmw;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274E606A32A;
	Fri, 20 Nov 2026 07:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4274E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e1tqSNmw
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3ueHL2135766;
	Fri, 20 Nov 2026 07:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vXp0hy
	8i8EssNCH31fRKL6Cul/GRpRbRIXs/wnt65A4=; b=e1tqSNmwaAyrwlg7gcza7q
	Hf/bjdZ/M1Zh86wnv9omHpFDmOASN/zFaiQrsvouF15IyHwBEdGvo8OLA5XjDU7s
	I32v83laDSFO7b8QxIQpJNvFR13k997IdChv6Hk6J/Y8pMRZ5liVys8YgW2xRjW4
	7OUD6G3kW6nMu6TbYzUbFfJLi7Vmu1w4qLvMS+8Xf/+0lKNGB5NVY3l8o4OEbGKs
	QyvXYiq885NR7zELusiGEMJKvFcvlF2Pw3ojgjLixbP0fqYznOkN26ayoRfy0UKG
	sR/P6LOyNuunsLKoUhuNLixO8zniSlcJFCL2vqAIa6rN0KHEUn5ApEKdeVA5ujZA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105npwc8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:40:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7CEZd600861;
	Fri, 20 Nov 2026 07:40:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5jugr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:40:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK7eOuv15728976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:40:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACB882004F;
	Fri, 20 Nov 2026 07:40:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DF1420040;
	Fri, 20 Nov 2026 07:40:21 +0000 (GMT)
Received: from [9.124.218.70] (unknown [9.124.218.70])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 07:40:20 +0000 (GMT)
Message-ID: <32518152-863e-4ce0-831b-d4d69caa491b@linux.ibm.com>
Date: Fri, 20 Nov 2026 13:10:20 +0530
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
Subject: Re: [PATCH v6 0/5] powerpc: Add RTAS based error injection support
 for pSeries
To: tasmiya <tasmiya@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: sourabhjain@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <b6a7ba26-e3f1-4dfe-a429-8dd3379e665a@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <b6a7ba26-e3f1-4dfe-a429-8dd3379e665a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXy7B1r++FB5Fw
 ZojBzibZI6xckz2pppZAq1PSuh63OHyb9HReryXRpPZEKVauZF5lW08Bq54wK+8m1oEkb6mBiop
 ahj5tBGcD8vlwsISV/OLaSCYCLwL6E9u53zk4lk4ZmC0Eu1+mKnIAtM9tmHQVINgEf3VjjOuylv
 R+qAlsNHteO1J1tfGNHaHC1bk5W9Ez3Ti5tK2Jyhk9tE3SS4htSJYzVt3itGLvVVGcj9CwGF9Iu
 ZkkeJu9brPGg+qmzfus4yiiBoTc7+SPxkQxH8tX08wBXSks5LcbyZyKnlUzocQ5b4WPjLo0umiS
 MGBqXOwC4CjMcH5N1YRj680R0Ot91b74WKuhl9qe3eTx+7FI5zf82e3FULJyIa2s+JUl6nOK2XO
 P7YmmfT3iSQ0+WkyekELhdDdDI7sRBO8Yn2+RK9FXNe55ogNZBupaGmtQeDiFwNE9yWAc+Q5TO2
 bW6dM+9A9WBqdlK4cig==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afff970 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=16zvxxa8fA1V9JArBYkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H97DVM_Yt6Ct0DG7o4Vqy7xcnja9aFNR
X-Proofpoint-ORIG-GUID: Gn4MdoIDlrOUk-tbAyCDtKSYwoCw11-9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX8T2SDEwp9hDw
 5+//8Os6yPD7YKmIGLa2jWuilP/rM/bKSaycfi3ipo/3XJweBAGZbvQD5W15qOt5kYlJ7mGNI7N
 ULQ2+cHYAeonhxoaBI4f3pDvsbT0Y2s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200029

Hi Tasmiya,

On 11/11/26 12:51 AM, tasmiya wrote:
> Greetings,
> 
> I have tested this patch on my KVM guest environment. I am able to 
> inject EEH errors from host console as well as on guest console using 
> location code for a VFIO passthrough device.
> 
> Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
> 
> 
Thanks for testing both host and guest error injection paths.

I'm addressing the review comments and will post v7 with some
code restructuring. It would be helpful if you could retest
the next revision as well.
> 
> Thank you
> Tasmiya

Thanks,
Narayana Murty

