Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82437649D
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793858; cv=none; b=srkS3HOuXevInDg2+8fRVDz1ZaFxei6hGXIk+csCU/Lgrz1Ka1kPfF1MFMfnw/5FCKuoQ8V5lFMJW++RQpPbhHyWy3R6gPj6dkGVtwJ4C3cX6iQF5hQl4AcwzeGcX1/2JwRHSyBCdJ8XXBHo+iwv8YHp3AkCfHOQCQkMeDztch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793858; c=relaxed/simple;
	bh=qvmZnqQatSPTh1mJ53fMUFwvoaWUfo+pkcEdCDOubK8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P0IHh5P3ZLk/lw/8KW2ROABcjQvQe9tFZk4QeNBLh1jS7fdiHgpfCY8O1JWrurea7vf9pIKUovr6eavaVIIrT9m+158LqinGpfsZAePYXgX++eUfRNclE25miftpjDv1h7D5yatAgtF3sCeo6w82Z6KmlT/BdaJvTGAgfOfvPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=in+eEmhZ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="in+eEmhZ"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L2rDC91822406
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:50:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=u659RX+V+MG6fUG1Ehn+R9BUUW23ImKdrAbY8lfxzqw=; b=in+eEmhZsETb
	gjRHvR5LY0m94Hav6Vx7ss+ceaG7yqv7BpF9MytWH4HL32MRsnjTo1w+QVhAHeJC
	8HVPBZmN1jZ25Xn5utC3JEhszJ8tHhBXleMJ2fCSSuTz68CLmVszOGoiQYQrLr5t
	ryFMCuOgb+O/VfMUlDIXW14Gk7PAisip5l0xO9/bryvaE2wfnrzBYPpiKcBnbuzM
	6CNmb5/1oaEFYroz49Y8Ijo9Y7DwFvj8wWlmiIH5Yxf68nvA4M9SudAEYwPJE7zZ
	hUAP0HQi8eMNWOQswnLPSwWAATztx29gNRtnOD+STgmTDp3sTXUcoA+17XQ3LS6f
	U00jbbI6Wg==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm58yj4kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:50:52 -0700 (PDT)
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so36006435e9.1
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793851; x=1777398651;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u659RX+V+MG6fUG1Ehn+R9BUUW23ImKdrAbY8lfxzqw=;
        b=pHHddvz8Y7x6HLd0kD9Dz/Z/2IxIJK9imYxzpKMVEOoy6MB/JkhjVraN/kn0qIdIOg
         vTdelqd9NptVyXOyzy9DLw33fXT6Ye7ww4kqzMWfgvR5QN5UzBYYTfpZ0I70M3YkPEPW
         t+WYatp84ETzggWtRErcx7T8KnZ0JBcaiPU0linSzqCb3yfcbn/OKojRvDEcyRWRqKTI
         aykjmwWnryuLftdTsMotvKihRnsVjzsKnyCCLqr46M3doxCaewVKORer41+no4OG9ygA
         js5m7aPvseS1DbQEZ/ajQVQ96C/+WKdrpHMzeT1M+xE7gRBeJGQTt7aF9RaPt+05Ky9/
         LZyA==
X-Forwarded-Encrypted: i=1; AFNElJ/yFwJY9DC5Ki9gPWW6Ipvn4cfMNIwEMMjmOzP0CxQZzt1FHH+bAhZ9RZLb5dJCVSawPUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnl/EG5aLFM8gucLXU2KrOIYTtkBi88XA6r7a4uU1y9psbBrHP
	KbxyzaPGnbbdQhbbLcQxg2hg19R4y4D0DGNmjEbSbWdiHhwL5cKbalCxuhVdr45AnrNmqe2yTwL
	vuPlMnsis/PQD0EjO3np/pf7SECbvtpCCr+uBvISzu+5TZgVqXMdf
X-Gm-Gg: AeBDieuM5XXnXn2yK4oI+zPj/OVIgE0k7K+9dI2VLDL9olGu0C1alUWf3cbuncGpTRG
	ePfiZDDUPeZecmKPL5aPxmYGyammku5dRb2U5Lf7J+0YGI+rCtdHpKB2I6ZkZMKnVDTAaX1XOZ8
	RltxG5yB9OyViWVThakVRatdUtR2TGECbrSiFd431zsMuTO2O1QPoV+nI4VSLhjz4ot9omjOCpR
	f0AcbPZvDejJAJJcwAEz+ei5uNNLahXbK2GEaSAeLqPVnDgb/sCHLw3rH89nCDmB7Onls3abRCH
	4ExwzITMgTSweaj7aFzO+tdtCCVXzXC/8p5rPWhh/m14Ak6NIWsbB5FUbg26zyLJaW2i0E4R6a7
	3cNBAGimsNRBAZPUfatmGi6wRD2aox29ySas3kAduAEDs9qt2Vo45BxAqxlZxQ+kKTQodSjtBVM
	+gRMS3QhM8spMp4boRDQS2g9zZt6GeyrLNyH4LIMZkKPV8QyCA+PHtccylTNjKS3366pNIM7tBv
	LrnRZYfj/8L2apMMttrn4/Fwl9Nxibzjg==
X-Received: by 2002:a05:600c:8183:b0:488:b187:d898 with SMTP id 5b1f17b1804b1-488fb771445mr230344155e9.14.1776793851158;
        Tue, 21 Apr 2026 10:50:51 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:488:b187:d898 with SMTP id 5b1f17b1804b1-488fb771445mr230343745e9.14.1776793850681;
        Tue, 21 Apr 2026 10:50:50 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm641230725e9.3.2026.04.21.10.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:50:50 -0700 (PDT)
Message-ID: <2487afab-779a-46fe-9f85-4e36748cd9b5@meta.com>
Date: Tue, 21 Apr 2026 18:50:49 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Don't export DMABUFs for unmappable BARs
Content-Language: en-GB
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Ankit Agrawal <ankita@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, schnelle@linux.ibm.com
References: <20260415181623.1021090-1-mattev@meta.com>
 <20260416081138.GE361495@unreal>
 <2ea075f9-c80c-41e9-9f93-9b0a2858f68f@meta.com>
 <20260416131417.GF361495@unreal>
 <ed5d615f-5ba5-4045-ac45-79f06fd07a05@meta.com>
 <20260416154806.0c5cb10d@shazbot.org>
 <9a8b39c0-5c0b-4f32-88b4-225f16e8f3c6@meta.com>
 <20260417163151.18ac44bf@shazbot.org>
 <789793ec-8ee7-4cba-b20e-15f8bb6f494d@meta.com>
In-Reply-To: <789793ec-8ee7-4cba-b20e-15f8bb6f494d@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AvHeGu9P c=1 sm=1 tr=0 ts=69e7b8fc cx=c_pps
 a=Q4jRaax7EcWM5fECTC1wcQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=Ey9hfNUkbNGToFrkYroA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=nJq5_VNI1X7IEIKzvdHs:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: zbn3gGiinT72hm1WGYLaiYEPkB7FZGOT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NyBTYWx0ZWRfXz2Rx82zmz9Ue
 ALDZrPijqYjIgnuT6eZedh54H9mBS8QVACnV5538XJNHh74hJJiE53lLjilhUwGJ0VuA58FSqeu
 5mFNrAObqm6uQ4/Uj1Ezg+JgS5cG8afTUEVN3CU/A9daTjcXmIvCXbCGp/RRI7Cw7c2wbwrQ2HT
 hgGi4OY6s2MNg5lSXAlFpgNbz9LEqlbPzBU/Pw08DQeOFuzALTTEeX6tgn5l8Ip4ggjPefOr6vZ
 Ok14FQ3AXUBb6LfNzuCDpn/LvjqUf7exC9MXiXs0rVd9yWB4MfDOKqcdj+mj3IcwH3SYypUjx4R
 uR21h9j2a1fP1vg8n/oxSKLfLtF5STwJsFpIVlqOxtB+RFH5JjOSMfzkG2HLTIOOeJHIE/Alvi6
 GP+OEMu67qO1w/Z+80918cqzJ1DimL6pe81CcSe16/svxA8hB7LpmXYBBwDEz0a3sOiiWKBqZU6
 Q/EZtmIlF1gyCIj121A==
X-Proofpoint-ORIG-GUID: zbn3gGiinT72hm1WGYLaiYEPkB7FZGOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01

Hi,

On 20/04/2026 15:24, Matt Evans wrote:
> Hi Alex,
> 
> On 17/04/2026 23:31, Alex Williamson wrote:
>> [snip]
>>
>> That's fixing the leaf driver rather than the subsystem, where
>> pci/p2pdma really ought to honor its own flag indicating the BAR is not
>> mappable.  The precedent is already there in rejecting IO BARs.  Thanks,
> 
> All good; I appreciate the discussion, thanks, and will redo with 
> checking non_mappable_bars in p2pdma.

Since the patch has a radically different subject/lists, here's a courtesy link:

  https://lore.kernel.org/linux-pci/20260421174351.3897842-1-mattev@meta.com/

(Obviously we can drop this thread now.)


Matt
