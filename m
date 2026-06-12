Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB7282F06
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276924; cv=none; b=H84yBKKsbafw+/jtV1uYExTtfLpI/e4onA6tO6OEnEqgM0ZsYPRJDbTn4+V2pS3yOlEtqcIsYoihunpvuoCSLlEWUWGCQqIGPuIz+RUiL2Q7F09s+QDIr7t/LYQXgNaooSM52YRFUyAkNYKkt0l62zAxKcsRUGTIUjXXWxyFla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276924; c=relaxed/simple;
	bh=HyZCvPVwDpO82HNjw8rLCqZtmo98bxPdTq6hXbBEUgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C1cgez2ouN1j8narXCb0hb9reZqCdeNWI766db7/hXBaZ93E/6umpLP4CEZuCvo0rIZtH0Bo7f6sOaF2Fq6bfSuZTPgQbwtrHaJzbzEj9tFysLkElNE67JdLCkwklvU5zBSVDNwl1edHeFzWEQLbC+FTystsjcBdS9RqTyD4fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCamFHUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCamFHUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9ED1F000E9;
	Fri, 12 Jun 2026 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781276923;
	bh=lO8rAWMWuA/CzujNEG1X3Las3uGV0CyJgiaYAsVC6HM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCamFHUWx5X0KozUi57VZ17M/d3vEGeNPKQEBR8TWxure/rA7+I4cKnAaVVmXqCiK
	 ALgW0iTa2azVsl3FWFK/Gb2b/f8t29VvOwO0wAPbc+T4ibgrfdz1gkJWl4/pIg8+CT
	 C6XXinzQplFkfLhPcnLKww8eJxEMZPBojqI5Le6M/fQBv51l55jrI44+qR2iwubDGN
	 nJuwUt3px1UszansZW0WUnZFdJuMzwsuX5L/XRdceSpabbkcifAu9e3hC8fCVu0a2u
	 SxQzYiRJJKd5YKNxJQO58dpKbrgiQjN3dS93sJk9boed6w9ulGit4pGkDbwRxLJ3YX
	 W8Lvwdhd1T4/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: access_tracking_perf_test: bump number
 of NUMA nodes to 32
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612150038.1277394-1-mlevitsk@redhat.com>
References: <20260612150038.1277394-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 15:08:42 +0000
Message-Id: <20260612150842.DF9ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Incorrect type for `asprintf` return value defeats error checkin=
g and causes undefined behavior/crash if allocation fails.
--

commit c131ebf5598f598f5bdd7d212b93b7da852ad82f
Author: Maxim Levitsky <mlevitsk@redhat.com>

KVM: selftests: access_tracking_perf_test: bump number of NUMA nodes to 32

It's rare to find a system that has more than 4 sockets, but a system can
have more than 4 NUMA nodes if each socket exposes its chiplets as separate
NUMA nodes. Bump the limit to 32, just in case.

> diff --git a/tools/testing/selftests/kvm/include/lru_gen_util.h b/tools/t=
esting/selftests/kvm/include/lru_gen_util.h
> index d32ff5d8ffd05..49c8139d398ca 100644
> --- a/tools/testing/selftests/kvm/include/lru_gen_util.h
> +++ b/tools/testing/selftests/kvm/include/lru_gen_util.h
> @@ -14,7 +14,7 @@
>  #include "test_util.h"
> =20
>  #define MAX_NR_GENS 16 /* MAX_NR_GENS in include/linux/mmzone.h */
> -#define MAX_NR_NODES 4 /* Maximum number of nodes supported by the test =
*/
> +#define MAX_NR_NODES 32 /* Maximum number of nodes supported by the test=
 */

[Severity: Medium]
This is a pre-existing issue, but does run_aging_impl() in
tools/testing/selftests/kvm/lib/lru_gen_util.c mishandle the return value of
asprintf() when creating the aging command?

tools/testing/selftests/kvm/lib/lru_gen_util.c:run_aging_impl() {
    ...
	FILE *f =3D fopen(LRU_GEN_DEBUGFS, "w");
	char *command;
	size_t sz;

	TEST_ASSERT(f, "fopen(%s) failed", LRU_GEN_DEBUGFS);
	sz =3D asprintf(&command, "+ %lu %d %d 1 %d\n",
		      memcg_id, node_id, max_gen, force_scan);
	TEST_ASSERT(sz > 0, "creating aging command failed");
    ...
}

asprintf() returns an int which is -1 on failure. Because it is assigned
to the size_t sz variable, -1 wraps around to SIZE_MAX. The error check
TEST_ASSERT(sz > 0, ...) will incorrectly pass, and the code will then call
fwrite() with an undefined command pointer and SIZE_MAX size, resulting in a
segmentation fault rather than a graceful test failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612150038.1277=
394-1-mlevitsk@redhat.com?part=3D1
