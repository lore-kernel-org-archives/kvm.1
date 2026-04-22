Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E602571B8
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873262; cv=none; b=qRhmaebA7Hm2qqC0q035C/lqefYR/epOGz9OVPkkdlQc4pDClQmMjeI81z1jdnZ77eMPZEXVqwwzxTyQI4k1OaW7nOwOP3ie8u8uZJl8+/ATivGqNHiyMwF1Tzud7PpGj+VzzuLJynDm9JSy15xidX2y+YkWohkVSmqooRyxw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873262; c=relaxed/simple;
	bh=p/o4p72Vt4z2tehtlFZfx0ZIoNtJEdCjfn1U5LZ50wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDUVjCVHepxitS0Sk5dV4i6APOtTQV4M50ys3AUYRefEnLF5ddtq+76dr3Rhi6Ldc5pK81QfiKeW63Jix/0UAaYWZUTLlxQKby7EdhL1rVM/fOxS2vCTRqKdYW5SeeryfFeORW65jDtzrIeu2RYSdpCR5UsRN6CDyFYvFW7vC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TbHGnsgz; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TbHGnsgz"
Date: Wed, 22 Apr 2026 08:54:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776873249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNSFjB5scCIoduSEowvVTvq40a5owQCVbC+es3+xqtc=;
	b=TbHGnsgz4p/jZjpNe6F0BBXy57w0Nk0cSY+BQuwiWwjJG/PLr2GOdU2l7UQe1AJdxQXVnB
	POvEsUH+T22cL7uij8iDLevqfu6ddNozYM2c/HnGCbzjO+UTdgyMVoI2bRH5C4b6jsZZYV
	gPcMqHyxmRgSplWg2AGT2ceTaWfXYsw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Zw Tang <shicenci@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [BUG] WARNING in workingset_activation triggered by KVM page
 fault path on Linux 7.0.0-08391-g1d51b370a0f8
Message-ID: <aejuZb1sDlsKVc3M@linux.dev>
References: <CAPHJ_VJGTsRDc7_Kv0oDObuDX2pJ0evcAvH-mnD_RYMX536+mw@mail.gmail.com>
 <e48748ff-0fcd-4561-9958-124dd853e70a@kernel.org>
 <PS1PPF7E1D7501FEA2B54606827E0DE1805AB2D2@PS1PPF7E1D7501F.apcprd02.prod.outlook.com>
 <CAPHJ_VKsVzyYzZ5ZnBkNbYLEMXDYL5x+7jfyUxhcwT1j4zPXOw@mail.gmail.com>
 <CAPHJ_V+L92DxzEB=4+Tj+C8MNBW7LM35xWYXAoLhHqU5p2nxfg@mail.gmail.com>
 <177d0a41-5267-41f3-bc77-415b756ea4bb@kernel.org>
 <aejGuMRQjeEEH-V3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aejGuMRQjeEEH-V3@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 22, 2026 at 06:01:44AM -0700, Sean Christopherson wrote:
> On Wed, Apr 22, 2026, David Hildenbrand (Arm) wrote:
> > On 4/22/26 04:06, Zw Tang wrote:
> > > Hi David,
> > > 
> > > Thanks for pointing this out.
> > > 
> > > You are right. The commit id I sent was incorrect. I mistakenly used the
> > > git describe-style suffix g1d51b370a0f8, but the actual git commit is:
> > > 
> > > 1d51b370a0f8f642f4fc84c795fbedac0fcdbbd2
> > > 
> > > The short commit id is:
> > > 
> > > 1d51b370a0f8
> > > 
> > > Sorry for the confusion.
> > > 
> > > I am also re-checking whether the kernel image was built from a clean tree
> > > and whether there were any local modifications when the crash was reproduced,
> > > so that the reported source line numbers match the exact build.
> > 
> > Okay, on that tree include/linux/memcontrol.h:381 points at
> > 
> > 	lockdep_assert_once(rcu_read_lock_held() ||
> > 	lockdep_is_held(&cgroup_mutex));
> > 
> > lockdep_is_held() would not trigger a warning like that IIRC, but
> > 
> > lockdep_assert_once() does
> > 
> > 	do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
> > 
> > 
> > So likely we are calling obj_cgroup_memcg() without the RCU read lock held?
> > 
> > 
> > kvm_release_page_clean()->kvm_set_page_accessed()->mark_page_accessed()->folio_mark_accessed()->workingset_activation()
> > 
> > ... grabs the RCU lock, though, before calling
> > 
> > 	rcu_read_lock();
> > 	workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
> > 	rcu_read_unlock();
> 
> No?  Since commit 906c38ff52e9 ("memcg: workingset: remove folio_memcg_rcu usage"),
> I see:
> 
> void workingset_activation(struct folio *folio)
> {
> 	/*
> 	 * Filter non-memcg pages here, e.g. unmap can call
> 	 * mark_page_accessed() on VDSO pages.
> 	 */
> 	if (mem_cgroup_disabled() || folio_memcg_charged(folio))
> 		workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
> }
> 
> But for the life of me, I can't figure out how obj_cgroup_memcg() is being reached,
> and I haven't been able to reproduce the splat to add instrumentation (though I
> haven't tried very hard).

folio_lruvec() -> folio_memcg() -> obj_cgroup_memcg() if folio_memcg_kmem()

How is the given folio (page) is allocated?

