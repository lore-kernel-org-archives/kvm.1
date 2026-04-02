Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A03659F9
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153995; cv=none; b=brq2/S0x0k09SlAN2YKHBxwGbRw+f7xT0BbSvwQ01IsHZpAErYSSYI2N9h9hdvlS38F1sbOgcnU0iindf83esLreSyHwL8xI78K7B7E46xsA4OuwaBJXZA7bAV0WkbveVh47elJ82MGYHLCkVvA74Y3UKy5bE5Ycd51N08Fro6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153995; c=relaxed/simple;
	bh=cphyPCgyL6ebWPWnpuwMV/17NOnBN54i6xVER3IgbQc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=AMD+wbM//tl+v/fHgwH7loHDpjf85ARbEZHj5MfkPaRcGhgT4SbZSOugAUY17iWRP3mx2T/R9PJGC56EciokEl/ywH7lJKF4ROGU9zk9bPkkxEKOEFF9QMFfkgwL8Sav/9sDi7yUnABsj7nj3KIQ5tgOr1FySvjvGpZ59soWxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dYc0L+M/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HwApsvXl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dYc0L+M/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HwApsvXl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632G4ls62528171
	for <kvm@vger.kernel.org>; Thu, 2 Apr 2026 18:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wiDkn4M6EeOZO6HfXfs1fLrNAiZ96hbYdrTrvNXFkyM=; b=dYc0L+M/7pKMzfsJ
	Xxh2RKcWwrM1NMLt7U9a1q/qJ8EUI4G1em6m584wOhh2e5MRjqxDvWnj2rSW4YWA
	pWMx3EtqUW7MWn+AlPactqXGo8LxbLsmeD4m5hpdoFqmZtKB5TvpfYyHHot7ABsK
	y8pKqzeWw9pnnF8teo5Lfc+ltfck6i0+fN9YQJqbCrBFxGComSp9JzdU3G02GR01
	zJ2Ff4dVxsGLydLlF78ZyMnLobclfcZf6NUCGL8k+nMkqP8gTPN0b5uOo5tuNfoU
	GlBardYOabKU5XtR+g0ZF4G33Yji6oyFNaFovSOQYfnzFPXwYhYxAuHATSOD03k9
	QtEboA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9txc8qdk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 18:19:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b802961ecso15789721cf.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775153991; x=1775758791; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiDkn4M6EeOZO6HfXfs1fLrNAiZ96hbYdrTrvNXFkyM=;
        b=HwApsvXlZRpQacDjqV4SSelAXBjRi/FXN1fdPqCc+el2IbgYhQJOXH4zYr8ANWCJwL
         OkK+8DIbl4spDW0THmNnZWDZ44RFhEmZsQ1LZ4rtaT4CTsDcH/v/CgM6aILdX7JpMsEc
         aKg171shZPC0RTz+QprvE50aQSvEgP7jhL7lViDLF1B1wyyKlLrjFiD0mDVyHMsA8cij
         jrumXmYcjPEl+KzbHjvocddjC77fpvpI69I4lSpdGdLAr0vRJ4Kj4utxzjl2F2mTiubE
         A2O4ncTR8WIV8L76iDZMhb4tSH9w8ZxvpCIQX78ccckMwAD+GpvBwHRc1MSghfGn7BtG
         Q9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775153991; x=1775758791;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiDkn4M6EeOZO6HfXfs1fLrNAiZ96hbYdrTrvNXFkyM=;
        b=TycKM7Q5v9tpqHKXnZ7BMVL328FB5Q3VIk/24d/2yBDAPedGuz0C8uereCbjDZJeqq
         J5+j/CIUUEmSDRhTDPMKzqnUgSPurfolxkhj1gtxFqkixmWaxODv5PbQQI2VBFrR4EbZ
         nNeErDxZma/HhOr446Zv4PBVg42qb+wuYmvJY71L+iaNACnOeFwbrA4MMTHfV32eGNeO
         m0iimOT5vD11kLbsE/6TgsDfjEh2v09jz64IE6DRd/C8V3juLHxLwjzHpsenN9qRmEOD
         XgdwkflM8/VbGYazDjMrcxkHODvDo8uM9AZ4CttTlbmQe7XkC4X4+P22a2yLUAodqgV+
         fWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNGEwVR5/DJ6iM7K5fBHMVIOLfi7y9igaUIfBKGeLjqSGHC3xORXxomeHr/ITNdZfyrCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+s10FIzzyz4nj3tq/+qk+h8gOSOrZMGm5SWw6/JbCircuynq
	hEqJ60OSfbZSBdF+UiboaX/1Bl+/nvqW21M2kIJlBeyhLthd88mkPy7pVpLE9ZCIqbkqPzNBMt3
	i/ehDvhLq79yVl+UTLIPreBapk/C/0fZF4d3BWZMmepadoItvP3W2Wjg=
X-Gm-Gg: ATEYQzwa8YAfzf1P+1XqZYfrNgMfidtNzwtU6h5zmXoLKZXX8lFGMu1AbUA9kqygla8
	H48EmfqtiDvkdO5ZFm7MWTHVu0R6gYlWfCyyiKA6cRblOHQWkUO/wWQ8qnZubmoZBWy4FtYs68B
	OPIeqHbLYej8GRgW4TS0elv7uw7vGbAHzWx0TzvJGwMxvtBLBy0OGpfQmNim0Qt/tj9Pj9eSX7l
	FzDrH79ltxMKhXAWQG5kFbz784W4n0x/ACWFAhujcStVRtDtxwp/HnV6zN9e+jAEEezOJIkkC2S
	J0vuZRdd7senjxEoLbWiPDtUnbmz4VWsfezFH0No1lKG76AOGSkbyUqZMLN9GxBBpDkzPEZ/XK2
	cgbwI2oHj1YYucsYVrIRF74vCpZ0LYGlzY+sRjBQyd9oWlvgHyxfDgfjr2OzB
X-Received: by 2002:a05:622a:aa12:20b0:50d:4199:8c88 with SMTP id d75a77b69052e-50d62772bddmr5001881cf.1.1775153990872;
        Thu, 02 Apr 2026 11:19:50 -0700 (PDT)
X-Received: by 2002:a05:622a:aa12:20b0:50d:4199:8c88 with SMTP id d75a77b69052e-50d62772bddmr5001461cf.1.1775153990314;
        Thu, 02 Apr 2026 11:19:50 -0700 (PDT)
Received: from localhost (ip-86-49-249-15.bb.vodafone.cz. [86.49.249.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c971f03sm114386766b.7.2026.04.02.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 20:19:48 +0200
Message-Id: <DHIVKK81LLM2.3VTYW1UXM6USQ@oss.qualcomm.com>
Cc: <guoren@kernel.org>, <andrew.jones@oss.qualcomm.com>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: <fangyu.yu@linux.alibaba.com>, <pbonzini@redhat.com>, <corbet@lwn.net>,
        <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <skhan@linuxfoundation.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?=
 <radim.krcmar@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/4] RISC-V: KVM: Detect and expose supported HGATP
 G-stage modes
References: <20260402132303.6252-1-fangyu.yu@linux.alibaba.com>
 <20260402132303.6252-4-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260402132303.6252-4-fangyu.yu@linux.alibaba.com>
X-Proofpoint-GUID: lniyG6Izp6pb0DlEdd8HPVAdqihUC6Yf
X-Proofpoint-ORIG-GUID: lniyG6Izp6pb0DlEdd8HPVAdqihUC6Yf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE2NCBTYWx0ZWRfX93vhfMTr4cUe
 pk9OE1cEaKBSOn8fu2f0qXGe6MSMrLTftYYmd8edZanr0JM1Gyto77oD76ZvUWnNT2yjU4vjOuY
 mER2dmRwWT3Ihn6YSMZwPFdMFAUHnWAhp9aJiFlD2lk1yzUTuBOGQdxJYGIf8RqxOgEMHIOHHQm
 HZR2hUnxdytrQYYi/MM/2y+Phw/26eUIOT26wrcsoMw4iV9s2J8DrzVGTI2bX+fjuS9swu+0ljA
 oF8sD4ow/X76XrWeCYlNlW7cuqi/IThlo+IfXTUXmML/BgaUBfhGppl+yUTvpa9UjrcpnLuQQBz
 bHQ9V40ZHmJXVCOnEL5vB6cV8f5uIArC+kxTgLIZbXk+UDlJlBVhIvLaT8oxFEH0Rqwy64PvALx
 sxhYc3lxVsvEvUpau59i/dRyLBqPC3yngmb5k7l4sh8wJXWzdGZjSi443fB889pGLcI18tNh1Zy
 KL0Ejy89hDDqqBrxsRQ==
X-Authority-Analysis: v=2.4 cv=HKXO14tv c=1 sm=1 tr=0 ts=69ceb347 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=fuErIE+P63Icv3tqjtEZBw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qHmfJlKEtTjsIq712WoA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020164

2026-04-02T21:23:02+08:00, <fangyu.yu@linux.alibaba.com>:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Extend kvm_riscv_gstage_mode_detect() to record HGATP.MODE values in a
> bitmask. Keep tracking the maximum supported G-stage page table level
> for existing internal users.
>
> Also provide lightweight helpers to retrieve the supported-mode bitmask
> and validate a requested HGATP.MODE against it.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> @@ -102,4 +103,14 @@ static inline void kvm_riscv_gstage_init(struct kvm_=
gstage *gstage, struct kvm *
> +static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
> +{
> +	return kvm_riscv_gstage_supported_mode_mask & BIT(mode);

Shifting by more than the bit width is undefined behavior in C.
RV64 effectively translates BIT(mode) to 1UL << (mode & 0x3f), so this
could allow values larger than the mask.

Thanks.
