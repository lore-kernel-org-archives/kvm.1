Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425700;
	b=U9HO9x2nkpJIaLQ0eoSI38wjJb8R3AVTwwAdO4bB1+fFYgpeAXhKPhQFgiymhjMsALJB
	 hI7f7M6oAE4yQWL19IVecj2smITgHU+Qene0x0ueylwc05LZYE3Eaoo/F1c1+iWDiuybW
	 J67liRoqAG6knsuLNsavTO6B2iaB70f53zLL/2bpax/mlAA5End7gsu5jb3W1J8ZIgvVi
	 wCD72M1hX9l50gO28x/VUYS+sFvMJKraUX+o5k3m9g51EN/7VY6jDaj9x8TcFYw79RQ53
	 ZNAzp1wnksNxuvXa6WoDNjBAqxUo/vHUKa2nskFQHV0Zbzg09KvwcYQiIu11iZpyAGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425700;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QC9xCOK+f/jHXxb9ySYvKpqdWbzsq981kopxJgUWmKs=;
	b=Y4hQQ19D4lV+jWit899TS/j4SXHfK6nhcGrv+FYw/jewX9OBhf7Z89p2RMPmT4V6TNSp
	 IoAv6RaPv3EPly1EY96+u1hIiXrWaputZ2nS+PiTytPVrepDcH5O8zSMM9atOXcudqMbX
	 cBJcpSpR1I5/Qa1c+7ELVGdHOZKPMKrMk1AXjTppELL8UZ1xb3csdMhuJjRtqdOtz6+qp
	 qqBupmilCDuKQWjBMVQCeS7f7psHMGIdx56iratTv2OElQaSnzBOIvWIYug9fazBC6EA8
	 tcn2VfrTlFGLQMRlKshdVEFtdsVe5fVIYI198WZwwWxJXzeIUvHlzRk/jP5ZQGHVK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VJ0WNv8V;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aGHH0HZt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E0606C922
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 16:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8E0606C922
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VJ0WNv8V;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aGHH0HZt
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JFPDmT3675001
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 16:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QC9xCOK+f/jHXxb9ySYvKpqdWbzsq981kopxJgUWmKs=; b=VJ0WNv8VbS+H+h/u
	1NAHOZqZPnNmFGTMyX2Cbw1oHOwgUJ13aoeNDiBvJSCLpJctWMdhTyYyoAYq2wvS
	9K8CsqSrWYGERhhAVJMKqGPDG71RaasyCgNRTLmb39tPJPbR9p1xm2ynaLpKHPIp
	I0mOYwFrbLzV8NYQPcoURT2Mo3ItzU//Pql/uFA5y/g4OkJYJoP599w/xNOsP7+N
	BkRq1pgGO71ktRibvL3dMj089x9G8/D4FeQ/777916PxfDUMCc5O2ewWW3OH38Kj
	st/UTHD6abMhBGL0Y6grXuIGrNLGF58Gj9g3sMHmONs1Qyxei7YkmKVi6ik/lokw
	hTHYrw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48j0mn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 16:01:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510d0baf63so5852488eec.1
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792425692; x=1793030492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QC9xCOK+f/jHXxb9ySYvKpqdWbzsq981kopxJgUWmKs=;
        b=aGHH0HZtVMcoOhYQlBIx6zdX8kdykgsElb+vQl1YjSDiwHlN29DvmbolmfE1dZVKid
         6cW3MXy3xi0alyIntePoP8hTb/AgIQpvKAN0xCGu/P2vQEokE0An3E4uycWvaRFqU/zx
         aaBxRBX0fZayb8BbIyBm7wsoiYwraenul7hHuo4Lyhia7xfWnZQGg+zhE/IEjXnzkURe
         Hzq9VnX8A8TQvxwH1U4+O3zXBwKHPgG0qd2EvIL6NxOiskltFmZ6Rxo493Fy+hW/7aDf
         SSTu62FtzVWn7yzo4jx054VD+AMNdaX2Q6NidNA/E8M9I37bShjtL9VOLStbwVQwcBLK
         pVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425692; x=1793030492;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QC9xCOK+f/jHXxb9ySYvKpqdWbzsq981kopxJgUWmKs=;
        b=n7lW20Q7lgHKPWFPRU8XWa/q+hfMw81T+3i+qO3ScK48zHGSRFovPPkFsWFyUcgu6S
         1KEqvmq673M3nC8pXmnIWxHDy263djzKhh1ke/GsaYeTc9ryAe/U7CikicNrFfWyt9Jr
         FwwBU+6cBfnAugc+T7UHS/3Xdcl/JF3/GdJmntRnwKaiCEg9+QDOv5X6NdPzo4f76vYy
         R3xEWem+Wkv5IYHVjYep1Xb8/9PTHpg7TIrVpM2FKkICz08PQY2nT2yy/1ZChH2ltzyr
         SKXS73LjB29HdC5cw/cVn03+smWDuEFK1Pa6s4u7xF6PIalB4FZeTxq1P0Ya256PyOG4
         UNOA==
X-Forwarded-Encrypted: i=1; AKwUvBwzDGU9BFgEsF82ggzBSLRN6lEJqNmqO4G7ENSPoXASMqu98HGXYq5xei9i+tvgbaMdRrU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOF/eopBJ3G+x08kBZ0OCGSh/rz1ZWkcY3d0iQo3Mv8eZgTbSM
	syj3hJ7IU+3b35MXFRoUvYqWUrbnf+jLtEZzPAg+H8ce0NPIbKHgvMcE8CHoqmf8Y/JR6ZGmnhG
	87n/EDsqloPAQzRiAuaFiJzF0oBOJ4V23nZIXEb0TkubN8evZAT+1ytlXWivAJtQ=
X-Gm-Gg: AYBFou22hfRlgzn4Yy8E+jomOaxtATtgC6tak3O8Dhm48YzueJzTyjlklGWZc3XEXAc
	BflOu1n09Se2eB/USPc6Nj5HWC1PeHPdxwssJJHmyXcq67Ia+isKhCI+tMjAHalAh931DFsspcw
	G4kT7fzgE9bQ0qHagsQ/96p3uTetuGdwPhePmocDe8NxNXfiuM0JmoJIPfdMOGumjoBkrYqp6Pi
	Vkd7lDetYU7mg8Tz94yf1KxOJQvnn/StU17xBxoimwSKEaxZ0Qez8kxqzcZ5sHq5zGSYaS5l1gy
	APOuqDfDu5r10UDV+AzygeTTJarZdmiji9/sE7azBDeG55UGE/GDcdZmYA7zmy9VRw2aXSZO7xX
	gQdCENdGKILywhHhfnLFvRDMWlPXXZtDovMNcevzEHYGvaXd6F0eiPXPcIX9PEdje8u6jkQ==
X-Received: by 2002:a05:693c:638d:10b0:359:8492:20ff with SMTP id 5a478bee46e88-361a1270c4cmr10867495eec.12.1792425691580;
        Mon, 19 Oct 2026 09:01:31 -0700 (PDT)
X-Received: by 2002:a05:693c:638d:10b0:359:8492:20ff with SMTP id 5a478bee46e88-361a1270c4cmr10867456eec.12.1792425690814;
        Mon, 19 Oct 2026 09:01:30 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net. [192.80.163.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm31303112eec.22.2026.10.19.09.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 09:01:30 -0700 (PDT)
Message-ID: <bc7f368b-ffd3-467f-b1a0-fc03ba60ff6c@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 09:01:29 -0700
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
Subject: Re: [PATCH] docs: Clarify 'query-kvm' deprecation release
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Markus Armbruster <armbru@redhat.com>, kvm@vger.kernel.org
References: <20261018230305.6239-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261018230305.6239-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfX26IjCo3oZIzD
 CIXnRvsIyQdjXn5pRJlu6jGzKAcaht3C0XtdZzKnRjUbiYzu5yHqmielJWkD2FfuZS/RBRNNmKV
 A987WGppjPeMZ27J4dxEWgDDwpuOyJoLnL9PCBB3m7k7C2FSJcKlCJ/1E33s5LLbVypXTHPUnRM
 vmNaPmbMG+IVevrfmf9XiAcVYGdZqOaYfX5oRVFf8RsQAdpgc+1PtZxB5OSDeChNCMdZtnev5Ty
 TS8Fx+5UVX/yFsDnvu7kBsnA2xbFEvYWmjZltQxcRsiJql4mKXY93SEQIVf9dI1qm2Eu11zqpNQ
 neaBMFh8rYFgQ1RM6i+Rbrrx0S82b+8Pw31GgIADifFuKKKcqFzLDoPM9/sMjk/+tp8meiOwiky
 vU8pNT98svxGcMFRTgKZTeHoSSjBFje4TDg5qOTPDhZWfYwkVPAy0xyIK+62wWhExJSZZLw9oNw
 MLYBEDKwRYteX+y6UyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfX1/wgesVbDNvJ
 iOroZnIRLMBwDcWAkUolNBEOQQaUJhoadXv8TLpELK5yXZMpEiQTjS+kdM2dHOmVewY9KNjUy5r
 sqwLElyz3TfLY2ucOOh09QcydJqsnhw=
X-Proofpoint-ORIG-GUID: HguTx6vKpCveJSsjr4S8BNyCqMl6Zisl
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad63edc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6zmBB6n6n2PSzIUxsucA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: HguTx6vKpCveJSsjr4S8BNyCqMl6Zisl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190063

On 10/18/2026 4:03 PM, Philippe Mathieu-Daudé wrote:
> 'query-kvm' was deprecated in commit 824141dcf48, merged after
> the v11.1.0 release. Correct to prevent too early removal.
> 
> Fixes: 824141dcf48 ("hw/core: Deprecate query-kvm")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  docs/about/deprecated.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
