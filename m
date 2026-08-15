Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031F419305
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786798347; cv=none; b=PaqhJqQupEKvmq1v4EGPJMi2ij/PuSmmBmbgooEZ/zcTFNTRtAcc/WdUTYRXExUeE7g+FX1rLGbXNFOOVm2gRm8kR/89QQbVD1rgoMjrfX2kiAKp9uaveTSwxq+7AsjV2Z4NfH7npdqjhQMcLsd06DgyUn0M0c7cX4GVpUBQg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786798347; c=relaxed/simple;
	bh=beSsuq1xxDvko/NaLtI6lJSmxpKybbNv3qu6Zttw3HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUrPvpw6QWxERu04bu5zDvEgAwkI9JtwCdyVJosAnEjB+ps4g4nSqx9km6wXPiCh2pkfTsJO0nWEqRSYUC2YrTnUId9gQeoTg+9VAGuqpAwxmAFQ689VxNgrO8Mj1ga9l052Qoh6CXDTRleL4NTj38EoGlMAcYeC6JgWH9SIEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZOs25pcG; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZOs25pcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9yxIf+lU8tvlujmQEoZAR4M3+yphkZtt6NN4FVSCJrk=;
	b=ZOs25pcGYg9oaEFhowqxCWUreCCQU3MWVC4ekc5EGVaYbxYsT/m1tWAUz451A3
	QPn6PV8pi8PSQzK/hnHid+RYxUontU08uNRlQfncyqAbQfqhdXFa4y4EaCF+MSAO
	d779Ui+f8wiI6UFtYA7zLXQ7oVa6DLveQaiZBgaEViYqM=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCHHEzoYIBq0Iy7Kg--.59482S2;
	Sat, 15 Aug 2026 20:51:52 +0800 (CST)
Date: Sat, 15 Aug 2026 20:51:52 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Hao Zhang <hao_zhang_kdev@163.com>, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] KVM: x86: Skip empty TDP leaf page tables
Message-ID: <aoBg6Hx2bQc1FWrO@192.168.1.215>
References: <an7JGuzynPBaYB5t@192.168.1.215>
 <an7J9Gh2DTrtP5vT@192.168.1.215>
 <an9VHNUEx9CPzquP@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an9VHNUEx9CPzquP@google.com>
X-CM-TRANSID:PCgvCgCHHEzoYIBq0Iy7Kg--.59482S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF18Zw1Utw1DJr18Xr4DCFg_yoWrXFWfpF
	ZavFWftrs8t3yxXw18Aw4vy3W5ua93Jr4kJrn8GwnFk3W5Ary2krWvyr15uFyDWFs5Xr4Y
	vF4v934DA3ykAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUvQ6dUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+ggNAGqAYOgOogAA3x

On Fri, Aug 14, 2026, Sean Christopherson wrote:
> On Fri, Aug 14, 2026, Hao Zhang wrote:
> > From: Hao Zhang <zhanghao1@kylinos.cn>
> > 
> > When KVM zaps only leaf SPTEs, the TDP page table hierarchy is
> > intentionally retained so that subsequent faults can reuse it.  However,
> > a later zap of the same range still descends through retained 4K leaf
> > page tables whose leaf SPTEs are all non-present.
> > 
> > Track whether a retained 4K leaf page table contains any present leaf
> > SPTEs.  If a zap fully covers the corresponding 2MiB range and the page
> > table is known to be empty, skip descending into it.
> > 
> > Keep the page table hierarchy linked so that it can still be reused by
> > future page faults.  Installing a new leaf SPTE clears the empty hint.
> > The hint checks are skipped for ranges smaller than a complete 2MiB leaf
> > page table.
> > 
> > The iterator restarts its walk from the root after yielding.  Allow the
> > restarted walk to mark an empty leaf page table again instead of
> > permanently excluding the page table that contained the yield.
> > 
> > Tested on a 4-vCPU, 1GB guest with five repetitions on the same host.
> > The main improvement is seen for repeated same-range invalidation; rolling
> > sweep workloads are mostly neutral.
> > 
> > Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> > ---
> 
> Does the generic iterator solution I provided a (long) while back work for your
> use case?  I would still strongly prefer a generic solution that doesn't rely on
> storing metadata in the MMU page.
> 
> https://lore.kernel.org/all/ZxmGdhwr9BlhUQ_Y@google.com

Hi Sean,

I tested the generic iterator approach you pointed me at, i.e. skipping
non-present SPTEs in the TDP iterator and converting the relevant TDP MMU
walkers to use the shadow-present-only iterator.

The results do show that the generic approach helps, but it doesn't fully cover
the pathology I was trying to address.

All numbers below are medians over 5 runs on the same host/workload:

                original    generic iterator    empty-subtree hint
    same16        330 ms          222 ms              35 ms
    same4         341 ms          234 ms              54 ms
    c16          1456 ms         1696 ms            1386 ms
    c4           1252 ms         1291 ms            1244 ms
    c2           1197 ms         1174 ms            1246 ms
    c1           1353 ms         1199 ms            1138 ms

The generic iterator reduces zap time for the repeated same-range cases by
about 31-33%, but the empty-subtree hint reduces those cases by about 84-89%.

I think the reason is that the generic iterator only skips non-present SPTEs
within the current walk.  It doesn't carry any information across invalidations,
so a later zap of the same range still has to descend into the retained child
page table and rediscover that all 512 entries are non-present.  The hint avoids
that repeated discovery step by remembering that the child page table is empty
until a later fault installs a leaf SPTE.

I also measured fault wait time.  The generic iterator didn't show the severe
~1ms regression I had in an earlier experimental version that reduced yield
opportunities, but its fwait p99.9 was still higher than both the original
kernel and the empty-hint version in this workload:

                original    generic iterator    empty-subtree hint
    same16         78 us          162 us              61 us
    same4          62 us          152 us              38 us
    c16            72 us          242 us              77 us
    c4            102 us          248 us             105 us
    c2            108 us          270 us             107 us
    c1             92 us          266 us              93 us

Although the generic iterator is cleaner, but it may not enough to address 
the retained-empty-subtree case.  The key question seems to be whether KVM 
can keep a very narrow, derived hint on the shadow page: "this 4K leaf page 
table currently has no present leaf SPTEs".  The hint is cleared when a fault 
installs a leaf SPTE, and it is only used to skip a fully covered 2M subtree.

If storing that bit in struct kvm_mmu_page is still a non-starter, I can look at
a metadata-free version that checks whether the child page table is empty before
descending and skips it for the current walk.  But based on the mechanism, I
don't expect that to preserve the same benefit, because it still has to
rediscover the empty state on every invalidation.

Thanks,
Hao

