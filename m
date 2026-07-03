Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A193446AF
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059515; cv=none; b=iD6lAX62dbJZoxG2wasHJB00E4m5M883QDeiD3ig2DRYug5naYAsH7ALdjgStJrs92Ms4hWQGYwXksKvBA1aRejUxaFp5QP7P8wjafaqj2OkDj+mYp1tf5Z4dC3mu1cKqwcVJSoyteOJFEVulo1+HL2VWc6XiQX6bjY6YE4EbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059515; c=relaxed/simple;
	bh=rHQuEG952OPTDWlrGCX9ijXTEVgoCzjDGN7IpKBHsPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f6yD5scV0xWsoUoM5y1TrMPQGLJ45i2rOxwTHwF8m8bDhdnb7Rbh7bym0OOtn2ZyvhlXXqzCFcNMgvFJ0kO+23oUVUOCibAXvRD1K3+HxMsuxLnBRtdqtUl/kRSmgHNQFRHhiFgEG0lsC65ogrMwQbGdidEQZLvL4fUpqitsLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h6y7AM2Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h6y7AM2Q"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IBN11930356;
	Fri, 3 Jul 2026 06:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rHQuEG
	952OPTDWlrGCX9ijXTEVgoCzjDGN7IpKBHsPM=; b=h6y7AM2Qsj2Z68ESUAkVyk
	BBw3rJNRsCPv7j7Z+qXt946AC+DTi6TZX93d/ixrtYW42d6Nz0kt6v25mhLuAZp8
	vmyF9btptLgIGdxtqS1QGwWx+PB9fvV6TYBpH4rPbrnyErdBwwMIiAa4AofDU5Yd
	24YpfSH/vXkgkb7YpzVjA6s68azfT6Z+1Lq5v7Wrmq9jq0NAxG3PV4FG52ZvtigP
	alc364ybPvo7/cQHbQmbQy8c9LnOASGbKpxnkZCGsczDofhlTmRnkBeSExyXVmUx
	/vCZq6fKCf9a6ETzHJcVNOri88eNE+Wd6PoS3DlL6dlNKtP24qOdQ7jH+hI09D5w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pedt9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:18:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663650LN029102;
	Fri, 3 Jul 2026 06:18:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukfhaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:18:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6636I2qw12058900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 06:18:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C5FA20043;
	Fri,  3 Jul 2026 06:18:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF58120040;
	Fri,  3 Jul 2026 06:17:56 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.24.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 06:17:56 +0000 (GMT)
Message-ID: <fc3de9cbc76a682f521fe0d88a7b2adcbf8f2b9a.camel@linux.ibm.com>
Subject: Re: [PATCH v4 5/8] ppc/pnv: Replace Power8E with Power11 for 'none'
 machine test
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
        Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@oss.qualcomm.com>,
        "Daniel P ."
 =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>,
        Sourabh Jain
 <sourabhjain@linux.ibm.com>,
        Hari Bathini	 <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn	 <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier	 <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum
 N <misanjum@linux.ibm.com>,
        Anushree Mathur
 <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani
 <gautam@linux.ibm.com>,
        Chinmay Rath	 <rathc@linux.ibm.com>,
        BALATON Zoltan
 <balaton@eik.bme.hu>,
        Nikhil Kumar Singh	 <nikhilks@linux.ibm.com>
Date: Fri, 03 Jul 2026 11:47:30 +0530
In-Reply-To: <20260630210355.789109-6-adityag@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
	 <20260630210355.789109-6-adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: DgoUh58aUmG03hDnkcHhbLaD8SJ_sERJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX2w2LyWXR0YTX
 IvsJd9yLF0dOD8NBOPX5oZSFXvhfrPEkvB/DOeUXEfFmreVur742cHMv6nwCVExFenN53xpuQBC
 VqVg5r5cLU3OiNWAW/NljLiXDn9lcpc=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a475422 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=syXIhHOfpIr89EnvoDAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX//RlVKO2J3h9
 D7lVi6fQELdnGPbExh/6E+hP8Z+zS1rSwnFZkLZ2xFfnHVVX1Foyu3TY7Bkh36EV/ujueiEylTR
 5G46uTEqCxy6E4oXOLWjNB9/HEUdLp6FH2AAzJ9u7XMXy3AeshqC30Hzi0YKZX6+A2E/VAFd3kp
 oBl6BGNYykKfVOJMuL+biit/NE4PdJwtIi9nVdGpg1+t+k3VfcgzrNFSzH0obgi+YWes5ETQl4r
 JCR+FW6IhpHR/0UsJG77uyQmv3ZSQCrpDtAqtf2Uf8X2wCNgKGDPsWETxp7u3sCVuw36rou/PBA
 cubCjJHUgt3EgCLHEuw05PBN/+rWJ5nPoXvXX4f8ITu4uI2XwaMF8bSff8WEiA/mgrlaVve0nu5
 I6lhiZd2M+32l4nQUDcIFwglp5abtSqNuyQzkavK07sE4saWDRtt5k9Hny5nWCDhIGRRB1MksN8
 MIk3TH9rx2xVAzHrrVA==
X-Proofpoint-ORIG-GUID: jA_-Ib-dsHA4ezN2jel_3MpbTzCX6L3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030058

On Wed, 2026-07-01 at 02:33 +0530, Aditya Gupta wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
>=20
> As Power8E chip is removed in future commits, remove the use of
> Power8E
> chip for use with the none machine test, and replace with Power11 for
> ppc64 test coverage for the test
>=20
> Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
> =C2=A0tests/qtest/machine-none-test.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)

LGTM.

Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>

~Shivang.
