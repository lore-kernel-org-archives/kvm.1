Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F50385519;
	Mon, 25 May 2026 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723959; cv=none; b=n59fCAkaZP3ybymh5eFbTdldMMwSPQC2qQjn07FbqvgdpOeTxIyNU8IDxBPa+/02vgZxNQeHDQ4vjHv6GUsshFzi9zTfFDKrqCRelhpKf2LhXRP4u+0Zdfn7mRqzer85bltWBJf8wEfkiiuBKXQa8vM9eWqWf8PXXMheMJ3SHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723959; c=relaxed/simple;
	bh=KOqZhAzjtJtBwHSaXyz2h38NN0MODiw5DcLCHfbDSvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgij2gbeE7mH6SRfG9qsEGYQkgUSO7yHx962JsOBOhRyn2FKFUnlaAwnS7HvWaD/HBlZwM+6ZnCavSwwmCAXGhmOJfCEXSFRExnMiKFMhQDg8Ufr3rRf6tuxCF3ebe4RDLwwtj2LHYkOm/aUXflkOmpdX6Euh/dzYQ51Jg0g4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ma5UQJ+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g8Lqc5Od; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ma5UQJ+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g8Lqc5Od"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id ECF191300B16;
	Mon, 25 May 2026 11:45:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 25 May 2026 11:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779723956; x=1779731156; bh=ip/pTMIAjVbVqPVjzKxY0lQR6jtS4rsH
	p7ki00Fhc8E=; b=ma5UQJ+1HxHUqPl6eHviAS4IqTxG5x6lwemNJutSnqkYZRX/
	GrdAnincetnbUBfJEo8Uf9Binwnevi5D4brGSTYGKFHZx8Ue8QQkh1DnoSkcyGdM
	yy1TETa0hxKnlrul3pD1urd+txEbmG4Qw5wSFQTBC7dTc5G117PVjc+xvraMA9gQ
	RWi5/4BVzH+rAcj6Xj3cnLaQOwWcIVCRN1esUqwHUImlTZJEM501TdqVlWVspD46
	OigfDKo2IQBKN0H1rH9+oRWkdkNedX8EgaTmZ7qRusm5KYNEvuFt7o6J2nzZlFkM
	t1sdgRkAjfDx9m7/J0nq0c7L7W5ZQbx3S/tP1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779723956; x=
	1779731156; bh=ip/pTMIAjVbVqPVjzKxY0lQR6jtS4rsHp7ki00Fhc8E=; b=g
	8Lqc5OdqrG8KVcqLc8hSs3+dCflbvacl4qMZJzpBWtPKrhu7Nls17fjYc5GgdklZ
	3FylA5Ip2wfIWi297udqMADlhkwE4YJZsPDBS96a8I77PxVIHpnDgJ5FdwySPq6F
	kMhFSF1AhetLYQkfr9mCoIQW6e+2GGAhUarETgqw/PBIdr6MFLu72sKsdwyFoTTG
	9YVl8rliT7CZ7xqzW3nEV1VgyXWRxqZlfqUKNq6Up3q+5g2lL4KqYrHcJK2fUr6j
	oL57I0klUS3XZ6jWsXiv72ffBnKVj5RTnJnCJZ93khR2gapAAewwAn74/AGKlong
	1cHReWprQ6eNXAQI04Qpw==
X-ME-Sender: <xms:tG4UarufJ1pS8yJHvq3sQ3JXMSH_JXx9wHgKsymToNChwnvicHSaGw>
    <xme:tG4UamZK_AcXR1gdbk3xJTXGRm8Jo77KCsDFsF27kYDMSM-I3X2Dn1Tk2tOtqqUPl
    a24ggKC06zWm_-AO1Q76pCaeDowOwBFit2qjKqDFcuFcMjqtZGjuw>
X-ME-Received: <xmr:tG4UagpbKjNo4e8gkm7IcjMvFY77VTJfiHdvrZaTfCCUi_sgRsCeSn9RlewQ_g>
X-ME-Proxy-Cause: dmFkZTGEPse4hV1yBwsDDEa7O6Lryon99uUXj/XLpI0tprakm/YTBddT7aRX8pCTW2DPLE
    wxqIym+YUtlhKLJDWeGlCptVUlFMjgS9D7yuWlBIwCAwtYKi6zo0j4CAVYn/vgyZJPXLOG
    BYtH9Nh6HPuNoLdp1/VdWgbOADAvtxmistcJnr4qLuoaufELcanxBkRVcKH65VViIUzn34
    Kp2QKpFHEZKdG/bhngq9fPozMAPTXZBBmDnTHHXvVQgDsw5EQro4ZLXcqB86Oyr85j+lYE
    v7bqRum/AgTZ/4ycaOAngfI42jEaiRD9E5AlmyGSKpkOU4sWKlAkCcvM1cGoh+03YQwAYe
    nnqsVq+rVRt2NiwU2dBhlRF+qv7z8pqhrS5UI8bpuZZYV89Oi0hU0tgBFN1ZodV98iQb0E
    FW1DNGZ+w4zVPM0JtWFEgSKr7nkVvPN5dUHjpiTnHp72Jx2gxSPmoOiQ4ExnD8Ho0wZGBv
    4Mo136PpNq+Y6iIKKzJEDv8ioeUm4SjoHpF1WO9zK3BypyNss/gYi5SPOF7uqt/DdxE0WR
    PfNDy2+C2sdDdvfW8ZiSawPoYsGLAzWgsFqsuVZgFGXSF841JEkijnhp/52hP8runr/iWK
    jocfd7vA1jz/2HIV430lby+kADDjRfF97P22PEia4BdeDrDOS4HrV5bcbX6A
X-ME-Proxy: <xmx:tG4Ualo-E0bSbpj-R0K6c2ezKX7CskI6h1zweC2OSrwJERA8gtMaGQ>
    <xmx:tG4UalVIilCojT34Ve5jLdX1XGuXRxW_3nkk8kcIahh2npAT5u-SIw>
    <xmx:tG4UaqQRyFruY-TSYfH-QTZ4lgxDQ_51ZEacU3HVAbLyNx-AKvdwmQ>
    <xmx:tG4UapS9qR3zwCfHUz3ENlJXAmPB87qOe8UVK2Ix1mq_e9aQgW9ymA>
    <xmx:tG4UahyIrtMsYnxHF8yfapyuetGoRw0HB2E_MHPr0x8_ESmqG8oq--x->
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 11:45:54 -0400 (EDT)
Date: Mon, 25 May 2026 16:45:48 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 14/14] Documentation/userfaultfd: document RWP working
 set tracking
Message-ID: <ahRuaePllG4Xo_Si@thinkstation>
References: <20260525113737.1942478-15-kas@kernel.org>
 <20260525122408.B74CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525122408.B74CB1F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 12:24:08PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] The documented VMM working set tracking workflow disables
> async mode AFTER performing PAGEMAP_SCAN, creating a TOCTOU data loss
> race condition.
> - [High] UFFDIO_SET_MODE relies solely on mmap_write_lock() to
> synchronize with in-flight faults, failing to exclude or drain per-VMA
> locked faults.
> - [Medium] The example code uses an anonymous compound literal for the
> UFFDIO_API ioctl argument, making it impossible to inspect returned
> features.
> - [Low] The example C code contains standard C compliance issues and
> an undefined variable in the `pwrite` call.

All valid. Will address in v5.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=14

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
