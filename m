Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483F4286D60
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678156; cv=none; b=obCYOZRLQm7juahz/t6CDCXvVBT1qaBeHOo+3QDyA6pU2I/YSZCV550IQMwhF4hPBiADYeZS32JFawIJCcBbpu1lneoYbmBWWmnbRPki08xXGxSzXOQsC7iXlrOZlZMsjoQkM4XTpMz+JNiHV090q3QQJH1gfFUaAcs72Nzl8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678156; c=relaxed/simple;
	bh=xHRaMHMzPGRzmn47MUv+NgPWPBnncYfFht4Qk1QBUIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AjfHRs+cuUkpyVVbDxJi0hmQwuEEpjSz/EMkfsm0XC6dL1p5+PXAoVUhGqs57XB1t4PBXE8t2DbI2XXZSIehtJejSeiD6db6uXVMN+kPoEDftzjKdOx29vf9FDMR5flIbq5CSGdpRQ6K6crxRITXtXn61hHuhW3l08Yajlo7lw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0F7672025BD;
	Wed, 17 Jun 2026 08:35:54 +0200 (CEST)
Date: Wed, 17 Jun 2026 08:35:52 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Subject: KVM Planes arch-independent parts
Message-ID: <ajI_ZR1tOL6LLfl6@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Paolo,

As discussed in the PUCK last week I prepared a branch with the architecture
independent parts of my KVM planes series.

The branch is here:

	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=kvm-planes-common-for-paolo

I made the changes we discussed during the call and fixed the issue reported by
syzcaller. Besides that the patches are unchanged from what I posted last week,
in particular I did not yet look into any of Sashiko's comments.

Best,

	Jörg
