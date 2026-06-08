Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BB3D2FF0
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937401; cv=none; b=IKDCrTnYANrRh4StCPktbFT1L8m4Xk8AIBkBuCW8K2Q6mDUGpIQ1IL7Y2qNoT95h8FR37BOwMq1eY/K6eh+3uGGKHvAqbGTRjyNXUSr5xIXSA93CjmbfuOhDKf8LGU7sIcInNSuhzjN5GXq3tFOgFTLKte54+Y1/cdtTS0XiYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937401; c=relaxed/simple;
	bh=zekbraP1Id3hE02FXpXHER4CsQ6msSfvmXTExOFMtPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EEWHb4kTXMHx0/W/4dPlEPhLoe9AZ5/+K+bRYyJ9upKMlRwmvEmr58k40ZV5MHq7IRpXuu121hhNk+nojtbU1YQJC3IUp6zSVF8CTwjLSpaEUb6Hk9CbEXphGVcNVkCqSJ24Px8A19Qf9Q4jw10pAyoVdaydtfh0i2I7lWerKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC5g0zYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC5g0zYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731AC1F00893;
	Mon,  8 Jun 2026 16:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780937400;
	bh=WKfUYaLjWQLhTreiDSh0AZppcuDsSFTUQDE6khw4UIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oC5g0zYUKN+wMnsntvbGJA1L+44QHjc0BveaDu/2nfF6EzSFIR7qdoTzDLGEt1q5y
	 JqIvoZbijqDmO9+a+543DqT6ZENSr3HcsM+oQ/L/4FhyV/nzl7mx8hKvNh6GZWpReb
	 q6to6siyfaxwWiTRdixnaZQ6g4W7LrpMdRrFYGt0Alklza22fhw0+des+WEDWEFFBY
	 /GXiFuHYtB6ZClp9DDdG1qVNUau2g5QPJ77NMDWLRE5gJnE4aHkYNqwuO+SMHrbrDc
	 GIt+L3N1G6QsNqAdWNX1x/0Dn8rM/HMDHLo21igWlyLmg7o5Wo6x1Ugif8NZ+Ud4aH
	 GKsUnMJ6LwGIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/60] kvm: Move kvm_vcpu spinloop members to struct
 kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-25-joro@8bytes.org>
References: <20260608144252.351443-25-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:50:00 +0000
Message-Id: <20260608165000.731AC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch silently moves `halt_poll_ns` to `struct kvm_vcpu_common`=
 and fails to update related documentation.
--

commit 6e23e7e10c3367adfc51b745b6493243d998e85a
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Move kvm_vcpu spinloop members to struct kvm_vcpu_common

This commit moves the spinloop state to struct kvm_vcpu_common so that
detection is independent of the active struct kvm_vcpu. It also shifts
the halt_poll_ns variable to the common structure.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9220c452aa3a7..f6e8a0b653b37 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -350,6 +350,20 @@ struct kvm_vcpu_common {
>  	rwlock_t pid_lock;
>  	int sigset_active;
>  	sigset_t sigset;
> +	unsigned int halt_poll_ns;

[Severity: Low]
This isn't a bug, but the commit message only mentions moving the spinloop
members. Should the relocation of halt_poll_ns be mentioned in the commit
message as well?

Also, does Documentation/virt/kvm/halt-polling.rst need to be updated,
since it explicitly references kvm_vcpu->halt_poll_ns?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D24
