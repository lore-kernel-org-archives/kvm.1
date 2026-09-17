Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1D4AC156;
	Thu, 17 Sep 2026 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656626; cv=none; b=eq7BMTKTJhWAHcAgA8tT0rgTdN0m0zcXCHhVG8Ina2QhjVSOycA31H38nzc3ZsNZl8x3b0fcpscSbcfpyCIVINUfxqtTMm/bIAXGQNJxu3b9hTok3jpmXliW41WZalBrzIM8uHgi9ERmaFioTF7hoMKoFNLbZVPADHcJlDLHm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656626; c=relaxed/simple;
	bh=eVWkWy44/qDOlZVCkQ/31R9pnyw9ab52gVT5TqfCAO0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=B5WIg1pt959W2s0tQyNkjhnyFEVjuZu9HplMLQ5/MLiL0D4/1lsGDOyBnar0xrNseqakZAXQvlsk6RcQghwuTgbWMFxVXgeG8hy5tMQq8Dc7Rad5MgSn7mmCf161IFD4uKYVhNPqbrdtBjkofn0unmbPVW/GEfczzYXKgb5YpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I49YKlLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I49YKlLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA801F000FF;
	Thu, 17 Sep 2026 14:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789656614;
	bh=eVWkWy44/qDOlZVCkQ/31R9pnyw9ab52gVT5TqfCAO0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=I49YKlLLMTvB9vk0Gu3n+YjOJxQEVSm58I+lrWE1hPAvm0pC4HCMMZO09nKz/PtPK
	 T8di+cUIcza7liOtk1FLG0eQu13im1F5RLxR/FnEUj4APzIvkoTDWIT6GO4HQOrfpe
	 0YKm03/7InEljX8XHT0fZhlI3LfH5lv2oZ9RdLOJpBqC6Ax+0yA+WIioS6T/41HtCV
	 WLalJcMYWSMMCF7cbUcN/azRmBMyU+j2N8/OOUZ1tjazujy/wvPlKWP9mbEDMDhTYF
	 4k8FAP2/3GmGn1J7a/WvJstSihDTq/G1PGgwB3XZs7a5PJvvtbjFnzhxS6hII9fhMv
	 Xhr2olBbgT+1A==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 16:50:07 +0200
Message-Id: <DLHOBJB1NYJA.3FCP9OLPBVRZA@kernel.org>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
Cc: "Alex Williamson" <alex@shazbot.org>, "Zhi Wang" <zhiw@nvidia.com>,
 <acourbot@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <kvm@vger.kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
 <20260916141718.GU3968357@nvidia.com>
 <DLGUPX9KPFKF.12CU304YAST79@kernel.org>
 <20260916162817.GW3968357@nvidia.com>
 <DLGXS4SCP3VT.28XXX09BL963U@kernel.org>
 <20260917132829.GA3968357@nvidia.com>
In-Reply-To: <20260917132829.GA3968357@nvidia.com>

On Thu Sep 17, 2026 at 3:28 PM CEST, Jason Gunthorpe wrote:
> On Wed, Sep 16, 2026 at 08:02:17PM +0200, Danilo Krummrich wrote:
>> >> TBH, I don't think it makes a difference; having Rust abstractions is=
 pretty
>> >> much the same as having another driver. I.e. it would be equivalent t=
o saying
>> >> "before we accept another pci-vfio driver we need to do some rework".
>> >
>> > Well, it is, but thats the point when judging effort..
>>=20
>> So it seems that we agree that there isn't really a difference between a=
dding a
>> new C or Rust driver in this regard.
>
> To be clear I was trying to say I think you are are underestimating
> how much work this is and how long it will take. Including all the
> preconditon C reworks has to be included when considering how much
> work is involved.

I'm not sure I follow what you mean by "preconditon C reworks".

Do you refer to the drvdata thing? That seems rather trivial to address?

Or do you refer to other C core reworks people are working on? If so, they =
are
only relevant if they affect the drivers. And if they affect the drivers,
there's not really a difference between adding a new C driver and adding a =
Rust
abstraction.

> Why can't we just go forward with what Zhi already drafted? Do we
> really need another side quest?

Because I don't think it is a side quest. As mentioned, the FFI layer is al=
ready
more complicated than the Rust abstraction we need, and I also don't see th=
at
this work is progressed further than the Rust abstraction I drafted. So, wh=
y not
just go for the proper solution right away?

I still have to finish some talks, but I could probably finish that work un=
til
LPC and then we can walk through it?

> I cannot forsee rust bindings for vfio until sometime in 2027.

What is different in 2027 than is now?
