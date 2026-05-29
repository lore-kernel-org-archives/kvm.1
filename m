Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C93413255
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080145; cv=none; b=O0AQlcT1Kp/jGs7cXDAWRyRxpn/f4iY16sdrwt0GqBQiAPaP29Om314wemzc5B+XgrJT8EqE3paZa4HQDi3fzm55wwn9obD4dR7FxsjWdMVz1hXkznJ/y51lB88rd0l7wPentu9hVN8TPxCBqBxVKrbrT23YzSkkf33wGyBnP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080145; c=relaxed/simple;
	bh=FDjh1qIPWcGlm5WDWsxIKWnuiLxEtKb6kx3dYlxLkgo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GTeYEuFx4mWt7vDtg4TgtVOwgGGSh67QkzJq/D0V3VO+F5cqbEfrM6029dhiCgaGE1C1HKx/153tCs4cFsFD+MRjm3Qt6/yfAMi1VRXJeHxYb7C26cBh1pqcsVmL0SGko75IDc5EWH3NbLRsDm0b31H9YePfxUDpVce8S4ln6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PLAu1H3W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FbAL1UiH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PLAu1H3W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FbAL1UiH"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TIevFk117901
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pm+sHTslY8Xo7S6QxYIAKzzkMwpEb83HM+2t5OkXI/k=; b=PLAu1H3WR3+Czofn
	QrHCzXQ2rYrUSreW+oxBfFtM4v28YomEJePxyVlqK/N2v3CTq0v3IAUIdZjHjxGV
	HacDrXoXaj+8MeoXjddaHc14AEpm/xQrMnUPXa+y7X6eRbJgIrbLjx+teVYgeOLu
	Hzmo7LMRjWC5wLFdvHQZl2/sguDkLnh/B4tFgRNOrw1nZLtkZA98G6/DvSO7n4ax
	RDJ6Ze3B6xMH7a3lPngcJ8YW1umMQYBusC4nN2I4RBp+aiZ1Hrkok9AdQEW6hG1t
	4i5Z179jre67KbryQ3OXvuJN17s8jlPIeiCY9pNKk8PjF1n9k9e2F9ktgsr57NAs
	v1PSWA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9vr05c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:42:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304ec73b015so533063eec.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780080142; x=1780684942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pm+sHTslY8Xo7S6QxYIAKzzkMwpEb83HM+2t5OkXI/k=;
        b=FbAL1UiHGu3tqVQr1HSS5aTqbHxidBQQ7UuoQodbFqLNqTObNBkyaAVZN09fmOBEZh
         r6jBdLbZcrjsCYfDcLztuS9ToU9f1B6H+zSrp3zoRNWx9HhLzichED+Nn/JWkw+FE1Sc
         EnEMH/CQ9N2oa2J4x3WP1t56nW8j2h6VoHAe85LDa2kgghu5ISXYgr+F20Nxcbx2njkS
         7wT1grx6WlToSP7vcB4akjKPH50NftnOzy6HFP/ihBxfN7FtAiweUj7UHa0RIP4Vmbs0
         DOfNRIS7kI08sp+yy87OCKlKDO82EfsOKIG2nCPNDK6NN+/a2EqqT0wmc7bHPF1bVH9p
         d4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080142; x=1780684942;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm+sHTslY8Xo7S6QxYIAKzzkMwpEb83HM+2t5OkXI/k=;
        b=FvZU5hyIxSK91sKdD3Ivi4P0acmFfeev3cSQ1i+u3G0tkUClyhUIX2Yv+suSNtPyno
         TQzqgK4dnbHTjslWqDEosOoLuIQ1dgAKN2aNgjuLshm9+PeYcQX8fWJfGU6PTEFl9HIi
         L5CS5F29z76IaB4LihJ8M5nK6IRvYgD8Fj5B0qwnBk3ZnRfZRe6yltYqZ9w+MUlRd2qP
         q58DYs5Jii5WldSMRLZMykrDxoQvuv/+eCg6NcwhrsN8r+sYkBi8MQwF0rHe+Bz5OxK6
         7rdA2vU4faPEUDhMZKd8b9JzPO5fwoYKJZNwypfiCMVxqH5/LK++YjNI/cuiw8PtQtJg
         /YPA==
X-Forwarded-Encrypted: i=1; AFNElJ9j4tMcKZl/Da9YX45eHW7lp/Zxh+UamWOeiPmoFGdCvAcF+2nLRekTWlpbo8zhPcN4TAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYi5f+6hfvtDp+AAfcXJ3nSg02AJfNI4N8tKaWUYORFoGfnk+
	7UToaP72u96SGr1f8vdcA2u4vNQkziE76OLo3DQWTNTcDl4XqJusCfpKy2CARKii8U6N0WwEWVe
	ApnnY8RIG9xb4jrNbTsnWon5qFASej9ww9at2zeSOr7oKtfPFJ72bR40=
X-Gm-Gg: Acq92OESrnC9tSvZYpvXz8ydA5qlrjA+VbByBK27Gl2pvhMZXDcNeFkuMNGvYJHSOBi
	n7L4LCCY1lG14r53bhfZ9iZNv7fPyBBKfT8WTTK/A45jodFOvM2lWFoLEFR0kLDdeTD7p/ivTMh
	dcxaDPHeIH/zmRGPZno4Sw5HGjbtejzXEQpcTgEkSAGM9RUdxRBfNUzw77hTwNWO7/XGpkxWeGq
	K4NHzuutVdy3oUxuEPmQhp0hor9hXhZ//P0clCEm/yALb4+lAfsXnDy/GgBF4wWLBYqdDEk5lpo
	O/jjowerYI2o5Sjll48yTsk033EpLJ6C46BvkzBG+xakb9dFlFW1KAZ0KDMjeY1SjUfa0QtFWAG
	Csul95pf6DvtRhW1xtvQTMT5D00U5H0j0I4NZWsdy9rOOkVsLC6CFSQOXV90yEl1DxVQmXXqRWc
	PB1Zshax9Q2UTkN5auC8teLvi3
X-Received: by 2002:a05:7300:e12a:b0:304:d8cb:841a with SMTP id 5a478bee46e88-304fa51a556mr528073eec.14.1780080141753;
        Fri, 29 May 2026 11:42:21 -0700 (PDT)
X-Received: by 2002:a05:7300:e12a:b0:304:d8cb:841a with SMTP id 5a478bee46e88-304fa51a556mr528043eec.14.1780080141233;
        Fri, 29 May 2026 11:42:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd8e1sm2444594eec.21.2026.05.29.11.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:42:20 -0700 (PDT)
Message-ID: <ac461b24-6e8e-44c9-a4fc-954f869dcae5@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:42:18 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 16/17] accel: Remove AccelCPUClass::cpu_target_realize()
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
 <20260529142434.87880-17-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfX0PqmaYu12NgU
 TUbtzrwEAftPWf9Fs360lo8DJV/ziliWHfwCa8wwLDwmy4YywCjUXQOe4m5V/miHAU351Uo3Qp2
 fQeq4YEngJ7slfSf6a9qxZJcSBWTPPySmfRZrMvj1U8QXgBSVshKGoECXO8Mput3SHc6VySXXBx
 ve7Ci703DboSkbke7sP/pTHkioTF6++HNbS9jOiqctmC1wdXCnha9oKHLntgPGnkFewkpHSzvDr
 HwPrCLXD7iQQM+P8rUfO7mqZ3gd6nrzE8igjPyrbyt1PwzrN4uJcT8z3SchBF9J7dfWkNJMYU5Y
 +Yau8Y8nhxd90xYs9h2gPFxgwjd351Syo8h8xxW/UFLGLSXchudBc8jH6/GjwC3g779bP+e2aTq
 AJN58DM/pVEVdXODHpVn4IblGXnjnkdWTu606kjm5CSfTCAVdwvc20+nJHaKS09iFQKoC2jAMMc
 0kFOoLzX8KKzQPPeD7w==
X-Proofpoint-GUID: jWgbPblYdJTpEQL9JOgCgcYlW_sRPjML
X-Proofpoint-ORIG-GUID: jWgbPblYdJTpEQL9JOgCgcYlW_sRPjML
X-Authority-Analysis: v=2.4 cv=MJpQXsZl c=1 sm=1 tr=0 ts=6a19de0e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=M4ieH9tDHB7thNhbP8AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> We removed all implementations of AccelCPUClass::cpu_target_realize,
> remove the calls in accel_cpu_common_realize().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/accel-cpu.h | 2 --
>  accel/accel-common.c      | 7 -------
>  2 files changed, 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
