Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F3330644
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796064; cv=none; b=Q1V0coVdEQyTp8ONwplnQHI5znG9FfQrxeDELQJ3bO4WPs9qjBnyxQnkjn01eMZDn6J2W191bOAwNd8UlNOqnknN3/+t5IywTR8NRd5bTbCq1pZhUIOERk4BR8C+4FjnTHepfdiB8wryJPdjvoK5p2cL8bnfiBnIHJcdIXX4Kxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796064; c=relaxed/simple;
	bh=4eqLe1Iwrf3fptDY/K6GGiGebId3UtaTTke4WiKK/aE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dRD/hKn5JNEFx7JPHTw3i5SKXNU87+l8thvrh8+oiWQ1jxffgX6ZDJSKesEtrrmr7OlH4LMAGQZW/MfvzKYqZGjIvNDe7vkLLfWwyAFqkr7CJKLeQmwF2A0RJuLETxN5Cp7u8YBY5K/stgGngAtS9XxeKXP3Y1QnReV2O7iiJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ER9ucCoJ; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ER9ucCoJ"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84865f326efso3655719b3a.0
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785796063; x=1786400863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FSEMelrQmRuUE28gHtJ+jjcyhZkULNzQArFyibXkDDg=;
        b=ER9ucCoJqKVU5ESWeKz/OEg7nsdpn9vdA/dWId30k3Wl2337lvV0kNL9FTqm2hdSZM
         c5EW9apOAkNTGw9kBcneEwC83rVTNOl8NlU+/V5ij6WVkL4dZbt8ePQ5tC0u8GmRi1SP
         wO7M+wmQTl86lm1ZI0Mk6dbWV9he5SoaIweXC7sF8/F1dAGnUViiYwStOTtt35mKzi3B
         lAYL4wkjU0K2XR0H0PWOIP1lKczYF+UMBY+CXaduZCMCG5woj/KqqWGLVNhB8gryaoGo
         aAdIXQclx3c9YMBXsRiTApZ1TVFa3HUftXefCIXuNesgJHHtiHD2UIcktCE9HyEMucty
         JwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796063; x=1786400863;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSEMelrQmRuUE28gHtJ+jjcyhZkULNzQArFyibXkDDg=;
        b=tYIg584YkGs+P88OVnjl4sLPSF12kwidLAr/f37b0FFTY3LLKi2DrCtJ2aZUk+rIdE
         +vs/sp4Nd75fpjw5sDXDLwUdtthQ/azcbf296EKHmKzWF8o2ruGIZDZp2jrLT00509jL
         pW0Nn9bhVu9nEvml7HAfp54L9rUK3VQ/d0FNGWNPBOVcLGCR2+tYKkYRFW97AOaaIEFp
         zEwLlvRP/0M6BsRWost1UERcNb3UxubK0N3iSn4x+rQFGfcye8JRjNk4YTklfFZZHnDu
         Arde+pxgpA2azneQCAUsNix3WfDqpBgSB8ikUQfRiE4SW5rd7rRfnDs11GakHQCei220
         lmUw==
X-Forwarded-Encrypted: i=1; AHgh+RqLtBbg21q98JtV7e9TNJhoSV9do/J45oGLRMzh9wXcnGGwgXKHkhbUKewfQoUEJEzcsq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlmE5esD72sOGULqGntnW231YZ530iMHkVIPxzj2shcpmwmEi
	AoMNWr+ILNe2YRTRhJiUV/+cBXWVzgkz58xQofjBZlOeNlKVbDuxeL9/SvJI5C44O7xJJJQPVZ2
	rQeNAXA==
X-Received: from pfks7.prod.google.com ([2002:a05:6a00:1947:b0:848:4f56:7671])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:464f:b0:845:f107:38c8
 with SMTP id d2e1a72fcca58-84ee493bdbcmr9842875b3a.47.1785796062551; Mon, 03
 Aug 2026 15:27:42 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:27:41 -0700
In-Reply-To: <CAO9r8zPq6j54qjSpx974+7LJ_behFs0R2Nk9yziVbcgbiro76Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-26-yosry@kernel.org>
 <CAO9r8zOKXjiaYer9d1bpDsGqgbRybR-kys7=VS5+bgamhH7LkQ@mail.gmail.com> <CAO9r8zPq6j54qjSpx974+7LJ_behFs0R2Nk9yziVbcgbiro76Q@mail.gmail.com>
Message-ID: <anEV3TCeMUO4TJtl@google.com>
Subject: Re: [PATCH v1 25/28] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026, Yosry Ahmed wrote:
> On Fri, Jul 31, 2026 at 11:41=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index e4bda43238654..d7b20941b1fee 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -2425,17 +2425,51 @@ static int clgi_interception(struct kvm_vcpu =
*vcpu)
> > >
> > >  static int invlpga_interception(struct kvm_vcpu *vcpu)
> > >  {
> > > +       struct vcpu_svm *svm =3D to_svm(vcpu);
> > >         /* FIXME: Handle an address size prefix. */
> > >         gva_t gva =3D kvm_rax_read(vcpu);
> > >         u32 asid =3D kvm_ecx_read(vcpu);
> > > +       int cpu;
> > >
> > >         if (nested_svm_check_permissions(vcpu))
> > >                 return 1;
> > >
> > >         trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
> > >
> > > -       /* Let's treat INVLPGA the same as INVLPG (can be optimized!)=
 */
> > > -       kvm_mmu_invlpg(vcpu, gva);
> > > +       /*
> > > +        * INVLPG on a non-canonical address is a NOP according to th=
e SDM,
> > > +        * assumethe same behavior from INVLPGA since the APM doesn't=
 specify.
> > > +        */
> > > +       if (is_noncanonical_invlpg_address(gva, vcpu))
> > > +               return kvm_skip_emulated_instruction(vcpu);
> >
> > From internal Sashiko:
> > ---
> > This is a pre-existing issue and was not introduced by the patch under =
review,
> > but if L1 is configured for 4-level paging and L2 is configured for 5-l=
evel
> > paging, could this drop valid INVLPGA TLB flushes for L2?
> >
> > Since vcpu represents L1, the check is_noncanonical_invlpg_address(gva,=
 vcpu)
> > uses L1's canonical boundaries. If L1 executes INVLPGA to flush a valid=
 57-bit
> > virtual address for the L2 guest, will KVM incorrectly deem the L2 addr=
ess as
> > non-canonical and silently skip emulation?
> >
> > Bypassing both the hardware TLB flush and shadow page table synchroniza=
tion
> > could allow L2 to continue accessing memory through old translations,
> > potentially leading to memory corruption or security boundary bypass
> > inside L2.
> > ---
> >
> > I need to take a closer look here, but if this is indeed an issue,
> > even if pre-existing, it would only matter with this series. Before
> > this series, even if INVLPGA is ignored we flush everything before
> > running L2 anyway.
>=20
> I don't think this is an issue. is_noncanonical_invlpg_address()
> doesn't use "L1's canonical boundaries". It calls
> is_noncanonical_address(.., X86EMUL_F_INVLPG), which calls
> __is_canonical_address(.., max_host_virt_addr_bits()). So the
> canonicality checks depend on the host support, not L1's CPUID or
> configuration.

Yep, this is a complete non-issue.

> The only potentially interesting case is if hardware
> only supports 48-bit addresses and L1 decides to emulate 57-bit
> addresses (e.g. emulate 5-level paging on HW with only 4-level paging
> support). In this case (if it all possible to begin with), I assume
> it's L1's responsibility to make sure this is emulated correctly (e.g.
> intercept L2's page faults with higher bits set).

Yep.
