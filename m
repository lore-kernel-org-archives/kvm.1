Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125563;
	b=BwUaPXlEcwHJOkfb5zxhNEMNYQukpjqcduQIVPo8v4qgYypcG+UrRFyX6PV47w/qLKgo
	 LQEy92V2JP3ucjxsFIGzi3RIk3LWgESJW2FjWA1FlUhYzWSCs8k5sAE6ckyrYxmRWN+0q
	 12bcECNCuXzcM/zT+eyE33f7h8w/KPhyFEaXixjP9RamXTsT987hmmLxhNR1mJkPGT1je
	 AQCwBGDQg2z5FKApHheFd1DW307e7V7zPPZiTI4tW/tuasoG0swUZDh0ylvSrhXegirg/
	 nRjJei+GOUKWiSgg3WCXWTl/U65Zrs63Eux7t71LEJTUcdr/CDrQsIH0odgej4De1Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125563;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sBoNYG2/VLOCXr5s8H72Fe6tRbiTjTU85h25ejei/N0=;
	b=CN24uAk08fHOioYYYWW4AQ5ndiweoWYkqbf+oMrgPPRdHRsZB8YnqnZ0XnA/+FANmRVp
	 ni426xrqS5uKSJh64T6bVZqXwBUR8s03+y0wpYp+lVFrxdANlOZifKbWYTW4Psx9YRUce
	 6aAZTSx4R4cJlhdiwCmGv+iyimCSQpUXDP0vyxPvg7BlY7ip2HqbudSs42OOYbufxxTJx
	 hylYsUMzK9AR/kI/NXWUx1WbQd97HuI6G0XH0I/NM1ArIebbNDc1+ZmR7cSmvdlxbgOWN
	 eBFJyL7tZZ+fU/mB4XCwTtzbHBVTb0Zc2u92jOBgTjBm+U7VQihYLEqNQYRFwDQHw0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mD8CnZgQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cPis5dPz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8EC606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA8EC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mD8CnZgQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cPis5dPz
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIIJGn3486811
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sBoNYG2/VLOCXr5s8H72Fe6tRbiTjTU85h25ejei/N0=; b=mD8CnZgQxE1oa5j9
	qoKXWXheKVZzLxGFCQd69cVdXqPCuWdkXjtlYVB1vx1TpHS4ssqwqthhF4DWGHJ0
	pvrzS9FXFH9ZIjGLBLuPqbb6Qa23faQ7wjIwvQ0CHr4TVyUctIEUdCjtiGeh27fp
	UUCi0qykQM2tjuwixbr2fuk2AVp/UwYUVoZ8+gduFzvLxTBKdLpC6pR3tM/7q2C4
	XAS+3ilcyVcxwQQxbWc/6VcuUbkm567kosgeRC1AOdYsVsLteX89eCWUAAW1YYJG
	2xB17lmoRe6Wm2/gtcgLnzc5MVnPDGHTJR3QXJpWzv/WiTRrUzm7DDu0VkE1g2zK
	HkMDrg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtbujc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:26:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93caf7856ffso13298285a.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793125561; x=1793730361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sBoNYG2/VLOCXr5s8H72Fe6tRbiTjTU85h25ejei/N0=;
        b=cPis5dPzHqHsCNAQsm71uxAh5izN3tNX0ZGvX1CxidGF+X8Y4voxnjOAF4WYtlgoP5
         eKnvbjCzccclcGfoTteg/0R64Ew35K0MNIatbJ3RdKcq6v6hcUd0cl3L6+KVO6ENJr4w
         p/nY6BUMd63Pocz5wPb5TsZ3j0D3bG1Cc6rA6nlBNBdHUmZafgwdKTbUMINR8fR0yv1o
         1Bd0qgonr3kMZMEbQUN6IEi5+SQOUnKqCjbe5Q0HuFdR9Bnvkxmvp1t5NRdNGyp/KFyG
         ztVKSsXe4PwQVlBu2uCJ8vcFQggx8EhThnSekV5jCwIdq2hr+aSwlxycWWgarxcmlbYo
         M11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125561; x=1793730361;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sBoNYG2/VLOCXr5s8H72Fe6tRbiTjTU85h25ejei/N0=;
        b=iTzQRef9fTo4paCNdJNGXyT3uAIMFwcvENcdnAxOCKbCcG6UO6pBk/nk2jMIRj0Dki
         KbSU+Y1oAZpDNwo/onoqCmyUQHxG8pKdn/KvmNFvPOSFPpZYMGJFyImJ0q+hirsiS44W
         4U+uHWetuvubfvOKznrZVmUz40RPM1MsvYs4LON0+o/6iqyEM+fPm3969PLg+z8PktuQ
         mnYfc8aH7htmWOR1Z5a8fsAYNVT/mSxHbrksmImzIgwVm5Yv/ARZalgtCPmSCylMDGtk
         UVDA47LA8fKQAEgzmyaBuIJLVOwJ1Cy0M63M95tLzKolMIUUxJI5+pzlwvaxjKV4PQ5p
         CiEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5j4obczYPOZkgoUMV5ds040Nudmx13hnJFB6HVd53ZE39W/ST1/2EelvoAfvt8EQN9nk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/rGm/0ZALEe1ljrGn9cORL1Zvb+fc+XZAIAwSkWSciSJ5a+7+
	QpEg6RMCthp8nTxctgnCogfYfCSEmqOZt6Pw9NI1RFS8FuoaG+BPnY8021vOw350LKl5DBf6SlV
	8R+a5I/FFYZJsSsIpyPLsWkF9+aJv8Je8qzp4ueiJiiNvbCkjCRc5/As=
X-Gm-Gg: AYBFou3iME9pnnfB4PO5Y1WLgHwdeuyX/nyDPLOjbKBO1mdX3xvieKc8B1i8KZoIHFF
	EZ1k7axQCeoRETF95eTBLPi/vhEv1jBZI4oL2vYMyYoP/QinUdV6E+TsrjkqNOUnlg1NWi0gsbA
	cpDSqH/FzenRjikpM2tIRFdZlyls/qLZhu0U12hUKQVk/ufkfyoBrN5pFJAIo8kkHyEvxzU3A7y
	b1L5pWJjI0rEXqBknnfaJejqyWYnUEIdPnqpSB3+aRv+ExVsTpYK4/X/hviSLAHE73hSq4tGL9s
	gDyRBJeEWG5SvbAxWeiKoeIHT6gaFwxgzkS52iypkQ9C2VnH7smydCKNZ5fiLn7KwRKjx2Dtxlh
	I9Lt8UF2gKwnmRApdi0uPcAQoHtN7x0No/TwgqJuM4a+G08BqTw==
X-Received: by 2002:a05:620a:1b98:b0:93c:6f0e:8468 with SMTP id af79cd13be357-940ef8f0788mr1681989185a.43.1793125561053;
        Tue, 27 Oct 2026 11:26:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1b98:b0:93c:6f0e:8468 with SMTP id af79cd13be357-940ef8f0788mr1681982485a.43.1793125560576;
        Tue, 27 Oct 2026 11:26:00 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net. [82.67.153.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94c6d9aeesm405515e9.7.2026.10.27.11.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:25:59 -0700 (PDT)
Message-ID: <c5a02b34-d171-4329-b8a1-ce7562752ee0@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:25:57 +0100
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
Subject: Re: [PATCH 08/11] hw/nitro: mark 'nitro' machine as secure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li
 <liwei1518@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Chao Liu
 <chao.liu@processmission.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        xen-devel@lists.xenproject.org, Sergio Lopez <slp@redhat.com>,
        qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
        Bibo Mao <maobibo@loongson.cn>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Xianglai Li <lixianglai@loongson.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
        kvm@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Song Gao <17746591750@163.com>, Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261027181400.1752951-1-berrange@redhat.com>
 <20261027181400.1752951-9-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027181400.1752951-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX0ZqQZVS/VSZC
 1fle+08nbK10jZqM9nYfOqLKYFT5g+uu9Iux2XVItAR7ijVz6rhdSGxdZXJy0AbYvT8WCQ2cASf
 aAm2g8yO2K0OAnpYAHdSSwmNWt7xYbc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX09LQUAuQ1zs3
 zHp61iqLcRmILOF3UWKAvI2j6qO8qKAkdWLRtO3/AILOXD+IVdAilSEZq+C662OYzyN7/fnmQSI
 /k7YMSjVTtj1qNgGXem9QgDUmcr1JvN6qS2jT/7LJrkIdbIWHXepYu2avxBdTt+NVib4uHRi4PX
 3mAVIwOHjBcw3Om993GNLbGEMDcwLJLhbQlK5EHsUiOIFYdphPyIm0ROU9k6R4eHdHs/CViPryU
 r/CDv+FPkXB0sRlToJzJNGt134AAWd/CzlAlLWRpNovjtbxhVSr/lEd9rbzb9BJlje0Z+l3lL2m
 jmoBUOpPUfqUas3ipNNgKn1d0TdCxpmaQHb+DTy2LqwkmDFog+kGbnfub3EPV8Jvp3QzB7ubPhQ
 bn55DdK+VKAzKVMNaXllX0BO+7ARvToqIfAAan1jvkXEiPoYfQpT3fAi2uC8MDlavQN8PXuS/3v
 OwntXw4xp10dacxTATg==
X-Proofpoint-ORIG-GUID: y2rqO77w8jfQVKqTTXERXBtytDDyQq_P
X-Proofpoint-GUID: y2rqO77w8jfQVKqTTXERXBtytDDyQq_P
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0ecb9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ZVfvRXNSK-DTiSIkpbsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270072

On 27/10/26 19:13, Daniel P. BerrangÃ© wrote:
> Unlike the 'nitro-enclave' machine which provides emulation, the
> 'nitro' machine is used with a real AWS deployment and thus is
> considered to be secure.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/nitro/machine.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
