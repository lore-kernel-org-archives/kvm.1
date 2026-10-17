Received: from mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F38480354
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792240152; cv=none; b=OLts96abTBEq5MGvYyfyugscBKO6bo+2Fm0n2SXYvFp1819xVtC3OikjxF9ReYoYXdL9OZIdBFIiKo2qnNddRbwNSSLx7RrADkuGn9iYWNiHN8cv2GaWgiuB6JQd09qvmvFAHr7OTW3RK9M54PilPkuOn4icGj9KRArTtGT6Se8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792240152; c=relaxed/simple;
	bh=7cgiKM+zDuDnTZJRzu5yT4bUih3KcyLUsgr/rzH4uiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGYjjt8zZyft9QzWr4a3pVlBoPrtHgJ9bMtqlJEACD5EP46vrWDzusKspsZZYGPed48W5IuzEf0x10BzVU6GficTMBUI1wJeSy9cOvOj2Z8uo6Am0dK03J+dJvraVRiLYIQHYP+mHh8SrQ314VH+QlNegyjF67WjVQ/dFEuTQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uEPEzbwH; arc=none smtp.client-ip=91.218.175.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uEPEzbwH"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7cgiKM+zDuDnTZJRzu5yT4bUih3KcyLUsgr/rzH4uiM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792240147; v=1; x=1792844947;
 b=uEPEzbwHu/tt5chmzaFb5qbVqI83ww2eE1GF8KosR6AjlTOwmdTEqJ94CSeZ1UR51kiAx4qU
 CQ6i+LLjOUvmP5QAsneUi7HxbRTR4MpxqAxhRPKJiUN89DM6oNRSjQvW2EtOVpxuAxoyEjCMvhc
 HMVUxPFgifG0cH94YLDLxAvg=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4ced6db5906c4a15;
	Sat, 17 Oct 2026 12:29:07 +0000
X-Mizu-Trace-ID: 4ced6db5906c4a15
X-Migadu-Flow: FLOW_OUT
Date: Sat, 17 Oct 2026 14:29:06 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Anup Patel <anup@brainfault.org>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	kvm-riscv@lists.infradead.org, atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Use a raw lock for IMSIC wakeup state
Message-ID: <atNpO4nRuijDH6l-@orel>
References: <20260925155116.465203-1-andrew.jones@oss.qualcomm.com>
 <CAAhSdy0Y8kQ=gsiX0QX6Ntq=fL89METhA0s7G3niBBJrHpue7A@mail.gmail.com>
 <7zy352odf4hekcibmio3atunubffzxfcsqnn55q6sfkksnynfj@5bx263nnizdm>
 <CAAhSdy2mAs6UgTk-hbGd3DX_1242Jpy9WLnOp6kmPvVVtABWHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy2mAs6UgTk-hbGd3DX_1242Jpy9WLnOp6kmPvVVtABWHw@mail.gmail.com>

On Fri, Oct 09, 2026 at 06:37:13PM +0200, Anup Patel wrote:
> On Fri, Oct 9, 2026 at 3:44 PM Andrew Jones
> <andrew.jones@oss.qualcomm.com> wrote:
> >
> > Hi Anup,
> >
> > On Fri, Oct 09, 2026 at 01:45:20PM +0200, Anup Patel wrote:
> > > On Fri, Sep 25, 2026 at 5:51 PM Andrew Jones
> > > <andrew.jones@oss.qualcomm.com> wrote:
> > > >
> > > > kvm_riscv_vcpu_aia_imsic_put() can run from the scheduler preemption
> > > > notifier while the raw runqueue lock is held. Taking vsfile_lock, an
> > > > rwlock_t, there violates the lockdep wait-context rules.
> > > >
> > > > Protect the CPU/HGEI pair with a separate raw spinlock. All updates to
> > > > that pair retain vsfile_lock and take the new lock, while scheduler-out
> > > > uses only the new lock around the HGEIE update. This keeps the wakeup
> > > > setup serialized with VS-file publication and release without bringing
> > > > wider IMSIC operations into a raw critical section.
> > >
> > > Instead of introducing another lock, why not replace
> > > read_lock_irqsave(&imsic->vsfile_lock, flags) with
> > > write_lock_irqsave(&imsic->vsfile_lock, flags) in
> > > kvm_riscv_vcpu_aia_imsic_put() ??
> >
> > Unfortunately, write_lock_irqsave() has the same PREEMPT_RT issue, since
> > rwlock_t is sleepable on RT in both modes.
> >
> 
> I am not fond of nested locking, why not convert vsfile_lock into raw
> spinlock ??
>

We can do that. The reader concurrency the rwlock gave us was only for
tiny sections anyway. I'll send a v2.

Thanks,
drew 
