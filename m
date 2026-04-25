Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96211CAF;
	Sat, 25 Apr 2026 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079179; cv=none; b=hTvQXIawwQeYC1IQR/i26zT6uhmF+ab44xbAFaa2gpcNYT5nhTG6ZoKhmSAATA+W8rYE1ojwfreH6bd6F3fr4JrFpqBgVAsqsIZfSRefz95OL6G2AGrg0TN84sz0pXg7xI4dv1UUw0PC49cJ2UCfJ5O02nTRQya6HE1xiD6y3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079179; c=relaxed/simple;
	bh=v6TTWDx8y13lbMK9v0dMxzlyEZMB61u6UeeQLu+kS7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akeTzSFHxa5twhsYjx7SWlU9Idl7cyqBIpTy+t65kthlGO8iWZgJlkasvRhquy5fL+Cxcp+j9X+jYI9b+X7x82AvdWQQnQ120Mr5uwG/9RCM32EVgwR8Q7mR+ppfBhF5oUMwZ9XTJ5RWIu6gzdIU9b5gIiMWvrkkzLIZbZXZU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6gMX2V9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6gMX2V9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20170C19425;
	Sat, 25 Apr 2026 01:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777079178;
	bh=v6TTWDx8y13lbMK9v0dMxzlyEZMB61u6UeeQLu+kS7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6gMX2V91tEk1P5uAwjQg8ks2apnyaD7defQMsAgj4LngklvwnnMiGt8ZoJRTWek5
	 3LBjPHdQ8vgxc6lt14gCyF7Cz0tXpFtMHIpXJjeqwxS9GkWhTgqOdQT5NzCeOESjm5
	 F3/Dt0CX2Ln14Q+zl9TLA+M9dTOpjM7T8pgu5skqjn8yWuda1j0KhgUQjUk7cHer/u
	 BefQPh6K8RPa1hgkqzhfiyABJkLaOKSYbN8ib+iF3UBhfFBObY2IAAeYKR8UJqdUtW
	 lxq5jXc6fjkV7S3NCEROCNF1ySPIzXAOCTc1pEQhl8hE3l0vxC7dIfK3O89GrmPjBM
	 GxefZy0CGj1wA==
From: guoren@kernel.org
To: guoren@kernel.org
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	cp0613@linux.alibaba.com,
	fangyu.yu@linux.alibaba.com,
	gaohan@iscas.ac.cn,
	inochiama@gmail.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	me@ziyao.cc,
	palmer@dabbelt.com,
	pjw@kernel.org,
	tglx@kernel.org
Subject: Re: Re: [PATCH 3/3] irqchip/riscv-imsic: Remove global nr_guest_files after KVM AIA per-HART conversion
Date: Sat, 25 Apr 2026 01:06:07 +0000
Message-ID: <20260425010611.3322320-1-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425005916.3321811-1-guoren@kernel.org>
References: <20260425005916.3321811-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Anup,

> On Wed, Apr 22, 2026 at 8:39 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Hi all,
> >
> > This patch simply removed `nr_guest_files`, which is suboptimal. For
> > v2, I will keep `nr_guest_files` inside `struct imsic_local_config`
> > (per-HART) and compute the effective HGEI count in
> > `kvm_riscv_aia_enable()` as:
> >
> > min(hgctrl->nr_hgei, lc->nr_guest_files)
> 
> Yes, I was going to comment the exact same thing. Good that you
> realized it early.

Thank you for the feedback. This is V2:

https://lore.kernel.org/kvm-riscv/20260425005916.3321811-1-guoren@kernel.org/

Best Regards
  GUO Ren
