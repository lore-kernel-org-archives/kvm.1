Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2FE486BA2
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283711; cv=none; b=NxrdN8X4lptxaLD7Lb/eW3LF5hIKEjaVa6MyyRDyKVD4HtUZ8/opJ/P1NN9mvGl4SYEwIrwrK7hg9n3BomKqAJmi4jzPVOxH90K9ooqqjmKe/CcY53LFJsW81m5a9nzfn5uBB1PtfL+5JNYP239ECgVedAn+rOLNIgGWxpZH6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283711; c=relaxed/simple;
	bh=/8akLwfs1o3i5XMdCX3/5Zu0HCQoB5fVGW3Pkg2xb8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V9GUS7sCeQsVWeNpV6Ax5xNpTA4uybqoYjUOAgveeruEPQcc97nqitB/Q76f4mYm75nQ9bG/o+UEJbVWGYiWPDodIkQMMgTkOesMb5a5kHAbGoIZpVCGMywabC4NI62mJcS4eRxWrOnevOECY4L06+jdwzIbEUjnymduyPzqlco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VklgPQxN; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VklgPQxN"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cee1ec30f2so244725ad.3
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788283709; x=1788888509; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pee9EJDo0yrD1zKrHbFb5B2Qg/13RIff1y5Ve46Cj+8=;
        b=VklgPQxN1CCYtaNNxKMPvJb/zGAbVZeI0uPkNo0gwIhxFYWCEnZEuSOnuN+Uxr6eP1
         QBkBQeXJki953L2CPfJuos3o9NaOzvT/F8lb2G8HInu0PYgYET9wg6ZYRmFd9vxh7kij
         Bli/e06iUUbzJMlbojHoo0+EHhpftEORdkGLrvCAoPs2MM+17OJz5D4SAYGlCHWD12Fc
         SrZ+IA+tHF8QYiq6877neqDvJtK2hFYNJs3CIuUxdZZ8EPJfU25C+oV+kdKqDh99S++u
         8XnkSQH22PVRBSMo/C6KHlMbGQfnltMOq8EF8a9zMV4lYrHPqJA6mPRwQNBpNo+heoRb
         cPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788283709; x=1788888509;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pee9EJDo0yrD1zKrHbFb5B2Qg/13RIff1y5Ve46Cj+8=;
        b=hAg9FQIwtC88u/dPQ7AH23RgTqOLihU/1AdYZMoiput8ylxGPcXwdjZQHMZ+p3TXpL
         kYU97PFZ24tPBOamrqbRBO5NsmCDeSQFdL8jdQQljDxlJQ71hov18JWnnqK8Xd/oln7Z
         MTqLLXPVlxfPj9RiPNKlQrmJYc9tzHjogBwOZVhZPW2uG1G8OyXCG10hS8LM2NA1ZtPS
         NY1DhXqPnOA7tXy6lmwAoo2L4Cll3q3Is+wtRbXFmrOVAYkhtQPKuXVgFaMkdBEo5J8O
         ONTINBhLwhUne9ORNfSnRGtz6NVTa0p/ouWPvEhJSBhwOFcPuj9sMe2N8DkO7eca6NEM
         Bmtg==
X-Forwarded-Encrypted: i=1; AKwUvBxblyNlxaCIdB+GGhEUs2Om5xKLHekjvfteLc2+0ZM4mjda6mIdGcZf10g2omYAouaPzFY=@vger.kernel.org
X-Gm-Message-State: AFuF++kkY/eLrzdMXYYY7pUiSnoSTB/Atui4g3C0qdGOD8FqFxsWo/Jz
	hz41nRkE0kQxUqtxUe/WAGu4Rn+1hpxXWW75C3O+BDT84NWVRpUs59jt8u7llz/v9W6au2Pp+19
	wguOn1A==
X-Received: from plgf1.prod.google.com ([2002:a17:902:ce81:b0:2bf:8db:4516])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0d:b0:2cf:ca89:499d
 with SMTP id d9443c01a7336-2d74def3ffcmr583168435ad.7.1788283708888; Tue, 01
 Sep 2026 10:28:28 -0700 (PDT)
Date: Tue, 1 Sep 2026 10:28:28 -0700
In-Reply-To: <20260901-gmem-selftests-fix-v2-4-5a273153354c@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com> <20260901-gmem-selftests-fix-v2-4-5a273153354c@amd.com>
Message-ID: <apcLPJerTWENV6iD@google.com>
Subject: Re: [PATCH v2 4/4] KVM: selftests: use allowed NUMA nodes in guest_memfd_test
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>, 
	Ricardo Koller <ricarkol@google.com>, Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 01, 2026, Shivank Garg wrote:
> guest_memfd_test assumes that nodes 0 and 1 exist and have memory.
> is_multi_numa_node_system() only checks that the maximum node ID is
> nonzero, which is not enough for sparse or memoryless nodes.
> 
> Select the required nodes from MPOL_F_MEMS_ALLOWED instead. Use the full
> nodemask width plus one to mbind(), and let test_mbind() run when only
> one memory node is available.

Please split this into at least three patches.

  1. Refactor guest_memfd_test.c to prepare for using nodes other than 0 and 1.
  2. Fix test_mbind().
  3. Fix test_numa_allocation().
  4. If necessary, do additional cleanups in numaif.h

As is, this is extremely difficult to review, e.g. without staring intently, I
can't tell what's refactoring and what's actually a functional change.

Actually, looking at the xAPIC IPI test more, what you proposed in patch 3 is in
the general direction of what we want, but needs to be more than just a wrapper
for get_mempolicy() to be useful.  Specificaly, if it fills the mask *and* returns
the number of nodes found, then it's more generically useful.  And if we also add
an API to get the next (exclusive) node, then we can cut down on the amount of
copy+paste without forcing tests to use the "array of one-bit nodemasks" approach
that the xAPIC test uses.

E.g. the below get_numa_node_ids() is basically just copy+paste from the xAPIC
test, except that it returns an array of nodes instead of an array of nodemasks.
The fact that you felt compelled to copy+paste instead of adding an API is quite
telling: using an array of nodemasks/nodes is inflexible and really only works if
a test wants to target exactly one node.  It's also annoying to extract to a generic
API without ending up with a brittle API.  E.g. if the API where to take the a mask
and an array, it would either have to be a macro or take a struct to ensure the
array can hold all possible masks.

I'm planning on adding these in the series to also add MAXNODE_FOR_MASK().

static inline int kvm_get_numa_memory_nodes(unsigned long *nodemask)
{
	int r;

	*nodemask = 0;

	r = get_mempolicy(NULL, nodemask, MAXNODE_FOR_MASK(*nodemask), 0,
			  MPOL_F_MEMS_ALLOWED);
	TEST_ASSERT(!r || errno == ENOSYS || errno == EPERM,
		    "Unexpected get_mempolicy() failure");
	return __builtin_popcountl(*nodemask);
}

/*
 * Return the node ID of the next NUMA node in the mask, starting at @from+1.
 * Guarantees a node is found, and that the found node is not @from.  Pass -1
 * to find the first node in the mask.
 */
static inline int kvm_get_next_numa_node(unsigned long nodemask, int from)
{
	const unsigned long nr_bits = BITS_PER_TYPE(nodemask);
	int to;

	to = find_next_bit(&nodemask, nr_bits, from + 1);
	if (to == nr_bits)
		to = find_next_bit(&nodemask, nr_bits, 0);

	TEST_ASSERT(to != nr_bits && to != from,
		    "Unabled to find second NUMA node (from = %d, to = %d)", from, to);
	return to;
}

> The sysfs helpers for finding maxnode are no longer needed.

This is an observation, not a proper changelog sentence.

> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  tools/testing/selftests/kvm/guest_memfd_test.c | 86 +++++++++++++++++---------
>  tools/testing/selftests/kvm/include/numaif.h   | 52 ----------------
>  2 files changed, 58 insertions(+), 80 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index 2233d871a38f..aee80dda6229 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -76,33 +76,53 @@ static void test_mmap_supported(int fd, size_t total_size)
>  	kvm_munmap(mem, total_size);
>  }
>  
> +/*
> + * Fill @nids with the first @nr_nids nodes in the allowed mask.
> + * Return false if the mask contains fewer than @nr_nids nodes.
> + */
> +static bool get_numa_node_ids(int *nids, int nr_nids)
> +{
> +	unsigned long nodemask = get_numa_mem_nodes();
> +	unsigned long nid;
> +	int nr_found = 0;
> +
> +	for_each_set_bit(nid, &nodemask, BITS_PER_TYPE(nodemask)) {
> +		nids[nr_found++] = nid;
> +		if (nr_found == nr_nids)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static void test_mbind(int fd, size_t total_size)
>  {
> -	const unsigned long nodemask_0 = 1; /* nid: 0 */
> -	unsigned long nodemask = 0;
> -	unsigned long maxnode = BITS_PER_TYPE(nodemask);
> +	unsigned long nodemask, bind_nodemask;
> +	unsigned long maxnode = BITS_PER_TYPE(nodemask) + 1;
>  	int policy;
>  	char *mem;
> +	int nid;
>  	int ret;
>  
> -	if (!is_multi_numa_node_system())
> +	if (!get_numa_node_ids(&nid, 1))

This is not functionally equivalent.  The existing test requires multiple NUMA
nodes, whereas this will now succeed if there's exactly one node.  That could be
totally fine, but it needs to be isolated and explained in its own patch.
