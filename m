Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB297389118
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295273; cv=none; b=hviBAgx2SI2k8upLH9xeRDJqZEH4Vadesw7516rajkfCA9z2AFyB0YJGu5AEmjm4c5BXmGAPJdlgFnWQHCuVnJxex9XkiTAvmbL7IboLeTrusMUREP2UPBOo2Ebb25AYjPJU1kMEoR9DmxZP1k2Fe8V/eKRkC/1+lhg8UpcFbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295273; c=relaxed/simple;
	bh=psMMOFJtF+kXmhZbIqCEwWB9ZeF9nIpvSaKhQSOCImE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M6Nqb7A8YEThsO1oumrp2fEF5G+uMHC+d285Vr3Xzr/tZ06JsLQhesOpO3swxB8JK46AhVH2soEvhYN/XulJok5zgSHDLLO4sRiFdm1dtFOYUeHwGXvx+Fr9mxaLXGLcI9VdNYTp2zyUEDdKLhmmb8LOVBio4cZGawpjrTkBdMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyZMpkDs; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyZMpkDs"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1d85c012dso501157a12.2
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788295271; x=1788900071; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hejcjb1fztMCJ1CJSchSzKPJN30uncRZpwDIFNQIfN8=;
        b=AyZMpkDsZd3U0jqkiG8eu3hm8gv5XlUeHSXyEZknTmgNHrsoQ+jgCeTgDmLGjA5TD8
         IY6fuJ9nxYKcfDyPeR0YSlprwFYxezcG7ojrqYYra4a/15e9Yjf7PkeUVOG++trDJrcx
         8TmY94ovaAdby3vXRWATNNnHNt5PgAFtmd2DgSuXn2iGF+4kh5JWfgkOEIJt3xAExzjZ
         Y8xaFMUuDm86IB+jtR1gIm+XNwc9oi97ughyEksEXJDgMIGgIRgnpR+bL3ZlUqkWuKOj
         VDGgamktqwAt6L0pJZyBsGFGjeJVjvDxE9oDpzAeXOyK60pPAdY5V9qis2E+CKTz1jSO
         kQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788295271; x=1788900071;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hejcjb1fztMCJ1CJSchSzKPJN30uncRZpwDIFNQIfN8=;
        b=UUANwqBYfVRMP/WZSwtHnzR8xLVWy7Ry+jPBB/zVHl7Asw1m5dEcoFiJyce3fp2Vxt
         kKaDjexKtPXXR/JmKUCX5fXDbSz0MXkYTFHmQI6jXLPGm/EAjF19PN3JFgEyKZchrysk
         q6toGmZo1P+lVmUygPK6KcYNFlfTt5WXnUmgfrKkf3cAHEB9g3ou+rwF8a9P1bBtE4ey
         UB+ffQapmGxqgfSwgp+komiqea9AzxpZUo98wxzC9TI53vPcAOLK4nmcNhAdPV6ebsu6
         wpLu42hdeX0+PtnsZc4HcblxSFnx6x/yfZFeSsLFPHAicCi61CTJBCEgVeniFfHEd3cP
         AxXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdFRhvqm3J/6y6aP2VoUPALacMTa/NmV0kdpeRjrlz93VuiZ26liIaKrrM/xfKO8M6EXM=@vger.kernel.org
X-Gm-Message-State: AFuF++mjLr5W4VkdjrKvzB2gEHoqTNUpySMveWziu6I72y59HbKgX6ke
	39D4HiMpGPPlDcFDpsqZc5k38K+HWvq5tRPCd8ALvIjzHGcYtGvaXqaDAKbALnmHcy+pX9OBYaY
	YUsx0HA==
X-Received: from pgdf1.prod.google.com ([2002:a05:6a02:5141:b0:c9a:ffcc:19c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cc0e:b0:3cc:faf3:331a
 with SMTP id adf61e73a8af0-3d7ae5e7fbfmr18016806637.10.1788295270941; Tue, 01
 Sep 2026 13:41:10 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:41:10 -0700
In-Reply-To: <20260829000926.176E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828235840.63227-1-kylebot@openai.com> <20260829000926.176E51F000E9@smtp.kernel.org>
Message-ID: <apc4Zn1wZtqfwv0h@google.com>
Subject: Re: [PATCH v2] KVM: x86: Restrict saved GPA writes to hardware write faults
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Kyle Zeng <kylebot@openai.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 29, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 79468ddfe4736..aa5deb7c73aa2 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -5088,8 +5088,13 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
> >  	 * Note, this cannot be used on string operations since string
> >  	 * operation using rep will only have the initial GPA from the NPF
> >  	 * occurred.
> > +	 *
> > +	 * The guest may have changed the instruction since the fault.  Reuse
> > +	 * the GPA for writes only if hardware reported a write access;
> > +	 * otherwise, recheck permissions for the decoded access.

Eh, I would just omit this comment, because a RMW operation is far more likely
than the guest playing TLB games.

> >  	 */
> > -	if (ctxt->gpa_available && emulator_can_use_gpa(ctxt) &&
> > +	if ((ctxt->gpa_access & (write ? ACC_WRITE_MASK : ACC_READ_MASK)) &&
> > +	    emulator_can_use_gpa(ctxt) &&
> 
> [Severity: High]
> Will this break the write phase of read-modify-write (RMW) instructions for
> SEV guests?
> 
> If a SEV guest executes an RMW instruction (like OR [mem], reg) on an
> unmapped MMIO page, the hardware triggers a Nested Page Fault (NPF) on the
> initial read access. KVM will set gpa_access to ACC_READ_MASK.
> 
> When the emulator attempts the write phase, it appears this check will fail
> because ACC_WRITE_MASK is not set. This causes emulator_read_write_onepage()
> to fall back to vcpu_mmio_gva_to_gpa().
> 
> Does this fallback attempt a software page table walk that will fail on
> encrypted guest page tables, resulting in a spurious #PF and crashing the
> SEV guest?

Ugh, SEV.  Part of me wants to take an erratum for the whole mess, but that would
be quite gross since the behavior would be conditional for non-SEV guests.  And
it should be easy enough to make this work for just SEV guests.

> 
> >  	    (addr & ~PAGE_MASK) == (ctxt->gpa_val & ~PAGE_MASK)) {
> >  		gpa = ctxt->gpa_val;
> >  		ret = vcpu_is_mmio_gpa(vcpu, addr, gpa, write);
> 
> [ ... ]
> 
> > @@ -6454,7 +6459,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  
> >  		/* With shadow page tables, cr2 contains a GVA or nGPA. */
> >  		if (vcpu->arch.mmu->root_role.direct) {
> > -			ctxt->gpa_available = true;
> > +			/* A write fault can require a read for RMW emulation. */

Heh, my brain fart notwithstanding, just drop this comment.  Because while RMW
operations are why KVM needs to get this correct, it's doesn't explain why it's
correct to allow reads on write faults.  We could write a comment for that, but
I think anyone that cares enough will be able to quickly deduce that reads are
allowed because x86 paging doesn't support write-only mappings.

> > +			ctxt->gpa_access = ACC_READ_MASK;
> > +			if (emulation_type & EMULTYPE_PF_WRITE)
> > +				ctxt->gpa_access |= ACC_WRITE_MASK;
> 
> [Severity: High]
> Does this limit gpa_access too strictly for read faults on RMW instructions?
> 
> As mentioned above, if an instruction naturally faults on its first (read)
> access, it will only get ACC_READ_MASK here. This seems to be the root cause
> that later prevents the write phase from reusing the GPA during MMIO
> emulation.

For !SEV, that's fine.  In practice, I highly doubt RMW operations are used in
fast paths, e.g. Linux-as-a-guest straight up supports only MOV instructions.

For SEV, this as fixup?  And then if someone cares enough (I don't think I care?),
we could add an entry in Documentation/virt/kvm/x86/errata.rst for SEV.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3db88742ea9a..4f6659aa72ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6459,9 +6459,17 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 		/* With shadow page tables, cr2 contains a GVA or nGPA. */
 		if (vcpu->arch.mmu->root_role.direct) {
-			/* A write fault can require a read for RMW emulation. */
 			ctxt->gpa_access = ACC_READ_MASK;
-			if (emulation_type & EMULTYPE_PF_WRITE)
+			/*
+			 * Always allow writes for SEV guests, as the guest's
+			 * page tables are encrypted, i.e. KVM can't walk the
+			 * guest's page tables and so must always use the GPA
+			 * from the initial fault.  Restricting use of the GPA
+			 * to the access type that faulted would prevent KVM
+			 * from emulating RMW operations for SEV guests.
+			 */
+			if ((emulation_type & EMULTYPE_PF_WRITE) ||
+			    is_sev_guest(vcpu))
 				ctxt->gpa_access |= ACC_WRITE_MASK;
 			ctxt->gpa_val = cr2_or_gpa;
 		}
