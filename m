Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E1F3DDDDA;
	Wed, 16 Sep 2026 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581759; cv=none; b=tV6+//rjWNlK/OgQfeSllXFTv6dZkNDoNx4euKKgqUKvSR6mzpdgFj3a2tk9xpPd8sF2tHHhdNF4Wi7Vyj1sH3Scx5p7OeYueZLlZRZlYQH7a0zuK7L+s48Gy1aeA0TfMz8kvpZzyqLzz6s5aQ5RolaILn5bnwHW5DxYpKYMO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581759; c=relaxed/simple;
	bh=kxgsNNT1KvLPfb3YCHP70inh8dhJgSSo6EGOUD+EiRA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=a/GhEq8p8obqL0NCj9YIqdprxwxEYiuMgDT6zaLEWZ3t1+mOUEmMlquw46r31tkg0plmQUGdjqJXmj3wjxiPC/wRY3loFF9Mb+XFp0UwqCwEESa1KBGkqoEmz+JcNhXs/pctQ9lGX1r5wk7vrFZ4dehMDcYwhma4xKOmUIHLVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIOCba99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIOCba99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAA61F000FF;
	Wed, 16 Sep 2026 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581746;
	bh=kxgsNNT1KvLPfb3YCHP70inh8dhJgSSo6EGOUD+EiRA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=ZIOCba99yzswUHkcAeKvXEWO/4QfUMF9elUUGXb60w+iYrGhurwzzNKJDvqx3u7Iq
	 YgORqkWOt+1JxM3gK6RqnYFntMYjgloXsb6POOsDfMwcTqlkhFpzmzh2HwDHG8OKYC
	 +2IfdX+wqXN2n/LN/niNao/Vk7a67L6xKVwOcqz9BwwEXCvrAe4OZUTJ66TBItGxij
	 NiT217d2NRJxsFMsDYfKXJ1r7ZzzMa2g94xtyQaDvQn0HjZydFmjsK+KNqJkBtmKbH
	 54qXawlPjADa14Cmq5u0GLAUuwn3ZIPvhToyRmlFoJ4zDXXd857SxdOg2jQtKn9v71
	 ltjvLmFLWSXTQ==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 20:02:17 +0200
Message-Id: <DLGXS4SCP3VT.28XXX09BL963U@kernel.org>
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
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
 <20260916141718.GU3968357@nvidia.com>
 <DLGUPX9KPFKF.12CU304YAST79@kernel.org>
 <20260916162817.GW3968357@nvidia.com>
In-Reply-To: <20260916162817.GW3968357@nvidia.com>

On Wed Sep 16, 2026 at 6:28 PM CEST, Jason Gunthorpe wrote:
> On Wed, Sep 16, 2026 at 05:38:21PM +0200, Danilo Krummrich wrote:
>> Usually, class device implementations can't make assumptions of the unde=
rlying
>> bus, because they have to work for any bus. I.e. there's no other way th=
an
>> providing helpers and letting drivers do the glue code between the bus a=
nd the
>> class device.
>
> You should think of VFIO as a series of helper libraries. One of those
> libraries is "here are all the PCI PM ops you need".
>
> Drivers rarely need to customize these ops, they just need to wire it
> up to the support library to avoid a bunch of code duplication.
>
> Stated another way - the very point of vfio-pci is to remove
> duplicated code from the drivers.
>
> So if we wanted to push hard on removing drvdata, and don't want to
> touch the struct device I would probably say to #define up a way for
> the driver to build its unique trampolines. It wastes a bunch of .text
> but at least it doesn't duplicate code.
>
>> The reason this seems undesirable from a vfio-pci perspective is that it=
 is
>> special in the sense that it is a class device that is specifically buil=
t to sit
>> on top of a spcific bus device (i.e. struct pci_dev).
>
> It is a library, all these ideas to do things with the driver core to
> implement a library make no architectural sense.

Both is true, it is a library, and it is also a class device built on top o=
f
another class device (struct vfio_device) that accomodates to a specific
underlying bus (PCI).

Which means that this library has the need to make a generic connection bet=
ween
the class (VFIO) and the bus (PCI). And this is something that the kernel h=
as no
generic solution for (and isn't represented by the driver core in any way).

Your dev->subsystem_data idea would accomodate this connection. However, I
object to this, as it'd be for a very special case and I'd be worried it is
abused by other subsystems in odd ways.

Besides that, I still think that the correct thing to do is to have the glu=
e in
the driver and just provide the helpers in the best possible form. In fact,=
 this
is what a library should do - provide the helpers, but do not directly
interfere with with other layers.

>> It still makes me think that there should be some closer integration of =
vfio-pci
>> with the PCI core, as it is specifically built for this bus.
>
> It has such a basic need I don't see this as a reason to pollute pci
> core with any vfio specific things. Like I would nak your [1], that's
> completely wrong layering.

As I said in the beginning, it is just a "hack"; and in fact it is the exac=
t
same layering violation as abusing dev->driver_data or adding
dev->subsystem_data.

The reasons I called it "more reasonable" and "less of a hack" in my previo=
us
reply are that it doesn't break an existing (driver core) API contract and =
it
only affects the the exact two layers this is about in the first place.

>> > I don't really understand in a nutshell why we should do this for nova
>> > the mails were so long... Can we not just ignore the lifetime
>> > imperfection for this?
>>=20
>> I mentioned some points in the first two paragraphs of [2]. Besides that=
, I
>> don't see a reason why we should spend time and effort for working out t=
he
>> inferior solution, where the better alternative is even less effort, con=
tributes
>> to better quality and stability of the whole driver project and also off=
ers a
>> chance for the vfio subsystem to gain new contributors and gather experi=
ence
>> with the language that has proven itself in many areas already.
>
> It seems to be quite a leap that it is less effort. IDK..
>
>> TBH, I don't think it makes a difference; having Rust abstractions is pr=
etty
>> much the same as having another driver. I.e. it would be equivalent to s=
aying
>> "before we accept another pci-vfio driver we need to do some rework".
>
> Well, it is, but thats the point when judging effort..

So it seems that we agree that there isn't really a difference between addi=
ng a
new C or Rust driver in this regard.
