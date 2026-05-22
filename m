Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918C368D7E
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473262; cv=none; b=iHx2FS4Qko0G6LWbcFGdjsmhTg1XcTkAPKnjXd7z9PmDb4q6oxx+aAfIWbM/qB0b1toz7gDXmfun2eIEK7gTIatz3xO5kTz1AYrZ6GGHfHwnc/w/G9dXuUp+hF7rYZnZm337Y5dIKQz/hXNgzOVFQqY5LWlIU56F62BPqRNQtzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473262; c=relaxed/simple;
	bh=5OWuTe22t8XhTxLMcJ0G91AVC1QJ/+dkB4zFe+zkcLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EqVL+ZQPfOJkUdTAa/hUMWHwtoyU4R7SG4dVF4ivC5xCXcSu8c936XUPqKpDkqR/oCkNRs665CWhvDnU5uCV7gatAoy3vb14tWOCMOiqInYaCbfMhEKDY3xG+ExDhp7KMFMUclo46mkdWzJmdLBpFAoUn0HGsfXHf2ZyMRD4+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc9mQy80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc9mQy80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14881F00A3D;
	Fri, 22 May 2026 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779473251;
	bh=0Sic23736NV8VBUqOYq2C32fQqV/+tVRTsy/n0YTu3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vc9mQy80aNICig8JU74UK5H6cn515T2RWcNSWNM7JI+P5WaV8JC+LBlvrjIehGPhf
	 QGHWa6SiLX6G4UOl2ue0uZS+rjMe+zMvhikvnZPivK3Kmp01/FEQRlc7gl7XQ55Yic
	 wBzWHETSdU3IvDfv5C9jiZKb138R4qnLZWCCkEmmPTlNLuLnQ/JZtH7JxKSFdB6G4j
	 /z1EFB0Ogjevyl3jOgkHFdB5LNYPh/YU5SsNbbwS6Au4HFCrBKeK/bYowdbANYS/JW
	 ejlpSI3hW35cc1gwAjUonrp6LnE4mPkwGwNjSPFdO/Qah8k3XBcUZRa3bQYSSsVmAP
	 LJ2PmWGR8qPvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Verify that KVM returns the
 configured APIC bus frequency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522173526.3539407-3-seanjc@google.com>
References: <20260522173526.3539407-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 18:07:31 +0000
Message-Id: <20260522180731.D14881F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message inaccurately states that the capability queries =
return the APIC bus "frequency", when they actually return the cycle length=
 in nanoseconds.
--

commit ffd11318e67f99d376b64f166afff3fe22cd6e95
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Verify that KVM returns the configured APIC bus frequency

This commit adds checks to the APIC bus clock test to verify that KVM
returns the configured APIC bus cycles value when querying the capability
on the VM, while still returning the default value for system-scoped checks.

> KVM: selftests: Verify that KVM returns the configured APIC bus frequency
>
> Add checks in the APIC bus clock test to verify that querying
> KVM_CAP_X86_APIC_BUS_CYCLES_NS on the VM after changing the frequency
> returns the VM's actual APIC bus frequency, not KVM's default.  For
> giggles, verify that KVM still returns its default frequency for the
> system-scoped check.

[Severity: Low]
This isn't a bug, but does the commit message use the right terminology her=
e?

The text states that the capability queries return the APIC bus "frequency"=
,=20
but the capability KVM_CAP_X86_APIC_BUS_CYCLES_NS actually returns the cycl=
e=20
length in nanoseconds, which is the reciprocal of the frequency (calculated=
=20
in the code as NSEC_PER_SEC / apic_hz).=20

Could the commit message be updated to reflect that it returns the cycle=20
length in nanoseconds rather than the frequency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522173526.3539=
407-1-seanjc@google.com?part=3D2
