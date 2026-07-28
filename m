Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9753AB29A;
	Tue, 28 Jul 2026 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274482; cv=none; b=RK+opj6xWqfk3qY8yI3wXilLTyVF2Bl9UyLz6YbazeVkIcNK0cQU+fai7ZXklhAZHp2dXEP4aNF4ThRuwLmngvWURCXTIgjnyXdsRsR7+HOERfbyUTCDUzU5KZsjYyN+JZqTUaKEtFCso/t8uxmw0a3vOEr6m9TVaujwjZ4aoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274482; c=relaxed/simple;
	bh=KrNGcBrtF94hQOQ0bIIj8tNoLqypkvHzpxQPJJMBC9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfOh4T++sRRrfleXCuhhtckNVUSe6rUqr8JeluF0C2dPQ8T629etS4zZmGou1FygyQxJEc37ivZhbSevCFW98UWdnOcbNFsH4gBZaH/looPhQynofVklZVqIdFkI6pecZhzXdu32rjwocIV/0BmAoUOI12CqHaWpudMhF/xdU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elZw9SW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elZw9SW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FA11F000E9;
	Tue, 28 Jul 2026 21:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274480;
	bh=g4a69SCtKPEB46sFkC5XdPoAViC7+k6MUUWjIaweeUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=elZw9SW0AaZvXi39ERsxRM32w/+87KG7StiWgkpndZajLU1ZzWI8Xlg43xsqFiGrx
	 HxDZQiGF9WMGUz7ows9l0+LOF3n7kXW08bQS5PMOenVvpVvJJn0SkPyyPiTQZlC8mP
	 /y85N/HM+rBxicopu4ehNNVfH4uuJpSRleNo1euVYnQuImlklXkhywacLl32lqqXji
	 dexRTd+sqfxL0fOoNszG5I4+RZt5rAVMJQXnkC8rm2vZh9UhFkKFXbcpWa9KaUNd2Z
	 8we3nmQXao28qGdnYVpCVGwam6zA1RBkJE0nn7RlNQ+N44DXXR6y1tUbJ6Nom0lVnZ
	 i/TLiCbii5GYg==
Date: Tue, 28 Jul 2026 15:34:36 -0600
From: Tycho Andersen <tycho@kernel.org>
To: Alexander Lougovski <alougovs@redhat.com>
Cc: bp@alien8.de, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, vkuznets@redhat.com
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
Message-ID: <amkdorffsAuguuIk@tycho.pizza>
References: <ameuTMWJUZfleIbk@tycho.pizza>
 <20260728171356.96405-1-alougovs@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728171356.96405-1-alougovs@redhat.com>

Hi Alexander,

On Tue, Jul 28, 2026 at 07:13:56PM +0200, Alexander Lougovski wrote:
> On Mon, Jul 27, 2026 at 01:23:03PM -0600, Tycho Andersen wrote:
> > Can you share the code for the mmap + disk io + DB content generator?
> >
> > We're looking at this and would like to reproduce.
> 
> Hi Tycho,
> 
> Sure, here's everything below.

Thanks for this, I think I've got everything set up the way you've
described on top of 7.2-rc5.

One question,

> query_stream() {
>     local TARGET=$1
>     while true; do
>         case $((RANDOM % 4)) in
>             0) Q="SET NOCOUNT ON; DECLARE @s INT = ABS(CHECKSUM(NEWID())) % 2800000 + 1; UPDATE StressDB.dbo.RandomData SET Col2 = REPLICATE(N'X', 90 + ABS(CHECKSUM(NEWID())) % 10), Col3 = REPLICATE(N'Y', 90 + ABS(CHECKSUM(NEWID())) % 10), Col5 = SYSDATETIME(), Col7 = ABS(CHECKSUM(NEWID())) WHERE ID BETWEEN @s AND @s + 50000" ;;

my LLM complained about the '% 2800000', looks like it's selecting
from 1..2.8M in a 1.6M table, so the updates above 1.6M don't affect
any rows.

I'll leave these grinding for now, I'm trying to scare up more
hardware to run more copies since it's so rare.

Tycho
