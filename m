Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8811CAF;
	Sat, 25 Apr 2026 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079277; cv=none; b=fbt+hIlB3HSQ4gQj9vG/YMf/JeYq1mOAePr3XbyUiqULxNOkJGWGJYrV4Zgi0h6T6C8GirdzfnspJ0kxCWs+/MaVousF0ME1EL8K6Taf645isFzevlwMzVChffqaZRjv8Podwtp5spOBtLE52a3FU3Q9MwKtlEwDsRz4udReDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079277; c=relaxed/simple;
	bh=v6TTWDx8y13lbMK9v0dMxzlyEZMB61u6UeeQLu+kS7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZPyj2rd0S9iEliTxnwojy0XDJF+VJs2bkU3RXyw2HjAf1Kz4GGm8/MHWVBisSXjaUll4IplOaob+nZuOO5nLJIg+hITVwS1ld/3WETveceBuHGHgc6QRNT/HASlkXx6k+3NZkem3HSoIiCGhSDYXqth9TeQZHOwA32Qo33JvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlhtXKH0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlhtXKH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7A8C19425;
	Sat, 25 Apr 2026 01:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777079276;
	bh=v6TTWDx8y13lbMK9v0dMxzlyEZMB61u6UeeQLu+kS7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlhtXKH0EVFKOmlfv1FSUM+pB992ZoOzPQvvQdkG9ATMCBSmxDqKSjCy2RxKOswqV
	 6UcnoCZfnEZ1j397uONDgWa6+8yhPN5WIvgmUio4ja9q6T8/m32ho7cngG5YcvJQNg
	 In75JQpWNI4/632P40A64yUbH2CiSr2BtKUo3EBuRZYVtZ29jOW3Hc2EK+tR24OMRA
	 pCmxvxsn3HnPvt/hS6AK7BJwTQDh0XTv4Ui8/xNDis6khjpVKeLnqqob64LjqShpPy
	 go/2aG04ydp2ndOYUt2F885tYnszBajCIMlmKn6rtvjoP6p7l7XdBwWToNZDTLtSsF
	 vSICW1jZ3te1Q==
From: guoren@kernel.org
To: anup@brainfault.org
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	cp0613@linux.alibaba.com,
	fangyu.yu@linux.alibaba.com,
	gaohan@iscas.ac.cn,
	guoren@kernel.org,
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
Date: Sat, 25 Apr 2026 01:07:41 +0000
Message-ID: <20260425010750.3322337-1-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAhSdy2RBs15ndXbUMs=k7fw8CH_5+b9k=+o6SNzxpvb-YKDig@mail.gmail.com>
References: <CAAhSdy2RBs15ndXbUMs=k7fw8CH_5+b9k=+o6SNzxpvb-YKDig@mail.gmail.com>
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
