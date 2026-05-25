Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C0386572;
	Mon, 25 May 2026 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723663; cv=none; b=E1PIv/VUp683Re4/VQxn1fSI/4B26GH3iZaW4VMVffLZZ702+syBJKr9rOxDQZKp248TE0JdurVDt7GL23p2TwRgAWawZwxpHVolzAh9KHfpU87h1N4OlpK6lH3feVg8yvnVsc+sBa6q8IsT0pGPmt/ED2T77eI716HmCCwFVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723663; c=relaxed/simple;
	bh=MeZfdtYp4Or92MH9PmAQLAg31Hk0PVg4fIYuCTiPEXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCux7NK9Dnh8Gj1xDihPnL9XplcKMCrH5P7Kn5TX1X2+tumQG2t8RXHnyoYjshab96O0v+1NR9krcq05/y/XFGeW2jHVYbjac7SRTLqxZHHfI4b/phCOf2frjz3h2HPY7QaqvrXSEp1OUkmwoNN+3fbQ8uONSqw0fBqDdqpdZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=vJnA9JPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h07oMABs; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="vJnA9JPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h07oMABs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 4340C1300AE8;
	Mon, 25 May 2026 11:41:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 25 May 2026 11:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779723660; x=1779730860; bh=S6r85cn+s0tYjNYeT+wcFes8DXkeNkXD
	uZ3gDEspPb8=; b=vJnA9JPYSXcE1aM3x0EGZAWwwVSMpFugkklacW6BM47LtO2a
	4uaYc3DXsJC/PgelfuQCRMlHVfww69f6Xt0eUOaXVEQZRH23rPlfHx/pWYVmwm3C
	KpXodAEbm0TjKaxcq816Kif0Z0tsRySXPJDRF8EkX7hMMkFABojTsAp+G8bmsE50
	AFM4iRRcpyV5qWsRuxYyhSpQCAt1nQs8e/xyLepz1BClyitaloSt0HdLv7dGC7xe
	R21lsidLcrR5QY3Ng8vQYM+edk9NJxxjKNPFD+lKzhpwvi3tG/8Dm22mI3LRrX3k
	+h5+wb655Rgf3062+Zm6NVfv6vMc1R4OaSMQLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779723660; x=
	1779730860; bh=S6r85cn+s0tYjNYeT+wcFes8DXkeNkXDuZ3gDEspPb8=; b=h
	07oMABsAEpTvwd5SrGEWVVvOhdqotPvRO5Ql1Wzfxo883AiNR8xt0VIEnhUfG+Dd
	JV6/lUbGRxE3uCTk35Dr+Fk0Ob8zNqBya4ylUporvdBXb4zpf0gdJ7OnMm24YJ6t
	OBebMgwYyi7fefZNFxY+tvKw2DQZWmgMedI3DqnY7UTp4Dk9h4Khlnk4jj9FWssx
	p9s/eber/QifNUNa/sjjvlfOCbDvzrHwsxk04PIEzxvcTANqB5sTQfWeDbK+apeZ
	jVJgr8LM8W8829c4gvdWDMLbuDkoRH0ky8cJMq+KkT9j0yXmXSWXVbmaYQPoFMLB
	Jpw43LwoBq0OgpJQiPieA==
X-ME-Sender: <xms:i20UauSh_dCVJbeTP56kimuJrtWPa2kVoksNlM7BYlSrDLvvbMkdIA>
    <xme:i20UasJO_tbPfslfr5MHiwNUHAtBtu0yx36lmuXbjM3XCQKbjUFKxXuZ2iUuA-Uc-
    bgmv74CKT-Eyh_R6HAvAgpGUYb0n-TyOR4ja5T46ph92sHQZlspxQ>
X-ME-Received: <xmr:i20UamEaGX3PuRCqowuVuHsnVNLpWh-R0UMnmcsmA7c3evmFTk4FpFl-5WDD3g>
X-ME-Proxy-Cause: dmFkZTF9Dq+do1pjsbXgPYH9Kq6zeKrlAj9bOft0Q/2TJpwfI2rC1Z0p4fA/pL63pzSruc
    zcaHVIMVJ+r2QVPs+AAS0OzZnc4MJPebalm2eqc6RbL5yfH39bzQIR/fPuUYf9zcWFg34k
    M0RP+DtT5NotOyA/iqYq/gUuvu3mn/tsPIoPumrt+aslhCvB38WXlNP+GU+PFIMfSmGlqj
    zW+m8/GW6UeUu2B8C7AOjXHFQfl1zT+J1FgcwNBRFWNmeyz11UAISxWq+XW0zX/mP87KGE
    gw2kaYPOcsZyd2aFWGYTltyMdZE5S7qgu1FKrMm9f2nZHkY3+LV60fTFyPne7bWM50/CeW
    m1qSc1ZemOSqsKK3dbkfcVQHa0JQHtMvz+KCbWnuFjAtNSX1So0K+xr2Sw1XsoC21rMhG1
    ZpGgDCgsJAPCq5GVr6EWlDkYzmpqfMj6z5MqcfFsHFDKzzPs25zZdd5kt5vo3hzAbqv5go
    /qf05PZdJQbWejVvZLYi7JhRR8jYLBy1myonRKpmStHIXY+2I9fRncq3MhMhiafyqVqkVV
    /WwbIR3K0IWpHENZuNYO2wpdKvyWzKwRpc6yLF0gO7fXuERDaNWVv4GPoFeZS6laT/dCks
    oCD45+DdF8pX4ubSmJjywxIJqgm7/wbIMAQ2/2nzUcWVH3K/o06nA76a8O0g
X-ME-Proxy: <xmx:i20Uaulqrlhm256mmOptSob3ueBQysDEqGAAp7AAcGMxyWLOGutMeA>
    <xmx:i20Uak1aJOn5UaUhh7rKFskA3wfkL_mTSdQPxp0JLgcez-40paTe7w>
    <xmx:i20UasyA85unvVqllEH_a4-sWUF0i62xrc7qQZHWiJLOxlPb5RSYSA>
    <xmx:i20Uak8GBD8Bt8tT6Iy80pHOagcm9HitcGqS3ho_71OP1qm_Sem-eA>
    <xmx:jG0UapTltX0tXUHqnqwnEsufNcvPtbohvA_imvg5BEC0D5g2HCYocSw7>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 11:40:59 -0400 (EDT)
Date: Mon, 25 May 2026 16:40:58 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 12/14] userfaultfd: add UFFDIO_SET_MODE for runtime
 sync/async toggle
Message-ID: <ahRsbwvg_hMZ8q3W@thinkstation>
References: <20260525113737.1942478-13-kas@kernel.org>
 <20260525124220.5336F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525124220.5336F1F00A3A@smtp.kernel.org>

On Mon, May 25, 2026 at 12:42:20PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The userfaultfd_set_mode function iterates over an external mm_struct's VMAs without verifying address space stability.

Pre-existing pattern across UFFD ioctls -- userfaultfd_register(),
userfaultfd_unregister(), userfaultfd_rwprotect() all iterate VMAs
after mmget_not_zero() + mmap_write_lock() without
check_stable_address_space().

If the XA_ZERO_ENTRY hazard is real, it applies to all of those too;
leave as a separate audit follow-up.

> - [Low] Lockless read of ctx->features races with its own WRITE_ONCE
> update, causing a data race.

Will be fixed in v5:

        -           !(ctx->features & UFFD_FEATURE_RWP))
        +           !(userfaultfd_features(ctx) & UFFD_FEATURE_RWP))

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=12

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
