Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC4306D2A;
	Fri,  7 Aug 2026 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123621; cv=none; b=hH9jJCCzZONBbucNCXbf7RzdIwVMV0Yp3xPVJtnN6ioMU0Er7C4Q0u7KRo9VpeD2GNshYG3Uj6Phg3J2Dh7ohOhBL2QxH4iow61ytdEKRd6QU0fA9PW+Tpy2aCvS05oZfe60uMad8Y7THvmH5KXHIY3YPKW9Wys+T0DTDOGSFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123621; c=relaxed/simple;
	bh=J6hKlLDfy8EzeR1/qAoX8QmUsTzAE8MSqchz203HbuM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WPkXpSN2rV34aKOi9x2HCydMDzxzl1Xo3Vzpkz1wms4Iyj5Ih5Hpi5TZsuO9q7ajnM5OufuJxOwaO8wcJLZ7orquMvuLHRiXjU1QoiNRWJuGqDhIHR/3Ggq1hB9g2mlYFfk/ZmCg+RDnbPXq2sg1BhxwPZ2hkG8KRKBZAGvyKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hJaakCfH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hJaakCfH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=g/4OPoBcc0jdDeonME1p8x9/LKSW50jPvoTZ23X6NDg=; b=hJaakCfHCV/XNKe2hBtjFq54bk
	KBJ8RFxBr4wwHHiAvTmp2dxSDrSSWS9BZ+28u7SdbbuF26yxAhGCPIk6XLta/2/v68pjes0s3xKCA
	0LZqWlEniqQwXSeTnLyURB64yG+FrDVyFAgIJ4yTlNZA9MjIe8B/5maXzHf3UJHGouC3WZy/7p1u0
	/g7YIvzsnvo+sooZjMRDGFQn6BrKVGlA7OXQK9GAvhaXow0W5k700pShuXFj/BqJzqetjH7Ka91uR
	q1kox7zUXvdtOP2zE2433IiNfMDiZPMW9qRJc+V7omyfxTJEwzKCDFTi16hkYvJ0o5n7JKBXllZZp
	g5Xf55Vg==;
Received: from [2a00:23ee:1cb8:40de:9642:5441:c967:9c6] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wsOLM-0000000CZ2Q-4815;
	Fri, 07 Aug 2026 17:26:53 +0000
Date: Fri, 07 Aug 2026 18:26:51 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>, sashiko-reviews@lists.linux.dev
CC: kvm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_05/17=5D_KVM=3A_x86=3A_Avoid_NTP_f?=
 =?US-ASCII?Q?requency_skew_for_KVM_clock_on_32-bit_host?=
User-Agent: K-9 Mail for Android
In-Reply-To: <anYBYu4rx-jCv8gr@google.com>
References: <20260804233923.3504629-1-seanjc@google.com> <20260804233923.3504629-6-seanjc@google.com> <20260805000221.B63F61F00A3A@smtp.kernel.org> <anN_J_KZhVJ1zIeI@google.com> <anUmdhx0Dh-yd89z@google.com> <anYBYu4rx-jCv8gr@google.com>
Message-ID: <9D3BEB2D-1FC8-4607-BB92-8C26F138985A@infradead.org>
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

On 7 August 2026 17:01:38 BST, Sean Christopherson <seanjc@google=2Ecom> wr=
ote:
>+David (I realized I'm having a conversation between me, myself, and Sash=
iko)
>
>On Thu, Aug 06, 2026, Sean Christopherson wrote:
>> On Wed, Aug 05, 2026, Sean Christopherson wrote:
>> > On Wed, Aug 05, 2026, sashiko-bot@kernel=2Eorg wrote:
>> > > > diff --git a/arch/x86/kvm/x86=2Ec b/arch/x86/kvm/x86=2Ec
>> > > > index 3107878a6fe5d=2E=2E8f469fd9863f9 100644
>> > > > --- a/arch/x86/kvm/x86=2Ec
>> > > > +++ b/arch/x86/kvm/x86=2Ec
>> > >=20
>> > > [ =2E=2E=2E ]
>> > >=20
>> > > > @@ -915,13 +914,6 @@ static s64 get_kvmclock_base_ns(void)
>> > > >  	/* Count up from boot time, but with the frequency of the raw c=
lock=2E  */
>> > > >  	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data=
=2Eoffs_boot));
>> > >=20
>> > > [Severity: Low]
>> > > Will reading the 64-bit pvclock_gtod_data=2Eoffs_boot without seqco=
unt
>> > > protection or data_race() annotations trigger KCSAN data race warni=
ngs on
>> > > 32-bit systems?
>> > >=20
>> > > By removing the ktime_get_boottime_ns() fallback, this read now exe=
cutes on
>> > > 32-bit architectures where it compiles to two non-atomic 32-bit acc=
esses=2E
>> > > If a KVM vCPU thread calls get_kvmclock_base_ns() while a timer int=
errupt
>> > > runs timekeeping_update(), it overwrites offs_boot=2E
>> > >=20
>> > > Even though the value only actually changes during suspend when the=
 freezer
>> > > subsystem guarantees vCPU threads are frozen (preventing functional=
 tearing),
>> > > overwriting the identical value concurrently with an unprotected re=
ad still
>> > > introduces a formal C11 data race=2E
>> >=20
>> > Huh=2E  And strictly speaking, 64-bit could tear the store/load=2E  S=
tealing heavily
>> > from ktime_mono_to_any(), this as a prep patch plus fixup (not yet te=
sted)?
>>=20
>> LOL, hilarious=2E  I was cherry-picking the rest of the series on top t=
o run the
>> tests, and discovered that "Compute kvmclock base without pvclock_gtod_=
data"
>> does exactly that: uses ktime_mono_to_any() directly=2E  So at least I =
went in the
>> right direction?
>>=20
>> David, is there any reason that patch needs to be 25/36?  AFAICT, it sl=
ots in
>> very nicely before this patch=2E  Then we don't need to do the below, b=
ecause
>> ktime_mono_to_any() already takes care of 32-bit=2E
>
>Same question for "KVM: x86: Use ktime_get_snapshot_id() for master clock=
"=2E  I
>don't see any obvious dependencies in here:
>
>  KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
>  KVM: x86: Remove runtime Xen TSC frequency CPUID update
>  KVM: x86: Avoid redundant masterclock updates from multiple vCPUs
>  KVM: x86/xen: Prevent runstate times from becoming negative
>  KVM: x86: Avoid gratuitous global clock updates
>  KVM: x86: Factor out kvm_use_master_clock()
>  KVM: x86: Allow KVM master clock mode when TSCs are offset from each ot=
her
>  KVM: x86: Replace nr_vcpus_matched_tsc count with all_vcpus_matched_tsc=
 bool
>  KVM: x86: Kill last_tsc_{nsec,write,offset} fields
>  KVM: x86: Improve synchronization in kvm_synchronize_tsc()
>
>And if I pull those in earlier, and grab these two (which AFICT also don'=
t have
>dependencies either):
>
>  KVM: x86: Remove runtime Xen TSC frequency CPUID update
>  KVM: x86/xen: Prevent runstate times from becoming negative
>
>Then what's left fits nicely into two or three buckets:
>
>  1: Masterclock overhaul
>  2=2E New uAPI and tests
>
>> > diff --git a/arch/x86/kvm/x86=2Ec b/arch/x86/kvm/x86=2Ec
>> > index b6e1dfd6db6a=2E=2E57679d871581 100644
>> > --- a/arch/x86/kvm/x86=2Ec
>> > +++ b/arch/x86/kvm/x86=2Ec
>> > @@ -921,7 +921,8 @@ static void update_pvclock_gtod(struct timekeeper=
 *tk)
>> > =20
>> >         vdata->wall_time_sec            =3D tk->xtime_sec;
>> > =20
>> > -       vdata->offs_boot                =3D tk->offs_boot;
>> > +       /* Pairs with the READ_ONCE() in get_kvmclock_base_ns()=2E */
>> > +       WRITE_ONCE(vdata->offs_boot, tk->offs_boot);
>> > =20
>> >         write_seqcount_end(&vdata->seq);
>> >  }
>> > @@ -929,7 +930,26 @@ static void update_pvclock_gtod(struct timekeepe=
r *tk)
>> >  static s64 get_kvmclock_base_ns(void)
>> >  {
>> >         /* Count up from boot time, but with the frequency of the raw=
 clock=2E  */
>> > -       return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_da=
ta=2Eoffs_boot));
>> > +       struct pvclock_gtod_data *gtod =3D &pvclock_gtod_data;
>> > +       ktime_t raw =3D ktime_get_raw();
>> > +       ktime_t now;
>> > +
>> > +       /*
>> > +        * Synchronization with clock updates isn't required on 64-bi=
t as only
>> > +        * one field is being consume
>> > +        * */
>> > +#ifdef CONFIG_X86_64
>> > +       now =3D ktime_add(raw, READ_ONCE(gtod->offs_boot));
>> > +#else
>> > +       unsigned int seq;
>> > +
>> > +       do {
>> > +               seq =3D read_seqcount_begin(&gtod->seq);
>> > +               now =3D ktime_add(raw, *offset);
>> > +       } while (read_seqcount_retry(gtod->seq, seq));
>> > +#endif
>> > +
>> > +       return ktime_to_ns(now);
>> >  }
>> > =20
>> >  static uint32_t div_frac(uint32_t dividend, uint32_t divisor)

(Home and on the phone after an insane week; full attention span might be =
limited until Monday)=2E

The only reason the ktime snapshot stuff is last in the series is because =
I did that work on the kernel's core timekeeping two years after the rest o=
f the series, and it was still sitting at the tip branch at the time so I d=
idn't want to make it a hard dependency for the kvmclock series=2E Now the =
timekeeping stuff is merged we can fold it all into the kvmclock series how=
ever we like=2E
