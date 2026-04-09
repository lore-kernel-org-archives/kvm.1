Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169426E165;
	Thu,  9 Apr 2026 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747228; cv=none; b=Zl7Z5EpVmRe1scw0sE8FyH3rOdZoLZxFilRfrsZhX3p6H59VPey/4HeeFx1IIpAdPoUfgIrsCfvf5fXm6bTFUj6JjCfrGTJC7DU2SKNDYmLLN9NILk1L7Bnsn5wejM/knyN7VaJwFdW6I0R/6RcL54FexJuvC0HQb4lllmiixE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747228; c=relaxed/simple;
	bh=BrM9UkQHGaeZt6BhaE+MM2d4YOSLyX/wg5pUeEPCy5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBqkwJGum6/IHwIBP1pZcfV9Lh9PEUdU3q8ehm4m1HqVsdxTwM5GLKt5BGNVZzOE80A/kk/6m32bIGut9h8rtoO82J/CB3rQm6gP37yix6LUACdjiJJleOuIIBGkAK9qJo+61lokakUlp+yiAF6upk1K8aYjSCGUJpGwBNEXs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhU3a53k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhU3a53k"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6399W9dm2592193;
	Thu, 9 Apr 2026 15:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=x3GcLqgIXYbclnfaVy8YSADhxqeGCA
	2RqnlGx/XErIY=; b=MhU3a53kqVdENIMpgY7KVBv1niHmKu0C0sBl44i8i4tUX9
	S236/OMMxYAgQrva9CLnRe/nLBM617Xys1n1+ZN0vqpdITQ7/4weoKLjeS7q/gwi
	sxC8i8o0VltjHjtxIOOMus/V7vpXrvy57frgLGbK+hE84IrsTp7cRn8i5FOyzObY
	qiN1oYX5FnfZNA/j58gmAimDhFto2H1i8BpoWtZvuxLAH1LAO/0DdoqcdWFdicq1
	eBQaaeOc+C95TIOEgG+xlctrp559l7Jy/0lX09Bb+ROvXJyxxrqBeCMbOMFK06JF
	OePkaKtfTNM4exWsFmBfWb959b7USsQYTqcBmj9A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2edmnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 15:07:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639D2JEj026646;
	Thu, 9 Apr 2026 15:07:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg841pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 15:07:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 639F70K529425942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 15:07:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ED442004D;
	Thu,  9 Apr 2026 15:07:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31C952004B;
	Thu,  9 Apr 2026 15:07:00 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Apr 2026 15:07:00 +0000 (GMT)
Date: Thu, 9 Apr 2026 17:06:59 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 0/3] KVM, vfio: remove exported KVM symbols
Message-ID: <20260409150659.71106-D-seiden@linux.ibm.com>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407180107.1603697-1-pbonzini@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OUke7ohKphVTD_7O46rqHj1BKutocYHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNSBTYWx0ZWRfXzi0106Aubn3V
 vbyR9PlxjnlY7fkBYeGOSi+WCnDIInbFkXy7Ldu/QYZhhZ21WTM9NoG22+cMMYiM6LBjxl2/pSa
 meBD2HO+MXS///JTSxX+DrySNKF06zGkFokQvIeUAvS362Co3O4dcF8uzmm2hFv4gk/GR9azYoD
 rreDaagLcOUY252iXDncyA2gEUivmWY0FY/NbcQfINJOeusIhoiwJ4kGyU/onh3yIUh+cMMGwpr
 fjSp6Rd7bxW+mxwBzPW6mJTK1bZLeOqjG56JEpQGt0eTmbS4CVJI4pRir6DH9TRB41ZOHFiWBaH
 JF1Qe9l/OYaGW7ZKK9uHygMZ2/JPPiMl8fbHSzwQncy3jTTljFYy19nb3TLHLQ/lJO8MvTUih1K
 XbctdmCekKCSXzudPcMZY2DRFQn0KK4edIBLuIwBDIqW2zSI6y/NYglGlgKbp+4oIbq4hPYJ7FH
 HYFvkBKR7uZOyB9c7SA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d7c097 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=rraXiVqOvpphp_JkS3QA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: OUke7ohKphVTD_7O46rqHj1BKutocYHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090135

On Tue, Apr 07, 2026 at 08:01:04PM +0200, Paolo Bonzini wrote:
> KVM right now exports three symbols for the whole kernel to manage
> the reference count of "struct kvm"; these are used by VFIO just to
> keep the "struct kvm" alive.  This can mostly be replaced
> by inlines, and in fact the entire definition of struct kvm can be
> made opaque to VFIO.
> 
> Besides the cleanup of removing the sort-of-deprecated symbol_get() and
> the bidirectional dependency between KVM and VFIO, this is useful for
> the recently posted support for Arm VMs on s390.  In that scenario each
> KVM implementation module wants to have its own copy of kvm_put_kvm()
> in order to call the "right" kvm_destroy_vm().  With multiple modules,
> VFIO has no way to do a symbol_get() from the right module.
> 
> With this series, that problem is gone because kvm_put_kvm dispatches
> through a function pointer, set by whichever implementation creates the VM.
> The main issue is that symbol_get() was implicitly taking a reference
> to the KVM module, and that has to be preserved.  This is the purpose
> of patch 1.
> 
> Thanks,
> 
> Paolo
> 
> Paolo Bonzini (3):
>   VFIO: take reference to the KVM module
>   KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
>   KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
> 

...

Thanks for sending/fixing the issue. LGTM.

For v2 of the arm-on-s390 series I'll drop the (first )three patches and
depend on this series. So we can merge them early. OK?

	Steffen

