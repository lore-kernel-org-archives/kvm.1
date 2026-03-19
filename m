Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6A2C3251
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934475; cv=none; b=t665VxGxIi/aTAM+GCirCy25YP7go9lUMA+8/BCXLGK5l06A/HRRlnJCGVvMspuhaPi9DDEv5LebwLIMazKmhsKhc5dxlMJ2mZraodPgHrH41ZDYSS8laI5od2Fq0cb1W9laOAGU5LGLk6U6O40QKmgc9AtpgI5UGhnlOJrpEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934475; c=relaxed/simple;
	bh=T9yoaW0ky9iK5m3sVlExTTkxZeT9lJKIpx8fZw+OucQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rpod+7VEEspky3psxrQLHVmuSmg9O6xzFHP8gCj9GlH+u6IgbkrQoZ4q3RFcjkPUsCeQPm0e5HCNFFcMWlj+4gVZ714t625ghnz825d4Ith3Qm6zjbPWDFsLSPO6HxzUgZgefevMP5uPchVNr271HngKOVpQtcP+zwMTvvtIcwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lBzqGmUd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lBzqGmUd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JEkM1t969073;
	Thu, 19 Mar 2026 15:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZWRf5M
	bhVMlsDSn3PbS5fz/0/HG88cZvaAE7lv40Z+0=; b=lBzqGmUdmGFZhj/nCdeNV8
	+77voJoR2O/TdY8KWi/1zNYGOEMLwz6UnGNcz/MaNPyQVARcWlx6xfg7KWDwSwOG
	Nx0oMOoRrJJM7ncFYbvq/3Gr0pRKxEKWCwIuTcpKYKRDLBDZbnY5V4OwgChgAK/h
	Cy8eZdsVTnQWwlGqafWQDq7PpaD+tag7OY4xVz9qbxfTkaYz2UiS5mXd9Zpedj7u
	zX5zcPUR9B11V3Rk8W2O1j40JR52ZATXcm3d2AyxzbAJb8Ea1InQET3niWssHRgI
	9dR+TXY+/ENAhTYQtZrkPYJzi64dyxqMYRiIl6Utg1zvLzNF/sZrCe5i9bAoPS3w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3j70qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:34:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JFP1O3028501;
	Thu, 19 Mar 2026 15:34:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1jsvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:34:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JFY81T52429092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:34:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5E1C20043;
	Thu, 19 Mar 2026 15:34:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9E7920040;
	Thu, 19 Mar 2026 15:34:08 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 19 Mar 2026 15:34:08 +0000 (GMT)
Date: Thu, 19 Mar 2026 16:34:05 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        Nina Schoetterl-Glausch
 <oss@nina.schoetterlglausch.eu>
Subject: Re: [PATCH] mailmap: Update email for Nina Schoetterl-Glausch
Message-ID: <20260319163405.2f230467@p-imbrenda>
In-Reply-To: <20260319143545.1395319-1-nsg@linux.ibm.com>
References: <20260319143545.1395319-1-nsg@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uV4-jaHqiETTUOrR-XrXNFTZBTWvG2GZ
X-Proofpoint-ORIG-GUID: uV4-jaHqiETTUOrR-XrXNFTZBTWvG2GZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyMCBTYWx0ZWRfX4K+eISwP/bTs
 JpkNyplDBx7g/Mw1xESG5SqJZrnCJVF6c2KXtXm5GEQpxcTZzRyVboKbYsbGhVUBO/4z/tHZigT
 y5tUloRMIfrV3rKGK49mnrv3uPv0VZCvXtdLB6UTNliI0eDra8TLyto14UkqSJjpQ9QOfHku2kN
 uzh2moWtWQFHLF5hezpB5YSNenPldyIoUCb4zx1i1JTNXmBppm4ZmmYL2oVMwREuIQQdOes+ufL
 BNv1E7El7+7voum805gobsSqFKzpcF3qEKo4UXQI5GmbXI5h+yYxKfTyAsvCjch5gRi+xz6U7z5
 +JTNOeknVv5juAz+feQOA5xaQZ/J2/Zonenu63ouvD5mt4nOU0VMEfuFUjVVmYyXZ2WjRNyN8OZ
 6bqJiffhct/ZQqyN7gaLrhRgi/2QwbAHs3tBlfTW+N39Yb2ufCO/SAuo2Lg6vi9/Ru/5+dp0sbC
 2D2UuPdoFZPD/wQB5aw==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bc1775 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=vr0dFHqqAAAA:8 a=20KFwNOVAAAA:8 a=CDq0vqnqAAAA:8 a=Ikd4Dj_1AAAA:8
 a=p8Hr7QA-AAAA:8 a=FS0upHgUAAAA:8 a=COk6AnOGAAAA:8 a=LpQP-O61AAAA:8
 a=ZvO8mmm2CNpZY4jmVKUA:9 a=CjuIK1q_8ugA:10 a=P4ufCv4SAa-DfooDzxyN:22
 a=Xn7iXEen_xUG9zZOO_Hb:22 a=Nk6gH44JAh1yPMgKJKsv:22 a=BQgJtduX4OmZBxSA4osX:22
 a=TjNXssC_j7lpFel5tvFf:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190120

On Thu, 19 Mar 2026 15:35:37 +0100
Nina Schoetterl-Glausch <nsg@linux.ibm.com> wrote:

> Switch to my personal email.

Sad that you are leaving :(

> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 40b4db2b2d60..08065a3fb37e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -625,6 +625,7 @@ Nikolay Aleksandrov <razor@blackwall.org> <nikolay@redhat.com>
>  Nikolay Aleksandrov <razor@blackwall.org> <nikolay@cumulusnetworks.com>
>  Nikolay Aleksandrov <razor@blackwall.org> <nikolay@nvidia.com>
>  Nikolay Aleksandrov <razor@blackwall.org> <nikolay@isovalent.com>
> +Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu> <nsg@linux.ibm.com>
>  Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba> <nobuhiro1.iwamatsu@toshiba.co.jp>
>  Odelu Kukatla <quic_okukatla@quicinc.com> <okukatla@codeaurora.org>
>  Oleksandr Natalenko <oleksandr@natalenko.name> <oleksandr@redhat.com>

