Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78603822AE
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846037; cv=none; b=BKqdIt9N+iBgRuQiGH1IjSTr+wYDuu2pHjS3MDw69DZjbpwyIU06YxLTuWNgpoQXh4phD6DC+woBggMSkfp/vKA9hCSbgHnBpTSSAA3MS2voJzvzwDsDP7r4roKMkk1QsCxc2XQMrnnfbia09kiozKAAgk/MN3j9bjqpSOfcBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846037; c=relaxed/simple;
	bh=sejmIqPMXnv+0ZyiikjnKODpWk3WcEmhPm49cB8zKPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxcAlExo0/ydrA0NLWBU3Xo7YJHTA+kginOrUtqzVvamcRhiGLChdZJjN0iLPhSsFCl2IaGrogGGH/PuAd/4cHMPPjTHKZr+xCZdjYJOO+Lv/nZwfzqFRl/qMIWOrgsoxW+xchJN5J4lGc5ywmc6hd1lh8PBqUneBWfGNah+Q0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AZjEU9t7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AZjEU9t7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIK152428613;
	Tue, 30 Jun 2026 19:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ElTZQC3ltpWU8XHXG0tTGEayNitJcZ
	fvL+dMd8vptQk=; b=AZjEU9t7x9lweDtVI9S3zDBWbyasYQ+DucxzzJbZOvCBuH
	QN+xN+uHF+T875ibmEhvxxzEy+G4n7o7njVmZMgqSe001NWIEGhpeF+lH309QcLW
	CuiOrnlVeLsJYBinodG0C7ZYlRSVAXZiqTj/DX2QGPgr6kUcDm+bVYZ89PyA17kO
	PSL9FNUmnnU5h8fXKTgdP3DS6q9TQxSQUKXyovRaugh05lpKSuU3RGXCV0Z0FA1Z
	DLMj7WUd1CxkkkPhArip2SWyQWTiDpY4sVTCFtE6FJ+Cbi86fJo2AC3aReX7QiTR
	ukfmhjDAwFBpyjBnMbcFSbhxpzP8lqLABX5gnHEA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg0ktt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 19:00:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UInb7P011224;
	Tue, 30 Jun 2026 19:00:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w3wee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 19:00:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UJ085661604280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 19:00:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 849192004F;
	Tue, 30 Jun 2026 19:00:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C8FA20040;
	Tue, 30 Jun 2026 19:00:01 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.22.35])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Jun 2026 19:00:01 +0000 (GMT)
Date: Wed, 1 Jul 2026 00:29:58 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
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
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
Message-ID: <akQRrF4jFTUTPxSz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
 <2870a679-dc81-45d1-a686-c1b0aaee98f2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2870a679-dc81-45d1-a686-c1b0aaee98f2@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a44123e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=mwgEtBXlT-Sc2TMNPJgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MSBTYWx0ZWRfXyCYKn3UpIR+k
 wQpCtjzQ83Op838D6gqt5bDtJSWPMf5FVPYcw4ps3J6P7eQQ8OOq/2W2IdlmT9vAMio0bgTMo56
 llHsh29KKGo3WWh0AMJZybCkUvH8gPc=
X-Proofpoint-GUID: eiGriTlqa3wDTInjW5TI8xwbsY1D1_ja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MSBTYWx0ZWRfX0Pt9DA8xK2dh
 wExkxZK4LikVZk0BrweVJDIrPGku5G1H6nZdBgBiOmA35WhWG2Boi0fWc/0CNAWr6ArwcgXvwcf
 ycYPQPywSeqO8wxgq9cNceWA2DgSO/O/Mr9Unz/GZVpAd1oaMqK2v2IfBuMjILgapEI8/PIAeUD
 BW65XGnjDrEmdWSDCNQBGq8C41qWh61qtbv3pQbEEEWwsu5KivDbxoRSFrVpJq7GSskpyfWjnWM
 QXhpe4QXjXqBOr2SwUzq5XNsQhwgZRnH+BwXVyPWnhcgIeaT4aHags6Jd8pz8xeNkS3Zl9FTlXb
 ssnevMLISQnwi6EI1ibo24xAM6u1gRhUByeQyuK3pqpUY6CL9gwbuHFHWNcFfjP7QZdxQbb7Uyz
 5u9mM+2Q0zBjrnvQ8Js5MP1lx1wsn1Ry01TeuQYFYOxXtFvB2UgZhkNT5LPJ1O5vLQmXX6I0YAb
 Ly9df9I94hrkXNZEa7w==
X-Proofpoint-ORIG-GUID: MvG9Ho1s-CiVUgFPwc0ESMWww5axuaXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300181

On 26/06/30 10:08AM, Nikhil Kumar Singh wrote:
> Hi Aditya,
> 
> One comment below regarding test coverage.
> 
> On 23/06/26 19:49, Aditya Gupta wrote:
> > @@ -548,7 +548,7 @@ static void test_xive(void)
> >   {
> >       QTestState *qts;
> > -    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
> > +    qts = qtest_initf("-M powernv11 -smp %d,cores=1,threads=%d -nographic "
> >                         "-nodefaults -serial mon:stdio -S "
> >                         "-d guest_errors -trace '*xive*'",
> >                         SMT, SMT);
> By replacing the hardcoded machine type here instead of testing both,
> QEMU will no longer exercise the XIVE2 path on Power10.
> 
> If a future change breaks the Power10 machine initialization while
> Power11 continues to work, this test would still pass.
> 
> Would it make sense to run this test for both `powernv10` and
> `powernv11`, similar to how the SPI qtest iterates over the supported
> machines?

Since power11's interrupt controller is the same as power10, power10's
xive breakage should break power11 too.
But I get it, safer to have both, will do it in v4.

Thanks,
- Aditya G

> 
> Thanks,
> Nikhil
