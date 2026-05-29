Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72591374183
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079837; cv=none; b=NKogKVhqI0CWUBzmdPo27M0u5UWpDE5ZfgsUlkEQ10te88V2xJZfYrWVCyr0wqi77QbNx269ZDTqQvh0C4CBwz1KPmsbJkCHdF/Qzrt3Qn4Stc240EFMMzdT0KcDLhuURSBGLo1kkHSaU+v1QOI29lcqA3Dbf1VnkQJiQd65jVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079837; c=relaxed/simple;
	bh=yGh9HwLpTOlU44VCYEpskniAr+5dczhu6dfE/eVjsd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qofejd5DReC1Sji/RPCxSmt7VDZbToD3Xsy1Jyy6dNksTAWtNWd/Ne6Qn+OHiOPpk3lSISGHGbP8C91cfhBk+AMV1zmWNKMw27e8N+dCi4j3+/12XYKiWgB3VI+eLFPzL8acfIEGKyRo+mQct41PqZSJ/pTVdH2t41yZEo+1NL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VeTcmVZh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bHbME8qH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VeTcmVZh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bHbME8qH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2FBq518314
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ds4eePQRVhbBzJnjqMZDIhEp7q7wwgndXkltHS6Z0s8=; b=VeTcmVZhllLsTVKU
	uotJlmRp3X8481EDz6xOHaLzEEG3uPidbPLCrj1G4XyNBAkyUTIAyoMpCMBZfNKW
	8+tGSDTIXGqicDnuQgLYyKDLPBva0w19+1ZLZrqac2CAa33yM186sIyXbKgaTfbL
	vAz1FEoVqt8bv95DQYCSrv6ILpDWXVm5G+/RfzhUVXkpzgL+0vETiEvuiFd0CaVP
	crKVAvJ3UKZTmhHxNmzkSf/UIOdkzdbARGhY8MdFjGKD0RXkSu/j7cCbsQ4DE9t8
	nBtwDX4GBAfzn7MQ0IyCu6HcDH+VfuqGbdZCUI9uhDaZtIg+pO49bBiIAMwlPuUC
	eMwSrQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efechgusn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304ec73b015so519870eec.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079831; x=1780684631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ds4eePQRVhbBzJnjqMZDIhEp7q7wwgndXkltHS6Z0s8=;
        b=bHbME8qHmASkbKuYPXb7aXlKNY3/NLY6p+SzOOrplJuetCCe0yE4GQRH2ROk7NFDvN
         eKhf/YvfWta4fZhZ46HqVWnmcpX6I8L3hD/oIX3ZaESo4TkoiSVutVu/cU8vuCW7xIuc
         TBNGfo7pV0oYBH1WJYi0YExpa2H9rV8VUVYIhfBWxnbNMMt7U1E8UU4fvH5kKYnHuVlM
         R2aVOJ7SP3Ihbg8wxvwdAuv8aymjtromkeELAS/yy3sPpcFG3LSJ0S0SXCL9OLYSxJT1
         8/OPebt9Rs9tEaitsnd0kZiu5N26Nkw2vRBpRcpr6jyo28NEiJTy00BBrz4Qf6+xfoAY
         8ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079831; x=1780684631;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ds4eePQRVhbBzJnjqMZDIhEp7q7wwgndXkltHS6Z0s8=;
        b=dIDuTggHoR2xADjGNHNrazEEhmbj4bhKJ/J8rDkLz4l6g6QSBhvepo+84QBCtOMd0c
         h+vZzTRHli+ViFMwQnemQYR6/XwGY1MbBDxtotqApfd5j7FgjZe3pnYKen/4ir61yb0M
         c5jLIS8sORg4asRyija56pB8NLBOYbNOrK8Vs19NrLivgOo84PDe6p4z/2Ycrn4qtvrv
         dIuZ2h+CoskE7YBh+TStmZ/oV+FBsSErRmlNWfsfwM7auWKJnz3cRwtRetmzEXbtrtF/
         DzWCaLxAQRCpZJKrUO5b2+mq3kbJw9S30sre0JwiJRvi00hJ0E7QrLNPN9jzdIUI8FNO
         g7IA==
X-Forwarded-Encrypted: i=1; AFNElJ+rg/2ySSfJ/UpuUWuyTPoWoud5TfvG1Pva1CHn9X9dTGaAVps6i8UIsbijFT0ElWEt+5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPq6UdfNux4clT+uEDGjj9QlXv92vvTguscAzW38zYZJ6cvTj
	doq1qJmYjI/q+l8CuKiYxXsY1jQ3ND8OCKBSv9vIKCrMUXJH/CM6grrH72UC1gg10hUrWEW//Rm
	BKDOwZeRXo8Kr5IFZb6a4D8H+LzJZWuO92SxrpaNS3hfuTK8WG/4sp3Y=
X-Gm-Gg: Acq92OHrO4dOd+zVwQt0bADsMAO7REAggqPnrvpUCaMEgmrrqZf3AqP3iNVGJ4TUfaP
	VCNShC73kriA8soKkfd6DX8SuXm15+yOiSQ3Tgaiuxz1ghJ0l0V1nsxQ5Tc1ZujwQSEw5Mv49tV
	oSInXPXpJLXczMNla/YD06xaqTY+JazfkrlA5+pDL0MNChdA91ZzBdsL3EWOeZxNF5I0fIQoJ0W
	NRboGAs9YgohcguhhHWvO6J5XhGTD4Y/CLuf9yj8pQNIGs7g2fOR/D11/rcQ4UdQBr8tCJ5jDrM
	KcXr+RMJBdzmzYhOUW88vtdIdzu1sJP+NKpVw4RF2tzow4SxJF2Zq7czH9500lHaoEXPRKxbhn/
	YkHEfZ1kDUTxA0pF4mb3FPEFOziVoTAhaKf2ePbDuUu14omBWowkokMkKFotWaK+hrFQPzCXSmu
	/x3eAhWWlDjQ5S3W34UVk29Aky
X-Received: by 2002:a05:7300:570c:b0:304:4f23:4592 with SMTP id 5a478bee46e88-304fa65a9bamr502893eec.25.1780079831191;
        Fri, 29 May 2026 11:37:11 -0700 (PDT)
X-Received: by 2002:a05:7300:570c:b0:304:4f23:4592 with SMTP id 5a478bee46e88-304fa65a9bamr502864eec.25.1780079830697;
        Fri, 29 May 2026 11:37:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f316sm2011607eec.19.2026.05.29.11.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:37:10 -0700 (PDT)
Message-ID: <cc80a7f1-1d48-4165-9cc0-f24cb4ede599@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:37:07 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] accel/hvf: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
        qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>,
        Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
        Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
        kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
        Chinmay Rath <rathc@linux.ibm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IcC9gnYqtfTDz8fga-CfW0Vj4FHqy8Rk
X-Proofpoint-GUID: IcC9gnYqtfTDz8fga-CfW0Vj4FHqy8Rk
X-Authority-Analysis: v=2.4 cv=U6Siy+ru c=1 sm=1 tr=0 ts=6a19dcd8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=6jQ7O0SlXpQS7W1eCiIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfXyhSast/rYXBh
 5UKI3VZLRK1vqa57ZmDiwpxQx2hVSS1yBz5cZNOkkZFPEW4rjnVmAvBhnddv80HgbUDnE+A0W4L
 wp6SZVnmJ8qmvKKuavrdjl/4Q+2kNscZjkhTYWlWFXH9OLmVXRvdfaxnHLS81jRLjx32+ps088F
 K2Uq/0d8SaCIrDZlBbAE3mswp6exoZHMiHi7T1S1PcFMPT7Y7pBq3wTRA21DsW6MSwrWXFnFjQk
 fMHqXNghwGUGUBMV9+fC43lGjy4MrQvnBMELmP6TvwuxoinZHQhiMIscBL6L5enzfZUIJr9WfNc
 nm4bmMeqCDAWuV8Zg1J5xowuwvb7CKFIgIG7rlumHifJyBzVJLnnAnnCmoiGWxwdQKXM4V5zd21
 rQp9+hTZzLmhFAkhG41hz2q5G16PZWtMrghlbaoDAZ4oXYL/9nbS9BntytcLB9hm653Wiz4Ivj4
 C1ZXSOs+cmTOJ+Ow9cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> HVF cpu_instance_init() was only implemented for X86.
> Add a stub for ARM, allowing to register as generic
> AccelOpsClass::cpu_instance_init hook.
> 
> X86's ACCEL_CPU_NAME("hvf") TypeInfo is now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/system/hvf_int.h  |  1 +
>  accel/hvf/hvf-accel-ops.c |  1 +
>  target/arm/hvf/hvf.c      |  4 ++++
>  target/i386/hvf/hvf-cpu.c | 25 +------------------------
>  4 files changed, 7 insertions(+), 24 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
