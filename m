Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710902;
	b=JYocwJFvVkMlaUPC86rsMFawyZN2LnLOHd1n+KrQRY4u4c9EigA9VkuODAIA2XeYa5M2
	 yX3Icf0XM9bLaDaojCQ3TWbdQSPQ5BBUD+iVTP0cRrAAoisjBhgqOZPPeY1ZtD0W6Ap11
	 ka6mRG9P951QKQA6Ho6kky3mQilq5/Uib2esPfJWi6Rb8RWFwRZ3XRXjoW3oI+zQxwn82
	 dLG7DljnT/qmQXuhwtwV9oAEy335N8omLQIqZgrh39phcszsqiQzhrUR+e/j5w9qK5pHU
	 e1kdlKX24hYRtn6tV8OeyuyKZQOcMoF1lt37n2ox7nsjTPw8aqhXMNY6HKn87+lEfyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fe/sqjXMQ0febl707jCaRDDCk+kBQa1AqavEoYmb1Z4=;
	b=FtomAO+ASWizSiomKAcIIBOAb1floO+slq4Tn4dkCQLMD4dCqIF3V7Segzzvkly72PaN
	 4g0LAgqcZ/3zylwimdrP3xnpSarzZj4aXKHpeaeSh6aK5XhZ2OuD3IHSPBxvXYWsC+rqW
	 mCwrELWE0DnqOcV60o6apbf9c0KLLUKE8lUrjEOLW+MzdCYl3a/dFjxGFNTYKqOBJbQyv
	 WUJd7GXVX84KPILgBIh728d+MKyKu/mko0R1MSjKgUpdktQMwomrL4SiYIG7ZJWrP45HU
	 ROPMjBTKKNC0hrJxb+PkCm8mnFV5eYx6bWZMP51qtDjVhh4NWxixbdZ82ftgI0yimjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/vZWMbJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D141606D816;
	Tue,  3 Nov 2026 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/vZWMbJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F7B1F00A02;
	Tue,  3 Nov 2026 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710901;
	bh=Fe/sqjXMQ0febl707jCaRDDCk+kBQa1AqavEoYmb1Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/vZWMbJt3cDh9eL99gNJuNRONQT43DsPpfv8plS88iDEHGa6/mVi/lCY7UzNmeMd
	 2V3p70NZontT/epfe/naILnfxpYjfChhL/e2z9ytL4ZrmQO1TL0q03UPRoVxGBKR2j
	 yRyZOkHnbmtMGK+c1/g27MHtxnaEm3ZCYct+95Fu712Eqhniqe2BUd9oCirgy6Z8kp
	 GzuYNIP21+eGxAZTUYDR0Obu9/Gur4ymqLdYxcKp8ffhJ24YYdmW1W0F/5uityO0dY
	 kHIEgLMfPsfFtLCbTap5mYPzgLw2DB4MWD+VODgWrbeeI5CXgkTL9imAqtcZLNSEfL
	 IRWHDenfVlbEg==
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Provide empty installation rules on unsupported ARCHs
Date: Tue,  3 Nov 2026 08:01:27 -0500
Message-ID: <20261103130131.4069212-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200152.1365147-1-sashal@kernel.org>
References: <20261014200152.1365147-1-sashal@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ping, this still applies on 7.4-rc1. On architectures the KVM
selftests don't support, like 32-bit arm in KernelCI, installing the
selftests still stops at the kvm suite with "No rule to make target
'install'".

-- 
Thanks,
Sasha
