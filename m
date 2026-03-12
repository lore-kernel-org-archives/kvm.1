Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B63346FA0
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326078; cv=none; b=n6f9qqRZlCKUkt99MAQRmE7szjH0z7mp8L7xIIuVhgzMtCF9xxZV3Ru5DGGfv9ZldkmthnxU3ySvs0tnbRMKg+6W6hFPbCKRPeivWzzWzCFsFBaWT/hXH1Vqo3Rk16kIEjh9EAvPUPnuIbwflmow2z3+G+QQE6gt8XsS8letsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326078; c=relaxed/simple;
	bh=mfxrKCupRHu+X+x0cz1Ztl2xdE4Ck9Ir8Gja9HgDHpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYvwc7oABCH1MDYMCdrFWjsXExi5QIkTlmosF3XzOnBIzFtQVFCecZTYKV7Qph8fGFVb/scOS724iUFeOD4B8EvRmRCA9TVONjbN2gv6djqxK4PfDqjoIt749IQGLsw+BZZopZa6I2JFCC2LnsczYF5+F3aLZ7dBRa3Num6HTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=K8JXgAyt; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="K8JXgAyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773326077; x=1804862077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dHgIOldCEHrIq/D7KhUwWFDHZzGA+7EQcTvE7prH4rA=;
  b=K8JXgAytmRVslWWRhNJ2X3d5EmfrJ6xZeOrItrEjzYyKSohsF/v23VHG
   iUtJgkEZ/yfmROnumhD71A7uc9FVkpQX7k3oDKEpjyDYDZbMJjC8uAhZv
   tOLS70O5+koL+or5lY5QqNajGA1jBMSMkNby/AmiZft+OuvJv0nPxEjeZ
   +M/YJHDn3ij/25OzJxpr8I+WCwUgI3tFA1pqy8MPjB3UrveaVXD7T5YN2
   JROwpTmE5YjnJ5bM6BVFofFlzZZAnDki2KiEXk9DtI8PklgOVdMdCqqqY
   O2NA9W8vDSvY9rrToWfG7lnK6YgEB/mGNN9DNytIjtHdNdF+9kCduumNK
   g==;
X-CSE-ConnectionGUID: zGRivClASLi8pX7C5WwfOA==
X-CSE-MsgGUID: NWXjBb5ORW6SEN0qZ4AwpA==
X-IronPort-AV: E=Sophos;i="6.23,116,1770595200"; 
   d="scan'208";a="14885265"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:34:33 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:14916]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.39:2525] with esmtp (Farcaster)
 id b00e6002-be4c-4c7d-8ac7-46a44bd68b48; Thu, 12 Mar 2026 14:34:33 +0000 (UTC)
X-Farcaster-Flow-ID: b00e6002-be4c-4c7d-8ac7-46a44bd68b48
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 12 Mar 2026 14:34:33 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 12 Mar 2026 14:34:30 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <seanjc@google.com>
CC: <david@kernel.org>, <dwmw2@infradead.org>, <itazur@amazon.com>,
	<jackmanb@google.com>, <kalyazin@amazon.com>, <kvm@vger.kernel.org>,
	<patrick.roy@campus.lmu.de>, <pbonzini@redhat.com>, <pdurrant@amazon.com>,
	<tabba@google.com>, <vkuznets@redhat.com>, <zulinx86@gmail.com>
Subject: Re: [RFC PATCH v3 5/6] KVM: Rename mn_* invalidate-related fields to generic ones
Date: Thu, 12 Mar 2026 14:33:59 +0000
Message-ID: <20260312143427.21678-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <abHXOvAaK3X2FIkt@google.com>
References: <abHXOvAaK3X2FIkt@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 11 Mar 2026 13:57:30 -0700, Sean Christopherson wrote:
> On Tue, Mar 10, 2026, Takahiro Itazuri wrote:
> > The addition of guest_memfd support to pfncaches introduces additional
> > sources of pfncache invalidation beyond the MMU notifier path.  The
> > existing mn_* naming implies that they are only relevant to MMU
> > notifiers, which is no longer true.
>=20
> I very strongly disagree.  Except for kvm_swap_active_memslots() and
> kvm_create_vm(), literally every function here has mmu_notifier in its na=
me.
>=20
> They no longer are used only the for the _kernel's_ MMU-notifier implemen=
tation,
> but they're still very much scoped explicitly to KVM's overarching MMU no=
tification
> system.
>
> If we want to come up with a "better" name, then it needs to capture that=
 somewhere
> in the prefix.  Because e.g. invalidate_lock is way, way too generic.  I =
read that
> and my very first question is "ivalidate what, exactly?".  Ditto for
> memslots_update_rcuwait and pretty much every other field.

That makes sense to me.  I only had the kernel's MMU notifier in mind
at that time, which is why I thought this renaming would be appropriate.

Since I'm not particularly seeking a better name, I'll leave these as
they are.

