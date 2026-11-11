Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391793;
	b=5rzFPi2MO48/s2SBRYdD7Qw2aclBLx8CNC6XNH8xvPBERywRAezPI0LG2w6SAYUcOq61
	 O4uSwJdRLmLiWNd/2yIkQqBWrx7O/Xxg1hb3LNQX+otzKiLYroEZVS4hbKTfMfRlFqeg9
	 yrKzWco1MASM6hvuceO5DbcuALugWC9iReFTSn1hOPnjAzlUUQZj5SK0ePqqPE2elKX9N
	 UV4vnwg3yQnT6hSzN95+k906gkaGiK5ozlWRtNZ7ElG8oDzaiQ99oeMtzXd8/g93AkWAU
	 h4eksLXaDerIhjziKdg2GE/7GKl3fEKmnaO3bhREvVV9EDGBxISaffYVT04GAOICSzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391793;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jEhEi9CeTKpVUmtThXx0AkKDXprkxUCaOiZAqez0tQw=;
	b=UUo19wysm3rZzzL5+2RYziFxkhqIpfPL5G3E64fLOk5KG/tKrerh4c5ynPTcjpfWgFN/
	 6BjeBVndcLixq2F8n/TfFQu5Wq2kmJCe2/zI3WagyItkcRmwX2DlgoUNSNjGy0k973kOe
	 tfq08vgHywr91RONY40M50S0B1G4zprUSkuCLdsWLbwmaSDXsxqorP5Oeo+WvRULnpNVO
	 vqVomkUM7UBYtckO6ET+pXyPaF830mwxLemtKpoC1MeYpFwmy3k4PO4KGxesWHWhMXsxU
	 Fs8UTP6G7LU8fkZ0mAHVofx82/aBsUdoZ/DYQvyWVl5uPOsPeFvPe6nYiDzR6mnLrDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LQz86sXB;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA9606A327
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 10:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0BA9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LQz86sXB
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iOUu285435;
	Wed, 11 Nov 2026 10:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jEhEi9CeTKpVUmtThXx0AkKDXprkxU
	CaOiZAqez0tQw=; b=LQz86sXB3GnIarAyMjAb8YgUzSwGW0MZ1BrNpoNwec7PAD
	VxF7TR4hH4sC/9FYtwS4f4VwQRM3O4YOSf1EI5NVdPlDAZ6jU8eHXmex8VzaNaRg
	cJ/J+5wJdPRJqMsv0LU5TxQqx6Ks4E3dpPKnvGrqhtKmCr8Prcai908Y5OfPJEoo
	IzDIE7GXQNMAHE3QPcM6fQxTlkLRy94NQnshtfiKUsThfSyJvOMts0B0uzfM5rhT
	ZIFKJ6qKQuixvsUp8Dn6fgNK2F8HrLybHDhOGOJiurewfc9Ir5B4hYR8mf6aBtrG
	+oZ1ZIYEGtQwm7w9hh72dP3OwTEcMkbgpAXpe/jQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq71kg3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 10:09:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB77ocY3005842;
	Wed, 11 Nov 2026 10:09:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0rget-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 10:09:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABA9fNq47645102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 10:09:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04F6220049;
	Wed, 11 Nov 2026 10:09:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9260420040;
	Wed, 11 Nov 2026 10:09:39 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Nov 2026 10:09:39 +0000 (GMT)
Date: Wed, 11 Nov 2026 15:48:07 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: [PATCH] powerpc: Link with -z notext
Message-ID: <20261111145459.6b15a2c5-eb-amachhiw@linux.ibm.com>
Mail-Followup-To: Thomas Huth <thuth@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
 <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXwaphTl4YCSnO
 lIVRmRYdxR+7sQ48iSfhNJQAaAseUqxKaByAP/rZd9G3svYhiCgTPpd8LK/ygLluhrSmXcFZImx
 UZklAN71fn3d60x7vP23XrfCsZxn5Xo=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af43eea cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=GCA8b2iqAg_wZIL1NzYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1WC-CqiRryi4i_MNQ-p0ehpCRyHYwX-H
X-Proofpoint-GUID: 1WC-CqiRryi4i_MNQ-p0ehpCRyHYwX-H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX6xvHSqKGOtB1
 XbQ2pYsu6kNxSYOCdI/lNGxonQHL0edTglBmnoFf7jO5JlKRXNrx1/q5VoJVKGJL3OOUhRD8ybv
 YrPMXG3DL4tSaruyvyhh52/oBr8qeJ9+hmt8QwYlNYg1aPxUASsTYF2B9tvT5NlzoQN4/HCwZLv
 NfLsDUoM1GtWUD4QCYLUnkmECJ5KEi7Q3n+WbDhRX9BdSVG/keD/3FyZI49ab5Wa1KYjnkFqKiI
 6aAqGvZrqpLocAoGDOd7IP6k3LZh8GAGTEIfyiRz7HmUuMQl/z6PRszqeY90avOL4sw+WVQd8iN
 r4dsgrjZHlXMxXnHns9srALbr0sN7PZIVO3f7mKmvFNEGY/llKP0vbFOLak7lFYsG+ezrAY7X/f
 eKJAT8Ba58rlW00PMARlW1HviCjW+ogU+1cS8Uzr3S/oq3Ua/AVW6YH8XLOF4q83igyZn5KPnC3
 bkDftLy55drzt3qyKsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110038

Hi Thomas,

On 2026/11/11 08:54 AM, Thomas Huth wrote:
> Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
> > Building the powerpc tests with GNU ld 2.46.1 fails when linking the
> > test binaries:
> > 
> >    /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>  Hi!
> 
> This does not happen for me (using GNU ld version 2.46.1-1.fc44 from Fedora
> 44) ... which compiler and distro are you using?

Thanks for checking!

I'm also using the same GNU ld version on Fedora 44 PPC64LE host (more details
are below).  Are you cross compiling on an x86 host by any chance where you are
not seeing this problem?

Assuming that you are, the difference is due to the default linker configuration
between native and cross-compilation packages on Fedora:

On native Fedora 44 ppc64le:
----------------------------
  $ ld --help | grep -E '\-z (no)?text'
    -z text                     Treat DT_TEXTREL in output as error (default)
    -z notext                   Don't treat DT_TEXTREL in output as error
    -z textoff                  Don't treat DT_TEXTREL in output as error

On Fedora x86_64 cross-linker (powerpc64le-linux-gnu-ld):
---------------------------------------------------------
  $ powerpc64le-linux-gnu-ld --help | grep -E '\-z (no)?text'
    -z text                     Treat DT_TEXTREL in output as error
    -z notext                   Don't treat DT_TEXTREL in output as error (default)
    -z textoff                  Don't treat DT_TEXTREL in output as error (default)

Because the cross-linker defaults to `-z notext`, cross-compiling on x86_64
succeeds silently, whereas native builds fail:

  /usr/bin/ld.bfd: error: read-only segment has dynamic relocations

Toolchain & host details (ppc64le native):
------------------------------------------
$ uname -a
Linux fedora 7.3.3-200.fc44.ppc64le #1 SMP PREEMPT_DYNAMIC Fri Nov  6 20:22:11 UTC 2026 ppc64le GNU/Linux

$ ld --version
GNU ld version 2.46.1-1.fc44

Thanks,
Amit
