Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A43B635E
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308891; cv=none; b=o5MLDWEXDqTPk/Mhc1YrYJGf8sLNOiQFKwSqoEfdvVK1EcKU7vDVdt9MB5qKgM/Bfcct3y7PHovKNKz2umd3tlWoqn9YfLRw222twPtlLBnI3e6JIid5J8c4YWR160Rh4SfK+Z8X75ffnG/eiVd+LReZAU/ecW83s2valn8PTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308891; c=relaxed/simple;
	bh=+SuUkXcRDrGA2g6ILzzszHYue7BwJLG3Iipm68dhT+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIFx7D6gg0ZE21FznlVWpl4snSbah6SMMKWafl5rI0zuCVlg4qbgn0GsGzlTMyrDgFZwd6sjPguX8SDK3Fs5XmpAk92hJzdUB3PKPp5yqlNNnLhWJETTSFcmMOywMaAGxM7+eluzSuQxtBeXfDB6JprqUBDe+SAMEZcj6UppedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rUCHIIf/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rUCHIIf/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmxlP645070;
	Wed, 24 Jun 2026 13:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SgcMkG
	V7hvM0ax53/oEu6I10+bV30F43/QldYfio//I=; b=rUCHIIf/fKCIwDxeIEJjXr
	eLZHnFsxHS1T1FpTYYNywvb8JyRAGaVg8l33oJ5hS/CFHtjwrP9snspHE3S73ZiG
	JpA/QG0sIs+nnYwq+8ikKbDzmHYGT1LnxFSJg1Apn3EpuTlpKWzvMGDhkbNLOVo2
	8juQREMhM0VW2pUJj3agG0ucFCGvOgiSjD8/xeoR3gMfbLR8ncrOePuIKInAF30A
	Llb8Zk0YUTuNUlHHHmwBE2EuiKW4EeHdOZyCJZp2Rv0xLp4ADoueLjSI7TB5jTki
	ot7Q9Y0i+7g4a5/MuGxbg/UosYkKil+3lcdZs9kXYQdMO4yIpnhMOHXEknEqrY/Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4mf3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 13:47:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ODYfNp006094;
	Wed, 24 Jun 2026 13:47:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qh2mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 13:47:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65ODlnPU51380666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 13:47:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A5692004B;
	Wed, 24 Jun 2026 13:47:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D45B20040;
	Wed, 24 Jun 2026 13:47:41 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.28])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Jun 2026 13:47:40 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:17:37 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
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
Subject: Re: [PATCH 1/8] tests/functional: Add remote interrupts test for
 PowerNV
Message-ID: <ajvfl1XVRUJiovA2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-2-adityag@linux.ibm.com>
 <2f6d69e5-e11e-4561-a38f-84760525a549@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f6d69e5-e11e-4561-a38f-84760525a549@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExNCBTYWx0ZWRfX2WQeekJyUtaf
 RxZl77J691M+TR8hdPVYUDR+MXrW9k4Zz463wjiIeWh7PeBhPdIM5jYRVGaQtSqSfxzZMgI1qb+
 jTKgaP8rOIQBVT7/lTjncj/XyNLEtl4=
X-Proofpoint-ORIG-GUID: P52uTQVncJ_E0_1umFDYvOsO0oriQPOr
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3be00a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=8lG4SYNR4Pdbq3r0qSMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExNCBTYWx0ZWRfX55ixbV97ioMo
 /gCldyPY9Dne66dfPfV+K0ojiF0sgfQYs7P6d6e3vy/dK4x7eqWfHtPY9MPjozIh4FsmV62osSR
 KfrW4QhU170MTLc4Nst9H3u8kUltrg2QsG2bcs6tY4rolWW/ZgHyb+cAfpdFlfrgKvV+cmxD5yv
 k/t6zrdInnOGn1u0HUPpHxI0E1YgjW7u7E+0VQOGGv/3qo1BiF0xwCOSp03cxoX++KgCz2YYn+1
 W2jJ2vgfLN/Fu21SyLfU+j+6S3JcODt5oKQlfeHkI7vzd3hWdPXQm+BTL2GrwLrE4nKpB4ir5eX
 1xmSwk7hftmBQC+mFtoZGr/0lyOg8r/700I+sIbsLsoWQP2T0Dzj7tKc1dOVe/BEUa9aTGHfCfE
 imR2ZnIFKStN7Xd5JYvTEF4Bc75kJAsOf9apoEl1naP31kuuqm8kzBMf48ZsrqycFrUWa4A6bFa
 o0LpmwpzfM7UegMxt6A==
X-Proofpoint-GUID: 02UyFluDyZ9exRjSNiEZVvP7EXXjDkCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240114

On 26/06/24 01:44PM, Cédric Le Goater wrote:
> On 6/23/26 16:19, Aditya Gupta wrote:
> > <...snip...>
> >       def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
> >           self.require_accelerator("tcg")
> >           kernel_path = self.ASSET_KERNEL.fetch()
> > @@ -71,6 +75,88 @@ def test_linux_smt_boot(self):
> >           wait_for_console_pattern(self, console_pattern, self.panic_message)
> >           wait_for_console_pattern(self, self.good_message, self.panic_message)
> > +    def test_linux_remote_interrupts(self):
> > +        self.require_accelerator("tcg")
> > +        self.set_machine('powernv')
> > +
> > +        # have more sockets with as few CPUs as possible, increasing the
> > +        # probability to have remote interrupts from one chip to another
> > +        # also have e1000e network device to generate interrupts
> 
> Can you attach the PCI device to a PCI bus known to be on the
> second socket ? and then offline cpus on the second socket,
> so that all IRQ servers are on the first socket.

Makes sense, thanks cedric ! will keep the device attached to 4th
socket, and offline it's CPU, and let the other setting affinity part
same

Thanks,
- Aditya G

