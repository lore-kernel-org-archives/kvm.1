Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AE3DA5DE;
	Tue,  5 May 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009463; cv=none; b=EmimqIOVG1vX6RnZlVhYj3NTkHeLYryL1thY0Uenv7vAiBxCsRwLyKOX+xPQ/9Iv5UVXD6oSfDZKgsgq2kTd/3OM5zhRw+6N68ZMWH0tqRzvGLuKcIx6xlrCFJOWO6E+iQ6zS3Y6Nn8abN4WS05ABCyyGOVyPO3y+vBjrL13KwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009463; c=relaxed/simple;
	bh=t5lJnaYrrtK+BLYUn5z0WIOUm2B5o/rz/l0BYxthXmo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OyYkW7lhV4eq2E00YXxSz+4GZCOGbA8PiLXCxWsPNuGKGS7eB8+At2zpRtoxdngXFrYtogBfC+ASTvySsS/5wypBodqqe7soZmU+ao3IoBF4IO3cHrVWL+HDoqaxlt0XhzWN2LpzXPDBqz5jK3mb9TsecS3Ji0DPFmH7dqV1LJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=L5ID19q5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="L5ID19q5"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 645JTi8s1137479
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 May 2026 12:29:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 645JTi8s1137479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026042601; t=1778009386;
	bh=0WCSuwfj1W768FCvM5VfHc16ZgHnSUwYc0Gvq6neuLI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=L5ID19q52aKnwJ9P975VEI/vfNLiSaFxu2L1Iops3NXlqejwwhUaZV7oV3eDZ/cTh
	 46cpWvpOx7aZconf7YrokP+Keg954OFqfJfL35dYVRdFifjgYGej63rYNG2IPVpIOh
	 evChBncxTjPS+8W8PVqWUFkwVu+OtWJMD6OnZZeh2YGOZ8r4dLveOdqd+aAvyICoV0
	 fJ6s4unSjniEIAbPlHbsZ85jaaEhaPXv+9MP60ZLJzQF5MAHPUaNnRW83V7m0B/nhr
	 7ko/vPM7O7kLsCBkEMln1XizFWOG4FbN2bj4J/N2HUeC4F8Rhypv0+UKwFx+yIdQW0
	 p/YafANatYSOw==
Date: Tue, 05 May 2026 12:29:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Xin Li <xin@zytor.com>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        "Saenz Julienne, Nicolas" <nsaenz@amazon.es>, pbonzini@redhat.com,
        seanjc@google.com, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        chao.gao@intel.com, hch@infradead.org, sohil.mehta@intel.com
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
User-Agent: K-9 Mail for Android
In-Reply-To: <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
References: <20251026201911.505204-1-xin@zytor.com> <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org> <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com> <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain> <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
Message-ID: <74DB6CAE-5ABD-4F2C-91AD-EEACE0F43020@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 5, 2026 11:30:21 AM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=2Eco=
m> wrote:
>On 05/05/2026 7:04 pm, Maciej Wieczor-Retman wrote:
>> Hello!
>>
>>
>> On 2026-04-23 at 15:56:54 -0700, Xin Li wrote:
>>>> On Apr 23, 2026, at 7:35=E2=80=AFAM, David Woodhouse <dwmw2@infradead=
=2Eorg> wrote:
>>>> Here's one to get you started (untested as I haven't found suitable
>>>> hardware to test it on)=2E
>>> Same here for me now :(
>> I ran David's selftest on a PTL laptop and ran into a couple of issues=
=2E
>>
>>>> From bd465aabebcb124e09a26fe9f4c861354febabe4 Mon Sep 17 00:00:00 200=
1
>>>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>>> Date: Thu, 23 Apr 2026 15:20:11 +0100
>>>> Subject: [PATCH] KVM: selftests: Add FRED event type classification t=
est
>>>>
>>>> +static void __used fred_handler(struct fred_stack_frame *frame)
>>>> +{
>>>> + fred_ss_value =3D frame->ss;
>>>> + fred_saved_rip =3D frame->rip;
>>>> + fred_handler_called =3D true;
>>>> +}
>> fred_handler() has problems getting linked:
>>
>> 	/usr/bin/ld: /home/maciej/linux/tools/testing/selftests/kvm/x86/int1_f=
red_test=2Eo: in function `fred_entrypoint_kernel':
>> 	int1_fred_test=2Ec:(=2Etext+0x104): undefined reference to `fred_handl=
er'
>> 	collect2: error: ld returned 1 exit status
>>
>> I guess the =2Epushsection below makes it a different translation unit?=
 Because
>> getting rid of the static keyword takes care of the problem for me=2E
>
>The problem is, being static, fred_handler() is eligible to be optimised
>away, because the compiler can't see that the asm() refers to it=2E
>
>Dropping static is the right fix to make=2E
>
>GCC 15 can now do references out of global asm() to identify the symbols
>they use, but it's going to be years before this capability is safe to
>use generally=2E
>
>>
>>>> +
>>>> +/*
>>>> + * FRED entry points=2E MSR_IA32_FRED_CONFIG points to the page-alig=
ned
>>>> + * base=2E Ring 3 events enter at base+0, ring 0 events at base+0x10=
0=2E
>>>> + * Since ICEBP executes in ring 0, the CPU enters at fred_entrypoint
>>>> + * + 256 =3D fred_entrypoint_kernel=2E
>>>> + */
>>>> +extern void fred_entrypoint(void);
>>>> +
>>>> +asm(
>>>> + "=2Epushsection =2Etext\n"
>>>> + "=2Eglobal fred_entrypoint\n"
>>>> + "=2Ebalign 4096\n"
>>>> +"fred_entrypoint:\n"
>>>> + /* Ring 3 entry =E2=80=94 unused, no userspace in this test */
>>>> + "ud2\n"
>>>> + /* Pad to +256 for ring 0 entry */
>>>> + "=2Eorg fred_entrypoint + 256, 0xcc\n"
>>>> +"fred_entrypoint_kernel:\n"
>>>> + "movq %rsp, %rdi\n"
>>>> + "call fred_handler\n"
>>>> + "=2Ebyte 0xf2, 0x0f, 0x01, 0xca\n" /* ERETS */
>>>> + "=2Epopsection\n"
>>>> +);
>>>> +
>> =2E=2E=2E
>>>> +
>>>> + /* Test 1: ICEBP (INT1) =E2=80=94 should be EVENT_TYPE_PRIV_SWEXC (=
5) */
>>>> + fred_handler_called =3D false;
>>>> + asm volatile("lea 1f(%%rip), %0\n\t"
>>>> +     "=2Ebyte 0xf1\n\t"
>>>> +     "1:" : "=3Dr"(expected_rip) :: "memory");
>>>> + check_fred_event(expected_rip, DB_VECTOR, EVENT_TYPE_PRIV_SWEXC,
>>>> + "ICEBP");
>>>> + GUEST_SYNC(0);
>> The above event type test seems to fail and return 0x3 instead of 0x5:
>>
>> Random seed: 0x6b8b4567
>> Testing FRED event types with EPT fault on stack
>> =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
>>   x86/int1_fred_test=2Ec:120: event_type =3D=3D expected_type
>>   pid=3D16646 tid=3D16646 errno=3D4 - Interrupted system call
>>      1  0x0000000000413349: assert_on_unhandled_exception at processor=
=2Ec:659
>>      2  0x0000000000407d36: _vcpu_run at kvm_util=2Ec:1703
>>      3   (inlined by) vcpu_run at kvm_util=2Ec:1714
>>      4  0x0000000000403104: main at int1_fred_test=2Ec:207
>>      5  0x00007ff8d4c2a1c9: ?? ??:0
>>      6  0x00007ff8d4c2a28a: ?? ??:0
>>      7  0x0000000000403314: _start at ??:?
>>   0x3 !=3D 0x5 (event_type !=3D expected_type)
>>
>> after a little digging I think the issue could be this in arch/x86/kvm/=
x86=2Eh:
>>
>> 	static inline bool kvm_exception_is_soft(unsigned int nr)
>> 	{
>> 		return (nr =3D=3D BP_VECTOR) || (nr =3D=3D OF_VECTOR);
>> 	}
>>
>> Since ICEBP(INT1) results in a DB_VECTOR it's not take into account and=
 the
>> check fails=2E Then in vmx_inject_exception() INTR_TYPE_HARD_EXCEPTION =
is picked
>> which is 0x3 when decoded=2E
>
>That's a real bug then=2E
>
>> I think you'd need to add another check in vmx_inject_exception() to ha=
ndle that
>> DB_VECTOR too=2E Simply changing the event type if the vector is of DB_=
VECTOR type
>> fixes that problem but then the selftest fails in other places (assert
>> fred_handler_called and saved rip vs expected_rip)=2E I didn't yet have=
 the time
>> to figure out what could be wrong there, maybe you would have more of a=
n idea :)
>
>#DB is intercepted to mitigate CVE-2015-8104 (systemwide DoS)=2E=C2=A0 Bu=
t, to
>start with, check that the test passes when #DB is not intercepted=2E=C2=
=A0
>That's the basecase for architectural behaviour=2E
>
>When #DB is intercepted, the type in EXIT_INTR_INFO needs preserving and
>forwarding into ENTRY_INTR_INFO, because that is what distinguishes an
>ICEBP #DB from other #DBs=2E=C2=A0 There's no way of recovering this deta=
il
>after the fact=2E
>
>On the injection side, some #DB's are traps and some are faults=2E=C2=A0 =
ICEBP
>will have a fault-like VMExit but need trap semantics, so like other
>soft interrupts, need INSN_LEN adding to %rip=2E=C2=A0 But, type=3D3 #DBs=
 need to
>leave %rip unchanged=2E
>
>~Andrew

Also, a function that is accessed only from assembly should have the __vis=
ible annotation=2E
