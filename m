Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E43C7E1B
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862913; cv=none; b=PNTRgDM7fvBo1a3F0248p65PijNoDVD01AM9YXUM2FuMMGxVxQ1J6/vO2rs9WMoE2wX0YnOxmz6zxzS7WmpenPaFZei1E/ul0mX8e0Kb4cYzTtPC2MRng/2e7S61ts3aMhnMn7upCYPhFg1NNPuvpa3Et1iHax0mqllD8v6BHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862913; c=relaxed/simple;
	bh=nqneL9zUt0dZNJebbf/LWs0KS5YJnC38qHTTLCAxNbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wqck9QWqEgqipR4HmA4kbKsVUTYnUXOTyyH8ccN/wguFnfJLDy3TRDVGa+pnpoA6GUIRKuIiq9fOs1kVoSwGKuTLWW/1eC1XHIko7W5NMGj+lYEkXQxs65tW7kwlk+NGs4nS42Cyapmdi0emLF8yZwpLl8G87VzxAnWLVUuLx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEt5PNp1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEt5PNp1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4678c6171so59000055ad.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776862912; x=1777467712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+12Isrg19MaOCC4LV9S11q3fZdSarqpUEBnPPaS2+4=;
        b=gEt5PNp1CCOta9qVKP71QxbkjpjrFqErZPGu7QYPsAw7lNF6oL/pgkyl5ZmITG7xHl
         qzpIN6irN9YMhjir5VzhrM5HpZ+MEGHPf1AXXsMYDmx3vJZ0v8tEyfFS/6DEWM60OMj6
         6vScNYgBYHoBVgYrtFJR41DrHH03SL4Z/oyCSAWfJz/Fyvl91kpB4j3MvJ+KNpvCs0Is
         n55qMlLxN8OyHLKoxUp4wm7W/+sUjqdKKi10J/p5jLPstDrqYge04jQDAkuvbOdgkrck
         BZH8EWsrRCumYaTQ8gH6YTJiYLBoqufJlg+r0LQBi55yplEcediy6Ama7EzTGAIyfz8r
         JgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862912; x=1777467712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+12Isrg19MaOCC4LV9S11q3fZdSarqpUEBnPPaS2+4=;
        b=ETqzN5r2AiFeLq4Cp0bptp0JqR44kBhYG+YlwZnDwEmgtjYZTSHsW8G9cLNPJ1VCIj
         pmhDq1zHOK57NxcrpRRha2/BQjh1PDk3NZwIVDSfjecL67RMTZOAt+LHRg/YnV9WpLr8
         r+m6PTyqm7VCmE5SxByjKfcYIypyMlygcbvHhQmEYEpyw5eI0BqwRFrxTb/z8kDwBk9R
         GmCZ+TdDUtbls5wAhUMWmLpAO3dkn1xHQZbfcrdW9myLn6o4iCpuLInnySpc/YV87a40
         PDymqV2xL8BXQOdeuaVLu2EXg5zeiZGxyrbcKPKwEl0fUKV1S4WuNlklX2F4mdnbirUP
         iZUg==
X-Forwarded-Encrypted: i=1; AFNElJ+A4wrigjGtvzwNdsFo6F//0F0oIInW1TLWrR71hbq/p0qmcnEB1yGJ0cEvKPFsZ6w9VLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTf8RJ8JtIwi/P5trfF6Dk8GmvcAgfGRmC9AMfvUrSsUNuedf4
	AdtIbZaRPjx7DCusGnE0QzkAA8Xj7HAkNSEO5p8JnFh1eWXXUrxOy6odTwKXGEjHLu0cYpUa+/a
	99e7DXw==
X-Received: from plsp12.prod.google.com ([2002:a17:902:bd0c:b0:2b2:4270:9f7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3dad:b0:2b4:5dff:310f
 with SMTP id d9443c01a7336-2b5f9fcf868mr138652695ad.34.1776862911351; Wed, 22
 Apr 2026 06:01:51 -0700 (PDT)
Date: Wed, 22 Apr 2026 06:01:44 -0700
In-Reply-To: <177d0a41-5267-41f3-bc77-415b756ea4bb@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPHJ_VJGTsRDc7_Kv0oDObuDX2pJ0evcAvH-mnD_RYMX536+mw@mail.gmail.com>
 <e48748ff-0fcd-4561-9958-124dd853e70a@kernel.org> <PS1PPF7E1D7501FEA2B54606827E0DE1805AB2D2@PS1PPF7E1D7501F.apcprd02.prod.outlook.com>
 <CAPHJ_VKsVzyYzZ5ZnBkNbYLEMXDYL5x+7jfyUxhcwT1j4zPXOw@mail.gmail.com>
 <CAPHJ_V+L92DxzEB=4+Tj+C8MNBW7LM35xWYXAoLhHqU5p2nxfg@mail.gmail.com> <177d0a41-5267-41f3-bc77-415b756ea4bb@kernel.org>
Message-ID: <aejGuMRQjeEEH-V3@google.com>
Subject: Re: [BUG] WARNING in workingset_activation triggered by KVM page
 fault path on Linux 7.0.0-08391-g1d51b370a0f8
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zw Tang <shicenci@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 22, 2026, David Hildenbrand (Arm) wrote:
> On 4/22/26 04:06, Zw Tang wrote:
> > Hi David,
> > 
> > Thanks for pointing this out.
> > 
> > You are right. The commit id I sent was incorrect. I mistakenly used the
> > git describe-style suffix g1d51b370a0f8, but the actual git commit is:
> > 
> > 1d51b370a0f8f642f4fc84c795fbedac0fcdbbd2
> > 
> > The short commit id is:
> > 
> > 1d51b370a0f8
> > 
> > Sorry for the confusion.
> > 
> > I am also re-checking whether the kernel image was built from a clean tree
> > and whether there were any local modifications when the crash was reproduced,
> > so that the reported source line numbers match the exact build.
> 
> Okay, on that tree include/linux/memcontrol.h:381 points at
> 
> 	lockdep_assert_once(rcu_read_lock_held() ||
> 	lockdep_is_held(&cgroup_mutex));
> 
> lockdep_is_held() would not trigger a warning like that IIRC, but
> 
> lockdep_assert_once() does
> 
> 	do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
> 
> 
> So likely we are calling obj_cgroup_memcg() without the RCU read lock held?
> 
> 
> kvm_release_page_clean()->kvm_set_page_accessed()->mark_page_accessed()->folio_mark_accessed()->workingset_activation()
> 
> ... grabs the RCU lock, though, before calling
> 
> 	rcu_read_lock();
> 	workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
> 	rcu_read_unlock();

No?  Since commit 906c38ff52e9 ("memcg: workingset: remove folio_memcg_rcu usage"),
I see:

void workingset_activation(struct folio *folio)
{
	/*
	 * Filter non-memcg pages here, e.g. unmap can call
	 * mark_page_accessed() on VDSO pages.
	 */
	if (mem_cgroup_disabled() || folio_memcg_charged(folio))
		workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
}

But for the life of me, I can't figure out how obj_cgroup_memcg() is being reached,
and I haven't been able to reproduce the splat to add instrumentation (though I
haven't tried very hard).

> The folio_memcg_charged() only checks folio->memcg_data.
> 
> So something does not quite add up here?
> 
> -- 
> Cheers,
> 
> David
