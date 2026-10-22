Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656448;
	b=mrudxDoKw3U27oPYZ5lKWNpn591t5IfgsyOY8DSnNsotE2KegM+Xgt4qItGXm8LmTV7r
	 quLuIGsR5ntKB4M8za/Uyz67fiQfQXS+So72uNZ1cLb2gYh5uwcGCFot0lcnW0faVjh6f
	 FPuAvp+g4ZJfFoCkkWU5kf7PfO49dCxHnQkx4eAC6Nat9EPaFkIjtxKRKxRkYIr1E+P1d
	 PyWemkgT6n+4ArjxKDfgzECFL3BiYzDBNsxENTd1KUBAo6P2slBy1/0RuluaJTkHyPbq8
	 d/3+fCMDsSInunlb4vKm6x5KxA/VlHlda4HuMAFDmbJ3MmPwxx+AOZ7gBrHuf9AMtqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656448;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nF1TTK0O9iC0maXZCEHXiP16zxm7ratzOTrdUcxf5kw=;
	b=qPnL2VhjPG3RaXCs+3gcnL/ZlZYyfL9sL/8mtUnWtK9hmVPmqkKuozxEB+XanYfXLJnB
	 LzZLZpD7KxISWfHlSzxNZVTXXg1LOb2kixEoIpHi+/4iDZJG8NXc+lKt3W+UY4+ilN9Pp
	 A7cOmoM735sRpLDSI9DRSOw3GELsXi+6YifhzsrDADqxMShHvSNL0/4RyvPgptY9oBZfc
	 aM7Q9yWIm1/KloU6UasS0l3RA2LB8TFeZ3kczVdhxiksAYjS7Bh+5YhFX+OCfqT3KKcZe
	 A71uTEf0fi9JyEpnQezHaoblJWbWZexU1T6lkvHcrHcAldhUewnFPXtVoz7F7HrHrXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EFbbUhUv;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E76606A319;
	Thu, 22 Oct 2026 08:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5E76606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EFbbUhUv
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M7EEDq3373332;
	Thu, 22 Oct 2026 08:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nF1TTK0O9iC0maXZCEHXiP16zxm7ra
	tzOTrdUcxf5kw=; b=EFbbUhUv+B0JPRJV28qs7cso7gvd3XfrzwCsGrgZZPGrae
	0AWqax9uV4Gzv+QADGoi6EpmCdc5iGxI4LcfrFlkS5bLdTdkDF0oou74Yb3p1THK
	gFsGyWPu3pMl/XpdhYopsWqDDRiPNaSjy1Zi3XfVyHWOCNYnbddchUbZV+Fzi4Fa
	4U5J6unn+iSmqZ5DicjYz2owsSPRJlLEQPk5VTUqv7saUAh+Jfw1V4drEi3UHbDD
	2NISPK4X2xhepNyEz+bB5IPp4uTcl29UMe2tDyT/L+cUX8AQJSu+AWdzq/q9x13q
	7jlmJEinQtbcAy2g14OnsxjVIypplLObYyQHVyqA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5awhhx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 08:06:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69M74rWG089138;
	Thu, 22 Oct 2026 08:06:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs93gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 08:06:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69M86mQl43843896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 08:06:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B3F92004F;
	Thu, 22 Oct 2026 08:06:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14D9320040;
	Thu, 22 Oct 2026 08:06:48 +0000 (GMT)
Received: from localhost (unknown [9.87.151.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 08:06:48 +0000 (GMT)
Date: Thu, 22 Oct 2026 10:06:47 +0200
From: Andreas Grapentin <gra@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Bernhard Beschow <shentey@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
        Paul Durrant <paul@xen.org>,
        =?utf-8?B?QmrDtnJu?= Walk <bwalk@linux.ibm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
        David Woodhouse <dwmw2@infradead.org>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-ppc@nongnu.org,
        Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
        qemu-arm@nongnu.org, linux-edac@vger.kernel.org,
        Glenn Miles <milesg@linux.ibm.com>,
        Chao Liu <chao.liu@processmission.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Xianglai Li <lixianglai@loongson.cn>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Chinmay Rath <rathc@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        qemu-riscv@nongnu.org
Subject: Re: [PATCH 00/23] kvm: introduce KVMCPUOps
Message-ID: <atnAuDpbhQGZwjNA@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
 <87se2039dn.fsf@draig.linaro.org>
 <80b593cf-77e0-4623-8059-937c51dd5cfd@redhat.com>
 <87jyna2vfn.fsf@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jyna2vfn.fsf@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ad9c41d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ADKhsWdzJHgx8XiJNyoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QCEhbWs8OPMtbD9saUJ_vW3U3cGr3W8D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzMCBTYWx0ZWRfXw143HnItMb4O
 7OGNcxPnFVjZf+e8k2EVOGnwWbpjbcDH5RT7M/5eHjG3HlSS5eDpNstWhITwTN1lhr3ODlg/HIq
 ll2AhDiAIu9VRkSfpa+f4p4ZWd79sEQU08RnEsND9VEbT9blSH1ymPHUu1fsjJNKbVSJr6mP7eP
 AQoK6jYQDN0ukHdT09rj+CeMmnujUP/IiyH/hq6LWo9geDMd7Vuuf7xX5LDORJ2QCuwLwwYaNHC
 m8TCYD3CSREGsaqxRpkHCBN/7SWgLceRvs2nEnYtyk4ZHu6any/Wgn+YUR4sGqwj65Z3dQOmL8M
 /iMULrXRRi7PJx0d9hx5lXwnDcnlaaIaxk42uiHlA7o+nZ1rLK5zigR9TZsvW8Gd8u54XKJ2e6F
 yNa5PUXelcGGAfHJSGzFw4gtylS6xeD2sqTwaQcQljMt36snUbvmVPTZ+aqqT/F/11joLDpyCMG
 Ii6xOG4/pC7H0+5BmJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzMCBTYWx0ZWRfX+87XnpKDLPs5
 rHfovf8py/Kmi1p/q/uX0s9x9mWLlt4RCyLMCfcDQQWIh4kp2+thJwIOleHrWGR1Gab2g9mh58n
 3ph8it9DuklXDmmiGoc+CgQVGEWrWBQ=
X-Proofpoint-GUID: WVfB32zkZukzbotBpl-hNWl-mqdj3IVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220030

On Oct 22 26, Cornelia Huck wrote:
> What would make the most sense logically to me is to use
> qemu-system-aarch64 to launch an aarch64 machine and qemu-system-s390x
> to launch an s390x machine (at least from an user perspective.) That
> said, I haven't looked at this series yet, but it does sound like a good
> idea in general regardless of how we plan to launch different arch guests.

Just to clarify -- nobody has any intention of using anything other than
qemu-system-aarch64 to start aarch64 guests, especially not
qemu-system-s390x. What we are doing for arm64-on-s390 KVM is enable KVM
accel for qemu-system-aarch64 on s390x hosts, alongside the KVM accel
for qemu-system-s390x.

that being said, if it were ever the case that qemu-system-s390x and
qemu-system-aarch64 were the same binary (which is what I understand
qemu is moving towards) then this would require that single binary to
understand both s390x and aarch64 flavours of KVM, warts and all.

There is another technical challenge in all of this, which is how the
qemu build can consume the arm64 KVM uapi when built on and for an s390x
host. I'm hoping that this will also be a lot easier to do if the
surface of the KVM architecture details is contained behind a KVMCpuOps
structure.

Best,
-A
