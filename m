Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701868;
	b=2LPlxdkx+MVKSPkksCyZ/k5V/Qg7ZESOse/sevSwJyTHlJzHTmv8WybmCrH++MRb2PQu
	 f37MijCCYKh8TTzpwf8wHye9kmX3kZGjxD3Ourbk1Ys0F2OemDBkgict1Rfx8cNTJWz0o
	 ovoQIdXBLiiNcQsEsMMsIzJA5gKquiLBABckg1iZmmZHcwa+M8YBuchd84rvBvU0SV7bG
	 a1HzzJeJGaddoemCJ+98phGy+uNYxQtleaP6+PCBwqn6zvpHpxejVCXBhUh0DTmx1mLCd
	 3H+lYVIN87jG1SgamQtu1CBl2L+8mCd02qSkNuhWBeGo1mTGPdwEdRn/p+ldNp6lHqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9iuFNDxRQ7BpfZLBoKEAQtTzT6oo5KrjNB2Uj0C+KDA=;
	b=Gt6W4pzLbph/Dz3ssMvXV1ZR0vz7px63nuG4TIuE4vXvxn+aOm6bvZZNru/tk5oEgnas
	 AYwQMW2sRGAfSX8ssgKeSOeHeuwDPAp9dYCqYD7jpJFdxcpPC/+LMEWAL/8M7/mtlRrxL
	 pkNm4l90/cgfGHQ/zaPdSon6CQZxHviFZfEww/95/+cDxE5rMShKixUu4YRP9ib+XIko3
	 bVXmrbKSV8XfW4jdCD254zHkTYZeTOsm+B6vmdRQbx0sOFoSvTtQ0asUi2EqQHHmIz6ma
	 fMBF3mKXaY7KJPMFpQ/uxwtc2om+snf38T98HMhSl6ViuxCdt2OWSDSuPjEIF1DTKxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdHHrmN3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1311606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdHHrmN3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B831F01825;
	Thu, 22 Oct 2026 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701867;
	bh=9iuFNDxRQ7BpfZLBoKEAQtTzT6oo5KrjNB2Uj0C+KDA=;
	h=From:To:Cc:Subject:Date;
	b=EdHHrmN3zUJKG0Kk3Tvjz3liiM7yTYNJG3VA0ycMlzfG+qU04YP9DfKgTAie6ZhVP
	 wfPy8rI74qh7yiXZXQV6TDViAonjp5r20JkAqUplOOSxOnartNgfu6UWYLOKXw462q
	 2QqBYe2RAe0vPzRFYJw9+4A1kz/dkzvcwzaJeLiDWjdqb2yKC1KvL/4MirKdAG+FM5
	 30nvrtvr7d3RgtPVS0ABDmnJLHkSLVjnFHVdYjE6lUJcp5VcuJfkSpaLLAPAPcJCBy
	 E4Jibafw3YaNaBjEPXdUgZo/zRVRnmCk4QgyqKiSuQ/j8IEcNNHMDW1M35L77kebiF
	 h2ylXlPF4ds9g==
From: Yosry Ahmed <yosry@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Andrew Jones <andrew.jones@linux.dev>
Cc: Greg Thelen <gthelen@google.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [kvm-unit-tests PATCH 0/2] Fix Clang 24 -Wunused-but-set-global warnings
Date: Thu, 22 Oct 2026 20:44:11 +0000
Message-ID: <20261022204413.856786-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
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

Building kvm-unit-tests with Clang 24 fails with -Werror due to the new
-Wunused-but-set-global warning flagging static variables that are
written to but never read in lib/chr-testdev.c and lib/x86/desc.c.

Remove both unused variables.

Yosry Ahmed (2):
  chr-testdev: Remove unused in_vq
  x86/desc: Remove unused exception flag

 lib/chr-testdev.c | 3 +--
 lib/x86/desc.c    | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)


base-commit: 5a221342a025948fa7d84f0c404748f6ba57f3ad
-- 
2.56.0.257.gf7497c7d27-goog

