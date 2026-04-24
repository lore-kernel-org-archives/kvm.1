Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB91D5CC9
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016593; cv=none; b=dHR2rmRwJj3JcmhQTbu+mdBCJxPVBDR+87b/o0qoj3ntMrQiPO7SFCOrLIugWhmmSwDdYgrvU0P9WLXQcXKuwSJoLVZG52Z9FXJzDdkvxISp3vXpbc4TqkCH92CuWsV0vNJCQMdGzs2QDV3HrB1bMnt5th29SGEoTaFvcHaZw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016593; c=relaxed/simple;
	bh=7ceVZYyH9FttHXz/qxU55nmhaCV4nemOGfY2BsVDWPE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=YP0dOAoksIXPnQtDA+JLSX0DQeBjD926lsK9sATMaQEAb4LJ8UYIr6RK5u98U/4p1ndmks4QXCTE7cJigDS+MlWwg9yszC1od3arOtJPJESoeS2lKrJ9abgy2tzeYZc24wuFRihtb9aB5EWSCTeQk5r54uv7mnUZOnACkMYnSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KVc9mmX9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KVc9mmX9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NMh0Qw2802698;
	Fri, 24 Apr 2026 07:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G9Mb+o
	H/TdiLngQ/tryBdgR+hEnvO8OyNXkZIoRCaC4=; b=KVc9mmX9KdbzVMLUMPTrZ9
	RJx6WIPXL+t6C4IDCIMCHtebBLi9QotmNAJzRq9vdQ3uZsW8H2ea1qa58rvKENxI
	1j0ciNOMvbkXhhqycy1UutQ0Hu/sTppm5C5sTX/my1eOZqVzySPYCz77A/QBLIoZ
	5hNvtF+WrLg2soHhz1OQbCDINd6/sNySnNA4NVzofQM2JVCT3ywImC7fL76jyM5v
	WE/PQihR3BotxAj/SlBsA6AgVAr6PmSqud7mWsA5CEff1qgcRlW92CXzulPj5msk
	IaiHaZekupqQegheC7vWlWCTY3gx2lp7S6D9VZARk0JZcMh14RG17o1kSKr6c6Ww
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2cpqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 07:42:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O7ZaAK019026;
	Fri, 24 Apr 2026 07:42:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky9wwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 07:42:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63O7gqtQ31326516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 07:42:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E18852004D;
	Fri, 24 Apr 2026 07:42:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE64A2004B;
	Fri, 24 Apr 2026 07:42:51 +0000 (GMT)
Received: from darkmoore (unknown [9.87.142.223])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 07:42:51 +0000 (GMT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 09:42:19 +0200
Message-Id: <DI17SGGCTERY.21IR5YY0JNHFK@linux.ibm.com>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Paolo Bonzini"
 <pbonzini@redhat.com>,
        "Andrew Jones" <andrew.jones@linux.dev>,
        "Nicholas
 Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>,
        <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH 0/3] scripts: Configure and update tools
 to allow basic b4 usage
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
 <16bf7ab2-c4ad-4982-9170-cd06015c39f9@redhat.com>
In-Reply-To: <16bf7ab2-c4ad-4982-9170-cd06015c39f9@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LThAaD0DZBCe5tFCbA34jTdkma7wCTmx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA2NiBTYWx0ZWRfX/NMD+Y69ygEj
 6VOFwpbbEc5cwaMVSh7Pkg65BWCRtzHLO9GoOHYh1QXX7klz6pywKFswRhqV263nWfIfSXBDeaD
 Iqk8qJo+ARPeS0cryM/Xy3DNrbyQ2z0JiROoAXsFPugqmfv+nLeYlJbUEyp/9oV02kfj/cahR4c
 /hcBsrskliaWuJd/xxeHS+i5MeoF8VHDjuFuh6EDluNVsiPSfntigivQkR0hLgKUjWScDfnypb+
 f7G8cKmeBwV2rNDxAxRyG8/zuRgD0WxVsbOAG7GbaOIfA2zmjA8eDZRoFX+LH0Zbhdu4tJCzG60
 4y/2p/ucnLyzf/kBFdT6ACEF0JLEWMlFvHBPJe6CnUbLqlFIN98xgbaEhkwdg8g61M5idcSKKCP
 wDJR7s+PC1Uto/GMXQ6kW1v3vXkJBO0oEKM1KzklocQuyMFxzHa47pNNlKEkA/86gO8/juClwjw
 qHbheyk3lgpf9KVkG2Q==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69eb1f00 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=QQikbYhoRg4xD7lCZdUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uPLniu73jIHaB9ydQJGVST9iQgd9zuDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240066

On Fri Apr 24, 2026 at 9:19 AM CEST, Thomas Huth wrote:
> On 23/04/2026 16.16, Christoph Schlameuss wrote:
>> Provide some basic configuration for checkpatch.pl so that use on the
>> command line is less confusing and actually useful.
>> Checking new patches with i.e. 'b4 prep --check' will now not just give =
you
>> dummy errors.
>>=20
>> Modify get_maintainer.pl to work when called from 'b4 prep --auto-to-cc'=
.
>>=20
>> ---
>> The second patch also copies the current codespell config from the kerne=
l.
>> I think this would be nice to have but I would also understand if nobody
>> wants to add that dead weight here. In that case I would also agree drop
>> that second patch.
>
> IMHO the dictionary that comes along with the codespell utility should=20
> already be good enough to cover most of these typos, so I'm inclined to=
=20
> rather say "no" to the second patch. Instead, maybe you could introduce a=
=20
> k-u-t specific spelling.txt to get rid of the warning message, with some =
few=20
> entries like:
>
> kmv||kvm
> RDSMR||RDMSR
> WRSMR||WRMSR
>
> ?
>
> (the latter two entries were fixed by commit 784dd85d25d484)
>
> WDYT?
>
>   Thomas

Fine with that. I will have a look around if there are some other things li=
ke
that we can add.

