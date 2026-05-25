Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02428B4FA;
	Mon, 25 May 2026 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723364; cv=none; b=Vrsqs4MDRTb2ydLGZRz/tKCKWQJSS1CZdFpm4tOKmp2tokLKKaqjAfEQUj6ehaRh0hiLHdeZs/QDH0La0yjpnLx5fGbLIPH9ItBTG+MPrrUDZyyxUCCDcBB3OQLM9hTyJx1LXhmMltQtLcBldmYEWfMA9FPbtgjbSAfmmwh/1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723364; c=relaxed/simple;
	bh=WgQNan+Rj/ZCIZp5Wd9u7TydtZPpwppU0y5Y67C/OBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOt8SWt0P5E8MconEhA3Vfz0AM1AABuNoPv6nI756sIpyNQdr1990zSYGfHeQkhzihUEDjQGiLNMT0DjMw02rWDco78r/6JniLZ5lNDcCU0z2BdxLJ1+jPNH7bdsPTDMAyOzVh6X0jqD61wUqWhqLTmDDSSVpCZKFk7Hvp9Bc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=g2bcBDcj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMqSjtf8; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="g2bcBDcj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMqSjtf8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 9C3891300973;
	Mon, 25 May 2026 11:36:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 May 2026 11:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779723361; x=1779730561; bh=/z8wcQtqyiAzjZ3rldpoXVYMavh2Gjnc
	R8kmcwNQbbw=; b=g2bcBDcjtyuSlDgGqKESNqueo2kED4B8KIpXvOQl8WTCEGZr
	UmymP81CYj+kO6pyDK7xm7dFU3PxA8qYf6xJcFnL/786ABaNjbzxse92izi/y898
	jKlTbKaP4Z8L3U5fVUdiqwPE4DiV1u4HUFxOs566Jmms38QmeffgpfZ6VY4g9ZNZ
	tA4wBZJqIyOyapzR4EMYFv4uR09jNmD8hk6Eg9IRAs3ScDdsMdzbE1Su7Q3XJU7z
	taiRsNorzG3I1GaEwS3jiFUhBWv/Z67Y7ELeGDJWVsYRJFwPAny0zCMZXvrLmquS
	+ShcrtgBPsPwjIljoiXWoreJv0SqIbHlT0jssw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779723361; x=
	1779730561; bh=/z8wcQtqyiAzjZ3rldpoXVYMavh2GjncR8kmcwNQbbw=; b=u
	MqSjtf8V5FiQM70wcCRNVwoogYxkhFO3wh8XVE9G5ewYNRSVsoF885cjbb4COyN8
	+bbbWZrMAeiglHx0FAKICwo0P9epCWsS18CAbXCgIc7IU/d244dme7La0y9otXpE
	YtOMq67CANjgjbv0awArzXd1qMkxCKEDnYc+1dxxHKPOPngBWBwUuepMMMsk4yaS
	k5XYoD7Qp+I392RJEkBaPgsK0/OiJstGAu9zV8gpWX2Hs2iakBtX4L2cKo33QGOQ
	Z5gdT4iDq1lFK5/vO5NiMcKbON/rV4scZALq+ZfV+7rfFiGP+BHmbUk5byUtBDZz
	sNNLfv09Hq7qGbUr3Oo+A==
X-ME-Sender: <xms:YGwUaruXOIcT8XiAvdzk6TsP60JgP92VIy5X5-kc5AiyltRkCXTopA>
    <xme:YGwUak0lLHvMYa-o_mN96IPNiGL4Hjok7HdHyrmbERfJ0sk5bsR2MJGrqmflALfIJ
    ZDu_DVwCdMpRmfBiTkhs84trx1egoxlhum-TUiblY-fiqE7cGveww>
X-ME-Received: <xmr:YGwUapBVguWyJbI3T4Bsbry-xtBWn685oU9uOg75VnVA11BL8OPz6eerxkTwBQ>
X-ME-Proxy-Cause: dmFkZTFIo7qevfcZRkKkYg4AJgroQ60er5U9hP0PkiNilvpP646LWUxvbqRIWJPa6qUBT/
    q1bir7IUhm7NhIqRJFfsduPbs3QThEb70zjkB6WF8iLA1wrGrUkaKVDj+7NXDIaemdp3gS
    ce9FiFOKhFAw3hO7URfJdJyvtOTkVBX4m5Q2n5uPKPEL1b8omvm6vatEeoQkeCJPOQxOvy
    Ext2/b1kDK+McLE2qhtSWtkrLm+LvTcZRFdWtKjlRNamZaPOA6owaiP17rL5rdhCNgI06Z
    HPr7l934RX0s9JUYx1fmNIDLi1uwUcHMbcYXaeJf7+iOebUt7qgcx/VvqufCD6G2hPWnMm
    mF8Fo5Dtbvt6f7WbAR/DNbJnbY4wHLobPKDPFY0BqyHALjKTWYKRFKKEHMVeIloQ7Ar1Jc
    lbvceBdhk7+aEnaloHs5ZpozOcyLLdET4gdQAgpyyOVm0MP6zJdIZv66t0bpm+QQRs49Jx
    z60aY5lCzrkgfkN/u3NxvXpmdlCbUFEUIseSwjo+9Pr57sPIVC1toortyyKn9t8sewIYbJ
    i4FVyeCDO7f9Ay2b8OXoWTC5l5SV13EXDofOwKZjEbx5IyrJjRMTn6pZOoNfMj3cAT7UHD
    Bbb0uGU5wUhYHMol/dEP6qF/bRmh8Z9ZPbeKM+ORFr0UztFk6EHBOmjE1w3g
X-ME-Proxy: <xmx:YGwUauzX_Klu4tW9_W_Vexy86CgY3N80W38HR9Zf0hVBOwMhOrXMag>
    <xmx:YGwUapR2PRYU5nGD4tdlyffu-Jnnir3vmC0wcjj4r-rPaI34eiIjPg>
    <xmx:YGwUagdVgAKpeMa_EPyCPZDKt8uPnpnwSoroUSN4Ebie0N6faoSjNg>
    <xmx:YGwUam5lC0CA23FAwwTJy23uXGnidWdZnO-Iy1Y8WMltbMjayGxvJw>
    <xmx:YWwUarc_RtoyvlqzogMxJEv3QvyCKsNVHM8ji7zWbTxuNN4kRHwl_XkI>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 11:35:58 -0400 (EDT)
Date: Mon, 25 May 2026 16:35:52 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 11/14] userfaultfd: add UFFD_FEATURE_RWP_ASYNC for
 async fault resolution
Message-ID: <ahRrpnq0ZaugOhfT@thinkstation>
References: <20260525113737.1942478-12-kas@kernel.org>
 <20260525123622.DEF511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525123622.DEF511F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 12:36:22PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Asynchronous UFFD RWP resolution creates invalid
> clean+writable page table entries, violating the software invariant
> that writable PTEs must be dirty.

This is a false alarm. can_change_pte_writable() already handles the
dirty invariant: can_change_shared_pte_writable() requires
pte_dirty(pte) for shared mappings, and
can_change_private_pte_writable() only allows the upgrade for
PageAnonExclusive anon pages where dirty isn't required.

Plus pte_modify() preserves _PAGE_DIRTY via _PAGE_CHG_MASK.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=11

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
