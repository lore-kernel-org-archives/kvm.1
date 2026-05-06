Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1393B5821
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104862; cv=none; b=hJF2MfgGQjykgfFyJSCxb+cRvrnzkWfzbGRKYtfvoRba+MO1YTLoa+t+2Hrw1snbpGyHht3JFwbj5qhoZD20dzKjg+ABHebO2V5V2EB/sGqI+CsD6Ei3YTwY6eiIhIaJKVKXhggxXcXs1nJWft8te1DJJzmiTSldnWQz5OXFllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104862; c=relaxed/simple;
	bh=IXZ4d32H+jOcp8VYWQpphT/u7pzhnl3CNMsqVR/2JKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+84mSjYRnOLtIk35mrNDdx4L8TdSmPzVdYE47rqhqJ3kzVS8hnkWhY7ZUGLU90rvWUsOVdJG/OvhfjYyeMZKDLYboXfQbme1DvgUfOBetffcwFnzWzPqPs4/CUqMZd8ZKEHikt50NbVGVOOJFn+zSAQyE1yXIW7bClV2A3xhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SR6oKNSl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eY+lNwAZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SR6oKNSl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eY+lNwAZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646LGOo41527756
	for <kvm@vger.kernel.org>; Wed, 6 May 2026 22:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aZPxIliVcF9OGztv2uIgcJGk
	CT8mmquqC1ZufniuUCE=; b=SR6oKNSlVvu5Oi4g7EAbzQbJqL70VeUZkFFoQr7d
	jBTGJhE+nNHV7VIPGBmbgJvVk94vulDk4vSyBaQdr0VA5aT4g8uEpcUXXT7q0JoP
	OLCwAnATUfCoKhuBlsGJh/kce1HoHHTpuvlgE5+SRwwPboydQTvpPsxucipuWjpQ
	FolwM6ppk6NBKBrvz+2DXaJ2ByuHnVvXZqsQDQ2fCsQREk9X3qC1J5H+Bg9UUqVE
	BBM+drUf+fkYJo30GFOq8SF3eOyE7GEYV2IQkMpPevkjuyf2D4P6FmTY8vPwBJeD
	ugUnK83b7jyBxEYuha1Q/Q7wi+mIbCd2p0uK02UclJEZMw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0128b7wb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 06 May 2026 22:00:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so324959eec.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778104858; x=1778709658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZPxIliVcF9OGztv2uIgcJGkCT8mmquqC1ZufniuUCE=;
        b=eY+lNwAZmdj/W8Y1tSFNAPUCak+AcRrnQXxC/Aki3cy+yalCPS6iuMSzynKrwINqAM
         Lu6FXGpAg0MsT58c2JuB5CmR6PvbytG/UEqJnUYidIELaqD8YKVKmelXCFojxC0vkyx7
         W9A4qhdH9PRfU9juL4sNFU3gxnJy2FzY3431iWXdK2HDUBndtY5vZnx66RKAd9TAOhPx
         otMGzk12pLAceqfAF+RYuyRQZ5cFQhY5LJaEdFjVAJgLxv55L1EhLhl+eLuEXUryW8dX
         9DsfTPNgNHO1zKwwsnB2NDAs2yX7ULE9i4KH/V9ce2cfqLCMAol3GEBxbI0DRTPk4IC4
         bKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778104858; x=1778709658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZPxIliVcF9OGztv2uIgcJGkCT8mmquqC1ZufniuUCE=;
        b=bEhrMdqgMXbfcAbja3kZJrXRzVecpM1tPYmMhlMKbFpNAM5Y52sost+88uDw5z9Prz
         r8mR3kBuT52P7y23BI5vryl3bxeMPlaLCH4uh2U1l3njN/kIhlVV0W2ckmOTWh1o7FY2
         1oHFNPowxh1f8R97dnE49FnIkjZZ5Cym7GbJk358wIF8YRESk8WbgMD/IOb7Ai27WRpn
         wocAACkOSUzAD6qfYOQwDUI0DSisNbbM+Up1KEIkfRZ7J974HkYHiqLxjuPLtO749waX
         B1VmHTeoNcbLuBa7/LE1gYA1K9Wth0N8cSimDpVFNOPcpzsuK12Wt7LfLkj8/oiAiA6g
         7aeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jed6BGGK0XBGXDD5G9VVYYNKr+PPVgTzpAgTFqRKxikJnX+7fQN1314+YW7KPFxkR9qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGE2vwlwM7Rca5zlWQHbDo/fSYUWXc/LxUuOzCQPGsDzKTYOw
	JkKWrJ9hqc2qJx+Cr53YKY9fptoGd8RmuEn8HkR4q5KR89+SIaRkhMyvJSLpk4uDHOEqMm/qUUh
	a27UNdbVfZljaX7gsT5GioQqm3hUY9zH49/G05Vk2SnUIpDqHMjDti9Q=
X-Gm-Gg: AeBDietugnKoEZs9Q1VROLkIUFkTbdP/44FYf330AurY0RI4f6l9/hJcb5R1WdUVj97
	8mbSPxuet7dwRvT+ng0OajvMRIpyDUI1fIMt2OIYbXu+OoLGhTdKZmhQwjV93NOsFKMKrQwQI4C
	T6WBDykjIGOONag/NhZEiijCFL/ju/MzuE1GctT5UIx5nvpAsIsD/pmmIMmBkDHQnpWdbD0g3+4
	dAVeqTsG5LZUfrKb/VGBS9IHI5RYSR7QRn+rqtidCyWh4otkxt65uGrzUpZmI3cvOHIn7p3o1Sp
	84UVetc1bylS0STxC5mg8JcqGvtdtlfM7lVaHoS2xynApdZEjPC1BaQu0oZYVEvW+cGUjlmPZjm
	VjrrZNWk9zYnp8TWHEvAffbnVjwvbvQMDxNdF8Qu46A==
X-Received: by 2002:a05:7301:9f03:b0:2f4:3a9c:819f with SMTP id 5a478bee46e88-2f54d79b972mr2873490eec.20.1778104857215;
        Wed, 06 May 2026 15:00:57 -0700 (PDT)
X-Received: by 2002:a05:7301:9f03:b0:2f4:3a9c:819f with SMTP id 5a478bee46e88-2f54d79b972mr2873464eec.20.1778104856617;
        Wed, 06 May 2026 15:00:56 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f5707734a0sm5901626eec.31.2026.05.06.15.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:00:56 -0700 (PDT)
Date: Wed, 6 May 2026 17:00:54 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, greentime.hu@sifive.com,
        vincent.chen@sifive.com, zong.li@sifive.com
Subject: Re: [PATCH] KVM: riscv: selftests: add check_supported_reg() into
 get-reg-list test
Message-ID: <kysjvcg5shcuhgsd44znceenfjw65djs4wviwp3psruq4t7n4c@ppj62upl26wf>
References: <20260503-kvm-get_reg_list-v1-1-c16f9b572e9f@sifive.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503-kvm-get_reg_list-v1-1-c16f9b572e9f@sifive.com>
X-Proofpoint-GUID: EMMow6hlnWxu5eJgCpBB4-F1e-Sc5Yiy
X-Proofpoint-ORIG-GUID: EMMow6hlnWxu5eJgCpBB4-F1e-Sc5Yiy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDIxNSBTYWx0ZWRfX0V0PisaCPcLK
 Ge3M0rmxnlF1nLqOaep0EAknTMQhrIGNqz/FzVhXXmRA0Kt3swol5Gmoe8YR7Zxlp4EKGtEPPpy
 gSSxPADEbKuMAfnrQxWis14amSyKJmvl/6xcwSNadRPhAAxoBefnPBSULoUZf4/83Xq84mNc7hV
 b0pZvNtN3T9Qv3LvP9V5Xk59oANmL7D/gfEaBH0fWD9O+58hCUcb/Zl8ky6DwlIVS8T24yE/J47
 f4QRveJgPvxMaNZwer/Jwrfd0wls7vk0wwIkwe7N8U24C1PaV1aKJS74dJ93w4F0F7ixH2zBKn0
 03iOWz1GDYd+UDRS83JIlgt+mRdSH/dBHsZQ33FoK/aEei0i5S6TY29eCVrn8rPFkPmGSnA3jWG
 ssV4L/lq+L5dQH8yESKJQIu9ZHEd20C/Tvrty0ch2oy5Zz2HLqSF4eFPJQRUCjlAlM8q11R+B1q
 DM1uMhjZ9AvzKG0enrQ==
X-Authority-Analysis: v=2.4 cv=A8xc+aWG c=1 sm=1 tr=0 ts=69fbba1a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pFyQfRViAAAA:8 a=wBkBAAe1paUrZEgFcZ0A:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060215

On Sun, May 03, 2026 at 09:00:53PM -0700, Yong-Xuan Wang wrote:
> Not all the registers in a sublist are supported on a platform, e.g. the
> SUBLIST_SBI_FWFT list. Add the check_supported_reg() to remove the false
> alarm of missing registers.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 8d6b951434eb..d7cb9b5d37df 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -28,6 +28,18 @@ enum {
>  
>  static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
>  
> +bool check_supported_reg(struct kvm_vcpu *vcpu, __u64 reg)
> +{
> +	int ret;
> +	u64 data;
> +
> +	ret = __vcpu_get_reg(vcpu, reg, &data);
> +	if (ret < 0)
> +		return false;
> +
> +	return true;
> +}
> +

arm64 implements this function to only return false when a register's
corresponding feature register isn't present or it indicates the feature
isn't present. The above would return false for all missing registers,
even when they shouldn't be. OIOW, the above makes for_each_missing_reg()
useless for riscv.

When its OK for registers to be missing, then we need some way to
determine that. If a sublist has optional registers then it should
be broken into multiple sublists. Then, this function can be implemented
to return false for registers in the sublists of optional registers when
we have determined those sublists won't be present.

Thanks,
drew
