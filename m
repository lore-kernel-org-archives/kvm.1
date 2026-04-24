Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4F1D5CC9
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016553; cv=none; b=TzrlufMz5x/iD4UzJK51j8GxOuz6zssZ4wIxaBRyLz9kknucetqZP3eSn1ovnSapw4A9lLLme/R7DveLw52w1DIDvAzfWYK5eVg0S6xN1UfuvnephEMApX4zMt/Do7ozAiQwhKEwUuXGWkzTqaJF58L2B0LsGlJ8XHFjjeKdTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016553; c=relaxed/simple;
	bh=yUe6Yw22z7e1ofC1YGPSEOnkyEjE0QHXkzWkIsMUJdM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:Cc:
	 References:In-Reply-To; b=YDFq9wytIyRwiy1m4UM51I+6/JlqWc3ZI7OKV/RKOKuf0D/D2iPzCr+J9SPK19lwa4XM/axp9GWMyH97oTGJNsKHl9lUjndS64hGWpasDCugqJMqPlKgZFL2SZVYUvA3oPh+k78vIT9SDIUfcw75c0XCKB7VL3Sx/W4uSR4EZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tGWvB9Zn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tGWvB9Zn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NIJKBB3292261;
	Fri, 24 Apr 2026 07:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mf4A6x
	iU88uRcuWxkaxHJmngNwOaKJVkZEfyXCn12KA=; b=tGWvB9Zn3ACm/X0g+cgWPM
	Vyl019QtIp1kt9DS1sAcJqSMiU64q4eUVTeV+INCzdxeBBrRdjtd6F0KhexEwaXB
	ZKwcAGgKYd3kjr6lyQP47OLjjgX0DjctCEKsif1itpHT2m1PSW0Ty2OAZwtTkjkQ
	iR9j2JATH7+TJnpnNHL5288Z+AvwP51UzNBtdtdTRj9hYp5bfcZJVPWUouEJdz/r
	Pi+VogsI2DLHpceQzpA9UiMkcIF1LdfQ4AqdLMaQoCD/B6HqjJ8o22um/uIwKfef
	J7FW90YZ9Fyj4trjt339yvfIZDp8qe9jl1dIP/oGMBk5yYB3W/XRduCG9LaDdA8w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrm32j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 07:41:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O7Za2h019031;
	Fri, 24 Apr 2026 07:41:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky9wur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 07:41:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63O7ftWo45809920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 07:41:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFE3F2004E;
	Fri, 24 Apr 2026 07:41:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFE4B20043;
	Fri, 24 Apr 2026 07:41:54 +0000 (GMT)
Received: from darkmoore (unknown [9.87.142.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 07:41:54 +0000 (GMT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 09:41:17 +0200
Message-Id: <DI17RO3YOC9R.1TACO4RM2RLT8@linux.ibm.com>
To: "Thomas Huth" <thuth@redhat.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>,
        <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH 3/3] scripts/get_maintainer.pl: Ignore
 --nogit-chief-penguins option
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Paolo Bonzini"
 <pbonzini@redhat.com>,
        "Andrew Jones" <andrew.jones@linux.dev>,
        "Nicholas
 Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
 <20260423-b4-cmdline-v1-3-f72ad0020d42@linux.ibm.com>
 <6761d631-a714-420c-9c2f-258aec664d17@redhat.com>
In-Reply-To: <6761d631-a714-420c-9c2f-258aec664d17@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 2nx3Zsx9HbDNaOIMea4oP9MoN6DEjN7B
X-Proofpoint-ORIG-GUID: EDw1Ok3I1W-BjDAlh7rPQzvphLo4D5sS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA2NiBTYWx0ZWRfX7JFuByWkO+bo
 fxpbXQyiYsLiGh1Uep17cfWt5raHtgaKDsD+ZnKpD4UslJi+N3uNFa2JcOTVoE/CpPoFjm6P7+W
 FHbC3kMJU2ewS1Ue0t5nQC5/uFOtMIH8xF/i0Ii/IIsVMrZXRh0ExGJKsFk3PqjolEOji+pYkFN
 BTuO3l0exC3K3bA3r+aDpUeYAA0yRJ9/ZTBUJ0wwvILzrO9aRN68D1atOh9EvuohMHsGLtjQHqh
 BQd+M/AwLhZI7gANeoH63EnQWiWqZ1LJIJXLoTOXvzZ/AVX+tOMfB/ifjyBOgqnyUliRA4mE8xP
 gUgNnwnzRR6OoakTssgiq9hASWxnSVA4G8Qg81yxU/+6OllJ08EzeVIgvBHjKzaHM5OM/41JRHo
 a+RX1AcismJLU6Xx89371/cqaT36us25gulij2bVD0MiiaJTEiH6HMf/C31Z/UucKXiJ+i31EnH
 9pKKSfjejA/hsXZ0RCg==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69eb1ec7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=E2ZC3_dGiowAEw5H33oA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240066

On Fri Apr 24, 2026 at 9:31 AM CEST, Thomas Huth wrote:
> On 23/04/2026 16.16, Christoph Schlameuss wrote:
>> b4 by default calls the get_maintainer.pl script with the
>> '--nogit-chief-penguins' option letting the 'b4 prep --auto-to-cc' fail.
>>=20
>> Adding parsing of that option without any related functionality to allow
>> simple usage of b4 in the development workflow.
>>=20
>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>>=20
>> ---
>>=20
>> Sorry, I am not too versed with perl, so if there are better ways to fix
>> this please comment.
>> ---
>>   scripts/get_maintainer.pl | 2 ++
>>   1 file changed, 2 insertions(+)
>>=20
>> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
>> index 117b69145f0e..9b99f6218467 100755
>> --- a/scripts/get_maintainer.pl
>> +++ b/scripts/get_maintainer.pl
>> @@ -31,6 +31,7 @@ my $email_fixes =3D 1;
>>   my $email_list =3D 1;
>>   my $email_moderated_list =3D 1;
>>   my $email_subscriber_list =3D 0;
>> +my $email_git_chief_penguins =3D 0;
>
> The variable is called email_git_penguin_chiefs in the kernel version of=
=20
> this script ... Could you please use that here, too, so we stay at least =
a=20
> little bit in sync with the kernel script?
>
>   Thanks,
>    Thomas
>
>

Oh wow, good eye. That was my intend to have it the same as in the kernel
version. But obviously I can mess that up. Will fix. Thx.

>>   my $email_git =3D 0;
>>   my $email_git_all_signature_types =3D 0;
>>   my $email_git_blame =3D 0;
>> @@ -228,6 +229,7 @@ if (!GetOptions(
>>   		'git-blame!' =3D> \$email_git_blame,
>>   		'git-blame-signatures!' =3D> \$email_git_blame_signatures,
>>   		'git-fallback!' =3D> \$email_git_fallback,
>> +		'git-chief-penguins!' =3D> \$email_git_chief_penguins,
>>   		'git-min-signatures=3Di' =3D> \$email_git_min_signatures,
>>   		'git-max-maintainers=3Di' =3D> \$email_git_max_maintainers,
>>   		'git-min-percent=3Di' =3D> \$email_git_min_percent,
>>=20

