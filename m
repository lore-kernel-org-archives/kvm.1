Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF514A6CFC
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269041; cv=none; b=DoFna3KYWLXkKcqu0bBxOPgOmCsS5RDmpwOGywWU/lUdpKy1x5rs2GTAPvXfY2SqatzKKmLN5vivTjEcPhhI2XVWNUMtku7ZIMpSGZOCQO1G+QRnDefW++9OViv030fiLEZyUmz3XOZpymaAtcYH3WsjaVk9n2UdPXv+IK7pTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269041; c=relaxed/simple;
	bh=Hzsp1UFzoC59Md1gxeOIU+2qNTd46IkSWC0K1qbvf6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9oEORD/uI2exqxe35eRqbwHlsDzg3OPAy2OVrPdPUKYmqJ/kfIkQp0F3TH3p67+UxoF1HsjZIZkuu+dLFq5DJq3SBjwQFwISk0BAfDoSG68BsGDAQARJ8TcvSK8ELYroOiGuGFzuWLkfary7+VcSxlmcYNVXny3z8egOrRN+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMi043bE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gEmAR81R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMi043bE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gEmAR81R"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFeQXA2101542
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 16:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M8tOw3w9WOlBwac6L5boAJMWocybycmH2cMyGQykxKE=; b=pMi043bE6QGr1lII
	pZb0IyUUMlzTpHxw6zL3pxwMkGK8zJVP5wf0pJMCdoiBDmqx+axCDSvvbSt23IG+
	BXfrMC1Wk6A8fjtC5jzeO6bz4MdM8/VtpzpX5o5gQfB8x/IaQ8q666ePw+XLT9jY
	hN4i54agbS8Ri8oQRajPAwr8WtpfK2LI6h4DcFh427uEJSvVII/M1WCRWYDpOEF/
	B+o+xUmeg8peBe8ZjmHPFWGCZMUcUluWBmV5cZiAO5OaeKNYVATURT3c9sJwbHjx
	sxtv395HGmucKB5F44AWHi/W2FjQSSkoJZWovi/F9mNyWsryNblI5zIHqqEqpQPI
	dx6LCw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e0hk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 16:57:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so117153a91.3
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790269039; x=1790873839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M8tOw3w9WOlBwac6L5boAJMWocybycmH2cMyGQykxKE=;
        b=gEmAR81R0BklcjkVbNeLtk6lzaBH3H3gOokCrYu73m8p7+YKec3ZYaNDHEfE6vXmqG
         ZQYJ2zrP93dv4LRb5w0QO08TH/w9L7fk9rQ5cV+vzRXG53Z2e4/VYgU1Or9RoIfnbSWi
         OlJ8oQN3QFaEsEgJogqUuHUio6CmKp6kWbLzO62LMlEilbiqrwGJqe1STYyaqL5MiK9R
         NiMwUgaowjGzpadjlaSr1L3cJ33LPxqW1EXBgSowCke5e+ROBC91O2ajOJsnMFv9028D
         xwic+oAvXe1An0KwgaakltoQaoSahUDYblre1oI6jZDnRy22RLFAWBElBQQJikPwu8Lz
         F5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269039; x=1790873839;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8tOw3w9WOlBwac6L5boAJMWocybycmH2cMyGQykxKE=;
        b=AsX46hy8fxIIeic7mIhPnyvbcqPjtrTrZVahnby9BjIBX3SuAN0V/brsiG6NznKQyD
         2PbQFsMvnPe1Z9+vpJGKbgFSzDU+mkNSID0QWIyyjMl7DWsrLIyErV9aoRrEm2yMMaHw
         C1YXPfuVynCZbWCyD5lmAfWmpHmiltjpuYu08HiVmAzcIEsCiJ63gyoqNovncDzplh11
         08c9zZEG0Z61dTFgpBVpyV3lWb0Z/jeFQyQqv/Z2GEbNpM0skytXs+XQt8R0bpqx2+Bf
         0hUldY/EvIAFqztPj1fuDflEqZj5RW6xw/Kw0HkF/deL6cmvMQoMYr3XhNa0whUf6koc
         sswA==
X-Gm-Message-State: AFuF++nNSMtga/nn9byq2uEfSb0Mvir2oPzk/mse6w/oT8mqOGNjstgJ
	cB/ikeVvZ0lyfA+cZCMwXCDA9VYN1PN0aRPJB+vqG2+HuUo/Pokuv0fkDGnN6iaZR+621FFDiyA
	nSxS/G5m46hUTh7Aryi37C+DUkoBhPcVoCh/EmR1YET352jFgsxY8vhRtnFWsTlQ=
X-Gm-Gg: AYBFou30lDLZUTXglIHQHpgrRX0jPMdYzwDcDtQPU0OCIhZfNVD3uL2trMHWsHWaPLU
	K+ezC+aZCHEYDHeTV5lcosSqGMH/XabW5LT550h9bHgUkz14xHFHygtoYEHkTjtidyDyuYI7OI7
	NUzmhmJ6WF2IbzC+8k8VqL67lBuf3rURP/DZ+KM4uZ0smICxpR2gsMXebtmmuatiSj28972wLdU
	KK0E4Apn2OA0POzDWhkIrs1HT8/O26wgwAZSt53CPK4rrqL5hH2Gf021Uc9Iw5AVmGzRn/nva5G
	trVOpZxtbTe8DS/yZDLPKv8TD0MJMNavcYlpFEGP7xt2J06pYzwdtKnWv0FO/Z4ocnQxTrLDsxU
	tZ6ah0nU7jTcsndOZdQoaf3iAPXoobwx9mZm9vBdvozKuTapdh+moSQ==
X-Received: by 2002:a17:90b:3c0f:b0:39d:eda9:febf with SMTP id 98e67ed59e1d1-3a098da4171mr3197733a91.18.1790269038441;
        Thu, 24 Sep 2026 09:57:18 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0f:b0:39d:eda9:febf with SMTP id 98e67ed59e1d1-3a098da4171mr3197707a91.18.1790269037987;
        Thu, 24 Sep 2026 09:57:17 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976cacbesm5687417a91.13.2026.09.24.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:57:17 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:57:12 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
        sudeep.holla@arm.com
Subject: Re: [PATCH v19 1/7] firmware: arm_rmm: Add SMC definitions for
 calling the RMM
Message-ID: <20260924095712.00004057@oss.qualcomm.com>
In-Reply-To: <20260924135201.850038-2-suzuki.poulose@arm.com>
References: <20260924135201.850038-1-suzuki.poulose@arm.com>
	<20260924135201.850038-2-suzuki.poulose@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2OSBTYWx0ZWRfX88lOUkTmlQxM
 mVLkxD4cvMIY3ZdJBOdeKyil69LF9Uvp7/oGVAIM6zQpGLF/EJOq9M6CouIyqe1kTzBCUgfR4V4
 PwaDpVyT8hgVyuqxdmzsvWGM6eVph7QNg91iiSsRNezE3sBE+1+7pv/cVMelkL3rXyR0Zv03yrH
 /qfx30Vxpwd6mqkmHdXwQwcmbqJ4PYOrJKhZAgPgUjUoDQVQ3+fIf/ht0FQ6Eum7HBtrSYKmQFX
 QzMIbh8De+K+orCWKLB1hHqrXgyD2ZIeN1ETdLbvBz6gGpEb46ukZVUnlmN9uKhjvGjwn1j8E9T
 jGRrpadQoB3Epsqx9p7JBZ40N/zEsjTtskyYyZViYQDbQ5gQPAzUFy8oNLkYkhjuGrWsPyBo5Gd
 x+3nEXlLP4N3toOswEO07D5J0YK+e5p4FKTctlWtaaL2ddZswX2mfQQHpOCDQe1h3VeAOffbyFd
 4d8aMucapsq72bCPpMg==
X-Proofpoint-GUID: C0PsmRJRig4Syr2XfYNtisy8dAi8Q-PG
X-Proofpoint-ORIG-GUID: C0PsmRJRig4Syr2XfYNtisy8dAi8Q-PG
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab5566f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=SeLr52ClSpxFPvFle8UA:9 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2OSBTYWx0ZWRfX7JGegtSgG6p/
 jlCt1+l3xb4YY+nijkI8TldMUlZuTi2tC/sR8x9lg6nxV3/HxpB30UjFvSWVJiN1a5gR1o2hXXA
 796E1HshK6VvrxbbEPnzByC9/a1JB98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240069

On Thu, 24 Sep 2026 14:51:55 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> From: Steven Price <steven.price@arm.com>
> 
> The RMM (Realm Management Monitor) provides functionality that can be
> accessed by SMC calls from the host.
> 
> The SMC definitions are based on DEN0137[1] version 2.0-bet3
> 
> [1] https://developer.arm.com/documentation/den0137/2-0bet3/
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Hi Suzuki,

One small thing I didn't really care about but where I thought you
said you were going to tweak things.

Either way
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> +struct rec_exit {
> +	union { /* 0x000 */
> +		u8 exit_reason;
> +		u8 padding0[0x100];
> +	};
> +	union { /* 0x100 */
> +		struct {
> +			u64 esr;
> +			u64 far;
> +			u64 hpfar;
> +			u64 rtt_tree;
> +		};
> +		u8 padding1[0x100];
> +	};
> +	union { /* 0x200 */
> +		u64 gprs[REC_RUN_GPRS];
> +		u8 padding2[0x100];
> +	};
> +	union { /* 0x300 */
> +		u8 padding3[0x100];

I thought plan was to fold into the padding above?

https://lore.kernel.org/all/d7ccaf22-5bde-4344-8bf0-a5a17dcac0f3@arm.com/

> +	};
> +	union { /* 0x400 */
> +		struct {
> +			u64 cntp_ctl;
> +			u64 cntp_cval;
> +			u64 cntv_ctl;
> +			u64 cntv_cval;
> +		};
> +		u8 padding4[0x100];
> +	};


