Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA051118B
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747272; cv=none; b=rPNTrtbv4melMajfPd11L6S7KVYCrg6dq4U2zHaDaT5HYTWRGk035p6/3NX9kb444V2HlXqwzrhuU2vt8WsZdvPz8rbvNwrLpZPP3Zwz6Jmqxf9//MOPjcUCIwU5pKEuyT92YhZW36/PgSkavOuGJlCwBPp2hYe5wynx8okZHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747272; c=relaxed/simple;
	bh=fjeR6nRzljEKR/ogWBUihDSPW+nJeEXY49xKpWSuYXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qbugfoIgn01YyZAzmZluxrecHP/b7ixwV6Sp1dUZoURLMZeBKhPY35yMoF0ZDdlvWPWctNeaDmJoIe8IYNXDDZ4rEc57SX0Wm3/j10i8zQN2bNH9jAMLz2IQ6j6OQn/AQGLv+0rSWs1uLZtoi4URXnAH6ZfeKFc8hu1rjN4Okx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byDDzgWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byDDzgWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76B81F000FF;
	Fri, 18 Sep 2026 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747270;
	bh=pf7enZGULdkDGT35+PB49Hq+Fe+C/6MkRiBJYXAZgY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=byDDzgWWZZqm1glmVsFo+zKPN7bGCZx7BPF59HQiDhwJ4foDVTh7C17GXjPAW5507
	 JZP2EkzNv0eDc7NXfYrvsK/GLvzmvvaeb+oSsUQ8XAgRJ2R3j9LcPw9NCtNxuwlIYH
	 BSlb/EqN8Tz008bpJ1jXx/RHyOyjQlA3obTVclPpaUYYreLXvTfdSvu31KVzZyP3by
	 SmYaUb0ULLvfVXjt0nR6Od+YiYTIrlpO2OLvVF4t0yPoQy7vJsfuSKl8Mrlp40AmC6
	 U7vJ1oaqrpQCvMyJmu2vQbI+l3LzCn70yp9QljnkF+1Pnx9OVtitu0EBBgLWD8R0pu
	 BDC+yNHRjIu4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported
 is set in guest CPUID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918154530.4129698-1-jmattson@google.com>
References: <20260918154530.4129698-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:01:09 +0000
Message-Id: <20260918160109.E76B81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: x86: EFER.LMSLE fix is ineffective due to dropped CPUID bit
--

commit 0daddb3cb6cd07afcd9545a8e1643427a1542393
Author: Jim Mattson <jmattson@google.com>

KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported is set in guest CPU=
ID

This commit updates KVM to reject guest writes to EFER that set EFER.LMSLE
when the EferLmsleUnsupported bit is set in the guest's CPUID. It aims to f=
ix
an issue where a guest could enable EFER.LMSLE on hosts that support it, ev=
en
if the VMM hid the feature for migration compatibility.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index 37d5bed3529f5..c8f894ccfb0f9 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -598,8 +598,11 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, =
u64 efer)
>  	if (efer & EFER_NX && !guest_cpu_cap_has(vcpu, X86_FEATURE_NX))
>  		return false;
> =20
> -	return true;
> +	if (efer & EFER_LMSLE &&
> +	    guest_cpu_cap_has(vcpu, X86_FEATURE_EFER_LMSLE_MBZ))

[Severity: High]
Does this check actually work as intended on hosts that support LMSLE?

Because X86_FEATURE_EFER_LMSLE_MBZ is defined as a PASSTHROUGH_F,
kvm_cpu_cap_init() clears this bit in kvm_cpu_caps when the host hardware
CPUID does not set it (which is the case when the host supports LMSLE).

Since the bit is missing from kvm_cpu_caps and is not an EMULATED_F,
kvm_set_cpuid() ANDs the VMM-provided CPUID with 0 for this capability.
Consequently, vcpu->arch.cpu_caps does not retain the bit, and
guest_cpu_cap_has() here will unconditionally return false.

Does this mean the bug remains triggerable by a guest running on a host with
LMSLE support when the VMM attempts to hide the feature?

> +		return false;
> =20
> +	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918154530.4129=
698-1-jmattson@google.com?part=3D1
