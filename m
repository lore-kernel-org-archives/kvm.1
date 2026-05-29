Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C547DD7E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079871; cv=none; b=aabkMmo2jgwe8U51mQYq1iQXv/0mx3tYABvMnRckBKhMmObudR9jTLzT2PA6p384QbIuD1V6MXZ8wRIQGLVKffQ2rPvdUSrHZ9zQuo7GB8oNZLfEPD1tEbnyQr9JKl7wWVQWi37F41Mo47DpGGDH/n4/4kEivrY9ktv4592+i40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079871; c=relaxed/simple;
	bh=EKTP+Y/fJQu4Si1CYxezLmJFE3bz+FH8+fqLfKYfpi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AW3b1wI8c5Z5E0DzGMqHbZL3F1MAtO/jqUx/A7m8ErnrBWFybMzNae4u8/COVYmNcWOo+FJKHvWeYvmcwsCUrPdRHmRCeTVci6fhh6WdjsW75yxhPW4PpqY548gyM+QFslzFo26LeuS7H6li6nI9dq54n99SoSn5LcOwfMMJTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BJEt+fOQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RC9gpwJ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BJEt+fOQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RC9gpwJ0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2MlK199567
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ZwropHTkksAm+IeaLomlXgfdTiDpxYD4pyUXh3rILs=; b=BJEt+fOQXXigmyum
	fA0FC3DC+QyLuXpV7/vS3o0iXI2bA0F9mDSMu9gfHk8aRnA0Fw0Fi/LUqV8rGurh
	2RuSFk8z+qfIC6KDO1zLY0b4+mrWIvzpDiEKwNl54agsMybmic7VpIL/vIbvJNXS
	cjW1qobITnmxeCvARgaw1JwnUxe02BxiXyV2DUXA28zDTV5/5yaWDQiD5PKONSkk
	0CE+dGSSZP+nUzPCj3j6jJkDDyBcB+5VMFhTYMt6KMhqyj9qLaQSN1oJkzwSmi/G
	RSyVCawJUt84GLitpT9iZkX6Bvut8QMVn/pemzCzKqqNtcSavJs0qed+7IEB7DFq
	ay/lRg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnh6nt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304e7fc90b1so1363635eec.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079865; x=1780684665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZwropHTkksAm+IeaLomlXgfdTiDpxYD4pyUXh3rILs=;
        b=RC9gpwJ0lOZQIzOzgxtHnPuTcIb0wKmsdFC20LXRfD61dgl0NW38lE4Bsuq1gyS4Z2
         AGig5nFhvBNPZD2yTK0lUm5VhYs1Y/UW0oWYgz/hpXfTgz/k5HPYX33BljFyRgSwgXTV
         7NqtX8+2hcLKNa+6ffh+dq8+se/O+rhelylgHEG4/ER8Los0VWqI+IJiUjg8mTZm+J9k
         Qc1o8JyBaLI7+Q6xFaXh45DNmMPvW6g+DrGigLIvuS+wQ5d+HE9NA1fZvPFI2VoTapX8
         GdvOYtdPPHavR8STtq1cFLzg5Cp/fOJJ8gdnSjc42gEzyGP5wII1Uw4rISLD118i59hm
         NmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079865; x=1780684665;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZwropHTkksAm+IeaLomlXgfdTiDpxYD4pyUXh3rILs=;
        b=AOJ8G2xAy4e1i59+aLw9DhhmanM07tQIbk52cPiJQ2He6xsYiDQXO3Xe3U/fDT3VLO
         RlATwDGfJE0sWntldMPksN+nWS8d/fq0m8/3YOo9jYsFVHqrnHrXF3al91kRjc+rtI0T
         dXdv8YNsQkZERGKsKohTe8XOMGnlsThWzhZJ2uYftL1ST12txrT1sInKHe5bDeK+amRQ
         wv+bqulIKg04nFhFHomgJrATaB4WReRsrR7E9uA9DlQr1V89JNsIs+n1n9KaJElRqwOQ
         u/+ngR0/10Zf2cz47TVYUVcKdqyNt1vzw1SqvWwJN7MnxvqSP5GesCCxlOIc0h2FZyod
         Lb2g==
X-Forwarded-Encrypted: i=1; AFNElJ+C1O+y21/2r6Gz6twIvvWBkQipsiAc4xWXe0NQPiMWAuB1U4GADx5EcOWA/ceHbNK2RfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydH5GXd6O83pIXuCJbIdkT7Ra5Nt1s9+wB/xVqBX4J2ixCR7pK
	rFJ/sK3l0PfJPqB7dWmuVJ9292VAcVSHZ6l9tIS329gF9uU+yHG45wzhQjdxj5Jdny22IO0xMsU
	PrH5zGGzN7jrWA5dwBVkfv6vCpHEv2Xm8laVoaiCsBGMORCPa5nPj0SE=
X-Gm-Gg: Acq92OFwYabp+CUfxI7TCV1hAaDYueq11ZncoXBqvSH8jXijivrRobnvh5xGYhSbpsK
	BBDQG/I3yIsOTVZ13tdDsW5CdJu5W/3NqKCIN3/jWK1wJfLer69BTlGyBIjvz29+Bc56yIbH9Sg
	2dDCr4pQgJQJTRGd6famXz8S4CWcK+n3HhY9HjC+DNk7ewnpnYvkLGhOjwBWtUyZoXhqlDpvye9
	nNDUB8kDCaU6pb3O59YCUOgX2PSvPp8QcD2G5ydKL3XXwGa+wCVhB7hDTSpreaHteWz5/sO7OrR
	kwGezJYHmxCv0R7E1Rey7Bu1ET+sXjpovSYBJNoUP4OHrY/uXrBXAEvnXLv6nzjOjXt/3wBqaR5
	pu8U20g1p88+vlBrH+1a1Ng0TQHljUShbolUJIim7Qx5wl9jcZXHi9EMcbaKI9Ylq5OHvataXkV
	SU2S+sq/H12Dlf0d4vnHvKglfB
X-Received: by 2002:a05:693c:3b09:b0:2d2:d7b7:5c61 with SMTP id 5a478bee46e88-304fa4fb79bmr538886eec.14.1780079864963;
        Fri, 29 May 2026 11:37:44 -0700 (PDT)
X-Received: by 2002:a05:693c:3b09:b0:2d2:d7b7:5c61 with SMTP id 5a478bee46e88-304fa4fb79bmr538833eec.14.1780079864302;
        Fri, 29 May 2026 11:37:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b8fbbsm2025089eec.26.2026.05.29.11.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:37:43 -0700 (PDT)
Message-ID: <9e0d9d36-1109-401b-b514-f7011a8ee7bf@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:37:41 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] accel/tcg: Convert AccelCPUClass -> new
 TCGCPUOps::cpu_instance_init
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
 <20260529142434.87880-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfX3/PSyU7oKplT
 P/tyZ6FCMGRlYVQt4/99k+8mHzaWkMj+KlmoA4p2q0uRi0SoADoWYMcmJ+9ncXaLVw1YYfkG7oD
 q7fQdUg0d9fdQ+gHA/2Q/dVLR4MVSYQjFGvCScwtJ7s5HkAA+laWrp9tOqD5JWxN5AwjUxtWgNR
 g/HppnJMtqdi+kgWfP/tE0NWa5PX+LtzRsmfJ/cTf+T3w9yBJF7Cnrv4Vt4RZPB9m2FOwUw+iZt
 Ag88HWUkwOxAQ4QyVqgdOhCRvZOs2s3fohyJibb3ksNye9CPTBO/WIxI40xmH8L+EjTwEzE7qlH
 LJ9HJcfEz0Nr/t0pLEFxf1ho0eBywZSaecazDkLCxx/Bo7K7MNZ9BiD83mXhHQpig2iiY+fuOZ2
 XnNxenI8pMN5EUKts/Vqk1X/KUiXa7fhmkolUyxnzQP1ezZgZ+bVag7oEcBXRtSk/92Jvrt8V3r
 N8mddpNrDungj0HN6Zw==
X-Proofpoint-GUID: BYmwq8_4UmG8BGyuiRuecCPyixMjoli3
X-Proofpoint-ORIG-GUID: BYmwq8_4UmG8BGyuiRuecCPyixMjoli3
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a19dcfa cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5L1J3GIhLrxbTrXAYmYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Introduce a TCGCPUOps::cpu_instance_init hook and call it with
> tcg_cpu_instance_init(). Register tcg_cpu_instance_init() as
> AccelOpsClass::cpu_instance_init.
> 
> At the same time, convert X86 and RISCV AccelCPUClass hooks,
> after forward-declaring each target method (to avoid moving
> code around).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops.h   | 1 +
>  include/accel/tcg/cpu-ops.h | 1 +
>  accel/tcg/cpu-exec.c        | 9 +++++++++
>  accel/tcg/tcg-accel-ops.c   | 1 +
>  target/i386/tcg/tcg-cpu.c   | 5 +++--
>  target/riscv/tcg/tcg-cpu.c  | 4 +++-
>  6 files changed, 18 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
