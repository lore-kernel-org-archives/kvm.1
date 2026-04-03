Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE63CD8B1
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233849; cv=none; b=FMAHzBKP+S0o0u6uRx/4Hu+g2q5mP8Qj9sJbNlP6HdapGJSO+pBNxZtlBCuigCBjPUAkDaCkDA74nc/ueHqi8Pe00TSUAo+liJpkfQ5WYjQr9mV2kz+NqNlHQY415r5wyMX4jkLPPCSFIRVyFtQCnfo7Y7eq7jMcsIsuZN4Du/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233849; c=relaxed/simple;
	bh=rGZgWtwCCI3+eFvVKc+X88h43lrdjuX32gE4iywL6A4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HO7OfoJTGj4AIjTXLwq/Jyog6KW4E1R+OM8HeWzbQy/GC49HpPuORernaVyIjgBXYKSdGclK2yX5H4R062XXqTs7aQw1gDvvfiIikWfybzHeyPifpxUL4oSY/dGPm8njYw8PsojmNhK8zp8hVSh92PWP5hpJRKlxzULDxgZ4Dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syfRd8WS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syfRd8WS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b242cbb97aso15037515ad.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775233847; x=1775838647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+Zt8Ye6QZDycK/H8I2xKI9t6Wy2CW5OkF+BQs3682Q=;
        b=syfRd8WSLrPJ6apEQ604WeEvOF3fivRBdp2ojXHjExtESYQt1WMCLa4T9b30Y4I9py
         XgjanW6SYEz+XHJD68+Y8bUOmx+q1SPlCvCKpxQXcrtisBeEJWJbP6B40Oy68kR1+Uar
         7Y3Si/V2T87rPei7TT/cLo53tzCbWM4rFtyBWwSgRoWvDaCreO3eIjJrJtN8AmAUSOth
         F9xj1r5UvYwxZN6RieSdw+cmjQLzY/LU7LXeI/vMAa2Hdtk6cBm202BUDPuy1fXMgFBI
         Ia25KfciaS6UwE3Wf7UK7azc8LeVpJ7zVn8G7XTTxKVqzROZSj5jDFLdN1uAsBas6gyR
         e8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233847; x=1775838647;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2+Zt8Ye6QZDycK/H8I2xKI9t6Wy2CW5OkF+BQs3682Q=;
        b=Zjse3N1BAyKehzTlEb5eum61VUN5raP02R/Zx8LbHBsiVNaZz+MB/bOuePr5KJ3MUL
         hZeIKEhWqnSILSJA9lDEd0TyI5BnBO/ZJ/hd++B2Ap+QlgQns8rzIcyb8lIRmacg78tG
         53l6/mWn2SWl6uVjJTfixhjh0xC8oiW03E5RyTqEXtAkXJskwISLNMV3TJbkPjV7JJ5K
         du534wWmNFg04jgolhw/fUcbU41yTBC14/SnZtdpWRQefO8iznihWT0Y81ptBUe1Zl7J
         tokAFzkTi6MqhXGYWxzyn6t7lDnmvFjNT4IaD8i/gZvPbwgF9sFb+5z+wJhw3PnInqPN
         7kEA==
X-Forwarded-Encrypted: i=1; AJvYcCVI/tWPxicpHs1Lqri79tIPzsU6Kxqe8WCbnZYWDC4ih4g4NzyIxm+OxOBN5qBzdyz0uc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKjGJks4XJWx06gsnZ0zpENYShuTfOJhaHYF+2OEXe2ORpHAU
	wSffTULrdzTRl6mQpCKPd/pzouUuul4eNisVjI82QrWO0glKgOkVa5f5MiF7MiigvuhKdLJnc63
	6Go+3jg==
X-Received: from plrx13.prod.google.com ([2002:a17:902:b40d:b0:2ae:d0cb:5159])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54f:b0:2ae:5eab:132e
 with SMTP id d9443c01a7336-2b28173fa9dmr36278905ad.12.1775233847240; Fri, 03
 Apr 2026 09:30:47 -0700 (PDT)
Date: Fri, 3 Apr 2026 09:30:45 -0700
In-Reply-To: <f67179d7050ae28ac261bb6227b1c045c10579c9.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260318190111.1041924-1-dmaluka@chromium.org>
 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com> <cb99e44c-8bc9-4bab-b485-9f63a4d0b262@linux.intel.com>
 <93358559-5ed1-4574-8951-24d7ea9354e4@intel.com> <ee8d7ea3-0ece-43cf-ab07-6954df4c01ad@linux.intel.com>
 <f67179d7050ae28ac261bb6227b1c045c10579c9.camel@intel.com>
Message-ID: <ac_rNT69TdocrMYc@google.com>
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "dmaluka@chromium.org" <dmaluka@chromium.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Dave Hansen <dave.hansen@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-03-19 at 15:40 +0800, Binbin Wu wrote:
> > tdx_has_emulated_msr() is used by KVM to decide whether to emulate a MS=
R access from the
> > TDVMCALL or just return the error code.
> >=20
> > During an off-list discussion, Rick noted that #VE reduction could chan=
ge the behavior of
> > accessing an MSR (e.g., from #VE to #GP or to be virtualized by the TDX=
 module) without
> > KVM knowing.Because KVM lacks the full context to perfectly decide if a=
n MSR should be
> > emulated, the question was raised: Can we just delete tdx_has_emulated_=
msr() entirely?
> >=20
> > However, these native type x2apic MSRs are a special case. Since the TD=
X module owns the
> > APICv page, KVM cannot emulate these MSRs. If we remove tdx_has_emulate=
d_msr(), a guest
> > directly issuing TDVMCALLs for these native type x2apic MSRs will trigg=
er a silent failure,
> > even though this is the guest's fault.
> >=20
> > It comes down to a tradeoff. Should we prioritize code simplicity by dr=
opping the function,
> > or keep it to explicitly catch this misbehaving guest corner case?
>=20
> I think from KVM's perspective it doesn't want to help the guest behave
> correctly.

Uh, yes KVM does does.  KVM is responsible for emulating the APIC timer, is=
n't it?

> So we can ignore that I think. But it does really care to not define
> any specific guest ABI that it has to maintain. So tdx_has_emulated_msr()=
 has
> some value there.=C2=A0And even more, it wants to not allow the guest to =
hurt the
> host.
>=20
> On the latter point, another problem with deleting tdx_has_emulated_msr()=
 is the
> current code path skips the checks done in the other MSR paths. So we wou=
ld need
> to call some appropriate higher up MSR helper to protect the host? And th=
at
> wades into the CPUID bit consistency issues.
>=20
> So maybe... could we do a more limited version of the deletion where we a=
llow
> all the APIC MSRs through? We'd have to check that it won't cause problem=
s.

What?  No.  KVM can't get actually read/write most (all?) MSRs, allowing ac=
cess
is far worse than returning an error, as for all intents and purposes KVM w=
ill
silently drop writes, and return garbage on reads.

> Failing that, we should maybe just explicitly list the ones TDX supports =
rather
> than the current way we define the APIC ones. As you mention below, it's =
not
> correct in other ways too so it could be more robust.

No?  Don't we just want to allow access to MSRs that aren't accelerated?  W=
hat
the TDX-Module supports is largely irrelevant, I think.

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..28e87630870b 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2116,23 +2116,26 @@ bool tdx_has_emulated_msr(u32 index)
        case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1=
:
                /* MSR_IA32_MCx_{CTL, STATUS, ADDR, MISC, CTL2} */
        case MSR_KVM_POLL_CONTROL:
+       /*
+        * x2APIC registers that are virtualized by the CPU can't be
+        * emulated, KVM doesn't have access to the virtual APIC page.
+        */
+       case X2APIC_MSR(APIC_ID):
+       case X2APIC_MSR(APIC_LVR):
+       case X2APIC_MSR(APIC_LDR):
+       case X2APIC_MSR(APIC_SPIV):
+       case X2APIC_MSR(APIC_ESR):
+       case X2APIC_MSR(APIC_ICR):
+       case X2APIC_MSR(APIC_LVTT):
+       case X2APIC_MSR(APIC_LVTTHMR):
+       case X2APIC_MSR(APIC_LVTPC):
+       case X2APIC_MSR(APIC_LVT0):
+       case X2APIC_MSR(APIC_LVT1):
+       case X2APIC_MSR(APIC_LVTERR):
+       case X2APIC_MSR(APIC_TMICT):
+       case X2APIC_MSR(APIC_TMCCT):
+       case X2APIC_MSR(APIC_TDCR):
                return true;
-       case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
-               /*
-                * x2APIC registers that are virtualized by the CPU can't b=
e
-                * emulated, KVM doesn't have access to the virtual APIC pa=
ge.
-                */
-               switch (index) {
-               case X2APIC_MSR(APIC_TASKPRI):
-               case X2APIC_MSR(APIC_PROCPRI):
-               case X2APIC_MSR(APIC_EOI):
-               case X2APIC_MSR(APIC_ISR) ... X2APIC_MSR(APIC_ISR + APIC_IS=
R_NR):
-               case X2APIC_MSR(APIC_TMR) ... X2APIC_MSR(APIC_TMR + APIC_IS=
R_NR):
-               case X2APIC_MSR(APIC_IRR) ... X2APIC_MSR(APIC_IRR + APIC_IS=
R_NR):
-                       return false;
-               default:
-                       return true;
-               }
        default:
                return false;
        }
