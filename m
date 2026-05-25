Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CE3F4118;
	Mon, 25 May 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722976; cv=none; b=vD8RFUGxe95SoZe5zlkt4oP3YiUvdRNW3LFVFOqe8qC9N3qYjIP76m3nEJX/4NJEKSA1uuThqK1kvWONYbBi+TIL5+rABG8I3sQG6RdMb5aIMZJ6xZ/p9wCBbx5njGaWmtB2ilhaNlmKWy3jvO0FfEWzd9I+tBRe24NuqKqY5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722976; c=relaxed/simple;
	bh=koERo+4Y3qdd0524f0iQzC6a53FijMr9oIq7gaxxlSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLJp3+LpzfMN3IZBLuj/mSCYva9C6M597mbnguQ+c84jJa1cqnYnibqVubDZ9e35+CRUu+BYodeRDJcPSy4ug6yYBd+tzOPoMXPXWzJhH4XCzDtaCH8kkrwTeUyHXOoQ2p7J9N427ESu2JOagf2t7ndSSD8lpm5XlY2TGy7Hr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=mQNEqOkf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bAK4oyEk; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="mQNEqOkf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bAK4oyEk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id A081E13006FB;
	Mon, 25 May 2026 11:29:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 25 May 2026 11:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779722973; x=1779730173; bh=koqpQdEmzECFo5R13UjpmYRDc4hRc7E7
	6rF4OR1LfuM=; b=mQNEqOkf7IpGi3vGbbjzUi4EdXEo6i6Mjljoo1lxF66paGpA
	1dpprCzpnhoTyreHsdhzPSubEh2iCQaU0g/Fy7yYQpDKCDJpN3NCbPBkfrCPn1nm
	ignGr3nmVkxHGLfC/JvdiRa6n1k1m5So5a1R2iYxE55BZpOyTbcXSp/YGorUlUeE
	ALMEwrfiZA+sW9aViJx19V4aHfwIJNtMa7o3xuujvD+GzoH7cLOIaD6oCjsMHATt
	p6gASQT1eemlldTDOwD0nxu5qXs6FOVSvxJ0txs0N0dYoS157NY9zovux65vz7zT
	kHml1WbnYs5ThOUxS0Sv0+AC4Ssd63zPsLSyTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779722973; x=
	1779730173; bh=koqpQdEmzECFo5R13UjpmYRDc4hRc7E76rF4OR1LfuM=; b=b
	AK4oyEk51g45pbTr6y1pt8ZOLG1Q1UsRKZsh+WZpF9b71ZKYMhnqdbDxGsoEg2kO
	ZYytwgWkJJ3TClxzvmr/7kFPk5Z3cy6yWo74nB+sdJjbJ0MdZlxUncRcU5iYj/Bg
	JEFN6y5ZaVYwXW94iSd5taqg7KyMHT/9NacQLs2v4TsiLPrghmMxz+rcEynIZhtD
	4jfN0WmtllBsCBYM/0YQ27Ek8EITHTEUf0GmByNXxkkvF112UbTS8+lzgET/3Qzr
	jwjPglY35fmWwOHt0ba16zwTsoD61jaX5mfRq4Lcwaku5nW6lQTVVnx94cfd1fOe
	wD2atHYen7DsfNsGeOUJA==
X-ME-Sender: <xms:3WoUauZwniadSV_0XJQRR3GfbfqezAgVOnEiJXQvVGpDxxbEcg-8ww>
    <xme:3WoUarX7I_TM33rJvpXWGdacq2w_BXWHKYsKrDtT4MqMNZuGuyvszFk_XbJRiYcpM
    ITuA0dRxGnyQ0Gv1AsiXpaRtcU4LdLYpXaHIIGKxK5Q3609Zv3qDj0>
X-ME-Received: <xmr:3WoUaq3TMWAAgMf8vwCjKN6t-AtgQq3AYWTp4Zx9wziGwgpipvalglWr7wgoYg>
X-ME-Proxy-Cause: dmFkZTFSztvldXVRZEX/sh1yXy8WVaJ330r2bAU/myjOo0zHQHyhaQcNvZ+pEoT1dFLitq
    y9M/24rkaHAXtyxJ8+YKwCOK5OI+TxBImPalB+hF93G//nOGkpwin3NA+Xhgw0dprXVYJd
    OlxJsf+n+k0eK5y68GajmHiELU44SlxGcmIWwYVJzM2LiyPtdPpv8KWzen85uN8aL9q2gC
    ACJiqgb+7E7PFVNiU+XMNhLKGxaUtcBWLPmyA7Crz0BpRKvP7IYztEWEggnISgXD22dJXN
    qy0iXTQU2ZIC5hEXp41L/fgWtwkvSLwzwODrxIvGKMgxGwmdLTalZ1mj7jeAiLk4m9LdPM
    /mk7fYPYgsZgbWYqVddSXwx0bpB0rF1U0eGSxOsGKQJOGmlu9RA+BNOgIAMlY1JkYef/6n
    gRxko25ObTCU8piLty0JYHtbTDEkXe2qxSFpYtCcjj2niIPen9VcygMVt7xm+ZR/A+RXaj
    3zKfrkQ3nU+lleC+rxPLnmHTlV0KL+0aMeY74mmoZjh0sP3KIbPOMD/p73DF1/b6pr9Ang
    /cFLnkCsXwRrIkajp6uUYf9eSjOLmDIoRa/WSPV8ZSkjt+T4sbHnzLdz2Nyq5vZi1KuhCe
    ToGk/UwYCgmZ+OMsUIYDTVI5kx8eei2qnuHFQgVRWuu2UDZ8Ha6vRrVcYIeQ
X-ME-Proxy: <xmx:3WoUasEN6LhIkvyVDGDHLBmki234R04Rze_yFsGsgfwezUtJjZZwKw>
    <xmx:3WoUajAhcewLM2mBs-bYnzhjRx9suE8c1ZWBT_7hb3eGcfG4guupuw>
    <xmx:3WoUauMoy_ZRzMXlcCosqpFVASZnRe4r0oLoV4mnoS89y9y9rNfl4A>
    <xmx:3WoUamc98WHaFJlzMMrOOsufxmvDJruVtd3npP0G3rZ1SfXRnRbcDg>
    <xmx:3WoUaiO6L2fCVXg-dfMrikcfQFbyI6ML7eWFPiiFicp7NxgUbKu-uTpC>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 11:29:31 -0400 (EDT)
Date: Mon, 25 May 2026 16:29:24 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 10/14] mm/pagemap: add PAGE_IS_ACCESSED for RWP
 tracking
Message-ID: <ahRqq3NBCEVx9BTU@thinkstation>
References: <20260525113737.1942478-11-kas@kernel.org>
 <20260525122659.BB52A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525122659.BB52A1F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 12:26:59PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Returning -EINVAL from pagemap_scan_test_walk() aborts the
> scan destructively, permanently losing read results for already
> write-protected pages in preceding VMAs.

Confirmed. The non-wp-allowed branch right below already follows the
right convention -- silently skip with `return 1` so the walk continues.
Will fix in v5 the same way:

      -       return -EINVAL;
      +       return 1;

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=10

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
