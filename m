Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC6239E76
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777605499; cv=none; b=TNICnQ/wR9qh/QvjGR0nFCONbA/+jrutMLQpev4yakYvfhdYD8C2UBsjBppv5GVIlygjtdnP2cPPrTubqxYy6A8d3XuJhcS7Wydig5guTJfDdNUAdLWD2cnijI1zBlYdq2ulq8LApngIJTq/0Xif84Ak7n6en3Gi7GxYF8xLd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777605499; c=relaxed/simple;
	bh=PbiqOjTe3+Ie0UcWtJguEnYD1YjuKUSlCXK3FwYlGoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VWxu/AFzcy0knoPvbD3VRugJ95azutO1ISC4asfMxmGVl88wyAn33PbRtLS4p++hJ/+rcVXf7C8oVXmKzukAPSwTA2ejl0EuX3vizVX9/E78VmZD8mn5trBY5qcj0Vk4GsoVosmLL4vMd+wU9LceE6P3xcezPWLUQct0fzNSC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=uH9cYWUB; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="uH9cYWUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1777605496;
	bh=PbiqOjTe3+Ie0UcWtJguEnYD1YjuKUSlCXK3FwYlGoY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=uH9cYWUBtlm4lMniSle5/4eb+MDrWL+zjzVI7qcTErWFXVYAPZroiUNNQlucrV8Ec
	 QI8U1uKRPpaTNXmAu1LUvhwiJ+XpkC/nz9bGEx1Bvo7PtpTrTBav0J8WhtEdewZs0i
	 /HapGla7EGXil+ERHsU61Z33MA16PAW80DIp9Eho=
Received: from [10.100.48.88] (unknown [208.52.86.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 8F9931C0259;
	Thu, 30 Apr 2026 23:18:15 -0400 (EDT)
Message-ID: <a289e973308038d86f82d05249dc1806888ae822.camel@HansenPartnership.com>
Subject: Re: PUCK follow up: Trusted IO call details
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>, Paolo Bonzini
	 <pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "michael.roth@amd.com"
	 <michael.roth@amd.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Weiny, Ira"
	 <ira.weiny@intel.com>
Date: Thu, 30 Apr 2026 20:18:14 -0700
In-Reply-To: <69f401e46ee72_2fadd10073@djbw-dev.notmuch>
References: <1f6e9052c0c748f023e880503ed0001a9a919599.camel@intel.com>
	 <CABgObfasYTWmuqkz4TaTprcivwkzKGxAjdYZJVgO66HB1wK-5w@mail.gmail.com>
	 <69e19cf75b5e9_147c8010018@djbw-dev.notmuch>
	 <96b0938a2ec7a83c7d2010c6a363e8417749cc27.camel@HansenPartnership.com>
	 <69f401e46ee72_2fadd10073@djbw-dev.notmuch>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-30 at 18:29 -0700, Dan Williams (nvidia) wrote:
> James Bottomley wrote:
> > On Thu, 2026-04-16 at 19:37 -0700, Dan Williams wrote:
> > > Paolo Bonzini wrote:
> > > > On Wed, Apr 15, 2026 at 8:59=E2=80=AFPM Edgecombe, Rick P
> > > > <rick.p.edgecombe@intel.com> wrote:
> > > > >=20
> > > > > The call I mentioned is officially called: "TAC Subcommittee:
> > > > > Linux Kernel Special Interest Group (Linux Kernel-SIG)". This
> > > > > seems to be the info:
> > > > > https://confidentialcomputing.io/about/committees/#Linux-Kernel-S=
IG
> > > > >=20
> > > > > Paolo, unfortunately I did remember correctly that it is not
> > > > > an EU friendly time.
> > > >=20
> > > > This one is friendly (9AM PST =3D 6PM CEST). The unfriendly one
> > > > is the IOMMUFD one (5AM :)).
> > >=20
> > > There are couple topics at present that would be suitable to
> > > raise at the EU-US friendly time. Specifically whether all of the
> > > per-arch implementations of "transport large attestation evidence
> > > blobs over shared memory from host-to-guest" would be better
> > > served with a shared generic transport (simple virtio-pipe /
> > > something equivalent for vmbus to publish).
> >=20
> > Sorry to be a bit late to the party, but why invent a new thing
> > (virtio-pipe), why not use the existing virtio-vsock (and hyperv-
> > vsock, so no new vmbus device is needed)?=C2=A0 If you're thinking it's
> > because you need a simple cat into host and out of guest, then you
> > can do that with the ncat --vsock utility:
>=20
> I missed replying to this while I was on break.

Hey, that's OK and congratulations on the new gig, by the way.

>  The problem with virtio-vsock is that it is built to terminate in
> guest userspace not in the kernel.

Um, I believe the ksocket API can terminate any socket type in the
kernel (including vsock):

https://www.kernel.org/doc/html/next/networking/kapi.html

That's how we do things like netlink termination (and NFS, of course).

>  I want to see the same flow for bare metal retrieval of
> device attestation blobs as guests, which points to not having a
> userspace indirection dependency for the PCI core.
>=20
> I have also heard concerns of the complexity / availability of vsock
> early in the boot flow (firmware?).

So this is OVMF being able to open AF_VSOCK?  That is true today, but
it already has socket APIs for https boot, so they should be easily
extensible.

> For that concern a "simple" pipe protocol, like
> drivers/virt/coco/tdx_guest implements, pulls the blob
> over instead. Except, now we have simple drivers/virt/coco/arm-cca-
> guest
> transport, and simple drivers/virt/coco/sev-guest transport all
> duplicating blob retrieval over shared memory with payload size
> quirks and bugs.

Well, this is a separate problem, but one I'm also interested in since
I'm looking at bringing the hyper-v VMPL like API to kvm, which also
needs this type of communication between the various planes.

> The problem is about to get worse with TEE I/O because all of these
> archs have defined extension blob retrieval interfaces for the new
> PCI material. That duplication is not in Linux's long term interest,
> so a common "blob transport over shared memory" implementation is the
> proposal. virtio has already done the work to handle arbitrary data
> transfers, no need to reinvent that wheel. The only hangup is that we
> would still need a vmbus filter to feed the same mechanism.

Well, OK, but if you do this, it needs to be usable both for guest to
host and for plane to plane in the guest.

Regards,

James

