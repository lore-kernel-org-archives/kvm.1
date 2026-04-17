Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2026158C
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393466; cv=none; b=SQ2VT7mbUiQBMa6EBPxGwbEtM/YLdbNrLiER9b87/qFhnmg50tiNfyQvrNUTPzT/0UhWtZ2CmSmaYqE9bSucm85Gh+n9zoO9x1JHkMJYzMuJoD3upXXmH13SAdciPDakuAI2HmSR2wj+JsCWbMRPYR7otwB/glf6E09Q8sUqxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393466; c=relaxed/simple;
	bh=hG07uEpQGKoOxyCjyUV/VwJZrf4nzcK5TKwm68m2qAM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NIDWQecs1VoCJ3D7qjueMUO6efF1hJiZ+MGUoIfxlfkRO5wKzGfK8If6ltGYLGzBjj+x8BUg2cEApczE/qXVYKtVoD51quOUo5FXIvMPRwd5oncFuXXjTmvmIVNkLjCMcr8xXfqP53ktoSVoFM5nCxoCfOy8KAaCkZWM49aQkm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNE8OJD8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNE8OJD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9753CC2BCB5;
	Fri, 17 Apr 2026 02:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776393465;
	bh=hG07uEpQGKoOxyCjyUV/VwJZrf4nzcK5TKwm68m2qAM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nNE8OJD8nhisgVs1/lTgzrfz3qKePv+EDgAKMTG4KzZw27SdzKqyaiWJ632cU9bI2
	 WQ2fkoado0yL7Tdg0J3dEZtZ4SrjPDz2SV5qb/H/STQx1tJBnGi5eq/zomnpCulOGR
	 7Uafx/Pb47Spd2YSawTT+qPWtnG0Lg7ndqSzqZc29nyPQSwUma4KCaKWxiz/oNh5Qr
	 binQvKVBYpsVbYANpDArv8GY3+dQhVlShKQd1fJm8zlmwl+F8ajsHEslatN02F29t+
	 sSdB0se23SkJMEuxFNQ4f0uXXJZ8cQ9oiwXS9OFCqj9YcCy8WX5pAXuy8QbbVMEs+r
	 S8eMYoY3X6D8Q==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B39E6F40086;
	Thu, 16 Apr 2026 22:37:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 22:37:44 -0400
X-ME-Sender: <xms:-JzhaXaOcMwbV5JZ9v1pubw-gBdvKHSEhy9RZ0bdFyOSfUA1t99Djw>
    <xme:-JzhaT-I9r-Sq4pgC3Kp91KQp4xGBfb68AI3uIRNM4vtHfuPs8XIlpOO3A3JAInm9
    Nxev-m3VXbCA4CuoUB6j-I6-nWoPlegCv4so1bMZfi2rggFzx94vyY>
X-ME-Received: <xmr:-JzhaQYLJAUsK1YMh9N5JAnbMRmMCzwIZXSex8yZ0wQ1l4gZPjrjltilua53EK0S7CxCodjJPFO3Ah7Wb7YygVKqp75ZVVoTaE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtqhertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    eukeejudelveetgedvueffjeeujeeuudevtefggffgheelkedvffehtdejgefhvdenucff
    ohhmrghinheptghonhhfihguvghnthhirghltghomhhpuhhtihhnghdrihhopdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfe
    dtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhi
    tghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvmh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlrdhrohht
    hhesrghmugdrtghomhdprhgtphhtthhopeihihhluhhnrdiguhesihhnthgvlhdrtghomh
    dprhgtphhtthhopegujhgsfieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhrrgdr
    figvihhnhiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:-JzhafPpfDcmRUNKcI3SJqBsUOWp8D888W4IbIM-0JLry3eemuxWLA>
    <xmx:-JzhaUBOsZJDJO3ub_wALDJcpY8F7FcBuJOrmhmSNqi_Ankq5g0xKA>
    <xmx:-JzhaeIspthM3hfg2VB0SrpMu0wy9-ug6wtobzn4-VWySqIvSLpDDA>
    <xmx:-JzhaVMj1XXU2nQYgadM6tJ4DikC_vo9b_VUseopky01VK4U3KbaAA>
    <xmx:-JzhaU5ajcf8VZwDxDgqfAtDU87EJsLol5crp0dhPnbCt_HL0I5gzncC>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 22:37:44 -0400 (EDT)
Date: Thu, 16 Apr 2026 19:37:43 -0700
From: Dan Williams <djbw@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "michael.roth@amd.com" <michael.roth@amd.com>, 
 "Xu, Yilun" <yilun.xu@intel.com>, 
 "djbw@kernel.org" <djbw@kernel.org>, 
 "Weiny, Ira" <ira.weiny@intel.com>
Message-ID: <69e19cf75b5e9_147c8010018@djbw-dev.notmuch>
In-Reply-To: <CABgObfasYTWmuqkz4TaTprcivwkzKGxAjdYZJVgO66HB1wK-5w@mail.gmail.com>
References: <1f6e9052c0c748f023e880503ed0001a9a919599.camel@intel.com>
 <CABgObfasYTWmuqkz4TaTprcivwkzKGxAjdYZJVgO66HB1wK-5w@mail.gmail.com>
Subject: Re: PUCK follow up: Trusted IO call details
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Bonzini wrote:
> On Wed, Apr 15, 2026 at 8:59=E2=80=AFPM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
> >
> > The call I mentioned is officially called: "TAC Subcommittee: Linux K=
ernel Special Interest Group (Linux
> > Kernel-SIG)". This seems to be the info:
> > https://confidentialcomputing.io/about/committees/#Linux-Kernel-SIG
> >
> > Paolo, unfortunately I did remember correctly that it is not an EU fr=
iendly time.
> =

> This one is friendly (9AM PST =3D 6PM CEST). The unfriendly one is the
> IOMMUFD one (5AM :)).

There are couple topics at present that would be suitable to raise at
the EU-US friendly time. Specifically whether all of the per-arch
implementations of "transport large attestation evidence blobs over
shared memory from host-to-guest" would be better served with a shared
generic transport (simple virtio-pipe / something equivalent for vmbus
to publish).

Then there are the next steps with the uapi to convey PCI device
attestation that was proposed here [1], and also discussed as part of
the Rust SPDM proposal [2].

[1]: http://lore.kernel.org/20260303000207.1836586-9-dan.j.williams@intel=
.com
[2]: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch=
