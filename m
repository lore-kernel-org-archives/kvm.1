Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513B2EDD6B;
	Tue, 26 May 2026 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783568; cv=none; b=bOgWOIPq0UJ6yOxXVGcZT7NMvxqUaKJhCslhdAGrCGgY18vHLlxVvdlR8zkrJhYrmQtz6ieskHPBt6MtgphaCYVmw35YOFNAiggo0HWOTo7PkkZXxKKAfYz3J9a84wtHatumoaQLUgT3jXJzoUxipp8VnvRrryPlTzphUcjZvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783568; c=relaxed/simple;
	bh=k8RtWdr2AcJtsgbhOZVyq2BgQBN8G21AAOzH8w6CyvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyOG26GkrwWhuLaebbTiSewrPVjtGjmcm7knAOoNyRS9DWvliekVxWuiKrNee7G1W5IIVupvQeO9qQ12v2Vjewn4KRv7higMFmi9XUcYyhH0fpzDjmcP0APrUNugFgu7btqaECrtOyTQB5G+qAp9bSRn9jTJREThkmRoG3OhGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=NNMcuZoz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t5TCYBJH; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="NNMcuZoz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t5TCYBJH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id B6754130018A;
	Tue, 26 May 2026 04:19:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 04:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779783563; x=
	1779790763; bh=NZv6DmRHsbAvyhU5VLHqEzbXbswDumT7KoHiGFwcjS4=; b=N
	NMcuZoz+vT7pqMT9TnQljKDBpFqwmj78ogb2CR1FVUjR7CUPaGx1vVq3CNfa7M82
	S3110WO9V/RGdvWxThX00e48cgLPfYpl1ZRqzhLsMWUPToefmbgPXWVFDvpZFdXb
	288BzcyB2SFw0DoyBMxh+SzDJ5hN/Vl/76AjAb913P6h8WO0hniYifZWNvKxz3fh
	JTzg6Q39Hu8iT2pAfccvgva58NQ69JdFJ1+YLoFXDz24WVPIp0oLJLQYS6B7XyYq
	QYEpiZqy50vhSEbHW5ZRjul4gyEs+9eOS7NZMpaZtebqe1aH9SbG7fGNUhvTS/TO
	W+IVlFJ5KWrzoy57toDuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779783563; x=1779790763; bh=NZv6DmRHsbAvyhU5VLHqEzbXbswDumT7KoH
	iGFwcjS4=; b=t5TCYBJHdLNsxFEkQbKmYIRZwBaRBimwbvFosqSH1njr1zWX3dk
	U+K+G51A46JPj2GKC1/4UgduhU96c7cJKe7O5hnYMYXtxAdWX76pcss1vKsXEdBL
	vxVZrE62joOcTKRogMh1o1DfJuG0iL+AupHtuv3QJgMRMo6/x7d9yVVjV8dEU1zH
	0+Mykptm9VkCm2Yomz1fsSi/2P27mSnmHEsQp0uDGsv37baf+INpQ94jM+RD2Hvp
	S41wC6ZwTaTkxx/npE1lUjOKmexInMoRem+E75HBNw9Vw5TF4SyDlDQFodUxyk7I
	9i+Cm9mdPRFeZmBU0aN4E7/p3W0eRZAwL5g==
X-ME-Sender: <xms:ilcVag74itIFR2KD_wU1wJSlcm08voAA3bWLKq-EJag-EaC0YAFgMQ>
    <xme:ilcVaqS6TVaRJD54bayaqHjFj_TQYXKKjT3erd6dre_vcN0HiTdJHgZi58ISD7DS3
    JMdk4h_P4wFHNCTQaUIVzVjPX5F6ZtY13AC2yvDoC3U7GsW-bg75Y4>
X-ME-Received: <xmr:ilcVapsVL30QWKNuN98-R1YfLYLH8u37eQOQUh7eeidHZTJI6KzgwRda7ZUvyw>
X-ME-Proxy-Cause: dmFkZTGg3NKGEoTEY919NCtnOF8MXOv3USa+FVzdfGv8gK+6Kmljj9Z7v+MEhBOmgQ4iJz
    2wkryOqsOOaL72yi/M9sWzEc2149MsMisNlSFsbjS2gc4WdjUB1aMMawTlxaNfjsVW9dII
    R0i7J6B+bwSd+x0K9fRdEAtCQLXpfvwBXFKonzv+hsxozQjCRiBrUq+9trag9LFaMeWwLw
    uYts+B7zg01wIjauFMjqZkURWggbx/h2EfR7rxs3yAa1jzHPFQB6AGBsGlpCUDRbV4j4de
    jUbsEfDZQWvNRB2FmLkOYhv1Ae+RJKanr0+cxI61K9142+8LcdCDjsJjTPJZpjHgmRfSgQ
    b+kVapfvL/TRnNIo1+vDt9AEIpEhNalldrNMDB+L2DR2+qi/krrW0BjTrxC8M44EYkHpAN
    Kog5k8r7BvYencRrXX6SRUvv0VVL6u/Auw+3NsY9Fh0/tYV7mlNNl4AWlrFhZvycIA4NiH
    ONClnHj1O33ouGoEDFDI39O4wIb4YKoe1EPycCPzb6U9bj+9euSdE0cxwudMTPiPgZPO3b
    JDeqtl1N2YoBjXClkgqSPQyFk9WzsxFVb4f929aLSmtQgLD+NVG33DcGNYTQVcUWqllkdF
    2Nx8b9c1sR6/BCQH0FN55gMnfx1/9tPuR8eIUD1QQK8Z+WovoWueBlV5a9JQ
X-ME-Proxy: <xmx:ilcVapt-OAd4UoTqoiR5yS5t8LDd5Ctkc9mueTqlIRgTFzkN-5qlJg>
    <xmx:ilcVahepuMvCuvNXf2n_WXImHh3faz3xDbTkrsj79OJ7BhUEtGrv0Q>
    <xmx:ilcVas6IGiIsnNh9XJE3GNP0qZP2olrro0gRqCCkw7ybgOCPdOd3zw>
    <xmx:ilcVaik7rIxQdrGwf_D1Jk3lXr5gbvOsZFsUyjUYtbRkAtDHtl0CtQ>
    <xmx:i1cVagYklGZxC9VVnFQWBN53-Kkuw3Gg3XrNoE5Iff-8cbhsP3341TpK>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 04:19:20 -0400 (EDT)
Date: Tue, 26 May 2026 09:19:14 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 06/14] mm: preserve RWP marker across PTE rewrites
Message-ID: <ahVXF5gplFCK7HDc@thinkstation>
References: <20260525113737.1942478-7-kas@kernel.org>
 <20260525120819.C18561F000E9@smtp.kernel.org>
 <ahRk5tphnTx_CVnA@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahRk5tphnTx_CVnA@thinkstation>

On Mon, May 25, 2026 at 04:07:15PM +0100, Kiryl Shutsemau wrote:
> On Mon, May 25, 2026 at 12:08:19PM +0000, sashiko-bot@kernel.org wrote:
> > Pre-existing issues:
> > - [High] Failure to write-protect the destination PTE in
> > copy_present_page() completely bypasses UFFD_WP tracking for pinned
> > pages.
> 
> Confirmed and pre-existing -- copy_present_page() builds the dest PTE
> with maybe_mkwrite(pte_mkdirty(pte), dst_vma) and only adds the UFFD
> bit, never wrprotects. Will address in a separate fix after this
> series.

Looking closer, this is false alarm. pte_mkuffd() makes the PTE
write-protected. No change needed.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
