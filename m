Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23541442F
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350249; cv=none; b=e6LeGteS3ipkLPlaw/DDDrUacxRdd4QPyX8u9/EL4Ho7DW6SZ9tdzRQrCb57Qwa3/BaYQuUsrdnfD2Mio8/c+9tJRUlXRs+pLKR86ypvuhQRpAch7OA8CPaXcAd88TV9pGpHAc+e/uxyAyvOur/S8BCSTd/XzC4spENYQQxU4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350249; c=relaxed/simple;
	bh=xv4odhemuBPAS8kcpf9YEYjSYrExVy3jQi5ATSg6zYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=St+JSpPDHUa6Ex+tE3H40z2F68MuL1PEL+F8ECgcbt5lxfN8/VodFDfgjSkYvhRUET3AfJqc9zxOZhzNG48RGLXVi7JpGA3EDYGCTLZoV9oZw519qJ3EfMCPXS/tHexkLhwX8DEStOue7iQQ+njdVZt+H/37GoP1yxaTUsEV7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cYH6Ycmx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gTdjM24I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cYH6Ycmx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gTdjM24I"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEAa1E600037
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eaED8Dj0FArN5pZ3q8CQ/4V/GaAP65mI/2pqKsEpiWc=; b=cYH6YcmxSpRbVDv4
	ASqOTKC8Ww3v7g4z40EX0CE80WVfVuMpO91dMVOjuCuMlVx9uakw8rjWxzSslUDi
	BxN/hQ3cPv4pIgMMtjhGcO6i2V7fvzPCApLgzZ7CMvCmcjQdclp4ppbCI1HBqaZs
	FIJ8kJaIBmcqRNS/2XqCkmNCgNbY3uTJzlwIgP+GIzIwjeW+iA3w0cZiuYp8dRP5
	n/ZbiKIwYy4uIhZihgp/w33uHKm1IbjrBHKIA6o0TWOiWmKhd5xUqak/wbExlYaT
	LlkBLdBX7UFnVJeJ0kFaerkJcMU592JHFDqolqv1SlyNUkql+l0Rp+usn5MJ4aWn
	eUf5Lg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjpvsxn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:30:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93bfb2da664so284520085a.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790350246; x=1790955046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eaED8Dj0FArN5pZ3q8CQ/4V/GaAP65mI/2pqKsEpiWc=;
        b=gTdjM24IPhm6kXF0rmXIzq72lggmnp212fQMoNkAPPXCDzNjCz1sp66briUQ99f1Jr
         nyY+x5atvu98IJTtwLnFH8x6KV6jxe6xu9S7aEQv2frcUR7MSFcmolgeDsahG6Lw1avJ
         EG3cIWc52yxebSrx43j1GI3nA5cXRmB3nkWxhg7PfPGIqzyIOMvHqiybxqE7nxx5f/2U
         hcXx76Gkwoy3OLoFAHVradQNM8xI6DN4kY/C6vYLnozzhbDXNVw1+WhUV6gfeujDvoq0
         GJjB3A9swbxiq2AyS40DTJx3uNswrEZeUPOgv2HM4YSbjQ7MMy8TPDoYNOZjuvju0ViU
         I3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350246; x=1790955046;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eaED8Dj0FArN5pZ3q8CQ/4V/GaAP65mI/2pqKsEpiWc=;
        b=wE/uwuwbzAEaIM5+ZSjAdlfZJ5gOSWIAqkmIPIV0dt4TaJgA1TgneXblOKKsxYwXyw
         aBHfxCfeURbI4TVHdyZsKpbBIy/oWljPEpEy6SAqrqVClOC6n5M7pIx1ULonScyVKU90
         cDoZf4GXVZwixOoSTnd9sLh9bF5KRgLhJYItY+2w5KOfuj1F5Aw8vnKReKw56a6tEv8i
         YNXfbQmeM09x4t6Q5wkMLmEDTtkZEawpjBBAUwUH6LWBSFMQ9kFPbjcbnF9EpEk4rGE8
         kKrr0JuCBF6wu77E9FM1RZ1XBuqx/dVVQnIq9onpdES6E4r2BJtOHRPVb2KnTGjkHXjW
         VIEA==
X-Gm-Message-State: AFuF++lLflDHytiIPsexzSE0WRrsQP1nVXQ9yqAldJNYDeDqKbxEsHI0
	DGH2g/Isor8fJ/Cic51EMVEOjdo+mDI9a4xV8bZEPtTibEF5ICN2iJo0dlNM5XaECearE+hUL0u
	w9zEPUUNhwz59Z4Jt34bal8HY1XPHCZ/iFqzwH6Tw9WOmukDM83PmDww=
X-Gm-Gg: AYBFou3eEVwS8jIRfk51BQiRUkJi3W6hg7Uh7tPsNk2EmejxGInv9CEZb7B8O/jqtAU
	V7NRZ8IKuKn/2IUqdpw2yDjcwIOA9U8ZuIlm49oqvY6wU8iVsJSlmWvVzWnh97cTDJ04cnDs0Id
	86J3Oi9zBiWxHcJN1By/0iWF3g/iGiF1J2KzIuxpLERk3JZS1tLPZCvzTUXUIYZzcVHNvJYJ7mc
	Vuj3nZygmaaq37Uip/c2mzD2ePwjZowagLZqC2+53oG2ipQyVOvQtDWv87p5eBIzTYVR16f7Mge
	FjwmrCYSP51P+WzWQjrW/QEefjTpPekCVk/fYbKsa1Nevgs4VWrFqVhFxNW1WJeCik5erm233/m
	lPJPbE3B9Y5i0xYc5yx+5mqCt+AKUgii1oUWiF6WaOzfORSQzDXYjcQ==
X-Received: by 2002:a05:620a:2915:b0:939:d5f4:ab5d with SMTP id af79cd13be357-93c47498881mr439178385a.33.1790350246460;
        Fri, 25 Sep 2026 08:30:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2915:b0:939:d5f4:ab5d with SMTP id af79cd13be357-93c47498881mr439169785a.33.1790350245846;
        Fri, 25 Sep 2026 08:30:45 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c44972febsm205040785a.39.2026.09.25.08.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:30:45 -0700 (PDT)
Date: Fri, 25 Sep 2026 08:30:38 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
        sudeep.holla@arm.com
Subject: Re: [PATCH v19 6/7] firmware: arm_rmm: Ensure the RMM has GPT
 entries for memory
Message-ID: <20260925083038.000022df@oss.qualcomm.com>
In-Reply-To: <14c6a10d-2891-42ce-8dd8-9745be2f7347@arm.com>
References: <20260924135201.850038-1-suzuki.poulose@arm.com>
	<20260924135201.850038-7-suzuki.poulose@arm.com>
	<20260924143821.00003491@oss.qualcomm.com>
	<14c6a10d-2891-42ce-8dd8-9745be2f7347@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QaQycUthQOT7UqpaVHcfxy-LXsBBYZqq
X-Proofpoint-ORIG-GUID: QaQycUthQOT7UqpaVHcfxy-LXsBBYZqq
X-Authority-Analysis: v=2.4 cv=aLBlOr9m c=1 sm=1 tr=0 ts=6ab693a7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=CGxCOrlZwYKUQMMqFN0A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MSBTYWx0ZWRfXy+9XjzbzvIbS
 ol9wmvKg0SuYX8V2YlL8xXMno104AXq6e7CPXnVKdtzzlPCoPLaUHTSbryfIRGORCOlpo/z2VN/
 IYJY3260tL9GYNGfxNYIU5/jlTKF9a8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MSBTYWx0ZWRfX2WZFNnedzjDZ
 XW+oNYcqJvB+jBIUTj44oSSeqbyIRJRGNKbTjtRs+99mtIBRDud4OGOcqesJU3stek0m554sq2J
 72LIN5Cr5LJFD/3YvY6pxNgT1aa32E+iIRZUeDfYuQjgs3oxaGRa/8a4KDmwmB84b6tjA52cRmr
 brYXUi38I+HHgdhW96k0Z4yPao9/b9ar8FW7957xhdhKpJgbFlKcZ0N3PyPGPJTi64IGhj8DBsq
 vXqEbmLBoxya4AiSxvGIRuqJN461nRDaodwNB1YUBDy9fPw9T/9mEXACttwkMrfFd/9uaj14DVi
 Vq5nFY642gwCz3EkH0Ay+m7mc6GE73eTToniVxfDw4FkVMkZR5vJbmFrlMzqubyv9fx/7GfxHzx
 afK07bj4eUgQTQEh4UuXvB/LcHilHSvN0cIiHyH7i+Tf6/PCg2mFtMlKvkmz5KxfVB+417g4pPR
 xCPrWTKRqopjI7zZIRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250061

> 
> >> +
> >> +static int rmi_init_metadata(void)
> >> +{
> >> +	phys_addr_t start, end;
> >> +	struct memblock_region *r;
> >> +
> >> +	for_each_mem_region(r) {
> >> +		int ret;
> >> +
> >> +		/* Firmware-reserved NOMAP regions are not usable system RAM */
> >> +		if (memblock_is_nomap(r))
> >> +			continue;
> >> +
> >> +		start = PAGE_ALIGN(r->base);
> >> +		end = PAGE_ALIGN_DOWN(r->base + r->size);  
> > 
> > Add a comment on why rounding down.  Doe we expect that to ever be relevant?  
> 
> Do we really need a comment here ? We always deal with PAGE_SIZE and if
> in the odd case this region boundary is not PAGE aligned we stick to the
> page that we can use from the region. I can stick in a comment if you
> really think so.
> 

Ok.  I was mostly thinking that it was an odd thing to happen.



