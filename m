Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E126ED3E
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016233; cv=none; b=uG5b1z8XeKw4e70xkSg/oDCDlESvyVdkRFKYhZtNQ8cguC78/uw+VgmYwBOHlGEJ0EI9RkEXWLKOyxka4dJ7OznuXiOkOy4rFSMDejLfekH/6L/O/RdSE6i91tClhrfdz1l8Rs8Wxq95HGHsE290xunjzSVIBs1i43IdC0uwXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016233; c=relaxed/simple;
	bh=XcfdmQ+sofV7VgZr1Fk1s/UZPDM0QJrRSOaVW+bYFEU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=YmWXSifd87ZqvPEqO5zKO0mYro9TjStDdhmkC6QuYLWCkGUh23VisCN5vj5VhfQaOIJ/EBJ+UOLOpvMVIxtrDz74OL9LFh7aE5A7YZCwzp253ALoDnxtZmW5YoZS5zuBjOkltUs08ml0NQ59TbnijyoZGLlQAB1T/V/epOWMAE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sc8kxpXy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sc8kxpXy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NHQ5b13291897;
	Fri, 24 Apr 2026 07:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3nYm/C
	ji9AqA/uLjRt9xY9E9i4dn7sg14FYW+Fprmps=; b=Sc8kxpXyNDGGsWUB4Y8V5u
	JdUQ/D0NHlRV8SJohY2ym9xawvdjCvPg4C54eEWA9K/x65gBmRo9a4ideqR4BOBL
	4+NgI4DY3CSYQZLPFYR+iwR1OmcldDPa9qSuzrGRIRT+m2USaLxhqWjb3hp0RNh7
	TUq0k5ZHAoK24BMQXoNJjYjGjRuduMtMuZtvNXYHVTm6bnaGnDplYHboCS+Jo9UJ
	aQVS2dyrOFSxosPmpTj9R9uuUmEIg4ye6ycwwTA4gheFn2f3I/iwdPccklCQ4cq1
	6dWSoUJZ1QcyYUeXbmXLxOAylnu4efoX95CRNafd6zbkmUQSPqb786Hygjuo6hWQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrm2h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 07:36:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O7ZT7c031684;
	Fri, 24 Apr 2026 07:36:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyhw4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 07:36:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63O7aswP55247254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 07:36:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1858C2004B;
	Fri, 24 Apr 2026 07:36:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA85420043;
	Fri, 24 Apr 2026 07:36:53 +0000 (GMT)
Received: from darkmoore (unknown [9.87.142.223])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 07:36:53 +0000 (GMT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 09:36:47 +0200
Message-Id: <DI17O7XO24UY.1UTBAQJVIGSCE@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
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
Subject: Re: [kvm-unit-tests PATCH 1/3] scripts/checkpatch.pl: Add empty
 codespell and const_structs configs
X-Mailer: aerc 0.21.0
References: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
 <20260423-b4-cmdline-v1-1-f72ad0020d42@linux.ibm.com>
 <87e4fcbf-92bd-4f74-9db9-369e4ba8bca8@redhat.com>
In-Reply-To: <87e4fcbf-92bd-4f74-9db9-369e4ba8bca8@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ejR1lyrRjg1uC5xj-eH8KlSdQJfRS2Kq
X-Proofpoint-ORIG-GUID: LsLkm3GXNv4tx08ZV2tzu8DjILL7bCM7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA2NiBTYWx0ZWRfX4zp8kUDR5n5A
 3mykb06qHie7IJSBpvv1TZ278bMxjFJZCKDG3Ke2/hrf1eTduYSa9V20KgleRLODrC+8B2g5Qoe
 H5F7oXuX+vUjniy0xeIZBa5jjwf6X+5iETiGsBubGIzsq0eiRG9Dcfu+Gs3SIDwONis8e5PjRTl
 KQ4zmPvB2UDRD6fRpL+Okg4rlfK+oIpLLPQGZvlHNcUzPjj8YJNICZHIVCr4ck0HXDBmA0hqJD+
 YW289DLCwLqK2EK9gEXs5zWUsKK9RO1zIctPC+EFkRSurcUNzkbGLe5eNDm04mIwvVVFcvAI28n
 cx0iaSn4XG+oWr5QnAbY7qCFItx9XMurbmQ/ME6gZ1KUEs5iY+Z7lDXjEexmmuyxfBHlOMuM1IX
 j1uASKsNGTbv1EoY7NCOVR6jsQp5YaBFD/CMBcw5+bU03QOPy0zuPcZCfmcQVvZ1b4UbIPvEn2C
 PHu5Vslu7SWsKoH6ubA==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69eb1d9b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=fjU1KvmuhNk0jL3U-k4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240066

On Fri Apr 24, 2026 at 9:00 AM CEST, Thomas Huth wrote:
> On 23/04/2026 16.16, Christoph Schlameuss wrote:
>> Without these files each patch is flagged with these errors providing no
>> value and swamping actually found warnings and errors:
>>=20
>> =E2=97=8F xxxxxxxxxxxx: commit title
>>    =E2=97=8F checkpatch.pl: No typos will be found - file '.../kvm-unit-=
tests/scripts/spelling.txt': No such file or directory
>>    =E2=97=8F checkpatch.pl: No structs that should be const will be foun=
d - file '.../kvm-unit-tests/scripts/const_structs.checkpatch': No such fil=
e or directory
>
> Very weird, we've got the checkpatch.pl script in the tree since a while,=
=20
> but I cannot remember having seen these warnings in the past. However, I=
=20
> just tried to run checkpatch.pl with a patch, and I now get them, too ...
>

Maybe you did have a git setting modifying the arguments? IMO this just sho=
uld
at least somewhat work OOTB.

>> diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.ch=
eckpatch
>> new file mode 100644
>> index 000000000000..e69de29bb2d1
>
> Maybe add "virtio_config_ops" to the file so that it does not look so emp=
ty?
>
> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

I agree that it does look strange completely empty. Will add virtio_config_=
ops.

Thanks
