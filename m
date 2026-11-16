Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873417;
	b=FkKtokx6Rvfh+cWCyPNCIV0hHS46TFIROvdXFLkn6AxXJT+SoXAbkGHdC3OA1iA2VLlL
	 FNjhvZcbTZP+tGg1JwxUqKKlIkN86medVuBFOb7rYR6ZLqdkwvA5FI2bHCOBodokZmJqN
	 GFssBwsD/IeuBTd6deYhBh1vIqB2OiFksqwu4dO+HyoLVcMcb3mWNP7ctxT2SGR6SXXya
	 usddaqnJKQz9cUyKOFNUnLHnSJM9c63zH042dwRfvIewyy47hep4LDQcIofTLyIGR57Sh
	 3cSvNbMvig91BchH4n9aIZhmPbhHWL2OaVHYKRQLio0os+e99TjBetKucUQOJo6Kl2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873417;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-SRS-Rewrite;
	bh=VDQ8XKp98/IUabUksJNwRsl5hTpuGniKvWNPUNAUVJs=;
	b=GA3NXbN1cCv17HuMTsqrAX3BaUEQYCpRX5+vlnievax54mRdISDrbqG8mVVrHseu4b17
	 LmCe9/AUHDv8hFdzXFkfl3UPvk0V7s1i2mQZuEi8V+OZq0DX5+1NmNzrX+3CkBXCsZfdZ
	 jdHpGcb1ruEjF/KnFjyHYW8eFeINY9aLWpgInsporYWWeEw2FUScKxno4WDf8f7HuShs/
	 PKlEwiGHCkHd/acN5u/Wl+Fttjvm9w7QIkvLBSM5y4VUSgnkaTzBq7B/eKfrqV+Y0i4DZ
	 OciJffgaas9UiZLOkbZG+FuCKhSJvM2VKPQNxzrjKYOYbsNtZCbUmhS8E9Vphq/IgiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=bAwGBnT5;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540A606A31C;
	Mon, 16 Nov 2026 23:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5540A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=bAwGBnT5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=VDQ8XKp98/IUabUksJNwRsl5hTpuGniKvWNPUNAUVJs=; b=bAwGBnT5GwP1cL3P3kxxd+Tt4p
	RTDaT0Oyl71V25VcnfUc1TJsIvvkfVFF6tQ7cjAsdBRjhaNhVfROk11PZQ2Lqp9H080zmEhNxAUWS
	2845Sqt5jD1hB3QkEXAuvA7zWzvgVWcCtoq4A+B1ou32/iKhaZsoaAgBPrjc9SGhhsNX56JBiO8I7
	Bc4gc4TPwyVghj71V2WVE2j61jwGFsmpNg3XUV4E+wbwhSTecpnZFeqAKhqzvB6pBB6N+mR0wooU5
	0SOKcOhLC9DuvMxgdFebRU8VgFgPZXIqt3KE3NaXJiKF6ke8hcLAeS4IC8G+z/mXzaEm9DAasDAbV
	V5XT4lxw==;
Received: from [2a00:23ee:2960:2262:e6b2:75b6:9515:3c16] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6Z2-0000000EQr2-3zpq;
	Mon, 16 Nov 2026 23:56:44 +0000
Date: Mon, 16 Nov 2026 23:56:42 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
CC: Zack Rusin <zack.rusin@broadcom.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Doug Covelli <doug.covelli@broadcom.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <shuah@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>,
 Francesco Lavra <flavra@baylibre.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/12] KVM: x86: Forward VMware hypercalls to userspace
User-Agent: K-9 Mail for Android
In-Reply-To: <avuDUNAU_a933zvp@seanjc-mac.roam.internal>
References: <cover.1794374897.git.zack.rusin@broadcom.com> <90467782be23b83fd3e9a6afe2f1d2149eaf9db9.1794374897.git.zack.rusin@broadcom.com> <876c4f4fc442116c9bff8abd8c34f99fcfa65531.camel@infradead.org> <CABQX2QNd7DehBsH-pGL=EJK4b5vC60PymL_YP27xDxGT6_6=uQ@mail.gmail.com> <1bae109338ab6ff1ff14eac811f7e86ced785b22.camel@infradead.org> <CABQX2QNhRZP1Td_HQ6QpMzw-_TjqhbooipWYg3VTgTOq2_U9+w@mail.gmail.com> <ca9dffb64656a392965f95d35b9d13d829f34076.camel@infradead.org> <avuDUNAU_a933zvp@seanjc-mac.roam.internal>
Message-ID: <78F8FDAE-31A5-416B-9A97-DB8D5E7271FA@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 16 November 2026 22:27:28 GMT, Sean Christopherson <seanjc@google=2Ecom>=
 wrote:
>On Fri, Nov 13, 2026, David Woodhouse wrote:
>> On Fri, 2026-11-13 at 01:33 -0500, Zack Rusin wrote:
>> > > Userspace *already* needed to
>> > > know about those=C2=B9 because it can't migrate while those are pen=
ding;
>> > > it has to do at least one more run, even if it's with the immediate=
_exit
>> > > flag set=2E
>> >=20
>> > True, but, again afaict, that rule exists because those completions
>> > have to run, so I don't think it tells us they can be dropped=2E
>> >=20
>> > > If it's deemed clearer, I'd also be OK with an explicit
>> > > KVM_VCPUEVENT_CANCEL_HCALL which cancels *only* hypercalls=2E But I=
 don't
>> > > really see the point; userspace shouldn't be getting confused when =
it
>> > > was actually some other kind of completion that was active anyway=
=2E
>> > >=20
>> > > =C2=B9 https://lore=2Ekernel=2Eorg/all/20250111012450=2E1262638-1-s=
eanjc@google=2Ecom/
>> > >=20
>> > > Looks something like this in my Hyper-V hcall series (except I alre=
ady
>> > > shouted at the agent for stupid struct layout and made it go run pa=
hole
>> > > on everything it's working on)=2E
>> >=20
>> > FWIW, restricting cancellation to explicitly marked completions looks
>> > good to me=2E=C2=A0 If Sean/Paolo prefer that, I'm happy to mark our
>> > completion cancellable and drop our exception fields=2E
>>=20
>> I posted that as
>> https://lore=2Ekernel=2Eorg/kvm/20261113170535=2E79246-3-dwmw2@infradea=
d=2Eorg/T/#u
>> and caught both Paolo and Sean here at KVM Forum and both seem OK with =
it
>> (although acquiescence when badgered at a conference doesn't necessaril=
y
>> translate to applying the patch=2E=2E=2E :)
>
>Heh, you jinxed yourself=2E


Yeah, none of us had really had the time to consider it deeply=2E

For VMware and Huper-V I do believe we need to raise the fault *on* the in=
struction, not after it=2E But that's achievable=2E

I had also added a third user of the same cancellation today =E2=80=94 we =
need to intercept certain control register writes and need to raise various=
 exceptions for those too=2E

WIP of that at=20
https://git=2Einfradead=2Eorg/users/dwmw2/linux=2Egit/shortlog/refs/heads/=
vsm3/regwr-filter-v5

I think I would still prefer to use KVM_SET_VCPU_EVENTS rather than shoe-h=
orning the same facility into the return part of various different kvm_run =
exit structs=2E But I won't fight for KVM_SET_VCPU_EVENTS to do the cancell=
ation=2E How about we just give each of the exit types a way to indicate wh=
ether to advance the RIP because the instruction is completing) or not (bec=
ause the instruction is faulting)?


>If the exception is communicated through some other means, then (a) that =
needs
>to be explained in detail, and (b) we should be able to use the same appr=
aoch,
>just with new "ret" field or whatever in kvm_hyperv_exit=2Eu=2Ehcall=2E

I do think it is a full 64-bit return value *or* an exception=2E My friend=
 did originally abuse bit 63 of the return value and I may have thrown my t=
oys out of the pram at it a little bit=2E=2E=2E they can type fast, but my =
God they are stupid sometimes=2E

