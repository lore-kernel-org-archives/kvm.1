Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082C181334
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170274; cv=none; b=NkH3ub4gy8UeE/FeTKBgI+EHLoS9ktM9PzVum/vnu1wgQq9Vw4IXPGMRHVSlTNBXA3e3Lgny9eYt5DSc8uwKN08M03zNPW4phvH98fWYlCTIqRA/yQgtGjOMChekOjnuqx/Rw/b6OSWmf/4TLAyFIX54GIyqewFUF3SjF5JL/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170274; c=relaxed/simple;
	bh=za25P21iRerR09HfB2lJ8DezWvhWIzLAuvQFIPRWmI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oFzx7gxMi1JUYUGUsTxRA0M1qiE84bOPxS3jHHoqB4ZXAJbYiwEfekYM7T23xPEFt9ZaAMQWi4+7XpfVgSNW/alXEieS2tDBKyJg7f2i+rcPRCQ5WM3DfJBD5VuIRM/Osxo5nwMq2mSjD5zxhjUhCxMTlYE4V0f3EH4fyVxFzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vt+PQuXG; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vt+PQuXG"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e375d9736so4089202b3a.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785170267; x=1785775067; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OOLQnJ1N4T9NlMm3RNk8fL/QgxOWSeQeUY1L1gTRIqQ=;
        b=vt+PQuXG5hSKGFJABnir7n06t/WiRPSu54KTwx1mMlAvXlkdZqCOwKaS1yCfSyY7k3
         c+5Hoz3Er+HzwwwpcmMk9AxPgQRhurDaGn0ElFi4edcvtCyvL5y9zclzlEVy7mtYUeKC
         ORJTCvUf7kT4zLZ009c05kcLTltMdkC1NS+TTF/FAMEv3vBJB7CIe1Z+kuXmeBye89NT
         4SJZw0+yB/5+tsSvFjehHy6Db7Oy3zeqpm01P5219s0Nh3LSgGJ9g3fUe+4nLFKAkLo8
         ivO0gKPz9Brn8WnOQrUOenYO9aCVvHs1ABgPO+xHNz4tGHpcr8S4Atykp5POzEnwk5Mp
         o4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170267; x=1785775067;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OOLQnJ1N4T9NlMm3RNk8fL/QgxOWSeQeUY1L1gTRIqQ=;
        b=RbEXjg325Az8WWJVgbHBDO767lNMVkbUhEVbyhZ4MyaEg5mb8hzYmNF3IJ61utr2N4
         9lZ5yhgbM3JLvS5Pa7bE+kdmLwLrBgk3HqTopL3C+BDTxrv8OLLrG0+r3UelZSXs3U3I
         0SLyJXR16jtKtYM4HsF4deOTCQjxO1QhkmVOFinLHTGro4/e63RuWYjBvL7Zxe33ups2
         UPps/JqeFH8w2/N4VEjqr6gxMIwM33TtLfIOL282RUn951s3sRMCvghXvCSr+6YoDynV
         mndeBGMN6ZJkbMROqltplSlZwT4VLXXpR1RSHOIEvLibR2rALUeBNvR6dBKSL62jm+7E
         DuTA==
X-Forwarded-Encrypted: i=1; AHgh+Rry32ISsorMcxw1gLokKvI7E+59eqXyqQ7z75RPxdkKOfCDcDR7MWxbVwYvr2H8Ib6eJRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvlLH0r4EfW8hG9ZHOz6wl8AD3dDxxiAk2AWtRTL4LgGjN6FB
	n/gyFOfnKuywCpXNf5Ov8mCn7OxzkIJ0i5o6IbEhdOKyPgDl2Tj51TzqserC8H3y2M7+lFGoclo
	1lYC1yg==
X-Received: from pfwy37.prod.google.com ([2002:a05:6a00:1ca5:b0:848:7f21:167c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2393:b0:846:2f3c:3f68
 with SMTP id d2e1a72fcca58-84e8d0a7c58mr137097b3a.57.1785170266555; Mon, 27
 Jul 2026 09:37:46 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:37:45 -0700
In-Reply-To: <amLhu07IpWfBbWC0@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629163337.1264881-1-hannes@cmpxchg.org> <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
 <amIcXrS7nGX-adpG@google.com> <amIrDncrL4K-JRBO@cmpxchg.org>
 <20260723171515.b5ddbc59c5c36ad01ef8f7fb@linux-foundation.org> <amLhu07IpWfBbWC0@gourry-fedora-PF4VCD3F>
Message-ID: <ameJWWjYXuONB6VF@google.com>
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
From: Sean Christopherson <seanjc@google.com>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 23, 2026, Gregory Price wrote:
> On Thu, Jul 23, 2026 at 05:15:15PM -0700, Andrew Morton wrote:
> > On Thu, 23 Jul 2026 10:54:06 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > > > But in this case, IIUC, this change will "silently" enable NUMA balancing for
> > > > shmem-based KVM setups where it was previously disabled (albeit unintentionally).
> > > > 
> > > > I'm not fundamentally opposed to the change, but I do worry that downstream KVM
> > > > users could be in for a nasty surprise.
> > 
> > It is a bit concerning.
> > 
> > > This should be very visible in early kernel validation after an
> > > upgrade. VM hosts tend to not do much else, with VM memory dominating
> > > the host. You'd expect a significant uptick in numa_pte_updates,
> > > numa_hint_faults, and a change in per-node nr_shmem stats. And the
> > > patch subject makes it trivial to find in a commit delta scan.
> > 
> > Is there anything we can do to make this process less painful? 
> > Documentation of course, but what about detecting the situation and
> > emitting a once-off warning?
> 
> Maybe a rate-limited or one-time pr_info/warn on the first PROT_NONE
> fault affecting KVM in the painful zap path?
> 
> Non-invasive, targeted, and helpful.

Unfortunately, keying off PROT_NONE probably isn't all that targeted and thus
may or may not be helpful, as it would generate what are effectively false
positives for setups where NUMA balacing is already fully enabled.  In my
experience, KVM users tend to freak out if there's a "scary" kernel message,
even if everything is working exactly how the admin intended.

Thinking about this more, I'm probably being overly paranoid.  The failing KVM
selftest is (very deliberately) about as pathologically stupid as things can get,
i.e. it's not representative of real-world setups.

How about we do nothing for now, and then revisit trying to find a useful way to
alert the end user *if* we start seeing KVM bug reports?  As you said earlier, I
think "You turned numa balancing on" is an acceptable answer at this time.  
