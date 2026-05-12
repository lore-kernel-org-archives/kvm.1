Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F95384CEA;
	Tue, 12 May 2026 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575045; cv=none; b=HKPaNkqddqDOZeOYMEwJ93LU7wdihdD1iIfGGeVoZhjcNElaIHYNYtK7B5zdQy5Wn5iwb9QpLiHHBWycsysUwFDlDOYH83H9JYSvZaS0qxAaysWylqdAU+wy3ISzg4t1w/bMGBqdoAzrIOkzz1Ika5o29CUZHXFfWNQODwucNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575045; c=relaxed/simple;
	bh=CxI3hTEN9P2Vac3nRPnVuEbRdVThzgjwwPJjqKfx2Us=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFglfxhGJqBgRhnwC/U1oQDYaJDR3KxfdVxEIL/ZAro2qUoEOrqY9rsyKLVulj86ymo2l+CLNB38o58ooYsOGKSSPdrIv+13PtnOnuR4Z3/tjiwcfC+EkVMSAwujEdksRQha72HOGIe8j1l7OiBATRcTZHVVqWHp8pBldh4bvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JFKfrhPq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JFKfrhPq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7H352760537;
	Tue, 12 May 2026 08:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=H8gZvhDiJcfPj4izdPoeTyKzYez876
	PA3k9XPRRUrF0=; b=JFKfrhPq8nUkfghkSxPLnz3TlK6envyHBf7rktLvSsXHmy
	iH1t0d6K4J710TpSKiT8tF9xje+oiyMy8ICvD6VMeIcSTcCn7NCtgOA0mj70X+Bl
	SDP6eWNiQ6MOqJ37gRiXulrHHDWpjKnmelcjgVSxmGkdynJ3AzQ7j6sBtuJJT4eK
	NntESoFIr/UIYKAe4aVr8qNbn/IB/MoR8M7KEN5ydLcAuet5pbAJgwSxazRbuq1l
	CdDSzaXZS8UacvRj3C/IQJf5dUikwWKwGPZfvA1MuoCqH2AA4zNG5vkYFLY88ddF
	UhbhTD5RaGfpLjM/k7jHyd+uK+IOxAMXs+OYBD/Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6j24w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 08:37:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C8OXsn028662;
	Tue, 12 May 2026 08:37:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjb95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 08:37:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64C8b2S325821758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 08:37:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD3A58059;
	Tue, 12 May 2026 08:37:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5EF458043;
	Tue, 12 May 2026 08:36:57 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.208.192])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Tue, 12 May 2026 08:36:57 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Tue, 12 May 2026 14:06:55 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for
 tracing exits
In-Reply-To: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
References: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
Date: Tue, 12 May 2026 14:06:55 +0530
Message-ID: <87pl31uiqg.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nU0nISuR4Dqqy-ix_PCeP0TTyaIL8XvG
X-Proofpoint-GUID: KMAjbdqZw1a388q652BZ71xGUDq0AL35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA4NiBTYWx0ZWRfX21zcGlj/4oYi
 +mHmsCfhLL7CRqOq08J+bp0jRQxj2DZRsLgEdY2C0yOhPCupP7StLghLuZt24lFKu88cYDEFNYN
 djDl4gbF4nwyUdZf52QOLQRwOmK2EMpqWqPBLPmPhzQQYI291SOP+xWTZS0pWvjP/1+/kUxluR8
 +Qrq7zMHBSddBRIo58gtVOWmMpGGIofs7rgre+LFASvPyDXtdfP14Xh47vklkDbN0l37zt0byWP
 CItPw2cdJOE2sk9czVpq45oRgpBej1dY8x57TQxOFllQBMspXtsoKCaPvpoq5OHISKoPhoGBIEI
 3bVO+IGRTsr6JH39wzILWTvV6rFH1GEt+5uYg3ei22BpjPYeewEO1gQ6GsEuFWbJ3RK6OLRvtdO
 TyshK9C+55j4tWHXSEC/6sI1XfLaG3zfN9viq+LdoIcpmgsKwikwYweqkWfRiARqrJ6stPYZKSW
 XhR8QpQozFN3Qf/+0Lg==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a02e6b0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ycv1Ynx4oPle2U8RHYcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120086


Thanks Gautam catching this and proposing this patch.
Minor review comments below:

Gautam Menghani <Gautam.Menghani@ibm.com> writes:

> From: Gautam Menghani <gautam@linux.ibm.com>
>
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
> trap reason is displayed as string instead of a vector number when using
> the kvm_guest_exit tracepoint.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v2:
> 1. Remove the trailing comma after last element
>
>  arch/powerpc/kvm/trace_book3s.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
> index 9260ddbd557f..5d272c115331 100644
> --- a/arch/powerpc/kvm/trace_book3s.h
> +++ b/arch/powerpc/kvm/trace_book3s.h
> @@ -28,6 +28,7 @@
>  	{0xea0, "H_VIRT"}, \
>  	{0xf00, "PERFMON"}, \
>  	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"}
Also add trap of 0x000 indicating "RETURN_TO_HOST"

Also sychronize the contents of the proposed changes for this header with the
libtraceevent header file tools/perf/util/kvm-stat-arch/book3s_hv_exits.h

>  
>  #endif
> -- 
> 2.52.0
>
>

With above minor fixes done, feel free to add:

Reviewed-by: Vaibhav Jain (IBM) <vaibhav@linux.ibm.com>
-- 
Cheers
~ Vaibhav
