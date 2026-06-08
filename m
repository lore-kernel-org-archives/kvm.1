Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6F31197C;
	Mon,  8 Jun 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907455; cv=none; b=k3Z6DqR/2aLwCrBh2V6dqBfPl7LqXO51l59TiOHokh4DfwlIg2xBcY+JWh3elEmKYJIDA1e4DgetuWJYMe803KsfDD+mXGmepHjNAdb13kqsLWEOci2l7X+PEPM1YN6MWS/gBnqIb3P3R5XF8yTYpQDe4J78fKA/xgbrlpMYoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907455; c=relaxed/simple;
	bh=ukPsr8AVW223GNDlkOBdESYJcOCBcUm24I0u/yjU+YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTCxpUp/AW4/YOTPDBJkbezDfN01z22havikU2m6cL5rGzM8t2GC17Vm6PTvma/wl69LyvJH9o8wbAYzR9NmZJ9VtmB0PmdXLxQyRof6g1gni5hSHAz5g29rDvG5N/ybIytyIX2cGbHqnRAGbBuGtXSCm6kGVjCUMM57plqLn1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrE5UV4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrE5UV4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FE21F00893;
	Mon,  8 Jun 2026 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907454;
	bh=ukPsr8AVW223GNDlkOBdESYJcOCBcUm24I0u/yjU+YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CrE5UV4E4gtMqWdlDxlwGiualRcpCYsTqtOnl9OQ7iJNffWWhuVEi4pb41/d3BE8H
	 E4PUS6xuWHk5A9OSqwN0It2JZroLsO+GjchxcCMplHnFEz5YXQa3bSj22emTn+NV0p
	 NpTt5uEAnB95OBuAJqNsP3oJdaMJThOc8kQihH+k+Y9S530VGWLSduTH3cZbAmQDY/
	 /mSvxvIv73FBM6REzzzeJ3TWVEr863JMvVqXrdQRIcFr9eGIwpPAJRcJ+3SrymvX+q
	 MdRJWv6j2z0zaMswzhzTqHrC1hwHxLA0ObKhVtN9E20OOsMIB5HrQ5bNc8sgYCzJZM
	 VMSbx6izi2ePA==
Date: Mon, 8 Jun 2026 09:30:51 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "shaikh.kamal" <shaikhkamal2012@gmail.com>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	pbonzini@redhat.com, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] mm/mmu_notifier: Add async OOM cleanup via
 call_srcu()
Message-ID: <aiZ4-4VVJTjIJB24@lucifer>
References: <ac08V4TaM2yh9SY1@google.com>
 <20260429222548.25475-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429222548.25475-1-shaikhkamal2012@gmail.com>

-cc my + Liam's incorrect email addresses, +cc Liam's correct one.

Hi Shaikh,

I'm assuming you're fairly new to the kernel so some feedback here, as
there's quite a bit wrong with these patches.

Firstly, please check MAINTAINERS to ensure you have the right email addresses.

Also please don't send mm patches in-reply-to another series, send them as
separate series.

Send patch series such that they're in-reply-to the cover letter. Do not
send a cover letter if there's only one patch in the series.

Do not send follow up series in-reply-to the previous version. Send a new
patch or patch series.

If you get an issue like a build failure, do not reply-to the patch that
failed with a fix, instead send a new version of that patch with the fix.

When you fix things, add a brief changelog under the '---' line if a single
patch, or at the bottom before the diffstat if a cover letter. Ideally with
lore links to previous versions.

For patch series use:

$ git format-patch --cover-letter --thread FIRST_PATCH_HASH~1

For v2, v3 etc. use:

$ git format-patch -v2 --cover-letter --thread FIRST_PATCH_HASH~1
$ git format-patch -v3 --cover-letter --thread FIRST_PATCH_HASH~1
etc.

More useful tips here:

https://docs.kernel.org/process/submitting-patches.html

An example of a series with these traits:

https://lore.kernel.org/all/cover.1774029655.git.ljs@kernel.org/

Thanks, Lorenzo
