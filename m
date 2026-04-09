Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12D30594F;
	Thu,  9 Apr 2026 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746859; cv=none; b=b50joUcFaBdgxmAZMarQwDt9htJ7Cx1GVgBlx60JQZf8vy9DyB2OeUGhX6jKFB1hFqt46ciSq9njQLx1fqhD1P/HE8ldbSGW98Y8Sjujpd6/rMO3v4SEGrRRfGg9XrgyRdYvnRverEYCnuCLgunhjgpSuTNKvwdPMt0I1lZAvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746859; c=relaxed/simple;
	bh=1PeLhkZRLvH8FKgh+2hbReWVKNTysXiu/mJ0LSqLUoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Psxk6romrHVKmK3AENukLzGg+xk8DnUU+TWq+HvZMQInnZDnGvJRe2DUAhkzGARcvt0Juppd5PmVJhl1K2sW15JKZPqtkFde/nILD3j8wcefeVHBstgFbMANUXiSRIH2LjzMhiJq3AiqhesPP0ruaEiH3bF7zGaT3795+EEDAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KWbZ7krE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KWbZ7krE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63993ufK2301594;
	Thu, 9 Apr 2026 15:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MMl9AD3z3dZGJYJByJzCnYarEKkxxf
	jVn0k4Ko4KITQ=; b=KWbZ7krE8KKb2U6qOX+IAtmNuhyh+bvfbzi7uC8fNaJDUu
	uxBN+thHkODr/vLnSpI5sd3qf4Hp4/CQvSaMJxsKF3XEU7LfeBdVPnekKd7Pln0d
	t/npzLsUcev7X2J9ML4hhqzYPl+SCJ2tuzcPLKAKVW69nwKh2x9d+JUrxbSGmNy6
	Udn8GQovfBmLsQAoERk74wPbhon9Pt9tWJWd2+5eajFKJ35jibTcT3fHy9IYOSsH
	pesCytDZ6tf00FGrsHd8BwQWGUsJo10UVSoTe3agNFLzVHnBJ9ppXnbYHM9aK6f0
	ZXFCJYAnG4tNyqu69ekvwD8qtyDDajss3OBgvJLw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fnja3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 15:00:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639Cqwr6018965;
	Thu, 9 Apr 2026 15:00:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9m2b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 15:00:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 639F0pPC46072316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 15:00:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F08DF20043;
	Thu,  9 Apr 2026 15:00:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3B232004E;
	Thu,  9 Apr 2026 15:00:50 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Apr 2026 15:00:50 +0000 (GMT)
Date: Thu, 9 Apr 2026 17:00:49 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
Message-ID: <20260409150049.71106-A-seiden@linux.ibm.com>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
 <20260407180107.1603697-2-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407180107.1603697-2-pbonzini@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNSBTYWx0ZWRfX1EXJLKARMbUL
 BCRNGeho+fI6H/aAdqHuwnZ8DKyW2ccX4wIB0bBlofoXrTlkP0HM5oh/B1wl+yInercWg6sCYIV
 oqXshgn+XebG+GLYG9bEZxJPHPC4S/IzZdURzCYFWlAj3zQhtrPymttVp4+lWOK/9sZxFBNVXDB
 H3xc2H3Q32eMvb0jAJ9Xja8Ja90pDV7CwkrbtNjKIPIU6y1wVx+YEolpfbs5AOiw49fJmQNPwbP
 eVltNIyTY9BPvBB5VgDvg8qHqJniX/r7xDvvnSiv+KNX+XXJiT/2Zea8QIZ32JeLV3JdMBIB6Z0
 AsWG9XyOrKY+eTkATlwe20XbBHZBGYok2FJluOLAc681ZFurOZhqJsdLe7ucJiNcJ7+IwYamKcs
 RPFfArGT+RcAxWOgCb4EqNKffyCUNjbT50gZuEgBswNWymQy465NQr1UmCA1IY7RheVTvu7XfQk
 vo8gMHwHj27EFI28tmA==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d7bf25 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=5N8hvMFE4S4G4LBNZQsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: hnGWGNOsOYEb2Ys2DG_IKCL1gz0UI7RA
X-Proofpoint-GUID: hnGWGNOsOYEb2Ys2DG_IKCL1gz0UI7RA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090135

On Tue, Apr 07, 2026 at 08:01:05PM +0200, Paolo Bonzini wrote:
> VFIO is implicitly taking a reference to the KVM module between
> vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
> symbol_get and symbol_put.
> 
> In preparation for removing symbol_get and symbol_put themselves
> from VFIO, actually store a pointer to the KVM module and use
> module_get()/module_put() to keep KVM alive.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

