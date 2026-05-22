Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670C39D3EC
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455581; cv=none; b=pxr3EImet7kxP67iMlKdfAnfnTnaBSC4Guiz9Z2zzblxKF1CTWDmWbms3AN7ewBuuj7/HGCPIOxfeD872s3Qr6cqxUHdgyIhkh108vmNmUl8gcIYwjEKQQhvRXzg9LFB/2wDpH2oaNTr/7l98d5gk7YbT2IEuQX6l3eM7Ekm8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455581; c=relaxed/simple;
	bh=TbmOatpof9p6+v4zMZRigO+g9bJXxf1m8u7FPSRwi48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ3x2vcxW0UV9CrasvRi5iP4YrBiRKdklTmS8qP8RxjgL+C311OJPEigrALu+JBKJUYqDoehgFOjs/7tM6QIEl6YRYAEJEn3vGP8up3ydPonTeU1oQM6oHvTrJd1d/m8LmNoEByIAOxzcFXqLc8dKG6hVbIgc8g9byOu5yLhiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p6OYK3Lu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hpOYIW6o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p6OYK3Lu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hpOYIW6o"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MCIWoc778825
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 13:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t65ionl8HpKaWCmZ/9penLDqAimBDJ97VFtyn/fDbHA=; b=p6OYK3Lu/23dJl+e
	0Oz1t88nAjoKTeSDHwrxCEi27PR9hQ++3Lro9BrMfuNJosIARFADkp8NcZUySzMr
	fqCbN9SNad2p9QLIE2Xb4A1B/6/+XnV0Ll3JKHteEz2Ox7pDqWPVontPS/wFcIRL
	Q+evJu99SVUnmODpUNC7SECjr7vNYB8/jm++KcoC/nonEthZv5I9lP8H2IZpLR7/
	gzfVJcUm+zxjYKrvJWAU+lexfrQVBnOta+FpxLIhpgOYtbGw2IbfMhMg27JpwtRn
	F0MS+DmBNIJCvFXAmKfD+Lzph7b1/CxAKEyoC6hnVlI2LQ2gpZDAokg8l/9gwxai
	zmimwg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7atuhb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 13:12:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so2824379eec.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 06:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779455578; x=1780060378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t65ionl8HpKaWCmZ/9penLDqAimBDJ97VFtyn/fDbHA=;
        b=hpOYIW6orWbGtZOTwr5cVKdltc4n7bL8nqMrMqyFZybJyQjB20YsbXs3OX6jZF1Pwm
         4OnLgXAnBYfEId8hg6GfyWCMH80rQjgk89MKx7lPGOn9ypUomC/RVTnu5KEh8Q8vB9+6
         1OV9xMwCoQRl5zqB51o7lbahwYMbKkE3/lhLyM5VsT82zR+y625q/dw9Lzp+AGO9wI7s
         +BtU1aAJnccYOKlblGFuMSrdTJ4V8qZeH6yvd4OBcuqCKVL492TWTiqMjvDQq5NT768h
         OKLah/WeKsVEge/bYKJFJTsNpXM/2IpETCtK/0OA/W4C8lCkCt139v+MJjBefp6t2Yv4
         92pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779455578; x=1780060378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t65ionl8HpKaWCmZ/9penLDqAimBDJ97VFtyn/fDbHA=;
        b=gPFIUw4BFAIiPkpUly6qE8wU8U/WOrsSmFBGwZhQ7En1HhjnL9zKLl8tbUMTsTkE8U
         Q/hZmZs7G41jeKGPUV+IfabN+dy2XSUF4GjU1H2fa8VvlvD6JKDWT0B9byAcuRG92sLp
         nOxDjXIIr21c/s7ZNMyiOj1ErjJoJI0pgbJsrS3NDOL2qbu4gjLkavLlSglebxljN6Sg
         VyR+3z9oA8KywP6nkhgOF5M7eBIp3Bp1qS4xMNtZbc8M3UTOmoou6yjaAcc+cuugn4wF
         YLptlUVI1J/27JNekrQidHMu1d7M5Hcd+onQ7lieia0ElnC2wNvDdbYb49bt28QYgNq3
         IM5w==
X-Forwarded-Encrypted: i=1; AFNElJ+PRRdZ+idA7V39yXpmQtLrnEwJl52H8qONKVTneES23uD7vBbYmSBRTJgFX/uoiiPiFSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIqNIoFVOVMZHWW3Q3uIeUOAO2rsIZcD0dz0rowvob0yAISn8
	33kifIAJ10kvu7ugIdSo9apxDQsBF+lrQ09WrRdnFjdcbi5FoC7eDKudp38Tr4nKagEAXsJ+Kbl
	NKnzZVDYsLGwUq2driSeEP8O+AzFyWFOeaPEomnPsCbSosFnnOziy84U=
X-Gm-Gg: Acq92OHXB9vDKJzBxb5cHZVdTwvoIRNf+2kdcd4erw++7N84dqwfmAdkEWueHEJzQjg
	wQkkFya92c/MTqs3/Dc4y71cJF+rfE2w8JXVkkL3v9MdvdduFzyOldZYNn2Rg+0kKD0EXy2thLY
	oDwZyMryo42IVK25gN8ySxMDfI2uIxNZIn9O43WOOqMTe2oUqzj6Rm3m1ImMho8EBOJGvfpSkr3
	UKYkV97BB+Z9K9gf6osHz/nUEdLlf/yRHYBua5Ez19J3PfePHS1lKFUDOVVoCo/s7MgwR7D0kz1
	pFVI8LojdwONizPUFBkbZsQYVKdSgrEdjjN0ScEOa0acaI3sVqgENgLdRo64A2qlL2TDJy/YiHA
	pC+TYpAOpkuyrDaN+YrD6lKK9zzkMHO4=
X-Received: by 2002:a05:7300:ad2d:b0:2c7:ea98:d94 with SMTP id 5a478bee46e88-30448ffda4emr1702410eec.2.1779455577505;
        Fri, 22 May 2026 06:12:57 -0700 (PDT)
X-Received: by 2002:a05:7300:ad2d:b0:2c7:ea98:d94 with SMTP id 5a478bee46e88-30448ffda4emr1702391eec.2.1779455576994;
        Fri, 22 May 2026 06:12:56 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f1fe3esm1328524eec.7.2026.05.22.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:12:56 -0700 (PDT)
Date: Fri, 22 May 2026 08:12:55 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: ajones@ventanamicro.com, alex@ghiti.fr, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev, jiakaiPeanut@gmail.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, pjw@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix TOCTOU race in SBI system suspend
 handler
Message-ID: <rqpv3mrcsxxdlaedbckb26bf5vfkj3xgd6m26me24nf4tbcqtb@jh62r2df3ur7>
References: <yirnowpcfq6wqru3jshbbaicqftfj4ef3dcss65jdtuon6nzml@iyv45tnmmfha>
 <20260522031813.3429490-1-xujiakai2025@iscas.ac.cn>
 <y2nfuwydbx4wxk3optxr5bex2pubo5whqvk2bzsl7os2kdkwaq@yk36oa4kozfh>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <y2nfuwydbx4wxk3optxr5bex2pubo5whqvk2bzsl7os2kdkwaq@yk36oa4kozfh>
X-Proofpoint-ORIG-GUID: Uv0eB9MPB8tvqpbTOYlC8SsQxfFTrjFP
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a10565b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=z0nQUa4Di5ar0o3MZ30A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Uv0eB9MPB8tvqpbTOYlC8SsQxfFTrjFP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzMSBTYWx0ZWRfX9/nsJlQnr475
 AWxGEt2jydvMx854DQSfjhpa0Ns+qKj5hJjSPZM+JNKHew5APZ82PSwOZYgc2iSaqIhbxZ32mEA
 417LKO7J45BfSx+Rk+GtxLg0b+SBH53Bz90CcLo8yyezfbtV9ZqpTQxzcCGuiT9bzlzfeisqgYe
 p1cHkxd5CH1b8mTNY/P2VKfvFcdXPy8cjmx9jhIqRJKk9FWjMYe554VZ1WdIDiREWgDd7HqtFkB
 s60z2JZNk2aKrd91zbVZ6aIZl47mk/sey3Wx/zHBM0aubVaYi8oh5APPxoawt1YqhDRcshyKFqe
 UArwfSQ1njF2it/QxP40LExnhinLbDiemSCpv377PQGA1A1ZaN6tlfY6xpuI7ZluuCyHNnpq4VO
 dWOFNR4Uu+T0m4RAIYPTKeo9AAVdrvsam8Vh104k+DdDOIaEXaC0mXMH/lDnTEHy3DkUzDRtfR5
 KZr5Il9RHwhcAxLlsEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220131

On Fri, May 22, 2026 at 07:50:43AM -0500, Andrew Jones wrote:
> On Fri, May 22, 2026 at 03:18:13AM +0000, Jiakai Xu wrote:
> > Hi, drew!
> > 
> > Thanks for your review!
> > 
> > > > I'm not a big fan of this approach and I see sashiko found it has gaps[1].
> > 
> > I read sashiko's feedback and I think it makes sense.
> > 
> > > > I'd rather we introduce a mutex to kvm_arch to serialize cross-vcpu
> > > 
> > > Eh, not sure why I said 'introduce' here. We can just use kvm->lock.
> > 
> > I looked into that, but it may be not suitable. Here's why:
> > 
> > Documentation/virt/kvm/locking.rst explicitly states: kvm->lock is taken 
> > outside vcpu->mutex. The susp handler runs inside kvm_arch_vcpu_ioctl_run(), 
> > which is called from kvm_vcpu_ioctl() where vcpu->mutex is already held.
> > 
> > Taking kvm->lock inside the susp handler would produce: vcpu->mutex → kvm->lock.
> > So may be we should introduce a mutex to kvm_arch to serialize cross-vcpu
> > mp-state operations.
> > 
> > What do you think?
> 
> Good catch. I should have trusted my initial instincts to introduce a new
> mutex :-)
>

But... before we get too carried away. Unless I'm missing something, this
race really looks too theoretical to justify any change at all. Do you
have a test case in mind that could force it?

Thanks,
drew
