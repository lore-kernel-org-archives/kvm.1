Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16AF314A86
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411277; cv=none; b=LRX63zTh6C4oc17qIMi8fQSEQszMNx4WXbtqBsRtIJflTaRCn9/FYuDNvaf0KTlqNducLoNFMDCa1Ctwe/GxKaM9nKFARpdE7DT4Wwe1ao6ekjAYXut89WKkflU71DZyq57lmVifrq2fa9eVPwNso3+XFZt+xBHbIQwLfx239Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411277; c=relaxed/simple;
	bh=/OKDtZKpe4kTubZ+QPOidPenFpNONaEESyITaSAXb1U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pHPaHrTDIYw8pYXvtW1quOeHr/GF41bjJrGqxpDYxaO7Cnl+UzBx2IhjnAZAUvAHhcJzpADcxd6aE/GSHPLZKeDQ11KVo9BrC2SDrOkwZ3GGpanKEtwu/yPtoVT3rCZg1BNL3S2E5WbGCBQBd12hRErESdZT4ic0UfSNNvNh6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mIbw2Whs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QEmR0Bik; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mIbw2Whs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QEmR0Bik"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7iL5g2262547
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 14:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yb8otKhnt0ZfdX0TM0MYAhAHgSLa2dwwdNl7K8IPkJY=; b=mIbw2WhsYb6OPwUq
	6cyyk5xfsBmRsyPT+GcQe17MXyaIHACsQ7bjCNpfVFpXm9gX+79rHui8VDQdh5ZB
	EWsRmjO4ZlbFmpJb2To3lTpeUD4rRzFrGGE5cnUvleMYzyzYS1sV0XshX3HrWlfL
	9ylyBNwlkkO4dgrFtsC48J8UzPIhFKwfn5GUfBzD4Ea5blNXld6H7wG/OAmnGbBG
	AK0K5nBUEPcJOYVn5eA5/vlgcpr/08GRK4iEAq83HY7/FldBiVE/Y7bK5KhukRF5
	XtNM2zZb77HYHN/EuLYKAtY9u9w1lZk6CHxW9kLdKUKJ1cFlBt8ByeMZ2L37HoXk
	P82DlA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvef4sbbr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 14:14:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7fc27cf7so1193817685a.1
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773411275; x=1774016075; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb8otKhnt0ZfdX0TM0MYAhAHgSLa2dwwdNl7K8IPkJY=;
        b=QEmR0Bik9GElXutzvO8b2MSDv9Eu/Ty7Xj6WDp+GuaMaR/TpECjFMypk4JRYO5kv3Q
         JyNCA/RwPcKnpuhZ5Vc3K3nSu3BNQgWza0AHZfR6r6926+SiJKyWEDDhGhs8+V4NcITl
         ASED6kaFE6Ii/ulVDf8lEMSm1awPp1ZBWkC5K70mw8z2UP7wbe6JwNDgF+9W6WHhL1JQ
         aq2thOxBf5NPuo/ox2ksTIpBKb84Q9Go2TAHePkiAzJxNvTDHsULflvQtPIU13iKpP1P
         CtGIjIq0jFHZ+3a4qZeNtP3cheWrhsO2D5WPs5QA27TWxxBHB/nEXn8oCueA63ulXLzX
         fLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411275; x=1774016075;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yb8otKhnt0ZfdX0TM0MYAhAHgSLa2dwwdNl7K8IPkJY=;
        b=cRwbO50t6cjPVZAhhi4YiD4xAnvbXPI/5QwaAo2rbwN8TFO2dngURN8fqTyk0HS2JS
         Y2tepnktLWMrlRTB2UTVXk2Q22a9gOhyJNb+ykbxikbeZAWKzRGR/M8sAiLVLGEWXLL1
         C55z/kX1cLQnEaClmUvYAX9zc0oGH1yYP3zoojaOukETzoAR9tzm8fBo2lA/1k6LXG6c
         o64LX53BavrA3MTvzRI7+T7ICPY7Q3MsIaU+1IKjPdWHTOaqLgCURMXLUB4duFnGfNfm
         dPVc3ZXD8XLXx+QNMaz0u57luVI9sgFtnKnCcdDe3fS7wzg9+h87luPanwtfEJSSD2C5
         JVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaXAjYEVlkAjJ0THDfPJbgvjha/7KTcYSt5jo+2DtiuJmo8yPk0PK+5OI2psfZjyvYLsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt34ZcPHC6RZ4MOfHIevLXE8w0ZikwS9o6SCuDtmYYH05sThrt
	GV15XnurKWRLar2Z8nR3Ic6enAcVtOseRkWLQ80b5F3Gf4SHa05mfqDEAqxWFCz1RYbCyX2/sZA
	xSEvd7vJd6A9+IjVwex/FuI1DuBiRSegmY7vROZaEL2hlPzG7iQ5ky+A=
X-Gm-Gg: ATEYQzxuoOqeBiyvebwJtdFZZfcLN/26YFyogbFdLZBY7WOVkkxnwKrlMEpCnDN+zSg
	OAGXugAqxOyO1A639IS/+yX2ICtFW8Wkf7hQQoH8Pdh0c3mJ3rX4xtc5sTeZ4eqq97+l1frGODf
	smVgNqSsYMWzYWJpYYnqpbRYkVZAb0aFMIJR9hmLk6VptG7jO0DsRluRa9iwWL6IFZhfl8Ias0S
	FsmF1O8dp0vmfSiWBCjk0SxibKP+XZVjefcjVmN2hLk/L216szu62uPXhwm4EkMklPEr6xJpXq4
	BpQ+qnZoH1nsYGU1KioSdLgTDoF121FcFP1BVEDT0NSiA+SwvYio+JgOqVHAVtIT3uhPKtEAFBx
	l1ME2FfMJqq2CQyhXEuTyHWjTj2/tBnJxizkoX2wIDjWE52vhd/6My9PP0rGx
X-Received: by 2002:a05:620a:170f:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cdb5a61b1fmr457591385a.28.1773411275266;
        Fri, 13 Mar 2026 07:14:35 -0700 (PDT)
X-Received: by 2002:a05:620a:170f:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cdb5a61b1fmr457584385a.28.1773411274689;
        Fri, 13 Mar 2026 07:14:34 -0700 (PDT)
Received: from localhost (ip-86-49-249-15.bb.vodafone.cz. [86.49.249.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485577835ebsm44367405e9.7.2026.03.13.07.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 15:14:32 +0100
Message-Id: <DH1PTVPUM2UR.2J53ICCVVPAFA@oss.qualcomm.com>
Subject: Re: [PATCH 05/27] RISC-V: KVM: Factor-out ISA checks into separate
 sources
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
 <20260120080013.2153519-6-anup.patel@oss.qualcomm.com>
In-Reply-To: <20260120080013.2153519-6-anup.patel@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: y1P8qCBu9BJw3DPIq6EWXJ3NInQHshWO
X-Proofpoint-GUID: y1P8qCBu9BJw3DPIq6EWXJ3NInQHshWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExMyBTYWx0ZWRfX8EGY8zg1I9Mw
 Lv5mtvhrEOIRm6nbDmiOz0SM1bUqZGWml+yidBQ/rjftUhWBFqIlRU7Sr42i2H7S/rkKWYM2oi2
 aV5DzYHJVdZ20izYoXv4Nq8fFieGhLvajZejRpWCHT8o7iF9pJbHBWEKpYpE/KnxBrQ+QqCk1Iv
 /WJ1wosR+c32+A+Hv8PdSE5YBQWYx+xLZ9KIKg/FLG9wohf2jZaX8liop8skwcSzbFGiUz5sxHo
 YZJgcPpBpYg/a8yCbhNRfJxg3x9NI/VAECEFfUMl7jIJaA1sTjYer8aAOOAL2VtG/rpWx9/I7SU
 otPCaA8T2vmwjn06NknkNZMdc6DMj5PC98fRxIbBvQb9sX8v29gZ3gw2Rr0NVykl1Vi+yVTwWp3
 zeLHydjqKMrCrwnlw4NXViFxmrjpVrCjrBpWwthxwX4tcWQZHiVAUK/o871QADqGTD9PTcYygu8
 4OZ5Bs8k5SHVEJujDqg==
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69b41bcc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=fuErIE+P63Icv3tqjtEZBw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=sIBLlZgNAvny2aHwhmQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130113

2026-01-20T13:29:51+05:30, Anup Patel <anup.patel@oss.qualcomm.com>:
> The KVM ISA extension related checks are not VCPU specific and
> should be factored out of vcpu_onereg.c into separate sources.
>
> Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
> ---
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> @@ -12,6 +12,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/uaccess.h>
>  #include <linux/cpufeature.h>
> +#include <asm/kvm_isa.h>

I guess <cpufeature.h> isn't needed anymore,

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <radim.krcmar@oss.qualcomm.com>
