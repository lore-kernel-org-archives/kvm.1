Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93EE2D592F;
	Mon,  9 Mar 2026 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099046; cv=none; b=gWM5f/MXXz1VB//fXtZQfCLfixvweG180YnAy/vsUM4w5qVs2IdZapIoHIax7DL+4MrrkpP6u/9C6+V4mwMPRqXVT7Sw2kGLSemJrO0wFOu+xVgcmY+DQDOngbggd2hU250HVhHEak0OZ4YjLcMXG8Bq8dRygZeKdv3kYB3rVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099046; c=relaxed/simple;
	bh=Mc8sQmOnsQjSJKQZW9ZakT7eg8OBz9HllSgbUmK4P2A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Mpy3Nra0zN9iBKBM+EoYdzvvi5ETbDwqPv08VmDqhmXT0rk7d8c4OhYM3Meg6wAuqLJW8otDotvX2V2D3+iZcM5gYC3Cvm0c53DchKVI63PLfRFRXTkEmUmigCtcrY+H4nX8EOJSwNBIwJlb/vSAohK/0+S6Olt/VqDyo4OsDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DTCLYS/u; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DTCLYS/u"
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 629Mw2o4582928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 9 Mar 2026 15:58:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 629Mw2o4582928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026022301; t=1773097084;
	bh=5d2lkjxDoRfoR577qtoDLDA2Jh6xlweEdNl2M83bZvs=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=DTCLYS/uzjbI41B18dSsKONDA8W9tVCvfSw482HN63OpeApcPiBCxNR4ojMV8h6pf
	 xxI6aHpEgciQnTlemGKkqjysiJy8rZc8LlLrjQ2oP5SWTKH6a1o0hEV+YmuZKcGzQM
	 OrcrUFxV6sgg9CtxirOewwFhc0Eza2LcuUTffq/o+a0Qg17Jpk5kL6oMU8924z0aPs
	 CbGQ5AeCKeEx6X8LQzbYPzxjiUf9zNTQPtSeEBdlvGlOLpcuGGIKp4VlrHQgeJDVuF
	 uzzBLADrdwj65phBdGVDa5ex1YLoG8tDSlyw0pyGuQf4MGNXQIsuJUzGLKggOPeKdw
	 GtFEP5iukamMA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v9 06/22] x86/cea: Export __this_cpu_ist_top_va() to KVM
From: Xin Li <xin@zytor.com>
In-Reply-To: <aa7mILKnhX9N4228@google.com>
Date: Mon, 9 Mar 2026 15:57:51 -0700
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org, pbonzini@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, andrew.cooper3@citrix.com,
        chao.gao@intel.com, hch@infradead.org, sohil.mehta@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8892656-10B9-4B5A-8870-2150E3140115@zytor.com>
References: <20251026201911.505204-1-xin@zytor.com>
 <20251026201911.505204-7-xin@zytor.com>
 <20260130134644.GUaXy2RNbwEaRSgLUN@fat_crate.local>
 <9C6FC4E7-DF8A-4583-93A8-3B82806D11CD@zytor.com>
 <aa7mILKnhX9N4228@google.com>
To: Sean Christopherson <seanjc@google.com>
X-Mailer: Apple Mail (2.3864.400.21)



> On Mar 9, 2026, at 8:24=E2=80=AFAM, Sean Christopherson =
<seanjc@google.com> wrote:
>=20
> On Fri, Mar 06, 2026, Xin Li wrote:
>>> On Jan 30, 2026, at 5:46=E2=80=AFAM, Borislav Petkov <bp@alien8.de> =
wrote:
>> diff --git a/arch/x86/include/asm/fred.h =
b/arch/x86/include/asm/fred.h
>> index 2bb65677c079..7eea65bfc838 100644
>> --- a/arch/x86/include/asm/fred.h
>> +++ b/arch/x86/include/asm/fred.h
>> @@ -35,6 +35,13 @@
>>=20
>> #ifndef __ASSEMBLER__
>>=20
>> +enum fred_stack_level {
>> + FRED_STACK_LEVEL_0,
>> + FRED_STACK_LEVEL_1,
>> + FRED_STACK_LEVEL_2,
>> + FRED_STACK_LEVEL_3
>=20
> Why bother with a layer of indirection and more enums?  Just pivot on =
the MSR
> index.

It=E2=80=99s a bit weird to pass a u32 MSR index to this_cpu_fred_rsp().

We will want to rename it to this_cpu_fred_xsp() when FRED shadow stack
is supported.

>=20
>> #ifdef CONFIG_X86_FRED
>> #include <linux/kernel.h>
>> #include <linux/sched/task_stack.h>
>> @@ -105,6 +112,8 @@ static __always_inline void =
fred_update_rsp0(void)
>> __this_cpu_write(fred_rsp0, rsp0);
>> }
>> }
>> +
>> +unsigned long this_cpu_fred_rsp(enum fred_stack_level lvl);
>> #else /* CONFIG_X86_FRED */
>> static __always_inline unsigned long fred_event_data(struct pt_regs =
*regs) { return 0; }
>> static inline void cpu_init_fred_exceptions(void) { }
>> @@ -113,6 +122,7 @@ static inline void =
fred_complete_exception_setup(void) { }
>> static inline void fred_entry_from_kvm(unsigned int type, unsigned =
int vector) { }
>> static inline void fred_sync_rsp0(unsigned long rsp0) { }
>> static inline void fred_update_rsp0(void) { }
>> +static unsigned long this_cpu_fred_rsp(enum fred_stack_level lvl) { =
return 0; }
>> #endif /* CONFIG_X86_FRED */
>> #endif /* !__ASSEMBLER__ */
>>=20
>> diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
>> index 433c4a6f1773..363c53701012 100644
>> --- a/arch/x86/kernel/fred.c
>> +++ b/arch/x86/kernel/fred.c
>> @@ -72,6 +72,23 @@ void cpu_init_fred_exceptions(void)
>> setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
>> }
>>=20
>> +unsigned long this_cpu_fred_rsp(enum fred_stack_level lvl)
>> +{
>> + switch (lvl) {
>> + case FRED_STACK_LEVEL_0:
>> + return __this_cpu_read(fred_rsp0);
>> + case FRED_STACK_LEVEL_1:
>> + return __this_cpu_ist_top_va(ESTACK_DB);
>> + case FRED_STACK_LEVEL_2:
>> + return __this_cpu_ist_top_va(ESTACK_NMI);
>> + case FRED_STACK_LEVEL_3:
>> + return __this_cpu_ist_top_va(ESTACK_DF);
>> + default:
>> + BUG();
>> + }
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(this_cpu_fred_rsp, "kvm-intel");
>=20
> Meh, just do EXPORT_SYMBOL_FOR_KVM so that there's no export when =
KVM_X86=3Dy|n.
> And it's possible AMD may need to grab the MSRs too.

I thought about it and checked AMD SVM FRED patches, but wasn't able to
find host RSPs get set explicitly during vCPU migration.

But anyway, I will make the change.

>=20
>> +
>> /* Must be called after setup_cpu_entry_areas() */
>> void cpu_init_fred_rsps(void)
>> {
>> @@ -87,7 +104,7 @@ void cpu_init_fred_rsps(void)
>>        FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
>>=20
>> /* The FRED equivalents to IST stacks... */
>> - wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(ESTACK_DB));
>> - wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(ESTACK_NMI));
>> - wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(ESTACK_DF));
>> + wrmsrq(MSR_IA32_FRED_RSP1, this_cpu_fred_rsp(FRED_STACK_LEVEL_1));
>> + wrmsrq(MSR_IA32_FRED_RSP2, this_cpu_fred_rsp(FRED_STACK_LEVEL_2));
>> + wrmsrq(MSR_IA32_FRED_RSP3, this_cpu_fred_rsp(FRED_STACK_LEVEL_3));
>> }


