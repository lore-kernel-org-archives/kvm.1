Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70B23ABAC
	for <kvm@vger.kernel.org>; Tue, 10 Jun 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563944; cv=none; b=fvaNEol4D0BinIGbTienA7gc0su7QLlsOZuDQdG4Tu8IMdJpkQJAH5VklVpWRZap8p71ShlxlYj9iJFn1jB0DmCPon7n/nwLkd/i0B7V5jBwnGjIjG/MvTqhIU/Cwyn6VoA9HfXpwccqwEnBS+Fo71m2zphCYSav/l3Vp6UQOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563944; c=relaxed/simple;
	bh=PAc9EymMF47hp9whtcEgaTN4Zfpyy44xlB8+cQbv1gY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=agwAHqNiWc/GZYLC6/Mt0LBTXqCUz5Oo5dQz3DY3acuAYwxTKMqPH6KHA3KtIZ24ypYeeM6GA5vhHjH3R7o0FCxpmgiIBGEpJnGGySDk4Oqoj/t1mns3zNKST9sPhhgMTG8heETmAJBk8bba1zN/XOHUoo2zMMKqx88o/EByb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kinwa1Fq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kinwa1Fq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBE6C4CEED
	for <kvm@vger.kernel.org>; Tue, 10 Jun 2025 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749563944;
	bh=PAc9EymMF47hp9whtcEgaTN4Zfpyy44xlB8+cQbv1gY=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=Kinwa1FqIsDAiKosu4jkH6udtE1k64B8KrWkZ/gt8zdhHAuUcl51MiqQlkqZi7HBK
	 oVc91/AiisJeY+47b95mmyRKHJ4NBvzalRxzTTSi+SMsYb4PptHnKjJ8zFlpOtnhd4
	 2O51EeMWVZbsYjWFTK8iECbeLC2kHiQklNnUwFriUbn0eUm1OZHJpMJszKbwuHjag3
	 tyaA0eIq9a5C5Yymjl9r9A7Ya0+tcOUNOPVVGmZIJWTPsINXmFC6ropizwPgs+Qubf
	 Jw+04VAXWZuzsF6HWxSN4M4vyIYgKtxVwcuqDIbv0dLR8IL6OubWXTgxli1KsewqE+
	 iamlFVLJgQBvA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 Q)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool v3 0/3] cpu: vmexit: KVM_RUN ioctl error
 handling fixes
In-Reply-To: <20250428115745.70832-1-aneesh.kumar@kernel.org>
References: <20250428115745.70832-1-aneesh.kumar@kernel.org>
Date: Tue, 10 Jun 2025 13:31:17 +0530
Message-ID: <yq5aa56gkotu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Changes from v2:
> * Fix smp boot failure on x86.
>
> Aneesh Kumar K.V (Arm) (3):
>   cpu: vmexit: Handle KVM_EXIT_MEMORY_FAULT in KVM_RUN ioctl return
>   cpu: vmexit: Retry KVM_RUN ioctl on EINTR and EAGAIN
>   cpu: vmexit: Handle KVM_EXIT_UNKNOWN exit reason correctly
>
>  include/kvm/kvm-cpu.h |  2 +-
>  kvm-cpu.c             | 30 ++++++++++++++++++++++++------
>  kvm.c                 |  1 +
>  3 files changed, 26 insertions(+), 7 deletions(-)
>
>
> base-commit: d410d9a16f91458ae2b912cc088015396f22dfad

Any feedback on this?

-aneesh
