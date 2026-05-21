Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437A37702E;
	Thu, 21 May 2026 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356014; cv=none; b=KRvd70y80n7berh+ssAtk1TKqllM2s0FNryoasx9JtU3X9xJQRLiezxrgbKcdAdzcvdbM0PAPSaVoODFRJELmrqNyBTqlKFuIaNls2YlnRoiUonuLQfej4py8eyWbm1D4LEz9CWZQnhzDJuZDFd8pyR/D/l+K6QUYuhX29JzF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356014; c=relaxed/simple;
	bh=w2iApBcpU1slHHlzAFIBH319Kv8zAfKYI+2jhBD82DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMMHjSmqqBoiKEg0/fmdUHUoG8cD9HRnZoRQ0SMLK936n6DDZyl1nZ/d9zF/BtbJMDa4TFME8h5j0oDUiKisWpKtZHA65fvGeRgmqSvzeQkFfsvu7VmRbQfpHsMtUxzKWdDm1Z4Y9EFR0W3aoPb3cxWZDAzUSvaI4HAR5McemDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JW+kDjAp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JW+kDjAp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2Zhip552016;
	Thu, 21 May 2026 09:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ag2QTg
	UDP6F8pw36rojCGVYbt7pzhih+zrqnh1c3xTg=; b=JW+kDjApgruRYwxV5Buz+D
	hDMG6wYxXkYYGmgodW2cGAUR5JvQ83dMzcslqhwpdABltjmhq8lEIc3rELQNNg2U
	2Genrztf7oEqRtXxJLVv+xxoUEeqKHmqY5nMMXtk1PE0eAuSDvMNALp6Rbhm2rqO
	MYBHyt1bVO153TvGJzO2fXT81rCG6hWVnKzP2X+mqWqg52vJ1KKkZvw8Sp5oQusd
	bMP2ha0JmgTB3bqStbezZDXsGnjiDFSy/jtGlTgg8gfr1OWuJu8Zcy5gDj7tvf6f
	tnj0gnsv1L140rlzPcgH2mXtsEpdnecAC1SfC2UDC1/rtM6lLnZHlp/Y8y1iLYEA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y67gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 09:32:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L9OIA2027053;
	Thu, 21 May 2026 09:32:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqbmt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 09:32:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L9WlZO40567098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 09:32:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DA2420040;
	Thu, 21 May 2026 09:32:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EC5F2004E;
	Thu, 21 May 2026 09:32:45 +0000 (GMT)
Received: from [9.111.82.79] (unknown [9.111.82.79])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 09:32:45 +0000 (GMT)
Message-ID: <942574f6-3959-4ca4-be24-6500b420e422@linux.ibm.com>
Date: Thu, 21 May 2026 11:32:45 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sashiko review email for kvm@vger.kernel.org?
To: Sean Christopherson <seanjc@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@linux.dev>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vitaly Kuznetsov
 <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian
 <kevin.tian@intel.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Eric Auger <eric.auger@redhat.com>,
        Mostafa Saleh <smostafa@google.com>,
        Pranjal Shrivastava <praan@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Matlack <dmatlack@google.com>,
        =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Kiryl Shutsemau <kas@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Roman Gushchin <kfree@google.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <agusSarZr-R_o2xD@google.com>
 <fbb937ae-62e4-4386-86fb-67d9b85c8fdc@linux.ibm.com>
 <agzHO6EXfAe_40F4@google.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <agzHO6EXfAe_40F4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4OSBTYWx0ZWRfXxRIJe94bpSzn
 uDXT1d/Ue90QDHnBSyPI/3Z2s0Yzrj+0/zlmYaNCl7YZ7QTH2zqiDw+bfWWpTBTYfa3qddeVPiI
 9DnlOgbX68hwRGbRvITykc17O9jsuKOkkILImrSTV39QwB/Lbx5H5bngWcSMi3ghbEtQj7gGwIy
 eawNhlXaHuBK81/QpcNx0RdTvxyez12FFDULal4CqkA6Rh6MiEU5v56WWHLZSQenS9bKENxKYpA
 rRKOqsSf3rsdoELx/nC49oXwBGAJrvK/BJB7JPE4DQPIiRvQsWb6sGT1J1etbuMjbbL8Eg1JiQA
 vv7hxe0SouisImTS3U6vO+KE0+gEOyrIxj6nKllKmN/XL22dKwYMtyeOekT78pARD8B4t2JuTKO
 X1Zq88fBUwbcTppWOHObYYtnnmYm9Jr206pi3J9ph9J6ep2hJTmlI4j+Q5BbKalc6Dzb6cWK+oc
 sWtivz5WZVpZoowQccg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0ed144 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=VwQbUJbxAAAA:8
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=NEAV23lmAAAA:8 a=1LRjq_vfZD5iGkovayUA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: iFn_RW7RHiBY5cr1E3cJ19H7PI6bGAG7
X-Proofpoint-GUID: qMr3dIis9bzTenNFlc44zoXgBScuzSFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210089

On 5/19/26 22:25, Sean Christopherson wrote:
> +KVM and LKML, which I stupidly forgot to Cc :-(
> 
> On Tue, May 19, 2026, Janosch Frank wrote:
>> On 5/19/26 02:18, Sean Christopherson wrote:
>>> Hello people with a MAINTAINERS entry that uses kvm@vger.kernel.org as a mailing list!
>>>
>>> How would y'all feel about enabling Sashiko[*] emails for kvm@vger.kernel.org?  For
>>> a variety of reasons, Sashiko currently only logs its reviews to https://sashiko.dev
>>> by default.  If subsystems want to receive on-list mails, they need to opt-in.
>>>
>>> I really, really want to enable email reviews for KVM x86, as Sashiko has found
>>> an almost embarassing number of bugs that (a) would have been painful to debug
>>> had they escaped review and (b) I'm not convinced would have been found by
>>> traditional review.  And for me at least the signal:noise ratio is more than good
>>> enough.  There are still hallucinations and false positives from time to time,
>>> but the good outweighs the bad by quite a bit, it's cathartic to flame AI when
>>> it's wrong, and worst case scenario I can simply ignore Sashiko.
>>>
>>> But, currently Sashiko is only capable of making decisions based on mailing list,
>>> i.e. as things stand, _all_ of kvm@ needs to opt-in.  Before I badger Roman to
>>> add bespoke logic to Sashiko's email flow, e.g. to special case KVM x86 in some
>>> way, I want to see if there's a general consensus in favor (or against) enabling
>>> review emails.
>>>
>>> Thanks!
>>>
>>> [*] https://github.com/sashiko-dev/sashiko
>>
>> Sure,
>    ^
>    |- This
> 
>> as long as there will be no mails from Sashiko or at most one mail per thread.
> 
> is in conflict with the caveats here, as per-patch email is exactly what I am
> proposing (the current state is that Sashiko never sends mails).>
>> I'd appreciate something like "I found problems in this thread, here's the
>> link, go look if you want to".
> 
> While this would be easier than manually searching through the web site, there
> would still be a sizeable barrier between contributors/maintainers and Sashiko
> feedback.  E.g. to click through an out-of-band source, copy+paste the response
> into the original thread, etc.
> 
> What are your concerns with per-patch email?  Hallucinations and noise are
> definitely a potential problem, but IMO that can be handled by per-subsystem
> policy.  E.g. if the signal:noise ratio is particularly poor for a subsystem,
> that subsystem can document/state that responding to, or even reading, Sashiko
> mails is completely optional.
> 
> Beyond that, I'm struggling to understand why folks are opposed to getting mails
> from Sashiko, especially for a list as large as kvm@.  As others pointed out, the
> volume for kvm@ is already high, and it's trivially easy to create a filter for
> mails from sashiko-bot@kernel.org.  I.e. it seems highly unlikely that mail from
> Sashiko will require anyone to significantly rethink and/or rework their workflow,
> whereas the web site approach is very disruptive to email-based review, at least
> for me.

In my mind there's a clear separation between human feedback and 
non-human feedback. So the disruption is something that I prefer. Maybe 
I just haven't yet fully evaluated how much I trust its review in 
contrast to my human coworkers.

That being said, I won't be the one holding this back. I see value in 
this and I'd be happy to test this.
