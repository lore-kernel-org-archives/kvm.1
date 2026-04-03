Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8B3BE145
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230740; cv=none; b=s2T+whuGUQQSUTNHtt+q6JhrrCkIo/TweFXIgu7FWk6jZETS5yioeFZhxneV5SRipbQlkq1D3e8mH5jtUBgFhc1ei7dsocQ7QUvIpm/RusZsNJphpoZb99bLuteE5bE2KYEye1EN4II1mEid7BtyLRfRxTYLCdF3HaQBmO3E6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230740; c=relaxed/simple;
	bh=uifvDQfOfG6Nx5OMIIi4SWcxWNKgEOo2Tv8nkqqAhbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkmWxz3A6HaZAD2si5gvDtO2z0Txoom5byeF813eFxX/eXFsygt1JYiM4kUzX3k3RrAwQp2Z1ngSf/XQF7/GxUcRBF7jY0rhgmoUCKzmNejeky1eKFgzThBgwPguV6LG/fxkxCwWug5JxBbYB6SDTclIwl3hThyboAN0sDd2N6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f9YsfV+a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OiQ5iJI0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9YsfV+a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OiQ5iJI0"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633C3d0P823112
	for <kvm@vger.kernel.org>; Fri, 3 Apr 2026 15:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dlQHizxSHnf89XQwG90apDFP
	E1boyp7qYsxMDR+MAKc=; b=f9YsfV+ajdvocMSfQLYKAK2lumyoUM73YP0zzUm6
	PfpAOWsaVN9ZI2RgMVhw7p/CXwKale7DGZW/s2moMVwBv5WAf65AxPuSb2yh6RyK
	jY9aim51m6nzrDTUGtVryEr9IBS1kGgsvb4HjrGJ8+ZGWZ39vwi+pdOB+gZRxOvC
	EbXnY5B4UKbcdMgqf360mbtrvwULkl2pL4mSB8RL98zKT7CyvgxhS4gP+KDWBr+n
	eWIh7pQSgHHLalv+BDyPXdUCvQ+JcE+mE9UXFrI4FzAm4KbW6HibHJZg8fx3ShLH
	UPU/jmIamyqu/R0jhIx+oCOYjIM2H50FrUEnQFqJMp7niQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da6739vr6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 15:38:58 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12776bebeb3so3293470c88.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775230738; x=1775835538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dlQHizxSHnf89XQwG90apDFPE1boyp7qYsxMDR+MAKc=;
        b=OiQ5iJI0pe59jLIe5ZkmaPCABqfLe9As5b2DpeLLT2DeRbzhX6XHiHFbuyIZ4IOinq
         BxqnWBjPIHrjRoGRL/72ciTDQrbkiKMHWko16kgshEPogRQIDdZajv+p/u/ES2rWhetI
         MbCz/k/ybfH7UIqwiSDYzwxt7+deKOWShjInrldIw/y8JdhZabNBhx/BLcuAC7J05OdD
         YnfVx0H9ly4rDKi3E0wyleupCZhhXwIUGNOIkYWrab+x9KgBItK6tAsF8NeifrJLmccR
         Uc1Lv4FZVHUC5xye7aD9912dqUO8epwHisg60XCWSWzRRNfav+9j2DwuC0F7U7GVvxsI
         CGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230738; x=1775835538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlQHizxSHnf89XQwG90apDFPE1boyp7qYsxMDR+MAKc=;
        b=pQwUYSSVPXrlQtjpjbk7jkEGXDg6s5vPyMh5/ur2EsGM/+l/B1DsI2p4djS6vqAmOV
         2ATBmxnlqgoTmAsSCRrEyj2d4ganIbjWoquPloExahY9qIAT3e2P/DjyiaW0fGVafyXZ
         zUOC7rku7/x/UmBmdlOwAx6tVdOODb7B6xcb6T8ptjo54RPG7wvnI7zSKom2rXpAOVfV
         /+pR38k4K/DO7dkAB+GbR8AzjZvy31dJg24Y5Ooxi1l3Y/X5+lOYwVJZTIOEnpBDHuqV
         Z5nuFV/ZlVjq+1/5BAL2jvi+ElQopImPgRfamTIW3iAE3z6WD705x7Lrrgw9EzNGThJ8
         MpSw==
X-Forwarded-Encrypted: i=1; AJvYcCXBtCzJFNLx98ETGWg/unw2jLsBKn0oFYaiw5O8nusqI2WhjEc5H3bJ18ukAaviRUGeceA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3rANKlHM5Y49Bce8xsG0fqG4XOmJ9RQuqLg6l5qy4omLShVoi
	WKFDflwoSZ0tyhlop7TKj8odKJKnvDX1WAmiP+HlAJLj6LUCmXMZZZZEqEUNI1YukjiMJBVDsOL
	kLnjJbiyuxjhefm92zyGtGGnJi1RqWq+HqJZ3yxTBUsn+TlBL6d4Fk9E=
X-Gm-Gg: ATEYQzwY7Lox5jS7UOdKQMv2p20UYuc/2t4GE/dIl8oLYuMIb0nX3/fGMVq6cRSodrI
	mEmMUa/XEqDsmsOUzZlDHFyQei6XmVATMUFLa9Pq8AXfBEZJMpTPF8LuyKjqIsNOyMOpJJsyvGc
	nk2yjPjctviUIDB3KUGA8tdhdJn348luLw8yAGlFE4rgvIKq8GaRE/B0m7JkssISHP3sTvKCzl0
	JgekrvvtTfGyTIJ79wJ2Jx4TDA8irox0rMLLstB2lMLEwBJ+YFxWtqA1WrcGQMONd3v3TqWDMy3
	JE2OTVUS9v11TWCWa1D5CBH66tnayW4EduV1++g6k0m3J76fvUN0BMylo3boWEVYO51H3fnmgQ9
	NLuKUaa3nWB/TzT1MFlCCYiI9pD0PSDw=
X-Received: by 2002:a05:7022:6997:b0:11a:4016:44a5 with SMTP id a92af1059eb24-12bfb7455dcmr1659267c88.24.1775230737733;
        Fri, 03 Apr 2026 08:38:57 -0700 (PDT)
X-Received: by 2002:a05:7022:6997:b0:11a:4016:44a5 with SMTP id a92af1059eb24-12bfb7455dcmr1659243c88.24.1775230737154;
        Fri, 03 Apr 2026 08:38:57 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedea9807sm4669086c88.15.2026.04.03.08.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:38:56 -0700 (PDT)
Date: Fri, 3 Apr 2026 10:38:55 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix shift-out-of-bounds in
 make_xfence_request()
Message-ID: <wneyyisnu6rtkzwpdantjfb6e3fzakkc4gbyfuanavunjoxaev@5niyyh64rdrb>
References: <20260403061302.2203179-1-xujiakai2025@iscas.ac.cn>
 <hkbpiuquqvsseu7tkv5gtlfxlj7qvsjoj6rndntty2btpcmdpx@4dfgpwffld2k>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hkbpiuquqvsseu7tkv5gtlfxlj7qvsjoj6rndntty2btpcmdpx@4dfgpwffld2k>
X-Authority-Analysis: v=2.4 cv=erjSD4pX c=1 sm=1 tr=0 ts=69cfdf12 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=MZhlcbl5PfivOvk-ML8A:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: ecL-nw6BUt7F-MUdCGYE0ylCsgYEwrZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEzOCBTYWx0ZWRfX7WUvE/Kk9/Fw
 r6+zeiIVCbqSbLVrugHNZhwEyhZJfjVN5IyoPYck7fy2BRE/cljZy1Jy3rG3mqGqlX4BU54OYSX
 6oR1I4C9pIJczVSMncf5YMcVVXzP8p61+dX8M2wD0wEJuaoSBXHYle2XP1S0Bb8uPzOS0oGcyuT
 A+1pdv1pZzlEeRCwH/9XRHzgJHxuRHbgvxciY37ful42LuPJB8R1V8lZkW6TWVvNCJpESV0Q67j
 w66aY7rAmQVnkjW6WwYbrhdJP2ZW17qCP4R1yqXOQjjRSBJonRoXyLiiNFwKECOhdTrG2j7U1UP
 kbDIFyUO7qDhOuTZhP5X8xxZHJK5IfyQQ4pi6FFfYtQl9FqGVTK6gRhS5Lzyb3N2s+W9OKQxvkr
 VPzFHcQkQysJ3VM9xZnZVjqwDjauzr8zAQrEGhtS+u2XoXkTdmz3gVDCRv6LmaNlCL557Av62aG
 gN9/VP+vCnwPcJ6AiaA==
X-Proofpoint-GUID: ecL-nw6BUt7F-MUdCGYE0ylCsgYEwrZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030138

On Fri, Apr 03, 2026 at 10:30:35AM -0500, Andrew Jones wrote:
> On Fri, Apr 03, 2026 at 06:13:02AM +0000, Jiakai Xu wrote:
> > The make_xfence_request() function uses a shift operation to check if a
> > vCPU is in the hart mask:
> > 
> >   if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
> > 
> > However, when the difference between vcpu_id and hbase
> > is >= BITS_PER_LONG, the shift operation causes undefined behavior.
> > 
> > This was detected by UBSAN:
> >   UBSAN: shift-out-of-bounds in arch/riscv/kvm/tlb.c:343:23
> >   shift exponent 256 is too large for 64-bit type 'long unsigned int'
> > 
> > Fix this by adding a bounds check before the shift operation.
> > 
> > This bug was found by fuzzing the KVM RISC-V interface.
> > 
> > Fixes: 13acfec2dbcc ("RISC-V: KVM: Add remote HFENCE functions based on VCPU requests")
> > Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> > Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> > ---
> >  arch/riscv/kvm/tlb.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> > index ff1aeac4eb8eb..500e001513a11 100644
> > --- a/arch/riscv/kvm/tlb.c
> > +++ b/arch/riscv/kvm/tlb.c
> > @@ -333,14 +333,17 @@ static void make_xfence_request(struct kvm *kvm,
> >  	unsigned long i;
> >  	struct kvm_vcpu *vcpu;
> >  	unsigned int actual_req = req;
> > +	unsigned int idx;
> >  	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
> >  
> >  	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
> >  	kvm_for_each_vcpu(i, vcpu, kvm) {
> >  		if (hbase != -1UL) {
> > -			if (vcpu->vcpu_id < hbase)
> > +			idx = vcpu->vcpu_id - hbase;
> > +
> > +			if (idx < 0 || idx >= BITS_PER_LONG)
> 
> idx is unsigned, so I would expect this 'idx < 0' to produce a warning
> that it's always false.
> 
> I wouldn't introduce idx and just change the current condition instead
> 
>   if (vcpu->vcpu_id < hbase || vcpu->vcpu_id >= hbase + BITS_PER_LONG)
>      continue;
> 
> >  				continue;
> > -			if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
> > +			if (!(hmask & (1UL << idx)))
> >  				continue;
> >  		}
> >  
> > -- 
> > 2.34.1
> > 
> 
> unsigned arithmetic makes my head hurt. It would hurt less if we
> guaranteed the ranges of all the components. vcpu_ids are
> guaranteed to be [ 0, min(KVM_MAX_VCPU_IDS, INT_MAX) ), see
> kvm_vm_ioctl_create_vcpu(). We should also test and reject hbase
> and hmask in all the SBI calls to ensure that hbase is in the
> same range as vcpu_ids and hmask is in the [0, BITS_PER_LONG)
> range.

eh, scratch this last phrase. Of course hmask can be [0, ULONG_MAX], not
just [0, BITS_PER_LONG) - so it doesn't need a range check. I guess my
head hurt too much when I wrote that...

drew
