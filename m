Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA458407CD2
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079636; cv=none; b=EbYlwHdIGtBEcScRXJ077lCbWLbRMoTEfu3dob6DUmF+61m6tbvegJqNoxF2GvRHK1k/u5rD+/qmJTdFFxdxLx1pGzzdHUmbLy8hYurLbRTXVBqqjHrWbiaowQJ3oVWvYvKzXWm7rgqmvERtOz2B2RyyPhohzjNxNg+wRj1iAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079636; c=relaxed/simple;
	bh=AixHGvmXZ5VCNrGEShVzwK58gYtpVTBqUwJiIxSKpX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsUZ1z8qNR42jE/y7PcOYQm1jr5DB6SikMKqORj4Tsu3AiKgTSLqs8UIpdM6u9kJPYTjOOTgsdQgCQ1JcmoRPLWtSEvCm41zBo+tFMOE/XTilu0PXNKQkbI5+PvRsNtOHwJYOfvPTMCJYEwX5GwnGT9VGnkKCspU3jlE3ggFYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KT6RUB0+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RIBA41tk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KT6RUB0+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RIBA41tk"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2O6R3915396
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EL1vawXMSOJUeCfRx+LOIC25MexzLlr8n479/rlYl6E=; b=KT6RUB0+03pJm32K
	UWIbM1JbP2CEer6J007RfQcKqCjtmQ2NiSdwkZOCgz6/EsyYhEc4kHHDlEO/SRJ8
	VAOhj1qFhJFH3XJniX/rMzwhqoKqKhQjW724ofn3yTUa+x3MmXbImbeAY9swtBxw
	Numj1PLTax40foT9PpJtb+WZNZOo7rAVeoOAfKzYea80EJYUGtqGh2QXKDhkslrb
	sIoS84Lx0X26msM7x9ORs0aDkDQlVNsI4VmAOok6otM3f+CqYSbW1WYDqbvaf/td
	Si2IXfd+VJz3VcTiCtfvaH5BUB6m/ikwLNkDt0AXaqZ121WrpXsr9xqf2tAS/M2S
	IINt5w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef015ckys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:33:53 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-135f2aa4742so4908857c88.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079633; x=1780684433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EL1vawXMSOJUeCfRx+LOIC25MexzLlr8n479/rlYl6E=;
        b=RIBA41tk2icbVvFG6kKHrQJUefnfQ1gNLX8A1QrfzqTWmLET/6EsVYocR7X3305h2D
         Jhfn3serbCzAYMgKs3OHqW34V7mWXEN7cbhuna1CyYMRSiAUhkJ36jt8ecOp0GwwC9Pi
         hVB+FIclO1cvigJzz0LpbouQJGfOU3AZukwji5jrreU8EcMnHkw8GaW4EJRMWMmWOhqK
         immZrWc8kL/s4HD9hIUjVDUdOuDpM6ZNEI31TFDUSMrE59wuF/2aG2LfYXKtgJIkhmBT
         Q9r2ivcyGFhRP7CAU4C24Laxx3guq/tGJQuuGA0TuHB3EesZEwHyFjt3kFDgtAnkYMpg
         pcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079633; x=1780684433;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EL1vawXMSOJUeCfRx+LOIC25MexzLlr8n479/rlYl6E=;
        b=p4nEkS3iBb3f3ePkIa40hk5jkKuT/Nd4TOMn6ekL8GKtc2ZlFNX1Giq9/UdWouLQGK
         udJhali1HFVp2KzpaaMuX0t/SUfrotVv5LBtMurvYBBsoHgsfoEGAzk33FDfFL/1wcUV
         Xec6/DJwV4IzGNn04et8VfF8qYF4RUzHALOho4RZYj/s6nLeQMY97W3S9nuqA0nN9hnz
         dJb0tA+5RMhNOTq8kK9D/GUnZTWUMBH8yLj12LqHHkcM/5eT2ZIrQSCkQw26PbpQm9rb
         Lr9lLsoPFbaW9FApNTLX0FhoOiViT80ppCXJInROwzW3BOxiCgBgxDGbRuAfxUL2IB7D
         qctg==
X-Forwarded-Encrypted: i=1; AFNElJ+unKf56kTo8x+q0Ue2BWVWJuynDqmZ/N/vGB/L2uOBD6tpCR+VoVGpLpEfNOdm6z5UesY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyki1gvGFDhqpMcv3cnOpjozYG/A1kixLcStAQThWx0+Cg2PxoJ
	UwAwXc2kk5nA0j+pxUff5vacl2oH+VVeraTUKJIGlBzobq1QE5O7tLYFD3+gvRC58bIhEOyBCey
	EhwV+1RTPjbqFaMqMSDMX7KINyJBFlvBuJrKkiO4OymxZJrcz4WF6De0=
X-Gm-Gg: Acq92OHRC6r34DuZjtLuiycaXZyfx+OcWvSpus7FbCKJszQx/84G4DQNNnKUnhB5S0g
	cm1GNgtID3C7MCFZCQmnVDK///37oyz6Pv0yo5unVB5NBxb5OF0YWgLRvnGIB66Si4peEfLWYaf
	EZPns3gAvh3eHlEBcypttpcn9Kr4g2VA2/F7HrrCMtg4gD9sMKmMATGhyGNQ13g2oIg6ye0sP8s
	Ow1toVZ4AaTVTj+hy8jlKd8Wge03pkt2VDVB4l+ePKPN0PIcG9L41MhaKdUebtWS3tdjOg10JX3
	cqG2Iz8RpR/tmqCDHjizYT4ec3yPOkQSzzps0+TzBqwiPkVJzogEVbaP0lkr6IDxwW/mMDtLrkL
	X5IT+MVr+AUABrrYBU+0aC/WtdI/ITzueJW+eeSHU+vICOMTnlEw9qejCKCBeq9g2fmZVgyJkVp
	EZH7f+jLKBvQ0SY/1xPy3lserB
X-Received: by 2002:a05:7022:6182:b0:136:8ca6:7032 with SMTP id a92af1059eb24-137d42839f5mr323671c88.34.1780079632969;
        Fri, 29 May 2026 11:33:52 -0700 (PDT)
X-Received: by 2002:a05:7022:6182:b0:136:8ca6:7032 with SMTP id a92af1059eb24-137d42839f5mr323655c88.34.1780079632432;
        Fri, 29 May 2026 11:33:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36c6eabsm1649163c88.7.2026.05.29.11.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:33:51 -0700 (PDT)
Message-ID: <61143052-19fb-455b-b0b9-457b4e944c03@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:33:49 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] accel: Introduce AccelOpsClass::cpu_instance_init
 handler
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
 <20260529142434.87880-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: y-tlQkSE-4bE-RdX-DQ-N6AkY7nQa7kB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NSBTYWx0ZWRfX7wVuBs2CdEsl
 4QdALkHid9oclqb/XakRBFVT75dfkGHgqgi/pQIxAO3R+FFQ6SpzTmhvP6ee1cVXZiqUSuB99cG
 8nDDRzC3aylebOrH6FGSZUXm41nQPlaxo6IBA1LjxUkkcohKopryy4uy6EbzgmdiyO/dleyisaq
 njY3bJoXfE3Ef3raiuueGfwqyv67MAqZV2PfI2zwD6Vsc1i4f0fABKNtoxWlHB7s5QW8kNlcM/9
 Klq7TW5DypYaLkdpROp8AK8Fv44UDPl/Gh5e/p4EN1yu69Ttfs78r4FzS/UvWLrQc+9yF2ryiHH
 cq+X23e9GX3xWbioNRPDRQWwd/e1SiFjpY61PwFrtlJbA3LDiw6cahQeqih4KQwBNBon7wkkVGX
 pKhDIpGZqwAwXjfUS0YLuFd8/64owXH119aQ+YGR3RoqpzBQdAqnVXj+PeorBrCwzZvsXNZPdD4
 PZhhuasr+F2LF0VFUFg==
X-Authority-Analysis: v=2.4 cv=DIG/JSNb c=1 sm=1 tr=0 ts=6a19dc11 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=x-YBvYG0Dqxg5h5i4QgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: y-tlQkSE-4bE-RdX-DQ-N6AkY7nQa7kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290185

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> accel_cpu_instance_init() currently dispatch via target specific
> AccelCPUClass which we want to remove. Introduce a similar hook
> in the generic AccelOpsClass structure.
> We will convert implementations from one struct to the other, so
> add an assertion to be sure only one implementation at a time.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/accel-cpu-ops.h |  1 +
>  accel/accel-common.c          | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
