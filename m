Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C637C918;
	Wed, 10 Jun 2026 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135134; cv=none; b=lNwHsafpqtbekquGTV/bXo8A8x89EuI/INDlgFSWjz7OnrO3D+ggmf7EYhsy1DZufBFPMwVo8bhVXherb3uoIKgMg5nZhZRAM87k5LToQV2ahBASCWN1iqAJ9Ejav6mLp/dmlKc6XFoXEQgPpv29kh2jJuQiUVhnQDontG5CdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135134; c=relaxed/simple;
	bh=M+YUlXtymD9rTEjCDvoSC/mwh+dWiVT8OwL3uxvAT2I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bQYk82i4OCRW9E16JpGWFML9LdZ54bLdgLSgjB9xtU7WK9K/nBgrA7j4KvwJSfaBj4FoYXsc+9KWM4EnlhfaaHqRa6F/yaSt28DIHa0PwKJzg3yUIDwSXoB02aHUB6F8Qlie6y/lZglXiFooU1W8OXcEboAwfwDN1GQ3lImxd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SrCrCNGx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SrCrCNGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:Mime-Version:Subject:From:Date:
	Message-Id:To; bh=0UgYFdXvIJZ0/2u/k0FRzMTYcQqPIV/APvU/sucKQcs=;
	b=SrCrCNGxakQZx7TPvwRY3ckSDuhDzRnSRWnGgoYcXosoUN1DcAtoXz0dOjk4+u
	2IQQeW4IrK2zuuyEXpRBNsVJD8EihFeGHgxjG8/oBta6u12wYJptRX56MiVVKHZV
	3fpJaABwbGdh06n6MLJPW4nRELX/Fp9tZv9bgXIXMFIJQ=
Received: from smtpclient.apple (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAHd6vq9ilqc7JjCg--.30065S3;
	Thu, 11 Jun 2026 07:44:42 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] KVM: SVM: Clear dummy V_IRQ in vmcb01 when deactivating
 AVIC
From: xinguo <m18700951735@163.com>
In-Reply-To: <ailce3eU59J4bv6x@google.com>
Date: Thu, 11 Jun 2026 07:44:31 +0800
Cc: pbonzini@redhat.com,
 tglx@kernel.org,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5230F158-B766-4BDD-8D94-FFE6AA46BF8C@163.com>
References: <20260610070512.85463-1-m18700951735@163.com>
 <ailce3eU59J4bv6x@google.com>
To: Sean Christopherson <seanjc@google.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-CM-TRANSID:_____wAHd6vq9ilqc7JjCg--.30065S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr13Zw4fWr4DXryUZFy7Wrg_yoWrXw18pF
	Z3GanFvr4DX3Z7tryUKa1Dury7Aa95WF18GFykGr13A34SkF12gF92ywnY9F90kFy8Gw10
	vw1jv3yrua4YyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRk9N-UUUUU=
X-CM-SenderInfo: jpryliyqzvilitv6il2tof0z/xtbCwgrcI2op9upq8wAA3x

Fair point, my changelog reasoning is incomplete and I owe you data
rather than speculation.

What I actually trigger is a workload that repeatedly toggles AVIC
on and off, i.e. avic_activate_vmcb() / avic_deactivate_vmcb() get
called many times in quick succession.  Under that load the Windows
guest blue screens with STATUS_INTEGER_DIVIDE_BY_ZERO.

=46rom the dump, Windows takes the bugcheck while dispatching an
interrupt: an unhandled #DE is raised inside the interrupt dispatch
path and ultimately reported by nt!KiInterruptHandler.  The faulting
RIP saved in the trap frame is:

	je   nt!KiInterruptSubDispatchNoLockNoEtw+0xd5

which is a conditional branch, not a div/idiv.  In other words, the
guest is being vectored through IDT entry 0 (#DE) at an instruction
boundary that has nothing to do with division, which is consistent
with the CPU delivering vector 0 from KVM rather than the guest
actually executing a faulting div.  That is what made me suspect a
stale dummy V_IRQ (vector=3D0, V_IRQ=3D1) becoming effective once AVIC
is disabled.

I agree this needs to be backed by traces, not just by that
hypothesis.  Let me instrument svm_set_vintr(), svm_clear_vintr(),
the intercept-recalc paths, and avic_deactivate_vmcb() to capture
vmcb01's int_ctl / int_vector / INTERCEPT_VINTR / is_guest_mode()
at each transition, reproduce the crash, and come back with the
actual call sequence that leaves vmcb01 in a state where V_IRQ
becomes effective once AVIC is disabled.

Please hold off on this patch in the meantime; I'll resend (or drop
it) based on what the trace shows.

Thanks for the review.

> 2026=E5=B9=B46=E6=9C=8810=E6=97=A5 20:45=EF=BC=8CSean Christopherson =
<seanjc@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 10, 2026, xin guo wrote:
>> When KVM requests an IRQ window via svm_set_vintr(), it programs a
>> dummy VINTR with int_vector=3D0 and V_IRQ=3D1 into the current VMCB.
>> These int_ctl fields are documented to be ignored while AVIC is
>> enabled, so the dummy VINTR is harmless during AVIC operation.
>>=20
>> However, avic_deactivate_vmcb() only clears AVIC_ENABLE_MASK and
>> X2APIC_MODE_MASK, and does not clear the VINTR injection state. Once
>> AVIC is disabled, hardware honors V_IRQ again and injects vector 0
>> into the guest on the next VMRUN. Windows guests observe this as a
>> spurious interrupt and crash, e.g. with =
STATUS_INTEGER_DIVIDE_BY_ZERO.
>=20
> Can you provide a reproducer, or at least instructions to reproduce?  =
This feels
> like we're treating a symptom, not the underlying bug.  And while I =
can definitely
> see KVM leaving a stale V_IRQ_MASK in vmcb01, I don't see how that can =
happen
> while also clearing INTERCEPT_VINTR, as the only place INTERCEPT_VINTR =
is cleared
> in vmcb01 is svm_clear_vintr(), which also purges V_IRQ_MASK.
>=20
> 	svm_clr_intercept(svm, INTERCEPT_VINTR);
>=20
> 	/* Drop int_ctl fields related to VINTR injection.  */
> 	svm->vmcb->control.int_ctl &=3D ~V_IRQ_INJECTION_BITS_MASK;
>=20
>> Fix this by also clearing V_IRQ_INJECTION_BITS_MASK from vmcb01's
>> int_ctl in avic_deactivate_vmcb(), so that no stale dummy VINTR is
>> left behind when AVIC transitions from enabled to disabled.
>>=20
>> Signed-off-by: xin guo <m18700951735@163.com>
>> ---
>> arch/x86/kvm/svm/avic.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> index cdd5a6dc646f..b042c3f5f90e 100644
>> --- a/arch/x86/kvm/svm/avic.c
>> +++ b/arch/x86/kvm/svm/avic.c
>> @@ -257,7 +257,9 @@ static void avic_deactivate_vmcb(struct vcpu_svm =
*svm)
>> {
>> 	struct vmcb *vmcb =3D svm->vmcb01.ptr;
>>=20
>> -	vmcb->control.int_ctl &=3D ~(AVIC_ENABLE_MASK | =
X2APIC_MODE_MASK);
>> +	vmcb->control.int_ctl &=3D ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK =
|
>> +				V_IRQ_INJECTION_BITS_MASK);
>> +
>> 	vmcb->control.avic_physical_id &=3D =
~AVIC_PHYSICAL_MAX_INDEX_MASK;
>>=20
>> 	if (!is_sev_es_guest(&svm->vcpu))
>> --=20
>> 2.27.0
>>=20

