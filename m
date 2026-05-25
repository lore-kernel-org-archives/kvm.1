Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6CB3ECBFE;
	Mon, 25 May 2026 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720223; cv=none; b=La4SlAjKrBOnLzJ0rkwU2I4JZ0CUIMD2hpfi1M9w/mnRoC+9tWCb4aMeUYm5sqpMVKoXQ/Iro4Yx4a9TSEHsMidjXAOePBgSSasveIX0Vao+r6xTMdk9pDMmhHt4d8d3bucTvM/Lp1SjNmAT/0tfMVFDBrBZKaCIHKI67MAVXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720223; c=relaxed/simple;
	bh=F0Lm0LcqCC5MALcG4zIM9i+KOyVYSpXPk/cNJLJFNpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdjewFHRv6/kWhvx9CvfuSPE/XwGqushvkNdaHcRNWWvGtEUKH66MuQqb/tV5O8bsfmeQ7eJALcM+jpNmVocp59Hsm2TosxtfINAsHJEvreyehgPPP0p+yX0ce8kZZ1Yw+HyKStkWcDJ7S49v39p1ryDeIOfjZ8EZEEIlNWQOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=QLx4MzY1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dxh5/+Ib; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="QLx4MzY1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dxh5/+Ib"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 75713130014D;
	Mon, 25 May 2026 10:43:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 25 May 2026 10:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779720220; x=1779727420; bh=jX/eef+5e+3NDek/iKSvJbkHZklHUJeT
	i2/HuriPvfE=; b=QLx4MzY1ghIsPDK7DvdcQEEj+Hn0ha4L7WsGq2CxwF+IrpbY
	tY6GxCX1zDEUIdt3mL0xh9zU4RdSZbXHTIotgWFMiwrac7XeYRaOxubGbptxqchZ
	ygSE1CAB1jdb9zsF6y3+7CInZNpW9SP4/7AExcZWK3Wya+2chxVSiYmss6MtPbUV
	Nswb7nDKoqxzSyFRvtm/GKbPnEq0Yrvd7HQNjMIu8wMaHSqyG25Ct/m7ZaAMKrBg
	mJJxU1cvAx9Uq7+nK5lOUxgsEQTQDBXbx3IgiA3frgup7Mk+99psl/jq7lXEMpw8
	4IulQpaTLwPb2IEXoYOKIVypScYYvdlyjATNdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779720220; x=
	1779727420; bh=jX/eef+5e+3NDek/iKSvJbkHZklHUJeTi2/HuriPvfE=; b=D
	xh5/+IbJKt0UrVXTG7xh/AKcHWOxDBnngsFU+CMZrME8VM7hL4fHvNHUixJM7Gwm
	GcOXZ5Op1NSDwGrI8ci/ePdalVDPMmAM9IRbOM736xSDJEJKaUlgNyVezcvd3XhY
	ajE7b20lagvNf+qK7FcCbpHB24cLQFdYV7/ASGQInNP+OKFikJastY/Mxh3BStGg
	3iJEXgcQkbHC89RKLdhUi5muROdZa85OZFZsJm1sCzdVMSaDddNqZBiQfHIgbozS
	AnfV4LDtx/Jnch43qkCkAlbzdoCCpb9x4/p0B4biDJZB0kyme7b7zRQoVcA8pxU1
	EM4AxBj9+6df6sQYb7igA==
X-ME-Sender: <xms:G2AUarPuurAybRR1W02bopcZBTYLL8Jl8bubcJDwZ3jmfALv9LrX1A>
    <xme:G2AUauX8bX4thLhh8_JP_mewrlbwi8wvQayqrAOwsPRYqDtqiffZPZy8gTLOdBgG1
    1_3MATGlOVS7xw_uzlB2xKlBfwiI0A-4XImxJd64RDNxVCjskn9cA>
X-ME-Received: <xmr:G2AUakixXQA45ImWqWahhl-JSybTAZfoog1dY9bnXoNHG6Qb7_q3hGWJHr60Hw>
X-ME-Proxy-Cause: dmFkZTGHZHLMjCHc643dxRklLh2oL/Fj1m4IuOELcM7KtVw32eoEW7vO/KG/cKBnN9WuTW
    xcg2IQePNYL331E/+iFrg9l3Q/0DfWc/pfzb7vWOi1Q3A9a5dIAx/Ip8sizV43jID8qi2T
    lPu7yzYYlC4jDwy9+0KEeh9FZYrc3IDuLVpMqBcYmpa2tVNF4MKCjt0kSOcetEMay+qG0j
    wZaWuQuIE2LusEhaCt/KcTuXfzwWNSSA/a6+c4ZC+utd7D9qUqXsnLmKd9bKV8qtvZC2fr
    pc8OG7aEFZFvhoMbEdIROsQzF6nr7BIT6NX92DQHbwsijQVdrSxa73C0r4i4pngBeREvLG
    3IUYQFg2A7oiryRL0Qg9yRjN7sPoqJXEgTAQQW8GtIj+NZaALOuqBBtbIjbbByQVuCOwAl
    yAjhoMTqkzXacKIwL5WT8n63skY7u7qJc5CKpd5O5yD8V+4JcITXhwHDtww4umWoCclqdt
    /BGU1ZySYOzQQglFm1lWlxurT9bxoWiAtzasqvhRc/hSWaaiW0GldL0KLfJX42UagdICtG
    dlWuGo0+6np14viWw3dBgZ2PQd4AXFSXvzaH+0ARf7889aeda3v4orkzR9TKrkqzKscwd0
    unwzLm+7M4+hfY3iGBB7MVG8DfWOMGy9wg/MUa8W1ib7ggHvEHu0EyVKVUkg
X-ME-Proxy: <xmx:G2AUakQ1akuJ6fKSYRRH7I1cr7xRw2ADOhuOaK0bcLS26p4PPM0lVg>
    <xmx:G2AUagxFy3CLUbl5FyBELQ8A1sEn2Zapr_6T7SzNBUlax72GLiD1Gg>
    <xmx:G2AUah8OAV8G6zuRESTPGf9Ikf_YvelhAPuoJAPmR5tPWZa3SoOnXw>
    <xmx:G2AUaqbERbtgJ2nMckXzGoFxqN0PGUu02wow5r717_eb52V_igg2yg>
    <xmx:HGAUao7ZwTazDzOJEN2b8_Qz9hfTC-VqdLvY3yWovvLnIyULEM2jaPuV>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 10:43:38 -0400 (EDT)
Date: Mon, 25 May 2026 15:43:32 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 03/14] mm: rename uffd-wp PTE accessors to uffd
Message-ID: <ahRf00RTI4_0Puux@thinkstation>
References: <20260525113737.1942478-4-kas@kernel.org>
 <20260525120513.C51E91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525120513.C51E91F00A3A@smtp.kernel.org>

On Mon, May 25, 2026 at 12:05:13PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] make_uffd_wp_huge_pte() modifies a present HugeTLB PTE
> without first using huge_ptep_modify_prot_start() to atomically clear
> it.

Confirmed and pre-existing -- the non-huge sibling make_uffd_wp_pte()
uses ptep_modify_prot_start() correctly. Will address in a separate
patch on top of this series.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=3

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
