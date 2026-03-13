Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E638CFEA
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411743; cv=none; b=IV/5KXBzPD5TTRAiCNYUAm8Yz4563PiSFuEHzUjYslerZ2Mi7YfJM4Jg4/KOmAiM5u0FLUT66mODd2OoByklq7P8xRkHZJuxItqirkSAPPePQiBV+LyveOWgaEssdbhbe9/G3cfefLcJ21czg+LQDQK+RzOiMxWmIXpk0FizVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411743; c=relaxed/simple;
	bh=qs+FeU50DrlvqhF27orPwTWo+s1bAUOoX6Y3YglXETc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=J8pgL2DZwbJKyNvHJ+/iBd/xdrFhENa4/RXsA3euHLmH2WR3Xi79pP7TjUzjpDflbnsqFS7+VTx34jw1kgYM3cXKls2yPEvAXsgl0fpctamUSh1oxD/wHCEZ+fJjV3QyOTR+6rS7/z3t5wJOEjia05IpjMMBdRF4FkoqvooWGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=csiaSIRJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h+9rvb2L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="csiaSIRJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h+9rvb2L"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D9TiTx1498953
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 14:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qs+FeU50DrlvqhF27orPwTWo+s1bAUOoX6Y3YglXETc=; b=csiaSIRJZfSYLPYA
	OrDIRC1jhNz96DNbH4FgjgNtXEk06/yjZyfbyDL8yH+010LGfAbN/1SJ3/Po24YE
	HHlDtbCDvHuxPyoZitbxXcFzqaEzrCFwcNcf3oJGiS4HNZaZC95RC/CVRzgSSrxL
	n+e3yegRuYAVPYp6fvqm4RDOmCoDhdhByr8kx2p9eOBCYHzb/sQhogV42oFLU8z3
	W60tQTewvGrjRV+dmK0/cKLFk8fGCQr2uWD39SmQM3gXripaRMy6ucknAoHYm6CQ
	2UaZksqdljY5jERkLaXws6E57GU7ooZqzWtRe5wlcCO4Uy/dLoO1eWCrs3RAWtxg
	Ou1FSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvg0hgx5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 14:22:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7a25c5a9so1219008385a.2
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773411740; x=1774016540; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs+FeU50DrlvqhF27orPwTWo+s1bAUOoX6Y3YglXETc=;
        b=h+9rvb2LxHk+fo28jtMJLv0o3l/L//rkKb57DKr9ey1s4IKkl9sQhp1gA3qKpkrcCH
         pB1g4M1EommcFWrl2KuFZd48tyo6yJsBFeSY6QOH0MXgmzeHTS+Fyugp81+3ktZzSdBX
         KPcjxQRmjFI82VC/YwuzoA81clw7OtwUU23v6BkD7/o3RH4PUexn9RouFBYPNSRDbEza
         3tJC4K8u10/CO8hIVWuAZYh6oE7+XUE8ARd1GC0++1O1aiuS8G2BOADCpxhgyihnLzg8
         /H4s0HqSp/Rai0sHD2Re5WcTWmFTTPhvkDVcVnmIipakfue4O8HgyDZEJJVXKupVRVW1
         7gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411740; x=1774016540;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qs+FeU50DrlvqhF27orPwTWo+s1bAUOoX6Y3YglXETc=;
        b=lR0z4yHQiy2eS1askW86PxFUx0ggUR2mZVDLZVneR499yFJ4gBH2X033VE+dXYd1KE
         wEmWHJq9OUMrVjmhrAZ01bGwGWdSIJVUzkmIR7RJF3iRimHocyQeaCNkaOo/GzYrm4Rl
         2I7XjDx/xRVQVmyZunx6Jddg+6dP5StM/3AZioyTMi5M94H6iA9NPBBdCrT9598p9cvE
         Ee2xhPkwN8YukGO3J1Kuxow+RU3rinN7y6solsogYG9M8D3fo40sMGucy/4UjYBAZMJL
         gWPavrvO7dNBEoBMqWvFKOTdAuEDMeN0pofajxVcKElfPGnNivbvNT8e1V2d/JX24Dj5
         5awg==
X-Forwarded-Encrypted: i=1; AJvYcCUm8D5Y8iN/YlbKK7ayB3eSbFZg8fVe6PSqb5SSYC/E0o0UaXlXT8IokI43+oyC3c2KyeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wMws3P5UA4NN0s7HMbsWt7eoZ21bAuDWwLO4Q35KAy1uBmpI
	Ax/9XOyn+lU8abB5yjImm0mWKAAEbZKoeQfDssGMGvwxk9e3b2SnoHijW1rPE5qqInNE+f/mU67
	AxdxBrgYIDm1ysl3apzzxY3cD+fsfpQoYsgQsXXVLazLDQ/o81FUspU0=
X-Gm-Gg: ATEYQzwlxXYwaYGypwbr91wIoFkamWA2i4kHRUqWwF6pVETY7FazNH/sUOdtzuPsEf7
	5M+y1OwNqfk8msxp6l2ZxPt1pvNknoXnVj/uC4D4ZqRd3dJgSnyAC2k6Ogt0Hl+IYnABGtrswgQ
	Muat4SyJsRW8oL7AXLsJ45mbCOjK2CU6nslPzAlGawspHxhtW5W66O6fw//R8i34WJPX4qTv6nK
	5tNxSugL2MJzw97VxuAJecBoDWk5Jd3Qh8XgRL0Kbwkad9crtSl+HyPlQYdZyWkztHQSKVoeI8A
	zFDKD5jCrJoVXBREGbs8jwvWfqkqux9LMN1rqQQ0EXT3WFaPsZZQTeBHNrgHUhj0bsycZyY7M8w
	+OHOFLuftL/sZ2G81Ctlq611aQWHdEk7WBjiWuu8O7VQyH0+NytmJqtKG7GxC
X-Received: by 2002:a05:620a:909:b0:8cd:b620:9be2 with SMTP id af79cd13be357-8cdb6209c9fmr328968085a.38.1773411740448;
        Fri, 13 Mar 2026 07:22:20 -0700 (PDT)
X-Received: by 2002:a05:620a:909:b0:8cd:b620:9be2 with SMTP id af79cd13be357-8cdb6209c9fmr328963685a.38.1773411739954;
        Fri, 13 Mar 2026 07:22:19 -0700 (PDT)
Received: from localhost (ip-86-49-249-15.bb.vodafone.cz. [86.49.249.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a73494sm25547505e9.13.2026.03.13.07.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 15:22:17 +0100
Message-Id: <DH1PZT7KCZE2.1LC6II43GX0XT@oss.qualcomm.com>
Subject: Re: [PATCH 04/27] RISC-V: KVM: Introduce common
 kvm_riscv_isa_check_host()
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Paul Walmsley" <pjw@kernel.org>,
        "Alexandre Ghiti" <alex@ghiti.fr>, "Shuah Khan" <shuah@kernel.org>,
        "Anup
 Patel" <anup@brainfault.org>,
        "Andrew Jones"
 <andrew.jones@oss.qualcomm.com>,
        <kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
To: "Anup Patel" <anup.patel@oss.qualcomm.com>,
        "Paolo Bonzini"
 <pbonzini@redhat.com>,
        "Atish Patra" <atish.patra@linux.dev>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?=
 <radim.krcmar@oss.qualcomm.com>
References: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
 <20260120080013.2153519-5-anup.patel@oss.qualcomm.com>
In-Reply-To: <20260120080013.2153519-5-anup.patel@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69b41d9d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=fuErIE+P63Icv3tqjtEZBw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=sIBLlZgNAvny2aHwhmQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: n9jgPYDb57kchxvyWMd0k2gFBHl06rKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNCBTYWx0ZWRfX2EkGoC2+qttt
 3zZIgM+9PDGozGQXC1nYx33m7DpE38t2jS4/O61jUYEPhENbF4Pka4DSfeKd8qwHML09X60XLfw
 vcgy71+GQYQ4iGwJjODRAgNUT9noLAvK2YWbu3wBV4kqAHazy+fWebnk4t/hK+05YlXyVJ5kkqA
 JPSk106yL78Va6xEIaHrfEZy/bgWh9alqmf5AOmzvQNnnzbXe0JwrBwZU9MwxAOWCvHvavucWDV
 iOrKw/yqI/VYIocFhiVjErR48YdsiTk1tznpEPlMwPY5H/By/5wbY8FSr/8dmZOHhdgRvjHWjsd
 7vXvcSaAxKix1I8Pd2V5qvw2YY+MsGhp8l5iK7wPbHeJdl33F9FyvbUwCYfvwLAUr5zgYm4yscZ
 gwkOnf43tmJmPDKy0sUCgIYnckvkPOR3f+fP7wXvOBK+C7uLAglonVjcuYCWiP/R+b+Etb0yeO5
 BllomWp5UGOhhOFPpZQ==
X-Proofpoint-GUID: n9jgPYDb57kchxvyWMd0k2gFBHl06rKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130114

2026-01-20T13:29:50+05:30, Anup Patel <anup.patel@oss.qualcomm.com>:
> Rename kvm_riscv_vcpu_isa_check_host() to kvm_riscv_isa_check_host()
> and use it as common function with KVM RISC-V to check isa extensions
> supported by host.
>
> Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
> ---

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <radim.krcmar@oss.qualcomm.com>
