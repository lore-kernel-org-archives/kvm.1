Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16B38642C
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752975; cv=none; b=dilLysMlntjTF6zQISVv2JzoSddNlK/9Eea9tSPnDKK4nUZZ7P8Rty8+bwDSAdftmKwmn6DZhpI7W0YmM2gGf3WLEq382bb2+QXBdIyv1DISQMJTOhMEx/GQt1diKzesBqO0NkGzPh1z8zaQvoNNbrP9gV5lIKfF//UkO2Ah5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752975; c=relaxed/simple;
	bh=8uzwat79uqeekQiI2D0N16UrQ5QSzjT7JIKQzzcE93k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e4B6KPEydaMCpW285psfVeQpunJWssRyPhP0U3bkKrxWNVUDimYDDYxns+Aj1rbjyz4DHXq+c5UboxOPrqavUzrDEs3nCzyOrjRR1eN7ny0asMqtEwWhHftuzix9357iCzQoprMc51EXnbvkRZW8J1fOP1OeTqBdOPLWIepqWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzhJKZRM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzhJKZRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08698C2BCB0;
	Tue, 21 Apr 2026 06:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776752975;
	bh=8uzwat79uqeekQiI2D0N16UrQ5QSzjT7JIKQzzcE93k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pzhJKZRMPR49j83fvSl/k54OOAzhb4WScoQ0QCXuQq300E4DZIukb4RT8CnrB2l0C
	 KZInx3pdiZErj5XiRCigCrpvywxwkda73f6D3Mk6Ur85TF2eWLWuHOGbWdxr7ZEx2O
	 1dxfGceLtpqZkXXDQN7xHcn27cWErIVZNdLbFLyzusYVzVrCdHBou8qocwo+iEAPht
	 mBekQjNfyljqH7KYigb5aLkXJAsyQiXq077niXtEaJVrcxr9mDgso0kgly1G+tspZW
	 zBqacjdIoQAxVMNzfkb3bwQmDGkceVrxLHWvJzTbP+Xqxgu/Ij6ugIjrq1KAKvpk6W
	 AWY7vv+sut2/Q==
From: Thomas Gleixner <tglx@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "peterz@infradead.org"
 <peterz@infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <04969e4690e146fb90894bfb22b391249b4174fb.camel@intel.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <bb07d5ee721f5fd4e3a168fdebad1b450eb6bee7.camel@intel.com>
 <87se8pcm1l.ffs@tglx>
 <04969e4690e146fb90894bfb22b391249b4174fb.camel@intel.com>
Date: Tue, 21 Apr 2026 08:29:32 +0200
Message-ID: <87h5p4ddwz.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 20 2026 at 22:24, Verma, Vishal L wrote:
> On Tue, 2026-04-21 at 00:19 +0200, Thomas Gleixner wrote:
>> Thanks for the update. Can you try to provide the information I asked
>> for above?
>> 
> Ah sorry - I should've said that with your patch applied, tracing_on
> did become 0, so the problem was triggered.
>
> The trace from that is in the URL above.

I clearly can't read :)
