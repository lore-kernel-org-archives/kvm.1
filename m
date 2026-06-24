Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED82D061D
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308166; cv=none; b=SWxrISed0y5VfAz+QEcSsbjSYTNOWkR8SmbsVQStqHjdZgl0lM0I3PhdrAhzJokTmHgLGZkA/f/oP//p/NKGjGtCZfDCtj7INJqa10JY5pcQimWQVCwmi2LXxuMywIFZx32BROJX2D+BqbX2iBIOgVFJ+Bm8LoAaFxeQlkV1orU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308166; c=relaxed/simple;
	bh=aLwe4L6yHvLFX3JEhzMqRJAmRJnvfhEND7h9NrEbYPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMZQBo4G4TFJo53ce+nFh2AP2/uNKLaK+ZMHP/Dd7fPoXwc5S2xbKNCkFEp8DGFvwYSds9nhKVfLbEita3VR1X9zMpcaazZ48JO5402WYB1qbtDrbE9pW2c1WL3quWJpOEEkHloVswJsSogvi8vGsSxJiDB4nAtmbWzk196Lx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LI2VEIHx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LI2VEIHx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmYv8550512;
	Wed, 24 Jun 2026 13:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o8jp8i
	tipPqzXHUsTnS5C4d7cdE7J6Jc86I9G84zuWw=; b=LI2VEIHx5rvgxHPiBTgD55
	1PXhjTlMybSrPe3ANwNt/WrwmC1nQnlIrlv28TSsX/W7kOZSM874orh3n4hWjzv+
	IQiw4tsGhJkrEAo/nGYheqfUiiXFi/YG2y4J80zFv8VtpQ7SLAi05GN2uwabUdkR
	zZDazoIj6LJDyjon6smBCUwEe7dlTvZf+EAFfbKQsypHe9zjim5nI0PcprOiKJ8P
	FSp1yz9TAAOFcNibUYXB0W+koJ96dkXSVES4k3yBnslJzMcX4uTBVCoNKSzP6zSK
	yQZVhNXg0DhfSsSjyckzkFgxdbZQTcEI6W56zpEopyj68IIWjV6I8K66Nry4Vq4g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gm832-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 13:35:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ODYfAf022196;
	Wed, 24 Jun 2026 13:35:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg8j83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 13:35:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65ODZQnh49283348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 13:35:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9ADA2004B;
	Wed, 24 Jun 2026 13:35:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2036620049;
	Wed, 24 Jun 2026 13:35:18 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.28])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Jun 2026 13:35:17 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:04:52 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
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
Subject: Re: [PATCH 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Message-ID: <ajvczRnjoRZhMjA6@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-9-adityag@linux.ibm.com>
 <aju1vc-yqJoaK7CO@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aju1vc-yqJoaK7CO@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3bdd24 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=YtZjg5rF9uJ-3N_UzN0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX/hFxx7lYvwSP
 9yBqtO6VuLo8IuXoNAcDLTVmAuAehDcNTmqAiEf15QWXQrx10eqr/Ym8tIyTUHaPTd4yILbYG3b
 3ETA02PfEWw6r1dZKJwgtcRShoWMkwfhZEb7fVSj2MBRBbhJSe3X93i5LOWgqEVEjueyEDpdNAU
 vL+p05N9LfYQE2CGrHTHxJh6+mmStJZMCKPS2tUmHfcqDSyocGOk8GPBB1hVhQjGw8yY6KgeH+n
 TlTzu5Egn+LqtMSvZczYri+3RlvK+L3N4ZnxCQLzV7GYbd1J+P8U/kmoWTNJknyIi//aFjnVi9K
 lIUtdhXcM7RnQDJ/ARCGH4CL+iaZWJNoVTnsgGadHGe+3RkJu1xnr9jIlS0tkpUMtAP6Knj1CE8
 xmh/tYpgfxQ9F3q/mXl/Tdk198dDzQ==
X-Proofpoint-GUID: xicn4HJKaj7ffJ-uljR5JqmGZlMrBaQn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX/T1I56G09y5q
 o0Sxkut7ly3FvtV8hlKxGzKKbNFOOEhu1VheDWD0AzAlqH0pB9BrRnQHu2pg5lZEjSoPeCkTjEt
 ovFZEREhpVvoNZi/EXe9RbQwTEtGyac=
X-Proofpoint-ORIG-GUID: ZMQldKijTdF4d8aQCDLcVGpWolXQUaEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240110

On 26/06/24 11:47AM, Daniel P. Berrangé wrote:
> On Tue, Jun 23, 2026 at 07:49:33PM +0530, Aditya Gupta wrote:
> > Add myself as maintainer for PowerNV machine, and remove the
> > reviewer entry
> > 
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >  MAINTAINERS | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 93df53d87f63..67f65bff3913 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1646,7 +1646,8 @@ F: tests/functional/ppc64/test_tuxrun.py
> >  
> >  PowerNV (Non-Virtualized)
> >  M: Nicholas Piggin <npiggin@gmail.com>
> > -R: Aditya Gupta <adityag@linux.ibm.com>
> > +M: Aditya Gupta <adityag@linux.ibm.com>
> > +G: @adi-g15-ibm
> 
> Please drop the G: line, as I'm changing the approach for recording
> this info to be more automatic.

Sure Daniel, will remove it in v2.

Thanks,
- Aditya G

