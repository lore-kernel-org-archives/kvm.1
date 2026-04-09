Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C283CD8AF;
	Thu,  9 Apr 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746941; cv=none; b=ccTQFB1N9x+RSBZHg8F5+dtNoF7KoI5d18tbKSTLBSRb8JrGkbC0W2nGJN56EWO/qHTS7YBvpcokRqrbbjtduPexmcPDrxAE7Xc3fEV1esZLq28UUoWX8JB1iKLO8reTzDZN51MmJmHVR6oDWgSTIp3vE20vh5uUUfUZmDlmsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746941; c=relaxed/simple;
	bh=xfznoGJRigeyE0tX8qMEDJg/uk5d6r+fm+zxV0xODtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaRR/bd768heQOuNbhs3milCmHYyQEunwxpmMvXnbrpVb10IqMwmKfy7WHA3pKAJcU6xmuXF/L/Fd5b+rmWvTkM0qGyldPYoqYLO9lQaumguHXkoqqb/jE5HUDAYh0LUFdfxu59Opu6r2OAjwYpBSOs60IoSdXcRDiu7M2OwR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KelG5MgB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KelG5MgB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639AnweW2314896;
	Thu, 9 Apr 2026 15:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kgElBchFK0ARUCY060As69AQom6fnx
	saGdE1xfFLo6c=; b=KelG5MgBc7IcvH2jmEAEWs1fbHmnXx8dzopqW17z79aj7J
	dywMVlhXfnwE7pFNz1rTxY/KgOM6y1g0GT7yF8v+6uaz93W2mjcE+6Bv2ceenaJR
	ZDUoCsBE9pRgHflkt0kjI1Nn5IPzbGiuZ7bWMZwGZXrVdq7qwUzto7r9X8shQON6
	PyRlGbLKLOnGBZtLMUHy1UyWyd2DavcdZTtDxLMFIhVkA9UvHINFctZsuJ6oK53h
	RgJdpkAwW7Mh6mmCZBQpioqe5Db0ocTKKKt6FZimf568tlB8nWWy/PFBxJGt+nDs
	WLHoOYcajJdo0qqz2ZVHz3wEtYl9mTB80gcPBMSQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g5jww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 15:02:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639Cu2XO007924;
	Thu, 9 Apr 2026 15:02:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2m2d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 15:02:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 639F2BAb53477834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 15:02:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B337E2004F;
	Thu,  9 Apr 2026 15:02:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91F4820040;
	Thu,  9 Apr 2026 15:02:11 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Apr 2026 15:02:11 +0000 (GMT)
Date: Thu, 9 Apr 2026 17:02:10 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 3/3] KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
Message-ID: <20260409150210.71106-C-seiden@linux.ibm.com>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
 <20260407180107.1603697-4-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407180107.1603697-4-pbonzini@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d7bf77 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=MjSQUF1uLjVparcYz5YA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: svdhi_oGBKkrGVGQ5bi1n4tXIi8QP_mI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNSBTYWx0ZWRfX41q1TVcnT2Km
 jPV9rYhojiLB3TJqJxKpycO1iRdJg9x2YXwXT7PceXN0I7nmbV2+ZuU+T3nfsrjuVB2iSfy3tDJ
 v9Sq+a+l/TkZ9XkRDE0MGOoV/OC1GQGK2KDIuvLeRhi+A0vnVsBivsCkPApJAZY73Gv89YT0ecy
 FqEmy1EsEu3qJfQ8wucMBOewH1KXbZAXlUBP9d7vtsZA/zKp6h+GFtCHio1jjmgXjx8TD6w1VTN
 oaCkSziBNeRBvZcaIEx2mvUp4pDJ3htxtbBMk7kJY5lkQbjLkrKzy5KLlJDv/SN38TCYLN0xVvs
 +uMTXQV8e6IEQyKObzF7FgC6N4Rwh1rxFq5v6kg7P7PbN7c8Jh6vWSIJDflKz1vriehxinLLXl+
 7NUKyLLP7csSfi5/sF6mcYPYSH7/HVMIPGBcczov6aMzJhfNVQjBTGgi7GWcNiN9Q+7/cLgFXQF
 1wPy9FZtWmgFCQYy0jQ==
X-Proofpoint-GUID: svdhi_oGBKkrGVGQ5bi1n4tXIi8QP_mI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090135

On Tue, Apr 07, 2026 at 08:01:07PM +0200, Paolo Bonzini wrote:
> Right now, KVM and VFIO are using symbol_get to access each other's
> symbols because of a circular reference between the modules, as well
> as to avoid loading them unnecessarily.
> 
> The remaining use in VFIO is for kvm_put_kvm, which is not inline
> because it needs to call kvm_destroy_vm.  However, storing the
> address of kvm_destroy_vm in the "struct kvm" is enough to remove
> the dependency from VFIO.
> 
> This also makes it possible to direct kvm_put_kvm to either the arm64
> or the s390 implementation of kvm_destroy_vm.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

