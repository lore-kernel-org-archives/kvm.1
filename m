Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CB428487
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080156; cv=none; b=jgICPALkHfYHAXyXnjBQC5KVmwwwroJj22YW/a6TK0HeWTF01PltrpucUg5US8LIXyhdgxxPBsPyEDQBMGalWJ5rgvaSMQ5t2YiocQ0nFJxXvmOVc82fZgHQPOuXR9tc3jbwbA0CgZ2/a8WeyNUU/G4Jccr5Qme1JPnu29SaavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080156; c=relaxed/simple;
	bh=jrpLgevhJTjIshaAzibwBCPI/R23oK4OAxLlhj9jmms=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OPN36cQJQd590k/yUTraOTGrgPPCTVOCq2CMc76nFuiayTFW+zNivbUkc/7HtuHE0BhQ5MH8h91eGOvCelBihpg2AC4xZLAIBCNMwetzGwvpNIfg9hBCpglVHjvSnIqv7l37FNFut1VgCBk3UFgRtCFdi0q8y3ydDidZbJly8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nt4eux0d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g+T6qq+c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nt4eux0d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g+T6qq+c"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2NT31912358
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U0GiKqxYGVho9sHc5JGqPJeipnbnaqHt+fQle5nA3Sw=; b=Nt4eux0de3HIdqtK
	wE6YHD/2Vw/7sImEKFD6We2XUGiHDbU8aDBaY5nBqnfbb8yPSicG0LMgO8bvf9Zm
	EpTd0nLydmZ+w/zgg99UnPBefMu2/jGZIFo7pZke7VmZAIm1/EnbcurP6sHKCqZD
	sYLI/tl5/KMC07xho3ogHnzwTwxdRcDOq4a9nZQMnpeXD8BxlZTrxP6GI5Ss+YW6
	ujnS7BogI/WXTvD5oaO88bX7yWXxI6FAb/e3i/5pZpneQftiT4egojo2bVp1CS9v
	1VHwZSArcC8DvX2HVYZWjkvCLLeyU76wnSs1K6/Uj9+mrHb70sdwaD5tBvjPLuRA
	Z3h7og==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu51syc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:42:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304e3e3fba5so5579028eec.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780080154; x=1780684954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U0GiKqxYGVho9sHc5JGqPJeipnbnaqHt+fQle5nA3Sw=;
        b=g+T6qq+ctk2fZc085sRqz/+2wVdBoxHGmPiTbLZrtS5IgCE/rGSY+V8f7/xcuIhz0T
         l1mpJu5DtUahftoev0lTmo3UzBXA9Bxp1IHvXbp/iSwqjRKICfd2y8byvYNAN2G0uWmg
         xIqQZnsAGzTem8BgJZeBWrOi8UocK7XmJ5rU1bAA7AIwVG052bJ4Rq9VVtzUokAiCl6W
         3KTusyoQxeVDXHOxs5LYOXO0yqwI1O13UGK63XOEUeXbBqV6iWIc+WGbQrmFAj48+Rxz
         wlsJIrVtgmre2d+0l7JTMD5TAuN/8EQ6zw2TaPQLaQfX04TvI9I1G/z+BfA62PqgffVB
         ZQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080154; x=1780684954;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0GiKqxYGVho9sHc5JGqPJeipnbnaqHt+fQle5nA3Sw=;
        b=F8qBDdaCxWGKIjl9rHlq4qsa+qEO4UutiS6w825085dQFahn2fjecz5pFbhNyg8Xyz
         hxry/nEBKbWP2V2j0IV0Fi+R/PZ3n5loERpz7+wi7pWozLjER8ITJcuigOXqnf8gbla/
         /KK+3roZM58/mpnUP/V6P4U2iWMAz812++RbzwocP5Hl5O7+kEUW1APECW0nbiTolBF2
         Sp8XqQ6Afg+mcV1ft/sUQlI6LoSweI3yi32D4WdVz7si1pJfGax34tS079fpj8v/SYSf
         QJ1eJC26r+3xC6F+hqolqbBwYcSwfqTSjQD6WaCUlYmkmP6k4MrM2yA2YjD8xhSZ6Jl6
         o4bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lSkyPqae4GZe08LZC2XGSkRg2o7QxlM9hVnRao1ar97mZtVfYk+yq7RoT1k0DIkjsB8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hTpGzD9HjfWCvG3BCx+1e7FE5QyyxIjzKWCw6nseRSiBLiXF
	jDc6BDEJh8j1ESuF+A6iICJodfdd1ro795Smr3fggzYP0c0ixWHBeQMH5CMCWiUG3rb60JYv64G
	FQtPS9sfam7riVG018uWKIM6CejqkvbS/siCefabWxviOeiwDG2L86qA=
X-Gm-Gg: Acq92OGPE/NP0O3JU06JNqjxCa9xZs8Bw3LQmB0wGzwEklSLH5GsiqqWuOGJf82qS4C
	lajZ73x3LIdfJ/QDcR2waAdze6PruXj63iXXABQDkOyBDhjUtn5XR0x8Byna0WDUPCDYOJ/lDtx
	5VHngnskoX67f8GfNLBfPD1MA8CtOrydrOdmQtn1Mjd73qwRK8kwuE7xszkpUnDUMtwmnMBd/Vq
	ztow9kQzCJI+yM/+PVG6tj9bwE0Vm/ARR1ciNFE3SyKqEDsPt1oX8u6k+vYHoKYWpZhEDhnIWPa
	R5TZPMRseMBuvJZFdMKthGgJ4tb1w5fn30cbg8Zr8zFIzzjYUMA4/QwRE0oBh4BoQZAc7QmuYoZ
	1uS3q3bakMpqlDp2fe7lA/1A6G9bVLZzOmLcuzhm4I52fjSKidmrOO39L95wUsBW0NszcHoN4hg
	wvjT2H8SwedfqtDctL4crG52Kr
X-Received: by 2002:a05:7301:1f0d:b0:2f5:3641:f126 with SMTP id 5a478bee46e88-304fa6ac22dmr503375eec.24.1780080154141;
        Fri, 29 May 2026 11:42:34 -0700 (PDT)
X-Received: by 2002:a05:7301:1f0d:b0:2f5:3641:f126 with SMTP id 5a478bee46e88-304fa6ac22dmr503339eec.24.1780080153617;
        Fri, 29 May 2026 11:42:33 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c154fsm1883835eec.3.2026.05.29.11.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:42:32 -0700 (PDT)
Message-ID: <062a4596-25ab-4f4a-accd-4157a58c0fb9@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:42:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 17/17] accel: Remove AccelCPUClass and
 'accel/accel-cpu-target.h'
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
 <20260529142434.87880-18-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a19de1a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=HiizW7Cylt4g5avhvM4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AVx7DuorhVtrUTxFOCHehnG30hR0bLH3
X-Proofpoint-ORIG-GUID: AVx7DuorhVtrUTxFOCHehnG30hR0bLH3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfXy+Jd1WUjYcFv
 yyJnqsXMGk2p33rrR+I3+PDzF3TrqlVJOXkiEMUp8oXbD29+GtoNLgfHtys2aux4dmvOO/kcv6r
 8fNugzdUCMFnjTHQiWRdYNqKO34SYABrBdLd6mDb130fnyLbBk6Tv2cGp2HRdXLc9wPAZSAYx9c
 lT6unZGjNjSHwg9bzF8ojMaHO6UMGWLiNRmsJr6jgrYcSv+p5RCpYzigBLOGZnFUSANiOam56jQ
 PiIe6Zr6axgUZlyYdwtPmJKO/kN7ISCDxtBIpLcPBufq0Xz8Qj61pMnq9Dk5VopZo8zqJiC5++4
 g2M456S8E1Dn/7JLHCzFDvAmC+gHC9wX2k2AUtWEwhcqJyf2GtZqk9GApZsH5/xL4tdJ4HLVpm4
 XF0te27f/bNzKwJZiyF2GvLX7tofIwodkJrczh8J78fzND5iTGDYwUJCyhlohW8mJrSn3WOL4zJ
 w+QYH0SPGkN8Tx3UzSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> AccelCPUClass is now an empty class. We removed all uses of
> the TYPE_ACCEL_CPU definition. Remove as dead code, along with
> register_accel_target_type().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/accel-cpu-target.h | 31 -------------------------------
>  include/accel/accel-cpu.h        | 19 -------------------
>  accel/accel-common.c             | 16 ----------------
>  3 files changed, 66 deletions(-)
>  delete mode 100644 include/accel/accel-cpu-target.h
>  delete mode 100644 include/accel/accel-cpu.h
> 

👍
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
