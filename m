Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EC39A04C
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409798; cv=none; b=eL8V+SYi7Ge9g+WLGkAKBt9GaQKnkt692rhPlV6tSHN5am66xrttBbQPKyXyxVXYOKDnQOPaLrJVw2S9XX4wjI0pgmB1LC1kMFqTAooIbvwWexxF1mmJEggoQeZWjU0rFaU13T9Y9qPF+pkPJYBFsNwmVWF6f6HsknoVQo5ldvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409798; c=relaxed/simple;
	bh=AnC1JrbA1UMTynZ5YPu/FMu43Tob3eK136JnnQ/BVzU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hE02uvfcGJQzv5gOf+X5z9MYJ9T2ZId+T+Oszj0Oq6PKHNAk5eTraxzmxzu9t2J5XoomyKTDOaoI2twW1fliT3dVrKiRp0SR2eGF6DieqLwHp9sZvp+HJzDaUEGUi18q01n/3h0npVq/gCA3wbm+SlW6gObReSgrgJdJ62843yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwa5/QgN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D1W82cb0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwa5/QgN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D1W82cb0"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7iLQq2262550
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 13:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AnC1JrbA1UMTynZ5YPu/FMu43Tob3eK136JnnQ/BVzU=; b=gwa5/QgNmnjGMtis
	1DLfyxp4IOGciKAHlnvjwVKArh/JmfSv2dzbFD9PsC9FOok6BxWUQQKm9nn3YqLF
	sgPI3FaOqQokp45U2VsAjcbRK5D8uIR/U6TVlzsilmdYg8iUGAIqsPO0at9ZoArs
	bFddhUpzFxBwFaDPrq2CP3ZgZBSbSyOE70pBsDW0txkXhTeFhratTt/MPA0cOLcn
	bcmUpbe/+jPeHXYhBNP42KsGooXPmEnO5XytciLNTRSebgXIE1mD5o20t1eTz4Ys
	Z5FGrCMokCA0rXX5wOEfIEhAUW852wp/oGmy0hBoZTTBDs0G2DTvKXxIJn+0drUI
	ywqqeg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvef4s7yc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 13:49:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd773dd39bso1602200485a.2
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773409794; x=1774014594; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnC1JrbA1UMTynZ5YPu/FMu43Tob3eK136JnnQ/BVzU=;
        b=D1W82cb06JpmJC/poEewcnF80cNox/c1GDudgDi/PI8wfqu2zRttXJw7Sdf3DlNIi7
         YC/pvKm3Ikd8XIgmbORqrVCn/msFfh0jkmVxusprvz1OSDyTfjipkJiSPPARZKYo+00Y
         f+zcqbPYtmom0LyKjG23dnDDx206ZRr42zQ7igouxMMu9fkjYij1eYaoaN9gXNvjxXmL
         qL7SSQ+8X+VI5shnMACtgOApUWPpF8jS/7RrJoziCvkraUvcNdqls46+Jji5n9n39KU6
         +55p3/CubzsovgUg3SJ0YXlRJyFxUhTkmRGi0YFrFdUog2aLizLRIzgWQjogE/rvHbe8
         7ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409794; x=1774014594;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AnC1JrbA1UMTynZ5YPu/FMu43Tob3eK136JnnQ/BVzU=;
        b=CWwB/CAw4PU7cGY3zaynzJp1lEOvLdyYpUqe9cRJ29X7TI8VoK4VoJ40ikMB+O2F/0
         HQYNuH4NFd5wKkHnqfkAh0RPvhy5zJAVt6vbyt1UsLaJ9lLABe8nmxlOrEmuepmxnjDL
         PrT3APlWBnwvyirw1tvBUQcc91nrk/horUFAATjb4IQVgLOkgznApcKaTGX8yE3Wsf2O
         Kyi9wwfk3QkfaR5x17xRXGtd8rbnjATcEDsf6AENsmSJhDzP4EXmdoJm6tQUMeicH6xl
         jnMudnIYXwQ0eYQ0pkpaW1yxA94aFTShTGZzrkgUoujORcFu4yPJYxPu4ry5iGwvD+EJ
         a8kw==
X-Forwarded-Encrypted: i=1; AJvYcCVA0GCDjh9HWFPRPsSE1hqgJpSxCkn77P1z/8dP5BDBjl7SOG6woxrrrJuiJfOLPNEhPsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbhga4vu9GcRPjgePZZ5Gh6Yt1kzE9hQGVRfb9tghrzrpZGyp5
	wYEomD/+VwXV5DOZ16ZrhuBAOS80K+/b77czivSyxkVzjXnmYAa9peUnTziqJqrMYT7bGmCsXOf
	PfMX8rTiseFtEa/BwdnqLGdZlMil6UqUbjTJr+fyv+AG5MvIlBdn/4rc=
X-Gm-Gg: ATEYQzzGN1ikt1KqNpB5+7FOt6H225BDexm/Aqw+B9Ltl8+YIfEnqc0t4hEXtEWXdKm
	feWFR5NE9RqEisIf/jLGfMJvw6fTFSA9JS0HYz0LEbuYsOPA4Z2q+XYPjuG/cQvSyDVRotVNBmb
	mrkUs3A9Fg5ICFbhyW+eQXCZ1YsSoq5Vj4p2hrmeb3CmxSec4+NFV4hN8q9Lnp4SavzZK3ju8yX
	aJCinmNGz7iF0GAfYyR+NGK0mzoORA10Va3K+r6ezbgIKYfQ8Df2P8veW+Mts2msZJkwH+CeyLH
	BvDxuGdIzbeSqiIAtT3nN1L1g2ePf6Rh4e5kd72PPScDDXwiljzT0fqBI6Cm5HJysDRvaH/9pqm
	oYKObiUPaXcWzygkuXvfiv8X+jhwSvNDjMD4j3/4Im0NSaBZJbTEfbYpFm7sR
X-Received: by 2002:a05:620a:5dd9:b0:8cd:b5f2:3b4e with SMTP id af79cd13be357-8cdb5f23b8bmr310879285a.44.1773409794207;
        Fri, 13 Mar 2026 06:49:54 -0700 (PDT)
X-Received: by 2002:a05:620a:5dd9:b0:8cd:b5f2:3b4e with SMTP id af79cd13be357-8cdb5f23b8bmr310876185a.44.1773409793700;
        Fri, 13 Mar 2026 06:49:53 -0700 (PDT)
Received: from localhost (ip-86-49-249-15.bb.vodafone.cz. [86.49.249.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855778d268sm29514875e9.8.2026.03.13.06.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 14:49:51 +0100
Message-Id: <DH1PAZDT90GE.2JU59DI89M0UD@oss.qualcomm.com>
Subject: Re: [PATCH 07/27] RISC-V: KVM: Add hideleg to struct
 kvm_vcpu_config
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Paul Walmsley" <pjw@kernel.org>,
        "Alexandre Ghiti" <alex@ghiti.fr>, "Shuah Khan" <shuah@kernel.org>,
        "Anup
 Patel" <anup@brainfault.org>,
        "Andrew Jones"
 <andrew.jones@oss.qualcomm.com>,
        <kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
To: "Anup Patel" <anup.patel@oss.qualcomm.com>,
        "Paolo Bonzini"
 <pbonzini@redhat.com>,
        "Atish Patra" <atish.patra@linux.dev>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?=
 <radim.krcmar@oss.qualcomm.com>
References: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
 <20260120080013.2153519-8-anup.patel@oss.qualcomm.com>
In-Reply-To: <20260120080013.2153519-8-anup.patel@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: wA7W5oFwskZ0DCdzOa2sYvNLx_W6nSjR
X-Proofpoint-GUID: wA7W5oFwskZ0DCdzOa2sYvNLx_W6nSjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExMCBTYWx0ZWRfX16/Qv585euBE
 UMkM0ELcXWqB7ZPi99ZV7H/paRfyzyU4JnpYstEnO7p6S65vv976Uv2Pdwbm4apde3YgpwLLTh2
 PwlZcIo3af7lbKKsOU3Pm39490na9du5h3FLtFAwhxLIZmFZNDWaGMF73WjkMy38B7t1wW2RQf4
 Uqf+jdTl4Xp+VTch9BgoeWXagH5/E7dMs1C4+/rJRi60FTqu0NW4TuBaNBeRk8mS6nZSF1572Qv
 X4WZOHlaopmPiOviTjXUKYbDk6nmC0VCC53agorESqWfFPFGAI0R4f2ruB7tgT/Hph2/hKv4gzG
 mr1h52eusGwo04OSLLBFMg6KoJqhU7VVtKv6TS9ZzyB4tC/BVxsdx/gLCBc5tGlwS2npS4BRAY1
 YaswbQJstNRlisLEB0nhzy8sm8TTWY0OHZEamVdgBOtL0E+2OMNURU2oosevsJU6VmVTGj7hLXN
 ubbY76YR5HpCusOM7Bg==
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69b41603 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=fuErIE+P63Icv3tqjtEZBw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=sIBLlZgNAvny2aHwhmQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130110

2026-01-20T13:29:53+05:30, Anup Patel <anup.patel@oss.qualcomm.com>:
> The hideleg CSR state when VCPU is running in guest VS/VU-mode will
> be different from when it is running in guest HS-mode. To achieve
> this, add hideleg to struct kvm_vcpu_config and re-program hideleg
> CSR upon every kvm_arch_vcpu_load().
>
> Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
> ---

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <radim.krcmar@oss.qualcomm.com>
