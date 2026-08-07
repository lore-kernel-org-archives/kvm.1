Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0143C067
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786081214; cv=none; b=knp4iA9glJCLLN/QTydJLN8GejPjnCEhcMg7vnBTZsXkrEsOQAgiUjtZWCAbuNHunb/15YhIaBz1NBTfDZMlyeuIcodJ9d5ej+nHswBPufzjqOWShyKi/WO02WewBOtUQXN6PZEQX3x87UZaHPwffyDIJogtHf8/SNdid4ACapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786081214; c=relaxed/simple;
	bh=BRUPNbNnNdPkuHFu5prbFrwhCBOgW6E3vQ6xeN04ldQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aFd8N2DZZYbrdr22e5GBChwKJhdJxNzs4AMM4NQ8/K6j4XQp5JotfQOceoC5NEDjhDqgRWEjHlfndKlkSR1q5Fm+AVB/Zk8uqQFePCqAETrtK/Lh7QqHvCaAqzo7lkzZjvTrFhY6maUFCpfZqxGqsGstwyy2hMpjdBdhqOZwSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ6aKii9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ6aKii9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB641F000E9;
	Fri,  7 Aug 2026 05:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786081212;
	bh=PimeBzVDtYWoaup4pUrog3BkXS8dM/ZPSPV5ZhjQBY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQ6aKii96W4LWZAL1oQOEtq3hwXxtz2W2W+gXVxFfehIg3hafjm7XwKXEbt4xpkHC
	 qmeqV7JQDMV78aLTXwFlLXadr/ySZropOrdXaTgWUrxVGhQejlvedZrHwYcUr4qMyv
	 traaRZOpNd/P5/K54XpvXGQWUL7c3B5s6ukK0q+wmBj+IszoCSMN0mfrW7qM2G8n+Y
	 QUq6arAvuOAVH2FNc/5TV6U59Xg10pNcIk3Y9W2WhATcwrjXHDZHGf2UUr1YbrOBPA
	 ZMqrUPBZFBIvraOSIgCxg18VGzqjZg4gQNnms8vQMdVlohKqK4HCY/ueGOjUhF+Vqc
	 ApGBUh/ZKZmjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] RISC-V: KVM: selftests: Add PMU event filter
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: Yuhang.chen <yhchen312@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807053227.341700-3-yhchen312@gmail.com>
References: <20260807053227.341700-1-yhchen312@gmail.com>
 <20260807053227.341700-3-yhchen312@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 05:40:11 +0000
Message-Id: <20260807054012.7EB641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message falsely claims that the guest programs the 'i=
nstructions' SBI PMU event, but the implementation only ever programs the '=
cycles' event.
--

--- Patch [2]: [PATCH v2 2/2] RISC-V: KVM: selftests: Add PMU event filter =
test ---
commit 828aa8f61ee14a213c9f6491df6c9b1b9ddbd337
Author: Yuhang.chen <yhchen312@gmail.com>

RISC-V: KVM: selftests: Add PMU event filter test
   =20
This patch adds a selftest to verify KVM_SET_PMU_EVENT_FILTER on RISC-V.
The host applies ALLOW and DENY filters, and asserts that the guest receives
the expected success or failure when configuring PMU counters.

> Add a selftest that exercises KVM_SET_PMU_EVENT_FILTER on RISC-V. The
> guest programs the CPU cycles and instructions SBI PMU events through
> SBI_EXT_PMU_COUNTER_CFG_MATCH while the host installs filters with the
> ALLOW and DENY actions, asserting that disallowed events return
> SBI_ERR_NOT_SUPPORTED and allowed events succeed.

[Severity: Medium]
Is this description accurate?

The commit message states that the guest programs both the CPU cycles and
instructions SBI PMU events.

However, looking at guest_code(), it appears to only ever program EV_CYCLES
via the SBI_EXT_PMU_COUNTER_CFG_MATCH call:

guest_code() {
        ...
        ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
                        0, 1, 0, EV_CYCLES, 0, 0);
        ...
}

An inline comment in the test code also explicitly notes that the
instructions event is never programmed by the guest: "Instructions itself is
never programmed, so host support for it is irrelevant."

Could the commit message be updated to reflect that only the CPU cycles
event is actually programmed by the guest code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807053227.3417=
00-1-yhchen312@gmail.com?part=3D2
