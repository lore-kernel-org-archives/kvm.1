Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9A3C063F;
	Thu,  9 Apr 2026 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746919; cv=none; b=bz2X/NyRGu7SlDJA3T64b/Qbe+0Gtl0BAT0oEFtgW36YKcrJ0Dwr894WKN6liOJ+HxWHV3fv2/MPz3S+MYydP9gOXTPgLfOuZd2OWCOHRF5k3Err52JVx0l5yL3Z7Fdxo1XYqFT0YUL9ouDkorllLlamsHQmCt20HVu7DC9+SG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746919; c=relaxed/simple;
	bh=d30sBmQXdolLJwPvL0oaaS23xb6Q0Sc0qiWs007rhBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk4n9Lt8dgB8FfpdJzV3Bo3C+1ixGfHMYnXOiHfgrgBFkwAIM4qXFoHI6Yk/HStEBLILI0/HzbJUYaN0Fdr51o1L0MWLm7SMEm778nRJ8u8UFqXTSGRQXO1dPfixtGxdQM7LiDZSkRMU+YTSiX3MgRG8ZX6lkZadgtbJJCDZFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fMRI6iZ6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fMRI6iZ6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6395v3W71449262;
	Thu, 9 Apr 2026 15:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=h8xx4otvpxgqyOcVskhVkDCoYHVhYm
	/hfJMrXwhaujI=; b=fMRI6iZ64gKlZQeOHbQka/IQF8Egl5rp+5H1/cb2nutGfV
	9+8baTbDTcXWbK/n2mJM4i7G6EPQX99FLQcZt1ba3+PSOkW3/VWks1ap4ccEZpoA
	hZZ1jvPa39FJa38PbX6fIHMuLYn+N2AWSYXCZUtrMtKl5UA/657MYXi+k6H1vmsk
	dcjAsGn7c16lJPbO2Ee0UkysJPY5H5idqwz6o7LcmFSmRV9T4m1rU+ltV93l1vkX
	74IgU5vLTsnI8F9K1BPtqozZMblgEhD6IV9+FPdzEzSMZyvcIrlrZdh33SC57j9w
	uGwfEmC68VMjVlMbaVxD/EEjqi4dnQJHjlKXikVg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2edksy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 15:01:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639CAfrn018952;
	Thu, 9 Apr 2026 15:01:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9m2g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 15:01:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 639F1pou39059838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 15:01:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 917B320043;
	Thu,  9 Apr 2026 15:01:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7786A20040;
	Thu,  9 Apr 2026 15:01:51 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Apr 2026 15:01:51 +0000 (GMT)
Date: Thu, 9 Apr 2026 17:01:50 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 2/3] KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from
 vfio
Message-ID: <20260409150150.71106-B-seiden@linux.ibm.com>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
 <20260407180107.1603697-3-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407180107.1603697-3-pbonzini@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NjXyPaPRBwOqfJ56jJnPe6cVutbZ7cSn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNSBTYWx0ZWRfX+JOht9q/Bg4Y
 +TaMO9kvP6Sq4jo2z1AwUWSTIjDGOG92rU+Z00hQ33HglU3Ky8hQryTWdMh/Mq5sGT9dx0Z5mgM
 nFbR85h3VYMyjTJywrWXNOKLd4DVErC03RDVX7C/+sOxg+9UDpFmInIxXi+Fnne7N2n0KS5WGwj
 7VSSApSYKNtbuQanQHRgy6viWrCOHsJmsYiPRYr/U0vwJ4Zs7928dNGrIs9MjEVAcjB3IvoCh6A
 d67XTa1jaD66u3zIEJ+CSy1nGnjTXhkn932Jtd63ln16k6UPvEiT7yi/Z3iuiJJtxcz2t7WEAxw
 rQwunB3cHISVRIt60io+gwOHOYaATRCsHuRIUO0t46CcrTztkzVdesiEiq1Il1yMFXu++emTgwJ
 obk3G9UD6847IRNJ9TJVRo3SaUTC1Cgg99s5Q2lyluFz6C9S/cbWQ1ZDQwivxMBi5neGYaxhuog
 MRIKZHs13jRT2ZccEbw==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d7bf62 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=MjSQUF1uLjVparcYz5YA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: NjXyPaPRBwOqfJ56jJnPe6cVutbZ7cSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090135

On Tue, Apr 07, 2026 at 08:01:06PM +0200, Paolo Bonzini wrote:
> Right now, KVM and VFIO are using symbol_get to access each other's
> symbols because of a circular reference between the modules, as well
> as to avoid loading them unnecessarily.
> 
> However, usage of symbol_get is mostly deprecated and there are just a
> handful of users left.  In the case of VFIO, in particular, the
> functions it calls can be made inline.  Start with kvm_get_kvm_safe,
> for which it is trivial to do so.
> 
> While at it, move the function from kvm_host.h to kvm_types.h.
> Unlike e.g. drivers/s390/crypto/vfio_ap_ops.c, there's no need for
> VFIO to know any implementation details of KVM, and struct kvm
> can be treated as an opaque type.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

