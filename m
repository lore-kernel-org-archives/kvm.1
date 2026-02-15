Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43528C849;
	Sun, 15 Feb 2026 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771177650; cv=none; b=L8uyD1fO87w+7Ja9yqp30fYEP2DAQU6UVjhYCF6SvO2ZDqQi+sBQCEfMH3G3plGtQVE0x79n94MJUg5XfWsLyTMu4p/emI86mN3UEmW/vaUU9jNQy7qGHdCfWpTj70AwJWf0FmHJgtlr1J48wsV2e7V+yPFBsvZt43dB2Fc/q54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771177650; c=relaxed/simple;
	bh=WauyYvE1fxZu8CMoxtW1HF3J+YpjZ/sOClCwhExhX3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpGoLwunmm5r1+Du0PSjbts8ERygv5ujTin7Zxu2w3xDZZ+QSuYn72IN0WDO9VxfpX3fLGz9sd6ogrZYCzcQumDl5AD0aNt+oJkZ42IIuiFKWUkJQO7aYSrmOvtjsBE2XiJcx4ZcwcuIs7WVbqWvQrdr+zc41S0i9m+m87+z6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbrYBjCS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbrYBjCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B06C4CEF7;
	Sun, 15 Feb 2026 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771177650;
	bh=WauyYvE1fxZu8CMoxtW1HF3J+YpjZ/sOClCwhExhX3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbrYBjCS7QUw/rE+JE8LWK3tTpdARCB19ZpCOzFQFJYGvUsGOHm6o4hP+P7BDXHS6
	 1Ra7umuePXGYH6F/+80Rm0n5TmkfK14mAyS9ntBXHkWecssXL0KP48r5LlHdNKCB/v
	 Yikkfr4c84VgkViQbjDlEPjtnJr8q/+vckh4k7MX3co2ZRshjaZYmP5lR8kUhoF2lk
	 XG9vwuHdbwOddDuJB7oSLZ4+XvlH5VSCO7CBJdBL+lBg3Wv8xOtfQ/eBwGNFheDjU/
	 Eituud2nlH0GtfZ47cgpkILBkjYqEq3d7GDUZKTTTqcgd7VR2xlMlt0CBgwzA5r05Z
	 SFgCDu9R+kG4Q==
Date: Sun, 15 Feb 2026 19:47:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 07/17] userfaultfd: introduce vm_uffd_ops
Message-ID: <aZIGp0F7uuS9qYVZ@kernel.org>
References: <20260127192936.1250096-1-rppt@kernel.org>
 <20260127192936.1250096-8-rppt@kernel.org>
 <aYEY6PC0Qfu0m5gu@x1.local>
 <aYhh2XzyFsJbohll@kernel.org>
 <aYzZ-zBipYQ2OA_n@x1.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYzZ-zBipYQ2OA_n@x1.local>

On Wed, Feb 11, 2026 at 02:35:23PM -0500, Peter Xu wrote:
> On Sun, Feb 08, 2026 at 12:13:45PM +0200, Mike Rapoport wrote:
> > > 
> > > I understand you wanted to also make anon to be a driver, so this line
> > > won't apply to anon.  However IMHO anon is special enough so we can still
> > > make this in the generic path.
> > 
> > Well, the idea is to drop all vma_is*() in can_userfault(). And maybe
> > eventually in entire mm/userfaultfd.c
> > 
> > If all page cache filesystems need this, something like this should work,
> > right?
> > 
> > 	if (!uffd_supports_wp_marker() && (vma->vm_flags & VM_SHARED) &&
> > 	    (vm_flags & VM_UFFD_WP))
> > 		return false;
> 
> Sorry for a late response.
> 
> IMHO using vma_is_anonymous() for one more time should be better than
> leaking pte marker whole concept to modules. So the driver should only
> report if the driver supports UFFD_WP in general.  It shouldn't care about
> anything the core mm would already do otherwise, including this one on
> "whether system config / arch has globally enabled pte markers" and the
> relation between that config and the WP feature impl details.

I agree. Will move the check for the markers back into userfaultfd.c
 
> Thanks,
> 
> -- 
> Peter Xu
> 

-- 
Sincerely yours,
Mike.
