Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8FD47DD6F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582430; cv=pass; b=mAG7A+I3DJ543mX3l1bJhhJoC6q9qHOHM1y4O4EBBjn8VhNUK0Izp7xxvpxuiVNq+mstDTnYS/AihegAfAXty6l7GR3+WPQFu5LL6pRKMuT3SauCzPGfoqsSONOV0uweAMVoaQVHNnvFPixjrgkG3+nEf6ABPttvdVCYuNXCajU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582430; c=relaxed/simple;
	bh=OaiUGVXIaoK58g4KUcH0QwFN2tyWJZUlc1JvNyAly3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC9PAddpbmcB4TMJql3JpPa2vEyNVqPOBr9WrIKQ5Miew+F78jQi2qaicoL583GVvrM93Ic4vj54pFlwLyHhPJ0kUGmEdIY7uaFTRbA8J87tTyIvfwu3guN0t5vmp97f2kV6CiVZHoICTZxd8isXFRvVuCNloMVyyjvb21X3iIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icNfnbPr; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icNfnbPr"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68cb445dd5cso9263a12.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 07:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780582427; cv=none;
        d=google.com; s=arc-20240605;
        b=j6zNysOFhLjL8OQ7cJKMZKFifWGGkUSyjimW3z6V3aoCKjuuySw1tGEa71VqNVxZsq
         /G6voBng0TpH9+jg4eaNuAVydK/Q5/CQwyQaBbCuVaaHIbzaOhQ5ulkBXvOpRZ3sBa+z
         ukohzjlMl+L/22KA8PdSZa12q4j14/klYXJCMEq4G1JAHZ6L5UUbVAZ2zgTz32UNJ0Vv
         LCVdgIcTxNn4QiaZhFdQdMSUbDtBkl+CMwheKk+5slAzQrW31wYYb4opFCwx8+/rn+0D
         HjyUd0tK+pAXEjS3EAiPnO4fdfw49XTd3BYBKr91tp0gBJVaURMCVmQJPVtBhPJYHxR5
         OliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9O0Q3WeGriwMoc2YI/vhq5MLo+cTt56z0DuYwFzn6as=;
        fh=rbRsiyZ+8PqOjxrgZQdB64ENBXlgTML+TsZf140LS3E=;
        b=NPSx/ICu+vUZllWBW0fX0rJZGV870pHRX1WgYHEyrB3Tt5Dj9FcFQV0J4KwpR7rw5h
         fR9EzC2ZVjAmXg+FoznJV0bYuYNlyaO09SOX+x2Cg53jYsYn1kcnNZRKTzOVF9uKYNAr
         9mDhD1P7dUEel80W1pDyEbhOUCLpn0weqKOCVUajFVEQvXfXNYsMsrfb6K/Ml6m/0hVn
         xEYbfsWYvxpwn/4Oo8S3PGt3FWPc0qbfN+YTIJ5C6Lymbh1t2/KyScicGa7FharWN6PS
         fkp0s9+WBJu7eWsUa8z64eUdra5gE31Ydnp2Rn4t5axmZcu4XXQnYked58GLIFCzKgF9
         U9nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582427; x=1781187227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O0Q3WeGriwMoc2YI/vhq5MLo+cTt56z0DuYwFzn6as=;
        b=icNfnbPrvp/2jPejs9zC3Nzi5LOcAzd/IZsZ6k9O5gNjE+QfJAcz4CP0qk0i5pZt+o
         RDLW57KbjbE1zfD/cYx8Co+VCTYzp6MiSi5OayZHgyOs/9akei1SuWQApUXLv296HQl2
         TTDrVszZhQLupSRA/ye+tc4puNK/7oXj6lUi+SeGALay5aLl4IN7+mh3iiO31ihh0Vk8
         Z3ZJtCh+pbX/Y8l/irT/wHkVmAPHaqRJngdSXtCZs7xki/HMEBtTFBp6N0o8wFFdxBl6
         Gl16/ASE0VMA/1Zfc2j9pgEPd/73iR9+qzV5RS610BYAgh2GFuomSe1L4YiprfNP6OnD
         fKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582427; x=1781187227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9O0Q3WeGriwMoc2YI/vhq5MLo+cTt56z0DuYwFzn6as=;
        b=QzeOvxglBrA3X58uwV1LJqO7KXOV7Ymj6VQE18zV2XkpnNaOsl3s0GpSOVdiVG0yoI
         7i4ptbDbk+RvxdOirX4DRYkp1cemoEgzMPRBfnXwL/3wiWUr7rZiA1tLNm9K8bRvJ61H
         XJHaH8kHQcGcbgTiZdayTyI+hg/1ZoVTOnXcY5WINTaV5/dpaxqAMe4qImpcMQb1g4WH
         PS67iv0VfK2blRNZkrgCRiyXiIUD4Pja6qGg8YDh1KbUZpr4SEBb4/xdMTFTh9nb+GfC
         lcYSlBHL136qZs4Mp0TRmuYGtYQ6rDnDsJ7ci9VOe72K93rwSJzLWYYXcANrixzzcvor
         ciVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pB9xtIOmU+OqUx5t53In2wab+k6pCf71DfPQ6Dil9Gygv6zZqqt/03wNk/whR9+1Np6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4NaUhzL4wWcqccCv+utM9AEE2K97KnIFiJCLOpCzkZ13yWK7u
	MNfzFzZvBrCfYFaNcEbJKq+82MEdXD2HyEN0enUBKfDA6pIUC/9AA315fTtvBG/6vcudHucKeEG
	uPDhPXD+PpzvW4fgyW88TkCMcCUUbMkjHkAMjAA1l
X-Gm-Gg: Acq92OFtfS1dTFt3PRGSVS19Vvji+aZ3t/M3dP8i3F4x3r1SgPdSFHjK3dvVmYomudE
	QRGi3QSJSRyuIml2cxEwMlRuPCXtlen5HvJN4vmjb7AkDIGzfS1FQL1wNDts4HzD7IGVhTjpeDN
	mkvJuvAmoBcMJ4o3E96ZMaIDOb3QnbqTeeWHKorh4vsM1mKl9cEQuQabxfvcIbWWuaj8VuTb1Tv
	qR7/RTejf+n0/MU8AENFUi1uiP4I6an1gMmgoBDAOzZic0Fg99zwMddM+XCelZTyD5jzyVZgl3f
	p6eyuVWNtMrFtkQZug==
X-Received: by 2002:a05:6402:4502:b0:66e:e3f9:ebb6 with SMTP id
 4fb4d7f45d1cf-68f1208d3bfmr124656a12.4.1780582426733; Thu, 04 Jun 2026
 07:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603223418.1720035-1-seanjc@google.com> <CALMp9eT2mBWgX9VntLJcRYDCeMdLzZwzmPbHrbcM6CRL2tYT0g@mail.gmail.com>
 <aiF6dg4_9mA-ID-5@google.com>
In-Reply-To: <aiF6dg4_9mA-ID-5@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 4 Jun 2026 07:13:34 -0700
X-Gm-Features: AVHnY4IQ33K-_t_o0K6DXcX4QZjibahd4Yk0IWq-AgxplGpwY-7k-x989JNEVtQ
Message-ID: <CALMp9eRHaAVvAHKjpa82Be_5sk7YC5P37h5duYp+HiGAsjkdEw@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nVMX: Fix ept=n bugs where KVM runs L2 with
 guest CR3
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 6:15=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Jun 03, 2026, Jim Mattson wrote:
> > ...
> > IIRC, the tests in question are confirming PCI bus error semantics.
> > Why would the VMLAUNCH not succeed on bare metal?
>
> Well, I was assuming it would fail because it couldn't actually guarantee=
 PCI Bus
> Errors, as it could very well stumble into actual device memory.  But the=
 test
> leaves TPR_THRESHOLD as '0', and so regardless of what value the CPU gets=
 back,
> consistency check will still pass.
>
> But!  I'm pretty sure the test would generate #MCs, not PCI bus errors.  =
The
> SDM very, very strongly implies that the reads will use WB:
>
>   Bits 53:50 report the memory type that should be used for the VMCS, for
>   data structures referenced by pointers in the VMCS (I/O bitmaps,
>   virtual-APIC page, MSR areas for VMX transitions), and for the MSEG hea=
der.
>   ^^^^^^^^^^^^^^^^^
>
>   If software needs to access these data structures (e.g., to modify the
>   contents of the MSR bitmaps), it can configure the paging structures to=
 map
>   them into the linear-address space. If it does so, it should establish
>   mappings that use the memory type reported bits 53:50 in this MSR.
>
>   As of this writing, all processors that support VMX operation indicate =
the
>   write-back type. The values used are given in Table A-1.
>
> And _that_ will definitely cause problems, especially if the read hits de=
vice
> memory.

Good point. However, "problems" here are machine checks, right? Not VM
entry with invalid control field(s).

> That said, KVM's de facto ABI is that VMX instructions get PCI Bus Error =
semantics
> on accesses KVM can't handle, and it's just as easy to skip the consisten=
cy check.
> Since a read of 0xff guarantees the vTPR >=3D TPR_THRESHOLD, the check wi=
ll pass
> regardless of TPR_THRESHOLD.

Hmmm...Is that an erratum? :)

> So, other than my stubbornness :-D, there's no reason to deliberately fai=
l the
> check if KVM can't read memory.  I'll go with this for v2:
>
>         gpa_t vtpr_gpa =3D vmcs12->virtual_apic_page_addr + APIC_TASKPRI;
>         u32 vtpr;
>
>         if (!nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
>                 return 0;
>
>         if (CC(!page_address_valid(vcpu, vmcs12->virtual_apic_page_addr))=
)
>                 return -EINVAL;
>
>         if (CC(!nested_cpu_has_vid(vmcs12) && vmcs12->tpr_threshold >> 4)=
)
>                 return -EINVAL;
>
>         /*
>          * Do the illegal vTPR vs. TPR Threshold consistency check if and=
 only
>          * if KVM is configured to WARN on missed consistency checks, oth=
erwise
>          * it's a waste of time.  KVM needs to rely on hardware to fully =
detect
>          * an illegal combination due to the vTPR being writable by L1 at=
 all
>          * times (it's an in-memory value, not a VMCS field).  I.e. even =
if the
>          * check passes now, it might fail at the actual VM-Enter.
>          *
>          * If reading guest memory fails, skip the check as KVM's de fact=
o ABI
>          * for VMX instruction accesses to non-existent memory is to prov=
ide
>          * PCI Bus Error semantics (reads return 0xFFs), in which case th=
e vTPR
>          * is guaranteed to greater than or equal to the threshold.
>          *
>          * Note!  Deliberately use the VM-scoped API when reading guest m=
emory,
>          * to ensure the read doesn't hit SMRAM when restoring L2 state o=
n RSM,
>          * and only perform the check when in KVM_RUN, to avoid a false f=
ailure
>          * if userspace hasn't yet configured memslots during state resto=
re.
>          */

I really wish that KVM dictated the save and restore sequences. :/

>         if (warn_on_missed_cc && vcpu->wants_to_run &&
>             nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW) &&
>             !nested_cpu_has_vid(vmcs12) &&
>             !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCES=
SES) &&
>             !kvm_read_guest(vcpu->kvm, vtpr_gpa, &vtpr, sizeof(vtpr)) &&
>             CC((vmcs12->tpr_threshold & GENMASK(3, 0)) > ((vtpr >> 4) & G=
ENMASK(3, 0))))
>                 return -EINVAL;
>
>         return 0;
