Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898053659EB
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469031; cv=none; b=aJq0sGvaQglUmY3RUa1c2qaD0Eav7q1SWn2X9ZSP2Wsxoyko3FK4NPTBY/NDBQmx9xHh/DIcIbO/R4z1KCWdwL+872mG+KMC56ulJC7NwMYiG7ZGD/iXjKIrMHMrotzNvhcu5ZLrveBZPbN3w78nJvkyTNQ6GXlCiFfZQ9O4iMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469031; c=relaxed/simple;
	bh=7l7DbEg1TybzyBtrT9VC5whDXJLZ+E4ko+shCadZILE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N8zSewSeCfz3Qey3VVVbR2Zunr92NdnRRGDO1tRoSK8MUL3O7IwN16SOEDa1FQycdcK4a6zfsBVLc/Kx1u4Nw1cFpIQ/WgMFctkUNq26uQ4YTOXfVBLvhswSOE0ViiEYIAtuZV6xy65jnO8b6gkWmPjEhkn2glcgl58QGRt9dQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtpYu9yo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtpYu9yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2591F00893;
	Wed,  3 Jun 2026 06:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780469030;
	bh=l2U/psbOjtWYh2SCJbkYu/baXgbGYWIqQwuv2O2CqKA=;
	h=Date:From:To:Subject;
	b=YtpYu9yoT7v5BbyzLN18ku7SSM6iX7g3CSbhH1EhV1nPjLQf5qCgt30MUiRQ/HCu3
	 Wyd8ET75n+7PV5HT0/jjkP1uDddsMyrQI8yLIzg/cmSibmRFLv4b9+IDOjEMoauMYC
	 5zJw3nCGavEg0lUrvn65jWocu9EjMVOoCPr/VublvLue85UnZTkwiQBUCZMdVu3NUu
	 2Mi/Ewa9YDE6O4PCxYkuWZzMfAVwVzppGClYNMBVhwXvaJHpR68zu7uIycJAaWwqql
	 BzFcx//OuJuO+qC1/wUZXn0aVMbKXbWCqX4BoTaHchTlAXPq3KaQX9p49GxsAOcBc9
	 N74pZTDjw2gRA==
Date: Tue, 2 Jun 2026 23:42:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: ppc64le kunit test failure: guest_state_buffer_test
Message-ID: <20260603064225.GC18149@sol>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FYI, the KUnit test arch/powerpc/kvm/test-guest-state-buffer.c is
failing when run in QEMU PPC64LE:

[  146.554299][    T1]     KTAP version 1^M
[  146.554348][    T1]     # Subtest: guest_state_buffer_test^M
[  146.554543][    T1]     # module: test_guest_state_buffer^M
[  146.554927][    T1]     1..7^M
[  146.556873][    T1]     ok 1 test_creating_buffer^M
[  146.558221][    T1]     ok 2 test_adding_element^M
[  146.559532][    T1]     ok 3 test_gs_bitmap^M
[  146.560309][    T1]     ok 4 test_gs_parsing^M
[  146.561246][    T1]     ok 5 test_gs_msg^M
[  146.562116][    T1]     ok 6 test_gs_hostwide_msg^M
[  146.562911][  T428]     # test_gs_hostwide_counters: ASSERTION FAILED at arch/powerpc/kvm/test-guest-state-buffer.c:488^M
[  146.562911][  T428]     Expected rc == 0, but^M
[  146.562911][  T428]         rc == -2 (0xfffffffffffffffe)^M
[  146.563600][    T1]     not ok 7 test_gs_hostwide_counters^M
[  146.563653][    T1] # guest_state_buffer_test: pass:6 fail:1 skip:0 total:7^M

Tested on next-20260602.  I haven't bisected it.

Note that this test is in the defconfig.

- Eric
