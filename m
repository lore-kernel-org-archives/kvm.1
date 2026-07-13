Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA393ACA6A
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941405; cv=none; b=kq9JVSBwYAxWZS//fXouZeklbF4QRYTPL1GPGYDM1bYuhu+Rksafz8o8Un9MjVJNh8wYO5o6YKHvaexpmUyAh2VOGtsryn5G6CLNA2i8TQhrdnRpP1iyvcO/rOCSgVID015IH45s8EwS8CKSDuZUyjwGQXF2CpmckEQOAuNf8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941405; c=relaxed/simple;
	bh=e+hddOMdukgyjOE3UeN1cE9NFWLlxzrqHB7SiMxOO+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xz0Ij70l4qX9nKFZc5KKb2BMf/rIYCq92KjdI7u2Hr/z7Gf3eCFqDQ6ohqN6XEQR9TkLH/epYeoeYHPuvgjD+y41zUhIRVZM7wPbxzaSlEh1DNcrhAnaj+b82RuUuuCbo4Roix062SL2Yrt6bC5O8iZb33hpXnFBGzIsDmvM/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oV2htQlc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QyH4yL9+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oV2htQlc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QyH4yL9+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NkMO668651
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xyErPye3cFw9bWjqscackmWoqS9hSImRguTgCL92V+c=; b=oV2htQlcnyRpUOfP
	YPRcldT64hGiVbzsbn9nFvbUo5J5z7zMM16npeleCkOP+vlcJ8bKEa4C/q9i7wLw
	Wh3YTIeoEbUgMEZDCIZz0wqJkC4YGefgzyo2H9gIEHTh4X6gENdAa21Hg1o4Eho2
	AZ5XbVvhxgR5FPY/9tkFzZRHKH8cFjC0ausbEwRQxgoYFLY5msAnYGkkXtNFCfsq
	oyPFcvm0/SeXcIuCbf47guqJwgkCAajh7JvIVpi6/Pw/EoYPtEYG8e5kEg5xYVnV
	tFd7UkMUYkoeZkQdQAUlLeWnHPN/zxnsTGiMPZ9t+Zm7Xwun0v6KPVbu8VxzSQ3f
	OoJ8wQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm281m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:16:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c083f1818so42233561cf.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783941400; x=1784546200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xyErPye3cFw9bWjqscackmWoqS9hSImRguTgCL92V+c=;
        b=QyH4yL9+OZBRPGTSfbr4MgMQv0H3re+JgUQj/DHs+dPfw1k31xQGFbnNPahUfzECJb
         6qZoQMJRHwb7Q58HztRzhZ1TDjEoWyao1gzLPvhdzbAs/Wv+P6HJ6Gwf868b0jD+2YAT
         8CHdjAoj6o6rc0JheVtDborwET0vD70Ka0TuhzVbCEKrxLlsvpwcMfuMYXcF4hRxPJsx
         kbXzFitlry+su8VdYpMkPowQVdqcpBX8DMzwuA0+wjcquk4oOd/1yd/0z6gkknQB0A5G
         3O1LH/opD0fGZ1Lu0ZqRmnjq4R3uOPaQjvsOHRJb+IWF1XqN2pkEjQlDClbtXTKaT/v1
         k/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941400; x=1784546200;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xyErPye3cFw9bWjqscackmWoqS9hSImRguTgCL92V+c=;
        b=ZXb6Ki9qID9+Xx7/zj2mtzPR0BT4v/KzW9cVlX1c/GRZPwxTUcrgQKbzVNVq87bXI2
         xnaVbcJyAypidAXy4qs29Bj6XxB6IWqnGSuqHzRuvJEwmLnnPfcWuw3Nl7cESFSIIk4K
         9sQWkujV9OrNFbjGZmcTWfq6sYiVFxYI2IdAaDnlNR/zgKFxmlHG+xYryht3A6UTy0M8
         h73p3ogJe5diaDdbq6yGgWhsCtwyRPJUcB+COmoyCTHWgr94jg8omhCmDNFTIMKXyiVi
         vEmqsbkeoWAO5Q7Rt4fcN1WVVdRGwlbYlpGvMdwSNFPQPlMSPjnAcSWPEzDh2NLvyEFR
         dROg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7q7U6zVdj/Y33fP7F069FzSkjctsQ2RKwzdybXxe6xAwU0wIrHiqup/oJkvYttVxZ0AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyieUGw8+upJNaa9v4Qha4NbTk7rHr4Jgzm6kjYc3Wt+X6tFq1
	UAtQpq1kNytJJ5uEqI5xt8e8jmwKiOXBPpCf4Uus+YVAW4PC/3+XoS869NDV+fhlKH2vOXhd/1Y
	/6igBeJgdnb0WZeetmDi/h5iHAoGBpGki0G844501WIOaEkQnWLt7vpI=
X-Gm-Gg: AfdE7cmYyJ6FTGiv2dwO5uo/zWDrrD9OLaMqXdKeWZ4i2DAzBCZsFsV7ixChne/R0y1
	3zLJ85FeElIZIWT6PWMhyhg3GSoAx864IIa687qevNU1mZZ71GAyja6trjNnTSh6Tp0swg2Gd/E
	AyfRCPKPEA5zPRtW5y3CUXGo721NH09yr8ASBwRqGHiB3sB8BB4JM+hVEaOYpxVvMgMM8HmrHHx
	FWGY7jBvMlYk3IjsD5aW2ngQqWVp/UB6OfX31UA9dyu8k7Y7RiGEuHZDFIHYK3je8vKrD11H+bW
	y0+QvsVjl7zaN5jcehm3OzDLLRY0n89AYfv3ZR8juttHbqWfDEH7x1aZjcnbWisGuAw5lr4aCWo
	bLDc4KIQzRRY3Bgmz5fyZUOl9LjJIqL2MX3PudDdVn1zz+zmQsZ2w9TJuPFrziQ==
X-Received: by 2002:a05:622a:552:b0:51c:963:cafc with SMTP id d75a77b69052e-51cbf3153b9mr81924861cf.41.1783941400613;
        Mon, 13 Jul 2026 04:16:40 -0700 (PDT)
X-Received: by 2002:a05:622a:552:b0:51c:963:cafc with SMTP id d75a77b69052e-51cbf3153b9mr81924691cf.41.1783941400292;
        Mon, 13 Jul 2026 04:16:40 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm85251462f8f.15.2026.07.13.04.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 04:16:39 -0700 (PDT)
Message-ID: <37cd41d4-cd36-420e-b6d7-a0bcc1590b96@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:16:38 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ui/input-barrier: fix off-by-one in keycode bounds
 check
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-5-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-5-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pYa2PRMKYmuOgVL8Zy3wjlk6fhPuz0w_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX7zoSd1amLhcC
 AExV/zAwZXJQXEorURji9gJUoHtJpwxaqnzURp9uHAtxqEywjCPxr7CfuG80sQlO1SWijJPHRcU
 NPPhz7IqAON6XINtvecMLI73CsW9T0UWYIpeKonkoZ9CpvSfGuJpBTS7ytNwg+3hBtaMd4RAiyX
 lB71b6wkQGhxxZtqG3XItvGM8HLK+SXFfYmkKAnr/uSIqLiapt4XqlOa64pUZDaz6YxTohlKIP6
 /hKpBznIrifhjI4qAUdVwnARnNXWDHSJscgdPuCE9locWwy0PjQd7u2jKpSv7y0S7bUT7kJtIAS
 Ynf/7/S1VbKLjqGA5/Ynk5jnlZKX6VlbzT2S8kOFrU6lgt1hUItbNvJLUiHlauziOkDPWjNUGxF
 LKgUWahHi9Md8rs0efphTnp5HPoGQ/U8V/K8jk0wfiKVNw26yuGA5dTRpnu4mtcWNcMOUKfraYG
 tDrwNkRRFWSELqUxKcg==
X-Proofpoint-GUID: pYa2PRMKYmuOgVL8Zy3wjlk6fhPuz0w_
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a54c919 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfXzqt1abibRlKS
 XEWsUlpJiB9m6wlVmJg/d8kTJW9khrYOV8cUbWDv7OKzX2BJBU497twzoKo3YE8NThi5Tr6I/5C
 W0UKNhxsbdHUlkdKpUAslcyGVemFm2k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130117

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> Use strict "<" to fix the off-by-one.
> 
> Fixes: 6105683da35b ("ui: add an embedded Barrier client")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3951
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/input-barrier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
