Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA03D3319
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122308; cv=none; b=LLavCUKHdcTtH4tK9jaY0EyWKrPATDdDqLXuXES6poqBitF7AQseFg8vpbAfBszP+VKS2Roy6LCdAxutMFu+tWfqwBRsegWcfsmhAdxXYc7PYBvfzaKJl4ihXT2UvucT2qH6Y9Z4wQLe9hhKZ8gEdhOwdupXPIflmiTtTVu/G2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122308; c=relaxed/simple;
	bh=YwbmprIkDtutINfk3sBxaUCdm/OmSlnPX5jH2QN1F0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWgq3TBGftS/DcWPIhge8ol36tjKzgH+5EOHlPPlj3zfq3e2m1+EDSj0SlDIVuA4jo3cx/RRBwzUdfSrnW8MaXz9O7kpt/Kdpjdz73ljSB5vBgRFJJqqTMH6GqsjPPvKl19hjJ1WZDHDeUcEpFldIE2YfO2LHVpAkyhnSejZq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=c7ps2RiT; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="c7ps2RiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773122301; x=1804658301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nt2g2G+5DYfHQuv+2HMCz3ZelNBjKrMJvT2XXgxuY1E=;
  b=c7ps2RiTiggnP08GgoDKUm948670GwAfb2dE6yy7U8jFwlo/p0c1Jc+8
   uYraBS8/gKeLA1b/AWZkJhTzODtmsKh2dMLZz46yBfCSeFN77B+qmO0rX
   iYZIGyNr5qgijdyvLMnzUZdIJEEOe3RbQBEF/8OpfBbpLm4gW/l2XhR4L
   i5Od0sFoIo7yjFhA+YCeU2/l72HU46LDKRTeNrvzfegzG+zvNyl5FX57+
   02QVf+cnm/Jcr7wz3++RXloAxgCd2hk590E4M3LWQZUw/O/ULIVa74omi
   iHnSwR8P4koaBi5p8zEu9xKxWxQ2mkWNA/y4PdtFP++feJ2RDXQlnwSf8
   A==;
X-CSE-ConnectionGUID: g5GgTMBBSFqBXQHIs+IinQ==
X-CSE-MsgGUID: 6w3mohR+Q42GMyTInTiIEg==
X-IronPort-AV: E=Sophos;i="6.23,111,1770595200"; 
   d="scan'208";a="14688221"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 05:58:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:30114]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.102:2525] with esmtp (Farcaster)
 id 5a5a57e9-3fa5-470f-b761-4fae4911677a; Tue, 10 Mar 2026 05:58:18 +0000 (UTC)
X-Farcaster-Flow-ID: 5a5a57e9-3fa5-470f-b761-4fae4911677a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 05:58:16 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 05:58:14 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <seanjc@google.com>
CC: <david@kernel.org>, <dwmw2@infradead.org>, <itazur@amazon.com>,
	<jackmanb@google.com>, <kalyazin@amazon.com>, <kvm@vger.kernel.org>,
	<patrick.roy@campus.lmu.de>, <pbonzini@redhat.com>, <pdurrant@amazon.com>,
	<tabba@google.com>, <vkuznets@redhat.com>, <zulinx86@gmail.com>
Subject: Re: Re: [RFC PATCH v2 1/7] KVM: x86: Avoid silent kvm-clock activation failures
Date: Tue, 10 Mar 2026 05:58:09 +0000
Message-ID: <20260310055809.2690-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aanCZqjXd0YiSmjR@google.com>
References: <aanCZqjXd0YiSmjR@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, 5 Mar 2026 09:50:30 -0800, Sean Christopherson wrote:
> On Thu, Feb 26, 2026, Takahiro Itazuri wrote:
> > kvm_write_system_time() previously ignored the return value of
> > kvm_gpc_activate().  As a result, kvm-clock activation could fail
> > silently, making debugging harder.
> >=20
> > Propagate the return value so that the MSR write fail properly instead
> > of continuing silently.
>=20
> Hrm.  For better or worse, KVM's ABI when it comes to PV stuff is to sile=
ntly
> ignore failures.  I 100% agree it makes debugging painful, but it's unfor=
tunately
> also "safer" in many cases, e.g. often results in degraded behavior versu=
s flat
> out crashing the guest.
>=20
> The other wrinkle is that success isn't actually guaranteed, because the =
actual
> writes don't happen until KVM_RUN via kvm_guest_time_update(), i.e. only =
failing
> in _some_ cases creates a weird ABI.
>=20
> And most importantly, this would be a breaking change in guest- and user-=
visible
> behavior.  So while I agree silently failing is ugly, all things consider=
ed I
> think it's the least awful choice here :-/

Fair point.  I'll drop this change in the next version since I spotted a
compile error in another patch and I need to resend anyway.

