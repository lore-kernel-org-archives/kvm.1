Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA692874E6
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369226; cv=none; b=RffOj4lqRuk+G9w3L2JQauPJE4w1/qtiYHsKmlNb6JfCwA9UXcz87fNR0RgdszAG9YkTO83TnzVVxZJRdA3rS/I7kcwIXgtJcx7Jji1EaQZLvWHcCVgCFh4+AvQ7TYYrWuzIFJIONaZkAVb9S/hidPNCBE8pmOqlCTwc2FLXKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369226; c=relaxed/simple;
	bh=/aC8130EFJ7u+kWfB2Sh3kUu42G6SuYlpwYaOu+3aYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdDNGJwJy7k1xcYG7+bSSryVmbsC6UN0iI9aww84WnRkUjEh6xbl/nCNPnuyc8L9UsUb4usgiRsz10LijDPDCX9BEJKeogP0YO6I+xVdu54an/8Lj6TiV9jnavOcgXNyb99MWfTTllzEwJJxWuX3E4d0onRAhWcI8CRdCmDlVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FqnfGnJi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FqnfGnJi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mVWm2977929;
	Thu, 25 Jun 2026 06:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kcpKFX
	vTivp9kP7qB8T1/R2TF8Zj3x0QbugW4pPUHjQ=; b=FqnfGnJi8ciFIa6uS6nv/A
	h2V8Fe4TqKS4fRInHXWOEpiZNQWIkpURIkaNkglHGKnNObClyj7iAvNPwtb3lFTQ
	IcTA05q/5aKRTpnPck+EA+uLkt7mkjHma/X8wTUaO1juPywFcvBV05BK5X6FZi9j
	TOHuZU1pKdoqqosFvFqnnUKApSIZc+tcrAdgAfeG0/7HSaUQPb/EGlZkPLA+Zd1B
	WLEbTx5Na1d20hnKEEtld8uuLZNCETYrfoQ1MGuvbZeXTQOY/yoRrNMEHmQo4Keh
	+L46Umefo1Wq0aCZYvpYQo6Wadlf4VwAEUq0mieBWSD6GnYFgbs6bkArB8pkdlDw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4rb94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 06:33:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P6K8L7005392;
	Thu, 25 Jun 2026 06:33:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwmxm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 06:33:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65P6X9Lj45744578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 06:33:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DED0520040;
	Thu, 25 Jun 2026 06:33:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 863C52004B;
	Thu, 25 Jun 2026 06:33:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.21.199])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Jun 2026 06:33:02 +0000 (GMT)
Date: Thu, 25 Jun 2026 12:02:59 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
Message-ID: <ajzLOyHQDof4wO4Q@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
 <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com>
 <ajvemcUx0k12xOIW@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <4edf1ef8-1d88-4ad1-92eb-d587974bcd20@linux.ibm.com>
 <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA1MyBTYWx0ZWRfX2+IdW+nAvkZm
 e+TLol9Y5ZT2N4wdL7MQJwiyll/RYHv3ZJoRf4+4iGLTM11mjUXh8RoAs6IjTa/zHM1MxSSEzbk
 nTGdo2k1k57UcpsHO/5xS2UAdtIQTKU=
X-Proofpoint-ORIG-GUID: r9K0Sw0udjjc10GPdX0yvmYJkxE-q74a
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3ccbab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=RuPvRiwboNjlD2If9HoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA1MyBTYWx0ZWRfX0ANGCJBrG165
 5gDwJCeH0xMtLA2yykQUWt9YBJqY4dSNF0D3nL/qYrjDLw2/eEKy7tdzlDvc/WWl377G3CPH3E1
 SXD6CQ9X7mDeJPNq3ZwjPtd1XIWHxETxai7wlesO0q1loCA+hvi88LLi8EA5ShgRckyOnDSxdQ2
 AEwxpaWsOF/hRj/ns+JK6BD8jmUc36kVOjVjxNUpFNbxGy9FUoi6ndM5f1cyNWOhaZIjGrajXyU
 +dDQ3X/D7OSa1EnMsrsZ2mH/RBsVxpl6gbuVJyvpYuyYfuXCfPpy9ghNZ2OS1a8plkpB8ecAf/N
 nPNjQa6WYoLCqfC0pO7MTAtsfkviSwRVXTHJRcG+00U9nPBa398bLWh8T6egxF4uJ+L+6TxwJce
 IRd6/3WN2y1IUTUI3rLGRgUmWNGTmO+ADV/Q+S0zqpysJhWU94m9lYIT+H995fo1VEwV5c3OTde
 jSLXB3h6t68V1VrEb8Q==
X-Proofpoint-GUID: paGEjVdJQkFJAkStK_BinL6gH-QrwnH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250053

On 26/06/25 08:03AM, BALATON Zoltan wrote:
> On Thu, 25 Jun 2026, Harsh Prateek Bora wrote:
> > On 24/06/26 7:14 pm, Aditya Gupta wrote:
> > > On 26/06/23 09:24PM, Shivang Upadhyay wrote:
> > > > On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
> > > > > +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
> > > > > +{
> > > > > +    if (chip_type == PNV_CHIP_POWER8) {
> > > > > +        return "powernv8";
> > > > > +    } else if (chip_type == PNV_CHIP_POWER9) {
> > > > > +        return "powernv9";
> > > > > +    } else if (chip_type == PNV_CHIP_POWER10) {
> > > > > +        return "powernv10";
> > > > > +    } else if (chip_type == PNV_CHIP_POWER11) {
> > > > > +        return "powernv11";
> > > > > +    } else {
> > > > > +        g_assert_not_reached();
> > > > > +    }
> > > > > +}
> > > > 
> > > > How about refactoring to the following?
> > > > 
> > > >      static const char *const machine_types[] = {
> > > >          [PNV_CHIP_POWER8]  = "powernv8",
> > > >          [PNV_CHIP_POWER9]  = "powernv9",
> > > >          [PNV_CHIP_POWER10] = "powernv10",
> > > >          [PNV_CHIP_POWER11] = "powernv11",
> > > >      };
> > > >      return machine_types[x];
> > > 
> > > Has a subtle difference, that it may not assert/segfault on unknown
> > > value for x, I want the test to crash/fail if this is called with an
> > > unknown/new processor chip. I believe the if-else/switch is better as it
> > > handles (by 'crashing') unknown values too.
> > 
> > We could just do:
> > 
> > if (chip_type >= PNV_CHIP_MAX) {
> >    g_assert_not_reached();
> > } else {
> >    return machine_types[chip_type];
> > }
> 
> Or even g_assert(chip_type < PNV_CHIP_MAX); without the if?
> 
> Regards,
> BALATON Zoltan
> 
> > That way just adding new array entry would work for future chips.

will do in v3. thanks !

- Aditya G

