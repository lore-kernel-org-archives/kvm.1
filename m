Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51295480DE6
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918442; cv=none; b=E9Z10Fv3O242IrrdjpniSZflBETmaQonUFxY3oYK2VmpFLoOLowHLKTHUblsVSE3lGnAmiWXzOnh3g7dX1/3ECdIS//IOrrasf2gjhT8DTu3Q0kh6VAScA8jYWDvUndJl4WFnxpcwBcZlA1tUIUXdQoCHMXy6Pawu7yRQFSOc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918442; c=relaxed/simple;
	bh=2/x9XdeHcETyzxI8E2KRfGO9qb2CWjS68D1628gPEoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYFXIwwskKyYDDj1wAFRaoab68uN42shFe5Sg44DVKBHDBMS7y5oAj/YLUSKUmYaGeLcbVl3jexqkVuA76wgNyPVYvT2Gyc4OOzjgKtk1R+ax46kosUHH/gD6KWgDonArtDwaOjyqIIXJu8bBokbA/zX1tE0FZMN0glUuU39REQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o4RidBNC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PnCPC3oP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o4RidBNC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PnCPC3oP"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8dQ0754631
	for <kvm@vger.kernel.org>; Wed, 1 Jul 2026 15:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MttML9Fecpm2oFDuamiPEcrdmopzFVL/fOA3IGnIl1E=; b=o4RidBNC9gjzl7cp
	ewUWsChglH9fUggH0i1f960GAzpRyNSXqXWCQJVEmsepK8ys4S2YvHTQ3G9dGcIM
	BYViZTz6MFgzbxLCgLbefckG7UF4zLeTNreXu5ss61/S1mnHaA1jlXGpor2EYCNy
	D6snfzSYWDeyTxUc2Nm1ZgBab2uZR5Ked5O2DfdlYw2/GCxl1yyKS3lhegas2muH
	+mSasV4LDERT4bKXWUijmStrKSwcM7FCmMn/loFD9JJdgwyyP+pzhyYv/Glpx25F
	5vTk3FiS/dHhevAdByNx3D8+cUEu/UKZqraNvHOcQ0PHWXyeNLXjbbwjf35Ud8Gm
	kxuKvw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqs9fy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 15:07:14 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5a7cbf971fcso81007e0c.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782918434; x=1783523234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MttML9Fecpm2oFDuamiPEcrdmopzFVL/fOA3IGnIl1E=;
        b=PnCPC3oPul6rnaxxO3qTskNj+ULD+YK7duXXtvwRCLYS95I6/8eQKlc6T5RMEMnJsk
         hQzcA+QQEB6gD+DwnwmXV3CsTRYVkk8R1KKqIdAhsauYuZ8ZFrqB1W1hbhv4JUzF1Byc
         psgenKpRa4bpO1Nfy25DdkotjRFdT4W/Ba15Almqj+v71cfeLAbC96dsyWaqy5xqdOnC
         4GKG1+MCeHe9kykBbyWegO1zDCs3TqGB1yyMxsQlM7L0YPcPNUX7Vejo2DWGYngnN9mq
         OzLJEfWKmieG2NarI6xrcOda2BGJV65HqL0brWz+B7dnJENeLH2ltkGlQMTEUt5BcHCP
         mlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918434; x=1783523234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MttML9Fecpm2oFDuamiPEcrdmopzFVL/fOA3IGnIl1E=;
        b=DTSw3bXRk4ydzhOUkYj6sLDTubnUqxt9KhXIpUu+b2KCHwaBewbv0qM/q57EaxSZ1f
         zj5Knlsl5QquP7gALTEBYIFtmfsdfkQ3PkDTnUJjgusUiL0mM1GI3ViDCtIxbqH7oMmB
         sApXBfkBkx/NyKNlPTAbu4b2CGjYH9f1a5yPWj94AfFG8nBiMyRDKtgup083rviF6ibp
         kaR1/0ec06B/1X/lL5mSabTgkISwdM8QWlD71v+pGm+HmEbOq2PH0HbnjrvQz7iWPQ1U
         6jBzL+R/VlpAy8irVKAstXFPK0HP2YSz+baibZ6G1gAd/2EqIraGV/7ysJobTY53gXvG
         Q+1w==
X-Gm-Message-State: AOJu0YxW/ie5t9CInff8oaK1G5AhHB9944oJPkd1vXemezMgr3hWgha6
	AahmDdY/wdCU/LxIGGwZZEgy3vjpddkNB6PLAj+MxrbIDK8K+6rvOt+dwKOY0ShvBUBD3CWqXC2
	XqUCXtlC6tJlLiX52Rd3jxfk4JyqKATkFD4lSBxT9xt4AMDsRI7nt1IU=
X-Gm-Gg: AfdE7cnd894/+ct/mbk4hh4ldlUpEeh4nzOx8YT3tA5NEcW1xvm78fO4oyDYj8ZrYMp
	vuLKxWuKeRJJ2LGbdiGikprEz+rikrWWdmep6VVdww2X9x95tKhb99ap6ES81Eq1gkGKieKOvSo
	dE1zkBR/jkCGq/awqR1J4Rl9QWU/H2axVILSXvS7R7M7hIUdD3Tex/m+5eGus9KFuIyFDBVyvsC
	f9iwb9oTrm8TlLqyIEMRnlc/3jkmfk7pRAYuwfTUCrg12hbyNicmQK8Dck4a3+V3HAXdJMW86cy
	HCtDZXKmir7/j7NSflN7lWs50q1OdTpQnVzogaiNykhoxSbTxKrJDCI9J+CuRC3tGR1uBfNTztB
	5O29zcG26DH4LCZ4XSFAW62gj/6+e07klmFDVqI52GcP4bjYKyN2/SVbS7CJgSw==
X-Received: by 2002:a05:6122:218a:b0:59e:6c31:5aae with SMTP id 71dfb90a1353d-5bddf5b7113mr759066e0c.5.1782918433751;
        Wed, 01 Jul 2026 08:07:13 -0700 (PDT)
X-Received: by 2002:a05:6122:218a:b0:59e:6c31:5aae with SMTP id 71dfb90a1353d-5bddf5b7113mr759021e0c.5.1782918433225;
        Wed, 01 Jul 2026 08:07:13 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4d2bc5sm85459685e9.5.2026.07.01.08.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:07:11 -0700 (PDT)
Message-ID: <5a848836-78fe-40b7-a34a-c64882c0575a@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 17:07:10 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] KVM: x86: Treat a vCPU as unreachable if its
 index is invalid
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com,
        syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20260630225619.511632-1-seanjc@google.com>
 <20260630225619.511632-10-seanjc@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630225619.511632-10-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iKeROCihG0hgbRJgIGXvvhoc0d26RU38
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE1OSBTYWx0ZWRfX+OYe6dxfXk0s
 TS3iKUbY1fMpxPThJi6/I+okiKxW16qTJdWZdVwCQt0AfSYsD2TlaS1294wKceDawA/FdV82U3a
 so5+0y4BFB/jjcSXTA4k6xL1I4Mw85g=
X-Proofpoint-ORIG-GUID: iKeROCihG0hgbRJgIGXvvhoc0d26RU38
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a452d22 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE1OSBTYWx0ZWRfX3JmCoE8M2Vxy
 rdrQNeR3678/u3EgpvSC5dLe0x26rYMKNE7PU5kg8c9VUPpzPBUQu4P/E/f6JJdXzDWZTlV+Ssi
 xVPwS2M1FPeuJNOyCueF4nW6It04di4fkImhn78QHC5imU7hneM/4clZeKZ6xhiP9qDo731Or1a
 0tV1Bagxf7ZeHl2wY25n/+Fu6fUYITmE3oIxU8THt5bHj/Dsmmd7Gvh9Kok5x+0GwPTZDs+MkSb
 C5WwYy6UGsV8Tz4gClh7oLKv2lIMhAQo82BdMpU1/q/dAMBkiJgw8d0MzZJ7FU3Tq6kqIK94A+I
 ux3LyxSma42hjoClTwtRPFgLRmpTIKS6Qk3xvr4O7I0HYqi47FBzhst1FhgFCoBYWRXb4ees68O
 GPe21/3j3DXT0h9T4gg0YZ2JAFKJbQUZ5pDfbl/fpy2CNTKU50todlCj3zOldV1Bi+Zy8ZLOdWS
 QGF+g7MoGzH0w39+ABQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010159

On 1/7/26 00:56, Sean Christopherson wrote:
> In the "vCPU locked or unreachable" lockdep assertion, treat a vCPU as
> unreachable if its index is invalid, i.e. if the vCPU is in the process of
> being created.  Until the vCPU is inserted into the array of vCPUs, the
> only way to get at the vCPU is via kvm_vm_ioctl_create_vcpu().  Note, the
> actual index is set _before_ adding the vCPU to the array, i.e. there's no
> risk of a false negative on the lockdep assertion.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   include/linux/kvm_host.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
