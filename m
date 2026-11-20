Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167012;
	b=fRXeg/exmrIAvZaPoOSOISXGaYYwySgsO+nSg0Lde/7vKLrSTs8YaLautoW3vQWchGDN
	 DDqsL3uyuMBgLRa5SaIvP+9oTqR6VWEAzXpXSxIaqy9W17R3rSYrzSyPnALYZagQVXlPC
	 /v24GXIU1a3QXYwnY6wWVoDVSwUQJCdgb64+iQRfBwaCSTk5UfU0C03q2LN1upuhawIBT
	 5rKquki6Zl7ULliC0Xa6XWmBzUERxA+6YDNpffI1uRRJwt2oEhfAObkCt/1TBRz2VAiyC
	 o5sDrC1S+QdDdPAWZmqpP/cdNN7Pta9L5DoblKbFsmL1XnuXKIgZXGxMesLQkO4wBaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167012;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=V9pATyht+zzlh8iKmMje1WGu+X+9da3pJjQWiWPYMyY=;
	b=raub0Lx3G5cadTbwESjR1BQI2b0+iAcrbV1UcM9JsemBeGU8DR2//wJoLNBMxAxIAYqU
	 iS614H6FjUqlagHTZEIgX+ii6VA0Ce3zdL1yh73H+TSbXLRqyJN7nSncdwxAf/vavzv56
	 ekwaWQw+JZMltUrSGG+CJj26ps2b5ktLOaiVJTBRVYeaiAVF7+KV/tfFk+NtT56mS26WG
	 PvTX5UQSOOUKsDmTrJatmoxSZUdMjz78Cs+oMATx2FuozELtJ+JgH8nlaTCnbKIU6vumd
	 4O335x/KEkNczsNrnxhEoqBzudk4ghHKi6aiMd/WKGpv/5+8xeKRIVa7WV2ajdNdTYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R+bLnIVY;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8166D606A330;
	Fri, 20 Nov 2026 09:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8166D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R+bLnIVY
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7u1nu2648953;
	Fri, 20 Nov 2026 09:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V9pATy
	ht+zzlh8iKmMje1WGu+X+9da3pJjQWiWPYMyY=; b=R+bLnIVY9rOS4yxND13PA4
	fti6lWHJieU7UR42N3o9VaB/D0HLtgksEp9tRsdtKja+bJ3Dn8RV9GdP9CtNQHsz
	t7IFDHDkO7PuLQetDZ1nlaUMZvWXSACjigYySdbPbUBTjUUgQLujwRvpbGrYACp1
	/Q8btaGFLM4+xSDz8gIz1D4+QBlL/Jh3gpBRKEAT33dV3pEAyLkjzV9i7noZCw72
	8HD5FvyYYJjsAvn0CSxbokGfXNWI/SlYAtARkBvG3/BUiizne9A/Yo4IOLSMAdZD
	oQqEMyF+LifvpM38OV4+pU0V7vPhYKB8Jhfe0faAc2Mmo0VPhlca4+6lUxqr3Wpw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nqdkt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 09:30:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7o3uY1951636;
	Fri, 20 Nov 2026 09:30:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3j1abb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 09:30:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK9Twpr37945746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 09:29:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ED4E2004B;
	Fri, 20 Nov 2026 09:29:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A418220049;
	Fri, 20 Nov 2026 09:29:55 +0000 (GMT)
Received: from [9.111.50.236] (unknown [9.111.50.236])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 09:29:55 +0000 (GMT)
Message-ID: <c1f4764b-884f-4844-868f-5347c7d71fb2@linux.ibm.com>
Date: Fri, 20 Nov 2026 10:29:55 +0100
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
Subject: Re: [PATCH 3/7] Documentation: KVM: Fix the function that implements
 halt polling
To: Fuad Tabba <fuad.tabba@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
 <20261111085448.1130701-4-fuad.tabba@linux.dev>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261111085448.1130701-4-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfXwWdzv1CH41LN
 8/zCVD+nEpbifRvkEI0flxDKgvkR9ASjHOL9vaIZuHpyC8TgOzXZXY4lAAqkB2N1jbS/5yOChpJ
 n2RS9h/CCUW1p28+qD0iEPatH/1TwyebmG6Mcm4m2uvginJPeOAWuKp4mzW0KpMs4a8BURlAfla
 zf5gqRCCz/rgXO/TIw7hPzo6OunVJmiJeApcugsDGQscY/UK1FB2SCKXjOMWoZl6FDVlh68L1Ge
 nqzHcM7EPLu55l0Cs50MZAxEWc+IvaJUkpUGQNihFUO48AVo0MF+PSBUocT9/jlB8bECQDNIKZ1
 p4mVcxRhe6VcwLYK0QoNuXf3qtMSIOw/5d9Jbd2+x8gRrAJTRHToVv/1xwcpi67thCqGle+swGo
 wq+IpViR4SCjatS6pfTJa1q8p5ZFWqhX3Gdy6hr9O0gf/MoV6Jv5wOMZ3qbij5GT/M5wYR1tZ7C
 yWoOV4uCFg0wFRox7Zw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6b00131c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=JMxS_pt2InJvb4wTJLEA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: 7uIP5KddXKm0EKGl07up1bv-p5Fzf3kJ
X-Proofpoint-ORIG-GUID: Rwawl2F0CDmVVDiciCZNfqCZYYZDdIfv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX5RTK0GdPKZ/S
 RUN0l3w4woLWIdCR0P7P3XSw/9pc9IkZ2e9kj0jtBxkuBVw7Eih4SF+alyqEIvQP3dwgKpxDg5y
 0nxfsKkAQL0LhKmdE42tq2Fj6fONd3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200037

Am 11.11.26 um 09:54 schrieb Fuad Tabba:
> The generic halt polling code is in kvm_vcpu_halt() since
> commit 91b99ea706578 ("KVM: Rename kvm_vcpu_block() =>
> kvm_vcpu_halt()"), but halt-polling.rst still names kvm_vcpu_block().
> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   Documentation/virt/kvm/halt-polling.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/halt-polling.rst b/Documentation/virt/kvm/halt-polling.rst
> index a6790a67e2058..c311aac1ff9e9 100644
> --- a/Documentation/virt/kvm/halt-polling.rst
> +++ b/Documentation/virt/kvm/halt-polling.rst
> @@ -22,7 +22,7 @@ savings of not invoking the scheduler are distinguishable.
>   
>   The generic halt polling code is implemented in:
>   
> -	virt/kvm/kvm_main.c: kvm_vcpu_block()
> +	virt/kvm/kvm_main.c: kvm_vcpu_halt()
>   
>   The powerpc kvm-hv specific case is implemented in:
>   

