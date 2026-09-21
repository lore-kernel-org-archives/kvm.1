Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC165172F2
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027625; cv=none; b=k19Y4rbEZrUbHoFWxxNBL1RgU3f1Iq99mHep8AzbMre4bGJmEM1Q7ko18CbEtv7S+Qs83xBFxAPvxrHrRqzlUyYb6X8MRfB5w1aXJSoiSuPY+88pZ8VKlovbl1SWIfKKWbT9WZ6oUCHzpzJq+pdL2VIhWtobepkXh6ybTbXQmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027625; c=relaxed/simple;
	bh=xk9+H6CvXaIi2b9MCe7qP08mfzgmJlROo6JCtBtDH9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCjDn96LTYmI6muYRg0rwqxylIltUfTix8Jp2EnLNSVJeLmggyUfNlbbpw/C+0kFLPUmygqdqCGZcVkzIYY68Ou/z1vw4eXOB6+ua79IFNWD83mv78hD682WGCe2WQjg56BZaqGuNtAr5h3xBxKy51Gc/kbPuUd2eh0EjRRYggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sfrlc1Bh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jAwJqD93; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sfrlc1Bh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jAwJqD93"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LLjfnf2877249
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nCgFELu6kIfcPsQKoSSTfCHDAyLCU7hgN7NBMBE2YJk=; b=Sfrlc1BhVwMkzGmR
	cmMZ3BWRONujILmAX4IVDq7hZ6g+YoOsnH8oDCHIonpP2TydSD4fCHiGcWWdrQzh
	mh2bS8lWSBe8zVt0Tzj5APVjagbBv16VVRG4Ecep0ObquQhVCt8xKFxg+6tJYriu
	ZqMNSeUKkzOKklnPU3g0qsD7XuwuFKXubSS1Lp6hpGSd7DenDSKPpfkDSf4FTwBB
	6gduSi7fZr/t5ouxzILhAyv9Lq2fUy5i/9b7XBlTwM5NlX0G5mJfou/qjGn21rgq
	c1HrR6k0sJl1r2tTufr/9gZnF6qffL6+UgL6rwRhyGgyGLUSOvkqpmLxNnEWmYbF
	IjPzHA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d3g3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:53:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dd8920c132so81512515ad.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790027622; x=1790632422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nCgFELu6kIfcPsQKoSSTfCHDAyLCU7hgN7NBMBE2YJk=;
        b=jAwJqD93f4BPS76c92H7AJ8hahi/QwjKm/gAyVsq4TJ6MYiBnH1ceCuePdn957VdUv
         hm4Gwh/oZUvuu10W2m3z1pXLVEHh0YcHXwJ4iuWkGNcbceyOc9cocj0HZj4egt8yuZyd
         VlW8XrVPvWayq8rO1F8FW8vIEMHRgPL8NdCCBlyjBFYl+W6W7IHPvsNfNbikQKGOdYii
         GtjPXRwInrQNgDXZ9nIX59eovJtPFmCfHwBqwFu6wZXYuVM3ORrrkvu5LBDMgyZbpGrM
         O63kIY1KEFiCOfv2LpT6zCzFtbGqMWpYLM4PkKugEwNQO4i0AGFyoLiH/2E9zCQJqzxz
         iAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790027622; x=1790632422;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nCgFELu6kIfcPsQKoSSTfCHDAyLCU7hgN7NBMBE2YJk=;
        b=PKkzbSSkqod92Bo3/k7YFq1YddaqK0Ce7lo/V+XsVOrz3o9YMnn07pZQTDG7b9SdH6
         oU1aMQ0OsMkmH5oMHUgK3Nt3h9vCycOULIqoK9+efBobGlP4dRA/DDbgA56XmLfJNaUD
         cbQ3+B174/CTU5LvJsX6ydPxjuWADLQHTCs5WkJHxNJNtVoKnhEB5caV0/9T9zxwveQG
         Jw8XuImZQmknKlqCK2WQSIKh/HTxAfYsx4UvZar+AWqwQ8HtlMCEB7IzL8+AAPO+hX/w
         //Fpedpg2ycC6HoN0WFP9k7LwqyVPsILaUGNVMwuthwypPggfUicAyc8bwp0nlwQmlIO
         cqiw==
X-Gm-Message-State: AFuF++lR2iXxJa2NrAx5DUiMJuf1vps0Dy2kyxcXjVtV5qWntIaZZrPP
	8ohoGcB+gFvPOl5Le5rYL27+26PRy9vKrjt8p+xnpG+5HCaNLL2/gK/ICQZhD41XZtM5BR62g30
	GUpK9Qc2mE+NHo2o83yRMbb8KRWYKq4fZiFPNAShUqyshiRoTaYqiQrg=
X-Gm-Gg: AYBFou2koyjfdDNEMhH+KFlTB78rhg4/8OAS+gycLuIn/Zba9QwSY2EzLQ+aZk/STij
	Nk/vSWPszajp/wWVEfMSu4imfXYfZW1uVmA9V44nNwPpgq5z/r+HbEEwL+Uw8oBuHSnnZpMpp8l
	P2Z8a2Ku8Ocrl8M47qyRX0U/cL7PsjdzioAue3OdGXAW3FnYGw0wxulMPEiQZ0S96jCOQ3JabRA
	LO3wqaLIf9s9mtFCYMgTtyKcTzlxx6OYNhOuoteKqNaspn88pkHAsIKQOJF2sJG+nhEFtHdoeAm
	TMD7wP6imXWiw9VtlVbvdbGUqclIT274Uu77HVbQxA3q1gbYHB9d0MwbWDNjEH2aWYoleQk03LY
	U12pHBbVLChh36MBsrsYik3KTxA==
X-Received: by 2002:a17:903:2f89:b0:2dd:60d:8b7c with SMTP id d9443c01a7336-2ddb1b1190amr169294125ad.13.1790027622371;
        Mon, 21 Sep 2026 14:53:42 -0700 (PDT)
X-Received: by 2002:a17:903:2f89:b0:2dd:60d:8b7c with SMTP id d9443c01a7336-2ddb1b1190amr169293795ad.13.1790027621908;
        Mon, 21 Sep 2026 14:53:41 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ec16d09sm710143eec.23.2026.09.21.14.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:53:41 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:53:38 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
Subject: Re: [PATCH v18 0/7] firmware: arm_rmm: Add RMM v2.0 base RMI
 support
Message-ID: <20260921145338.000070e0@oss.qualcomm.com>
In-Reply-To: <20260912083611.2513845-1-suzuki.poulose@arm.com>
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
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
X-Proofpoint-ORIG-GUID: yhFtmeSxaVOuo6teUjQfe4hAApiJNmr8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMxOSBTYWx0ZWRfXxcr0+x5XGuVG
 F1NTjD9Zh2gxzcRx82H/kuFVXZ0uDZlj5CJ9QUJhTRvwZJFhnZGkeKeObfMOb3u8XR+gGkQ3pZ5
 oc8ZFu4tYxdx79UpDNBLYtkrldaU350=
X-Proofpoint-GUID: yhFtmeSxaVOuo6teUjQfe4hAApiJNmr8
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab1a767 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=_lSb5bjROgHUFZFBuPEA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMxOSBTYWx0ZWRfX7QYpxe1REs3T
 TEz1eK8gMYWXl545ZHZRdC49r7fCx9b787Kiwsr4/HQSx9dbYL/cbIhX7+UXkzxBdVQXCf+Wv77
 hJkN6RKS4/9O2WqSlpTp64OOUOtJ4wZ3SlKSUcWWzOajdOyw/5SS+/R/Ju4Wkv05ymf8DFSpnQB
 YiLIj8osFUcANKZe8FjpabOAWSChl9z6FF4PtOwaPxCmLDfK49HWj9MuMd6LxSpLq6ej4o67een
 8QoNN2cMZA2CHrrfch9m0LPH2J05qwRlfjbYknBGXFYg3y4NMX+2Oh5duUMXweGn7Sr/m4wHz4z
 OicV20au3YmKpjn/RXrUS3M+f5UTrCEqBGssUyY+szHdeT0qgWG6BZaUV9EAG/Fr4au6vXCmWj1
 MmFK/9Ng6n46rh8DUuetMLZnXDQuVVpdLDXaNnkK0bQofUPMgTiXLX3Ys8WUV0djVIOJ1SySdUv
 I7YF9uGLOqSiSpVMfLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210319


> 
> [1] RMM spec : https://support.arm.com/documentation/den0137/2-0bet3/
> [2] This series: https://gitlab.arm.com/linux-arm/linux-cca.git cca/cca-host/fw_rmm/v18
Not seeing this branch.  I wanted to sanity check on discussion in the thread and
was being lazy so didn't want to check out the branch I built for review.

J

