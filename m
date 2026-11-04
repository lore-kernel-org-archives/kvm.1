Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822964;
	b=ndcnMuc3RymnrcUACJsNHPYDyxbLL35Xbn/TmBegkiITyqMfoKA/e/lJAHXlw5XMhVSX
	 tFGoK81gJMMqRh5YkxX4yvOz6hxgQZGZXKU1/v8+rtqmIXPv02z67shjVBzwu1LJP3ku1
	 49QikXksMShARSNUX9ocL+6Y9wPcryeoOPtm9TA9D2TJ5hMy/oyF35sOvCB8vHobc33WW
	 82Ve/aLyCb9INVY9xh3Ge1l6EtUdQCFJ/zR0WzjZX5s5INu3nr8PN3AkYL/V9CG+7oeAQ
	 Hrm6nVKlNsiGPEq6yjaXgoTLEMBnCVfsaoLozy/L+3o1yNMhFYDf7Dw/f9tFVtGQkLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=E2TeHoCGLsdbVlnVR3R/1g272e9+f/e+PpD1xA79wRM=;
	b=jhX3OA0YefOSZUqDcuicTT50A/g22mP45NbviLdSWKezXULnlFZIrjY1y3ZokVAfB9Kn
	 bDBqHNuIK29GY2Wkhf5FViamM1kh5KekdZWxY3fjpgQuATStBkNztnDU3EW3wzUdYXhGO
	 eLoGqvQzE0HO0oAcNkAzCIHXwYecOHiajICjEOBkqxD7D/S1vxCUZI8vSjmGQKc3I5hso
	 bKmAhwb6XGdifG6D0PrIqRys1ephk4kjwxLpUdn92zJwFi+OpacsE9XuaeuVHOy/BJusq
	 DZsTZjReLTAWwZFlHOBAIc9F1BpKEmn+8oZyJrSVzjJ972TaJP+djQusQa+nyArkHaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ks1+EsyG;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB846070E6B
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 20:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBB846070E6B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ks1+EsyG
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1181878a12.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793822963; x=1794427763; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2TeHoCGLsdbVlnVR3R/1g272e9+f/e+PpD1xA79wRM=;
        b=ks1+EsyGcdNm3nnjwH3qu2mAPy2MGIX9c3zziwOLIuws/kki5T+SudrwpLhb0UI37l
         2H5mtgEjEwNq6j1zmSu0kn7ZlvA+B6xuh5Pswv+1gzfraDoDYbeuQHQpnj7HOY2XXyZJ
         5eCOnwU2ntQBsk/ZmmjQsSN/gMz1bjCN2Hp8EPQ7RiuICKxEGrUcUHYyE6bmOdQltuqx
         ZUVrTKtIHv663IOrifXhojZppskrdXyCax0TYR79e7ImzIdP9aNQQON9Zi2C5WwCiFUS
         H0MCrkKESU74fTGq9+YuM+il5Ez8qaxeo7MiMyFbHnQZ0q5uvjGt/XD1Qu3VJuPrq8qy
         jfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822963; x=1794427763;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2TeHoCGLsdbVlnVR3R/1g272e9+f/e+PpD1xA79wRM=;
        b=26PrxXnjndoklMZNzbk7LTYDczwBnKiqsTGdBPrZuHhg4IMDK3ELnjGAcs4/v+SZa2
         gFpNVtmIg8BZtIOJVZJXykk//aC7sgiOey8IEznquVaJSpY9CFxaBId151jcJq6kK8bP
         u2IA2KLF7SbWA5iQq3tX5MQQigKPzSqvizBGj7VP3GNF9pze9VybL3lLBzhcbH5f77wT
         CRFWBxb5pv4qZSu/kWCqtiFY2wHUrDR1bATgY5zonqbmWeiqIMJ2owfaAyIdCjEP0PCQ
         H6F6BMV1Te6fjPXSt2JOtnmM/VhVFR/Fzzi7ja8yf0abktNorf14qcY5ezSzotrhfNx+
         7kCw==
X-Forwarded-Encrypted: i=1; AKwUvBzMiXCzT2kPUierOq9Bu2Ui83djpbfAMQq2MVqMYEQsRlBrnBw++pG0/JIq362Zz1PWhwU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9z47IlidJOX4dhjF3Z5xNROL5atZGmUfgEi/tiarlxHJhWSDr1
	9TCuJBI1rJRLKuWWKznVXfbJvhhI1ZPw3A+o3ba58/Lpu+fjWr3ziJJSEFw3OhbCCC+smdhBY5q
	3gBjcig==
X-Received: from pjbgn10.prod.google.com ([2002:a17:90a:c78a:b0:3b0:b36b:66fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:584c:b0:3ac:9c37:9418
 with SMTP id 98e67ed59e1d1-3ae89724824mr14163241a91.19.1793822963093; Wed, 04
 Nov 2026 12:09:23 -0800 (PST)
Date: Wed, 4 Nov 2026 12:09:22 -0800
In-Reply-To: <20261008-lapic-extint-lvt0-unmask-fix-v1-1-db2bf68fba75@collabora.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261008-lapic-extint-lvt0-unmask-fix-v1-1-db2bf68fba75@collabora.com>
Message-ID: <auuQ8pE439EB63tm@google.com>
Subject: Re: [PATCH] KVM: x86: Reevaluate pending interrupts when enabling
 ExtINT through LVT0
From: Sean Christopherson <seanjc@google.com>
To: Matthew Leach <matthew.leach@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 08, 2026, Matthew Leach wrote:
> If the PIC output becomes asserted while LVT0 is masked, unmasking LVT0
> in ExtINT mode makes that interrupt injectable without setting
> KVM_REQ_EVENT. Without another event triggering reevaluation, the
> interrupt remains pending and a guest waiting for timer ticks can hang.
> 
> Fix by setting KVM_REQ_EVENT on an LVT0 write where pic interrupts
> become acceptable.

Why just for LVT0?  Isn't this a bug in general?  I.e. can't we simply do:

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d6e5fbc3c58c..ffdc67ca8fa3 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2554,6 +2554,8 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 			val |= APIC_LVT_MASKED;
 		val &= apic_lvt_mask[index];
 		kvm_lapic_set_reg(apic, reg, val);
+		if (!(val & APIC_LVT_MASKED))
+			kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
 		break;
 	}
 
Ahh, but there's nowhere for edge-triggered events to be latched, so this only
affects level-triggered events.  Which means, this?

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d6e5fbc3c58c..b72930a8516d 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2554,6 +2554,8 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 			val |= APIC_LVT_MASKED;
 		val &= apic_lvt_mask[index];
 		kvm_lapic_set_reg(apic, reg, val);
+		if (!(val & APIC_LVT_MASKED) && (val & APIC_LVT_LEVEL_TRIGGER))
+			kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
 		break;
 	}
 
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
> During calibrate_delay_converge() we spin waiting for jiffies to increment on a
> tick interrupt. However, if KVM fails to deliver the interrupt this causes the
> guest to hang, spinning on the while loop.
> 
> Reproduce with:
> 
> qemu-system-x86_64 \
>   -cpu host \
>   -accel kvm \
>   -smp 1 \
>   -machine pc,hpet=off \
>   -kernel <bzimage> \
>   -nographic \
>   -append "console=ttyS0,115200 noapic apic=debug no-kvmclock clearcpuid=tsc"
> 
> Resulting in a hang at:
> 
> printk: legacy console [ttyS0] enabled
> printk: legacy console [ttyS0] enabled
> printk: legacy bootconsole [uart8250] disabled
> printk: legacy bootconsole [uart8250] disabled
> ACPI: Core revision 20260408
> ACPI: setting ELCR to 0200 (from 0c00)
> APIC: Switch to symmetric I/O mode setup
> Not enabling interrupt remapping due to skipped IO-APIC setup
> Enabled ExtINT on CPU#0
> 
> Note that the bug manifests itself only if a PIC interrupt is asserting during
> the mask window, so it is timing based. Using nested virt helps, or apply the
> following patch to the guest to provide enough time for a tick after masking:
> 
> --8<---------------cut here---------------start------------->8---
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index aa1e19979aa8..ddee09360dd0 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1509,7 +1509,7 @@ static void apic_clear_isr(void)
>  static void setup_local_APIC(void)
>  {
>  	int cpu = smp_processor_id();
> -	unsigned int value;
> +	unsigned int value, i;
>  
>  	if (apic_is_disabled) {
>  		disable_ioapic_support();
> @@ -1527,6 +1527,9 @@ static void setup_local_APIC(void)
>  	value &= ~APIC_SPIV_APIC_ENABLED;
>  	apic_write(APIC_SPIV, value);
>  
> +	for (i = 0; i < 10000000UL; i++)
> +		cpu_relax();
> +
>  #ifdef CONFIG_X86_32
>  	/* Pound the ESR really hard over the head with a big hammer - mbligh */
>  	if (lapic_is_integrated() && apic->disable_esr) {
> --8<---------------cut here---------------end--------------->8---
> ---
>  arch/x86/kvm/lapic.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index e1f3cea14765..ce7fbd6c45c2 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2520,6 +2520,14 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>  			val |= APIC_LVT_MASKED;
>  		val &= apic_lvt_mask[index];
>  		kvm_lapic_set_reg(apic, reg, val);
> +
> +		/*
> +		 * Enabling ExtINT can make an already-asserted PIC interrupt
> +		 * deliverable without another transition on the PIC output.
> +		 */
> +		if (reg == APIC_LVT0 && kvm_apic_accept_pic_intr(apic->vcpu))
> +			kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
> +
>  		break;
>  	}
>  
> 
> ---
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> change-id: 20261008-lapic-extint-lvt0-unmask-fix-52d2328af682
> 
> Best regards,
> --  
> Matt
> 
> 
