Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB353F58E5
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410609; cv=none; b=MLnaDtlt0HBliORZulMu59kicW/u855+Z/Ddt94YDp9IE1194U7TyjbBKO3UnfM9G2FYlhbCW/BLW1OJuKAWx/z2xPCNZQsWWRNVinA58zyaD0SGIa0d5TNrQDx3zZkiU2AbttJ4UBJaeqILCtXV7U2Pxa3yCY6UxMigig7VG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410609; c=relaxed/simple;
	bh=gTl7Uz3DKjv7de/oqx1b0pi/1qYSSiJ39hvLSRk5YKM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TiXooKNX9HsfOHA8sJivAzeyaKg87Z4cx/vFxszCNMBb+lmaQcwELCTZouyVek6TZnoCL7KhvtGgCL9j6rm3EDBhmPcLME/zth1qVHuwacwu0VjV+6tpWfVv9F12JF6qQG2Ox5lVB4tiejnleHYuwcvhzGyC+k3GfnkXpiJ6lQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8C6mtfM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4NMLcVM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8C6mtfM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4NMLcVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFPDNotAm5fBJybBFxFK1UVydnWca4IYUl5KPrMJLsU=;
	b=f8C6mtfMbtGNiwo+MpYSsej8aI4GbJcdXtExjvK2SAF+9WrWaHfLuHju8bW3GSa3d3xwRg
	viOotO49yBNlVAKH45fUracOxarJURrImJbd0Ail7N2H6R33gPeoay73pXSS73tW90N8Pd
	UTgi1DhHnCzrNtlQIQ5gGm+2jXlPmQo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-rpjfwKDIPtK9upEAXan-jg-1; Tue, 02 Jun 2026 10:30:05 -0400
X-MC-Unique: rpjfwKDIPtK9upEAXan-jg-1
X-Mimecast-MFC-AGG-ID: rpjfwKDIPtK9upEAXan-jg_1780410605
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a236220so55585391cf.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410605; x=1781015405; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kFPDNotAm5fBJybBFxFK1UVydnWca4IYUl5KPrMJLsU=;
        b=B4NMLcVMHw2rT6m3Z7mPuBr927ulLJCQKdPXcvXToDEU8vRnz0mYfeUv4UVaTotckp
         d3SUOIPrHEof2GV4mhazw2YZdHpK9NXKNh44u/We1zDgK+LPlqbcFUaUgtJ5Yjf2UAbU
         XiMUN4fJ5VQFifLC53XwwH9KQTFgwEKTki2SNdEUrDz1J7yL6coUUDH/q6mirh8ptQMn
         S2MjTsSa+klVZWM1AXYaBTnZ57O8ZR7ZjBgHOyvFQUdtpfjDWM5GuQZPgl0chs3Bl4Zs
         +x0x4akZT+diAvf6nD48bULbnDzxFpBLaR112l/jTr8bhVap0Yz8Eo4uQZnKy0d6uhPP
         OXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410605; x=1781015405;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFPDNotAm5fBJybBFxFK1UVydnWca4IYUl5KPrMJLsU=;
        b=rZ72bWvP7P3rpHKnbqgmB0SyLWuKr2F5qELp95VncErQMuWMt2nimPEtqVTkDAmbSd
         CN1C0jEih8TGeaKx7QVp8ImBGfv1fEm3GcoYrmSEo6Y+RUDOPBsNF0QIZg4ECaSvp1r1
         7xzZ6eu5O9ylAdHWqv7kTzZajWUiDT+momYpyL36f9FVHVvbriQioxwQLwcCu+vJHOUf
         aGceOSZ3UpiXjRaGTBBdroHBxSHOSrqZFyxlfsc4B5n6hL0dmLdw4FxGG9K04lj5b49X
         +0DDitu4fIwvFU8M41Qzm+YU7BeZKaUQWfceWE0JxOlY2MQ0usqCqRGnu8pm1qbhkTjk
         cCAg==
X-Forwarded-Encrypted: i=1; AFNElJ+x2m1YhZM0n4JXRVeEi8fs+Nf00HMIttRpYZjjin3mr/dD4fF8jN3JkoAGKV15LCYqS2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/hgpISt/clPVsWpsdKhji4cXaQu/l6F6e8nmNlYEQPxXjd5q
	2320zyorJQBjNickW/j2rEEoBrzYfdqv4flJdGXw0tiGnA62JmthchS3L5jSiv+eZslGfYP+blV
	SL9JVxidUJefycLkaE/jfCF724yX9/S5LhRFW86/vUDD88l5H0ZVpMQ==
X-Gm-Gg: Acq92OGeIrUK5k5ueckkOjP6iSq2gp+Qb+5bakNq/ixmEMWMExerGF1ek4dlYE2UFnq
	+BeiePlk/ZswlvHdZk5IEigf9Dx7W478n+ASghecZob0wRUztBtijN6CZg1S9iWJI2apoNSZiEk
	WhsF/6XNAtJUgTm5IpSlsBIrawCq9wr+6GnvTHJxSwUyr+zGQMoxUJS7fcsmc+q8etvaqjZfpPO
	5WjrhvQgzefDma1saNN4NVqPZmafaeCyjolpHYJvBQh6CC8i4oaG6h8fg6q7ry/neX8Tm5NiRAt
	bxTIRUFfKPfWkdMEgYuSJsjb/Il4SCwoO+BQjkB0MzR6w5YfV+qAmHFd/77xOt2ZD599pxMXJZk
	shZnjRMXs/UeVWwvLAO9ino2O3H6oBMnfjcUr7oU=
X-Received: by 2002:a05:622a:858a:b0:50d:a6e3:ae1 with SMTP id d75a77b69052e-5173a7055e3mr191731021cf.17.1780410604731;
        Tue, 02 Jun 2026 07:30:04 -0700 (PDT)
X-Received: by 2002:a05:622a:858a:b0:50d:a6e3:ae1 with SMTP id d75a77b69052e-5173a7055e3mr191730431cf.17.1780410604252;
        Tue, 02 Jun 2026 07:30:04 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c4648asm109121cf.10.2026.06.02.07.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:30:03 -0700 (PDT)
Message-ID: <d1f79ab5403e077bd81fb027ad15b6c035c65621.camel@redhat.com>
Subject: Re: [PATCH 23/28] KVM: SVM: add GMET bit definitions
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com, "Borislav Petkov (AMD)"
 <bp@alien8.de>
Date: Tue, 02 Jun 2026 10:30:02 -0400
In-Reply-To: <20260505195226.563317-24-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-24-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-05 at 21:52 +0200, Paolo Bonzini wrote:
> GMET (Guest Mode Execute Trap) is an AMD virtualization feature,
> essentially the nested paging version of SMEP.=C2=A0 Hyper-V uses it;
> add it in preparation for making it available to hypervisors
> running under KVM.
>=20
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/include/asm/cpufeatures.h | 1 +
> =C2=A0arch/x86/include/asm/svm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 1 +
> =C2=A02 files changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index de7bd88e539d..d58dbce83f45 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -379,6 +379,7 @@
> =C2=A0#define X86_FEATURE_AVIC (15*32+13) /* "avic" Virtual Interrupt Con=
troller */
> =C2=A0#define X86_FEATURE_V_VMSAVE_VMLOAD (15*32+15) /* "v_vmsave_vmload"=
 Virtual VMSAVE VMLOAD */
> =C2=A0#define X86_FEATURE_VGIF (15*32+16) /* "vgif" Virtual GIF */
> +#define X86_FEATURE_GMET (15*32+17) /* Guest Mode Execution Trap */
Hi!

Looks OK: APM states 'CPUID Fn8000_000A EDX[17]=3D1'

> =C2=A0#define X86_FEATURE_X2AVIC (15*32+18) /* "x2avic" Virtual x2apic */
> =C2=A0#define X86_FEATURE_V_SPEC_CTRL (15*32+20) /* "v_spec_ctrl" Virtual=
 SPEC_CTRL */
> =C2=A0#define X86_FEATURE_VNMI (15*32+25) /* "vnmi" Virtual NMI */
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index bcfeb5e7c0ed..aa63431ba92c 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -243,6 +243,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area=
 {
> =C2=A0#define SVM_MISC_ENABLE_NP BIT(0)
> =C2=A0#define SVM_MISC_ENABLE_SEV BIT(1)
> =C2=A0#define SVM_MISC_ENABLE_SEV_ES BIT(2)
> +#define SVM_MISC_ENABLE_GMET BIT(3)

Looks OK: "The GMET mode is selected for a targeted guest by setting bit 3 =
of VMCB offset 090h to 1
> =C2=A0
> =C2=A0#define SVM_MISC2_ENABLE_V_LBR BIT_ULL(0)
> =C2=A0#define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE BIT_ULL(1)

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

