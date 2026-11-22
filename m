Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323321;
	b=BnblmMeccdg3Tyn+++Df2uKwMCLJrVnJgJ0IufcALLtUYuESNtkhqm0rdl1XO+yMfLTm
	 BUApgR3ET3zSeG9x4gpJvlcZ17YyAZMZCeq0+/RLgDg+1yUKGMt4hify2+ZrxHdi4L6FQ
	 MOCtXI+BJNGgN/nPRLrKr7ij3qC8o0CFaQBnApIblEfK2MaHfolOkT1sfDZ9y3LN+HRdB
	 YHLbUwz89MGbnlvm2aGf3SdjzuaccLn4CMWW9EoL4UrC4TB33n0PFLbaJDO9ceTRVe8gH
	 kmgskmaUJdjAe9m6l0VfZabfih7nOcVVUJC68P0TMUlEPnVuoAcA+uatgHXB+CRWUwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323321;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kdLauVpY9Yo6pj5sNKVnpV0+CPCa6XuOMaRpyST6pbA=;
	b=QlKJfuRA0IZ1YPaFK4ymfU315Jg/YgaWkoem87ACuk8YQKZpj1iYKc+gfU69fsnXw2bK
	 FcYNqN5aqQl+46sm20E0lwX0DQ2hbs9RtUW0N3vWm04vXae48Ix4fNzF7nDy9WwVrvFLf
	 C5s9j34aWBF0ZgoTdDukYxwc4w01ohO/orANE6XGULV+YzfCPuKExawURoAeWSVvIqn+o
	 RKo2XLzvqHR1Ltw/8gbRhOK1WbLgH9XTTqj/2Y2PPNzx0AJA1s6sQe8D2FU0q/aIoHkXP
	 NfBHLMEt0Nz3khFzAtjTihTlyh39T26s+MIbGHUf4aCHrUCykoH1FAVPmESTFmoxROA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W941NW1a;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFF606A32C;
	Sun, 22 Nov 2026 04:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15FFF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W941NW1a
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44cKC2469571;
	Sun, 22 Nov 2026 04:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kdLauV
	pY9Yo6pj5sNKVnpV0+CPCa6XuOMaRpyST6pbA=; b=W941NW1a5s76U6iuaWXtW6
	xpGpM1xk8JB5TXPvVfLhuI+qf37JMoVvP7kQb3ViZYiwmDqk7H1BZnBXGPGaR54q
	UsGdPst9t6gSrnjMeFw4cUAfI6ZWw0CsSKVmSvDJ7Ee96DUA386BroI53DbPPbJC
	UQcde6/Nww9FLes/wqCUytSu+zclyg2walG78b50UL694drsSV414Hrg80sgOC+E
	wCl00hYDYNxhXIkRwGzqKwh1A2zMf55O4D8U8PPVNcQlA3auu/7NNdGSvkJcDTmv
	RIozOpajHnxt/Dj1w/ZaUo3Up8Xrz6trLFZ+sz3RCLC+CcjFuI5NFQXOprotcyEw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p44rst-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:54:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3nYe0810579;
	Sun, 22 Nov 2026 04:54:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h0hjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:54:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM4srJ041746720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:54:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3888220043;
	Sun, 22 Nov 2026 04:54:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E806220040;
	Sun, 22 Nov 2026 04:54:49 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.90.96])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:54:49 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, farosas@linux.ibm.com,
        Haoxiang Li <haoxiang_li2024@163.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
Date: Sun, 22 Nov 2026 10:24:48 +0530
Message-ID: <179532322364.92012.7986778361768910539.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118102012.2252221-1-haoxiang_li2024@163.com>
References: <20261118102012.2252221-1-haoxiang_li2024@163.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX5y5VOp5v1df4
 W6PJPQAHFa68FjOVGvn5sjfql9qo4ZvnuqvbAIpSNlzyhBvOJzec/6TNh1vHxM9GoE348j5Ms2f
 MnEWtimaI6qlNIl40JUY2WWK1Dt8FWE=
X-Proofpoint-GUID: X5PVK69_dnM84_fl8OYqgTKUcdIIPg3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX5lMeTnyJDl7L
 TK0HMIYYBuq0AeJSJHY8SKXuXrxyjNIGOm+y+HdpHnI57bLS4YzJvaE6ru6YXOiWg7fT0R5M1di
 u9ZViP6wNso/gbVtvL4l+K2Jc9LjOB+mvpNIP+7KdbqodLNie2NuSRlyTAzIC9NNaotYiBgTYez
 knQhnLaCNQJFf1m4xbRnxk4wRzO6g+MZyiI2yeMcuWiRX1A50IdOhcL5Pq3aDgda+D9uEYHC8nn
 N1e5Iq4cXY2SNwP6U6KvVa8sMbxtKfVSXE4ytWpppoL+TWJSccDB+du4MkArkoq6IQjNXZOArPQ
 0h5xiEXGsnevCNOvUxik6/p/oDBGdRI0HvkUd2kU3pSjEdmZbioGG5FoXdIF4GWop34jfs56o+U
 L3ATkZp/qBtyRxB4DMjIZMouwxNYB/Guzfub29diRaAnzaneGX1LlrblzvSUq/FfUrlItMrkZPL
 2KzjM9hMEqAnDf6cKVw==
X-Proofpoint-ORIG-GUID: ekAhA9xlJfu9pb04B5umrzg9mpm7V3yj
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b0275a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pKdLQWa3WuirC5Xg7FAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220018

On Wed, 18 Nov 2026 18:20:12 +0800, Haoxiang Li wrote:
> When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
> directly, bypassing the existing error path. Jump to the existing
> error path to clean up before returning the error.
> 
> 

Applied to powerpc/fixes.

[1/1] KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
      https://git.kernel.org/powerpc/c/e721359e5ad0292d93bb9779c4b09fbeb681c266

cheers
