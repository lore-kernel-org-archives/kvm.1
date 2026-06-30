Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF13F788D
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818196; cv=none; b=Pmuz4znrPnosBGr3zASusaqUOWfH9FSSud11tTqTAcb6NCLJLISNIyusJsFoi+M+YPidMuoQVagTAeEu2E/RDovLEjuq1fTcnisRMCr/ygALn2cbSbJrzfsuUZjoQ5avAKVHdcCQcoy2NpXivu7O8No8ANz09hG9fM5ky1RfXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818196; c=relaxed/simple;
	bh=wPJxsDL/WLjTdSoGwJyGp+BtFFs4irrrsFk8NuVJHso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4UW1fqdupk+xOocDE0sNdCS/CUhssrFlu9LRYY2HXZZ+hhEa2J68v8slgEcjte9lRpijeNKU1saYRie467oa81ypIpo6L3GItL6+KXiKF2bfdMP7tUTFkJ3VuNR4S3SwVQnDkdeV2xAcWu3+ZZxU++JOF8lMFXpT8rh1YGd7jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N+2VxTvl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N+2VxTvl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nr1C1535952;
	Tue, 30 Jun 2026 11:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J1TFxY
	W1LU7d7iHpkdg6fNMWOd95aruizz1U7PXdBGQ=; b=N+2VxTvlh5kVyid+J9+c/s
	EI+k16NbSF5FaU4CpDvJqDkBlTi9vzdpNgGr9L9WqSzUTezs3GS3rlYNvMslhtU1
	yJQhcTfdzza4oblu0gwYJMdom/m+2bA+WzonHwcqMrTTxvuuDGHIT/elaJGIdIi4
	AZX/y93ouXRnkm+X89TVHsj3h2YU6retQGQC0Y0eHZfkk8ksUIrvFM4IKcg5rj45
	A99C41zZWQ5sn1yWZqVivFGmbc9J5sDaGu1jj+kus5YYP1LdNB3S6Xz+ZlSGghhj
	Bfzmd0JC+HGBnq0kwomvJB1468I00CAiDFtvtWhfn1qVUS/NsjN/06XivOJqmPaQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjp3d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 11:16:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UB4cbo001235;
	Tue, 30 Jun 2026 11:16:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g9qgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 11:16:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UBGKbK52494600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 11:16:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3AD92004B;
	Tue, 30 Jun 2026 11:16:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17C1120043;
	Tue, 30 Jun 2026 11:16:16 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.123.10.203])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Jun 2026 11:16:15 +0000 (GMT)
Date: Tue, 30 Jun 2026 16:46:14 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
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
Subject: Re: [PATCH v3 1/8] tests/functional: Add remote interrupts test for
 PowerNV
Message-ID: <akOlUFpWqeRz0Ft6@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-2-adityag@linux.ibm.com>
 <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
 <akJXAebIn7BHhPRS@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <99726741-229a-4230-b19e-63a7f27ba9f0@redhat.com>
 <b489fbd0-a1f8-429a-90f0-9ed950cfda1a@linux.ibm.com>
 <dcffa5bb-c092-422c-8685-6f247ffed004@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcffa5bb-c092-422c-8685-6f247ffed004@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX2LZplNCV/7UF
 wixGrKecyqay35lE4RjfhrCR/ldTyfSIPyi3LAyg7G2UE0kDaNExkb2ufUAK+fsRVVfnDNvn1/9
 vrLW9D52F+SBliD8Zu6ozD4mrL2bFp8EUEerikWN6qzZqQwtRzg3ku4oFUlZUS2UaIdNdpEuDKD
 mQWwpuUhVhT7ZWBX7PnceiaJC27i2kGbfp12Md0a/ThoKv/41V1PnpF6v5uc3Ay6un/byGOtgH7
 y3z2y0rrjt/rQC8KLmfI7TkxT/hiwAF/aNLx70C+qLjGOuudhRF7RlMEma6f4W+C42dmgS6ytkl
 QYbD1K8jbdFMbAmb6MLFmyiRjUolV1GZjxkDAYrb2jF1s334OhyUoplG2heNCARx9G3aJ/g0J3A
 iEhu/lKGN/blVsltV5MGeZ4+0dvZwPLT32GDRiA5uIxwepebWtQGxGZ7nmxvnQrKk5I+k7P/Gnh
 LpyA+txZlVYOc6u2TPg==
X-Proofpoint-GUID: RpcKSz7DQPqOosIfOvX69FVnFpoIYhEg
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a43a589 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=iHSUZDvydOyf3PkQ_0oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX08rsBUHLsumd
 VDdVEvOzXOOHfN9qbC9kxgcjj4tggKGAev8V/XnPWO8d0o/IwUPSSwwCAizTjsAUBQqtayMH+FT
 xLG7ve7OuECJ6VyHwFy1BYPM15PuWK0=
X-Proofpoint-ORIG-GUID: 7oSPOV3y4IqiKOBd_9y5qfKfh7q3D811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

On 26/06/30 01:13PM, Cédric Le Goater wrote:
> On 6/30/26 13:04, Aditya Gupta wrote:
> > 
> > On 29/06/26 20:13, Cédric Le Goater wrote:
> > > On 6/29/26 13:39, Aditya Gupta wrote:
> > > > On 26/06/29 01:20PM, Cédric Le Goater wrote:
> > > > > On 6/29/26 13:04, Aditya Gupta wrote:
> > > > > > In the past there have been hard to recreate issues where XIVE changes
> > > > > > cause qemu crashes due to multi-socket interrupts such as in [1].
> > > > > > 
> > > > > > Add a functional test explicitly to test whether remote interrupts work.
> > > > > > 
> > > > > > The test can also work as additional boot test for multi-socket boot,
> > > > > > initrd boot test, as well as a check for e1000e to be working in powernv,
> > > > > 
> > > > > you should consider moving to a more modern nic model: igb, which
> > > > > has sr-iov support too.
> > > > 
> > > > yes, can do. with igb i see multiple irqs, so test will have to take sum
> > > > of all rx irqs, and compare:
> > > > 
> > > >     2026-06-29 17:00:46,288: cat /proc/interrupts | grep eth0
> > > >     2026-06-29 17:00:46,391: 135:          0          0 0 PNV-PCI-MSI 2416443392 Edge      eth0
> > > >     2026-06-29 17:00:46,393: 136:          0          6 0 PNV-PCI-MSI 2416443393 Edge      eth0-rx-0
> > > >     2026-06-29 17:00:46,394: 137:          0         14 0 PNV-PCI-MSI 2416443394 Edge      eth0-rx-1
> > > >     2026-06-29 17:00:46,395: 138:          0          4 0 PNV-PCI-MSI 2416443395 Edge      eth0-rx-2
> > > >     2026-06-29 17:00:46,397: 139:          0          4 0 PNV-PCI-MSI 2416443396 Edge      eth0-rx-3
> > > >     2026-06-29 17:00:46,398: 140:          0         16 0 PNV-PCI-MSI 2416443397 Edge      eth0-tx-0
> > > >     2026-06-29 17:00:46,399: 141:          0          6 0 PNV-PCI-MSI 2416443398 Edge      eth0-tx-1
> > > >     2026-06-29 17:00:46,399: 142:          0          6 0 PNV-PCI-MSI 2416443399 Edge      eth0-tx-2
> > > >     2026-06-29 17:00:46,400: 143:          0          4 0 PNV-PCI-MSI 2416443400 Edge      eth0-tx-3
> > > > 
> > > > I feel e1000e suffices for this test, should i stay with e1000e or use
> > > > igb here ?
> > > 
> > > or use a single cpu per socket config. Which seems better for the test.
> > 
> > 
> > The test uses single cpu per socket, since i have `-smp 4,sockets=4,threads=1`. Was this what you meant ?
> 
> yes. or cores=1, as you wish.

sure, will add cores=1 for clarity.

do you have any further comments before i send a v4 with this change,
and #include's removed ?

Thanks,
- Aditya G

> 
> Thanks,
> 
> C.
> 
