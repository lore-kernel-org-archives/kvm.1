Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50D3CBE7B;
	Wed, 18 Mar 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842849; cv=none; b=dLAXbYTXW6UxPGVt1ZsrwvdscG9WUX3D4KSgZ1BxDWCSyg6h+1O0eYo4M3Kclncd9FwSuquSjzDkwl50EDlC+pYk66cKdFFfnftJ6oMt2mDWpeBuNa9JRI28+PssSFs6caIiPfHsPS9IsFT7UZ/k6nJZuePJPBvdukNlPYoJaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842849; c=relaxed/simple;
	bh=xVHDZBr9hRtukhJKZKkZ5lH+CodUuhgR2zQoP0qbSqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUvvSR9PFuNBc74yxabjUPY/c/Z3orElNpYkUZvj9CnJuX4RqxuF8vDsHKFy2hTT/ZM2dtfdRyjqw7mBML7QZhhDay3JKkTGAMDZs6D/Yt/5iEN6xo//F1lyci1SyHt6AF5uOPUGWAeBqyTWpZgC7dwYmjMy8UlsnaxZhXaJqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cElEuW4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cElEuW4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F52BC19421;
	Wed, 18 Mar 2026 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773842849;
	bh=xVHDZBr9hRtukhJKZKkZ5lH+CodUuhgR2zQoP0qbSqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cElEuW4+7dWuaxLa6Layls2/T9Q21hZCwYzYQ27lJ0YjRECmtbrVksBvHzDT43Gwd
	 XbYervVZhjNtmK7Rsbry2j8LQSPx5iLc49eeyp4d23yXx8r9z5Yq5DmtNzkT9t8a6w
	 ECOrnpuVYZW6faoUuypDUzdjZKo39P/xJV+Gf9RkbzpV8mDR0bG5EHKAIX6XJaSQ8d
	 ZT/pQFIpNxODSEG8tbZWtzS7kCDG++N0AbvYGaiwkEyjH+1Xvsj54VFqu7jnlc6iH8
	 MIL9NIP5ZunVNMLdR/LDwoI1j/epe3UUt5Tf8al7F7tvtnt6Opnxjj7tim7hvKfSj2
	 Rx4roRERrJvdg==
Date: Wed, 18 Mar 2026 14:07:23 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "Boone, Max" <mboone@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mm/pagewalk: fix race between concurrent split and
 refault
Message-ID: <5765d71e-70e4-401a-9b6e-e20ec42b2de3@lucifer.local>
References: <20260317-pagewalk-check-pmd-refault-v1-1-f699a010f2b3@akamai.com>
 <7ded426a-0cb5-437b-9634-8d806b704db6@lucifer.local>
 <719CB417-F511-402A-91E3-8A696ABCE0D5@akamai.com>
 <E9058409-F4D6-4146-9366-17E87FAC9812@akamai.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E9058409-F4D6-4146-9366-17E87FAC9812@akamai.com>

On Wed, Mar 18, 2026 at 01:27:33PM +0000, Boone, Max wrote:
>
>
> > On Mar 18, 2026, at 2:08 PM, Max Boone <mboone@akamai.com> wrote:
> >>
> >> Yikes, really? :) This is from 2017, I'm a little surprised we didn't hit
> >> this bug until now.
> >>
> >> Has something changed more recently that made it more likely to hit? Or is
> >> it one of those 'needed people to have more RAM first' or bigger PCI BAR's?
>
> Forgot to mention, but yeah, we’re seeing this on Blackwell cards which have very
> large BARs, so probably seeing it first because of that. But the window was already
> pretty small, it’s not a very logical thing to poll numa_maps or smaps walks while the
> firmware of a VM is remapping the BARs of a GPU. With regards to that specific case
> there’s a proxmox thread and mail from the same person presumably [1, 2] that mentions
> the same bug.

No question we should take this fix, the page walk code is the right place to
check for this as we are not safe assuming the PUD entry can't change.

>
> [1] https://forum.proxmox.com/threads/walk_pgd_range-crash-pve9-1-on-6-18.179895/
> [2] https://lore.kernel.org/all/5948f3a6-8f30-4c45-9b86-2af9a6b37405@kernel.org/

Cheers, Lorenzo
