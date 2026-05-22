Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD625A359;
	Fri, 22 May 2026 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492657; cv=none; b=tyrYzqknCtBZB8E34gZ1O4z9D0CV5MLIcdV4GlGBRBEB/uIDstACvKVHkR+//jygjDZhFAA5tnwKVWOh9LyxB3LiI/bLhFQ7NBA53vejefsd0XUCrgGdP9e2h2klBg3o1beTEOccoWjTkJBr4maJDYTK2dQr05/vTRYwFu6HN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492657; c=relaxed/simple;
	bh=i6vHdQ5oldCpZlhFDjFmxL304IdV4wnWfln87BM7NM0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Bv3956/aryiIYFmQrMjQ7L6ynX6VmT5OM9/3421pSGsD6GQf77k5ItzQJXcYBmKmWi1UD0D3GV69Lu297OPLqC0QquoEIdPTejBL6ZmLe92IlwvZt/mi8rI/W051ZbRovfJiR8e1NuILD1no0uMOC7IIiX1BrY/NOu7MMbD/U00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OUorWJ8t; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OUorWJ8t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=i6vHdQ5oldCpZlhFDjFmxL304IdV4wnWfln87BM7NM0=; b=OUorWJ8tXcW09mDeCVBA/b8LZW
	hpfXFu+EBYP9IjRj2PiIkEVGfSyH9LRxmdtygDflODeVVijCU7fk7dVBnp1ZLjSeCRFp5cIz2lYZ5
	i0K5bRWjlXK8pJGE+1wWAdEN7ptP8dQ/E7wnmXXsU5b4IldjDJg1OuxzNRa5Dv1ECgoPWc1bQZrYB
	7Qqsy8e6x1CWJOdocrh1neuN+vKOiZ9WJRS268HMjqh6pNxc4N1jCsaKs1K/il0+geGYobFEr/J9E
	zno9xHOsMAknlHjYnXKJQo/D+frfDBzhKu8XKZ8zdUrzZO9dHhegJdo6KdiPhByzmwkvgRjFtEeM+
	BfqIJBCA==;
Received: from [2001:8b0:10b:5:5975:12af:289:68ce] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQZK5-00000005akR-0Dzw;
	Fri, 22 May 2026 23:30:33 +0000
Date: Sat, 23 May 2026 00:30:33 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Sascha Bischoff <Sascha.Bischoff@arm.com>, Marc Zyngier <maz@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_27/30=5D_KVM=3A_x86=3A_Add_K?=
 =?US-ASCII?Q?VM=5FVCPU=5FTSC=5FEFFECTIVE=5FFREQ_attribute?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ahDO58dKuPt-lj_J@google.com>
References: <20260509224824.3264567-1-dwmw2@infradead.org> <20260509224824.3264567-28-dwmw2@infradead.org> <3ad6cd109480772ade3c11f23b9c1d7a9855d67e.camel@infradead.org> <ag-Hf2liLSX9q0rS@google.com> <ab84153e33fbe7c25667f595c56b310d4d5a93ef.camel@infradead.org> <ahBQ7mXNaTtouT3C@google.com> <c4b498c401287477402ddd60a0120b0c5a9bf8d3.camel@infradead.org> <ahCQluJj59uWlDAF@google.com> <99356a588677e9ff31c1747db1705d9250a2728d.camel@infradead.org> <ahDO58dKuPt-lj_J@google.com>
Message-ID: <277F54CD-9F17-4B67-B575-3A8DDEA09796@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 22 May 2026 22:47:19 BST, Sean Christopherson <seanjc@google=2Ecom> wrot=
e:
>On Fri, May 22, 2026, David Woodhouse wrote:
>> On Fri, 2026-05-22 at 10:21 -0700, Sean Christopherson wrote:
>> >=20
>> > I'll send a standalone patch, along with a selftest tweak to verify t=
he fix=2E
>> > It's technically a fix and won't generate any conflicts, no reason to=
 delay it=2E
>>=20
>> Are you suggesting the other 30 should be delayed? :P
>
>LOL, just acknowledging that it'll take me a minute to page all of that c=
ode in=2E

Hey, it took me more than a year to page it back in :)

I am only teasing; no rush=2E And I will post v5 with some accumulated twe=
aks (from my kvmclock5 branch) soon=2E
