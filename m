Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607002DC76A
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249297; cv=none; b=WtPUC5A6omOfTHw9gJWOBH+K1yJHMWQJGugVBFCO1he4+mF7KtczR8NQ7oBog2ndcD2yU4WkH0/rrwaKXH1iwb206aUr1VrLso+aaK5wW99ZiOdhoE0pTuL6YQqWR+4vnbUOqkWHyGIrxTefW3hhXVRlzGi2tel4+h5omLJvaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249297; c=relaxed/simple;
	bh=7LtrBUufN12HOdgfUihxOvi1IPdydKftCfUhExQLXvI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=sAKnKLCdtG3+DEguJAD28oUKouP1POdbBJk5lViKdj4MWldQhqkZqXlnQlhREjzPgQenzDl5tIoNCU1KxQZNEFg8CtNZkCuw/CeKwaxWgp84Q1d9a8PdY4h2en63M+XQAH73pIvtV9DaHUkW91xY1VeJdhZH+2AOhStDYw6cspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GGaBCx3B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GGaBCx3B"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C36auI722204;
	Fri, 12 Jun 2026 07:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5PNplx
	zw5Wg95uprdyIqSedFmRJXKOl5v13DzIoJJ1E=; b=GGaBCx3B9gKX13kflhT6DS
	Myo0uf26mUR+u/IrrHqlDNbgld9rh0KmUSL6i12H23XVNoQ5WMXGqwsZwU5ncpVa
	hzzsnR4AVMLPG5nrMDc5upmKwzDLzSVFjO1LPWPfauZrjMXU3pgFkSTCnY/s1T9W
	Qel5ZO6uoKqoKZvnemsKcA9z/t3GdZMYiYOjFbprW9ApUIekW8b3AUMendtuoihC
	qB9LUma6V80L2eo6P9vfeCDiGUg+CyRdPTLUeL9JQJJTp78Yo99feA4xZSWZsPpm
	ebtx/YBjQprCgiSDde8wjQvwcPX7Z/v6mMwdUKZBrYeW972vTe9mTJLUXto7xabg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dfsdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 07:28:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C7JaDO023414;
	Fri, 12 Jun 2026 07:28:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08xsxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 07:28:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65C7S2Om44368346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 07:28:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AF5B20043;
	Fri, 12 Jun 2026 07:28:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDD4A20040;
	Fri, 12 Jun 2026 07:28:01 +0000 (GMT)
Received: from darkmoore (unknown [9.111.35.149])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 07:28:01 +0000 (GMT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 09:22:00 +0200
Message-Id: <DJ6W1L5VXQSI.29PF1MVLB88XE@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] s390x/kvm: Add ASTFLE facility 2 for nested
 virtualization
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, "Halil Pasic" <pasic@linux.ibm.com>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Eric Farman"
 <farman@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Richard
 Henderson" <richard.henderson@linaro.org>,
        "Ilya Leoshkevich"
 <iii@linux.ibm.com>,
        "Thomas Huth" <thuth@redhat.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Hendrik
 Brueckner" <brueckner@linux.ibm.com>, <kvm@vger.kernel.org>,
        "Nina
 Schoetterl-Glausch" <nsg@linux.ibm.com>
To: "Cornelia Huck" <cohuck@redhat.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>,
        <qemu-s390x@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
 <8733zdniy1.fsf@redhat.com>
In-Reply-To: <8733zdniy1.fsf@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2MiBTYWx0ZWRfX06VeWoenzzTY
 Gym3qTAiHsI8MU8ToFUMHNVXVzfABpQCqHc0cb0r1cgyBFQ70nk2XrMomVFdc09pVLM1fYpZELP
 bfgR9YYrJKZGe6pmAY9TVEvfMuzgM8M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2MiBTYWx0ZWRfX0mg6t1NFgaaj
 iadDo3ecOs44o2VjuvTLOFs8EQ8XgTlFUDRi1N+4qmSYdcRT8mVf1glLZFeUG85IUdJXDsnA6eW
 kBaByT9om7grzBl5VER7sBBUodiriBDmNPfawT0V6zyo/qpisuDmAj9yL6KqXIqXDZl1IvhiEAr
 zkPcDIIkiXE8LI9F1aku4f7b37H/tVAS/C6iUWam1VNOtGBurn2G3yRTcNbKVYFyVOKU8locSKt
 TNabJANOP4w7NE0DPmxKDU6/gDhpBSADUW1KsSqdnZqXyYwL1fASaihgfekmAr1TUfc+3PR8cfD
 TBI4PwJ+fvTopn/MYVcdLzwKhFePtx/PhJUg8q432I0ooFjCk8ycSBWgWgYNw8v2iywaO93AV/Z
 GVyELotLWvdhtHsjB4XCaEzZ8b+D5B4tKQvWTslcryxLgoPwulnvpJocB250FBSijB+/awmv9TY
 XKR0ViI42SLvV1+AkLQ==
X-Proofpoint-ORIG-GUID: KJ6vgai-w2ziG9LCAVeOImRPLz8FBnTe
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2bb507 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
 a=GtqPb0kPmu2bT9b1aAkA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KJ6vgai-w2ziG9LCAVeOImRPLz8FBnTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120062

On Wed May 27, 2026 at 2:19 PM CEST, Cornelia Huck wrote:
> On Tue, Mar 24 2026, Christoph Schlameuss <schlameuss@linux.ibm.com> wrot=
e:
>
>> Update the kernel headers to get access to
>> KVM_S390_VM_CPU_FEAT_ASTFLEIE2 and allow passing the feature through to
>> guest on IBM z16 onwards.
>>
>> Cc: qemu-devel@nongnu.org
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Cc: Eric Farman <farman@linux.ibm.com>
>> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
>> To: qemu-s390x@nongnu.org
>> Cc: kvm@vger.kernel.org
>>
>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> ---
>> Changes in v2:
>> - Isolate the linux-header update into its own commit (thanks Thomas)
>> - Correct naming of the feature (thanks Hendrik)
>> - Add S390_FEAT_SIE_ASTFLEIE2 to full_GEN16_GA1 only as it depends on
>>   SIEF2 (thanks Christian)
>>
>> ---
>> Christoph Schlameuss (2):
>>       linux-headers: Update to Linux v7.x with KVM_S390_VM_CPU_FEAT_ASTF=
LEIE2
>>       s390x/kvm: Add ASTFLE facility 2 for nested virtualization
>>
>>  hw/s390x/sclp.c                     | 2 ++
>>  include/hw/s390x/sclp.h             | 4 +++-
>>  linux-headers/asm-s390/kvm.h        | 1 +
>>  target/s390x/cpu_features.c         | 3 +++
>>  target/s390x/cpu_features.h         | 1 +
>>  target/s390x/cpu_features_def.h.inc | 3 +++
>>  target/s390x/cpu_models.c           | 2 ++
>>  target/s390x/gen-features.c         | 1 +
>>  target/s390x/kvm/kvm.c              | 1 +
>>  9 files changed, 17 insertions(+), 1 deletion(-)
>> ---
>> base-commit: fa4b2e31e649ba6fdb3eb2dd43952aad4a3bd675
>> change-id: 20260209-astfleie2-85eec9fd9213
>>
>> Best regards,
>> --=20
>> Christoph Schlameuss <schlameuss@linux.ibm.com>
>
> Looking through old emails: Can we respin with a proper headers update by
> now, or is the kernel change still pending? (Or did I miss an update? :)

The kernel change is still pending. I will respin this as soon as the kerne=
l
part is out.
