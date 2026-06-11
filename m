Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901016A956
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160150; cv=none; b=Z4rKTrWgPLZ3BLxJZ9GzQUklSvf/Wi+eDvIzuXigxfR+uMJS804EjzA3qhh3Ct6Y2Z0louLODapjRjSx2hiBwOxCgTPAmYaOkkBtJ1TW+aYxyerxgpHZxVhrJr7jgsjOlddi4++VDumJThX5WEGQiH9jnhfHLZi081BHoESCvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160150; c=relaxed/simple;
	bh=8cErzV/1kCpY5TloMwC8J4omVYuk1Vy23od72mj5clA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKNHNEmVui8b5EXl4+zHobHbyQLdmR9iAn3qlZdVUQ97dzhRWl31SiDpkmrhAJqvEHa4a/qT+xsWX1gq5OLjgPFi2zPFMSshTf5i3DyoGM8aWs+fnPr5e+38MOS3j+p3rC+WbWRpnGetyK0qJe5y0zCX5MzlyItAXiazuDy0fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=My5NhvqI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NZaV6oF7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="My5NhvqI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NZaV6oF7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GKWu3761261
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gmzzsIqFmZoYfm8M0rjp/DD25RwJE352GmJYRit/whg=; b=My5NhvqIJyjd63qk
	uxf/+atoeZIiDZXubWdOAwrTtRYVZBnobm69JNdG4QyOqDlbUlH9gvZwJ2Gbxjar
	trn27P2VpEzcwgUacPr+Mk5c9AZMnVszNbe7eFb6lR3lHFirCF3CJbCtVvN3sN5z
	Ndk0vTABwsKb2N77UFLWSqQsEUJp1kpgx7GhPsMsryRWn+ZGFRxjAxnZJ4TMWbqB
	sCjN3Bo02/Uv8cvP+FJ46hD7zVq0mwbcVC4ZTDfS2VqPU+mf/9QcWsiQkEcI1Okx
	m12dvF4hTQOVYR7K0dkHYT1vxEqpZhpkMXQLuTe9WTBmn+JrG74s4cXu+wmIMEQ7
	0Du0pQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sj3d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:42:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517e054fe07so38785941cf.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 23:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781160148; x=1781764948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmzzsIqFmZoYfm8M0rjp/DD25RwJE352GmJYRit/whg=;
        b=NZaV6oF7YEAWLInX4cHDjZNfIAaRwXL3IvHVH89lGvbUA2JNqY8vtc82CyvLbFWpsI
         LKw2lKrqsj1+onBMeq4vED1q7eQbQ81oJRPbWskv9VOq/ziioFCT8gJ7Fem3hB5uQmWI
         HRpxfibAbuR0EXLnWkKRDY2jj3j4d2L9BEp4KFWJPNjWdzXYyMdLVly5j0bA/VQS9v3F
         skM2C0pq5sbJnjIroDw8I6spB5WGVPn3tD1qtyXt+om7C++B7OJYH6ahLv6+Tr9JPX71
         R69Yr8GhmJ9NGCnZtdpU9/o0ic8r3OP6CaPgaDECSqqFUCELbRdwWxkwVjCikeU20/+q
         86zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781160148; x=1781764948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmzzsIqFmZoYfm8M0rjp/DD25RwJE352GmJYRit/whg=;
        b=MFiqIlC/RtkNMRSX/h+qJz5H9be5Ml9zBuZFjNv1UPIsFcChbCaW30Opm8ZTKHAXD4
         c7hy13TnEVeAEdu1vfmCeDS0PJuOYH7jz6wZ8sQyjomDtQWXDCT4967ltG/5npv99ujH
         ZpLWAuaGoavFqB5tIyKTiqb9ud0LtpybhNmeyQhVGKY/lmOjFEtrBlNxvQjZG6iId800
         NrzecDMtav6DHPslOQfE9TpPXFYtOKPxc5Vx1VNoY8+N5TUbuVeInuTWCQtA6fanZS9X
         f72egTOfJ3VXmHYKDLmpalK2qMIIIAOVGFB0eR8cYACahKDplaforp7mH8YTtEgfhJ0D
         FOwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kOHjlkl8kf/kGQBVlhHKmpWbEs/tIEtvgogFMn0JJCV8ES+UVnEbREKleASoa3oadWQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMtDDCz1mzUKWWn4f3N7XYiNL455pmVD/5HGleO9OveHjsIGZ
	TXSO2euVn/xB2p5lOHXsUcZjrozkRTkf+nQnmPiqGfPPc9D6h6oqcpq3pevih1yX7Kk2C5hbtyz
	EOOR8Ycq6mtTgnspDvD7C29sLN1qOTVsL6dYsD7u0FzAi8n0yI3CwfF0=
X-Gm-Gg: Acq92OFEsFL6j0L8GBhQsDMwKUwmJhkE7gdJihuELDd7YBA/qFUwUgyd0ZRSCwupP7o
	vtpcNwYpP1ThoidlPusPSpIxtFuew0r7un1DDZH66xdCtOZRGjglZ+Xu3wpziOckWUDKpC983gw
	bsCK2q0uMxrLx2NSRvnxGUQQsG0ZuNtAraTe/9H1Ydr1nGdQkLbuYaXFL8nVJ99OwShAqvoEhWG
	wVallQgWu+f096jps9lDBKwo6zYksSnxGAwnb2B+yBN85x8p4ofl806m/rFTo08E1YxCC6Y+zjo
	LJqyLUsNXNohdyD10eCQLZv9N/W2XFZOn5oX8xZwRfA06tJAfGqijZ9T8OHs2DbjlJMD1q7duKl
	bU8/E7i68hiHDkooP23yjX7Nc3U1X9hbt78ekGrP8v1xpevRiUax/CfADzBB9o/zxC6V8yZ4FOx
	BPt535Lg==
X-Received: by 2002:a05:622a:28b:b0:517:6e5b:ebd9 with SMTP id d75a77b69052e-517ee244a94mr23003331cf.31.1781160147624;
        Wed, 10 Jun 2026 23:42:27 -0700 (PDT)
X-Received: by 2002:a05:622a:28b:b0:517:6e5b:ebd9 with SMTP id d75a77b69052e-517ee244a94mr23003101cf.31.1781160147148;
        Wed, 10 Jun 2026 23:42:27 -0700 (PDT)
Received: from [10.156.84.244] (218.170.88.92.rev.sfr.net. [92.88.170.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb668c9f4sm17602766b.56.2026.06.10.23.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 23:42:25 -0700 (PDT)
Message-ID: <d92662fc-5483-4505-9330-7271d666bc37@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 08:42:22 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ppc/pnv: Remove Power8E and Power8NVL CPUs
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
 <20260610090800.3672832-5-adityag@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610090800.3672832-5-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a2a58d4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=/nYmEve+L4YsDi96RCWAbw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=QKpl30L47EuW14pftawA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: bRw-7HlJ3ig955v-FaFzqbZ9T8scB5uH
X-Proofpoint-GUID: bRw-7HlJ3ig955v-FaFzqbZ9T8scB5uH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfXxxmPm2PwO5zd
 6TVHzQ6fdmAD/XNYk8cFcbaW4XdgSMOoFKRw2pDlFNvBy4lwfKPiwLLhp65w1F9hCTlCEuxcrfZ
 8rjrcUQfqHLz9/c477rbGrrrAUaO9Nuujtzlf0Vfk5+8o1DZc58adhE3873lQ6FiQDlKoe5BTFC
 Rt0C5Wq/jqGuxkCEfWxa4tGe9bZ495Lxy+TwSB8m1t26L2unKaUP/nAVPnMw4Xm/ri5ZzwC/Hk5
 ZI3vOWNoSct1CZavflT/hun1KmccN5GG3Ofzizlnh5/6YhNZnPraMXYBvQ0kscJHqjoydWLhV+c
 hczugM7exQA5HVMMYyP3GOech+cqzeq4ZI6Wz0Z9bLQze/ppYW+hlGgmDZ9SujpWzUuf3fkC03w
 dzwQaWYlrlb1vPxu3qBOf5Px5CNiqwI9yPZ52M/PMcPZ69sfpTHcenVC3fMvLAX+nrUTxRICh9h
 BCUgxX8LX2d0PZAouFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfX/d5afL3UVDyZ
 OA3Eo5AU4ppfheAAHKdDNm2QqGDl6PzXIEfriRff7jNhcL8OMBW2FqsiZKaBX7Jf94YGrf5Zj28
 X3NR4MeIMCVmhuuvVPN7V8LosY19hWI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110063

On 10/6/26 11:08, Aditya Gupta wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> With no use of 8E and 8NVL, in powernv chips or spapr cores, remove the
> CPU definitions for the cores
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/about/deprecated.rst | 9 ---------
>   target/ppc/cpu-models.c   | 6 ------
>   target/ppc/cpu-models.h   | 4 ----
>   target/ppc/cpu_init.c     | 6 ------
>   target/ppc/kvm.c          | 4 +---
>   5 files changed, 1 insertion(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
