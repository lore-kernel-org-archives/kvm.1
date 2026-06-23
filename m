Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134B23D2B1
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227293; cv=none; b=XtgwH+OoZ9F3Oetq1V6nPmIb4nYkqc9rfbEBb6Y1MEzL4LNIW6FLj6W87O4g7X/pv/Nik4NeHRls3iKtGC7ky+lcmoIWwZeF9RRidmZ4gSJAtDyMmk7VbgMZbaC27pXHVCtLAPFwF30r/bXPB33p9u92zO0dPxXJkm+1soan0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227293; c=relaxed/simple;
	bh=UEqn1XIqRumpcfgFX8YZoxMoMIDIv1eLrdmseBImUN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqE+ESmxNRRX7w/rzNfeWF8vyTa1jYX56uoYF0aOxZNMxOSiXR7qYsCTmcvUL34d0C/sOoxq80gbfZniTVy/jNFLDbU5dtnWuoFMbDHbeukLwA3Qz55VYDmc97UXpG5WUqW1FJMzLns5OziYYy9geAebTv17Z6cgZ78HfE1aGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLNeLSL6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HkdsEVzw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLNeLSL6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkdsEVzw"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXoYg3668845
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 15:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2NJ+7EMYBNpzMNctK2SBpsLKRQ/CVbMpj+ZwWzk171w=; b=hLNeLSL6V/jcJWXg
	C6CS97/rYuABUsHW6K47biI6QSWEdJyxaK/2R9yFc85ct8BeHo/UiKiN4Oywq4eP
	3yUJYM/Hvr5gRpNC+hUqsJbEcoyohJOgs9Q7Kjj1PJVFsLQFAN0AicnyoomBHZ1P
	/VJGy047I015tzRq2WXoBJmAHHLeGBJgj1s+ZL3JF+mmoKMoRtX9RDqk2af/uY4Y
	pz3Xbzj/iGD4hE2owXK7SnnIz9J4BbRMX/aTcZqg9cG8dpOuDPB1UroMUnjzoObE
	ZWDlGbCNaeXI4kQYc6b86gDFDtbMEZ4w23e0NKrskURpVX2rAUTIueD0Xvl+E+9V
	a+JRnQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppyhntk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 15:08:11 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9596519f3so5592942a34.3
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782227291; x=1782832091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NJ+7EMYBNpzMNctK2SBpsLKRQ/CVbMpj+ZwWzk171w=;
        b=HkdsEVzwL5qtNCoNHAd+SDOuSOCWyhLu8Wth86gMxRZ+bTzNIgBF/ISShSLXm2R34Z
         J4V3x0kcuSVacPz7rKTwAde2n0sa21EOTRaZUXMGMj3ddmhLubOLXaI0O8V63xFrUAgQ
         4k22xrVBfU07xFFpnusjLYvUeNO7Jr4JFHxiwlo4wnxc2v+oordivuq2562TOr62ZEBG
         UzixxXb5kxpBRPDybDUILvG2jQzFcKxK0oAU62JmAGf03lLo44Ph2BVXjOhicSTdx7Ku
         hkHxSlyzjDsGrpREqoZBfaBw5mcfXCa1NrCumyKXiDox7Mz2z+aTuRxSyxeVsfLGeUix
         +fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227291; x=1782832091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NJ+7EMYBNpzMNctK2SBpsLKRQ/CVbMpj+ZwWzk171w=;
        b=RC7cLrsGIqEXi9NjQmYAUOf9vMmDQ8XWcsbKiZfPOK9ba8dg5V3qe6u0qSvMGdtKhR
         CGZQ7n8Mohc+QebdIPF5h5Rxeogr+6zehQ8F5R+l3pgJgV87h5WMDUabfboZRk7uOkIS
         wazMbBvCqYFw8wtI4yO1QmAd68IIJSAFu1j+l2LjdLY0DONjRtb884e8zHYFidGep4TA
         YAEpg8cZnvuvbzZYo8JNOPFt7UoLRBXL1Ni7v7yrNRKm4sPfA1gvfdy2KgD3+bGy+8eN
         Ds2xXKKA3mIDfRQSvULRULd3pMVzsKLu8NyKCDk6M4Oupn3MircLhNxTkKNvJF4vB8RP
         Uiuw==
X-Gm-Message-State: AOJu0Yw06x8MAhbbmx/AbfLeTE3teLJvuf76MIlTXktn/7TrEQrAr9wm
	+f4KudQCfXQqW0rStef49Kl894dLWy+g+I3l5siXiQ+TU+dI9xV5GqxU2JIMeiA6GBJhp3mErA2
	1i7L7Y6TIlGq2FRikslypZcDpUd4XXZCT9CKkM1kV3Qcp4WJZRwXqrpbp1lAv/W4=
X-Gm-Gg: AfdE7ck8Ts9mTZLAJKIszEDtEdIuELI7rPC7pZqNE4E/9N6qxYruuSjbd6fiROPO1M3
	+bpd8xTvlniE+P6QalKXvO25XN8QriJnaFAkSuftK+O/Mz60eCzpSnGXwQBKMninIm46wTY3zLu
	OP7IywfXvFPzAMQZ4bKXBusFPu4UdUWEPXjAm5+olm/YGJDPkx7ius/ex1R5S9ZHa/WjrbJmilO
	vuK4hjtNRqb0/tVXAZtIeJXdoujain0xyxWMuQbZphITmI/tzXBMWxSZChlEc8SFBRQ4Y8ccsaY
	b01cLmV7qqHilvCL8ZCzCzAY50IWAT4Yy3z7uXPc/xPuQnQDNlOj9rsGoGk3WDVC5qCt+5CtdQT
	+dmBJSghomXSBOISDKZAsB3hjPh7WL5ZyaRHKiM5nty8deiba/AX+TjmSFfEdXw==
X-Received: by 2002:a05:6830:6118:b0:7cf:da97:57d6 with SMTP id 46e09a7af769-7e92d54c748mr16677799a34.6.1782227290895;
        Tue, 23 Jun 2026 08:08:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6118:b0:7cf:da97:57d6 with SMTP id 46e09a7af769-7e92d54c748mr16677748a34.6.1782227290465;
        Tue, 23 Jun 2026 08:08:10 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ac80c8sm525662366b.40.2026.06.23.08.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:08:09 -0700 (PDT)
Message-ID: <92a4d803-c545-48e8-ab5c-647bb04f3560@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 17:08:07 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH] checkpatch: add support for Assisted-by
 tag
Content-Language: en-US
To: Andrew Jones <andrew.jones@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com
References: <20260622164109.26350-1-andrew.jones@linux.dev>
 <CABgObfYzDQN-2OpM7JjoPe32Y=y=FokJEq2oePYbyASUuxy2yw@mail.gmail.com>
 <ev32z6yxkujq3ctb66f6l3e2l5cx2b33ye76mlqvo6jdsydxsk@hwmgkv5rmqym>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <ev32z6yxkujq3ctb66f6l3e2l5cx2b33ye76mlqvo6jdsydxsk@hwmgkv5rmqym>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNCBTYWx0ZWRfX2XDYajv3aPPT
 SHuITFpMCvvq+4xY+H6uj9A2xKDkK/dcUU9fw3b6gTkuZ4+r3gVRdKGgyDI47gEbHNNWQwfpioe
 GmWS82gSusoU00w6dgjVvF+T+qFXEtB/4dy+PrhQrKXLPDw3doDogrm+sK7epMfQHpu2pswWm5r
 AYQQhhE7RRECO+uV537/3zgw0mglsmSZrtOwQ5rquw1+XhA1npYp36yLYvj70SFCyPbq8iVs/C2
 KHEU5wkSbJuyvvRCx/x0jtAw3dKoNqLhvslGdRLtWlotg0LJyckwXvSfga7P6RKDZ/h8DigoFZk
 5h+Ng3PQC3QE1/eg82xJKJa3KSs/G+Y0vCcyTh/3hgHoijs6tQOL2vclo1eK0qEeJKYXVFbhEzE
 /30CvfFTHoteoqohwDVu1alomAcb7VGiZZjgspO1Lgm5LUeWimAZJ55yBaFEMUaliYKGU6mMFNt
 gox1XpSMZoARJfG6PqA==
X-Proofpoint-GUID: eoPijuuIyrRQey2pGXsnYAai0hQdGD10
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3aa15b cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=dAJdSmP9SHWhm3zmMxcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNCBTYWx0ZWRfXwXatlDNoGIf+
 YsdsmH3wdwbWZk184hiOszNYb7jG732AyY7cBp1DYgiyXwAEPHNL9Toapiep6ixe+gO+arijGDK
 FiS+5xM0c3t4FkAtU6eNaaQrrSUprG0=
X-Proofpoint-ORIG-GUID: eoPijuuIyrRQey2pGXsnYAai0hQdGD10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230124

On 22/6/26 21:00, Andrew Jones wrote:
> On Mon, Jun 22, 2026 at 06:43:45PM +0200, Paolo Bonzini wrote:
>> On Mon, Jun 22, 2026 at 6:41 PM Andrew Jones <andrew.jones@linux.dev> wrote:
>>>
>>> Import Linux commit d1db4118489f ("checkpatch: add support for
>>> Assisted-by tag").
>>>
>>> (I should have used AI for this, since it'd be fun to include that
>>> tag on this tag-enabling patch, but sometimes I still do my own
>>> homework!)
>>
>> Personally, I don't see the point in providing free advertising to AI
>> companies, so if I had to choose I would do "WARN(...) if ($sign_off
>> =~ /^Assisted-by:/i)". It's more important to know what AI was used
>> *for*, than what AI was used period.
>>
>> But I won't complain if people want this patch.
> 
> The process is now well established over in Linux kernel land and we
> encourage kvm-unit-tests contributors to follow Linux processes. The
> motivation for this patch is because I just queued an ARM patch which
> used the Linux process and it failed checkpatch. I'd rather checkpatch
> succeed than to have to tell people to remove/modify the tags they're
> used to using with the kernel.
> 
> We can encourage contributors to also add sentences stating how AI
> assisted when an AI assistance tag is provided in order to capture
> the "AI used for what" part.

I tend to agree with Paolo in that I don't see the value added by
these tags -- except the free advertising --. Besides what provides
$AGENT_NAME:$MODEL_VERSION is likely irrelevant without the prompt
used. And even if we try to reproduce we would get a slightly
different result :) Then by the time the patch is committed the
information is almost obsolete.

Anyway my 2 cents.

Regards,

Phil.
