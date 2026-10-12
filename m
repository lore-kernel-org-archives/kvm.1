Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2F214813
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765097; cv=none; b=fDigtT6ZvsRTU3ZY3wE7kv6XgyCNy72olN0c1J/UhpNu9Unl7HZWUtd4dC4cATmo2vI2GwCFYe/Yv/kx7v0jBIFY9gbYeA/mJ1Of64/bIXrzuEW4+xRT+HBMZghrmP/h+H3c4QOuABZJvASxoNOYqdCn0i0d2TF7KHwdWekrwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765097; c=relaxed/simple;
	bh=RUXX/8LcvZ0vB1NfOTbwuI0qJ0UfI9cCnFbhhtoelG0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bS4FG9nOAUQi7QeaSOs6YIEkQiB0zacbDqUw0Bv4TIrA/SC+FCFTqY+SMDoO+SwDtTWbbO95dAayLRnKDfT1faqRq8QJgob3EczbZ8O+ZUMh5UoLMIYfMENaIwAGX2xzJ1UHa4DOy0XUndWtqAnmcFuQEdzqzkqodwUEvLD5frQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=turntrout.com; spf=pass smtp.mailfrom=turntrout.com; dkim=pass (2048-bit key) header.d=turntrout.com header.i=@turntrout.com header.b=UEFk7vRp; arc=none smtp.client-ip=79.135.106.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=turntrout.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=turntrout.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=turntrout.com header.i=@turntrout.com header.b="UEFk7vRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=turntrout.com;
	s=protonmail2; t=1791765086; x=1792024286;
	bh=IraLLtnBNwHo1dM/C9RlUNjtzUQvG9INhNh3pggIMIc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UEFk7vRpRCSPplihQDiOD1uO6ySs+QMPaxpFBTtGFzM52D4r012i+QTpgMsMbJb5E
	 EudQ8AppMjgbI1g9hMRpU4WZnJBhlIqcRfPwQNFiJSRj3Y83DNjFVM89ryfzBYYTLW
	 42peD8xg4hWQAh02dwu41N4oAJlOOkwvP/CYnIzXgUvm1OVS0AoFlmPz1LZPu1zKiM
	 MDlqOv0HBJvI5+tGc078l+FsF0igFRwedzX5D7JjsYe0cr4okybh2j5Ibl2r2gC31i
	 lWTjFkhzGsjNls6LSeMK9ZtZ7D4iYBbnZUZnAMsNWFwXDx7PQUFujy3ZYGYVY9qqVl
	 6QV9AqKHzstsQ==
Date: Mon, 12 Oct 2026 00:31:21 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
From: Alex Turner <alex@turntrout.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, nsaenz@amazon.com, vkuznets@redhat.com, snambakam@linux.microsoft.com
Subject: Re: [PATCH v3 00/28] KVM: x86: Introduce memory protection attributes
Message-ID: <20261012003036.61996-1-alex@turntrout.com>
Feedback-ID: 110371027:user:proton
X-Pm-Message-ID: 68202226d966a1c20801d528891e7db282e9f536
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A second user, with no guest cooperation: we run untrusted AI coding
agents in Cloud Hypervisor microVMs, and the host builds the guest
kernel. We would set NW on its text after boot, so that a ring-0 write
exits to the VMM as tamper evidence.

Two questions:
1. Does NX distinguish supervisor from user execution? Without that,
   ring 0 can copy its text to an unprotected GFN and repoint its page
   tables. Is MBEC/GMET-backed NX planned, or should the VMM
   write-protect guest page tables?
2. For the emulator EFAULT gap you noted in patch 26: will a write the
   emulator performs on an NW gfn always exit?

We can test the series from Cloud Hypervisor if that helps.

