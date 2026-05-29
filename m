Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C892E7378;
	Fri, 29 May 2026 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071003; cv=none; b=BEy/tu7kcWlrjoE8D0TS8MncgKP/JhA2iiesYiOb2Hyq+V+geEWholu7Fn+E2zyOhaNozH5tyMWNhbcjQ30p2wFMEOPuO0Wz8t3CYxOoobEGgEFZXpe5LsgR6neaDLmY3gTNn9rMEl11SLF1PMNtNPptz5nuDya7ixFZL0NobAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071003; c=relaxed/simple;
	bh=ueMbKYDnjG/pPkozcvq1hNvLbgzbX4F0xs9sWbgMRyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeymAD8vU/EqAqGdBQH5y+FjwEJf9tVEbSsQmaltwoUGp0aWFjgzLq09Iib70xWXst6IsT8/Ey0Z5r3oGob+KE8YcVcI83KYHxLQOPM/14Jd8HZGGZQ7IEzL7CerARXUxNARZn9nsodxD05kuyn7GNVjheavAHQ+wG7M+d3t+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=dx790+gm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XzjWYWA2; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="dx790+gm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzjWYWA2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 8E219130017C;
	Fri, 29 May 2026 12:09:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 29 May 2026 12:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780070999; x=
	1780078199; bh=yCQGxE2VwZ7TPyH1GENnw64ogNKLMsypG7SdY7O7HyY=; b=d
	x790+gmFOOG9v4AuVJP4ne6bRgdnfCQusA6mDuRfxN+aMBZm0kvt3wnU/pQeM+CN
	39g8UHT39sT3ktgE8mrVsSybi6u7Suk6K3GB9lcXIBDLJEys60v8ontI4U+s9zlp
	T4iYlyY8kt4aEBJQjexUP35BvIns5SAO8obRtFrCE9Gxj+axX+y3ZKofNhMxwCjV
	DIagvUTLnSYY0OxSfoJGdFu1qmeFAf4jHNxhwKyCENto6+BWUOIm0CsMglsEg7G9
	oTXff5K8+JWKdrVUY2sO0CS7nleoceCZNXqN3QeXpV06teB7zZMxM9+th1ladti8
	Q7hVeSIefKnCrOg2vr4cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780070999; x=1780078199; bh=yCQGxE2VwZ7TPyH1GENnw64ogNKLMsypG7S
	dY7O7HyY=; b=XzjWYWA2FQxK/sdjf3Ns4xQt2XwlqavTtO/b0i7jHjVEqQs6IZs
	Xk7OtncmEJccbLGx1TCq3HrtmigP24BtojTYLnv8lx2ZD2SmxuE3jZKVeNQmp7Zr
	C/w+DA7rWDavQvu0xbUGqKJs7XFerdMLnhYma25urvVM6Y1mzGupa9PK9QJ/Xiql
	6xGhGQzdieRgB/BM+rx3CJPad6rotOF2nD0+5orpWJ1GCqyu2oVJ360Q3h4gD6Dh
	xmtcR6868TTK1n/hVvQLHe6/UaMCM8eTf4jPydMZNjwGMcznykbrVKtDHefoLeHF
	Vk2zvjzlgy08XXRhJg2F/Sf3LrFpWqjSStA==
X-ME-Sender: <xms:VroZaiYsZ3s217W5f-7Yot472V3xNeypxcJfdq-lZPZ2zBxLt6w_Yg>
    <xme:VroZatx4_egnkCHb_9gr2HO1f1PndNcIn_8GDr8p4vAyTGCHbKghHY3ERldVpZfOv
    KxKvvjO7gaUh52NcFGbq_XFEVREFwQT87gUuoJBQ1_V3teLy8I3QlM>
X-ME-Received: <xmr:VroZanNjicJKD2ueeW2Q6rlSuSxp5Lu2S-vvGEQzskUPdPuR_-EbQULwg9JeVA>
X-ME-Proxy-Cause: dmFkZTF5GxdEr1yCvZ6kyFvOzvHVs6SwkJfUGREcVnkg1W8F4OQC1NfE6tZFRjuAEYN7CY
    oaeGvqirqC7MgUTCKRTPqriH20k/xhHdv+L9upsVMvX2G0Ehd95vRdHta+K3je4rJQBnCS
    qAV7t2idhxq2AHeyEs7ThD8S9VwoF45Rgg20qllo34+oUy3TVn6bXp7RhbnqeiMkplmiE/
    vGDHTQ4fr6VkZ3xwGpfyV8Fpf0aTgcR3ui/oOuiF8Lrc3gIpmXEAc8KbPGQDXs4ubh5AVO
    aEDwiSBAL68wmfFNOohGfrv5tNlzCqN22kr28c1/AEq5T/PDAjboCyvAd+YtMlbSzDrvOg
    5ffwJyVINgO0G/FnM7vN04WA3yPEDhlzsEEWsbxItMdALnS7Req6yihD4HKG27eTCIUWsi
    3K35QliMA7OJhexc3hMbSlu15zDC0Ubi56fAUo9qu3dhOy/zSAoOCX78c6uLEoWiaYn6Qm
    1Vtru0/IdBDvXgaSzsTuIQKqN61p4z/8JVhFETigfRfSgLIn2zrqhBrKyvPS+j/OE7l0uK
    zt0o7mgm8lOF+uurUs+vz7W5PONJEoIfYm8ADY7juvGiZRjRVsGCwxWLRRQQD+H2Gpi5Am
    znL2bTp4ZHh2vuBrcQHiY+cq5PFRj9a9Ihe7Ee/0ulN4xQH1W5I8EGaE6ZmA
X-ME-Proxy: <xmx:VroZapOzu8MWwtCKHQeztbejLKFN4MQi2TnVxrs6R92pa5qus8PKtw>
    <xmx:VroZaq8GzdXftzn4ApgZ8sKdAvtx8eSwHlqhZpMMapGCXvpVmYH_LQ>
    <xmx:VroZaoby_NAFtPQhj2dWHtxsDxUZOjCaUjcleAVcgLGn3bFEAKibdw>
    <xmx:VroZaoGOrnNd-hzG95vFOmevM9g64xdpwHnB_WIsMegvtQ8ub5XU7Q>
    <xmx:V7oZav4VZ1ZfLoykJzfe7aSwIPEi_N--zGIiXJ_TCAdDHftwfbCVW3x8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 12:09:57 -0400 (EDT)
Date: Fri, 29 May 2026 17:09:56 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 04/18] mm: skip out-of-range bits in mk_vma_flags()
Message-ID: <ahmoH9v6_DA2i_zn@thinkstation>
References: <20260526130509.2748441-1-kirill@shutemov.name>
 <20260526130509.2748441-5-kirill@shutemov.name>
 <ahmQvfNk7S4F0LBj@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahmQvfNk7S4F0LBj@lucifer>

On Fri, May 29, 2026 at 03:00:14PM +0100, Lorenzo Stoakes wrote:
> > Add VMA_NO_BIT and have DECLARE_VMA_BIT() resolve any bitnum out
> > of range to it. vma_flags_set_flag() drops negative bit values.
> > The ternary collapses at compile time, the runtime check folds
> > away when the bit is in range, and the common path is unchanged.
> 
> Hmm are you sure it does?

You were right - I measured it (gcc 15.2, clang 21.1.8, -O2). The
DECLARE_VMA_BIT() ternary is fine, but the "if (bit < 0)" guard does not
reliably fold: with it, clang stops folding __VMA_UFFD_FLAGS to a constant
and gcc keeps a rolled loop; without it, both fold.

So I've dropped VMA_NO_BIT and gone with your config-gated-mask approach
instead: mk_vma_flags_from_masks() plus VMA_UFFD_{MISSING,WP,MINOR,RWP}
masks that collapse to EMPTY_VMA_FLAGS when unavailable, so no out-of-range
bit ever reaches mk_vma_flags(). __VMA_UFFD_FLAGS now folds to a single
constant on both compilers, 32- and 64-bit. Added your Suggested-by.

I also took your "use the new API" hint and added a prep patch converting
the existing userfaultfd_*() helpers to vma_test_any_mask() (Suggested-by
you as well). One deviation: vma_test(vma, VMA_UFFD_RWP_BIT) is itself an
out-of-bounds *read* on 32-bit (test_bit(43, &one_long)), so the helpers
use vma_test_any_mask() with the masks rather than the bit.

> Either way, I think we should break out any fix like this from the series.

Agreed - the OOB fix and the other pre-existing fixes will go as a separate
series with the RWP work rebased on top.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
