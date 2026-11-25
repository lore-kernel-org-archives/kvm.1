Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713215;
	b=lpxammizUvZeD+DKZp/XdgI14pHuF7mz6poZ7ariZLnLVB1c4wxUxgouqK0SMB45toe3
	 uLVZ25MbeanD0A+K//8q0P7A+jeJ9bP6FrwC4NgFB3Jr5I56+USgQLOljdcoQNdBFIZUN
	 sirODFjDO3hoisSqZxQvR7wNdscyM7oI5zKt9O031LVdR0QP7dJFcd1vI5oHVjC11ceRr
	 kklcpGgX9tmuxZTzaczB9LBrxEB5OJBv/m4Yl08POJZHM2MiFxY4SDGM+0lGHCIs9RfGr
	 Pz0k3kMVAfk+64248tjblDYIqEuMSd0k5v5/6a6S8PZG+3C+hjc7i53zaXZxzLIx0pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713215;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cYISrqwFDAdvMVCm0AZleanH6dwFlvwyUS0R5RiDoww=;
	b=1yac0IMPYSPXiDFUb6e7k1UMbNZ7FaZyuezDnXPxgtf8FBcg3WL1fa4AU+e9e7G6Ng+W
	 RwKApeOvvpJgFLmmYPPpFfY0umRrGqbzy0RWvC8IjDArBmbYRjptpRbVPlHHIyQH3b+Fm
	 cKSDYzTYzmSz+AtLqn/8kvJCW85UxqfSiZMSUfuoS4nlU71Zvg1KurkGljV3kw8Tlc6+w
	 OkMU8R3lgugUenoprV6fgrXCJwvps/xnwjjAvxf2wuEsjliu4V4pM+OoDX088SxTrVozK
	 l4xDJ/eIYyqU2rM6bqHAqMU97rqSz+4fTXhQPNXTGQZu8nRYHKB4+0vODdRMJcvly3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=TVfDxwjz;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5EC606A329;
	Thu, 26 Nov 2026 17:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E5EC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=TVfDxwjz
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 01F9940E01F4;
	Thu, 26 Nov 2026 17:13:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JESkrDVBnqxP; Thu, 26 Nov 2026 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795713209; bh=cYISrqwFDAdvMVCm0AZleanH6dwFlvwyUS0R5RiDoww=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TVfDxwjzYIkXQRkJ+1Fl/JMHBjtBMyBAU7q2mbe0l1Lsx1/gHl+6rg4y8wb7g3+ch
	 jo6FfsN+qdZotC88TJVh/Se8tBNl5kovKIrY/qAPJq1Wz5yPVjpKp5bvhejTCrgNzU
	 nfdRKQfKyOe9Ytdmp/E8ye5TaG3gRR7VMyW+Biru932w/1GgdARb4pr3jzFxmBxJHL
	 Rw2YonbPIva3+ZReg2ZOBnTdO7G1XpGjRic5FoVMIGFMnrFM7tHKhJQrJlK1gaAbXN
	 iPDzMxzNApgnlZOt+s37KoARSVDei1Crs5scASzMXN3bd7eIlNKd4SllB/oZ9M6RFu
	 Y0QAiR7p568XorqnJqkr1nVT1mzY6r6whWzmTDe11etBseZntxSCOzBVbipAltDApN
	 nRx9aBEUO0Z3JqHeNbqsbZ3nDH3KrNULBILH156JDOsokCi0GyTAHuCoqk4ah6CaEd
	 XfA5QQ2rbG5vRYN+sWqdMBG0zqVcXJfI06sWlPNl+7lYZnMfeDOYWaNFEhB9rc8UkX
	 gSV0CLdRl3svF2ifKS9R5BEaDdghKZ5fB66pNqQBVfxSDEfI54zZRIN6exCkLerh+/
	 SLvt0yuogNaFpXPert5a1zFMfIdXH7o5HtI5kGcaINAvmuKS4HBa3DyiUFNYotxHBq
	 k4qDylKJwBRTvW6qRNnrDmBw=
Received: from ehlo.thunderbird.net (unknown [IPv6:2600:1700:38ca:c00:c5c2:d13d:7fec:2bae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DAF040E01E1;
	Thu, 26 Nov 2026 17:13:16 +0000 (UTC)
Date: Wed, 25 Nov 2026 22:46:36 +0000
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
CC: nikunj@amd.com, tglx@kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 thomas.lendacky@amd.com, Srikanth.Aithal@amd.com, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/sev=3A_Skip_DR7_write_during_k?=
 =?US-ASCII?Q?exec_when_it_would_trigger_an_unserviceable_=23VC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <5acdbdc5-0c9e-4db8-a21c-fa011ba0bd57@amd.com>
References: <20261116230335.1161521-1-Ashish.Kalra@amd.com> <20261123234341.GCawTPrczGd6iM_Uby@fat_crate.local> <47cb97d1-5919-4ee7-ad67-6039551304d6@amd.com> <20261125041925.GCawZhzVbU3ngXnt5c@fat_crate.local> <5acdbdc5-0c9e-4db8-a21c-fa011ba0bd57@amd.com>
Message-ID: <190F8E6D-856A-410C-AAA4-9086C707A167@alien8.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 25, 2026 8:29:49 PM UTC, "Kalra, Ashish" <ashish=2Ekalra@amd=2E=
com> wrote:
>Hello Boris,
>
>On 11/24/2026 10:19 PM, Borislav Petkov wrote:
>> On Mon, Nov 23, 2026 at 06:22:09PM -0600, Kalra, Ashish wrote:
>>> On the "bogus VMGEXIT": before Nikunj's change, __sev_get_ghcb() retur=
ned
>>> the per-CPU GHCB, which snp_kexec_finish() had already converted back =
to
>>> private=2E The host mapped that GPA, read ciphertext (exit code 0) and
>>> returned GHCB_ERR_MISSING_INPUT, but couldn't write the result into th=
e
>>> private page, so the guest saw its own stale contents, treated the cal=
l as
>>> successful and moved on=2E The DR7 write was simply dropped=2E It work=
ed by
>>> accident=2E
>>=20
>> Oh lovely=2E
>>=20
>>> As for using do_vc_no_ghcb(): the GHCB MSR protocol requests are meant=
 for
>>> specific guest-initiated operations (protocol negotiation, GHCB
>>> registration, page state changes, termination, etc=2E)=2E The only one=
 that
>>> corresponds to an intercepted instruction is CPUID, which is why
>>> do_vc_no_ghcb() handles only the CPUID exit code and terminates the gu=
est
>>> for anything else=2E There's no MSR-protocol equivalent of a DR7 write=
, so the
>>> no-GHCB #VC handler can't handle it=2E
>>=20
>> Well, can you fashion something with VMEXIT_DR7_WRITE and a dummy GHCB =
MSR request
>> to the HV which is innocuous, just so that it can satisfy the flow?
>>=20
>
>We could issue a harmless MSR-protocol request and then skip the instruct=
ion, but the request wouldn't carry anything about the DR7 write=2E The hyp=
ervisor would end up in exactly the same state as if we just skipped it, so=
 it would be an extra exit that doesn't actually communicate anything=2E
>

Which doesn't matter on the kexec path=2E

>So how about doing it in the #VC handler: once the GHCBs have been torn d=
own, route the #VC to a GHCB-less path that decodes and skips DR7 accesses,=
 completing them locally, and the kexec then proceeds normally=2E This is s=
afe: without DebugSwap, KVM intercepts DR7 accesses and only tracks the val=
ue, it can't load it into the encrypted VMSA, and the kexec'ed kernel write=
s DR7 again in cpu_init() anyway=2E Any other #VC in that window, which can=
't be completed without the hypervisor, would terminate the guest with a sp=
ecific reason code instead of dereferencing a NULL GHCB, so it gets caught =
explicitly rather than silently skipped=2E
>

Sure, that sounds fine too=2E

Thx=2E

--=20
Small device=2E Typos and formatting crap
