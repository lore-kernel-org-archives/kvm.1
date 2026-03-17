Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE73F8808
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774355; cv=none; b=K32xq2b/Bv+Zb6779lPajKgmnIqBLjvLZQpjPKtSOlMxGm0nf0Bkjs/VN5frAR0EjLmfSiv99ydHyzRixIP53CAl/uQxyAfk/lYZaJJ/69J16SxLYtAbYCyE6BsCoGX0so/Fq5wFdrBwYltFp3PBRPq8ugw4hcIJsTB0sawBQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774355; c=relaxed/simple;
	bh=NF7Y5dovv3G3Tx+4h2I1Qh9S7vSOMcSBIjkIkaAtasM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udReLfAY9OVT2ZWIzwcCb9NtTTY4sxk/3mk7VVcBDSmXt6ZsLLvJRK1JY0+z96eC5uzEdeU/7sFuaVbMC009wEZM/PLRbLdRCIq87gdNeN5ET1bNQAwOO8+APMgt1v+IxPkXlwYDjEnqpIzHHdFOu8E+Uxg9OLpDCFsL2ESeNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=5AEK/lmA; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="5AEK/lmA"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 62HGZgtR394977
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 12:05:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=Jb+cvCHXzroux0bE867G
	z8WloAHRp7RfIB9TE5DglOk=; b=5AEK/lmACjc9t+b0G/7+CVvrW5k7M1aTwhXu
	uYQNyjwtapTNLv333UkQkCJjtoCM6N66qobqYq8qPnFjtV+t2erAHQIqk4qw9tsc
	i/h5dw78QbPO5/gEGKsZNsXaqq5Q+9V8sfpAqxTaA1xCbxVxVm0wfR1tUPeAxmw5
	F7Md/E0uEL3i0mEM7O/VrJTmR3ngwBYBT9D8bg//kHCFI3tphZXXRGxFPScQj7Ir
	IsWR787UdSBhszYh9X898nmRFgyJA5SSGtC6NvWgFQDruVtrDpDaOENIr+QWj1Ug
	T1jQoEw7FXjfelJ9Oj3fqCoxwArsOE64xeJbUdZ/0fY3BNgixw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4cy77cxyg5-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 12:05:53 -0700 (PDT)
Received: from twshared61449.03.prn5.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Mar 2026 19:05:50 +0000
Received: by devvm6375.cco0.facebook.com (Postfix, from userid 721855)
	id 78BC16AA975A; Tue, 17 Mar 2026 12:05:47 -0700 (PDT)
Date: Tue, 17 Mar 2026 12:05:47 -0700
From: Ted Logan <tedlogan@fb.com>
To: Matt Evans <mattev@meta.com>
CC: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
        Shuah Khan <shuah@kernel.org>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
Message-ID: <abmmC0DUZ9gBDjui@devvm6375.cco0.facebook.com>
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
 <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com>
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=evvSD4pX c=1 sm=1 tr=0 ts=69b9a611 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=qqi52k1n9YqV2eshQTIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: pnj5qm38uV73eVejwz2_-xHuq-v3dRgf
X-Proofpoint-ORIG-GUID: pnj5qm38uV73eVejwz2_-xHuq-v3dRgf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE2OCBTYWx0ZWRfX374Haf5SwBRW
 EK359AJhJLUbCFfadUmedw2BN3RbzJSqLDXS2ghORJJcd6qsrqETvlXUkhJwoSyMxum6gTXmHms
 ARMfA3ffuXcRBxfQ5PvMpYEZGb0I3I5/ig1nRo8Cjk/HLG2AHYwLFsLlg39z4Y3rBS0gGnKRqMW
 jlHrdfR9MEoGO7lDdlArMRfG2slOyTBOfaadqHAypjaZD7lTuInlpj+qeChLCCpleZvZYjMaKOz
 DmoodHpBd9hNZDGk/+WM8yhtCVivNgjBcGVv+JoqM2b4DEjjYHxRa447IqTrsuX8lvTGqg+eE1U
 AYLHQWhPUZDrcGZ9em4TDh6u340XYia1zJwYcfoBoTk7Qt2V239WI8iDLB+jYnAl3EBMGDys7P7
 KJU3KTFUst0gGRfLT9qYpNg0LQZZ6lrEwkBxGVge+85F0cH+7CIE2bO+oxIWAszUCmuhcM9WuC8
 nFsed6oGpxcfaSvuQqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01

On Tue, Mar 17, 2026 at 01:55:17PM +0000, Matt Evans wrote:
> On 03/02/2026 01:23, Ted Logan wrote:
> > diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> > index ead27892ab65..8e90e409e91d 100644
> > --- a/tools/testing/selftests/vfio/Makefile
> > +++ b/tools/testing/selftests/vfio/Makefile
> > @@ -1,3 +1,10 @@
> > +ARCH ?= $(shell uname -m)
> > +
> > +ifeq (,$(filter $(ARCH),arm64 x86_64))
> 
> This fails to build (i.e. elides the build) on my local arm64 machine,
> because uname -m returns 'aarch64', not 'arm64'.
> 
> Are you seeing an arm64 (Linux! [1]) machine where uname -m is 'arm64'...?
> 
> This patch needs some translation, of the sort in
>  tools/testing/selftests/mm/Makefile:15
> 
> 
> -Matt
> 
> [1] Note on macOS/M-Mac, uname -m is indeed 'arm64', but not so on Linux.

I didn't have an aarch64 system handy to test when I sent my first
patch, so I went with David's comment in an earlier thread that x86_64
and arm64 are supported. I did just fire up a Linux VM on my Mac and I
see it does indeed report the arch as aarch64, and that it builds the
self-tests without warnings. I'll mail a patch to translate the
architecture as you suggest.

- Ted
