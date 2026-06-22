Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075239EF23;
	Mon, 22 Jun 2026 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123057; cv=none; b=aGip2V4VpX8ryh7rARfeVtd2hKAsBYvq4cQPp/rY+H93v8SPW/IoIf5ICIbsYEys/sAsw3hxBdNhs3FDgEde1LKY7nk2it8Xjk2ptJUwsCZAuPQR6QTVMXHKy2W/+8lC7uFEQaH+pZuZm602DD4RNK4+p8aYp/g2DJsrGJ2gMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123057; c=relaxed/simple;
	bh=qzjNbqgTQu78GAcE3V+utCvHGgcrEvvJ1e8fHmxJUCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QYEkNWTFT65QGVBSr4/2PlhCE6j2mAtMXfXnk+zyWMEl1ViHuQg1hLisW8gOjCCfu4xOBdQo/k1TcJLYYUBboIXlcC5by1AmnZYElnSJzZFoU+cLK+LGXaFwZfG6rPNcPfbTprIUyIDuSVmG7TYIIT6uGmC0fMs+fcvLvClon0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvtHi4Vp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvtHi4Vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4120C1F000E9;
	Mon, 22 Jun 2026 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782123056;
	bh=qzjNbqgTQu78GAcE3V+utCvHGgcrEvvJ1e8fHmxJUCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvtHi4Vpg4dj5ZyY8LJxauQc3h0apoqfnNn3gS+kgTAym+ipWrsh6Lgs/Rzxf4pCD
	 13kCgW77Kuel/QUzPWnouwQ+A05i62iZWnJngrmcg95U+4OlPrlSwvtpCzyGD/jy4C
	 JfKda3AdV9m2eovwI6hAxFudHUI7RAaFM6PmELOm4lhcNWeDew7sqmtdGEHG5AxKgz
	 fF9VwXl+LDrzKCHxzohGsLqZ4sjXRryDJTAlXEhulg51C/qAYcXB69tuQ9Tx+EKmf4
	 ANw5c7b0qePJSjKSs1a1Ll/1Bdmk66qwyrhwwH3lpvsXCKED+nHKhz/R7gho6+E8pT
	 2ogzr0ZBg8Q1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] KVM: VMX: Use higher-level allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, kvm@vger.kernel.org
In-Reply-To: <20260622-alloc-trylock-v2-6-31f31367d420@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-6-31f31367d420@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:10:55 +0000
Message-Id: <20260622101056.4120C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly states that `__alloc_pages_node()=
` allows passing `NUMA_NO_NODE`, while the opposite is true.
--

commit 7bd439c242125db27305b61b14c9972fb028282a
Author: Brendan Jackman <jackmanb@google.com>

KVM: VMX: Use higher-level allocator

This commit switches the allocation function used in alloc_vmcs_cpu()
from __alloc_pages_node() to alloc_pages_node().

> KVM: VMX: Use higher-level allocator
>
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the former allows you to pass NUMA_NO_NODE.

[Severity: Medium]
Is this description inverted?

Looking at include/linux/gfp.h, it appears __alloc_pages_node() explicitly
forbids NUMA_NO_NODE (-1) via VM_BUG_ON(nid < 0).

Instead, it is alloc_pages_node() that handles NUMA_NO_NODE by explicitly
checking for it and falling back to numa_mem_id().

While the code change itself is safe, the justification reverses the
behavior of the two APIs. Could the commit message be updated to
accurately reflect the API semantics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-alloc-tryl=
ock-v2-0-31f31367d420@google.com?part=3D6
