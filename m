Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06BD231832;
	Sat, 15 Aug 2026 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786777405; cv=none; b=eadOeuXxDH14bdGOUdlKC0LXfYUcvHMZQnw4z3QdAH1OZ2zm1XkpWmwYhAp1jr/AX6WXngMrglH89wFAsGmtbqGEnu4TvDoR32CiYGYc/gTuqKPw18d4uMVPvFa+ZpJKqT0SckcJtAW50DynRh12pMWqUTQ7KXDNYInUnh97Hgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786777405; c=relaxed/simple;
	bh=DrpjM4vTfVVFK3xHJOBLXDnqWrGk4VfWkcfkE7G1viE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Xwt2X7tGFhHhrPcyXba3pb8mNv5Kl80/8afcVoSw0rE2gHV2cbfO4hb8g/kdRYceI8mJy4aPS9TCjE9BkqGn4f/YB8LWmx1J28NpGllsUiUJuP9re4pRSLGy/Aw5erwvbMjR6+FedQFCZZGiYQ2bdT4aC3kzHPqiVOPZYEkYFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TsD1aUT9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TsD1aUT9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vFwW/KzeZkxEAcxvRpsV5UXDgsa9npf+qs5mLhHNQNY=; b=TsD1aUT9ojH/4Tct9skCWNvTNK
	44l/zqLlBlmWFlgdrwDQL+FMgjnMoP0yx3NOB7d9rJBr53GW31p08+qK+W2brToWlxephG84Sc8M5
	H6FypLYnkl7SD9j8MaG/fk02wZd8XFEHuVGH1LWuVpp7W0mFejD8hMadvmTujPJJcWI4j7zUWt3+S
	XXWdfZOILX8K2+HYBXOhHPRton/Ccb6kh4LYCx5btBO/6krUhpL7kG/PAjChXLP6/O3NylmzF/A6p
	IQSlksnb0p5VogSmZYY9d6HdgEb/LBK8cSzoJnOUmOjf1nmcxPz0T652yJzGp7G1US43ALjYn90F5
	h58OfAcw==;
Received: from [2001:8b0:10b:5:7c22:1ec7:eff1:386] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wv8Pq-0000000HLvs-34jQ;
	Sat, 15 Aug 2026 07:02:51 +0000
Date: Sat, 15 Aug 2026 08:02:50 +0100
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_17/36=5D_KVM=3A_x86=3A_Allow_KVM_master?=
 =?US-ASCII?Q?_clock_mode_when_TSCs_are_offset_from_each_other?=
User-Agent: K-9 Mail for Android
In-Reply-To: <an9WVBHSsy5W0PUk@google.com>
References: <antQYJvRxJxOjtut@google.com> <f5dc701cf3319a7b3c8fd1497f26d051aa9fa3ba.camel@infradead.org> <antb01WqOrs-tztm@google.com> <6ab49538675d97f1f4bf01574b1b066aae0bc05c.camel@infradead.org> <ants4VjfAiblaWsl@google.com> <3dc73f745b6abfd1eb53e7d3fce2067eaa3b3c92.camel@infradead.org> <anuYNxD81OE3MrQw@google.com> <5efe7a3914a3610ee00a487379caff84af6aa731.camel@infradead.org> <anusv0DloFhLMMoW@google.com> <c5c532e01309c8c73de2b0f393539b608c495f1f.camel@infradead.org> <an9WVBHSsy5W0PUk@google.com>
Message-ID: <606ECD8E-2EED-48B9-A440-62D2444FBE22@infradead.org>
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

On 14 August 2026 18:54:28 BST, Sean Christopherson <seanjc@google=2Ecom> w=
rote:
>On Fri, Aug 14, 2026, David Woodhouse wrote:
>> On Tue, 2026-08-11 at 16:14 -0700, Sean Christopherson wrote
>> > I'm not totally opposed to a broader GET, but we should definitely ge=
t Paolo's
>> > eyes on this sooner than later=2E
>>=20
>> We've been saying that for two years=2E Shall I bring a net and a whip =
to
>> KVM Forum? Or Plumbers? :)
>
>I pointed at this thread in the "clocks" pull request, so then should be =
now,
>soon=2E  And if that doesn't work, I'll just rename the getter to
>KVM_GET_PAOLO_PAOLO_PAOLO and send a pull request=2E  Either that will ge=
t his
>attention, or we'll have a source of amusement for years to come :-)
>
>Joking aside, this would be a good PUCK topic if we need/want a synchrono=
us
>session to sort things out=2E
>
>[*] https://lore=2Ekernel=2Eorg/all/20260812213206=2E1564354-2-seanjc@goo=
gle=2Ecom

I prefer https://lore=2Ekernel=2Eorg/all/69b0cc5aa1032d708700bd2367b43d623=
8fc4079=2Ecamel@infradead=2Eorg/ as the summary over the one you picked, bu=
t happy to reach a solution either way :)
