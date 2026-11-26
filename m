Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713310;
	b=URbMCw7HVYnsejcWN/nAKvZl1wQwKgwstJDqbxnTPlOi9DEQKOntjbT9NnuicRzDujOI
	 5mtwLj9ALfgKqesPKKuYnDog8AXfXMqTE9otbqc2HFAMt+Fijwui3qdHTm0svkhktLmQA
	 d7/tVzDh+uC73mybigrVnnGcBiWCZWX2gJfuxxHvyzMtozn7ElUZ0kb5e6MIIAoySD0GU
	 Vrhv7gaaA2T7Y2ShTrCdh4FcVKGUvecuDPmvgMwKXAyjJ+F95XU6pErT3YzzSYKM70z7J
	 3J67svaEq3fFWfnUKOaqm0W/nxZHv1vF3q8lixGwq9kH2RdbMdKwB14gVfBY7HxQ7ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713310;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6TepgGfj4GMWHGrn1OgMA5TBfCmzMmlZJKiB8GMwmtI=;
	b=ILDHvUrTW6XkRNMtHhfrgLP9Jw6UbQvpAN5kFdigJK4pt6ee/g88+SgCthkCHzqu+Pf2
	 +fjq+y9qrqujyqgmMJrBwxODXlA5BSGBftK2gZEREk5/4iDgN29a4d9l4c8b3XkZh3MGj
	 8oB+IntXrYLwqnXmT4nihlpQp/WVX9ntLja+IPvjPW4eYXeMy/QsnnhZs7M1UmIyjX2kN
	 h/QkH3wi3z4YLMY6tuzezN0beQTFfp5AtsFow41u+aebxAYfb1bHkYHGD/gOHtTSk6ELu
	 kTjjff2JMxf2FiR7jyeMjKs7Ynkuu2YHN/lLSU9sk0cZRPRG2g+B5yHbZARYMbJxOsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fd/ZcERy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1F606A329
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fd/ZcERy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0C31F000C6;
	Thu, 26 Nov 2026 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713309;
	bh=6TepgGfj4GMWHGrn1OgMA5TBfCmzMmlZJKiB8GMwmtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fd/ZcERy8XDJ+A1bHrvCXl/oQVf/uaWMRvhc5yvMVYBGekU6h7uGzrVjY6E/+nlGL
	 rVROxsxV6G4mL+RzwQnZkpN+X93bP2Tat18Rk2OqQ/l1jyTlSv3w+cNEV73q2wO0PG
	 at4L8HDTyBKd5JY9XtESGAhlEs6DJ4T0Jlzww6k1kYRpW9w2c2cMyQLTYOQqAUiNhO
	 HmWXdnUsCvClYP+X8DGJuPzEC8GYEgkCbC6SEGC66WGYxnJQsWzrp7ALH88QpQW2r7
	 OpsgV25uMq3dqwL/fRJ7M0hysPydJEqCzFCmTIaaNCsMoKtSsY+JCoQkGIGrF+v52S
	 CGwRowbOtDSPA==
From: Will Deacon <will@kernel.org>
To: Julien Thierry <julien.thierry.kdev@gmail.com>,
	Mika Tammi <mikatammi@gmail.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool v2] Makefile: Fix the feature checks when SHELL isn't /bin/sh
Date: Thu, 26 Nov 2026 17:14:37 +0000
Message-ID: <179571028384.2955005.16115604114691335774.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030004422.33732-1-mikatammi@gmail.com>
References: <20261030004422.33732-1-mikatammi@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 30 Oct 2026 01:44:22 +0100, Mika Tammi wrote:
> try-build and try-cc pass their test program to the compiler with
> echo "$(1)" in a $(shell sh -c '...'). The newlines in the program
> survive only while make's SHELL is its default, /bin/sh: GNU make then
> runs the command without a shell, splitting it into arguments itself,
> and the whole script is one single-quoted argument to sh -c.
> 
> With any other SHELL, GNU make runs "$(SHELL) -c" with the command
> line, which it first rewrites with a backslash before each special
> character and then parses again. A newline becomes a backslash-newline
> there, which make removes [1]. The compiler gets the program as one
> line, ignores everything after its first #include, and fails to link
> it:
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] Makefile: Fix the feature checks when SHELL isn't /bin/sh
      https://git.kernel.org/will/kvmtool/c/f5178cb030dd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
