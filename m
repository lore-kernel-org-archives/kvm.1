Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923419;
	b=UE5QPvfRpQ4BZFqFQ+pf9FcQjVsnfI1VX5uEpVydEfqMJLEZVjoGD1jtuNG1qWQukqA3
	 JvAqYw98httIfLQoAyfs55zD1COidgocSpQSRn9SPUuQNCqXs5ESYZmuRKhLzHPLNWEQp
	 5iOCOqRmRyYra1PB8J7mydGJSCx1Z5Zo3Iaq8+sJ2npS6ndL3wTb186TbRppXT++hYQFg
	 n9iukj1/sKY1JFk5yS+CLzAi5nfG9NkmkAPgalGFbNdxR2+aA2gGzLj8GB+X9tvbm3+7R
	 Isx831iFXkC7KS/+9XtSoZzznHKR9fWGDEu2ixrUgu9MinNW7W8W8pgWdE4GnqwejOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y1d7KOMyGONR7Xcyuz0lyWSIJyuszQNhjyeb7j3Wj7Y=;
	b=3pdVumwAiQGqK3Kawvmgkzhng0ePg5U6w5PAlEvKpPIqa+dIlXD+jhk8xE51rDX8Qoca
	 fMsJpieXhgZaUT4mAhnPgQara09DKhzdp5HSZERcSFp8mKoUeKWdWnRAcK4blfengaOj1
	 lI0Ly/H5L3v67UeuJ8HKShFrYW+WzbIe0foCpFkRE6fvkK17NbbY/1FHnsLNTUEEGmZD0
	 MhFpDGprjtYIEpUbX24UB468HXKJ0joBlIGX+jl1MGoGKmWLXPUPBM0CNOwy/8dJ8iG/M
	 4yMFqJ8qNTAROiQ/SFFjdRWm8aePgRdzmYEUGmLftwYtASjdSRFTp9v8HrPBDgKb/bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqWF+wT4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8B606A323;
	Tue, 17 Nov 2026 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqWF+wT4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012581F000C7;
	Tue, 17 Nov 2026 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923419;
	bh=Y1d7KOMyGONR7Xcyuz0lyWSIJyuszQNhjyeb7j3Wj7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqWF+wT4R4hfuiF8A9ImCmFWHEfRjHWx9g+kG6QFzkzwMsXewn5LadOnkvaLBR9EU
	 3CwyCeD0Cd0a7kkX1E9KIe0hS/RfJYDOIdBZoYbHghS4F1jdHnBe7DK5WHAiPqAPFf
	 OUrky8ZYq5j2sDa6+Y0KNy7BNoMYMwQ5IuDq7+wTLtv6WWBCP/4RDPANS5bKYTrR6k
	 ThOu3l8qasba7f5tEXzeD/6SYaOZa0eZ6OlofSnCSC71Pu9t0AFpD9VoERZUOwuikq
	 AAGxBtSShf7HScnd6+W0Nm+qj1c7GaPQPZrJ2x4hZfshzqHIbPr1a1l8V5M1w+mnOp
	 srJsP0UrSw4tQ==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Kyle Zeng <kylebot@openai.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Don't reuse the GPA of a fault on the guest's page tables
Date: Tue, 17 Nov 2026 08:50:17 -0500
Message-ID: <20261117135017.1506973-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027191914.2341911-1-sashal@kernel.org>
References: <20261027191914.2341911-1-sashal@kernel.org>
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

Hi Sean, Paolo,

Ping. Did you get a chance to look at this?

It still applies to kvm-x86/next and to mainline, and the bug still reproduces
:)

If you'd rather fix it some other way, let me know.

-- 
Thanks,
Sasha
