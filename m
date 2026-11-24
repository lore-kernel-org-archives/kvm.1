Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563118;
	b=V/5PcaspwcnMsyCVEvGKBjDEyKc3nWBswiWaKGt6LHV0LZoR9XOrFM+RxwiT2Y76nack
	 J0O6W5xa38qhPYWBI/ryLNVA685yUWgSax4cvz6fqB885GIZYn5xx+e9Css7Vjg6ibIWu
	 tnt6FoT4PjeRf7b69CF0ODvKbCmDmqUA6/xF4CUGoJRdoSAJs/cdQcjC/wZVcT+Y16zbe
	 Ejp4fbdYAPzbEk6KwWFAP3dh2YsCFrzkrBS2itc7v6bwOlBYLH96Y1gNEj4XhewRcEg7W
	 NWKs1V+PEXpoJrUdJqzbuOa3vYB0AA85CFRJMM0wgCV5kxZzfGh2A+/AmNQVSgb0lKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563118;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G1ZAm7akP9D8mbltmYnzmqncqYxXc4x3mIjxdEr9bU4=;
	b=aSY/o+U6hQztpS7paAahgVjz6++6E9DGChpVG/EWuyaC0V0grGXUAQpOJEbU4rE0ukwi
	 Xu28YyHE/Wl3kbawX0f4UxY7QRdssAQmTGjz4+VJld9AlktbYvjwxAsi+H3cWJVXqE4hV
	 tZck9Yb9gmnn8BkPZu4FCbBSd5ttK7bXg5rNbM7THPin6YZCF+9/NKBpNan7sJsig1FE7
	 7V849NfvjBsg+vGAhz14OWqeLkrK+HQvrevIL0+nzrfAQx0iXwrqAYo5sHYmSo/krXLGM
	 /euNzcT2MaUIZVNoVqzvxKizZnKofx8ExuYF4asUWxq1+1x1zCyEHEcummZPehtn3CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YdvJDNZU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="KvdDZ/Jj";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7E606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A7E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YdvJDNZU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KvdDZ/Jj
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOMaxgO640514
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G1ZAm7akP9D8mbltmYnzmqncqYxXc4x3mIjxdEr9bU4=; b=YdvJDNZUyxhdhS6J
	arsYzy3lKCqdBPApC8vjWOmux1EIZ/i1OW6ayttqTLrpcttLnVewWbiIMUWRLJz0
	RmmzuEZZCfCRwALk8iiU5w1FrdEn80w8EaCCPuo1QryLIYZsv52MaPN7dB5/Fx6z
	l6jCl47R23yif+/qQfkM5FhT8f14UNd2fOQ2jupj4TKMNHZrqVPmmT6zOyrtzDL+
	5l4JKsIwHiZQIhO4ZAJ6D3jyEh4dbR9gTyjgAnpZqeLCk36mMOeNAxvWBa4P3WlY
	+e2yGHnhMeCh/SpVzWeo/Iwoh3bYrLMJDCh6MNDsq527n5lkVfRmsYCXMJgLDRBL
	uQNQSA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5effsfua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:31:56 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b4d1e90b9eso43140987b3.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 15:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795563115; x=1796167915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1ZAm7akP9D8mbltmYnzmqncqYxXc4x3mIjxdEr9bU4=;
        b=KvdDZ/JjUazEnN/IDa92TBmbwH0tmeZ1mRtCjdaNwdAxq8U3Nb8PkbKEUEY4A3LV2B
         tQPyGuKdOysokDn8P01IoI4qL1dcj1djIWU5a5YcMkxQjk3hxov3ibtINd5CFKS/Sxat
         YeIYso3DqILXchIwV4kE2zIspvfkaWSK1Wc+iDT6P1OK2yJHDWngpQBmg6ALBt3xdyxH
         MeunH9H8JIAbw6tBRoZ/nha2C5MZHW0JDthb0ucyKqNHhdmoyewrpc5goVFJTP8Ne8vn
         wsWANoLsSZuwtiqHIUya2n/0PTTMmq2dcvhhx///UTImYrV3zUYV8Z2kiS3B/0lgNAaR
         +S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795563115; x=1796167915;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1ZAm7akP9D8mbltmYnzmqncqYxXc4x3mIjxdEr9bU4=;
        b=KlGhCmcF3gebdvZMnjoM4i1wFthemQCsNFSBcqk2jWigpmYLhajsV3FqPRM+TmXJIS
         bzaaptkJoe3PJDIzNgVxdkA8wroEttTYKi1Cd5tvhDl4DaCWA9CAbzMJqHIlYB0AmYti
         fHzbo4jMFrEzPHRwked5e1S9yHYRQqAffhVM2pQmXEWLzFFMSUcSwAIKtkuXflpmbjPR
         UDlq06hU4dH5qlr4Fi+jiNTwSnokcw7lCndkUwrn/SC54icaF1LpxoPclsYp5ecG+2uu
         XXcMw2iB/rsmXMJZNo8YH2WgKG3HzsTntxpBGoSNVae0tlUFfNexTpwMYBSIlNJUyQQU
         VvDg==
X-Forwarded-Encrypted: i=1; AL+hErGw0xSkGXEinmm6Cf+VBcLp89fDguJzqvahYSkf7FcP+DrfnbiRpn2Xh6scDs75YjtGktc=@vger.kernel.org
X-Gm-Message-State: APuU4Z88W23u/nw2gqBIyrt2H+cDBb0ASu8TvYLi3v1fgjTXr1FWtfWb
	Z57oa4/GbH6ylLb2cZIaShqApx/trQozc1c2vUGCHcMVq+RV/d78vpLwIGnNA2lgrqxyWgcfXZn
	g/Ssza7fTvBCXTsUAcPYH3vMmLVt2U4tWevzxkCEVKHsCGrmg1lrcWOs=
X-Gm-Gg: AZFdTZfXUP/zQ1qoxQpadJPqMUSIO1OfW5hnEsrVeVroGA0ds84vBiFFoEktlZtxUqp
	IyO9q8PW6sYPG0uhihVPZP46+mmxuHZ83CuaG3LGUaY90QYK3NGDdvRWqG7nBI09Ue6Fa0alEyo
	bhkwppPuyyayFcF+fgwosM9T0xTDUeOQRL/tR00cguqYVE8GJ1lUt/HEiXcyRC1I0trf74weJos
	oknbaFPj9I9ta4d2dH+MPC64fQZjf6UtfjyJ9rE80vWZC9W3YwTmOkuN5WaRe2NxsMuVJO7pwov
	Qq542pgEGLyCkBsL3Cj7yHaNMYe8P4LLiLB1wuKoWJ8Q4TEc0vaerXpcfQGI5UCuOpAoHHclFlq
	BmGf6PZELAIjwMAkuuuwH40TrtGuzQunwm1UiQqazsVt6eyz7Mo7wMo4x7190zD4MoqR/yPYi0H
	ebVVSD8WI=
X-Received: by 2002:a05:690c:e3d2:b0:873:5c0f:27c with SMTP id 00721157ae682-8b5204ad248mr71151017b3.38.1795563114695;
        Tue, 24 Nov 2026 15:31:54 -0800 (PST)
X-Received: by 2002:a05:690c:e3d2:b0:873:5c0f:27c with SMTP id 00721157ae682-8b5204ad248mr71150797b3.38.1795563114026;
        Tue, 24 Nov 2026 15:31:54 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm29788684f8f.36.2026.11.24.15.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 15:31:53 -0800 (PST)
Message-ID: <2f326926-16e7-478d-bc57-86052033199b@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 00:31:52 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/21] i386/xen: Don't inject event on invalid port in
 qmp_xen_event_inject()
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Maydell
 <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
        Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-10-dwmw2@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-10-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eo5KXYpX c=1 sm=1 tr=0 ts=6b061e6c cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=pBOR-ozoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX/KM+S2r3zN8+
 uB4OV/wchazi9+EWjDzAcbb4eCTmGrUND0fUpLLFJKF+PpOz273/wVBrpAlZd5Jd5LvUg8Ghhpw
 3QPurtYfx6c+/+62ipwKbFNLFMljILAVsFQnoe/csacf3Qqh275E211/HXNqBOHjlfEj2hCkAm3
 m0gmYGRssaW48WJBzDxD0j+REiMVNmjEprM/9AB54VUuevU8SzEnM99xJ7/KdkIn7Ia4wuxa+bg
 9ZWgC05MIuvNEl8Grqt0FWqvpjY9H39yajvn2Yg+CfvdjkRNEu+69SU3QTm2Ca1Q2hbsGAEAgJO
 lRGztECJIlHWpNNKe/QaEy8dZtz7Chzb6KgcNQuEbluTQFHw9o2PKtLS0reAEhtYWva+X4/Dy47
 n5w1i/lNRzN/n57oP/UYrpyyGH+l5cOA9N1Ha4PGC3HkGTjMEi8XvxcZMHwIzzpC4Ayc1ifapNy
 kWQwZEt8qWJUesF2oxg==
X-Proofpoint-GUID: zKeQ1qi23h-dn06_i5l2Vy4_BkmeXNkx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX5AaMY2s90WRu
 6Nz8+FgaEm5yxLMpBqvLT8dSWiOydTHtCjdq8t/cmHZ7gMKHbKyhKdI6T0ll52WRHwwCuB0PMJI
 gf7ED3OCjKRbIbzlGqy09Q/9dzj6Uyk=
X-Proofpoint-ORIG-GUID: zKeQ1qi23h-dn06_i5l2Vy4_BkmeXNkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092

On 25/11/26 00:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> qmp_xen_event_inject() reported the invalid port with error_setg() but
> then carried on regardless, passing it to set_port_pending(). Return
> after setting the error.
> 
> Fixes: 507cb64d6e66 ("i386/xen: add monitor commands to test event injection")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
