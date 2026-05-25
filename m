Received: from flow-c6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6573612E7;
	Mon, 25 May 2026 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738216; cv=none; b=kVpVabov9BXsHOHdIv1zxzQX5q1IkrOsef905HZ17YQKgnsDxYXrUtenocA2medBH+jgKnr0xl1TADKYAYh7vzjQG6ul0LdWCi1XYw/a1VnGruEpB81Ui7ZAOWujN5FOwpk5ItEnFzUqCQVCj4Xl/1OZiSgYqKCk19xClt1sAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738216; c=relaxed/simple;
	bh=GKD93VG64A5kxQue7lEH7O29Yz4xMU1KD9nt6cnvzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpPQv0wYzrFhABkmqicIcAxkvjQCclW4DAaWN9vngK1UKfFVSfYKsvjlqeCyMMLrvWVrphXocM+kPEDiu4fsfGMHXUBE66a0ct4StCY5Mg2sXDtTY73sn5G3y2QqRvVyHWof83w7FkbTAl5EvIcgc5xLukXDvePZKV5XKZTQJ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=C4Mur35z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sViDS8HA; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="C4Mur35z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sViDS8HA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id B332B13007A6;
	Mon, 25 May 2026 15:43:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 25 May 2026 15:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779738212; x=
	1779745412; bh=eYZqWDWmyjtutgvRJcqr8YK9g0zs3aP+mve8YH79Xw0=; b=C
	4Mur35zTAbdD2IH43kVpVnAr6/c+7yOk/l7RaxWV7gUuKK0LNc012SvoYkL1W084
	3l5W+uvWNRqm5fhQkmt7O8t0iOvfRVp5c7hsHQHpE6Qh9FSZ/MEoPjx96aKk3AkE
	ssHYiwNmq1SEAVqnFbP0efBZxyldRCmC8s5Zl+tfQZ8WGuOzTI6yGE2h/vgSae7k
	mH4yLwNBGC7Rcf2oBc4LwvH9yTSphL11RFVYaRK4lx8Q1UmZQghLA8nEnHZAWaWf
	ANbAc/pq4iTpbnf6rJyZNkH2dmzPXLX09kCmIN9z+S/jXs+v1Y9/03JjxJgLlD/P
	VACidMDqSxRwBY//QEiLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779738212; x=1779745412; bh=eYZqWDWmyjtutgvRJcqr8YK9g0zs3aP+mve
	8YH79Xw0=; b=sViDS8HAC4PUJSq+rQLyeLUU8K1RBZxtExi2wq9BmqnqlgPgwyN
	A24DJP5LDnGg1XLYHaPLLcTmeOs9GGABxvDEts7fRHt2Cr4GzkPgcFXPC0/4z6rU
	S7MZLXXm9hUbWS/42u9bwfyccWDh5aqvzRRQFgkyXQ4N4ZIarTL88AlaJ88AS1PY
	LUhejk7h5TE7vhxge3p0FZMOlitRcZsFQTiKLqUlqfBiSXLETziIYFAXJmmwI7Sd
	DxnDbdMGt9z7apzpgLqymuEckeKuzE+TUb2C7cGXwaQClZF4CFliiAtp2+KnzRwy
	v9H84aLObrCHOxPeV9DArTRarjdVgpP6vkQ==
X-ME-Sender: <xms:Y6YUaipClrAJ8uJDR42SfSGS26hZSRBEPmfiDPDTce1H4j1lOv6VjQ>
    <xme:Y6YUapBwgZ821jjjbBe2VKkhReoLXtF_9ma9NNvoktqa1974baqEE2VtYpz2gorfX
    5JjcKdLE51LuAPXiwcWvcMvFxsvD6uVhK-jQU_OfE5RfKAxOOBtY88>
X-ME-Received: <xmr:Y6YUaheTNXu-YOC1yxulv5MrAXBFKOj4V6N8TttkUK-CbcGrf5Cmi-ODIUlOyw>
X-ME-Proxy-Cause: dmFkZTGngrPU8UnqgtZHBi2y4I4SmyZVOKDVY9/WQa8xOMHvTiQ9LJMMNTiLiBDkUTCnEb
    VmSZ0YH/NriLI6FeprGFh0FO2pN0fiL5RqhghH5nywUkn6bjGacjYJJo3Cei5tQxKfTyRk
    znk0VH0r3YdzTv38dyn04gsnUUZy5ILD6NFuKJO6eVTQADMTFq2bevs1uTCjhyveT7jM30
    y5wq28mw5I0yWm965Y3QDl2LcU6F4ztQfJCBam49DHPmA17AqsoHeyvSkoYi7mmDv04bir
    9qsX+ty+9nymwEGBpfIhsRiomOXpjmW8fBCDJTRxzSlpkO3BAb1yO1FTBnmN62zB7n3dCy
    +aqI1PIGiVpWUOKlMua6wqJfJZ3pKZazyu6GdRFuFYe04jJya3EtT+8qzvODERAt9Xr67A
    LyKEejtEHrJwvpmxTo826djH+4IlpOcQ+qWk+1pl5CIFNgGpaXHCfH09gGVYVoP8q5iR7s
    uvJBsCojis9FDdA5X+cKIAVLNYGwThfa64G5lZlqDBL2cRt1LicIU1gF+B0FfkliYnkQ7P
    cvbwqXazG9g490YMUzuTeRY0LTBh9x+fBwH9dOkG7Ol0zG9sF9HcblH4iyLcKUig45Vdep
    1QrMBKdiU+uAhtKZ4aAfF8DLYc3yfDZ2L7gxGx78FDAtDqrATaYgs/0xxH3w
X-ME-Proxy: <xmx:Y6YUamdUCTt7fnRYY1r_x2Okc3-Nb-VWlcnMljgq5J1VXLBLADs3MA>
    <xmx:Y6YUavP4yHvqbcJLMkazD0udv9gZugM7IOSYpKqj2kjKB9Dsl6Qvxw>
    <xmx:Y6YUanoxnCds8pQk1NO57YCbE-pcWn98OApZhhZgxwKYuXkqVXA63A>
    <xmx:Y6YUamWU-whlKbA8ZzMZjVrlSDufg11xavmpSu2i8Q8fF2cq_XIVsQ>
    <xmx:ZKYUalJW4HxZxn7Y43nNwQCuCQOb6PT0GdqWwOlWIFLym8SBXKKhw2uV>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 15:43:31 -0400 (EDT)
Date: Mon, 25 May 2026 20:43:30 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 03/14] mm: rename uffd-wp PTE accessors to uffd
Message-ID: <ahSlqQCqrxGsQS4W@thinkstation>
References: <20260525113737.1942478-4-kas@kernel.org>
 <20260525120513.C51E91F00A3A@smtp.kernel.org>
 <ahRf00RTI4_0Puux@thinkstation>
 <20260525123108.0b66d07c4be97dab3536dfde@linux-foundation.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525123108.0b66d07c4be97dab3536dfde@linux-foundation.org>

On Mon, May 25, 2026 at 12:31:08PM -0700, Andrew Morton wrote:
> On Mon, 25 May 2026 15:43:32 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > To: sashiko-reviews@lists.linux.dev
> 
> hm.  What's this.

kvm@ folks opted-in for getting review feedback by mail for patchsets
sent to the list. I've replied to all recipients of the patchset not
only to kvm@.

> Sashiko seems to have been useful this time around.

Yeah, better than last time.

> > Confirmed and pre-existing ... Will address in a separate
> > patch on top of this series.
> 
> There are quite a few like this.  Would it be better to address these
> existing issues immediately then base the new feature-add on top?

Fair enough. Will prepare patches this week.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
