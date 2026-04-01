Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E8315D53;
	Wed,  1 Apr 2026 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065491; cv=none; b=bDV+EVTTbD2qGqS/tthw4s1B0g1yzIUGtSuq/LgRVhVBNSsLTPqPbPMkv+Hv/ec2vyvtDEOO+XtZmus/VaspG22q5B6jA42CCxj19rGXKmGt9k8aGUV29+Tb9mYvGeRT5fXKennYRfVagCeS3BzZ+qk3I1aRPNSImJjpiGcY/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065491; c=relaxed/simple;
	bh=Vpvl1hwrUz4+8zrhaW+q8G2QFNcvqrZBxlmzw5hbjeY=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KJTp+KDig6Z18sD3bTrJs0gmttHt3Vt45l0wyBJJY755h6wm8UMGgxOQ94A18uTydMOqOJDsuk97TaM8klJBavnYQMUMH+YwzN/vEbkRPUjUCNrxasx6MJisramZVgFc2B0swysBWUprlR/rywF3bp2e4Cle/b9DY9fKX+WWcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aJ3GOnzd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aJ3GOnzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52224C4CEF7;
	Wed,  1 Apr 2026 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775065491;
	bh=Vpvl1hwrUz4+8zrhaW+q8G2QFNcvqrZBxlmzw5hbjeY=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=aJ3GOnzdtftQFcgGw9LludNc+Xqz3IGUEX7Lf0U40Zix6m0fF/Xpu42F6o8fJHoyp
	 Z9ML6t9FO5UsakhjGV1dEw0su9MpAtZYy3RJaD7lm9L3QNFbQtuHnMtuRmdpkSMYAs
	 ycDV8UG4IaEXWb0L1dUtni6LsVe1CLO4csZLl2Kc=
Date: Wed, 1 Apr 2026 10:44:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>, "Harry Yoo (Oracle)"
 <harry@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Andrei Vagin
 <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, Hugh
 Dickins <hughd@google.com>, James Houghton <jthoughton@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, "Lorenzo Stoakes (Oracle)"
 <ljs@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal
 Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, Nikita
 Kalyazin <kalyazin@amazon.com>, Oscar Salvador <osalvador@suse.de>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 02/15] userfaultfd: introduce struct mfill_state
Message-Id: <20260401104449.42123600e33e08b5ebad10a5@linux-foundation.org>
In-Reply-To: <20260401103717.b236b271a2856d536a48663b@linux-foundation.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
	<20260330101116.1117699-3-rppt@kernel.org>
	<actxscYZGFiyvUcs@hyeyoo>
	<acva_NKf7T5rbIC8@kernel.org>
	<acvnEd3-s6XI26vb@hyeyoo>
	<aczK4-vrULRiTvyh@kernel.org>
	<20260401103717.b236b271a2856d536a48663b@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 10:37:17 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 1 Apr 2026 10:36:03 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Here's a fixup (it causes a conflict in patch 4 though).
> > Andrew, I can send v4 if you prefer.
> 
> Looks pretty simple.  "userfaultfd: introduce mfill_get_vma() and
> mfill_put_vma()" now leaves things like this:

err, actually, it gets messy.

Can we please have a v4?  I think there are a few other things pending?

I've noted
https://lkml.kernel.org/r/acqrtd7E6UxrX6Ji@casper.infradead.org and
https://lkml.kernel.org/r/202603311743.uZYPu1Gn-lkp@intel.com

Alternatively, I can leave the current series in mm-unstable as-is and
we can add a fixup at end-of-series.  Not ideal, but it's OK.

