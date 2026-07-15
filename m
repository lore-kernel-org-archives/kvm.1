Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558F3CC9E9
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119721; cv=none; b=aglOFCBxaMJKof01E75/pzB+ccGck3hn2QKbt0uo0l1z88JqTWijybEh+PWD6WZHosyRGuEJgpBnXtyWtoNOBeDTmDYrK5nIAR/SXl6tVk5AA1Yi8bZGQ7KQXM0lE9mWP/yrw4ZgE+PB4emKtNRnYVLGDR4MDUsUB9/WZnpqPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119721; c=relaxed/simple;
	bh=AEq8KswqyqCrsiGxrQvHe2264+2OFPJvJzZWyiTQHqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F2QwrlOBtxWWUAXLyt+hi0RNbwSxx7DDFbw37j1A7xsZdKxPrwpTwgrg3JlSs481JMQhZs0CFk7BdBenbqrXTWhwAx8GPD79MfPE54SJBHvPdplVUv9wGtq7K6Kj5t32G+rgbquHibakEvW+5SaRFUDpBgyVDB+AnHSLgehT1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO4M0g1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO4M0g1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB811F000E9;
	Wed, 15 Jul 2026 12:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784119720;
	bh=bf0xoEe7zv2Tcq8a0Cmi7DggVwj2AK6r8DWVaj/xPEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aO4M0g1TRlvKPbRwOCdFebqiYCm8WwQUGUQ+X8XRrjOW+Bf+cuptNC93/05s0IvZj
	 3lSk1jCs1KAcTP2FDiTxokpSUZPh+r+eSYAdp8QSZebkB9QNUOgiBb0Z1/tJHC/hzY
	 Wp3vvk2ZGXk/CDBii2aOD2kYLje7FVGTEVIaWYAR6bx2kfe7psMAZvgvjzdsVb9bvv
	 f0rYU5ozL85Q3+YQhPlk0mTUjXry0IYV7KnrWlACJ5hG+MNeB7GqgbFkEUN20j0NbU
	 lfiB40YDUT5oy6T0u3kii35QtmdR+rJsg8ZpAZrFK95GwqAPLSwF/+JGumi2bZLnWV
	 itV9zqj8ZoSOw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] KVM: x86: RFC for per-VM C-state policy enforcement
 (KVM_CAP_CSTATE_POLICY)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Harivel" <aharivel@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260715124235.1444895-1-aharivel@redhat.com>
References: <20260715124235.1444895-1-aharivel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:48:39 +0000
Message-Id: <20260715124839.DCB811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] VM-Exits clear the CPU's monitor event pending flag, causing host-=
side MWAIT to immediately fall through (NOP).
- [High] Executing MWAIT synchronously within the KVM exit handler violates=
 Linux scheduler and RCU invariants.
--

--- Patch [1]: [RFC PATCH] KVM: x86: RFC for per-VM C-state policy enforcem=
ent (KVM_CAP_CSTATE_POLICY) ---
commit ba053ea08a3b49a2e72662168226ef280171ed4d
Author: Anthony Harivel <aharivel@redhat.com>

KVM: x86: RFC for per-VM C-state policy enforcement (KVM_CAP_CSTATE_POLICY)

This RFC proposes KVM_CAP_CSTATE_POLICY, a new VM-scoped capability
that lets the host set a per-VM maximum C-state ceiling. When active,
KVM intercepts MWAIT, inspects the requested C-state, and enforces
the ceiling by executing a capped MWAIT on behalf of the guest.

> diff --git a/rfc/KVM_CAP_CSTATE_POLICY.txt b/rfc/KVM_CAP_CSTATE_POLICY.txt
> new file mode 100644
> index 0000000000000..15439e6e7ebbf
> --- /dev/null
> +++ b/rfc/KVM_CAP_CSTATE_POLICY.txt

[ ... ]

> @@ -60,18 +60,18 @@
>  3. Internal flow
>  ----------------
> =20
>  When max_cstate >=3D 0 (policy active):
> =20
>    1. VMCS "MWAIT exiting" =3D 1 (intercept MWAIT).
>    2. On VM exit for MWAIT:
>       a. Extract the C-state hint from the MWAIT operand.
>       b. Map the hint to a logical C-state level (MWAIT sub-states
>          are CPU-family-specific; a translation table is needed).
>       c. If requested_cstate <=3D max_cstate: execute native MWAIT with
>          the guest's original hint.
>       d. If requested_cstate > max_cstate: execute MWAIT with the
>          capped hint, or return to guest immediately (C0).

[Severity: High]
Does executing native MWAIT on the host side work as intended here?

According to the Intel SDM (Vol 3, 27.5.5 Updates to Non-Register State),
a VM-Exit unconditionally clears the state of the monitor hardware.

Since the state established by the guest's preceding MONITOR instruction
is wiped out by the VM-Exit, won't the subsequent host-side MWAIT find no
armed monitor and immediately fall through as a NOP, resulting in a busy
wait loop instead of entering an idle power state?

[Severity: High]
If we execute MWAIT synchronously within the KVM exit handler, how does
this interact with the Linux scheduler and RCU?

If the CPU successfully enters a deep sleep state via an inline host
MWAIT, it seems the KVM vCPU thread would remain in the TASK_RUNNING
state without yielding via schedule() or notifying RCU via
rcu_idle_enter().

Could this hide the CPU's true idle status from the scheduler, break load
balancing, and stall RCU grace periods by bypassing the host cpuidle
framework?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715124235.1444=
895-1-aharivel@redhat.com?part=3D1
