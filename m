Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4647ECC4
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079878; cv=none; b=ZXPn1KviFQvf1by8zfElDadW7CO/O/lgf3XT0c9BP6k8LFlznbPM7VwVdWBY7E6BOeyHfCqDcxur1WulxZZQ41317vGVG3S6j8yZnOJqPtfX2m4+V57/avamFn7yi7H8yp4t9ZtAC0VRkxDATlQ1aXztMhNGH5fhUE0AR4uPwII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079878; c=relaxed/simple;
	bh=qDYVIahsLXqZFb/l/ZA8Zc1AdCBS2UhknZp1Htuph88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/zmmgsiqNFWczOKzntcAsK5gkVyRfR1Mx7/1LROnrxYcaJRzcRLjMZ0Ytu0k9iw1CEdjzNuG2BvsyQfS30ePFgHx+bihWmGWdfNNZnrZNcWwQol5NA3r60HQjZyL20lXCMeSfusdIEQWY4mCc5Af6UPG+Vtlf3j6lwnD2CakX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ELMfJz2h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WXxtSUzF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELMfJz2h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WXxtSUzF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2OSp199698
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MdkS9YRVUYxdK0i3/4cdSDl/lCrKtzJ/CBf+UUhWVUs=; b=ELMfJz2hkjG3GunL
	PvgRJvgI63lTQ2FzKeMvXaWpgpUNc7whcA1YXgu3ZwKrIyeyRR0z5H0BaHY7B5qx
	diNJG89wbPK9jUySN9jVMOzKANzq8kA0Wk+Rt9o40j9QQysGT+Njb8RLMUxbbIQh
	7tBMtMTCBPW5fI4UzUwLD2AtEUgJjdEEK6W+kMO5mHkPflgRoI/RkN59uyxB9lGV
	cg8LaSTRYMgAXdUZ/1eycC7sJETq7IgRh+QlBFleb1G4tij9KrKzRFdWBRsp6Nvb
	G1wwNt7FfXslys2fu0dFlpy9thZldqRN/9LmHG4w6khZpnZ95WdlhgtvJEsrYofv
	X7JJwg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnh6pr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304d8613efbso2632169eec.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079873; x=1780684673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdkS9YRVUYxdK0i3/4cdSDl/lCrKtzJ/CBf+UUhWVUs=;
        b=WXxtSUzFgL+ggCV18K2ina40Bw6BS6yXjz71y/rlGHpC8pBCfmKqOVm/KFWri4xW2Q
         3+SmK5oh2hzrnTrjmI2doyedlt0om1QOvfz+ifusoeDO8H8ov1ypkahR+/8EFev6WWXP
         9RZvXaeBy17eGX+OjDz518nruNwxKz78Ctgaiy0vLx6JMTBx2D/tnC9GvoxX0ByG817n
         IrNz2Q97964bbB1f8wexLzia1BinUR89ELyWRzGnZx7cRkFjQ8fyRxBt9t3/octN1yR0
         vgcAYcjFmPqpzPraueA87crDHW2yhm3QA8cAyFrInBQAihQ8tB9xbgl4Sgv+u1xg1WAm
         zDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079873; x=1780684673;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdkS9YRVUYxdK0i3/4cdSDl/lCrKtzJ/CBf+UUhWVUs=;
        b=JJYQREnprZDurH4JP8hyFig84hMb9NVhMN/p4b4PdrV4fwgTS1gJVTl/Z1Mofq0WIB
         6/K1zlsC6iMJAW9kzEuqrKSh3zz9k0blohirnmHlFAghvRgan+6lS1+WbkgVlICst8zu
         tSLYVDgCe3SP0odvQZMbrpPABCro4yilcjcX/wSHSuakScGhpTO8DcpxS+w4G/ZQDm14
         2yTAV1PMMD7AQd8SXGsjOO7DxKVRDfojwAh0oDhueMaDi4Rm9n+4MdZInUTtkEV20Y/E
         Lk3rDEdZetnxFGI4H1krYubpz62N0LxRCBOLt5tXuYUkdZG0GK467jck6WJ6YtKFUYHy
         9R6g==
X-Forwarded-Encrypted: i=1; AFNElJ89QtulKGzMnwtQW471gMheOxHvZ+Z7PkepjlprQ0faJTBpDCJw3m0Xz6dwcAd5LFXEgeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzppZl4RInnw06vpqrqMCYmHL1S1gdasjo0iyprp9c2nBaoyoq+
	QkvMBIDhb/614f1koTmivazVmaYUzmDU//8kGDDl6fcDoPeNJo94Dg00OteZ1h3/DLGblUyY1x7
	qNL06bv+zKzGU0r470dK51Qfj8h905dwEaJnI3MG1AloFMzekok9L83M=
X-Gm-Gg: Acq92OG5sX/FMWqJ2xnm4KTfPYGXHs0twZiJ6shFZEc+2RkWqw0EZWjFQc6WU9GZbup
	zEUFHFrTlkXffHAysodyLI/UvBa33D9GqouSjIkyyFsFUY6PO599d+k8cDdBRlNOEsBEj+zntrd
	LlbAlknmq9YxNHpeLdKMqInhqfkETj7H2Hc6wtcW3ephFWLSbMBOSt21EK1/L4DDMruQhkg5C8C
	zjetXrsXmm07LJos5fJE7cJOaV6ZSGgMd+w57WmEsPp3qXUyIFz8mcHe7L2bMZ4pD06lptGAKZD
	jlS5r+uzyxhdW8agaaAV5YHHovUekXpjYSfoqDpw4SyHRxP9DoxXm9Sm+pRSxqYv4Q1zibh9nhK
	ONF7pA30Z155yEbdfpRSNxQzGZg5qsjQAepS6PxmJ02ftAYMgN0lyyIld8ieQZ+U2wXUWYrrND6
	86gbWHYXem8IhY2IJzSVpbpd+o
X-Received: by 2002:a05:7300:724d:b0:304:bce9:25fa with SMTP id 5a478bee46e88-304fa525843mr505027eec.4.1780079873306;
        Fri, 29 May 2026 11:37:53 -0700 (PDT)
X-Received: by 2002:a05:7300:724d:b0:304:bce9:25fa with SMTP id 5a478bee46e88-304fa525843mr505000eec.4.1780079872822;
        Fri, 29 May 2026 11:37:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c120csm2076783eec.4.2026.05.29.11.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:37:52 -0700 (PDT)
Message-ID: <45fce4a7-5f44-4a07-97fa-ad639368f7b0@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:37:50 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] accel: Remove AccelCPUClass::cpu_instance_init()
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
 <20260529142434.87880-13-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfX0BjlSKZxksF/
 XGH/6GWGjqd+891vDD90E03T5PHtDMHpmt5iDuKD04/nvYIW5IamL+IjW9DLPGpc85MyXuy9su7
 IThHaNRg01BlQ7y1j7k1kIniq+s/YvW6RLPB6xYs45KYareM7IaTLRFbl5Ug6RePqSiJ18Dzoxm
 IV1I/WZ+vkfqE7iFoW6JgGKTohLXRtFS6YAt1Q10ECx8M1ySAzXk7CKoEXaFyKNLMeIFRopP71T
 UW93C9hLUmsWK5Uskn3IkkvVOIHyLI6hRtbZQTU9u6qCGMuhL3GtDxGKp3chjNVswpigclubBz3
 inOfTGfnsuoWEUVhF9DAgKFYW1bGKMOOhk/zhXw6+Xqd4hFb49k4ulF6wWlBD2Au9EDxUH+OU88
 3G45wZ6cY0eKNJD2OTG0CSajxPH5x0mJTh191bOgEagTeugXebKSY+34o7whC9wiAdOiT4+/1xg
 ASZayaTOo4vTjYLb+SA==
X-Proofpoint-GUID: Tk6GRnPtAvKgRzL7TRQBQRrWhWDNWnog
X-Proofpoint-ORIG-GUID: Tk6GRnPtAvKgRzL7TRQBQRrWhWDNWnog
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a19dd02 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=M4ieH9tDHB7thNhbP8AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> We removed all implementations: remove as dead code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/accel-cpu.h | 1 -
>  accel/accel-common.c      | 5 -----
>  2 files changed, 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
