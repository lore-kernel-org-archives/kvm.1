Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5433343C
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148284; cv=none; b=cpbflEOEoWXK7mvbc9r6Q2LceL8jXx1FYTq9/mgxPbNahkpRp3K0G9DSAy1ttuejNT1C7qlStmG61oMGhUcTejHNUY4OoBO0/uYdM98ykThw07PY/8jVYo3uPaQPPXVSGvAAqZ2YJKwnqy3v5qhS4hE3VaBnGwmd7cjmUxsQKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148284; c=relaxed/simple;
	bh=FSBoQYl9pKVX8kDbLQ9ev59hCVL1FSyoN047oWdFqAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5eHkzYPRJmYp2WW5eAmM8iP1LHA44r5seVNS378C0Hfgir9EQ2ancWZ6HWuSju9tunJPRLNq0IjpUwBILcV70TbrYhbinyw/0ehO2fBkpRb7UXsD/75YePgqHVYShAukIyYoq86Q/ay3bbvQ4KLt2sFhIZYoMUxfy0r6dFQ1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQYmZPve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQYmZPve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309C8C2BCFD
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778148284;
	bh=FSBoQYl9pKVX8kDbLQ9ev59hCVL1FSyoN047oWdFqAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iQYmZPveOlChILrXBaOikArVjvLHUif2Wm19E7Ugqe8rvhk4mbs4lq7FwrmeqRSwP
	 4z0pT5mkzz3hZinWJ6lpKJRmOSqIyBhF81sj3c5Hin91accm9LpDS5qDXj6c5G7Ist
	 Z5vnHmsX2uwSGG6oWF0aKUMz4H2HDQSoPRYwy7O5pCcmAjNFm1/N5wbERJxfkCwtWP
	 CTWUPSJyoCQJsjDcRFc/k4xNle6oMtnJofQ/5F6riKpVzzTA/sli/n3E3/HnO3Of7m
	 CfPvc1uGajnJGyl9+ce6hmQ6CQWWAUbuw7fcwL9CGPnXT/IaU7XWkm4Xiq9SBVUptv
	 1MokFMB9Y94vg==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4526a8170ceso355179f8f.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 03:04:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/bO2s5bkajlrmsZYPKB5SYZba4YqYmv0+xJc2I8L+oxRvskf/lyQsB7Lt9z7DYyN7KQko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7WFeVb4KaEpJSIfKA2aOWJF5LI51FBaDGOe0ni+RJEyRXldP
	4JYWy3mwJavxvwbJl3mB6b1aQ/2T3sp9uvkihgLy2KALoXlDV/zIzSTRJdZ3R0z4V0PwsUdMNiK
	AsaIXBl8infKxLwYHP9bDgDCa1p44ErM=
X-Received: by 2002:a05:6000:61e:b0:43d:7b90:fa23 with SMTP id
 ffacd0b85a97d-4515d4d0fafmr12396020f8f.29.1778148282572; Thu, 07 May 2026
 03:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425005916.3321811-1-guoren@kernel.org> <20260425005916.3321811-4-guoren@kernel.org>
 <87wlxhwr8v.ffs@tglx>
In-Reply-To: <87wlxhwr8v.ffs@tglx>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 7 May 2026 18:04:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRWpbqmbLcqX-CroOp_XsNGZxinxMEb8FEkBY-qJeniRQ@mail.gmail.com>
X-Gm-Features: AVHnY4Imjt2cNMxiqNS60LFeeQz6aivaWccZakhoucv_O_-tz8wElEbBRk3SQEg
Message-ID: <CAJF2gTRWpbqmbLcqX-CroOp_XsNGZxinxMEb8FEkBY-qJeniRQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] irqchip/riscv-imsic: Move nr_guest_files to
 per-HART local config
To: Thomas Gleixner <tglx@kernel.org>
Cc: alex@ghiti.fr, anup@brainfault.org, aou@eecs.berkeley.edu, 
	atish.patra@linux.dev, cp0613@linux.alibaba.com, fangyu.yu@linux.alibaba.com, 
	gaohan@iscas.ac.cn, inochiama@gmail.com, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, me@ziyao.cc, palmer@dabbelt.com, 
	pjw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 4:12=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> On Sat, Apr 25 2026 at 00:59, guoren@kernel.org wrote:
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > With the recent KVM AIA per-HART HGEI conversion, the global
> > nr_guest_files is no longer appropriate. Different HARTs in
> > heterogeneous SoCs may have different numbers of guest interrupt
> > files.
> >
> > Move `nr_guest_files` from `struct imsic_global_config` to
> > `struct imsic_local_config`, and compute it per-CPU in
> > imsic_setup_state() based on the actual MMIO guest file region size.
> >
> > Update the related comment to reflect that KVM now uses the
> > per-HART value.
> >
> > This eliminates the last global assumption about guest files and
> > completes the per-HART conversion series for RISC-V AIA/IMSIC.
> >
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>
> Assuming this goes through the risc-v tree:
>
> Acked-by: Thomas Gleixner <tglx@kernel.org>

Got it & Thx Thomas.

I think it'll go through the kvm-riscv tree because it's all about kvm
improvements.

--=20
Best Regards
 Guo Ren
