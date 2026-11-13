Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587626;
	b=Leq/HU1iKq83Sm/KH02/t6zPWMyZyMjtPlu0JKILai1Uf4sLPnBu0wFMFpNeR06bFMMF
	 Zw5gWjl1rJ1bihXERnrIEiJSPBjZP4MPVZKaGCH0B2K7XGuWP/DrxUxTSDF+G84vYt8F8
	 6orXIs8Y1/egi3eBCwFfKNfbg+y1gkS0RPHXylvKN67rcHLqhzN9cI/3lMY0etyevjPV2
	 C3seLLSVqu99AgXQoYEoXU8jonbnYcwFYGGxgJ1hIZ1XoiXu4PuxMd3uYjVbMgT7WOjVn
	 /JOmJAo3MGPUHIn7Bwggn/xwuDV39x5TzyAUbIF/maZPvCNuKrgsyve71oNMNlGbTMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587626;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nDY6g8wwhcMLyuBhzmb8DN6IMJlPgJbqFNtxYZnN9Z0=;
	b=Lo3i/jHGsfaiH3L1b9B0cqVmZV2pq/euOiiLoXNdWPBKnT6udSRluUvlgo/tWnfzTGW6
	 han5YG9zaNer+uzVmFmgZ5b/R8endcGtKiZA2/EhtBU+vn7loktdo1X1yP+VPrUeHjH47
	 tuTJLl7ttlFVjx6jVvzzry67qY1KGb2lIepIad0sCSK1aNXjhlBu0fW2wjh31nsH5KZmD
	 MZGgznv8hDv9CdL1wf07UMIEpO4kJp+JkeQCqcjPOfYf+sLPVJQK0ypcwI3zxGiwv+Bjx
	 auUoU+6TpF3wk0QFrTnphV/NviCH9/BxSDsdD+JoUiMCYPqMcjf2WIuo1ML15HH68AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXZqP3Px;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11206606A327
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXZqP3Px
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FDB1F000C4;
	Fri, 13 Nov 2026 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587625;
	bh=nDY6g8wwhcMLyuBhzmb8DN6IMJlPgJbqFNtxYZnN9Z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXZqP3PxV4bgLbFfUBAVtDFM8VQmCVnAXyvI6+7vbBiEC7trFloxatyjbjFQEoidv
	 OFy9Fd7ZPj7ivh9k4E2iXjcYUJWpietFzAVohXWLq1hTEiCG0UNmBt9MvW7kUSeDMp
	 NxDc9qCGpysJ1iWlhfwIvwzvgFW3vuR7oY498XDN59Tf1U54NzN8Gos3zoOHeQPnEk
	 3N1GsFxECokk7il5MM1i7/irNbHRG7RQ5uFNhbxgeoKjVTNVoKC1N4QiwAGPbqmgp6
	 66CSq4h2iPmehdgERJEA0kvuPsGn9LEtsiqVLX7b0NW1+7pQqXW9ks0iqB1vcuggC5
	 cEKWH/KyT32Dg==
Message-ID: <sashiko-outbox-213200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: SVM: Sync CR8 to the local APIC after marking the
 VMCB clean
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113162556.461390-1-seanjc@google.com>
References: <20261113162556.461390-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:33:45 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] KVM: SVM: missing Signed-off-by trailer from patch author
--

commit 233803838af902e26ce77bf3e6c981b3c2991bd9
Author: Chris Oo <cho@microsoft.com>

> KVM: SVM: Sync CR8 to the local APIC after marking the VMCB clean
>
> Sync CR8 from the VMCB to the TPR *after* marking all VMCB fields as clea=
n,
> as syncing CR8 can toggle the CR8 write intercept and thus mark INTERCEPTS
> as dirty.  Clobbering the dirty bit can result in KVM failing to detect C=
R8
> writes if the underlying "hardware" uses the clean bits to optimize VMRUN,
> e.g. when KVM is running on Hyper-V.
>
> Failure to intercept CR8 usually manifests as hangs when running Windows =
as
> L2, as KVM's view of vTPR stays high and so KVM never injects pending IRQ=
s.
>
> Fixes: bb365a506b1e ("KVM: x86: Unconditionally recompute CR8 intercept o=
n PPR update")
> Cc: stable@vger.kernel.org
> Cc: Carlos L=C3=B3pez <clopez@suse.de>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Not-signed-off-by: Chris Oo <cho@microsoft.com>
> [sean: rewrite changelog, massage comment]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

[Severity: High]
As noted below the tearline, the patch author's Signed-off-by trailer is
missing and currently listed as Not-signed-off-by.  A Signed-off-by from
Chris Oo <cho@microsoft.com> is required under the Developer's Certificate
of Origin before this commit can be merged.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113162556.4613=
90-1-seanjc@google.com?part=3D1
