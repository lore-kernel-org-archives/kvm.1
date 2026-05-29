Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0484218AD
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079893; cv=none; b=Fb7NUIdEB9LreApJ+PzIN/8OCW7E3gatFGX9FY8bIz/FORJjqGUe0ZapKX/lxOcSgRIDUj+1Ly6AsgW+166addofZhwjggkILumKsKqf6rCpjVNJ5A5Waj1lYux+EeFLlZmtVnlPTLG5r2GshfTFOPvMxYUHWfyIFBqdwj5bNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079893; c=relaxed/simple;
	bh=Mjn7JNfyu+k5OtQBNjj1O+bgPddoMZA9ZCZ6V1CWN5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFnc17Jxpwa+enfMHy6XhzjjIVUs2DPKCA9bWrzwGqXvPKQjVto1FgQ9vKMCU1s8OKb9TBYFVAJfXN95+/ZLV+yjGA4C/NtX5rqLehNPSEh0aP4kVm+V2L5i0/vlbEVYSpAHjEB4uUmoLFO3t5toP+iKlD3Cvz9Zaklm/v/JZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PLq+NDF8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZNYvPi1C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PLq+NDF8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZNYvPi1C"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2Rrc313054
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qu6dr6kFW3wuBHlsRpljUoTZoNPGCNwbOjajcP/koUI=; b=PLq+NDF8T/m4cGIC
	hannQkkSQDlnNJfi+xc2N0Mvl7l0RN0lrF4v9/UL5h40v/+EgmbIbsY3Jf3DuX9r
	4/pfck0UdAtbqE/KVyOd9XgDaxE9suRivtiU5xespvIBnbYDbDz8ccfw2pRgGyc2
	pIGkWGqpTz9AVCPGb97l+PYiU1G7r5pjJuEEHhn0862ZZ6gKOdbZOEtfP06cjtlG
	Eku4VpzGsa2spLDWWerpoHeINpreDLqH4L+gfvTT5PE8G0Cejr32LvIDoPPMGZoz
	AQgjQCoLc3a1L1IM2IPI77ExhrRX95wdtta0ZQ0FGBBAe/TsxVh6Z5CRrDQ/TJnn
	ndb9wQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eex6m56wf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:38:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304d8613efbso2632413eec.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079888; x=1780684688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qu6dr6kFW3wuBHlsRpljUoTZoNPGCNwbOjajcP/koUI=;
        b=ZNYvPi1CrNJPNGNFJYNXhi+UOOaoBJ9YxnB4Z/v3kw5zqZL4q9fQDv03fRtswcgYn6
         VCa9IGeUMlSiddJD/KoDZWgaycmQeyAft4bs4gyS5dPCavlbSJN/D0SCgfxZoLTaZxSG
         EhfX/FXjpfjDJQKQpbctk6ZvP2N8W/tdtrqoA8mJloaiZRDgeFk1s/Lz/vJzaxU7hQvW
         d+RRKYEzoOiyKEbYszQUnRwcEbaTOGBxyIESWKd6gT08u6iouwOy872ihfBeLB+8+rmj
         WhSwsBo6/ZLW3QR2u5PaeIrGCcXnwDCSCG8jxzhjBlSJcZ0Xm9jObWN8AARnwbIpvEme
         Pv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079888; x=1780684688;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qu6dr6kFW3wuBHlsRpljUoTZoNPGCNwbOjajcP/koUI=;
        b=OKY2TdgzUjZg4WvaEkXOvxTHUticj5zXnL8MuawYkmCNR5vsNNd5j6VoMaNxLUnfyJ
         Al/15fGJ/c3dK960DsfF8MeiNXG6RCVlCaYK9mZQED5eP78m8Z+rBl51Gd8VR9S5lWHl
         y7MXl3e+hfvEtG3vW0FTdJAbVD1VJUeK9r8t5sudMPld0cyCdCBUWkgILoq89BOB9SYU
         PfxumnnYgk2cDYrbwdZlhtl39uFGeksNf2vaRkNc6JK4lH1uwUyjqJ01wLZ7p7rOJgkf
         X7Z+bcKBRKsJ6jfPq9lpPg37wDcgeNRgy8GYWM4ejWd9xd9o2Nkaa6XAQm0owoIOPcyG
         nanA==
X-Forwarded-Encrypted: i=1; AFNElJ+uxXbWrGcsVNK5HyydAhoPMMNeiup4nedi+fVudle8upJhIHRsbgUBMh2HiROALosAYf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+uhK3s369iV5vISOYtjPi3lVGDH03bBJDvC4TogAPZjKTha7
	Uspgv9LD4+GTnoMGywfuD9qhRf9zIOK3dahbzxDVpOfB4nVeH9xmusI7tYEyrpt77B+rgKhATC6
	8RInXHD5MD/2W6depqte3QFZcu76PKsFwdWfXB9Q5ePeY98IyUecSiMg=
X-Gm-Gg: Acq92OEY4QrcBIfTH1KR95XZUbQpBcNX8Csx49NFeL2N22sNBBL4hkyoewG99pMNub3
	iLJEPhW2gtQfYMx/z1MoC3/EYpfes64SZ1TN2hBcB3oQ8qCyoz5RCIevOocO0LXza3+EM6u4i/u
	iHuHC0MY3oup+7IuDeTuZA0UhP0jlTRxS4bmcFa0kl4DQELfIxZD4twplNDLPo0Rl6qev20jpBl
	b9kkicTBi7F+HfToDK+0VAtuUNEvGQpxoMX4GL+ZXDdrOHPi5+2DNphBlzP4VeBVQLiZ8hpu0XU
	JBozzL5I5ASa2DE/xzzF9m7LKz5aqw72KrNO1CSquf6MEPIM7hSQEqjQOTV9qyoF/WXjeHyUKQI
	k15kJSql+XhflR7+a5fJiyS7jghuQ8Ul8biejP7y2Wsrgl9PQpBQZIDzN1tEI5Jfh78cCYGFeR0
	P+fVPYUvAN8EDWIjAaprbMRiFd
X-Received: by 2002:a05:7301:100a:b0:304:dbcc:5809 with SMTP id 5a478bee46e88-304fa6e71b3mr502269eec.31.1780079887513;
        Fri, 29 May 2026 11:38:07 -0700 (PDT)
X-Received: by 2002:a05:7301:100a:b0:304:dbcc:5809 with SMTP id 5a478bee46e88-304fa6e71b3mr502228eec.31.1780079887020;
        Fri, 29 May 2026 11:38:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed578c48sm1982340eec.20.2026.05.29.11.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:38:06 -0700 (PDT)
Message-ID: <0b095216-411d-4bb2-8b76-2dd8169cf330@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:38:04 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] accel/tcg: Convert AccelCPUClass -> new
 TCGCPUOps::cpu_realize
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
 <20260529142434.87880-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfXxt1wcZpWfrQm
 0TvfhDpdiA33LCY1YlflJctG0SJJ7o0XFqRbFiUPo4m6Ny/M7av/d5kRlSurkSlGUWepoEDrASn
 UaBKGORBG15Y3cGJord91xNh5LAgtthRu4dNPWynevtV8U7gB7lUZrGZVv47MxuMTAAdkO6zFbx
 Qnsk1CWqm9haXVH0+ECwpSIrwNas87xI1s7Aq2ue/3sX5b8QRx6kS2tRyugOkafVmXqoLj+0Wmh
 xUSsM3IGe35GAsppR+PItAAKnAubJlCZINTCvQYzpbjcKIZ8rT/UVbyYjypQ/GIIZgmVETu2aJd
 xIjDtvM9oNBlwPSZTYjPCYLjUb7C3LOpxBHRknIqxQLhLBVPNRU/Wrh0yNKujwx20fMr7BvWE82
 +0XN+EpY+fKO9PsRR5/ILkhcQLiJLdlGgmOjSjIwgE7NEjB7q0KKJXBZexqQ9IHEkSbGa4sqfIb
 Yk5/JhKCMyhNz3s3ODw==
X-Authority-Analysis: v=2.4 cv=frnsol4f c=1 sm=1 tr=0 ts=6a19dd10 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=RhbWdbH4l8ml5Vp1eOsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Ix4WQWGUCwXirfaYd2XYspNgWdOiv9tX
X-Proofpoint-ORIG-GUID: Ix4WQWGUCwXirfaYd2XYspNgWdOiv9tX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Introduce a TCGCPUOps::cpu_realize hook and call it at
> the end of tcg_exec_realizefn().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/tcg/cpu-ops.h | 1 +
>  accel/tcg/cpu-exec.c        | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
