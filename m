Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2393876BF;
	Sat,  9 May 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330843; cv=none; b=jFuWGYLJv01HlWJJGao492DQnqBF1jZxmE9Fkcnv14laK6fTtxfjpp0DNea17ysSq8OigDzsMgsPpx6G7TORj0Fy1AhdXxLVY3P+PHeuHuoV04lGZHfr4M25kUqy+Ff8R/S5V6y9L3JfC6F8DM1XDq51ysT55MEt5QdnzkUtqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330843; c=relaxed/simple;
	bh=6/b2OkitxMNFYu9enV3cVh7wspN7m5hqEO5MR09RNDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKf48kXRtRBbvBaxPdBtTUvHYtzlNYcJuijxgDl8Eqi7rzosF4uc6wSVi4OD5FpaKZH0dZJyr40yLW3WAL9PmZxeMq58lGyBzn4VRe12BEIZgRBr+E9y8O/OOY/I4zD6ZbFKn9RzAMeMLa0/y42jeQxrQBFJ6jzMapHqOPwE9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5FQ9dEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5FQ9dEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3366BC2BCB4;
	Sat,  9 May 2026 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330843;
	bh=6/b2OkitxMNFYu9enV3cVh7wspN7m5hqEO5MR09RNDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5FQ9dEbS5M4Q1nqeTgdPYgrwKNw96oL0oZ1skBmkeIBvMrhbMCL67A5Ejxvrji2s
	 BG+bXUAt6hZle/vyk7PiUkKCLY5CmOWxtDtrITc61HZHxV6nUJW3/qb5VedN1wJwC+
	 nYW3Zj7qEdvCQyCIchXzwouvBB5fUf9+/yAmS7lIegSRsDRjuaziqxDOb+4cxjyk5+
	 XyXagZcPET7iEnYnGPWMF+FQb4jioABC5yY4X8sUi3I7zciVkc+R8DhF97zhSRhexR
	 i5XCEQZm93rFxHNSibAL5uQg7yGDeS7HOokxfkN2CjTCOIo3gJB/xNZCX+2avmIEIt
	 mXfr7+KnS3bXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Sat,  9 May 2026 08:46:47 -0400
Message-ID: <20260509122858.8afe43a9c80b.re-kvm-x86-shadow-paging-uaf-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505065857.190809-1-pbonzini@redhat.com>
References: <20260505065857.190809-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Queued for 6.18.y, thanks.

--
Sasha
