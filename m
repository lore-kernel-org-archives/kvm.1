Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6C449ED7
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079794; cv=none; b=icodWJ1VxEtffYWtjNiByo/pDl+1VBQV61jA2VV3tHusjU17tUuj2mMsykZFjpeT9VfrWMNU+PXDl61w/BaG8DpZkgKGTnM8GLIaYw+YKe9siQTEp0GnPOFMMcZ1Jbpwl6XuasTsJfRcoXt+T0K9Znxo8ibfQ+BWWpGqHrxruIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079794; c=relaxed/simple;
	bh=DdpspGuUaDivdLuFD434PcjJty5Cogu/W4NmnbNVlEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNhmBnXH+0n4VdV6zQ83962jfRWcev2xZEa90d0CIC2i8uKS6wJw/+OxzG3RibjCD57fBW8BMbc4eVDetyx+Qucu9+PwOQ5EeeqcpFUvJZoZAeIOmWj2FRT1Sz8yl9raqtT8UPM0Q0vOq4cn+xlgMvZ9R0gGQKhc+z2hAMEaKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fz/XNF6/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BYrBoH8e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fz/XNF6/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BYrBoH8e"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2QOr313034
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jwetY48q6jZKjFlfIkES0/E/aJ1gDs1xBquYmzI+n/I=; b=fz/XNF6/GfXjQFNX
	0UfcuCtloIVagGtD2+GvOtQGw8+Qf7lrJtaNYE5Ixumx2tn12ObRsAyZEVbu0S2N
	F/9QInpSsmfg/5zHR04qy+juDSw/qCvhDvgkZnKTXXkvqduFaUOBn8u3wPeLiSPo
	uthc5JZEmuTo+Ab1x0L2ZTnPWeOdqgeyd6tKbwF/dqfP7rctsFD5/YKEG1XChL6d
	pfVErFptt7TYD9Jbt2yc6xxxWFcX8Lm8JZf0rjl9F6cctSM3MHXFQlIMGtGQyT8p
	ltL+Ow1mQxjGnJtsQxQFWyZ55W7s2U6UY9HQ6H9Mor5LKNJzUx/XrYkcQvSQNDXF
	QiNkkA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eex6m56js-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1353bfdbf99so4542017c88.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079788; x=1780684588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwetY48q6jZKjFlfIkES0/E/aJ1gDs1xBquYmzI+n/I=;
        b=BYrBoH8e4M2CqYmPq41ALjpfSKmsFXWsKNzmk11BW2CvhmDDj+RGLrRxzX3do5Rhyp
         Bvn6/8Mh35C/4d0+zFPbvqZwz1ArR0LbdJ4KA/XHhSymfMeCUhUJT7+rPuab8TTcUOkg
         TZF4dnhafiO7zJzAhK3Hs6DqJtAc9bdaHwCh6EzyUVJc7o4L3pyzEZm7rYmkYpn9Ab8O
         VIlJMFT7inyV1+3NtbcwZSbNzzJ6yC2zC/1GyVAZZV5U8dvq0R05b/bUWvnvXuLIW1Qa
         rVsTiQhYHpGPiIVHrfDsqewF3Rlfo/V/M7OEyP8lGTumBLbd8cOAy+ucXxDOcBYPitfu
         twhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079788; x=1780684588;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwetY48q6jZKjFlfIkES0/E/aJ1gDs1xBquYmzI+n/I=;
        b=MtNAJIWTOwqupyTdb8DqsMCi37TB+n4070RGA47LlGamqt4l0zENMBMu8n9mSeX8ci
         yt9IY/T3t1DkVWcUZEPBayM0t+dwsDLmwBQ/KccwNYyzOQxYKlkQo+6AytXTGNo4GnPL
         WSGICSvP/AFSMvFvl6xCaoaMFIZvDgjDcHrP7Nyh9vHXNtovJYQvd+UdsSAtq2fv6D0y
         eptjtCpveizZw2y9njG4/x1P2iC5FReaLS3VVmTynjBErmKUJ5iAXUxMsuIJcScqfVf4
         9BxkrFGvewzkDibDMhLNOb1BjDOQENjOOWOZpQg/jtntzXSxEI8g0AkNpPhalWVjgDCy
         fesw==
X-Forwarded-Encrypted: i=1; AFNElJ8Uf6ZajqfBfbjJi4k8IBcBKk1uFrQvPliDs/pYxCD4vS/3yfDZvqoiaJf4yzJqLw3hppQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAfaHlEKOPVP+tU8pbs2/GmFZP8tAslw1kpS26ba+5BFWkDkA
	TYjiNg0mht0cy1BmSTe0jnexZhDlOb9onlqO9Unfn5fgg0Wwe5Z6df/37CF7j7l9KnKGq00IoDZ
	C7Xq9qbgCAifq7qDPxn56DBFzEMFwLiAQNd4QTOSk5HCNrKmyViP+nvc=
X-Gm-Gg: Acq92OGrVjlCh7DE2tmySWRxwM7V64yfdu3r7wIVriuFautyku9Fz4lUslPz/MCNXHO
	2M3qg4jG3lS78bX2kVF9T4ab88++6mKytUltvtSoNsQPpBAyeTVWoV6x7G9rkxMhPR9lACmW5/N
	JDJ8b4I/7mh1x6kQanfQaAHcrR1wKDVOfwITwAqa/t2Iz6ORMR04G5iCTufvyFl5FvuDFVIZqFS
	Iyrx+DG1JeqZLK2aC2x36Re/P2IE5A7wmtp1n7KikRdyYoERTLr1xRqa2gCP0/KjA1ctrJKA4mb
	hhMVD/aGG0/hHu3+b0EMz41DjireS3mkMHymhqWIGWXY5DuEXVOrJPe2CKSvTYnWP/qajjACawg
	MEpf4GmPjrkFO7TRi9980kD48eZGQBy3Dk9PdaFtP/Eibji0hVOj+Y+BSyDrfI2z6I4srDtvuiw
	8YAA50blxmlWm+GNqsCdmBgybe
X-Received: by 2002:a05:7022:503:b0:136:4a60:43ce with SMTP id a92af1059eb24-137d3e11dccmr448183c88.11.1780079788540;
        Fri, 29 May 2026 11:36:28 -0700 (PDT)
X-Received: by 2002:a05:7022:503:b0:136:4a60:43ce with SMTP id a92af1059eb24-137d3e11dccmr448155c88.11.1780079788022;
        Fri, 29 May 2026 11:36:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36af6edsm1682252c88.5.2026.05.29.11.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:36:27 -0700 (PDT)
Message-ID: <7f3da38a-96d0-496c-8c8e-e8a51624fdaf@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:36:25 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] accel/nvmm: Convert AccelCPUClass ->
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
 <20260529142434.87880-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfX2rdvhM1GoLWf
 /+vQYRRpbiiuxvtU+eIPd5pjJ4oCEbFEGEjc5vwpGdxNXSs1W563kcwtKsCtDGhUcDLNDUytrbZ
 3Ih5pOji+qsCaq05YM+xSg63EC3wS3T7xUkS98oixWS98aLs4zXw85gLpWLKVoFZmldvh5bxTHH
 Jx+zkw9DBdnmYvOfHSQgIsv7IoT5G0+HskE9wCehosXFQ5zeqnUkoqx10S4wvErGYk0Fcz0JmGO
 IDspfKqYM8ZfSDQePmxgcsMRQY8/ZRE6YfR6raSsloWYcimbTU3GZFfuYVwc6KAPVzU/E226hE0
 eKJI0oqpOvTA2Z2N/u5FNwbkUg7mUNWYLjVNDjF972DMOWqJfjz1f1QBvSKGHEfYB9f3S0fkJ9P
 Vzycfu3zyCW0+MOlHPEY+rfHsRhD53vbrnDVUj7F6hbHYAyzf2JP4noZ41iIvp58RaX95i6yk+0
 Tl3/CYQyR698rzn0Vug==
X-Authority-Analysis: v=2.4 cv=frnsol4f c=1 sm=1 tr=0 ts=6a19dcad cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Kyjw8ylCigwU-0_J9SUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OT0w0rgJxE6prkx66UvYgSfyNoHOosTH
X-Proofpoint-ORIG-GUID: OT0w0rgJxE6prkx66UvYgSfyNoHOosTH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Register the new AccelOpsClass::cpu_instance_init hook.
> 
> ACCEL_CPU_NAME("nvmm") TypeInfo is now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/nvmm/nvmm-accel-ops.h |  2 ++
>  target/i386/nvmm/nvmm-accel-ops.c |  2 ++
>  target/i386/nvmm/nvmm-all.c       | 19 +------------------
>  3 files changed, 5 insertions(+), 18 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
