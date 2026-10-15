Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF14AA41D
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050876; cv=none; b=cCEXSGf5NEstJWLhA8ZKx+lz/TmAzvvnD1TKI+gcMERq0efzEdLeIymQt0XYMvTSjbvNMjwLaKiYQOhOLq9ijQdtvkMfnpLqjpNl77oQZ6OPxTRfq3KrJuJxsq21/dyBfat5iUj+R+TOhckwZByVxaOKLcbyX3RW9FihwbVjbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050876; c=relaxed/simple;
	bh=hVteIZnn/KZGhwyV6npF3HFMEF8PGQ8W2HWu0o+zPKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aftpDLB5ulWXxW8kKWYuhKSZB+TlcJXNU1onGqtRgsJwAvnGHmOP28m/zy3D97tX7Gd4gfQ3NUMVQW2Tzyi6vU8mbMg8beWx7Ki2n/4XgDZZQEov2ujkAgojL87CIrbjMgjLb3SQYKzeyrOw7L7Am0EgcR5qOWFgvHM8t1Y0juk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BUOJCsjs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Px6kr8sV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BUOJCsjs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Px6kr8sV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F6Eswt500302
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1dJSG07GXyGKGiQW7TmuVDezgqv6wfOW05ypU5gMGE0=; b=BUOJCsjsIAqYjHJI
	AF3wypISTszN5hD+N7W+fcozerWK14lPAXXETxlWb11U5SEVyHO/pcaU2dDcBtfb
	L//nsOQN1X4j1tSgtPbLKcSMbS1eg1p6CmFKJ9BgZ8SgrbHrqEGovvgNS0GszWZW
	K/jrfOmXFu0hg6JvTfXD64s5h9xg7X6BNtG346VVjeHhYMIrUJEsoP0JwsITp6xi
	9tha3OXTg8lKiWDA/TM4hikFaMe2MZKqZ/F4uPgLGVnMRmgtG/JoPRpCQ1uIY+IS
	hIKCshKsh179sXkZwBMGuPNbFnNziTtXIEWzd+R+CkWS9PncY10GOsjoq/BMKATA
	bkP3BA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf3w0h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:54:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e818ca61bfso17800545ad.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792050872; x=1792655672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dJSG07GXyGKGiQW7TmuVDezgqv6wfOW05ypU5gMGE0=;
        b=Px6kr8sV6z102UhliOUl1fkIIc3wG4qP3hgJ6F1jlXuAmTidRVyHCDFNdgVX7jXp3R
         zpwXHLHpI7dueHMxIS89d2DM0BunsrrVgN+6oGFydby0wcUGxy0k+JlVnZWEZsub46KA
         FufB/pzHmNKnQ+MUTgSU9598rS8yY+Q54IRvw2U91U4mku0Oy7SEBABjkisYndGsxOGt
         GcJ/Qfm1zI+QszJng9ndGhSPcslj15u6vS8VL3pJRgwa7po4eiixcuvI5+ip7+bMoSW7
         dYN9epv7O4n6nh2qXUSeViEsSwL50Wn40EkFRHGrDKvVFEZtC9xJYclMmBT1sW2JnNK8
         PGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050872; x=1792655672;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dJSG07GXyGKGiQW7TmuVDezgqv6wfOW05ypU5gMGE0=;
        b=tUnU7dG+l5K+EA8e2gScNKbmrkv6yI2gYJcC3hflD6Ol3yQpwOuqh+OOc7KTOQSBFB
         Xk+GnBJnwH4542+ZWhzHYK1kuPdtQnEppDin+9Zbql/Gc1kCQKk3Tl+OJTLT5C+yTwmf
         Ksoy1FV7QP9rov21tXtmSUEWwRUNbzT08z7SuhOkGhzz+eubqACWPDoa978ghDciOPxE
         K6wcSHzvHmEhOa7Gezht9gpg41l/1mdTdb1+j5p/FeySCgzSvfOsZmVgFUCHVUT2UGnb
         qcv4ZUHcacGrb0wUzhgEuesU1uV/Juy6Nr/ITTu2mtSJIxfTGSfpsA9Fc5OhyacyoPiR
         hypQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaZNxWP22qbMLVTraXCKlUjW/z8uT9Tl1ZhI4dxZ3malB06Lo9IeXGAxt9/NKbn/etc3g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwW7fAt01UQRJo6OGa/lSFGKBalx3LEEG933jokEG7aq7Z7TWH
	W+dAX1OzAsPpr0/4DNq9metfQNfkZ/I/+cP2U2kULVcU6AhoeCF3CQS+JvJgktgWxcahBqeSVMV
	zJVxq5crJptAE6qqa1zRkKYJ7M3JZZQR/YCqvI19LafZYa8hJujEwn5s=
X-Gm-Gg: AYBFou0yA+gekpgp6eHA5NvfjS/GOJTyMmgkJo5l2zihf74CbpfYqmuoNPtGGWhDbZq
	RM8wT0+fbtqwCX3ZUoPorhYvT4uXOxYXZgdPKzce4z2rncfEK75JFSSbXQL1kAI69T3eLuj/GQQ
	9JdUUB0BfDlFEgprNLE23U7sc1ALPvAPfI5lMKoWX2H9opvgyup78CLNZo4oYGycHjfwROow4JC
	a6q6e1r/s3n/P1ZptSk8Hp0WpJ0Unx9iHdmy76VvXyRqyOTOFia96Fwpx7XE0snjJCmeg2Cnsso
	7gX0TBbKnVa8luzzvwp5qfTux2aN5fBhNoAFurI2GJqTHdY34WhV8f7fRTT9TDkf8bq0YWKwutc
	4w5g/DOxx6PaY0suKMhKfZbzkM46KY4Ves6gTC2LeRfS0l3zU/M4GLL2GoGXRjSw8zsQd+oYo
X-Received: by 2002:a17:903:110e:b0:2e9:2a1a:8b69 with SMTP id d9443c01a7336-2e92a1a8ba7mr57665915ad.55.1792050871823;
        Thu, 15 Oct 2026 00:54:31 -0700 (PDT)
X-Received: by 2002:a17:903:110e:b0:2e9:2a1a:8b69 with SMTP id d9443c01a7336-2e92a1a8ba7mr57665605ad.55.1792050871349;
        Thu, 15 Oct 2026 00:54:31 -0700 (PDT)
Received: from [10.133.33.32] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm76306455ad.54.2026.10.15.00.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:54:30 -0700 (PDT)
Message-ID: <56832d7b-e7a1-49c6-8995-4b17a442e4e6@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:54:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Enable Qualcomm WiFi PCIe passthrough to VMs
To: Jason Gunthorpe <jgg@ziepe.ca>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, alex@shazbot.org,
        bhelgaas@google.com, jjohnson@kernel.org, johannes@sipsolutions.net,
        mani@kernel.org, yishaih@nvidia.com, skolothumtho@nvidia.com,
        kevin.tian@intel.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <b1a3f755-19e3-407e-b8f8-b494de83f59a@oss.qualcomm.com>
 <20261012144835.GG14213@ziepe.ca>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261012144835.GG14213@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMSBTYWx0ZWRfX5zV4V5jtDCAM
 1To0HITrOtHldVOV3G4GOxomyKyRMMfj28vSr5yvf569Ww5uiWUekTWla6RmujaidA4JeQyIaGJ
 HFYguvYpjMKlLXhT+9JTBOd3P4yK58GtrRHU8gf4R1oGynp1MZG0XjQIpwaUfhtDu0awtKkZdbY
 F2eOge+Vod1criASE3wssTssBESAJGDkMZdGu4lxpBHwhFwf+BTxjeIsXrg2qTxSs+pyB0vlDG+
 TkBp02tHpW77N/QfbUuvKZpwuEvTusWbL6ktmouyePvHNIchFay4ax+tfdAWzs17f45a2xPbz8H
 Vd+L3KPs35uaACTqv9PMEaZJ0MeSH1Wwn0RvApQxCdYM2q7kZQeQ53Qo8D2VBSpya7JE1fDBaY0
 GPWHnCzaWQK6On0akv7liDeObj/vN1GK2t8VHVG36U3iwGZJfeKFRB+c8/B4JM/6e8pZhObUICY
 NiaJYnqPZ90HCuuJl+g==
X-Proofpoint-GUID: G_3Wq6ToJsUoThrr6h-q6sKvFidvwgBI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMSBTYWx0ZWRfX8l1894hpIxsW
 UkgXrYvfhhNwk66ctTCXSlzpJhulLyq/2QN8JhkvAaGaxtbe8p2gthrM3SDajDDVGxAwKHLhtPB
 OuZw+2g0ZzabWz/skWvajFfwuOlL79E=
X-Proofpoint-ORIG-GUID: G_3Wq6ToJsUoThrr6h-q6sKvFidvwgBI
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6ad086b8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=n56IT1IzDtYYEsRGsiEA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150031



On 10/12/2026 10:48 PM, Jason Gunthorpe wrote:
> On Sun, Oct 11, 2026 at 11:22:26AM -0700, Jeff Johnson wrote:
> 
>> Thank you for providing this level of detail in your cover letter. I've raised
>> this issue with the engineering team in the past, but I've once again raised
>> the issue with your in-depth analysis.
> 
> The main issue here is the driver can't use a normal MSI-X in the
> normal MSI-X table.

to be accurate, it is MSI :)

> 
> "private" MSI registers don't work for virtualization.
> 
> Jason

