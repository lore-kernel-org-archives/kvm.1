Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48A49CF21
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591987; cv=none; b=EaDTs4Td7narkKqLmoCWjiWzIFi5HmcblPByOby1Nosu0a6/8EM3U7+RQaQd2pq6S7e5f7A2e0dQGDVshtcf4Xa4QxRov6WupKsiKH59yVS+Iqc/cxtgDkgsVd8OP3LaVA87isPAOST3BD6kqWlgYxqAPMQLb/GbtcMZVbZF5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591987; c=relaxed/simple;
	bh=Y5RaTCcN/m+B3WTKNUCrB27XMo1MAttjFLpbhr5HOO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGbV33HTdbEIs5Obs5HTZOMqEbsOgLNebcpLAa2lhpbwQk4qogghAFIm5rqj8WwnLnPjM/j4oSU3+U22pvYRq+5tlv1iuXnQQL0qEhdMFfwdo9PtUB22FlZIUx2MYpwVsggbqAAaGYXdZMJfjzLAmG5cDV99eIzor7N3sDPHZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdZFHXD/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XDNnUFlK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdZFHXD/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XDNnUFlK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9M45t322560
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TMqT+pNe1u8+gsjWsBdnfHCPm7gBPI7oINOv8dEYdgw=; b=JdZFHXD/o7tCUCX3
	tPQPJJNwufdJ3QfVGO1+TwStMcsC7gf0mXhh1sPlG91HMDqSFKMVS5fJ86QsqCk0
	Y6MoQvVi7QdGe5rwM5HeNckpTY6raDSQmCw5M7ue9p7EWi8XG3dQcNA6JqWPbg4e
	+b9Qtfkee43DrYozCQ/z2P3HRbCh0TeRexxSWBisWV4cOmuUklj5phr7h0Y8wGpv
	5eka29LPjKIJ1aetYryDOhflRaClotuQg1MGhJojPdID0GhRW99iTKMhsvXT0kec
	KI5dTdTIQS8a67ctbPh4lXG3kixTvuoNTNhoYP6MQqB5KkTqZBGhACgOfOJ1mdzh
	RXQ9Ow==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1r6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:39:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a1e564fd5so567590485a.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 03:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790591984; x=1791196784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TMqT+pNe1u8+gsjWsBdnfHCPm7gBPI7oINOv8dEYdgw=;
        b=XDNnUFlKw648DObmCTR8RuPhUQVTXi65Mh4c/zqf6qxEnZmfU/B6ISrSZifJrphj52
         1K74PlKGs6hHo6y5DfhjTGjSxwFOnYthoTUyozFpIg46AMzr/G3grGmGNbBjY3gq5+PS
         j3CaeoXfJp7vEozBhQSwhHaWvgiqadIdP3OdLMaWkdo6ZTupgh6bB3NVdzemPZ9RNQ5z
         2uKo0kBSLEaWf5hVPbVBKFNY6blzU7nEM3bJH/xyUt7uT+1wYC1o8hFnbJkoBc1CZaOT
         WZFUVdZyo1fbbzfeI8kqW32EjF22u6irkUPrfUsvv/8UhOq100EaU8I02GDpX9FjdZQV
         Cfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790591984; x=1791196784;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TMqT+pNe1u8+gsjWsBdnfHCPm7gBPI7oINOv8dEYdgw=;
        b=cUMfxJE01fYoAA2Vg56sU3EVUulfTLue6xqWZAkuddfNXJPObMNJqUuZ8Z1Nd/FlRn
         v+SFQ5TpvBerkxveTJCBZfUVugS7pESmDg4A0EdSd+Glhe/qvxPrXwAbywDhL1jW0MkU
         4qlc3fqrKHJdWUfuV/cCWKU8ED0WlXqbnmqtGlL62OyRbjJi5GlBCT9I1+uOk8nvTKek
         2Dk7UczN2ONFe8LwHCDr1T0PV2xAZ7sFrGQITFljymae8Iq8zTkrANhPyYR80PUV9yyB
         w5VFkknLxeLgJaVV9nRBEFNRoZALsZQDIuLxPTjYgtwU/BOpAHJL1y3CODjyDVXvTvN+
         ZK1w==
X-Forwarded-Encrypted: i=1; AKwUvByjGY1yAmBMm3j5psCZ1quqUVbYKlb72OLQHjr+E18S+azZ2jIpqTQMzjEMywxifwdnf5c=@vger.kernel.org
X-Gm-Message-State: AFuF++m0o9AOOfqvon+aNqnSwvxM4FLJQtmS/bmiXry95JKkJGp6KaDW
	SHznu8FZZpaoj3mV/GwKkMV+gETIkf2XZkGRE3iyjiYiy7fsoJN6vMa+ZOAni1SPpC/0TPgOJP2
	IYGUdTubnwUvlWCGGf408Dn3AZLFZgyApKZvFnHDI0rpB6/7jIKSvTwc=
X-Gm-Gg: AYBFou27NnKOi7aFZ0LnnijatFy6Tkh9GUUs1oLXf0tAfN+qCx4trGOcsBqbms437FS
	oIazLigoHrLPWXP2m+IZ2R+Kq+aLv914T6aR3+mOfLyDsT0jhuNphRKQvGogsFGwaY49bRCvbnr
	VyWZ2tYJCeXMxVHcpd/WXCnwbIKDCBCjc4NLnrlLHlUuu++DGk9zyc46cK4VC+1vgKWmrNRTm/s
	V7my7u+VNZcXR5NLYEdV34ikxYnwvjGpgt2iOZ0yv458rUwAhFzDH3r7wzjXx5u9ochGpRKB8IG
	HNh7fw3npGc/8w00FKD1HBLmWZ3qRh/4HKKrlmPZMhjfbsrO0tMMIgdOTHq7iCSq/8uILU+T9hP
	P820r9JY2SgIY6M/51illOId1RJ91nRDOlA==
X-Received: by 2002:a05:620a:2614:b0:93a:2bdc:cd57 with SMTP id af79cd13be357-93c43b7f72amr1961054085a.2.1790591984004;
        Mon, 28 Sep 2026 03:39:44 -0700 (PDT)
X-Received: by 2002:a05:620a:2614:b0:93a:2bdc:cd57 with SMTP id af79cd13be357-93c43b7f72amr1961049785a.2.1790591983514;
        Mon, 28 Sep 2026 03:39:43 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001915fc2sm127462375e9.14.2026.09.28.03.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 03:39:42 -0700 (PDT)
Message-ID: <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:39:40 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-arm@nongnu.org, kvm@vger.kernel.org,
        Thomas Huth <thuth@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com> <aro93NuZBXYGbD33@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <aro93NuZBXYGbD33@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HN6hQCYRKKDp7UNId8OWt5f2g-iCfVia
X-Proofpoint-GUID: HN6hQCYRKKDp7UNId8OWt5f2g-iCfVia
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfXwWLnmLis6dkJ
 NaopLVDXq5Ef42EsTBmEcfe/MwQuw6ych6yr99th2mGvQ9q001+BYYLNVhqR29rQPlQY/9CDOpT
 ars6C+KgXZ2c5OMSddff1RfrKlHRr2Y=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba43f0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=KzZhQ3oIAa4MhOPPK_wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX0OEUV2NH9WsE
 nLepP4anJcSgshvNDLz4+OwFd2bgnR9CjdthuOP7rhUTVqKNFU9aV/+hAYBKRYBkBgBUoasYEPQ
 sQafKNtpkV03XCEKpRemeuKVxWDFQdN77A9Et6ua3QtL2xbEmvWZTbIOO6iM6MYAU8i2fbkCvf2
 j8KGAQlkHw4JjtTUMX+MgmkQ25Q/CfZP9GcWPLnZvLBt/v5gou8D1gDaxWC+IMuUU07IELkyJGU
 dxBX1G983ewjK42KHaDTi/wV/8PWGTZ8PD+hJA8xbNO92ppwie/yID786rFJx+Q0B/XagTqhCDZ
 tkT8RUpwX06NfhxNTyMGOuVjtMD+6l+v9iDkxFpqUBUdhj+Ty6s6JHugf3Vp0RQeGUJuAvgx8B7
 yIaEwZOlPxnASHhySrT2UqOyHrQJd+YHb7JS3VYzx9wddTjv3FRcYuDxTekid4tFcHz2jMi6Pc3
 mjtI9I5GVRtTwVZCOTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280042

On 28/9/26 12:13, Daniel P. BerrangÃ© wrote:
> On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
>> query-targets lists each linked target, including none, with its
>> arch, endianness, and the machines that target accepts.
>>
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> ---
>>   hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
>>   qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 65 insertions(+)
> 
> 
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 6aaa2af709a..d8cdea6203e 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -307,6 +307,41 @@
>>   ##
>>   { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
>>   
>> +##
>> +# @TargetMachines:
>> +#
>> +# One registered system target and the machines that can run on it.
>> +#
>> +# @arch: the target architecture
>> +#
>> +# @endianness: the target endianness
>> +#
>> +# @machines: machine type names, not aliases
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'struct': 'TargetMachines',
>> +  'data': { 'arch': 'SysEmuTarget',
>> +            'endianness': 'EndianMode',
>> +            'machines': ['str'] } }
> 
> We already have  'QemuTargetInfo' struct which is used
> with 'query-target', that should also be used with the
> new 'query-targets' command.
> 
> We need to add the 'endianness' field to QemuTargetInfo.

Why do we want to expose endianness, and what endianness to
expose? Endianness is a runtime bit state of CPUs. Sometime
this bit is hardwired but that is an implementation detail.

See commit 0e2c5647d92 and surrounding for MicroBlaze for
example.
