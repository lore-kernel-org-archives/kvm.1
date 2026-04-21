Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5837189C
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796163; cv=none; b=pjumQcD07PxKoy6MjTnjL0JxlFUcieFIA+4JdmUJuzWtpZpOeoeaas2VpRf1y+MajZE10fl986J4/NVfunSguZ7u+m62bTaLq9HjKFnhXv5WzTDKX0f5YSz5MJXHSHiCA/VxL3bVi6fXPWhHkxakTBsCKmVoz6CoudemR/sCIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796163; c=relaxed/simple;
	bh=mDCOdsKkY3BtGJeevTHwSX/C8WC2nbSJUNJ9G5RNEMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aMVG/yGf3qkysxaiH0/NxHL7tZKem51hbh/D7E+duYUUC+SEX/igWs6MTcxWkX17xUAWkX+iUajBH82R+ZnGvwLn0sYfL6tAD+oDzQqO6rSYYONh1n49dX9Vja8706MXHWqc9chG8PufNGUwhTOMlBv/ewUeG9ROm8xOEYEwUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSNGncRj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSNGncRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA07C2BCB0;
	Tue, 21 Apr 2026 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776796162;
	bh=mDCOdsKkY3BtGJeevTHwSX/C8WC2nbSJUNJ9G5RNEMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oSNGncRj0MV7SN7dCEf5oIFjKDHl2eeV+omb9lI4PrUkU3HjH2jl0+yU9n6JeAGGb
	 XmdICkA3eJWG4OLOxJOAbsUIaNfRwEbnpKaHFxeGxI65G5zw1roPWv3PAXka1o7fwR
	 941XmwCwAmnqFkibuDPoEyb9VE6hpjpVOCCU6Vns+kDJosLEeZ6Vmon7zoOjkJNd50
	 pbfsKfVtcUXMDbc1tViiXM/p2GqR+uCqKhnMbitE050GWVEfmt+BUp7s5g2Qhtx8mt
	 kv2/j5QuawFcz2vKrgGHcwgYr3frdsGNHFXFyCwhx+D3jV7KElFlash0Fk3BSPBNg4
	 x8mQRk7eZl4dg==
From: Thomas Gleixner <tglx@kernel.org>
To: Jim Mattson <jmattson@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Binbin Wu
 <binbin.wu@linux.intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, "Wu,
 Binbin" <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Sean
 Christopherson <seanjc@google.com>, Paolo Bonzini <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx>
 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx>
 <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
Date: Tue, 21 Apr 2026 20:29:18 +0200
Message-ID: <878qagb20x.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21 2026 at 10:20, Jim Mattson wrote:
> On Tue, Apr 21, 2026 at 10:14=E2=80=AFAM Thomas Gleixner <tglx@kernel.org=
> wrote:
>>
>> On Tue, Apr 21 2026 at 13:49, Peter Zijlstra wrote:
>> > On Tue, Apr 21, 2026 at 01:34:07PM +0200, Peter Zijlstra wrote:
>> >> > > > KVM invokes regular interrupts with pt_regs which have interrup=
ts
>> >> > > > disabled. That's correct from the KVM point of view, but comple=
tely
>> >> > > > violates the obviously correct expectations of the interrupt en=
try/exit
>> >> > > > code.
>> >> > >
>> >> > > Mooo :-(
>> >>
>> >> Also, is this a x86/KVM 'special' or is this true for all arch/KVM th=
at
>> >> use GENERIC_ENTRY?
>> >
>> > Should we not make asm_fred_entry_from_kvm()/VMX_DO_EVENT_IRQOFF fix IF
>> > on the fake frame instead? We know it will enable IRQs after doing
>> > handle_exit_irqoff() in vcpu_enter_guest().
>>
>> Doesn't work :)
>>
>> > SVM does not seem affected with this particular insanity.
>>
>> Looks like. It will take the interrupt after local_irq_enable().
>
> FWIW, VMX should work just like SVM if we clear VM_EXIT_ACK_INTR_ON_EXIT.

I know. What's the point of that VM_EXIT_ACK_INTR_ON_EXIT exercise? Is
there any performance benefit or is it just used because it's there?

Thanks,

        tglx


