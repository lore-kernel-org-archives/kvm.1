Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B8192D8A
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865488; cv=none; b=BkziIXx0sU/YhHYvXa/GU4KvQ0WPkGXmCaZSiGrQYy3XN74Y4B7iLqXbjUHk2zoDNPNWKHK1Ol9qeIECM8jH/6BLWu0USc+3493F8PvPNOJ4SFERQslI8BuFllxNHjMnMlsTQVUabhMEoRdHJ7l5+lO84bc9HFrvnNFp302lhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865488; c=relaxed/simple;
	bh=VZtNvgWIY9khp30jLMx14u90vJGoVZATHasXUxg20ek=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=azAWoCElkH/z7u5J3EPt1a8jEzbfTTdE9ffUYHf0Fz/gUplsGrSncbWvxKzmVrpj230IvoW0uiUsGUPJ5m/X0POmQeMpTCbJ1FGcmW8lF2xVXUgXuUR7WPOcMc3bMJfOtXn9nJVk0eSQvhDd74VLryP43HzS5LQuEvhl3KY3r4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuDWMxhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuDWMxhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851221F00A3E;
	Wed,  1 Jul 2026 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865487;
	bh=VZtNvgWIY9khp30jLMx14u90vJGoVZATHasXUxg20ek=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=EuDWMxhQsKiKTntZn+vKVPvmalUqXBcEDJn1NksCzs52h8tw8UmwjQY0NRoJaX8Al
	 J0IDBaLakKBfLlnqZjLBU76jOHkm8BDQb/iLDRUo6CM8NO450x7LJTQA8Tco0D3Gx9
	 qulypna6QqKCK3TNOx9k/CGHFfl8gAUNUJHDifIqBtXhtCIIz2c5wfa0/+FtdNPcUp
	 /0oQ6czYN6ONlzoGgTuOBWn1q/uqgtX6wMY5hedqj68AeeX7jQvhz0zbgXwZHwUIcp
	 DlKmkJ+dNxUdY60RsLzmd6T1GGn6Okdj78O2PPhYey5Uv8b/NYckEXw6fYbCfairAX
	 3qYhYCQT6+v7g==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8EF56F4006A;
	Tue, 30 Jun 2026 20:24:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 30 Jun 2026 20:24:45 -0400
X-ME-Sender: <xms:TV5EavqyYJf___BIvm0ulRvshbi0tKOqG_HIQ48dNMtqTa9dtZc9oQ>
    <xme:TV5Eaq-BQr2AzoZ8X6_KGVwBk-w-DK8hz2zy9Ue9dIgeVADnCa4jfVtTfyeMO-FE4
    M-l9FGE6tHdNZA5fHxWVlh0ncwpcUPbv9Cuapwnn0P3HrsRI9ORJLSY>
X-ME-Received: <xmr:TV5Eag12V0AA1v_ZmbvHn4MYAWmv4Y4VQZMDHpb-eISGK77z4ZpXoHJCd8irDbvuCgTTuWyJ_QtlNCuKOnGoJkguFW9r1DaFDKQ>
X-ME-Proxy-Cause: dmFkZTGoZrv2fzkpxtidEv/NFUx1ansUsx+nsv9A0EhLzZa397RsmoD63KVKdzaChFn34f
    COVnzbgpM2/NiJMJXRX+oY5K5gDl/6ZBv3Bw+Yhvz9lj4rryI5ou1YrFCyE9KmZaRCaz3C
    RQyt8S6hSTqjKdCVAk6bZw9UxwlGDNueoChPmQhVoknJgtKYzNFlJCRC9YrXfiC/7lbjaH
    iRDdfgrDaJ5yiSeUFfFz/5K3JkEpNYcQUrhwYY+zBrKh1JL9R/xOgfO+imBIg8TwgR+yfU
    661P+t+BIGeGVlwZG2vkcMng6W5IftJ2y3EJKjbU52XcZI6NdQNHnyATgCDXkLwI2bnCfR
    AcxrLge8pzUh6LNgN/CfpCt82VMw+vsN8cS9gS8y9A2+F8IoJLHB1RUBT6l+URjEUGpDld
    QRosRVy7LPMjHEXihetJBdqlQadrg3BE/hpdoK3RnKBx8aqwp8kgh2AEoIqkUn/ZrgEgb4
    EWFCfyzFhtTkhOWvp4A0seAK464K8mnvVapuLkLWxnbAy91rtUKKxWqYBBvzZCAaDNFAsC
    Yoywz+uMa0rng5gb82mie8u6u0QTqi5v+rzEGwito2rIJrvZ/RzBmwEBMQi2ry+/HPX1ie
    /qWY7jWRPRAMV5M5iOCFT+86lKzIKvcENB53PHYgxw59kxaJLoDOR5iq0C+A
X-ME-Proxy: <xmx:TV5EalmZBL6tKf5HMG0vDrup5U-gEmRoEsUYISnPKSfILoK6liHaGQ>
    <xmx:TV5Eal3e7NvOYqMtm_1PvAVf4YNImKPkz5WVkkw3m8Qz0e-raAbL7Q>
    <xmx:TV5EasgCyzKIwPqAqb7FrzFNYkFFJZAYFYHfYKUM8Ati8vpZbWLuog>
    <xmx:TV5EarUiDtqANS8TovvUFGcmfiufdHGufu8H7EOr_8X71EYtTPmfPg>
    <xmx:TV5Eagy8R5ZnF3npBfv5g5eal-bomL-ezmaItA8v3QB3K-9tctfwJ8n8>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 20:24:44 -0400 (EDT)
Date: Tue, 30 Jun 2026 17:24:43 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
 "seanjc@google.com" <seanjc@google.com>, 
 "Fang, Peter" <peter.fang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
 "Hansen, Dave" <dave.hansen@intel.com>, 
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, 
 "Hunter, Adrian" <adrian.hunter@intel.com>, 
 "kas@kernel.org" <kas@kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "Xu, Yilun" <yilun.xu@intel.com>, 
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, 
 "Mehta, Sohil" <sohil.mehta@intel.com>, 
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
 "djbw@kernel.org" <djbw@kernel.org>, 
 "Maloor, Kishen" <kishen.maloor@intel.com>, 
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
 "x86@kernel.org" <x86@kernel.org>
Message-ID: <6a445e4be6b12_3a3568100db@djbw-dev.notmuch>
In-Reply-To: <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
 <aj1tFuwZWdPGfUoG@google.com>
 <20260629100301.GA1743876@pedri>
 <akMQ3J6fK3DUBsPH@google.com>
 <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Edgecombe, Rick P wrote:
> On Mon, 2026-06-29 at 17:42 -0700, Sean Christopherson wrote:
> > Answering my own question (though probably poorly), IIUC the answer i=
s that
> > DICE-based quoting is done through the TDX Module, whereas existing q=
uoting is
> > done through an SGX enclave and so was routed through userspace.
> > =

> > If that's all there is too this, then why is KVM involved?=C2=A0 I.e.=
 why doesn't the
> > TDX Module provide the quote directly to the guest?
> =

> That is a good question. The answer is partly historical reasons, but I=
 think
> the pros/cons don=E2=80=99t really move the needle too much.
> =

> The main benefit of doing it with the host in the loop is that the gues=
t side
> TDVMCALL quoting interface can stay the same. There is also a wrinkle i=
n that
> there is a limited HW resource involved in the quoting, so we want to d=
o these
> operations one at a time. Having a mutex on the host is the KISS way of=

> accomplishing some level of fairness for DOS prevention.
> =

> We should've explained this more, but TBH this solution is *way* simple=
r than
> the initial one that never saw the light of day. So this extra host wor=
k seemed
> quite small compared to what we have been staring at and we kinda overl=
ooked it.
> =

> The other relevant tidbit is that the TDX module folks have some proble=
ms to
> solve before they can support TDG calls to TDX module extensions. I thi=
nk we can
> get them to though. The question is probably really: do we want the gue=
st
> trying/selecting multiple interfaces, or the host.

tl;dr: FWIW, host, if only because this is one of many blob transports
across multiple archs that need host coordination.

While TDG calls to do the same helps a TDX problem it does not generally
reduce the Linux problem of multiple archs having multiple blob protocols=

to shuffle data from host to guest in shared memory.

The current direction for other archs (CCA, SEV-SNP) and blobs (e.g. PCI
attestation collateral) is shift the burden from arch/*/kvm/ to
drivers/. There might be a later opportunity to consolidate some of
those drivers' internals on a cross-arch generic transport (AF_VSOCK),
but there remains a requirement to talk to the host.=
