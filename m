Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5404A362138;
	Thu, 30 Apr 2026 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777524432; cv=none; b=ZjDGKvqqeAYAh+N0El25I44V79M9zF2kZFAAhzJl7iR1Hhcu0FuvjgFYuORjxkgH/AJRo4YaG0nNyaTee+VgCHVGIEQLnup7RlHYpnemz58wwHZfhXlBcrdFrkdwFU95bWiR4b7JhLKXNHGu47KiOPEnpwksJpXU4TSVhLGN+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777524432; c=relaxed/simple;
	bh=E/yh7MssMqbKR24sqcd/16bJQwoqXO9idoUrqSRK92E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCZ85269bV72fW0ptIr3wgVpjbqtnPqKP9YZ0Rsx28sAcQ1OS5JjKZfwwg4DuVAn1a2m1gPUiW7w61zb13HZomdjzJ7dprlklk/0jFstyUcrpUjvKwBu3rjFzk2MUF3JdrPnzAo7HNYipAXVpYMmw/Rhx9LEgfXjsn8YraXXE0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqT6uRgQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqT6uRgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F372C2BCB8;
	Thu, 30 Apr 2026 04:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777524432;
	bh=E/yh7MssMqbKR24sqcd/16bJQwoqXO9idoUrqSRK92E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqT6uRgQeiMgV6LaXGJpu+ONELl49SC1EESjimSweN54pm/XOyeUMK3m8LaD1GWMo
	 LqyirD+d0LA4s8Sf59sVojGYlYUx+kuWYJtcKuhpTxJuScImz54+YifA+yrUPoCb73
	 yS8wkF9qtOED4THBT5voqlNs/EzTm7dlaBBimJmnNp8ZIvu/8d1RVlSEl+R8KMrfq2
	 9WGb+aOyqTYy9sE0DJWFIgLnFRZtaq+L1vzivbh7tvKMpjLedrUQguWpjf6TjvEJuy
	 3LlTyJxkrH7CM9wVks8DBi282OwhAGAdDxtnoN9yHOoD2gsAw4QtIoPPQ4BtzAPyDD
	 8t0UkHsCtZLxQ==
From: SeongJae Park <sj@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	david@kernel.org,
	ljs@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Liam.Howlett@oracle.com,
	ziy@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	jthoughton@google.com,
	aarcange@redhat.com,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 01/14] mm: decouple protnone helpers from CONFIG_NUMA_BALANCING
Date: Wed, 29 Apr 2026 21:47:02 -0700
Message-ID: <20260430044703.77862-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427114607.4068647-2-kas@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 12:45:49 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:

> pte_protnone() and pmd_protnone() detect present-but-inaccessible page
> table entries. This capability is useful beyond NUMA balancing — for
> example, userfaultfd working set tracking uses protnone PTEs to track
> page access without unmapping pages.

I agree.  It can be useful for general access monitoring.  I'm also slowly but
continuously working [1] to use that for DAMON.

> 
> Introduce CONFIG_ARCH_HAS_PTE_PROTNONE to decouple the protnone PTE
> infrastructure from CONFIG_NUMA_BALANCING. The six architectures that
> support protnone PTEs (x86_64, arm64, powerpc, s390, riscv, loongarch)
> now select this option, and CONFIG_NUMA_BALANCING depends on it.
> 
> No functional change — the same set of architectures continues to have
> working protnone support, but the infrastructure is now available
> independently of NUMA balancing.

I think this is a good change for making the infrastructure available for uffd.
I believe this can also be useful for making it further available for general
access monitoring purposes.  I hope this to be landed on the mainline sooner
than later.  Thank you for doing this, Kiryl!

> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

Acked-by: SeongJae Park <sj@kernel.org>

[1] https://lore.kernel.org/linux-mm/20260218054320.4570-1-sj@kernel.org/

Thanks,
SJ

[...]
