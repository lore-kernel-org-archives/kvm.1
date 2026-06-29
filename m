Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA444102B;
	Mon, 29 Jun 2026 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748965; cv=none; b=lUkz8JscVfb5M5HOxwp5tAfQc0iWSG6sCIQIfWsAClrqUHDrKh4OnYivbE/r4zKmf/HmEfUwnLdkSJzr+JIDounBbnrAOXGhxcziRrfjeG79YyqVZLlwDcmUNGlVbA9LNvZJP3NflSfgdnbE9yCUHgPGFeP7exTXe2Vbft5Cwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748965; c=relaxed/simple;
	bh=xUf6430MUJDHSC5orAznw95bP/KW4glg9syvaE6YZhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAULuRLcPFYjcm9RT9YF/CULLYC0uDcnM4aY6VQdYcNh9jqoFUcygD9bvQhNgMZHsXuFef7jo8i6cuFyOkG+estHDr9CY6u/Tgg442MP2oaNHghvbTTjAGcw/BAJgI6NKz/yY6+oZjRVVzpTCdQtGolzWoYyAUAmjCzRDGAfYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lterjNH4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4Prm+vx; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lterjNH4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4Prm+vx"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 6FBBF138037E;
	Mon, 29 Jun 2026 12:02:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 29 Jun 2026 12:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782748963; x=
	1782756163; bh=5M7UrWTmU2fnWKZojvoJwc5RGoqcaVVltooaRFZSbD8=; b=l
	terjNH4SS6dbm7ZLR3cT8v0CQWM6BYPp7JwJx5JHs6wYmDrskeL9eFpXHU7x5FP9
	i7ovNMukFffN45qrCtjS5pVHdrUWJQuIsxug6mnYgJ8XN1PRNJw/yVQufVv8vV7W
	X25/eoFjgyFoGvv/DplYNLrPAV5fdPTMfp9adZ+5bzKIyTk6uVbaMcXvodkORq9m
	rFz7oNrgxuYOPK4a5gD+/YhYEfqASmYZVM2laU8bM5n3xGFrX7mIEaj+7sRV+yIr
	P9fS3RowK9esq9C4O+4JY6c03GlWm9STey+km/jkknM04NQGoy79z8VBAilMDjli
	3ISCnhaa/y/MXCmTkojQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782748963; x=1782756163; bh=5M7UrWTmU2fnWKZojvoJwc5RGoqcaVVltoo
	aRFZSbD8=; b=f4Prm+vxw0uPrjIauItnXpWZWosjcyK5uKoXRf3h8MOxc0RK/TQ
	NxeUehuXq0dAp9HeDS6CARmGeyw6ESQNFvu11X8Zdy7XaU2nr0Jrwzc/+0s9c3RN
	wnIGjqIIwd5En4IDHPFOA8jE6kMWpN5/L0zoZZEhliNp7YEioZGAM2trxB4bnNZX
	UK6BlFw63n7yRsTEeZVRMNsD9gl9y4+lLXuC19yw09hvfS5RdqrC3SJT2ARSuID1
	froiUydCH9CNMUaEOr+hXtUy87hkEW1knryg4vVMfH/cZfHcAeZs7azys99Izkgs
	TnnqGCY/NaiYRZVVYMArKRvnHBoCtfUsQ8Q==
X-ME-Sender: <xms:I5dCahmrywK2XmKKrXi34cxfd-7jZ5vYqMOZDLC0dONzWjSgGWB0IA>
    <xme:I5dCalPY2ZqO546gF66vI4g5nJZD3yjlQCs-aNCcJMfRorFAHAyrva09ADxB68QqJ
    WCZoneYSMMDZwQWA9yDBJYZiAI2vmZ_lYZdxTAl_oSAtJhs39SZai0>
X-ME-Received: <xmr:I5dCah7z1q6CBoH2evDYJLFJ126BboKdoqYET9eu2yv8roOyvjPZ_-Mbc0P7Ow>
X-ME-Proxy-Cause: dmFkZTFDlTNK+FNohJg4noCYbW5VpwAEJ/3lhl31ZFTIvh6wOi6MwAQn2pdhCP1fDqPjSp
    DThp5HlJoStLNnqS7NKN1XFUvrVLCFaaDrqKHocOP7Q0yFfyk9vYJwPjD4MtZnSSU+huSE
    0bkQ4ZIkzUfj30WTfAyH257AFUsdMzCDhw0NoGAJUakjPmDj4VwuK9ibUEs2fq3McnGv78
    Nh2JYbn4djoiaQDuiejPXLoPHxDQPhQeipCwDaQnTK65xBeDKRnJz9LO1G0ubz+7ygczav
    kf9ymsjv6R0e7EpJWlgyVS12qRilACHu4La+l0bLD0/MxAsnjj+YIo73t+IxeqDILoe3aI
    EGi5XfI/jWveDG9g4WL+5X/HQPKMnj5RRBtKX05jMG7+yCi7C450Ue3g9/WkhfbZVE1DD+
    BXn09yMHPghVteggvBz2uHm+ayYXAy4SInb/5Q8CrS2AiPIChqLo/yfuVTLXhZg9UKdLu2
    BK7bij7g/xg9IyuQmHAsF2svJoFNX+gKUlLyXZVTwg0oU9NpZFhqZIhetDbTjdDqIw6FxV
    NDL+Jg024Pzi/8xay+OtYIKFSFiKHP9C82afWChq9YWh8ws9G8Mxn40tP1FMgFeJw3igq/
    7iPc6nh1nX/NB32lxDYrSzQ1mF4YU4WilWmhoSLeg78JloBwBmC45O+6h4XA
X-ME-Proxy: <xmx:I5dCamKBecsIvHRTs86s7_UMNMQyF4VfTO6wv8sfOFicnMvOAY836Q>
    <xmx:I5dCatKhWeWhuybIyaV1aL_pZOF0pD_VdovgDw0lObYC_lxqQBUnww>
    <xmx:I5dCam1ygCErQMLo99_D0L_5-34w1LIlYTQEGpJyn4JSFaCCkqubHQ>
    <xmx:I5dCatyNiRsJqyMNLB5UB_39zZ8g0COnUVokKpTu8WxgXOfpBZtTqA>
    <xmx:I5dCam1Ngh67dJljnvhol0Oi168Rb156u1MIFMAysA-Umwqcqk0HfOvm>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 12:02:42 -0400 (EDT)
Date: Mon, 29 Jun 2026 17:02:41 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev, akpm@linux-foundation.org, 
	rppt@kernel.org, peterx@redhat.com, david@kernel.org
Cc: kvm@vger.kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v7 07/15] mm: preserve RWP marker across PTE rewrites
Message-ID: <akKWzol3mExZhVYq@thinkstation>
References: <20260629120749.566063-1-kirill@shutemov.name>
 <20260629120749.566063-8-kirill@shutemov.name>
 <20260629123320.1EF891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629123320.1EF891F000E9@smtp.kernel.org>

On Mon, Jun 29, 2026 at 12:33:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] do_swap_page bypasses RWP tracking on non-exclusive private pages by resolving COW faults internally, dropping the RWP marker.

Okay, this one is real. I will add test-case for it and fix in v8.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
