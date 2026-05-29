Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFC378D9A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079472; cv=none; b=ZMVzhD2uSwCwEqwZVbB9C6+wgKRNdeOSDm6NaludVWArc9HP+cZczfg7t1tFd6f1ADLbKZiWW7GscP+bgl9jafaE0O9FUrq690AR0aKyImZoCBJC2zpvWscTpSOlSrlXFjn2YVwGuybaPMDFfAUTexu75gcj4eY5oY3I61t1aBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079472; c=relaxed/simple;
	bh=vmX7lLW9umZkJT/ZekwLD2I8GNkzPIiCjfx31nj81tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzThd69ckSTaK5+OjrZ8CwEw5P03F5mRjsya3qGyHCzvKQvtASJiEcBSOM35t3ObLlyYKQyvQh371onAS5gZMY2R/TvLLWmiAvGBmjGhKQjjugsilo1/r6vfhfQHfKKC9qRKVb/bHY39e+8+GlBeR4ujCGtzP1H+jW3FQt7Zquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVqtrua8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bdBbK4Z/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVqtrua8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bdBbK4Z/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2L9x120501
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pkN1s9eqDTieCVIBdC0bdo/U49JIHfXY+v7fyyRHIZk=; b=OVqtrua8h2E2emkR
	WVYY4pDKLVsYfq1fsNMbLcUi78JtM4eFLGTai4jHButIucBHLj8WtZUoI4SM0/DK
	XgbS9buhvk/regybuRR/yPfJgjRdUMklLmebtuYfMFW4wR72RhfCuvBfR7fl5CMB
	SHjjJpuHwJ8yEu1dFGrQ8PmEhN1PqKMV/z98/7mfPqn7mF+zOZK+7lYjuCqiCmRm
	r9KKxPMRlSUI729RMILTYXD0Mgim0BX4OaBUzxEzoi63dbNNq7M7EtOlLANMaMO3
	AihqfWqD2TqEjt7DHjeVdIeNkXx/ZzW2QQOV1JHsLann2LOca8dxuCCzaDoDEWQ6
	v1xgJw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5x3d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:31:09 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-135de949041so14902244c88.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079469; x=1780684269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkN1s9eqDTieCVIBdC0bdo/U49JIHfXY+v7fyyRHIZk=;
        b=bdBbK4Z/oQknQm7kJAIGKfGWkoF+l0vuqrRCA4OHmoPIvU/xQlJOUP8b60QLQuV5Zg
         o/MjIWBj1YiutHc/7T0jGez0SyVT+MxLsZF1IBD+MQfpdZFseONaO1ulSvCNG7rYf/Jr
         HTFkMtx9uJSQsC3vB1ywnfSCXpUqEbPqo7qRiYZ4bmErX081qVcfc16+y8FiDOShetMl
         IZxMM/aiUK/cJ5LQY9R3oNQ5/HEus9uAPlEk29NdGdRdhhVT8x3TpfoX8sRFl0BuEAJW
         bDDaLyb9hrFiOr2XK1VhLy7Vx0zxrTSwnNUSmQjacgp8vIrYb6JOoosswUdEmnogzk8d
         ME9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079469; x=1780684269;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkN1s9eqDTieCVIBdC0bdo/U49JIHfXY+v7fyyRHIZk=;
        b=dHHb+Umnx5szioVrVbYcTIdMgHzAOH537cCHudOeG8zA5KHd/qMVAKipbP2TNiQGr3
         STYZK3P52UynidF4m1CDWXnBF2dOtcb+efBdEjHoqcLWm+EbvNN/BwgcaNUQINUVRbNx
         Da2P134nutm93V7Lf48E28ZDWCm+VlLpufrXBOP/ENVaJOOSoF4vY16poL93Z1Xc/QMa
         SFcUh2hW9Ce/jnkGD24MA96wBGil7v00mxXkk5TLMVpnntWosymMb9kqX3uOXtlrWneQ
         yh3ukL97KG+PYUEcQU3tEtPWPvLoosVWVAS+Dh5OKbef+9lSNOUHa4rEroj2I5RgscPn
         mX8w==
X-Forwarded-Encrypted: i=1; AFNElJ/Nf0fa6sZKvz8uuFafiu5HkoVYZEj0+pWHt/1X5vV/DZZ9jTQx9L53rI5cPsA5BB6frnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktoVkp5sYuLQOwuvBRp9+s2FLdxnt2BA+1mqb/Kv0J0h3YiRU
	pWAGP12J+pG7pwUJvh+rAylJaZY81cR5fWNa8fgQRLkhyVm3y7wUcoA+nNhdik0Ogrg5fok2azR
	a7ZPMOXsokEhRq0Y2mBeIJMx8UOxwP+q1UVc9qwW+YEf9jSnySYKRax4=
X-Gm-Gg: Acq92OFVfiFNYPXbFFROCj+srvItCv/v61K7ouAso0EpBKFMx6Bue7qoc4ylPXZzlZh
	cnDVX3dijep6F7s6jtz1pHURsVrlH3Qy72IxaYa+3HwNc3apxXnUIS/keKn81mf+4/btMWglitB
	VOGRx5Tb1YiNp6JP3lGBAXqxAjHcARQs2WOHyXnVhHowpXKT7Uh+yqYA981lWA2tZopaM6RkmoL
	5wbiadvY7gH4vQVnUO7X5tQr4towGtVNPdYBDDx2/wv5Kk6hxLN1LD5b0CCCO0MgucLuNWZ+nQj
	rrYWpwkMlQdK5YL2Fy7rXrpvKC19FiQfr59CUifJYBZJtilFEArVbFlhIonM/6b1glTcqbahlj1
	3RjNE2paPm8T7JtgwUAa9+sa1UAcsHY9+P6KaZWt+seIJjGy+qpszyhHfvl52/FM2SXIlvHZMKV
	cf25w+lnN9uBQXmBR6G/0VVAdc
X-Received: by 2002:a05:7022:ea2c:b0:137:64ad:a62e with SMTP id a92af1059eb24-137d4132657mr342494c88.30.1780079468943;
        Fri, 29 May 2026 11:31:08 -0700 (PDT)
X-Received: by 2002:a05:7022:ea2c:b0:137:64ad:a62e with SMTP id a92af1059eb24-137d4132657mr342466c88.30.1780079468344;
        Fri, 29 May 2026 11:31:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b37cd5basm1681594c88.8.2026.05.29.11.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:31:07 -0700 (PDT)
Message-ID: <845a0105-1b1a-4986-b8ab-fc75639dfeac@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:31:05 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] accel: Rename AccelOpsClass::cpu_target_realize()
 -> cpu_realize()
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
 <20260529142434.87880-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gA4A0iLY3PMyRZPQaTGLU87Pxk-ndOvr
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a19db6d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=x-YBvYG0Dqxg5h5i4QgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gA4A0iLY3PMyRZPQaTGLU87Pxk-ndOvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NCBTYWx0ZWRfX7gHjaVQEnM3h
 URgr1b0Cb6BbANOXA1cAZ6x0Z1MTYFDIA1dinzg79UwQ7sFZBtVyRcIi42ITE90hzD5oZrfy1at
 JfPwllx4Dsghd2ARwhahrNAJJDQOch7Dcum5so9HtZTCpxzMg/aLXRiJZPEZHOJqycgmt1rybQF
 9LR0k39PsHccYhNqdq0faPBPUxFbGOvg3i8SQKP43rzb6ykGzVVc3OclFjQjC0h4pNMYXAljhVY
 KmNqK1KWj+VKJBO91MYeU8zx9eCXAgkxEmpfa7/2oJKukBvrSs84CsCYHu+MGcH7lRDXQaeEp1G
 Dj1nkzLRkVTi7s4vHLZuI5lOFR0r6I+BR8VpLBJxj+BOR8TLUYKPZNuh/RCxECuWYIEwowyMZ0x
 oZSL2AKZuCc2M+/RBKAvdRbbW6OJucFDeSt3wOqCW2lA25EpDzkRyKmfvrQUDe3EYUnbN9iNSq6
 vCwmy/YoQonOZi+Z1Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290184

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> cpu_target_realize() is misleading, we simply want the host
> accelerator to realize its things on a vCPU. Rename more
> generically.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/accel-cpu-ops.h | 2 +-
>  accel/accel-common.c          | 5 +++--
>  accel/hvf/hvf-accel-ops.c     | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
