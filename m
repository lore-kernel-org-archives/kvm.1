Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD70349CFD
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160113; cv=none; b=kk96klPcWo2D52aGxokPk7CBZqbV1C01TLrxNU/TZ7nfvd1XjLwAhzDmSOTEREVXj43I3kExB+O2CjQoFPI3znzHfznrjZMB5CCwnreNThiHRq5PxNTVDBEvqfrQBTE2mCxYCEkL9e+fSfZ9jrtr6b7Bab1njYADXqYJU1dPIUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160113; c=relaxed/simple;
	bh=USKsWudXAdHHwfy9ibLewzmWRZ4lmSYh9uddoQsyTPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCxi0ZmUIUQn+Nz4b9facZEtvfjpIj2tdENOKL/BP86+hvZkQJ2JF7ogEq6wRo7+mpOW9U0Uy/f9yRsdz6eugdcFZ2X5pbadFN05HHq0/LGdW/QVN6YeuDcIGzUuWPb57EwiVxIKwQC/zuUwBk9XvbZggaT8KlNKWk30LFJddnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xyr9xpaC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GE5kTb6v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xyr9xpaC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GE5kTb6v"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GYj53812648
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j6xoN9s2k2z6WBjErH2B5a4ve+qKzH72nuHagBkgw7o=; b=Xyr9xpaCmjKMKv1g
	XbgKl34KARoqGMIHM5Xl+Q8rYjdzHgw1ypsA/ZQ1H61HajOcIWUNUgw5zDtrSQT7
	twIuqElAbNwe3EI11j7MOZyEfQhZij5TZWb2YYFdYWUbVxwrEiXIPAc+nr0esuSd
	kKz8CYEkoOrVmQl9pPhA5YUUp73RkeZAgrlSvjk75zfX1hyHqWdcZFitBibtJwDy
	ernWVnug0jWLN0k0oWLtcShC18uNXcBTHPeCIfHMihEbrC63M8xIRpOWFL6ZC7Yg
	MfN5rlcwCaXYa0LoF02tXCU8e2FXXgh7l8ao5WgDbT0MaygpWlLXrWH3pVsR2cqt
	KNfIQQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71j4d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:41:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5175aa1a54bso168034441cf.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781160110; x=1781764910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6xoN9s2k2z6WBjErH2B5a4ve+qKzH72nuHagBkgw7o=;
        b=GE5kTb6vcz7oSP76NsHMfVgB5bWxrK8GfQ7HjnJNH+Pa8Nx9o8DBXuFUVppQsV4kyQ
         35FDnKO9dvtJItpUiNC7d600ItNVz/zMUzz+v7uJzcxz1JpfblE3JzD274pXGyWPmktc
         MP5dduyK5mxwPJ1fLrgwM7wJRFTihqusm9r+K5MRWthJ3wjjjk86zbR9EUnf1TT7KG+6
         18nvUHU61tp9FxTOshaQs+R1oWOIRfaWLNWx6JkLUgl+VaEuFIweZfQyEHgBEikFOKyH
         4e2Z2J6a8aLNoJnIokadTZr3dvsBU++1wAct/netxLmRkq07UyQVKAsByWryh0VcSSgz
         BxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781160110; x=1781764910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6xoN9s2k2z6WBjErH2B5a4ve+qKzH72nuHagBkgw7o=;
        b=Vj5t9v6r77DekWtuqsmn3YL9hN84B1kCflvajm0v54MCW/nSxgREyadcFvYOIs6T71
         ZPBKifxdC36pp+c1ybZVlBCNodUuVccmoXMIZ6MYvk/tyxghhn6a6GWTDVJtOK9s/4K2
         q7Dy/EKUqRB9DUNbMDMrBcwnj+wEn7KP/c9uCaoV7ShWdBqjCIHtXBdSPeg4528BFG2i
         bI6b6Z8KbFP+JZRgXo0vseqYpgnFIer6xCT7CioL5OqxoUr5nd1cSa9bYPm9IQVPK11N
         peuSjCEKJ1kIJIpslNlvijkmYTy8dSJmXH/m0wQ3dmpvhIAlfamwwMac2LbHkoqEk5hm
         dmMA==
X-Forwarded-Encrypted: i=1; AFNElJ8AmDJ87aOhXiQULz/OFKagQ6T/G3L5vs7cZOKlQMS7iVppGkcZNwGz7KKPHm6R/a6MN7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITDgFUlJ9abQue537T9T5co0h5EYt+WYMU7JTu14aP+E6GEMS
	BVG1/kSYgXRWC10zKYSuD7vrdyro/gMLBttrSpBsIUGSeansKFWhqMCJjpzF72VYVyph3QS/p1T
	+N2qlTQ9Lmd4gJpkNtpx6xDwxvLUE9xa4ChkqB5wt0do7TSBJUpZbdJs=
X-Gm-Gg: Acq92OFXA8vHFLzijPf/Y0N6pKrUo3Tf1KHFs+IIEqAkz58yPo7/Qn9ETG9e+WizjTe
	mCqDQy4VRjiJn4cDKwC9FlLGPUrb2EvXo5M9Jkns9DdeHsA862byNAghvtGKwgJDjOo6O94w1sF
	tGB8qr1TBR+wd6XyYx2ACSISpxpVHEcL70v4yGMrWaZp3utKuhWQmvlYEs00y+GknzVphkaISfw
	TzeO+ytTCoj/elQ7v3wHyGEUDeJmtqPtGFZRIlKGdqPiROk3TSlX7PVjU4xRvKuOo12I1PfftED
	YPWpuDKtVbYlJMfWVyjg3SG0Xc5C52UD+AZ05iEPG/5m/rlOOUVSzNZg6vir3xSL3HQCQjws973
	OohX/dCaHbU+SbdUc+RPO7DWUFxl3m3rC1jVskc4GsrOI/nNeu8eCkPi1HwqibJrbM5szCtnK4A
	XSbAeZNw==
X-Received: by 2002:ac8:5915:0:b0:517:6d75:a2cf with SMTP id d75a77b69052e-517ee204de9mr24562361cf.43.1781160110539;
        Wed, 10 Jun 2026 23:41:50 -0700 (PDT)
X-Received: by 2002:ac8:5915:0:b0:517:6d75:a2cf with SMTP id d75a77b69052e-517ee204de9mr24562131cf.43.1781160110164;
        Wed, 10 Jun 2026 23:41:50 -0700 (PDT)
Received: from [10.156.84.244] (218.170.88.92.rev.sfr.net. [92.88.170.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb0f14edbsm17924666b.3.2026.06.10.23.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 23:41:49 -0700 (PDT)
Message-ID: <6c41aedd-9862-4b42-832c-cd0f706bb855@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 08:41:44 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ppc/pnv: Remove Power8E and Power8NVL pnv chips
Content-Language: en-US
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-3-adityag@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610090800.3672832-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6ZsutLibNY0wZqzxxlB6GIHiLMGo1aje
X-Proofpoint-GUID: 6ZsutLibNY0wZqzxxlB6GIHiLMGo1aje
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfX9jaTvhs1mOAZ
 mvROPZvuIXGSiRhckc5jEDLNuiujy3BXhDHCdtU84kn2z96Sqp9FYbyfalTeLo75tLJ0rtNPntH
 NOSCs2huzSGDPJ/jp4ek+NUZffePbwpcdWPBzbP73p9EvHgdrBeKxEA0WI5HJt1sWMF9tU5pPHX
 pTBJshWq4eRfC2P+zWvQIAL7u0IK2lb6LYhrSUcF4Bi1D03cVw8EheHr7P4H0VZf2H9g9VtFJYL
 MTvpYaXGZMN/JY/398t1juIxyDGgIU9FyRbrGB2sfOb8kbS8IEMY5ZjA9A0C7KiWlrfJBXtFX/t
 mMEjAbPubjH3y1gDn7bUuWA4U6FW1q5yqgJGldqI2HJc/gubIz8N1VlVfFqaOALsD7jiCqN/tYZ
 PegRoSczmthi+2d8G7IVAESNIExi5EBdAc45f/ZxxHfgL/3i1ieTBR0ozx41CJKqViyBs1rPAdy
 z85vjvi0QseSyjfjx/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfX1WcDl2uw0ZPN
 hHGQKXOL0Fyu4VK5E3FlI/7otLqpkmPSqBvXkYqDVzyLDGtT7q8i0Ih39/AtP/8v9sisRNE8vq0
 EhqqCoj9h+eIpwxXL05kPyQPDzTuV7g=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a2a58af cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=/nYmEve+L4YsDi96RCWAbw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110063

On 10/6/26 11:07, Aditya Gupta wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> Accordingly, remove usage of 8E and 8NVL chips from powernv, as it's old
> and unmaintained now.
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/system/ppc/powernv.rst |  2 +-
>   hw/ppc/pnv.c                | 62 -------------------------------------
>   hw/ppc/pnv_core.c           |  2 --
>   include/hw/ppc/pnv.h        |  8 -----
>   tests/qtest/pnv-xscom.h     |  9 ------
>   5 files changed, 1 insertion(+), 82 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
