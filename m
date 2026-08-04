Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E79423E91;
	Tue,  4 Aug 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828530; cv=none; b=aS8oDDN4KAicJCUbzZKCDmLdLnBKKqPz3qYtBKxMWORZAd8eTetEwChIoaOhs1NHigV1AnBNRCs1rbOL7nT5F3fDwgVM7YRrV7FcNxCqvIfTH206OuYGPTOsXlvy1Wbg4qFQHyKF9FovBW1vUF6BoZCXY/Nyms6pRE5Dm1qKuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828530; c=relaxed/simple;
	bh=59QBGdszpD+ptvH3BvC3eYi/REMGyve3Ua1AnGhc/Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg6BT3Qyn/8h0DFX2VwcI70qLZ0t3IguXeYTDqRD6ibK75W0yVRAuC53WxfVl4v3aQOnVW1Yg5lptT5U849HIglJjCeS7Gne/L7tTXLGIfdmaBddYiqungfH4aZF2mw2e1X3WcuK7idPUJYvNZ0Y702B90Ys5lMDq/Uu/dj85aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e7/6dXCz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e7/6dXCz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HjfD3656328;
	Tue, 4 Aug 2026 07:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=59QBGdszpD+ptvH3BvC3eYi/REMGyv
	e3Ua1AnGhc/Nk=; b=e7/6dXCz8rShuh1euBRoO+SpC4UN6OQb+hnVH18hB2f6qp
	E6qI/u/BEpUKaNVrQUNspfe32tqdNAaYjG8aj0vVWRbUiarLJAVRgU5b24MQPNIZ
	ZQNkKgujfZGooJzWX39/gvVi/QqEawOhi18Cd5Q3j6l/kVWxQ4ZIp6LYT8UuGOkK
	R7P0FCFNDjFVTaLK3PnEJmNSkhJyjuKhV3ly0Ho3UdIDMrWhKN7uSvNFgx2LrSo6
	Vi2PW9S96gE9j5pFvVyDEBbSZervufviwm9s7OOcVKtpmveWvGfyA/3Oz4I4MxEz
	TbffkUPG89iOzZi17c1YgudPiKTePXFzB0g8/y3Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4vpa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:28:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747QVoA000854;
	Tue, 4 Aug 2026 07:28:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtygpt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:28:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747SVZq17629676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:28:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ACAC2004B;
	Tue,  4 Aug 2026 07:28:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C19DE20040;
	Tue,  4 Aug 2026 07:28:27 +0000 (GMT)
Received: from Unknown_32:98:3c:96:ca:91 (unknown [9.39.29.19])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 07:28:27 +0000 (GMT)
Date: Tue, 4 Aug 2026 12:58:24 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 0/4] KVM: PPC: Expose CPU compatibility modes for
 nested guests
Message-ID: <anGUmKdw_-hWt9ez@Unknown_32:98:3c:96:ca:91>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701051409.51820-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX0lByIJB1cDyy
 03cjG7jfeXX9Nhhwu1MNOoVwIEUs/nEjozv5tu4YgUxK65k9jOByTydgzgswAIirFvuNrx1Rdpb
 bTRWbPpbxZoZF0VyUuFMPCN4MOJ9Y1Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX0tP4bY/3dR/5
 T20sWbWh+Nti+qojJbpTycygkRBJmzXqtP3v/kTTZJKTpj7Otn3j5Uzzvm0VafwUxqiBO0xmrop
 tL3Nna3LOhicIaxR3i4n7qjEXOCz8EMrM/UY+7a2vZbQr2lyNCyUMfX4LM/ifRW6eFGdDVEhskb
 yDwC4XIqEMJYhRypQ7ya7MOSRiDVUM7Mm780vQnBAidcOoh2HP59cRSztPvE6U4PR/SJU7l5eZZ
 Cst4p4Lja3EmXyjhoBJ9pQz81kikPxCblcbtEPvuzmoyq8mqmyaVVR7hTcqb4PZZV9dRVnDATkj
 4f85yluVR0kRsktRB5zYYOKZMOhgSL7Wjol8PDqfx54DCemwOeWxNVsq1Z65eZpprxDYfqBDzE3
 ZxzRU+qhPTAHBU542xwM20iu44G2B4sA7XY+sDWZO0kAeTHIIbcpC/xZh4yMpgZb/HqxL9wcx0R
 PJ5nQUdg+qv0eEzKBww==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7194a4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_8gdUu-fOGR6YzzzubEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: blkI9nAo2OGj3UAR_USXM6KmN8uoBlcs
X-Proofpoint-GUID: uXipwvrm6_K3wMwPh2T2rP2uz6tT5l2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040057


I tested this series with different compat mode settings for KVM on LPAR
and KVM on PowerNV.

I've left a comment regarding the ioctl number selection. With that
fixed, feel free to add:

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

Thanks,
Gautam
