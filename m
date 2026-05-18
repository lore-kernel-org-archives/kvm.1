Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F2393DDD
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136964; cv=none; b=VoOxcD8773ZPLx/EqVvrFOU9cZt1y+izSHQv7DkoySb0QGi9/S+qGeNNChfoWNHNKJ3ETJ7GN5YUAF43XJjJyHb8qRMeY4n3lD4uoy65oPhZG0LwG669nLonaIFFz/Wf9urQyWmSJoN5CmdkMk559uOUlI3dMWDKRMZJNMKFwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136964; c=relaxed/simple;
	bh=nQVouHXOMCqKouN03zntvmRFb98UZvsXHIXc5Lhetxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yad3QLDMHTGQLdGyiTrnZQU7mnOM1EzYN86ZvOMXbGmTyISiCHfC/O1HO2r0lw5oZfu84AhwMjJRZMPRhCdJBndcizu9vfrWHPNw1a9oyfetRUGO/2dL+JIodz4nNAV9FkYBmOdNIj/Mw0x5NIQZfURiEsXHgutGrc8XjyXPg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LaUF8OXi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LaUF8OXi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso32320495ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779136962; x=1779741762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEZiI2mCaxhF27MBx5FxJQ+kMagKDbcRpCU+GTF0M5o=;
        b=LaUF8OXiun00q6G5gyzFgzqxAR8yDko5H7DIT0sHGhmHtIc43DXdUyzOheAeN5ZdKp
         QGlspkvwP0DFmgMNoDYdeYt0yMsuM08OHkhOzQD5WDC2efW4zSPiFG/gnD71CL+N3IJr
         8096AAP/VAcySjXMFl09Ea8sPOwNbiCVEL9au8CJ41ah0BXjXmUDBKSF9vfhsfK65dq0
         H7JCGOMDhL0Ad6yftSQM5Lt/6G76ihixSNmyxF6B9wzFRgXHfc41Mzi9KLl7XL/aeeoF
         prJZbNBU4czyFvBcBesF1PWCcqJ7QNoLCHHP44uoYTEJUwHu1aAUDL5QgmO8NE0Th3JB
         r4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136962; x=1779741762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEZiI2mCaxhF27MBx5FxJQ+kMagKDbcRpCU+GTF0M5o=;
        b=pYMEyHP+fdcZ+GNiT22RSjlAYWCAKPLIWIR0LtsGaae9RLlx9aMVqJEE/0CnSyteYF
         Nnq84YrKGpv/tpIGmSAuF3aTe0Oo/G55g5HuxtO7dkYH8cSnh7x2e/4HevIFaMFh28ZC
         OY06tJWlei/z6WpUMvs5xe+U7vAOfMAeWDTN7oA9VTZy4CLpi+new/N7isZNPkw/NZTy
         SkWX4rKfczrVmsg1yJqoaRaiHcdxPRlZwuPEaiEt5tk6hPYd4vy/rv7WlZMFbVPrVsaz
         Mtf7ZMt1ioWgkhq3GPwVD3BMo31FpM4AAghQCwkMUuC9uqwafuuxA/aVxZZNdO23YxM+
         XgKA==
X-Forwarded-Encrypted: i=1; AFNElJ+GcwTPUykrVL8tW7EAB23BIHm6gD9xFl+Jtjn46wqwb0PxtZfstMCLYUTd+rlfQ5mWaP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIJwhaPNkKNIqalNrd7omCun1xNWqMVW+yWioxTKRbkoOOyu0
	iE6w+I9sEdg1rt6JYI7BKGE3LEhwsYR9EBCc3wVGmcGDR+UlqysaVc39ONvPd27qZPf+v6i2qO9
	a0xnj4A==
X-Received: from plsr2.prod.google.com ([2002:a17:902:be02:b0:2b2:48d8:c695])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c43:b0:2bd:c310:f7c9
 with SMTP id d9443c01a7336-2bdc310fd7fmr94710675ad.2.1779136962102; Mon, 18
 May 2026 13:42:42 -0700 (PDT)
Date: Mon, 18 May 2026 13:42:41 -0700
In-Reply-To: <CAEvNRgHd4azPaMddvqnSG+Z5fmg+LWd+pz=LSB3PrJTW618dww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402041156.1377214-1-rppt@kernel.org> <20260402041156.1377214-14-rppt@kernel.org>
 <ac7oE_1j6gxf8OKT@google.com> <CAEvNRgHd4azPaMddvqnSG+Z5fmg+LWd+pz=LSB3PrJTW618dww@mail.gmail.com>
Message-ID: <agt5wTK5I-FvlB57@google.com>
Subject: Re: [PATCH v4 13/15] KVM: guest_memfd: implement userfaultfd operations
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrea Arcangeli <aarcange@redhat.com>, Andrei Vagin <avagin@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	James Houghton <jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, tarunsahu@google.com
Content-Type: text/plain; charset="us-ascii"

On Fri, May 15, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> >
> > [...snip...]
> >
> >> +#ifdef CONFIG_USERFAULTFD
> >> +static bool kvm_gmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
> >> +{
> >> +	struct inode *inode = file_inode(vma->vm_file);
> >> +
> >> +	/*
> >> +	 * Only support userfaultfd for guest_memfd with INIT_SHARED flag.
> >> +	 * This ensures the memory can be mapped to userspace.
> >> +	 */
> 
> Is the principle here that any memory that is allowed to be mapped to
> userspace can be userfault-ed?

Yes?  It's more the opposite though: memory that can't be SHARED and thus can't
be mapped into userspace can't possibly support userfaultfd.  Six of one, half
dozen of the other, but I think it's important to highlight that there's no
judgment call being made, i.e. we aren't deciding to support only SHARED just
because we're lazy, it's a hard requirement.
