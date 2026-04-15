Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386E314B9A
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277826; cv=none; b=qUvLyTPXgiU7toL6+DhkgXj5JM2DbErNkWJlEquBwOTymA/bGgXruBOmV0MQrUlnjS2QheILZI0ysYnGpaoHLtxbvIeNeZCDSG1Uk7eWzT9OWQuYNxiJUvNx1ALik67UNyp2B0UfnP3Rilh8+VfNtiucXEOBlJ98tQ4DEd6j9tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277826; c=relaxed/simple;
	bh=KqJIrnnlS23UTICxlradCHw5j1bEgQdGSIDRlnYbqPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQSmGidAOhYKAMy58HEfrV2WBBnKGNjIPt/iAblB8pSXteXzkZg+2v98pZEt6ge22OQJrvuQdbPU6A8Uu0+k2cYrk3hIlSBbVK/RNAGH7RngGntYZdk4J3ajYLlrvPa4F4ZU3dIL3ztusJnL7xDcDTa+/ceCs6KW86dJ0Biqc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UKnmC/jy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NzUPPTbC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UKnmC/jy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NzUPPTbC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FFoYTF4052561
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 18:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/IdsrcYcpvwIkeKLjtv2ENG4xhn9aWKyhvQXOQSINFo=; b=UKnmC/jyvlYwwBgA
	kn0UHQKUmKfh6+6wbSqgZE2lWVumhXzKpePm0pj1xpkK8F5un0kkzGDkzOvFyStF
	IZrFUtTfozB4/6yVr3HuohJWxLji9uWegDREubw9ii1bbJPO/uZTlAyhZqLyXXC+
	7C/J7xuIlmrlBJB0gjzylivDfOjW97mAT/3RTjo4j5sviUPLrexr8T5Hk5gDg/nN
	FBH2m9ZIrtW6KFhCoZ0G7+0fJrk+1Wuj906c+FNBd7RpQayYgGVmISpnuYokmTev
	KybA+1gdLIrP+RiJojGKGtVwAr1wjefg80tNLFQaHNcIKveOIloC3S8jBS06lFMn
	KBsVOg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj7s5t006-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 18:30:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2de07c12745so8375086eec.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776277824; x=1776882624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IdsrcYcpvwIkeKLjtv2ENG4xhn9aWKyhvQXOQSINFo=;
        b=NzUPPTbCQBohP0YDPTM6iNwsF/Fcgctq1IJ6tJcbwMYjt6LptvjhA8vUmcSH0Kqw8Q
         SQ1ku+lIarwoU95xRupTqOj6YoiagTIp7iyKP+/88L8dN5Ss2shSuzC1m/i5oqT79Qp0
         LX8uW3q56tyLI7XbhZa4mU/Pt9oXlDL8ByLTMQ+XZKafyOSFNJnD2thGikkxkuiC1tRG
         CbN6Ly9HHddbXIHCNpAk32sDT/XzVAxv+sBT+cDh2o3BROUsu1/ajI4XHm+nDdaRtXHQ
         SnM8nFxrC+dE6/JJpwubcV94dKdT8Lj/LXzKwrVm2S0IsSEV6Z0MplFWlSKPsbCv3WnS
         GFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776277824; x=1776882624;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IdsrcYcpvwIkeKLjtv2ENG4xhn9aWKyhvQXOQSINFo=;
        b=ZZCGqJvR/GtNH7U//zHA8/Sus4lT2mC4n157rEnBrzKKCki7B+ksi6VXQ7vCW8uoZc
         C0G8/WgnhtvI2e19F1TOWMQ3X8LUeDtU5RetSKZC9no6RNIJKUNqpnuFIadjQMgQHI/G
         heZaxUI8nO295alIo9ZV8ii1Oazwgx3umwsNGWzlMEbWFgtqhmxycC4olPqouN2Ele8m
         xuBe5t4w+IzZAEu2IFaF98sXDvcnVN/n8ERRW9JiIx7k7muJCEaArAaxz5i+aLYtnCrt
         patKFi8BgI3zJVyj/hycnDlu4S/5q3dm+/r28Hs5NRxCNyVZ3rxwXY5/aehGOhbAJCX6
         kqkg==
X-Forwarded-Encrypted: i=1; AFNElJ93VmvPSrD68Yk5LFJbt9g7FJKjv/ZCLtNnxYZe8q/ESpqQoqvdQmdN8nsGlzM/f9hDSFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6HpcyPSYHrLl2WBTPXygri9FptRdBAEkacIoZY8vwDS4X66I
	SKfvnkwwBjGJzBoa4UaKlesSThmhMyVTHjM7WjhzEZtFUI+bWLohcFUFompNv81OxFiEqSEFgAW
	ZnHUfbIA9z20RCLoa5DF43uFjYpktlzsTmsDLpIiOCoBzZTGrvekk0Sc=
X-Gm-Gg: AeBDiesAGllPhOMEbV9C4HjZhxjUy7oaxArRDfpy4ilZ+dItHiuVR0ouLEBSBbv67Ps
	J98Xj3lSYl7kXAvEaXP769vpxMNreWiMtIcbgVaL06mhMaZqWozE5w5u4JsmFy/KFSnda/JYiZx
	EXPDtVAamLHrJeBMtykWJ4ilv788itBcoYrxrYSbGPXeJtyovx4v+HczU84gWqzFu9qlM0EzG34
	TlfMdvfNpL8DzlQl9TFJSA+VA9gy1b0ZBpTXzrGliqXN61PknndTofsFQcwGnioF6k7B8NSgQIT
	BumEBPyYVeSNxT+8M1u9z1fiIeT/SV4s1Dt3h+3Z9EOJUACYlL/WO7mqwtRtQt6liVw9aq95Bow
	BKR2HaFifERxnntXiwUCSzPdijaiIml2ZwRfVHVEf2/jkC/SxsW0WNSOHaONSsIdA+CpLF4Rc8O
	YOkMij+92tog==
X-Received: by 2002:a05:7301:6788:b0:2d1:a3ea:d8cb with SMTP id 5a478bee46e88-2d5873ad992mr14147021eec.4.1776277823759;
        Wed, 15 Apr 2026 11:30:23 -0700 (PDT)
X-Received: by 2002:a05:7301:6788:b0:2d1:a3ea:d8cb with SMTP id 5a478bee46e88-2d5873ad992mr14146977eec.4.1776277822985;
        Wed, 15 Apr 2026 11:30:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c10a688sm5121974eec.4.2026.04.15.11.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 11:30:22 -0700 (PDT)
Message-ID: <e6ec25da-03b9-47c8-9256-30cfdb7c930e@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:30:21 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/27] monitor/meson: Use SPICE with migration HMP
 commands
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
        "Dr. David Alan Gilbert" <dave@treblig.org>,
        Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
        Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
        kvm@vger.kernel.org, qemu-ppc@nongnu.org, Peter Xu <peterx@redhat.com>,
        Fabiano Rosas <farosas@suse.de>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=A7Zc+aWG c=1 sm=1 tr=0 ts=69dfd940 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bQ1BS5QBeQHsm1KAlAEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: McL6886iDiyiyv6VQBM5yn4bM4oNAME_
X-Proofpoint-GUID: McL6886iDiyiyv6VQBM5yn4bM4oNAME_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MyBTYWx0ZWRfX5gx4hoVoMNIN
 zpYgjP+v2J6IWHA+K5YLAih3nGEX09RMh6d90CaXPqkKTvxxonMBpl3LDbcf0OGFu4fK843eYcu
 TmGERioJETu/pyliMHa9Sq5t3cwUOg/qYDLbQPHfqgKVOJRYkd4uICC4wk24uiG1YzCsbNfiqSz
 m5mhI0BHSwbY5WTeeWu1b3j3jeI9pYARF4WxZENdl6HY27lIdpmmwayUDgYAxftFbBgqou8aX+j
 N9LvVBE2SIVf9uT525xDkq0PRevS8PoY/0QvhrZvBYYR8wrW1oORri3yPbV5sxiW8Bf0VmvAxzB
 BvoRSHDbz1Y32fxhbxjZokzYb2Axv3jHKPt689rYOd+WUsky4ZSgCApu2jGWyfs6QZ35nZ7nE6R
 bCY8JwKNhwWoObzAS1+n7WWyUq7Is8UbW8aBnb7P1VGZcVcntaDRK82BYIQuyYfzpCZGC+U+TPn
 hPtPj5ATY7bWPIRrQnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150173

On 4/10/2026 12:53 PM, Philippe Mathieu-Daudé wrote:
> When moving code around in commit 27be86351ec ("migration: Move
> the QMP command from monitor/ to migration/") we forgot to update
> the meson rule about SPICE pkg-config flags.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   migration/meson.build | 2 +-
>   monitor/meson.build   | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
