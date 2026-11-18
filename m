Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030934;
	b=wtN5w/TgvCx08cOONvkmN1uybuBItsNVKE8+2LC2qCrtSBqyvss2iEhDELnPoLDNqDeM
	 XfCr4Zyvm4NC3g/7DeoJA7D128fOe9WH5l46AimjU02L9Mp2Cx4jDCaWTNuoWZH0ntKFN
	 uTBJJPk+TC4S6xInCQupPWbjTtMEq1roeBRjYXvT6R8oskvoT2RssKBH/PetJpRSZCRgK
	 Sfwo5Y8UOxNG8wR2uBjVPuXGC05hEOdwA3aHEsmK1gioqzKw5TpDYqTxAgzejsk2z6F3h
	 KMKxde9fenDtNEJStou2YAehIKxvIialu6WL3sVWFNXmxrt5cTrtrEtOppqKTwc9S8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030934;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZwkeXhoNuf2KPdjEfw4sg2NJFsMy7sV1rDjpKTrhj/g=;
	b=ML7g7ty8I/DI5dFU3saFayJfprvEQpIK5vzBBfmcdTAwKhcD+kylLbsn+1e5Q7hJt2tv
	 m7IDxddosvHA/osvgVhi/DcCEwKx+T43PGjfJWLbtRwpMtmz8mLX4E9oU/BExlvxHI4bi
	 I3IPPvFXs6Mobe/hLT4AaLwLVKh5CLNm9oyr90nNxIkK4sl2zci8TrHb5/6Z+8Mk3ueAF
	 qoS8iKz/RYARZry80echBMXUhRsiY0flvUeJSBkLmAd+Aoptnv3NglmWztY8kbwdrUnmG
	 KPat9m66xPelDimGTvTiM452q5d1cWHrW3JTr0aVffziA9YZMs5urdVORmlt+l2boCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MqRX8LLo;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767A606A336;
	Wed, 18 Nov 2026 19:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2767A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MqRX8LLo
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIJQ9Sm755960;
	Wed, 18 Nov 2026 19:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZwkeXh
	oNuf2KPdjEfw4sg2NJFsMy7sV1rDjpKTrhj/g=; b=MqRX8LLorA35SpP2mwQbYx
	7179nv1xPZ1GIzqefkbFUIqw5WxhoIkcOjyUMisBTjYuK5n1ZXx6cg0ItNBPjCKQ
	PRhBauw6hUFDes1o7EUWvIVZtokj4QGVxD/qcKwDayybix4Bblrgm0gNGOjsMpBO
	h1ePHO67qco/qBu7Cm7vH6MsvXExtaY6hjqBs5rX9rDMw925seHr93O1r7OY55k6
	k+caNOIz/PMthUuWtHa+fvbVhCLE9nb7V+k9BY+QZZbY+9GJ3vKzp3iuDYgCItPv
	uElwjfkussuIKyBAkl2z0SF1AfvWW1SPK9qMuIXtMSZ6eV6YGlBJALgabFGNk/bA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vv5ff-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 19:41:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIJK45s3854450;
	Wed, 18 Nov 2026 19:41:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6r6y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 19:41:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIJfrcY45547844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 19:41:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC53620043;
	Wed, 18 Nov 2026 19:41:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7B0420040;
	Wed, 18 Nov 2026 19:41:48 +0000 (GMT)
Received: from [9.39.20.8] (unknown [9.39.20.8])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 19:41:48 +0000 (GMT)
Message-ID: <2ed69cf8-eca2-41ed-a100-844f9d84c2ad@linux.ibm.com>
Date: Thu, 19 Nov 2026 01:11:47 +0530
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
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
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
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20261023073642.59657-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dD3dmLOBGgk3P7MvaFjHXl3PaL0cdUFu
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afdff86 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=b7QKy6wA_HDc8uP7B80A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 24-5BvSMu5bUjEc5gTmCj54tFA2Il3nN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfX+VaaMvH9OC22
 X/BsPWKxhumCgqKsNQEp91OA1GWrXNi2CBC+ZAvXNdVyEpHajz4O/10O6jvHVYR5+XgtiSFTFoJ
 DDSjrIZuGO/++G/tAaknwFWzZ/ulSxE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfX0kxVU6SDNxfA
 H5U5y1fqFXmdCQzUpajVMRASJjdQRlw6DWTekL6xN1Mupnfzrm4gU5t5Diiszm1lz1mC8tbN/2w
 UgzHWwiuwyhRsY2iJzXoQWQLqz7LHLVjLegXZKUO6TgB107TrCtKp5LBnV40QCPcrGJehvRHbh3
 XR60x2Z+QuZZueMkVVj70a5eLQU3d+HJP2OZ5AkKtYcHliUl3OxPQpTxIbrgU+vkdvjwP01W3wH
 jHHuZWjS+hT1Qnzari7rMJWRzQ/dtErfOsLZ1qGhBtddeglTquNhnZm3rm3CPJa4BNtYuP3ZrjG
 8RiGu7HhKar0Y8DbUv2D1wHsigdab7xQ5AGU5FOyIQleg7YfUUizj/2h+/VmW6kcfmMGrfrFAfa
 hZNeAMs81jPgnxPDoBqMD/wHdGvrBkKMHxPi63wdy0ZRtyz/IcKGGi8PGYXYM1Uo87cvT7FzMcB
 6UDZZb429Z+xIehEJPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180076

Hello Narayana,

For my understanding, could you clarify why this change is needed as 
part of this series?
The series is about enabling RTAS-based error injection, and PowerNV 
doesn't support RTAS.
How does this change fit with the earlier patches in the series?

On 23/10/26 13:06, Narayana Murty N wrote:
> eeh_pe_inject_err() is called with generic EEH error types defined in
> the VFIO/EEH userspace ABI (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64).  The
> PowerNV backend previously compared these generic values directly against
> OPAL firmware constants (OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64).
>
> This is fragile: it relies on the generic EEH ABI values being
> numerically identical to OPAL-specific values, and would silently
> misbehave if they ever diverged.
>
> Add an explicit mapping in pnv_eeh_err_inject() that translates:
>    EEH_ERR_TYPE_32 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR
>    EEH_ERR_TYPE_64 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64
>
> Return -ERANGE for unsupported error types, preserving the behavior
> of the original code.  Decouples the VFIO/EEH interface from OPAL
> implementation details.
>
> No change to existing userspace ABI or PowerNV behavior.
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 22 +++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index db3370d1673c..01dae760cecb 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1167,12 +1167,24 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
>   {
>   	struct pci_controller *hose = pe->phb;
>   	struct pnv_phb *phb = hose->private_data;
> +	int opal_err_type;
>   	s64 rc;
>   
> -	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
> -	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
> -		pr_warn("%s: Invalid error type %d\n",
> -			__func__, type);
> +	/*
> +	 * eeh_pe_inject_err() receives generic EEH error types from the
> +	 * VFIO/EEH userspace ABI.  The PowerNV backend must not rely on
> +	 * these generic values being numerically identical to OPAL firmware
> +	 * values.  Translate to OPAL-specific types before calling firmware.
> +	 */
> +	switch (type) {
> +	case EEH_ERR_TYPE_32:
> +		opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
> +		break;
> +	case EEH_ERR_TYPE_64:
> +		opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
> +		break;
> +	default:
> +		pr_warn("%s: Invalid error type %d\n", __func__, type);
>   		return -ERANGE;
>   	}
>   
> @@ -1192,7 +1204,7 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
>   
>   	/* Do error injection */
>   	rc = opal_pci_err_inject(phb->opal_id, pe->addr,
> -				 type, func, addr, mask);
> +				 opal_err_type, func, addr, mask);
>   	if (rc != OPAL_SUCCESS) {
>   		pr_warn("%s: Failure %lld injecting error "
>   			"%d-%d to PHB#%x-PE#%x\n",

